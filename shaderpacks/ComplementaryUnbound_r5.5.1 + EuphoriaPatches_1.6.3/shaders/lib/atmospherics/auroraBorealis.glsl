#define AURORA_COLOR_PRESET 0 //[0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15] // 0 is manual and default, 1 is daily, 2 is monthly and 3 is one color preset same with all numbers after

#define AURORA_UP_R 112 //[0 4 8 12 16 20 24 28 32 36 40 44 48 52 56 60 64 68 72 76 80 84 88 92 96 100 104 108 112 116 120 124 128 132 136 140 144 148 152 156 160 164 168 172 176 180 184 188 192 196 200 204 208 212 216 220 224 228 232 236 240 244 248 252 255]
#define AURORA_UP_G 36 //[0 4 8 12 16 20 24 28 32 36 40 44 48 52 56 60 64 68 72 76 80 84 88 92 96 100 104 108 112 116 120 124 128 132 136 140 144 148 152 156 160 164 168 172 176 180 184 188 192 196 200 204 208 212 216 220 224 228 232 236 240 244 248 252 255]
#define AURORA_UP_B 192 //[0 4 8 12 16 20 24 28 32 36 40 44 48 52 56 60 64 68 72 76 80 84 88 92 96 100 104 108 112 116 120 124 128 132 136 140 144 148 152 156 160 164 168 172 176 180 184 188 192 196 200 204 208 212 216 220 224 228 232 236 240 244 248 252 255]
#define AURORA_UP_I 33 //[0 3 5 8 10 13 15 18 20 23 25 28 30 33 35 38 40 43 45 48 50 53 55 58 60 63 65 68 70 73 75 78 80 83 85 88 90 93 95 98 100]

#define AURORA_DOWN_R 96 //[0 4 8 12 16 20 24 28 32 36 40 44 48 52 56 60 64 68 72 76 80 84 88 92 96 100 104 108 112 116 120 124 128 132 136 140 144 148 152 156 160 164 168 172 176 180 184 188 192 196 200 204 208 212 216 220 224 228 232 236 240 244 248 252 255]
#define AURORA_DOWN_G 255 //[0 4 8 12 16 20 24 28 32 36 40 44 48 52 56 60 64 68 72 76 80 84 88 92 96 100 104 108 112 116 120 124 128 132 136 140 144 148 152 156 160 164 168 172 176 180 184 188 192 196 200 204 208 212 216 220 224 228 232 236 240 244 248 252 255]
#define AURORA_DOWN_B 192 //[0 4 8 12 16 20 24 28 32 36 40 44 48 52 56 60 64 68 72 76 80 84 88 92 96 100 104 108 112 116 120 124 128 132 136 140 144 148 152 156 160 164 168 172 176 180 184 188 192 196 200 204 208 212 216 220 224 228 232 236 240 244 248 252 255]
#define AURORA_DOWN_I 33 //[0 3 5 8 10 13 15 18 20 23 25 28 30 33 35 38 40 43 45 48 50 53 55 58 60 63 65 68 70 73 75 78 80 83 85 88 90 93 95 98 100]

#define AURORA_SIZE 0.65 //[0.00 0.05 0.10 0.15 0.20 0.25 0.30 0.35 0.40 0.45 0.50 0.55 0.60 0.65 0.70 0.75 0.80 0.85 0.90 0.95 1.00 1.05 1.10 1.15 1.20 1.25 1.30 1.35 1.40 1.45 1.50 1.55 1.60 1.65 1.70 1.75 1.80 1.85 1.90 1.95 2.00]
#define AURORA_DRAW_DISTANCE 0.65 //[0.00 0.05 0.10 0.15 0.20 0.25 0.30 0.35 0.40 0.45 0.50 0.55 0.60 0.65 0.70 0.75 0.80 0.85 0.90 0.95 1.00 1.05 1.10 1.15 1.20 1.25 1.30 1.35 1.40 1.45 1.50 1.55 1.60 1.65 1.70 1.75 1.80 1.85 1.90 1.95 2.00]

//#define RGB_AURORA

