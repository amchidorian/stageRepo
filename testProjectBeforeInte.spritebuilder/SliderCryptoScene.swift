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
    var lListeItems:[String]! = []
    var lListeNomItems:[String]! = []
    var clone:CCNode!
    weak var _scrollViewCrypto:CCScrollView!
    let fm:FileManager = FileManager.default
    let path = Bundle.main.resourcePath!

    
    
    func didLoadFromCCB(){
        getIcons()
        let children:[CCNode]! = _scrollViewCrypto!.children as! [CCNode]
        let slider = children[0]
        createSlider(slider)
        
    }
    
    func createSlider(_ pSlider:CCNode){
        var item:CCNode = CCBReader.load("ItemCrypto")
        let ih = item.contentSize.height
        print(ih)
        print(pSlider.contentSize.height)
        pSlider.contentSize.height = ih * 100
        print(pSlider.contentSize.height)
        var sliderH = pSlider.contentSize.height
        for var i in 0..<lListeItems.count{
            var item:CCNode = CCBReader.load("ItemCrypto")
            let ih = item.contentSize.height
            let iFloat = CGFloat(i+1)
            print(iFloat)
           item.position = CGPoint.init(x: 0, y: sliderH - ih * iFloat)
            var itemChildren:Array = item.children
            for obj in itemChildren {
                if let sprite = obj as? CCSprite {
                    sprite.spriteFrame = CCSpriteFrame.init(imageNamed: "coinMarketCap/\(lListeItems[i])")
                } else if let label = obj as? CCLabelTTF {
                    label.string = lListeNomItems[i]
                }
            }
            print(item)
            pSlider.addChild(item)
        }
    }
    
    func getIcons(){
        
        do {
            let items = try fm.contentsOfDirectory(atPath: "\(path)/Published-iOS/coinMarketCap/resources-phonehd")
            
            for item in items {
                lListeItems.append(item)
            }
        } catch {}
        orderItems()
    }
    
    func orderItems(){
        var lTempItems:[String] = []
        var lTempNomItems:[String] = []
        for var i in 0..<lListeItems.count{
            for var j in 0..<lListeItems.count{
                let lItem:[String] = lListeItems[j].components(separatedBy: "+_+")
                if(Int(lItem[0]) == i){
                    let lNom:String = lItem[1].components(separatedBy: ".png")[0]
                    lTempNomItems.append(lNom)
                    lTempItems.append(lListeItems[j])
                }
            }
        }
        lListeItems = lTempItems
        lListeNomItems = lTempNomItems
    }
    
    func createItems(){
        
    }
}
