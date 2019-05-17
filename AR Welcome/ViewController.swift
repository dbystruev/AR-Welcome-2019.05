//
//  ViewController.swift
//  AR Welcome
//
//  Created by Denis Bystruev on 17/05/2019.
//  Copyright © 2019 Denis Bystruev. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Enable default lighting
        sceneView.autoenablesDefaultLighting = true
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
        // Show the world origin
        sceneView.debugOptions = [ARSCNDebugOptions.showWorldOrigin]
        
        // Place campuses
        placeCampus()
        placeCampusInCode()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()

        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
}

// MARK: - Placing 3D Objects
extension ViewController {
    func placeCampus() {
        let scene = SCNScene(named: "art.scnassets/campus.scn")!
        let node = scene.rootNode.clone()
        node.position = SCNVector3(-2, -0.5, -2)
        sceneView.scene.rootNode.addChildNode(node)
    }
    
    func placeCampusInCode() {
        let building = getBuildingNode()
        
        let campus = SCNNode()
        campus.addChildNode(building)
        campus.position = SCNVector3(2, -0.5, -2)
        
        let grass = getGrassNode()
        grass.position.y = -0.501
        campus.addChildNode(grass)
        
        sceneView.scene.rootNode.addChildNode(campus)
    }
    
    func getBuildingNode() -> SCNNode {
        let material = SCNMaterial()
        material.diffuse.contents = UIImage(named: "bricks")
        
        let box = SCNBox(width: 3, height: 1, length: 1, chamferRadius: 0)
        box.materials = [material]
        
        let node = SCNNode()
        node.geometry = box
        
        return node
    }
    
    func getGrassNode() -> SCNNode {
        let plane = SCNPlane(width: 4, height: 2)
        plane.firstMaterial?.diffuse.contents = UIImage(named: "grass")
        
        let grass = SCNNode(geometry: plane)
        grass.eulerAngles.x = -.pi / 2
        
        return grass
    }
}
