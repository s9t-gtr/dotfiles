# /// script
# dependencies = ["pillow"]
# ///
# Remaps background images so their background color lands exactly on
# the Flexoki Light paper color (fffcf0) instead of standing out
# against the terminal background.
#
# Most images' "white" is not pure 255 white, so a plain multiply
# leaves a visible seam. Instead, the dominant (background) color of
# each image is detected, and each channel is rescaled so that color
# maps exactly to the paper color. Images without a bright background
# fall back to a plain multiply. Embedded ICC profiles are converted
# to sRGB first, and output is always PNG so no recompression can
# shift the flat background afterwards.
#
# Usage: uv run ghostty/tint-bg-images.py [SRC_DIR] [DST_DIR]
#   SRC_DIR defaults to ~/dotfiles/ghostty/images/ink_painting
#   DST_DIR defaults to <SRC_DIR>-tinted
# Already-tinted files are skipped unless the source is newer, so
# re-running after adding new images only converts the additions.

import io
import sys
from collections import Counter
from pathlib import Path

from PIL import Image, ImageChops, ImageCms

PAPER = (0xFF, 0xFC, 0xF0)
EXTENSIONS = {".jpg", ".jpeg", ".png", ".webp"}


def to_srgb(img: Image.Image) -> Image.Image:
    icc = img.info.get("icc_profile")
    if not icc:
        return img
    src_profile = ImageCms.ImageCmsProfile(io.BytesIO(icc))
    dst_profile = ImageCms.createProfile("sRGB")
    mode = "RGBA" if img.mode in ("RGBA", "LA", "PA") else "RGB"
    return ImageCms.profileToProfile(img, src_profile, dst_profile,
                                     outputMode=mode)


def detect_background(rgb: Image.Image) -> tuple[int, int, int]:
    small = rgb.resize((64, 64))
    return max(small.getcolors(64 * 64))[1]


def tint(src: Path, dst: Path) -> None:
    img = to_srgb(Image.open(src))
    alpha = img.getchannel("A") if img.mode in ("RGBA", "LA", "PA") else None
    rgb = img.convert("RGB")

    bg = detect_background(rgb)
    if min(bg) >= 180:
        # Bright background: rescale each channel so bg -> PAPER exactly.
        luts = []
        for bg_c, paper_c in zip(bg, PAPER):
            scale = paper_c / max(bg_c, 1)
            luts.append([min(255, round(i * scale)) for i in range(256)])
        out = Image.merge("RGB", [
            ch.point(lut) for ch, lut in zip(rgb.split(), luts)
        ])
    else:
        # No white-ish background to pin down; a multiply is enough.
        out = ImageChops.multiply(rgb, Image.new("RGB", rgb.size, PAPER))

    if alpha is not None:
        out = out.convert("RGBA")
        out.putalpha(alpha)
    out.save(dst)


def main() -> None:
    src_dir = Path(sys.argv[1]) if len(sys.argv) > 1 else (
        Path.home() / "dotfiles/ghostty/images/ink_painting"
    )
    dst_dir = Path(sys.argv[2]) if len(sys.argv) > 2 else (
        src_dir.parent / f"{src_dir.name}-tinted"
    )
    dst_dir.mkdir(parents=True, exist_ok=True)

    converted = skipped = 0
    for src in sorted(src_dir.iterdir()):
        if not src.is_file() or src.suffix.lower() not in EXTENSIONS:
            continue
        dst = dst_dir / f"{src.stem}.png"
        if dst.exists() and dst.stat().st_mtime >= src.stat().st_mtime:
            skipped += 1
            continue
        tint(src, dst)
        converted += 1
        print(f"tinted: {src.name} -> {dst.name}")

    print(f"{converted} converted, {skipped} up-to-date -> {dst_dir}")


if __name__ == "__main__":
    main()