#define AURORA_CLOUD_INFLUENCE_INTENSITY 1.00 //[0.00 0.25 0.50 0.75 1.00 1.25 1.50 1.75 2.00 2.50 3.00]
#define AURORA_TERRAIN_INFLUENCE_INTENSITY 1.00 //[0.00 0.25 0.50 0.75 1.00 1.25 1.50]

float GetAuroraVisibility(in float VdotU) {
    float visibility = sqrt1(clamp01(VdotU * (AURORA_DRAW_DISTANCE * 1.125 + 0.75) - 0.225)) - sunVisibility - maxBlindnessDarkness;

    #ifdef CLEAR_SKY_WHEN_RAINING
        visibility -= mix(0.0, rainFactor * 0.8 + 0.2, heightRelativeToCloud);
    #elif defined NO_RAIN_ABOVE_CLOUDS
        visibility -= mix(0.0, rainFactor, heightRelativeToCloud);
    #else
        visibility -= rainFactor;
    #endif

    visibility *= 1.0 - VdotU * 0.9;

    #if AURORA_CONDITION == 1 || AURORA_CONDITION == 3
        visibility -= moonPhase;
    #endif
    #if AURORA_CONDITION == 2 || AURORA_CONDITION == 3
        visibility *= inSnowy;
    #endif
    #if AURORA_CONDITION == 4
        visibility = max(visibility * inSnowy, visibility - moonPhase);
    #endif

    return visibility;
}

vec3 auroraUpA[] = vec3[](
    vec3(112.0, 36.0, 192.0),
    vec3(255.0, 56.0, 64.0),
    vec3(255.0, 80.0, 112.0),
    vec3(72.0, 96.0, 192.0),
    vec3(112.0, 80.0, 255.0),
    vec3(232.0, 116.0, 232.0),
    vec3(212.0, 108.0, 216.0),
    vec3(120.0, 212.0, 56.0),
    vec3(64.0, 255.0, 255.0),
    vec3(168.0, 36.0, 88.0),
    vec3(255.0, 68.0, 124.0),
    vec3(216.0, 8.0, 255.0),
    vec3(0.0, 255.0, 255.0),
    vec3(0.0, 20.0, 60.0)
);
vec3 auroraDownA[] = vec3[](
    vec3(96.0, 255.0, 192.0),
    vec3(204.0, 172.0, 12.0),
    vec3(80.0, 255.0, 180.0),
    vec3(172.0, 44.0, 88.0),
    vec3(80.0, 255.0, 180.0),
    vec3(244.0, 188.0, 28.0),
    vec3(92.0, 188.0, 180.0),
    vec3(176.0, 88.0, 72.0),
    vec3(128.0, 64.0, 128.0),
    vec3(60.0, 184.0, 152.0),
    vec3(160.0, 96.0, 255.0),
    vec3(32.0, 176.0, 33.0),
    vec3(180.0, 0.0, 0.0),
    vec3(0.0, 24.0, 36.0)
);

void GetAuroraColor(in vec2 wpos, out vec3 auroraUp, out vec3 auroraDown) {
    #ifdef SPOOKY
        auroraUp = vec3(0.0, 255.0, 255.0);
        auroraDown = vec3(180.0, 0.0, 0.0);
    #else
        #ifdef RGB_AURORA
            auroraUp = getRainbowColor(wpos, 0.06);
            auroraDown = getRainbowColor(wpos, 0.05);
        #elif AURORA_COLOR_PRESET == 0
            auroraUp = vec3(AURORA_UP_R, AURORA_UP_G, AURORA_UP_B);
            auroraDown = vec3(AURORA_DOWN_R, AURORA_DOWN_G, AURORA_DOWN_B);
        #else
            #if AURORA_COLOR_PRESET == 1
                int p = worldDay % auroraUpA.length();
            #elif AURORA_COLOR_PRESET == 2
                int p = worldDay % (auroraUpA.length() * 8) / 8;
            #else
                const int p = AURORA_COLOR_PRESET - 2;
            #endif

            auroraUp = auroraUpA[p];
            auroraDown = auroraDownA[p];
        #endif
    #endif

    auroraUp *= (AURORA_UP_I * 0.093 + 3.1) / GetLuminance(auroraUp);
    auroraDown *= (AURORA_DOWN_I * 0.245 + 8.15) / GetLuminance(auroraDown);
}

