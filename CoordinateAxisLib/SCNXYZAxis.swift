//
//  SCNXYZAxis.swift
//  CoordinateAxis
//
//  Created by Shou Wei on 19/7/18.
//  Copyright © 2018 Shou Wei. All rights reserved.
//

import UIKit
import SceneKit

open class SCNXYZAxis: SCNNode {
    
    public var xAxis : SCNAxis = SCNAxis(type: .X)
    public var yAxis : SCNAxis = SCNAxis(type: .Y)
    public var zAxis : SCNAxis = SCNAxis(type: .Z)
    
    public var defaultValue = SCNXYZAxisDefaultValue()
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public init(axisName: StringXYZ? = nil, radius: CGFloat? = nil, sizeVector: SCNVector3? = nil, directionVector: SCNVector3? = nil, colors: ColorXYZ? = nil, axisNameScale: Float? = nil) {
        super.init()
        
        setupXYZ(axisName: axisName, radius: radius, sizeVector: sizeVector, directionVector: directionVector, color: colors, axisNameScale: axisNameScale)
    }
    
    open func setupXYZ(axisName: StringXYZ? = nil, radius: CGFloat? = nil, sizeVector: SCNVector3? = nil, directionVector: SCNVector3? = nil, color: ColorXYZ? = nil, axisNameScale: Float? = nil) {
        defaultValue.axisName = axisName ?? defaultValue.axisName
        defaultValue.axisNameScale = axisNameScale ?? defaultValue.axisNameScale
        defaultValue.axisRadius = radius ?? defaultValue.axisRadius
        defaultValue.sizeVector = sizeVector ?? defaultValue.sizeVector
        defaultValue.directionVector = directionVector ?? defaultValue.directionVector
        defaultValue.color = color ?? defaultValue.color
        
        addXYZAxis(radius: defaultValue.axisRadius, sizeVector: defaultValue.sizeVector, color: defaultValue.color, name: defaultValue.axisName)
        setupXYZAxisPosition(transVector: defaultValue.transVector)
    }
    
    public func moveAxis(transform: SCNVector3) {
        self.transform = SCNMatrix4Translate(SCNMatrix4Identity, transform.x, transform.y, transform.z)
    }
    
    public func getMaxBoundingBoxLength(boundingBox: (min: SCNVector3, max: SCNVector3)) -> Float {
        let length = getBoundingBoxLength(boundingBox: boundingBox)
        let maxXY = max(length.x, length.y)
        return max(length.z, maxXY)
    }
    
    public func getBoundingBoxLength(boundingBox: (min: SCNVector3, max: SCNVector3)) -> SCNVector3 {
        let xLength = boundingBox.max.x - boundingBox.min.x
        let yLength = boundingBox.max.y - boundingBox.min.y
        let zLength = boundingBox.max.z - boundingBox.min.z
        return SCNVector3(xLength, yLength, zLength)
    }
    
    public func calculateTransfrom(boundingBox: (min: SCNVector3, max: SCNVector3), direction: SCNVector3) -> SCNVector3 {
        let transX = direction.x > 0 ? boundingBox.max.x : boundingBox.min.x
        let transY = direction.y > 0 ? boundingBox.max.y : boundingBox.min.y
        let transZ = direction.z > 0 ? boundingBox.max.z : boundingBox.min.z
        return SCNVector3(transX, transY, transZ)
    }
    
    private func addXYZAxis(radius: CGFloat, sizeVector: SCNVector3, color: ColorXYZ, name: StringXYZ) {
        xAxis.removeFromParentNode()
        yAxis.removeFromParentNode()
        zAxis.removeFromParentNode()
        
        xAxis = SCNAxis(type: .X, radius: radius, length: CGFloat(sizeVector.x), color: color.x, name: name.x)
        yAxis = SCNAxis(type: .Y, radius: radius, length: CGFloat(sizeVector.y), color: color.y, name: name.y)
        zAxis = SCNAxis(type: .Z, radius: radius, length: CGFloat(sizeVector.z), color: color.z, name: name.z)
        self.addChildNode(xAxis)
        self.addChildNode(yAxis)
        self.addChildNode(zAxis)
    }
    
    private func setupXYZAxisPosition(transVector: SCNVector3) {
        xAxis.axisNode.transform = SCNMatrix4Rotate(xAxis.axisNode.transform, Float.pi / 2, 0, 0, 1)
        zAxis.axisNode.transform = SCNMatrix4Rotate(zAxis.axisNode.transform, Float.pi / 2, 1, 0, 0)
        
        xAxis.translateSetup = SCNVector3(transVector.x, 0, 0)
        yAxis.translateSetup = SCNVector3(0, transVector.y, 0)
        zAxis.translateSetup = SCNVector3(0, 0, transVector.z)
    }
    
}
