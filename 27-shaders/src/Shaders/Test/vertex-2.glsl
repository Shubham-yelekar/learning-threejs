varying vec2 vUv;
uniform float utime;
void main() {
    vec4 modelPosition = modelMatrix * vec4(position, 1.0);
modelPosition.z+= 0.01* sin(modelPosition.x * 4.8 + modelPosition.y *3.4 + utime);
vec4 viewPosition = viewMatrix * modelPosition;
vec4 projectedPosition = projectionMatrix * viewPosition;

    vUv = uv;
gl_Position = projectedPosition;
    // gl_Position = projectionMatrix * viewMatrix * modelMatrix * vec4(position, 1.0);
}