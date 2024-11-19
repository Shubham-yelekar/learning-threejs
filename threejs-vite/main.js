import * as THREE from 'three';
import { OrbitControls } from 'three/addons/controls/OrbitControls.js';

const scene = new THREE.Scene();
const camera = new THREE.PerspectiveCamera(
  75,
  window.innerWidth / window.innerHeight,
  0.1,
  100
);

camera.position.z = 5;

const light = new THREE.DirectionalLight("white", 3);
light.position.set(2,2,2);
scene.add(light)

// const helper = new THREE.DirectionalLightHelper( light, 5 );
// scene.add( helper )

let textureLoader = new THREE.TextureLoader();
let newtex = textureLoader.load("./public/earth-texture.jpeg")
console.log(newtex);


const geometry  = new THREE.SphereGeometry(1,20,20);
const mat = new THREE.MeshPhysicalMaterial({map: newtex});
const planet = new THREE.Mesh(geometry, mat);

scene.add(planet)

const canvas = document.querySelector("canvas");
const renderer = new THREE.WebGLRenderer({canvas})
renderer.setSize(window.innerWidth, window.innerHeight);

renderer.render(scene, camera)
const controls = new OrbitControls( camera, canvas  );
function animation(){
  window.requestAnimationFrame(animation)

  controls.update();
  renderer.render(scene, camera)
}
animation()