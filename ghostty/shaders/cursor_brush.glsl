// Sumi-e ink spots — a wet brush carried across the page.
// No stroke is drawn; instead, a visible brush tip travels from the old
// cursor position to the new one, shedding drops of ink along the way.
// Each spot lands slightly off the line, blooms into the paper, and
// dries. GLSL keeps no state between frames, so everything is a pure
// function of (iTime - iTimeCursorChange).

// --- knobs ---
#define FADE_RATE    0.9   // ink drying speed (1/s); lower = lingers longer
#define SPOT_MIN     8.0   // fewest drops a move can shed
#define SPOT_MAX     24    // most drops a move can shed (also loop bound)
#define SPOT_BLOOM   0.5   // how much each spot swells as it soaks in
#define TRAVEL_TIME  0.35  // seconds the brush takes to cross the gap
#define DROP_DELAY   0.05  // pause between brush passing and drop landing

float hash11(float n) {
    return fract(sin(n * 43758.5453123) * 12345.6789);
}

float noise1(float x) {
    float i = floor(x);
    float f = fract(x);
    float u = f * f * (3.0 - 2.0 * f);
    return mix(hash11(i), hash11(i + 1.0), u);
}

vec2 cursorCenter(vec4 cursor) {
    // cursor.xy is the -X,+Y corner; cursor.zw is width/height.
    return cursor.xy + cursor.zw * vec2(0.5, -0.5);
}

void mainImage(out vec4 fragColor, in vec2 fragCoord)
{
    vec3 base = texture(iChannel0, fragCoord / iResolution.xy).rgb;
    fragColor = vec4(base, 1.0);

    float elapsed = iTime - iTimeCursorChange;
    float fade = exp(-elapsed * FADE_RATE);
    if (fade < 0.01) return;

    vec2 p0 = cursorCenter(iPreviousCursor);
    vec2 p1 = cursorCenter(iCurrentCursor);
    vec2 seg = p1 - p0;
    float segLen = length(seg);

    // A single typed character moves the cursor by exactly one cell
    // width. Skip those so normal typing doesn't flicker; only bigger
    // jumps (word motions, line changes, pane switches) shed drops.
    float minTravel = iCurrentCursor.z * 1.2;
    if (segLen < minTravel) return;

    vec2 dir = seg / segLen;
    vec2 nrm = vec2(-dir.y, dir.x);

    float baseRadius = min(iCurrentCursor.z, iCurrentCursor.w) * 0.5;
    float seed = hash11(floor(iTimeCursorChange * 1000.0));

    // --- the brush tip travelling across the gap ---
    // Decelerating, like a hand arriving at its target.
    float progress = clamp(elapsed / TRAVEL_TIME, 0.0, 1.0);
    float eased = 1.0 - (1.0 - progress) * (1.0 - progress);
    vec2 tip = mix(p0, p1, eased);

    // Elongated along the motion, drying (shrinking) as it travels,
    // and vanishing quickly once it arrives.
    vec2 d = fragCoord - tip;
    vec2 dLocal = vec2(dot(d, dir) * 0.6, dot(d, nrm));
    float tipWobble = 1.0 + 0.25 * (noise1(atan(dLocal.y, dLocal.x) * 2.5
                                           + seed * 71.0) - 0.5);
    float tipR = baseRadius * (3.75 - 1.05 * eased) * tipWobble;
    float headAlpha = exp(-max(elapsed - TRAVEL_TIME, 0.0) * 8.0);
    float pigment = (1.0 - smoothstep(-1.5, 2.5, length(dLocal) - tipR))
                  * headAlpha;

    // --- drops shed behind the brush ---
    // Each move sheds a different number of drops.
    float count = floor(mix(SPOT_MIN, float(SPOT_MAX) + 1.0,
                            hash11(seed * 311.0)));
    for (int i = 0; i < SPOT_MAX; i++) {
        float fi = float(i);
        if (fi >= count) break;
        float h1 = hash11(seed * 131.0 + fi * 7.31);
        float h2 = hash11(seed * 173.0 + fi * 3.77);
        float h3 = hash11(seed * 219.0 + fi * 9.13);

        // Spread the drops along the path, jittered so they don't read
        // as an evenly spaced dotted line, and nudged off-axis.
        float ti = clamp((fi + 0.5) / count + (h1 - 0.5) * 0.6 / count,
                         0.0, 1.0);
        vec2 pos = p0 + dir * (ti * segLen)
                 + nrm * (h2 - 0.5) * baseRadius * 1.6;

        // The brush passes over the spot, then the drop lands one
        // beat later. Spots still stagger since the pass time differs.
        float tSpot = elapsed - ti * TRAVEL_TIME - DROP_DELAY;
        if (tSpot <= 0.0) continue;
        float bloom = 1.0 - exp(-tSpot * 3.0);
        // Landing: swell up from nothing instead of popping in.
        float landing = smoothstep(0.0, 0.25, tSpot);

        // The brush dries as it travels: later drops fall smaller.
        // Cubed so most drops stay small and the giant splat is rare.
        float size = baseRadius * (0.35 + 19.65 * pow(h3, 3.0))
                   * (1.0 - 0.4 * ti);
        float radius = size * (1.0 + SPOT_BLOOM * bloom) * landing;

        // Irregular blot outline instead of a perfect circle.
        vec2 sd = fragCoord - pos;
        float wobble = 1.0 + 0.3 * (noise1(atan(sd.y, sd.x) * 2.5
                                           + seed * 53.0 + fi * 17.0) - 0.5);
        float spot = 1.0 - smoothstep(-1.5, 2.5, length(sd) - radius * wobble);
        pigment = max(pigment, spot);
    }

    if (pigment <= 0.0) return;

    // Wet ink sits darker than the dried cursor color.
    vec3 ink = mix(iCurrentCursorColor.rgb, vec3(0.05, 0.05, 0.08), 0.65);
    vec3 result = mix(base, ink, pigment * fade * iCurrentCursorColor.a);
    fragColor = vec4(result, 1.0);
}
