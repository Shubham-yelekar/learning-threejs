
varying vec2 vUv;

float random(vec2 st){
  return fract(sin(dot(st.xy, vec2(12.9898,78.233))) * 43758.54534123 );
}

void main() {
    
    // gl_FragColor = vec4(0.0,1.0,0.0, 1.0); // color green

 // use of UV of the plane
// - Start at left bottom (0.0,0.0) -> top right (1.0,1.0)

// // Pattern 1 - Gradiant from bottom of y and left for x
//             vec4( R   , G   , B   , A)
// gl_FragColor = vec4(vUv, 1.0, 1.0);

// // Pattern 2 - Gradient between two color , creates interpolation
// gl_FragColor = vec4(vUv.x,vUv.y, .0, 1.0);

// // Pattern 3 - x axis gradient
  // float strength = vUv.x;
//  gl_FragColor = vec4(strength, strength, strength, 1.0);

// // Pattern 4 - y axis gradient
// float strength = vUv.y;
//  gl_FragColor = vec4(strength, strength, strength, 1.0);

// // Pattern 5 - y axis gradient from top to bottom
// float strength =1.0- vUv.y;
//  gl_FragColor = vec4(strength, strength, strength, 1.0);

// // Pattern 6 - y axis gradient multiplication
// float strength =vUv.y * 2.0;
//  gl_FragColor = vec4(strength, strength, strength, 1.0);

// // Pattern 7 - modulus - (value, threshold) , if it goes over result is 0.
// float strength =mod(vUv.y * 10.0, 0.5);
//  gl_FragColor = vec4(strength, strength, strength, 1.0);

// //  Pattern 8 - Step - (limit , value)
// float strength = step( 0.5  ,mod(vUv.y * 10.0, 1.0));
//  gl_FragColor = vec4(strength, strength, strength, 1.0);

// //  Pattern 9 - Step - (limit , value)
// float strength = step( 0.8  ,mod(vUv.y * 10.0, 1.0));
//  gl_FragColor = vec4(strength, strength, strength, 1.0);

 
// //  Pattern 10 - Step - (limit , value)
// float strength = step( 0.8  ,mod(vUv.x * 10.0, 1.0));
//  gl_FragColor = vec4(strength, strength, strength, 1.0);

// //  Pattern 11 - adding 
// float strength = step( 0.8  ,mod(vUv.x * 10.0, 1.0));
// strength += step( 0.8  ,mod(vUv.y * 10.0, 1.0));
//  gl_FragColor = vec4(strength, strength, strength, 1.0);

// //  Pattern 12 - multiplying
// float strength = step( 0.8  ,mod(vUv.x * 10.0, 1.0));
// strength *= step( 0.8  ,mod(vUv.y * 10.0, 1.0));
//  gl_FragColor = vec4(strength, strength, strength, 1.0);

// //  Pattern 13 - multiplying
// float strength = step( 0.8  ,mod(vUv.y * 10.0, 1.0));
// strength *= step( 0.2  ,mod(vUv.x * 10.0, 1.0));
// gl_FragColor = vec4(strength, strength, strength, 1.0);

// //  Pattern 14 - barX + barY
// float barX = step( 0.8  ,mod(vUv.y * 10.0, 1.0));
// barX *= step( 0.4  ,mod(vUv.x * 10.0, 1.0));

// float barY = step( 0.8  ,mod(vUv.x * 10.0, 1.0));
// barY *= step( 0.4  ,mod(vUv.y * 10.0, 1.0));

// float strength =barX + barY ;
// gl_FragColor = vec4(strength, strength, strength, 1.0);

// //  Pattern 15 - Plus Pattern
// float barX = step( 0.8  ,mod(vUv.y * 10.0 + 0.2, 1.0));
// barX *= step( 0.4  ,mod(vUv.x * 10.0, 1.0));

// float barY = step( 0.8  ,mod(vUv.x * 10.0 + 0.2 , 1.0));
// barY *= step( 0.4  ,mod(vUv.y * 10.0, 1.0));

// float strength =barX + barY ;
// gl_FragColor = vec4(strength, strength, strength, 1.0);

// // Pattern 16 Middle Gradient - Absolute - turn negative in to positive
// float strength =abs(vUv.x - 0.5 ) ;
// gl_FragColor = vec4(strength, strength, strength, 1.0);


// // Pattern 17 Cross Gradient - Minimum of the two
// float strength = min(abs(vUv.x - 0.5 ), abs(vUv.y - 0.5)) ;
// gl_FragColor = vec4(strength, strength, strength, 1.0);

// // Pattern 18 Cross Gradient - Maximum of the two
// float strength = max(abs(vUv.x - 0.5 ), abs(vUv.y - 0.5)) ;
// gl_FragColor = vec4(strength, strength, strength, 1.0);

// // Pattern 19 - cut out box
// float strength = step(0.2,max(abs(vUv.x - 0.5 ), abs(vUv.y - 0.5))) ;
// gl_FragColor = vec4(strength, strength, strength, 1.0);

// // Pattern 20 - Intersection
// float sqaure1 = step(0.25,max(abs(vUv.x - 0.5 ), abs(vUv.y - 0.5))) ;
// float sqaure2 =1.0- step(0.3,max(abs(vUv.x - 0.5 ), abs(vUv.y - 0.5))) ;
// float strength = sqaure1 * sqaure2 ;
// gl_FragColor = vec4(strength, strength, strength, 1.0);

// // Pattern 21 - step gradient
// float strength = floor(vUv.x * 10.0 ) / 10.0;
// gl_FragColor = vec4(strength, strength, strength, 1.0);

// // Pattern 22
// float strength = floor(vUv.x * 10.0 ) / 10.0;
// strength *= floor(vUv.y * 10.0 ) / 10.0;
// gl_FragColor = vec4(strength, strength, strength, 1.0);

// // Pattern 23 - Random noise
// float strength = random(vUv);
// gl_FragColor = vec4(strength, strength, strength, 1.0);

// // Pattern 24- Grid pattern
// vec2 gridUv = vec2(floor(vUv.x * 10.0) * 10.0, floor(vUv.y * 10.0) / 10.0  );
// float strength = random(gridUv);
// gl_FragColor = vec4(strength, strength, strength, 1.0);

// // Pattern 25- Grid pattern - skewed
// vec2 gridUv = vec2(floor(vUv.x * 10.0) * 10.0, floor((vUv.x + vUv.y) * 10.0) / 10.0  );
// float strength = random(gridUv);
// gl_FragColor = vec4(strength, strength, strength, 1.0);

// // Pattern 26-  length
  // float strength = length(vUv -0.5);
  // gl_FragColor = vec4(strength, strength, strength, 1.0);

// // Pattern 27-  Distance
  // float strength = distance(vUv ,vec2(0.5 ));
  // gl_FragColor = vec4(strength, strength, strength, 1.0);

// // PAttern 28
  //   float strength = 1.0-distance(vUv ,vec2(0.5 ));
  // gl_FragColor = vec4(strength, strength, strength, 1.0);


// // Pattern 29 - Point
  //   float strength = 0.01 / distance(vUv ,vec2(0.5));
  // gl_FragColor = vec4(strength, strength, strength, 1.0);


// // Pattern 30 - Point skewed
  //   vec2 lightUv = vec2(
  //     vUv.x * 0.1 + 0.45,
  //     vUv.y * 0.5 + 0.25
  //   );
  //   float strength = 0.01 / distance(lightUv ,vec2(0.5));
  // gl_FragColor = vec4(strength, strength, strength, 1.0);

  // // Pattern 30 - Star
  //   vec2 lightUvx = vec2(
  //     vUv.x * 0.1 + 0.45,
  //     vUv.y * 0.5 + 0.25
  //   );
  //       vec2 lightUvy = vec2(
  //     vUv.x * 0.5 + 0.25,
  //     vUv.y * 0.1 + 0.45
  //   );
  //   float lightX = 0.01 / distance(lightUvx ,vec2(0.5));
  //   float lightY = 0.01 / distance(lightUvy ,vec2(0.5));
  //   float strength = lightX * lightY;
  // gl_FragColor = vec4(strength, strength, strength, 1.0);

    // // Pattern 31 - Star Rotate
  //   vec2 rotateUv  = rotate(vUv, 0.2, vec2(0.5,0.5));
  //   vec2 lightUvx = vec2(
  //     rotateUv.x * 0.1 + 0.45,
  //     rotateUv.y * 0.5 + 0.25
  //   );
  //       vec2 lightUvy = vec2(
  //     rotateUv.x * 0.5 + 0.25,
  //     rotateUv.y * 0.1 + 0.45
  //   );
  //   float lightX = 0.01 / distance(lightUvx ,vec2(0.5));
  //   float lightY = 0.01 / distance(lightUvy ,vec2(0.5));
  //   float strength = lightX * lightY;
  // gl_FragColor = vec4(strength, strength, strength, 1.0);

    // // Pattern 32 - Star Rotate
} 