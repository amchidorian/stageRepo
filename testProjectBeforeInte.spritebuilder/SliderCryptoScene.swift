//
//  SliderCryptoScene.swift
//  ze iOS
//
//  Created by Clara MatchUpBox on 24/10/2018.
//  Copyright © 2018 Apportable. All rights reserved.
//

import Foundation

class SliderCryptoScene: CCNode, CCScrollViewDelegate {
    
    //Variable locale
    var lDataCrypto:Array<[String:Any]>! = []
    var lTemplateCrypto:[String:Any]!
    
    //Variable Design
    weak var _crypto1: CCNode!
    weak var _scrollViewCrypto:CCScrollView!
    
    var lListeItems:[String]! = []
    var lListeNomItems:[String]! = []
    var clone:CCNode!
    let fm:FileManager = FileManager.default
    let path = Bundle.main.resourcePath!
    static var sCryptoData:Data!
    var lData:Data!
    
    
    
    func didLoadFromCCB(){
        for var i in 0..<100{lDataCrypto.append([:])}
        let children:[CCNode]! = _scrollViewCrypto!.children as! [CCNode]
        let slider = children[0]
        //        createSliderLine(slider)
        organizedCryptoDatas()
        print(lDataCrypto[0])
        
    }
    
    func createSliderLine(_ pSlider:CCNode){
        var item:CCNode = CCBReader.load("ItemCrypto")
        let ih = item.contentSize.height
        pSlider.contentSize.height = ih * 100
        var sliderH = pSlider.contentSize.height
        for var i in 0..<lListeItems.count{
            var item:CCNode = CCBReader.load("ItemCrypto")
            let ih = item.contentSize.height
            let iFloat = CGFloat(i+1)
            item.position = CGPoint.init(x: 0, y: sliderH - ih * iFloat)
            var itemChildren:Array = item.children
            for obj in itemChildren {
                editItem(obj, i)
                
            }
            pSlider.addChild(item)
        }
    }
    
    func editItem(_ lElement:Any, _ lIndex:Int){
        if let sprite = lElement as? CCSprite {
            if sprite.name.elementsEqual("light") {
                let img = sprite.children[0] as! CCSprite
                img.spriteFrame = CCSpriteFrame.init(imageNamed: "coinMarketCap/\(lListeItems[lIndex])")
            }
        }
        if let colorNode = lElement as? CCNodeColor {
            colorNode.color = CCColor(uiColor: UIColor(red: 40/255.0, green: 53/255.0, blue: 61/255.0, alpha: 1.0));
        }
        if let label = lElement as? CCLabelTTF {
            if label.name.elementsEqual("cryptoName") {
                label.string = lListeNomItems[lIndex]
            }
        }
    }
    
    func organizedCryptoDatas(){
        if let cryptoDatas = HttpRequest.sCryptoDataParsed["data"] as? NSDictionary{
            for(key,value) in cryptoDatas {
                if let cryptoData = value as? NSDictionary{
                    organizedCryptoData(cryptoData)
                    let index = ((lTemplateCrypto["rank"] as? Int)!) - 1
                    lTemplateCrypto["img"] = "\(lTemplateCrypto["name"]!).png"
                    lDataCrypto![index] = self.lTemplateCrypto!
                }
            }
        }
    }
    
    func organizedCryptoData(_ pCryptoData:NSDictionary){
        self.lTemplateCrypto = [:]
        for(key,value) in pCryptoData {
            let jsonKey = key as? String
            switch jsonKey {
            case "rank":
                self.lTemplateCrypto["rank"] = value
                break
            case "name":
                self.lTemplateCrypto["name"] = value
                break
            case "symbol" :
                self.lTemplateCrypto["shortName"] = value
                break
            case "total_supply" :
                self.lTemplateCrypto["total"] = value
                break
            case "price" :
                self.lTemplateCrypto["price"] = value
                break
            case "percent_change_7d" :
                self.lTemplateCrypto["change7"] = value
                break
            case "percent_change_24h" :
                self.lTemplateCrypto["change24"] = value
                break
            case "quotes" :
                let lTempData = unwrapJson(value)
                organizedCryptoData(lTempData)
                break
            case "USD" :
                let lTempData = unwrapJson(value)
                organizedCryptoData(lTempData)
                break
            default:
                break
            }
        }
    }
    
    func unwrapJson(_ data:Any) -> NSDictionary{
        let lDataToReturn = data as? NSDictionary
        return lDataToReturn!
    }
    //        var lTempItems:[String] = []
    //        var lTempNomItems:[String] = []
    //        for var i in 0..<lListeItems.count{
    //            for var j in 0..<lListeItems.count{
    //                let lItem:[String] = lListeItems[j].components(separatedBy: "+_+")
    //                if(Int(lItem[0]) == i){
    //                    let lNom:String = lItem[1].components(separatedBy: ".png")[0]
    //                    lTempNomItems.append(lNom)
    //                    lTempItems.append(lListeItems[j])
    //                }
    //            }
    //        }
    //        lListeItems = lTempItems
    //        lListeNomItems = lTempNomItems
    
    
}
