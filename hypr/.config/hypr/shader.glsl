// Hyprshade compatible CRT shader
#version 300 es
precision highp float;

uniform sampler2D s_texture;
in vec2 v_texcoord;
out vec4 v_color;

void main() {
    float warp = -2.0; // simulate curvature of CRT monitor
    float scan = 0.5; // simulate darkness between scanlines

    vec2 uv = v_texcoord;
    vec2 dc = abs(0.5 - uv);
    dc *= dc;
    
    // warp the fragment coordinates
    uv.x -= 0.5;
    uv.x *= 1.0 + (dc.y * (0.3 * warp));
    uv.x += 0.5;
    uv.y -= 0.5;
    uv.y *= 1.0 + (dc.x * (0.4 * warp));
    uv.y += 0.5;

    // sample inside boundaries, otherwise set to black
    if (uv.y > 1.0 || uv.x < 0.0 || uv.x > 1.0 || uv.y < 0.0) {
        v_color = vec4(0.0, 0.0, 0.0, 1.0);
    } else {
        // determine if we are drawing in a scanline
        float apply = abs(sin(gl_FragCoord.y) * 0.5 * scan);
        // sample the texture
        vec4 sampled_color = texture(s_texture, uv);
        v_color = vec4(mix(sampled_color.rgb, vec3(0.0), apply), 1.0);
    }
}
