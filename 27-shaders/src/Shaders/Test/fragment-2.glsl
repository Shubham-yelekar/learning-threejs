
varying vec2 vUv;
uniform float utime;
#define PI 3.14

float random(vec2 st){
  return fract(sin(dot(st.xy, vec2(12.9898,78.233))) * 43758.54534123 );
}
vec2 rotate(vec2 uv, float rotation, vec2 mid){
  return vec2(
    cos(rotation) * (uv.x - mid.x) + sin(rotation) * (uv.y - mid.y) + mid.x,
    cos(rotation) * (uv.y - mid.y) - sin(rotation) * (uv.x - mid.x) + mid.y
  );
}

vec2 fade(vec2 t)
{
    return t*t*t*(t*(t*6.0-15.0)+10.0);
}

vec4 permute(vec4 x){return mod(((x*34.0)+1.0)*x, 289.0);}
vec4 taylorInvSqrt(vec4 r){return 1.79284291400159 - 0.85373472095314 * r;}
vec3 fade(vec3 t) {return t*t*t*(t*(t*6.0-15.0)+10.0);}

float cnoise(vec3 P){
  vec3 Pi0 = floor(P); // Integer part for indexing
  vec3 Pi1 = Pi0 + vec3(1.0); // Integer part + 1
  Pi0 = mod(Pi0, 289.0);
  Pi1 = mod(Pi1, 289.0);
  vec3 Pf0 = fract(P); // Fractional part for interpolation
  vec3 Pf1 = Pf0 - vec3(1.0); // Fractional part - 1.0
  vec4 ix = vec4(Pi0.x, Pi1.x, Pi0.x, Pi1.x);
  vec4 iy = vec4(Pi0.yy, Pi1.yy);
  vec4 iz0 = Pi0.zzzz;
  vec4 iz1 = Pi1.zzzz;

  vec4 ixy = permute(permute(ix) + iy);
  vec4 ixy0 = permute(ixy + iz0);
  vec4 ixy1 = permute(ixy + iz1);

  vec4 gx0 = ixy0 / 7.0;
  vec4 gy0 = fract(floor(gx0) / 7.0) - 0.5;
  gx0 = fract(gx0);
  vec4 gz0 = vec4(0.5) - abs(gx0) - abs(gy0);
  vec4 sz0 = step(gz0, vec4(0.0));
  gx0 -= sz0 * (step(0.0, gx0) - 0.5);
  gy0 -= sz0 * (step(0.0, gy0) - 0.5);

  vec4 gx1 = ixy1 / 7.0;
  vec4 gy1 = fract(floor(gx1) / 7.0) - 0.5;
  gx1 = fract(gx1);
  vec4 gz1 = vec4(0.5) - abs(gx1) - abs(gy1);
  vec4 sz1 = step(gz1, vec4(0.0));
  gx1 -= sz1 * (step(0.0, gx1) - 0.5);
  gy1 -= sz1 * (step(0.0, gy1) - 0.5);

  vec3 g000 = vec3(gx0.x,gy0.x,gz0.x);
  vec3 g100 = vec3(gx0.y,gy0.y,gz0.y);
  vec3 g010 = vec3(gx0.z,gy0.z,gz0.z);
  vec3 g110 = vec3(gx0.w,gy0.w,gz0.w);
  vec3 g001 = vec3(gx1.x,gy1.x,gz1.x);
  vec3 g101 = vec3(gx1.y,gy1.y,gz1.y);
  vec3 g011 = vec3(gx1.z,gy1.z,gz1.z);
  vec3 g111 = vec3(gx1.w,gy1.w,gz1.w);

  vec4 norm0 = taylorInvSqrt(vec4(dot(g000, g000), dot(g010, g010), dot(g100, g100), dot(g110, g110)));
  g000 *= norm0.x;
  g010 *= norm0.y;
  g100 *= norm0.z;
  g110 *= norm0.w;
  vec4 norm1 = taylorInvSqrt(vec4(dot(g001, g001), dot(g011, g011), dot(g101, g101), dot(g111, g111)));
  g001 *= norm1.x;
  g011 *= norm1.y;
  g101 *= norm1.z;
  g111 *= norm1.w;

  float n000 = dot(g000, Pf0);
  float n100 = dot(g100, vec3(Pf1.x, Pf0.yz));
  float n010 = dot(g010, vec3(Pf0.x, Pf1.y, Pf0.z));
  float n110 = dot(g110, vec3(Pf1.xy, Pf0.z));
  float n001 = dot(g001, vec3(Pf0.xy, Pf1.z));
  float n101 = dot(g101, vec3(Pf1.x, Pf0.y, Pf1.z));
  float n011 = dot(g011, vec3(Pf0.x, Pf1.yz));
  float n111 = dot(g111, Pf1);

  vec3 fade_xyz = fade(Pf0);
  vec4 n_z = mix(vec4(n000, n100, n010, n110), vec4(n001, n101, n011, n111), fade_xyz.z);
  vec2 n_yz = mix(n_z.xy, n_z.zw, fade_xyz.y);
  float n_xyz = mix(n_yz.x, n_yz.y, fade_xyz.x); 
  return 2.2 * n_xyz;
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

    // // Pattern 33 - Pi 
    // float pi = 3.14159;
  //   vec2 rotateUv = rotate(vUv, PI * 0.25, vec2(0.5));
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

  // // Pattern 34 - circle in the box
    // float strength = step(0.25, distance(vUv, vec2(0.5)));
    //  gl_FragColor = vec4(strength, strength, strength, 1.0);

    // // Pattern 35 - circle in the box gradient
    // float strength = abs(distance(vUv, vec2(0.5))-0.25);
    //  gl_FragColor = vec4(strength, strength, strength, 1.0);

    // // Pattern 36 - Ring
    // float strength = step(0.01,abs(distance(vUv, vec2(0.5))-0.25));
    //  gl_FragColor = vec4(strength, strength, strength, 1.0);

    // // Pattern 37 - Ring
    // float strength =1.0 - step(0.01,abs(distance(vUv, vec2(0.5))-0.25));
    //  gl_FragColor = vec4(strength, strength, strength, 1.0);


    // // Pattern 38 - Sine in ring
    // vec2 wavedUv = vec2(vUv.x, vUv.y + sin(vUv.x * 100.0)*0.1);
    // float strength =1.0 - step(0.01,abs(distance(wavedUv, vec2(0.5))-0.25));
    //  gl_FragColor = vec4(strength, strength, strength, 1.0);

       // // Pattern 39 - Sine pattern
    // vec2 wavedUv = vec2(vUv.x + sin(vUv.y * 100.0) * 0.1, vUv.y + sin(vUv.x * 100.0)*0.1);
    // float strength =1.0 - step(0.01,abs(distance(wavedUv, vec2(0.5))-0.25));
    //  gl_FragColor = vec4(strength, strength, strength, 1.0);

       // // Pattern 40 - Angles atan
    // float angle = atan(vUv.x, vUv.y );
    // float strength = angle;
    //  gl_FragColor = vec4(strength, strength, strength, 1.0);

   // // Pattern 41 - Angles atan
    // float angle = atan(vUv.x -0.5, vUv.y - 0.5 );
    // float strength = angle;
    //  gl_FragColor = vec4(strength, strength, strength, 1.0);

    // // Pattern 42 - Radial Gradient
    // float angle = atan(vUv.x -0.5, vUv.y - 0.5 );
    // angle /= PI * 2.0 ;
    // angle += 0.5;
    // float strength = angle;
    //  gl_FragColor = vec4(strength, strength, strength, 1.0);


// // Pattern 43 - Angles atan
    // float angle = atan(vUv.x -0.5, vUv.y - 0.5 );
    // angle /= PI * 2.0 ;
    // angle += 0.5;
    // angle *= 30.0;
    // angle = mod(angle, 1.0);
    // float strength = angle;
    //  gl_FragColor = vec4(strength, strength, strength, 1.0);

 // // Pattern 44 - Angles atan
    // float angle = atan(vUv.x -0.5, vUv.y - 0.5 );
    // angle /= PI * 2.0 ;
    // angle += 0.5;

    // float strength = sin(angle*100.0);
    //  gl_FragColor = vec4(strength, strength, strength, 1.0);

 // // Pattern 45 - Circle with sine

//  float angle = atan(vUv.x -0.5, vUv.y - 0.5 );
//     angle /= PI * 2.0 ;
//     angle += 0.5;
//     float sinesoid = sin(angle * 100.0);
//  float radius = 0.25 + sinesoid * 0.01;
//     float strength =1.0 - step(0.01,abs(distance(vUv, vec2(0.5))- radius));

//      gl_FragColor = vec4(strength, strength, strength, 1.0);

 // // Pattern 46 - Noise

    // float strength =cnoise(vUv * 10.0);

    //  gl_FragColor = vec4(strength, strength, strength, 1.0);


     
 // // Pattern 47 - Noise

    // float strength =1.0 - abs(cnoise(vUv * 10.0));

    //  gl_FragColor = vec4(strength, strength, strength, 1.0);

          
 // // Pattern 48 - Noise

    // float strength =sin(cnoise(vUv * 10.0)* 10.0);

    //  gl_FragColor = vec4(strength, strength, strength, 1.0);

  // // Pattern 49 - Noise

// float strength =step(0.01,sin(cnoise(vUv * 10.0)* 10.0));

//   gl_FragColor = vec4(strength, strength, strength, 1.0);


// // Pattern 50 - Noise with color

// float strength =step(0.01,sin(cnoise(vUv * 10.0)* 20.0));

// vec3 blackColor = vec3(0.0);
// vec3 uvColor = vec3(vUv, 1.0);
// vec3 mixedColor = mix(blackColor, uvColor, strength);

//   gl_FragColor = vec4(mixedColor, 1.0);

vec4 color = vec4(1.0,0.0,0.0,1.0);
float noise = cnoise(vec3(vUv*4.0, utime*0.1));
color.rgb= vec3(noise);
 gl_FragColor = color;  

} 