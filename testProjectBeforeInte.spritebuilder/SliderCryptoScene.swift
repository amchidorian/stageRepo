//
//  SliderCryptoScene.swift
//  ze iOS
//
//  Created by Clara MatchUpBox on 24/10/2018.
//  Copyright © 2018 Apportable. All rights reserved.
//

import Foundation

class SliderCryptoScene: CCNode, CCScrollViewDelegate {
    
    weak var _crypto1: CCNode!
    weak var _scrollCrypto: CCScrollView!
    var clone:CCNode!
    
    
    func didLoadFromCCB(){
        clone = _crypto1.copy() as? CCNode;
        clone.position.y = 10
    }
}
