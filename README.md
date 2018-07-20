# CoordinateAxis
3D XYZ Coordinate Axises

##
pod 'CoordinateAxis'


## Sample Code

        let scene: SCNScene = SCNScene()
        let xyz = SCNXYZAxis( axisName: ("X", "-Y", "-Z"),
                              radius: 0.01,
                              directionVector: SCNVector3(1, -1, -1))
        scene.rootNode.addChildNode(xyz)
        
        xyz.moveAxis(transform: SCNVector3(0,-0.2,0))

## 3D XYZ
![image](https://github.com/sw0906/CoordinateAxis/blob/master/threed1.png)
![image](https://github.com/sw0906/CoordinateAxis/blob/master/threeD2.png)

