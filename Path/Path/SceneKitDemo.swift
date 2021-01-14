//
//  SceneKitDemo.swift
//  Path
//
//  Created by Patrick McKowen on 12/16/20.
//

import SwiftUI
import SceneKit

struct SceneKitView: UIViewRepresentable {
    func makeUIView(context: UIViewRepresentableContext<SceneKitView>) -> SCNView {
        let sceneView = SCNView()
        sceneView.scene = SCNScene()
        sceneView.allowsCameraControl = true
        sceneView.autoenablesDefaultLighting = true
        sceneView.backgroundColor = UIColor.black

        let sphere = SCNSphere(radius: 2.0)
        sphere.firstMaterial?.diffuse.contents = UIColor.blue
        let spherenode = SCNNode(geometry: sphere)
        spherenode.position = SCNVector3(x: 0.0, y: 3.0, z: 0.0)

        sceneView.scene?.rootNode.addChildNode(spherenode)
        return sceneView
    }

    func updateUIView(_ uiView: SCNView, context: UIViewRepresentableContext<SceneKitView>) {

    }

    typealias UIViewType = SCNView
}

struct DemoSceneKit: View {
    var body: some View {
        SceneKitView()
    }
}

struct DemoSceneKit_Previews: PreviewProvider {
    static var previews: some View {
        DemoSceneKit()
    }
}
