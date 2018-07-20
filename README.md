# CoordinateAxis
3D XYZ Coordinate Axises

## Install Pod
pod 'CoordinateAxis'


## Sample Code
        //create an 3D Coordinate system
        let xyz = SCNXYZAxis(axisName: ("X", "Y", "Z"),
                             radius: 0.01,                                             //axis radius
                             sizeVector: SCNVector3(0.5, 0.7, 0.9),                    //axis length
                             directionVector: SCNVector3(1, 1, 1),                     //axis direction
                             colors: (x:.blue, y:.blue, z:.blue))                      //axis color
                            
        // add to the scene (0,0,0)
        let scene: SCNScene = SCNScene()
        scene.rootNode.addChildNode(xyz)
        
        // translate to scene
        xyz.moveAxis(transform: SCNVector3(0,-1,0))
        

## 3D XYZ
![image](https://github.com/sw0906/CoordinateAxis/blob/master/threed1.png)
![image](https://github.com/sw0906/CoordinateAxis/blob/master/threeD2.png)

