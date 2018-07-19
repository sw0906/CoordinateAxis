//
//  SCNNodeEx.swift
//  CoordinateAxis
//
//  Created by Shou Wei on 19/7/18.
//  Copyright © 2018 Shou Wei. All rights reserved.
//

import UIKit
import SceneKit

extension SCNNode {
    
    class func creatSCNAxisNode(radius: CGFloat = 0.005, length: CGFloat = 0.6, color: UIColor = UIColor.red) -> SCNNode {
        let node = SCNNode()
        let axisCylinder = SCNCylinder(radius: radius, height: length)
        node.geometry = axisCylinder
        node.geometry?.firstMaterial?.diffuse.contents = color
        return node
    }
    
    class func creatSCNAxisNameNode(name: String, color: UIColor = UIColor.white, scale: Float = 0.005) -> SCNNode {
        let node = SCNNode()
        let xAxisString = SCNText(string: name, extrusionDepth: 1)
        xAxisString.font = UIFont.systemFont(ofSize: 8)
        node.geometry = xAxisString
        node.scale = SCNVector3(x: scale, y: scale, z: scale)
        node.geometry?.firstMaterial?.diffuse.contents = color
        return node
    }
    
    class func creatSCNAxisBox(radius: CGFloat = 0.05, color: UIColor) -> SCNNode {
        let node = SCNNode()
        let box = SCNBox(width: radius, height: radius, length: radius, chamferRadius: 0)
        node.geometry = box
        node.geometry?.firstMaterial?.diffuse.contents = color
        return node
    }
}

extension SCNVector3 {
    func multiple(_ value: Float) -> SCNVector3 {
        var vector = SCNVector3()
        vector.x = self.x * value
        vector.y = self.y * value
        vector.z = self.z * value
        return vector
    }
    
    var translateMatrix4: SCNMatrix4 {
        return SCNMatrix4Translate(SCNMatrix4Identity, x, y, z)
    }
}

extension SCNMatrix4 {
    
    static func SCNMatrix4TranslateWithSCNVector3(m: SCNMatrix4, translate3: SCNVector3) -> SCNMatrix4 {
        return SCNMatrix4Translate(m, translate3.x, translate3.y, translate3.z)
    }
    
    func translate(vector3: SCNVector3) -> SCNMatrix4 {
        return SCNMatrix4Translate(self, vector3.x, vector3.y, vector3.z)
    }
}
