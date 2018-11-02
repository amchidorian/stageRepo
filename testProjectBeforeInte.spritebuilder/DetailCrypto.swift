//
//  DetailCrypto.swift
//  ze iOSs
//
//  Created by Dorian Pikcio on 31/10/2018.
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
    weak var _change1Crypto:CCLabelTTF!
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
        _change7Crypto.string = "\(DetailCrypto.sDataCrypto!["change7"]!)%"
        setLabelColor((DetailCrypto.sDataCrypto!["change7"]! as! NSNumber), _change7Crypto)
        _change24Crypto.string = "\(DetailCrypto.sDataCrypto!["change24"]!)%"
        setLabelColor((DetailCrypto.sDataCrypto!["change24"]! as! NSNumber), _change24Crypto)
        _change1Crypto.string = "\(DetailCrypto.sDataCrypto!["change1"]!)%"
        setLabelColor((DetailCrypto.sDataCrypto!["change1"]! as! NSNumber), _change1Crypto)
        _rankCrypto.string = "\(DetailCrypto.sDataCrypto!["rank"]!)"
        _logoCrypto.spriteFrame = CCSpriteFrame.init(imageNamed: "coinMarketCap/\(DetailCrypto.sDataCrypto!["img"]!)")
    }
    
    func setLabelColor(_ pPercent:NSNumber, _ pLabel:CCLabelTTF){
        let lFloatPercent = pPercent.floatValue
        if lFloatPercent > 0 {
            pLabel.color = CCColor(uiColor: UIColor(red: 0, green: 1, blue: 0, alpha: 1.0));
        } else if lFloatPercent < 0 {
            pLabel.color = CCColor(uiColor: UIColor(red: 1, green: 0, blue: 0, alpha: 1.0));
        }
    }
}
