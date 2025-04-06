import * as THREE from 'three'
import Sizes from "./Utils/Sizes"
import Time from "./Utils/Time"
import Camera from './Camera'

export default class Experience {
    constructor(canvas) {
        // global access 
        window.experience = this

        // options
        this.canvas = canvas

        //Setup
        this.sizes = new Sizes()
        this.time = new Time()
        this.scene = new THREE.Scene()
        this.camera = new Camera()

        this.sizes.on('resize', ()=>{
            this.resize()
        })

        // Time tick event
        this.time.on('tick', () =>
            {
                this.update()
            })
    }

    resize() {
        console.log('resize');
    }

    update()
    {

    }
}