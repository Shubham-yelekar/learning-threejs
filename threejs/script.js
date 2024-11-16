

const scene = new THREE.Scene(); // Create  a scene

const camera = new THREE.PerspectiveCamera(
  75, // FOV
  window.innerWidth / window.innerHeight, //canvas aspect
   0.1, // near
   1000 // far
  );

const geometry = new THREE.BoxGeometry( 4 , 1, 1 );
const material = new THREE.MeshBasicMaterial( { color: "blue" } );
const cube = new THREE.Mesh( geometry, material );
scene.add( cube );

camera.position.z = 5;
const canvas = document.getElementById('canvas')
const renderer = new THREE.WebGLRenderer({canvas: canvas});
renderer.setSize( window.innerWidth, window.innerHeight );
document.body.appendChild( renderer.domElement );

function animate() {
	renderer.render( scene, camera );
  cube.rotation.x += 0.01;
  // cube.rotation.y += 0.01;
}
renderer.setAnimationLoop( animate );

