//
//  SCNNodeEx.swift
//  CoordinateAxis
//
//  Created by Shou Wei on 19/7/18.
//  Copyright © 2018 Shou Wei. All rights reserved.
//

import UIKit
import SceneKit

public typealias ColorXYZ = (x: UIColor, y: UIColor, z: UIColor)
public typealias StringXYZ = (x: String, y: String, z:String)

public struct SCNXYZAxisDefaultValue {
    
    public var axisRadius: CGFloat = 0.005
    
    public var color: ColorXYZ = (.red, .yellow, .green)
    public var axisName: StringXYZ = ("x", "y", "z")
    public var axisNameScale: Float = 0.005
    
    public var sizeVector: SCNVector3 = SCNVector3Make(1, 1, 1)
    public var directionVector: SCNVector3 = SCNVector3(1, 1, 1) // can change axis point to - or + , using -1 point to -
    
    public var transVector: SCNVector3 {
        return SCNVector3Make(sizeVector.x * directionVector.x, sizeVector.y * directionVector.y, sizeVector.z * directionVector.z)
    }
}

open class SCNAxis: SCNNode {
    
    public enum SCNAxisType: String {
        case X,Y,Z
    }
    
    public var axisNode: SCNNode = SCNNode()
    public var axisNameNode: SCNNode = SCNNode()
    public var boxNode: SCNNode = SCNNode()
    
    public var hideTestBox = true
    public var hideName = false
    
    public var type: SCNAxisType = .X
    
    public init(type: SCNAxisType, radius: CGFloat = 0.005, length: CGFloat = 0.06, color: UIColor = .white, name: String = "x") {
        super.init()
        self.type = type
        addAxis(radius: radius, length: length, color: color, name: name)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addAxis(radius: CGFloat, length: CGFloat, color: UIColor, name: String) {
        axisNode = SCNNode.creatSCNAxisNode(radius: radius, length: length, color: color)
        axisNameNode = SCNNode.creatSCNAxisNameNode(name: name, color: color)
        boxNode = SCNNode.creatSCNAxisBox(color: color)
        self.addChildNode(axisNode)
        self.addChildNode(axisNameNode)
        self.addChildNode(boxNode)
        
        boxNode.isHidden = hideTestBox
        axisNameNode.isHidden = hideName
    }
    
    var translateSetup: SCNVector3 = SCNVector3() {
        didSet {
            axisNode.transform = SCNMatrix4Translate(axisNode.transform, translateSetup.x / 2, translateSetup.y / 2, translateSetup.z / 2)
            boxNode.transform = SCNMatrix4Translate(boxNode.transform, translateSetup.x, translateSetup.y, translateSetup.z)
            axisNameNode.transform = SCNMatrix4Translate(axisNameNode.transform, translateSetup.x, translateSetup.y, translateSetup.z)
            
            let offsetRatio: Float = 0.05
            switch type {
            case .X:
                axisNameNode.transform = SCNMatrix4Translate(axisNameNode.transform, translateSetup.x * offsetRatio, 0, 0)
            case .Y:
                axisNameNode.transform = SCNMatrix4Translate(axisNameNode.transform, 0, translateSetup.y * offsetRatio, 0)
            case .Z:
                axisNameNode.transform = SCNMatrix4Translate(axisNameNode.transform, 0, 0, translateSetup.z * offsetRatio)
            }
        }
    }
}
