//
//  DetailCrypto.swift
//  ze iOSs
//
//  Created by Clara MatchUpBox on 31/10/2018.
//  Copyright © 2018 Apportable. All rights reserved.
//

import Foundation

class DetailCrypto: CCNode {
    
    static var sDataCrypto:[String:Any]!
    
    weak var _nameCrypto:CCLabelTTF!
    weak var _symbolCrypto:CCLabelTTF!
    weak var _valueCrypto:CCLabelTTF!
    weak var _supplyCrypto:CCLabelTTF!
    weak var _change7Crypto:CCLabelTTF!
    weak var _change24Crypto:CCLabelTTF!
    weak var _rankCrypto:CCLabelTTF!
    weak var _logoCrypto:CCSprite!
    
    func didLoadFromCCB(){
        setDetails()
    }
    
    func setDetails(){
        _nameCrypto.string = "\(DetailCrypto.sDataCrypto!["name"]!)"
        _symbolCrypto.string = "\(DetailCrypto.sDataCrypto!["symbol"]!)"
        _valueCrypto.string = "\(DetailCrypto.sDataCrypto!["price"]!)"
        _supplyCrypto.string = "\(DetailCrypto.sDataCrypto!["total"]!)"
        _change7Crypto.string = "\(DetailCrypto.sDataCrypto!["change7"]!)"
        _change24Crypto.string = "\(DetailCrypto.sDataCrypto!["change24"]!)"
        _rankCrypto.string = "Crypto n°\(DetailCrypto.sDataCrypto!["rank"]!)"
        _logoCrypto.spriteFrame = CCSpriteFrame.init(imageNamed: "coinMarketCap/\(DetailCrypto.sDataCrypto!["img"]!)")
    }
}
