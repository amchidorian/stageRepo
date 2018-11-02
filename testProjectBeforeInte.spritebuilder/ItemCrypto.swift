//
//  ItemCrypto.swift
//  ze iOS
//
//  Created by Dorian Pikcio on 24/10/2018.
//  Copyright © 2018 Apportable. All rights reserved.
//

import Foundation

class ItemCrypto{

    weak var _nomCrypto:CCLabelTTF!
    
    func didLoadFromCCB() {
        //print("qopsdh")
        //print(_nomCrypto)
    }
 
    func setName(_ pName:String){
        _nomCrypto.name = pName;
    }
}

