//
//  Copyright © 2018 Tectus Dreamlab Pte Ltd. All rights reserved.
//

import Foundation
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
                axisNameNode.transform = SCNMatrix4Translate(axisNameNode.transform, 0, translateSetup.y * offsetRatio, translateSetup.z * offsetRatio)
            }
        }
    }
}

open class SCNXYZAxis: SCNNode {
    
    public var xAxis : SCNAxis = SCNAxis(type: .X)
    public var yAxis : SCNAxis = SCNAxis(type: .Y)
    public var zAxis : SCNAxis = SCNAxis(type: .Z)
    
    public var defaultValue = SCNXYZAxisDefaultValue()
    
    public var hiddeTestBox = false
    public var hiddeName = false
    
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