vec3 AuroraAmbientColor(vec3 color, vec3 viewPos) {
    float visibility = GetAuroraVisibility(0.5);
    if (visibility > 0) {
        vec3 wpos = (gbufferModelViewInverse * vec4(viewPos, 1.0)).xyz;
        wpos.xz /= (abs(wpos.y) + length(wpos.xz));

        vec3 auroraUp, auroraDown;
        GetAuroraColor(wpos.xz, auroraUp, auroraDown);

        vec3 auroraColor = mix(auroraUp, auroraDown, 0.8);
        #ifdef DEFERRED1
            auroraColor *= 0.2;
            visibility *= AURORA_CLOUD_INFLUENCE_INTENSITY;
        #elif defined GBUFFERS_CLOUDS
            auroraColor *= 0.6;
            visibility *= AURORA_CLOUD_INFLUENCE_INTENSITY;
        #elif defined COMPOSITE
            visibility *= AURORA_CLOUD_INFLUENCE_INTENSITY;
            return mix(color, auroraColor, visibility);
        #else
            auroraColor *= 0.05;
            visibility *= AURORA_TERRAIN_INFLUENCE_INTENSITY;
        #endif
        float luminanceColor = GetLuminance(color);
        vec3 newColor = mix(color, mix(color, vec3(luminanceColor), 0.88), visibility);
        newColor *= mix(vec3(1.0), auroraColor * luminanceColor * 10.0, visibility);
        return clamp01(newColor);
        // return mix(color, color * auroraColor, visibility); // old, keep it for now
    }
    return color;
}

vec3 GetAuroraBorealis(vec3 viewPos, float VdotU, float dither) {
    float visibility = GetAuroraVisibility(VdotU);

    if (visibility > 0.0) {
        vec3 aurora = vec3(0.0);

        vec3 wpos = mat3(gbufferModelViewInverse) * viewPos;
             wpos.xz /= wpos.y;
        vec2 cameraPositionM = cameraPosition.xz * 0.0075;
             cameraPositionM.x += syncedTime * 0.04;

        #ifdef DEFERRED1
            int sampleCount = 25;
            int sampleCountP = sampleCount + 5;
        #else
            int sampleCount = 10;
            int sampleCountP = sampleCount + 10;
        #endif

        float ditherM = dither + 5.0;
        float auroraAnimate = frameTimeCounter * 0.001;

        vec3 auroraUp, auroraDown;
        GetAuroraColor(wpos.xz, auroraUp, auroraDown);

        for (int i = 0; i < sampleCount; i++) {
            float current = pow2((i + ditherM) / sampleCountP);

            vec2 planePos = wpos.xz * (AURORA_SIZE * 0.6 + 0.4 + current) * 11.0 + cameraPositionM;
            #if AURORA_STYLE == 1
                planePos = floor(planePos) * 0.0007;

                float noise = texture2D(noisetex, planePos).b;
                noise = pow2(pow2(pow2(pow2(1.0 - 2.0 * abs(noise - 0.5)))));

                noise *= pow1_5(texture2D(noisetex, planePos * 100.0 + auroraAnimate).b);
            #else
                planePos *= 0.0007;

                float noise = texture2D(noisetex, planePos).r;
                noise = pow2(pow2(pow2(pow2(1.0 - 2.0 * abs(noise - 0.5)))));

                noise *= texture2D(noisetex, planePos * 3.0 + auroraAnimate).b;
                noise *= texture2D(noisetex, planePos * 5.0 - auroraAnimate).b;
            #endif

            float currentM = 1.0 - current;

            aurora += noise * currentM * mix(auroraUp, auroraDown, pow2(pow2(currentM)));
        }

        #if AURORA_STYLE == 1
            aurora *= 1.3;
        #else
            aurora *= 1.8;
        #endif

        #if defined ATM_COLOR_MULTS || defined SPOOKY
            aurora *= sqrtAtmColorMult; // C72380KD - Reduced atmColorMult impact on some things
        #endif

        return aurora * visibility / sampleCount;
    }

    return vec3(0.0);
}
