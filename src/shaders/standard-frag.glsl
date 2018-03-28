#version 300 es
precision highp float;

in vec4 fs_Pos;
in vec4 fs_Nor;
in vec4 fs_Col;
in vec2 fs_UV;

out vec4 fragColor[3]; // The data in the ith index of this array of outputs
                       // is passed to the ith index of OpenGLRenderer's
                       // gbTargets array, which is an array of textures.
                       // This lets us output different types of data,
                       // such as albedo, normal, and position, as
                       // separate images from a single render pass.

uniform sampler2D tex_Color;


void main() {
    vec3 col = texture(tex_Color, fs_UV).rgb;

    // if using textures, inverse gamma correct
    col = pow(col, vec3(2.2));

    // only fragColor[0] is 32 bit
    // want normal in worldspace, depth in camera space
    // fs_Pos is already in camera space from standard-vert
    fragColor[0] = vec4(fs_Nor.xyz, abs(fs_Pos.z));
    fragColor[1] = vec4(1.0, 0.0, 0.0, 0.0); // stores if pixel overlaps mesh in x
    fragColor[2] = vec4(col, 1.0);
}
