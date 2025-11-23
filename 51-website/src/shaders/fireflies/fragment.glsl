uniform float uTime;
void main()
{
    float distanceToCenter = distance(gl_PointCoord, vec2(0.5));

    float glow = 0.05 / distanceToCenter;
    float blink = 0.5 + 0.2 * sin(uTime * 1.0);

    float strength = (0.05 / distanceToCenter - 0.1 * 2.0) * blink;

    gl_FragColor = vec4(1.0, 1.0, 1.0, strength);
}