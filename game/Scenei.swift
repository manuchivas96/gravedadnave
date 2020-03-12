//
//  Scenei.swift
//  game
//
//  Created by CEDAM 25 on 11/03/20.
//  Copyright © 2020 UNAM. All rights reserved.
//

import UIKit
import SpriteKit

class Scenei: SKScene {
    override func didMove(to view: SKView) {
        
        backgroundColor = .brown
        let label1 = SKLabelNode(text: "Jugar")
        label1.fontColor = .red
        label1.fontSize = 40
        label1.position = CGPoint(x: size.width/2, y: size.height/2)
        label1.name =  "Jugar"
        addChild(label1)
        
        let label2 = SKLabelNode(text: "Salir")
        label2.fontColor = .cyan
        label2.fontSize = 40
        label2.position = CGPoint(x: size.width/2, y: size.height/2 - 200)
        label2.name = "Salir"
        addChild(label2)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let toque = touches.first else {
            return
        }
        let locationToque = toque.location(in: self)
        let toqueNodo = self.atPoint(locationToque)
        if (toqueNodo.name == "Jugar") {
            let nueva = GameScene(size: size)
            nueva.scaleMode = scaleMode
            let trans = SKTransition.doorsCloseHorizontal(withDuration: 2)
            view?.presentScene(nueva,transition: trans)
        }
        if (toqueNodo.name  == "Salir" ){
            let nueva = gamy(size: size)
            nueva.scaleMode = scaleMode
            let trans = SKTransition.doorsOpenVertical(withDuration: 2)
            view?.presentScene(nueva,transition: trans)
        }
    }
}
