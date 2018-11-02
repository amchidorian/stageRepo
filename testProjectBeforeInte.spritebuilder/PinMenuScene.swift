//
//  PinMenuScene.swift
//  ze iOS
//
//  Created by Dorian Pikcio on 24/10/2018.
//  Copyright © 2018 Apportable. All rights reserved.
//

import Foundation

class PinMenuScene: CCNode {
    
    static var sPinAction:Bool!
    
    // Function to redirect for update or delete.
    func editPin(_ pSender:CCButton){
        if pSender.name == "updatePin" {
            PinMenuScene.sPinAction = true
        } else if pSender.name == "deletePin" {
            PinMenuScene.sPinAction = false
        }
        PinScene.sStep = 3
        let lGameplayScene = CCBReader.load(asScene:"PinScene")
        let lTransition = CCTransition(fadeWithDuration: 1.0)
        CCDirector.shared().present(lGameplayScene, with: lTransition)
    }
}
