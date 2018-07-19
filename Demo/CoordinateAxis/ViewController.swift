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
        
        let ambientLightNode = SCNNode()
        ambientLightNode.light = SCNLight()
        ambientLightNode.light!.type = .ambient
        ambientLightNode.light!.color = UIColor.black
        scene.rootNode.addChildNode(ambientLightNode)
        sceneView.backgroundColor = UIColor.gray
        
        let zeroLocationBox = SCNNode.creatSCNAxisBox(color: .white)
        scene.rootNode.addChildNode(zeroLocationBox)
    }
    
    func addBasicBlueCoordinateAxises() {
        let xyz = SCNXYZAxis(axisName: ("X", "Y", "Z"),
                             sizeVector: SCNVector3(0.5, 0.7, 0.9),
                             directionVector: SCNVector3(1, 1, 1),
                             colors: (.blue, .blue, .blue))
        scene.rootNode.addChildNode(xyz)
    }
    
    func addMinusYellowCoordinateAxises() {
        let xyz = SCNXYZAxis( axisName: ("X", "Y", "Z"),
                              radius: 0.01,
                              sizeVector: SCNVector3(0.5, 0.7, 0.9),
                              directionVector: SCNVector3(-1, -1, -1),
                              colors: (.yellow, .yellow, .yellow))
        scene.rootNode.addChildNode(xyz)
        
        xyz.moveAxis(transform: SCNVector3(1,1,0))
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

