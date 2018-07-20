//
//  ViewController.swift
//  CoordinateAxis
//
//  Created by Shou Wei on 19/7/18.
//  Copyright © 2018 Shou Wei. All rights reserved.
//

import UIKit
import SceneKit

class ViewController: UIViewController {
    
    @IBOutlet weak var sceneView: SCNView!
    let scene: SCNScene = SCNScene()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupScene()
        
        addBasicBlueCoordinateAxises()
        addMinusYellowCoordinateAxises()
    }
    
    func setupScene() {
        sceneView.scene = scene
        sceneView.showsStatistics = true
        scene.rootNode.transform = SCNMatrix4MakeScale(5, 5, 5);
        
        let ambientLightNode = SCNNode()
        ambientLightNode.light = SCNLight()
        ambientLightNode.light!.type = .ambient
        ambientLightNode.light!.color = UIColor.black
        scene.rootNode.addChildNode(ambientLightNode)
        sceneView.backgroundColor = UIColor.gray
        
        // create and add a camera to the scene
        let cameraNode = SCNNode()
        let camera = SCNCamera()
        camera.zNear = 0.1
        camera.zFar = 0.5
        camera.focalLength = 60
        camera.automaticallyAdjustsZRange = true
        cameraNode.camera = camera
        
        // place the camera
        cameraNode.position = SCNVector3Make(0, 0, 8);
        scene.rootNode.addChildNode(cameraNode)
        sceneView.allowsCameraControl = true
    }
    
    func addBasicBlueCoordinateAxises() {
        let xyz = SCNXYZAxis(axisName: ("X", "Y", "Z"),
                             radius: 0.01,
                             sizeVector: SCNVector3(0.5, 0.7, 0.9),
                             directionVector: SCNVector3(1, 1, 1),
                             colors: (.blue, .blue, .blue))
        scene.rootNode.addChildNode(xyz)
        
    }
    
    func addMinusYellowCoordinateAxises() {
        let xyz = SCNXYZAxis( axisName: ("X", "-Y", "-Z"),
                              radius: 0.01,
                              directionVector: SCNVector3(1, -1, -1))
        scene.rootNode.addChildNode(xyz)
        
        xyz.moveAxis(transform: SCNVector3(0,-0.2,0))
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

