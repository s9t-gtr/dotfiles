// Hotaru — fireflies over a night river.
// Two behaviours, both pure functions of (iTime, iTimeCursorChange)
// since GLSL keeps no state between frames:
//  * A cursor jump startles the swarm: sparks scatter off the travel
//    path, drift outward while slowing down, and burn out.
//  * When the hand rests, a few fireflies gather near the cursor and
//    blink with the slow rise-and-fade pulse of the real insect.
// Typing a single character moves the cursor one cell and triggers
// neither, so the swarm only appears in the pauses.

// --- knobs ---
#define GLOW_COLOR   vec3(0.678, 0.859, 0.404)  // #addb67: Night Owl yellow-green
#define SCATTER_MAX  14     // most sparks a jump can shed (also loop bound)
#define SCATTER_MIN  8.0    // fewest sparks
#define SCATTER_LIFE 1.8    // seconds a startled spark takes to burn out
#define AMBIENT_N    6      // fireflies that gather while resting
#define AMBIENT_IN   1.5    // idle seconds before they start to gather
#define PULSE_T      3.2    // base blink cycle (s); varied per firefly

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

// Soft glowing dot: hot core plus a wide faint halo.
float glowDot(vec2 d, float r) {
    float q = length(d);
    return exp(-q * q / (r * r)) + 0.30 * exp(-q / (r * 3.0));
}

// Firefly blink: quick rise, long fade, dark rest of the cycle.
float pulse(float t, float period, float phase) {
    float p = fract(t / period + phase);
    return smoothstep(0.0, 0.06, p) * exp(-(p - 0.06) * 5.0);
}

void mainImage(out vec4 fragColor, in vec2 fragCoord)
{
    vec3 base = texture(iChannel0, fragCoord / iResolution.xy).rgb;

    float elapsed = iTime - iTimeCursorChange;
    vec2 p0 = cursorCenter(iPreviousCursor);
    vec2 p1 = cursorCenter(iCurrentCursor);
    vec2 seg = p1 - p0;
    float segLen = length(seg);
    float cell = min(iCurrentCursor.z, iCurrentCursor.w) * 0.5;
    float seed = hash11(floor(iTimeCursorChange * 1000.0));

    float light = 0.0;

    // --- startled swarm scattering off a cursor jump ---
    // Single-character typing moves exactly one cell; only bigger jumps
    // (word motions, line changes, pane switches) disturb the fireflies.
    float minTravel = iCurrentCursor.z * 1.2;
    float scatterFade = 1.0 - smoothstep(SCATTER_LIFE * 0.6, SCATTER_LIFE, elapsed);
    if (segLen >= minTravel && scatterFade > 0.0) {
        vec2 dir = seg / segLen;
        vec2 nrm = vec2(-dir.y, dir.x);
        float count = floor(mix(SCATTER_MIN, float(SCATTER_MAX) + 1.0,
                                hash11(seed * 311.0)));
        for (int i = 0; i < SCATTER_MAX; i++) {
            float fi = float(i);
            if (fi >= count) break;
            float h1 = hash11(seed * 131.0 + fi * 7.31);
            float h2 = hash11(seed * 173.0 + fi * 3.77);
            float h3 = hash11(seed * 219.0 + fi * 9.13);
            float h4 = hash11(seed * 257.0 + fi * 5.53);

            // Spark rises from a jittered point along the path...
            float ti = clamp((fi + 0.5) / count + (h1 - 0.5) * 0.8 / count,
                             0.0, 1.0);
            vec2 spawn = p0 + dir * (ti * segLen)
                       + nrm * (h2 - 0.5) * cell * 2.0;

            // ...and darts outward, decelerating like a startled insect.
            vec2 away = normalize(nrm * (h2 - 0.5) * 2.0
                                  + dir * (h4 - 0.5) * 1.2 + vec2(1e-4));
            float reach = cell * (3.0 + 9.0 * h3);
            vec2 pos = spawn + away * reach * (1.0 - exp(-elapsed * 2.2));
            // A touch of upward drift; fireflies rise as they flee.
            pos.y -= cell * elapsed * (0.6 + 1.2 * h1);

            // Each spark flickers nervously while it burns out.
            float flicker = 0.55 + 0.45 * noise1(elapsed * (6.0 + 6.0 * h4)
                                                 + fi * 23.0);
            float r = cell * (0.22 + 0.16 * h3);
            light += glowDot(fragCoord - pos, r) * flicker * scatterFade;
        }
    }

    // --- resting fireflies gathering around the cursor ---
    float gather = smoothstep(AMBIENT_IN, AMBIENT_IN + 2.0, elapsed);
    if (gather > 0.0) {
        for (int i = 0; i < AMBIENT_N; i++) {
            float fi = float(i);
            float g1 = hash11(fi * 12.9898 + 4.1414);
            float g2 = hash11(fi * 78.233 + 2.7183);
            float g3 = hash11(fi * 39.425 + 1.6180);
            float g4 = hash11(fi * 91.7 + 0.5772);

            // Each firefly circles the cursor on its own orbit: half go
            // clockwise, half counter, each at its own pace and radius.
            float spin = (g4 < 0.5 ? -1.0 : 1.0) * (0.25 + 0.35 * g2);
            float ang = g1 * 6.2832 + iTime * spin;
            // The orbit breathes: radius swells and shrinks slowly so
            // the path never closes into a perfect circle.
            float rad = cell * (3.0 + 7.0 * g2)
                      * (0.8 + 0.4 * noise1(iTime * 0.2 + fi * 11.0));
            vec2 pos = p1 + vec2(cos(ang), sin(ang)) * rad
                     // A little jitter on top so the glide stays organic.
                     + vec2(noise1(iTime * 0.5 + fi * 17.0) - 0.5,
                            noise1(iTime * 0.5 + fi * 29.0 + 7.0) - 0.5)
                     * cell * 1.5;

            float b = pulse(iTime, PULSE_T * (0.75 + 0.5 * g3), g1);
            float r = cell * (0.20 + 0.14 * g2);
            light += glowDot(fragCoord - pos, r) * b * gather;
        }
    }

    if (light <= 0.001) {
        fragColor = vec4(base, 1.0);
        return;
    }

    // Additive glow: green-yellow body light whitening at the core.
    vec3 result = base + GLOW_COLOR * light + vec3(0.9, 1.0, 0.7) * light * light * 0.25;
    fragColor = vec4(clamp(result, 0.0, 1.0), 1.0);
}
