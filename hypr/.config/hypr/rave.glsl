#version 300 es
precision highp float;

in vec2 v_texcoord;

uniform sampler2D tex;

out vec4 fragColor;

// A utility function to convert Hue, Saturation, Value (HSV) to RGB.
// This is a common and efficient way to create smooth color gradients.
vec3 hsvToRgb(vec3 c) {
    vec4 K = vec4(1.0, 2.0 / 3.0, 1.0 / 3.0, 3.0);
    vec3 p = abs(fract(c.xxx + K.xyz) * 6.0 - K.www);
    return c.z * mix(K.xxx, clamp(p - K.xxx, 0.0, 1.0), c.y);
}

void main() {
    // Get the color of the current pixel from the texture.
    vec4 pixColor = texture(tex, v_texcoord);
    
    // `gl_FragCoord` gives us the absolute pixel coordinates of the current fragment.
    // We normalize this by the screen resolution to get a value from 0.0 to 1.0.
    // Note: The resolution must be provided as a uniform from the application,
    // though for simple cases `gl_FragCoord` can be used directly for a gradient.
    vec2 normalizedCoords = v_texcoord;

    // Use the normalized coordinates to calculate a hue value.
    // Combining the x and y coordinates creates a diagonal gradient.
    float hue = mod(normalizedCoords.x + normalizedCoords.y, 1.0);

    // Convert the calculated hue to an RGB color. The saturation and value
    // are set to 1.0 for a vibrant color.
    vec3 tintColor = hsvToRgb(vec3(hue, 1.0, 1.0));

    // Combine the original pixel color with the new tint color.
    // The `mix()` function blends the two colors, with the third argument
    // controlling the intensity of the tint (0.5 means a 50/50 blend).
    vec3 finalColor = mix(pixColor.rgb, tintColor, 0.5);

    // Output the final, tinted color, preserving the original alpha.
    fragColor = vec4(finalColor, pixColor.a);
}

