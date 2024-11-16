import * as THREE from 'three';

const scene = new THREE.Scene();
const camera = new THREE.PerspectiveCamera(
  75,
  window.innerWidth / window.innerHeight,
  0.1,
  100
);

camera.position.z = 5;

const cubegeo  = new THREE.BoxGeometry(2,2,2);
const cubemat = new THREE.MeshBasicMaterial({color : "red"});
const cube = new THREE.Mesh(cubegeo, cubemat);

const spheregeo  = new THREE.SphereGeometry(1, 32, 16);
const spheremat = new THREE.MeshBasicMaterial({color : "blue"});
const sphere = new THREE.Mesh(spheregeo, spheremat);


const group = new THREE.Group()

group.add(cube);
group.add(sphere)

scene.add(group)

cube.position.x = -3; // Move the cube to the left
sphere.position.x = 3; // Move the sphere to the right

const canvas = document.querySelector("canvas");
const renderer = new THREE.WebGLRenderer({canvas})
renderer.setSize(window.innerWidth, window.innerHeight);

renderer.render(scene, camera)

function animation(){
  window.requestAnimationFrame(animation)
  group.rotation.z += 0.01;
  renderer.render(scene, camera)
}
animation()