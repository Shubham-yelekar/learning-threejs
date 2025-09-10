uniform vec2 uFrequency;
uniform float uTime;
uniform float uElevation;
varying vec2 vUv;
varying float vElevation;
varying vec3 vNormal;

void main() {
   
    vec4 modelPosition = modelMatrix * vec4(position, 1.0);

  float elevation = sin(modelPosition.x * uFrequency.x - uTime) * 0.08 * uElevation;
    elevation += sin(modelPosition.y * uFrequency.y - uTime * 0.5) * 0.05 * uElevation;
    elevation += cos(modelPosition.x * 2.0 + uTime * 0.5) * 0.03 * uElevation;
    elevation += sin(uTime * 2.0 + position.x * 5.0) * 0.02 * uElevation;

    modelPosition.z += elevation;

    float shift = 0.01;
    vec3 posA = position + vec3(shift, 0.0, 0.0);
    vec3 posB = position + vec3(0.0, shift, 0.0);

    float elevA = sin((modelMatrix * vec4(posA, 1.0)).x * uFrequency.x - uTime) * 0.08 * uElevation
                + sin((modelMatrix * vec4(posA, 1.0)).y * uFrequency.y - uTime * 0.5) * 0.05 * uElevation
                + cos((modelMatrix * vec4(posA, 1.0)).x * 2.0 + uTime * 0.5) * 0.03 * uElevation
                + sin(uTime * 2.0 + posA.x * 5.0) * 0.02 * uElevation;

    float elevB = sin((modelMatrix * vec4(posB, 1.0)).x * uFrequency.x - uTime) * 0.08 * uElevation
                + sin((modelMatrix * vec4(posB, 1.0)).y * uFrequency.y - uTime * 0.5) * 0.05 * uElevation
                + cos((modelMatrix * vec4(posB, 1.0)).x * 2.0 + uTime * 0.5) * 0.03 * uElevation
                + sin(uTime * 2.0 + posB.x * 5.0) * 0.02 * uElevation;


vec3 tangent = vec3(shift, 0.0, elevA - elevation);
    vec3 bitangent = vec3(0.0, shift, elevB - elevation);
    vNormal = normalize(cross(tangent, bitangent));

    vUv = uv;
    vElevation = elevation;

    // gl_Position = projectionPosition * viewMatrix * modelPosition;
    gl_Position = projectionMatrix * viewMatrix * modelPosition ;

}