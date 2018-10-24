//
//  PinMenuScene.swift
//  ze iOS
//
//  Created by Clara MatchUpBox on 24/10/2018.
//  Copyright © 2018 Apportable. All rights reserved.
//

import Foundation

class PinMenuScene: CCNode {
    
    static var sPinAction:Bool!
    
    func editPin(_ pSender:CCButton){
        if pSender.name == "updatePin" {
            PinMenuScene.sPinAction = true
        } else if pSender.name == "deletePin" {
            PinMenuScene.sPinAction = false
        }
        PinScene.sStep = 3
        let gameplayScene = CCBReader.load(asScene:"PinScene")
        let transition = CCTransition(fadeWithDuration: 1.0)
        CCDirector.shared().present(gameplayScene, with: transition)
    }
}
