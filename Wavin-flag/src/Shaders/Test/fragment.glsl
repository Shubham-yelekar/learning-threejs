precision mediump float;
uniform vec3 uColor;
uniform sampler2D uTexture;

varying vec2 vUv;
varying float vElevation;

uniform vec3 uLightDirection;
varying vec3 vNormal;

void main() {
    vec4 textureColor = texture2D(uTexture, vUv);
    float diffuse = max(dot(normalize(vNormal), normalize(uLightDirection)), 0.2);
    textureColor.rgb *=  diffuse;
    gl_FragColor = textureColor;
}