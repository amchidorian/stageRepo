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
        for _ in 0..<100{lDataCrypto.append([:])}
        organizeCryptoDatas()
        let children:[CCNode]! = _scrollViewCrypto!.children as? [CCNode]
        let slider = children[0]
        createSliderLine(slider)
        
    }
    
    func createSliderLine(_ pSlider:CCNode){
        let item:CCNode = CCBReader.load("ItemCrypto")
        let ih = item.contentSize.height
        pSlider.contentSize.height = ih * 100
        let sliderH = pSlider.contentSize.height
        for var i in 0..<lDataCrypto.count{
            var item:CCNode = CCBReader.load("ItemCrypto")
            var iFloat = CGFloat(i+1)
            item.position = CGPoint.init(x: 0, y: sliderH - ih * iFloat)
            var itemChildren:Array = item.children
            for obj in itemChildren {
                editItem(obj, i)
            }
            pSlider.addChild(item)
        }
    }
    
    func editItem(_ lElement:Any, _ lIndex:Int){
        print(lDataCrypto![lIndex])
        if let sprite = lElement as? CCSprite {
            if sprite.name.elementsEqual("light") {
                let img = sprite.children[0] as! CCSprite
                print(lDataCrypto![lIndex]["img"]!)
                img.spriteFrame = CCSpriteFrame.init(imageNamed: "coinMarketCap/\(lDataCrypto![lIndex]["img"]!)")
            }
        }
        if let colorNode = lElement as? CCNodeColor {
            colorNode.color = CCColor(uiColor: UIColor(red: 40/255.0, green: 53/255.0, blue: 61/255.0, alpha: 1.0));
        }
        if let label = lElement as? CCLabelTTF {
            if label.name.elementsEqual("cryptoName") {
                label.string = lDataCrypto![lIndex]["name"]! as? String
            }
            if label.name.elementsEqual("shortName") {
                label.string = lDataCrypto![lIndex]["shortName"]! as? String
            }
            if label.name.elementsEqual("value") {
                label.string = lDataCrypto![lIndex]["price"]! as? String
            }
            if label.name.elementsEqual("percent") {
                label.string = lDataCrypto![lIndex]["change7"]! as? String
            }
        }
    }
    
    func organizeCryptoDatas(){
        if let cryptoDatas = HttpRequest.sCryptoDataParsed["data"] as? NSDictionary{
            for(_,value) in cryptoDatas {
                self.lTemplateCrypto = [:]
                if let cryptoData = value as? NSDictionary{
                    organizeCryptoData(cryptoData)
                    let index = ((lTemplateCrypto["rank"] as? Int)!) - 1
                    lTemplateCrypto["img"] = "\(lTemplateCrypto["name"]!).png"
                    lDataCrypto![index] = self.lTemplateCrypto!
                }
            }
        }
    }
    
    func organizeCryptoData(_ pCryptoData:NSDictionary){
        for(key,value) in pCryptoData {
            let jsonKey = key as? String
            print(jsonKey)
            switch jsonKey {
            case "rank":
                self.lTemplateCrypto["rank"] = value
                print(lTemplateCrypto)
                break
            case "name":
                self.lTemplateCrypto["name"] = value
                print(lTemplateCrypto)
                break
            case "symbol" :
                self.lTemplateCrypto["symbol"] = value
                print(lTemplateCrypto)
                break
            case "total_supply" :
                self.lTemplateCrypto["total"] = value
                print(lTemplateCrypto)
                break
            case "price" :
                self.lTemplateCrypto["price"] = value
                print(lTemplateCrypto)
                break
            case "percent_change_7d" :
                self.lTemplateCrypto["change7"] = value
                print(lTemplateCrypto)
                break
            case "percent_change_24h" :
                self.lTemplateCrypto["change24"] = value
                print(lTemplateCrypto)
                break
            case "quotes" :
                let lTempData = unwrapJson(value)
                organizeCryptoData(lTempData)
                print(lTemplateCrypto)
                break
            case "USD" :
                let lTempData = unwrapJson(value)
                organizeCryptoData(lTempData)
                print(lTemplateCrypto)
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
    
}
