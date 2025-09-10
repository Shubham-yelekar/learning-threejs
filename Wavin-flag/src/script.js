import * as THREE from "three";
import { OrbitControls } from "three/examples/jsm/controls/OrbitControls.js";
import GUI from "lil-gui";
import { DirectionalLightHelper } from "three";
import testVertexShader from "./Shaders/Test/vertex.glsl";
import testFragmentShader from "./Shaders/Test/fragment.glsl";
/**
 * Base
 */
// Debug
const gui = new GUI();

// Canvas
const canvas = document.querySelector("canvas.webgl");

// Scene
const scene = new THREE.Scene();

/**
 * Textures
 */
const textureLoader = new THREE.TextureLoader();

const flagTexture = textureLoader.load("/textures/flag-india-2.jpg");

/**
 * Test mesh
 */
// Geometry
const geometry = new THREE.PlaneGeometry(1.8, 1, 64, 64);

// Material
const material = new THREE.ShaderMaterial({
  vertexShader: testVertexShader,
  fragmentShader: testFragmentShader,
  transparent: true,
  uniforms: {
    uFrequency: { value: new THREE.Vector2(16, 8) },
    uTime: { value: 0 },
    uElevation: { value: .3 }, 
    uColor: { value: new THREE.Color("orange") },
    uTexture: { value: flagTexture },
  },
});

const flagFolder = gui.addFolder('Flag Wave');
flagFolder.add(material.uniforms.uElevation, 'value', 0, 3, 0.01).name('Elevation');
flagFolder.add(material.uniforms.uFrequency.value, 'x', 0, 40, 0.1).name('Frequency X');
flagFolder.add(material.uniforms.uFrequency.value, 'y', 0, 40, 0.1).name('Frequency Y');

material.uniforms.uLightDirection = {value: new THREE.Vector3(-2.8, 0.17, 8.0).normalize() };

// Mesh
const mesh = new THREE.Mesh(geometry, material);
mesh.rotation.x = -.25
mesh.rotation.z = .15
mesh.rotation.y = -.18

mesh.position.x = -0.03;
mesh.position.y = 0.0;
mesh.position.z = 0.20;


const meshFolder = gui.addFolder('Mesh Rotaion');
meshFolder.add(mesh.rotation, "x", -1, 1 , 0.001).name('Mesh rotatate X');
meshFolder.add(mesh.rotation, "z", -1, 1 , 0.001).name('Mesh rotatate Z');
meshFolder.add(mesh.rotation, "y", -1, 1 , 0.001).name('Mesh rotatate Y');

const meshPositionFolder = gui.addFolder('Mesh Position');
meshPositionFolder.add(mesh.position, 'x', -5, 5, 0.001).name('Mesh X');
meshPositionFolder.add(mesh.position, 'y', -5, 5, 0.001).name('Mesh Y');
meshPositionFolder.add(mesh.position, 'z', -5, 5, 0.001).name('Mesh Z');
scene.add(mesh);

// After scene creation
const ambientLight = new THREE.AmbientLight(0xffffff, 0.6);
scene.add(ambientLight);


const directionalLight = new THREE.DirectionalLight(0xffffff, 2.5);
directionalLight.position.set(-2.8, 0.17, 8.0);


// const directionalLightHelper = new DirectionalLightHelper(directionalLight, 0.8);
// scene.add(directionalLightHelper);

// Add this after you create the lights and mesh
const lightFolder = gui.addFolder('Lights');

// Ambient light intensity
lightFolder.add(ambientLight, 'intensity', 0, 2, 0.01).name('Ambient Intensity');

// Directional light intensity
lightFolder.add(directionalLight, 'intensity', 0, 5, 0.01).name('Directional Intensity');

// Directional light position
lightFolder.add(directionalLight.position, 'x', -10, 10, 0.01).name('DirLight X').onChange(() => {
    material.uniforms.uLightDirection.value.copy(directionalLight.position).normalize();
});
lightFolder.add(directionalLight.position, 'y', -10, 10, 0.01).name('DirLight Y').onChange(() => {
    material.uniforms.uLightDirection.value.copy(directionalLight.position).normalize();
});
lightFolder.add(directionalLight.position, 'z', -10, 10, 0.01).name('DirLight Z').onChange(() => {
    material.uniforms.uLightDirection.value.copy(directionalLight.position).normalize();
});
scene.add(directionalLight);

/**
 * Sizes
 */
const sizes = {
  width: window.innerWidth,
  height: window.innerHeight,
};

window.addEventListener("resize", () => {
  // Update sizes
  sizes.width = window.innerWidth;
  sizes.height = window.innerHeight;

  // Update camera
  camera.aspect = sizes.width / sizes.height;
  camera.updateProjectionMatrix();

  // Update renderer
  renderer.setSize(sizes.width, sizes.height);
  renderer.setPixelRatio(Math.min(window.devicePixelRatio, 2));
});

/**
 * Camera
 */
// Base camera
const camera = new THREE.PerspectiveCamera(
  40,
  sizes.width / sizes.height,
  0.1,
  100
);
camera.position.set(-0.4, -0.2, 1.0);
scene.add(camera);

const cameraFolder = gui.addFolder('Camera');
cameraFolder.add(camera.position, 'x', -5, 5, 0.001).name('Camera X');
cameraFolder.add(camera.position, 'y', -5, 5, 0.001).name('Camera Y');
cameraFolder.add(camera.position, 'z', 0.1, 5, 0.001).name('Camera Z');
cameraFolder.add(camera, 'fov', 10, 120, 1).name('Camera FOV').onChange(() => {
    camera.updateProjectionMatrix();
});


// Controls
const controls = new OrbitControls(camera, canvas);
controls.enableDamping = true;

/**
 * Renderer
 */
const renderer = new THREE.WebGLRenderer({
  canvas: canvas,
});
renderer.setSize(sizes.width, sizes.height);
renderer.setPixelRatio(Math.min(window.devicePixelRatio, 2));
renderer.outputColorSpace = THREE.SRGBColorSpace;
renderer.toneMapping = THREE.ACESFilmicToneMapping;
renderer.toneMappingExposure = 1.1;

renderer.shadowMap.enabled = true;
directionalLight.castShadow = true;
mesh.castShadow = true;


renderer.setClearColor(0xffffff, 1); // White background
/**
 * Animate
 */
const clock = new THREE.Clock();

const tick = () => {
  const elapsedTime = clock.getElapsedTime();

  // material.uniforms.uTime.value = elapsedTime;
  material.uniforms.uTime.value += 0.01;

  // Update controls
  controls.update();

  // Render
  renderer.render(scene, camera);

  // Call tick again on the next frame
  window.requestAnimationFrame(tick);
};

tick();
