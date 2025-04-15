varying vec2 vUv;

void main() {

    //  Solid Color 
    //  gl_FragColor = vec4(0.5, 0.0, 1.0, 1.0);

    //  Gradient Color blue
    // gl_FragColor = vec4(vUv, 1.0, 1.0);

    //  Gradient Color green
    // gl_FragColor = vec4(vUv, 0.0, 1.0);

    //  Pattern 3 => Gradient Color black and white
    // gl_FragColor = vec4(vUv.x, vUv.x, vUv.x, 1.0);

    //  Pattern 4 =>  
    //  float strength = vUv.y;
    // gl_FragColor = vec4(strength, strength, strength, 1.0);

     //  Pattern 5 =>  
    // float strength = 1.0 - vUv.y;
    // gl_FragColor = vec4(strength, strength, strength, 1.0);

    //  Pattern 6 =>  
    // float strength = vUv.y * 10.0;
    // gl_FragColor = vec4(strength, strength, strength, 1.0);

    //  Pattern 7 =>  
    // float strength = mod(vUv.y * 10.0, 1.0);
    // gl_FragColor = vec4(strength, strength, strength, 1.0);

    //  Pattern 8 =>  
    // float strength = mod(vUv.y * 10.0, 1.0);
    // strength = step(0.5, strength);
    // gl_FragColor = vec4(strength, strength, strength, 1.0);

     //  Pattern 9 =>  
    // float strength = mod(vUv.y * 10.0, 1.0);
    // strength = step(0.8, strength);
    // gl_FragColor = vec4(strength, strength, strength, 1.0);

     //  Pattern 10 =>  
    // float strength = mod(vUv.x * 10.0, 1.0);
    // strength = step(0.8, strength);
    // gl_FragColor = vec4(strength, strength, strength, 1.0);

     //  Pattern 11 =>  
    // float strength = step(0.8, mod(vUv.x * 10.0, 1.0));
    // strength *= step(0.8, mod(vUv.y * 10.0, 1.0));
    // gl_FragColor = vec4(strength, strength, strength, 1.0);

     //  Pattern 13 =>  
    // float strength = step(0.2, mod(vUv.x * 10.0, 1.0));
    // strength *= step(0.5, mod(vUv.y * 10.0, 1.0));
    // gl_FragColor = vec4(strength, strength, strength, 1.0);

    //  Pattern 14 =>  
    // float barX = step(0.4, mod(vUv.x * 10.0, 1.0));
    // barX *= step(0.8, mod(vUv.y * 10.0, 1.0));

    // float barY = step(0.8, mod(vUv.x * 10.0, 1.0));
    // barY *= step(0.4, mod(vUv.y * 10.0, 1.0));

    // float strength = barY + barX;
    // gl_FragColor = vec4(strength, strength, strength, 1.0);

    //  Pattern 15 =>  

    float barX = step(0.4, mod(vUv.x * 10.0, 1.0));
    barX *= step(0.8, mod(vUv.y * 10.0 + 0.2, 1.0));

    float barY = step(0.8, mod(vUv.x * 10.0 + 0.2, 1.0));
    barY *= step(0.4, mod(vUv.y * 10.0, 1.0));

    float strength = barY + barX;
    gl_FragColor = vec4(strength, strength, strength, 1.0);
}