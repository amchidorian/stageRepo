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
    var lDataCryptoAlphabet:Array<[String:Any]>! = []
    var lTemplateCrypto:[String:Any]!
    var lSlider:CCNode!
    var lItemCryptoList:CCNode! = CCBReader.load("ItemCrypto")
    var lItemCryptoGrid:CCNode! = CCBReader.load("ItemCryptoGrid")
    var lNbItemOnSlider:CGFloat = 100
    var lItemHeight:CGFloat!
    var lOptions:Bool = true
    
    //Variable Design
    weak var _crypto1: CCNode!
    weak var _optionsNode:CCNode!
    weak var _scrollViewCrypto:CCScrollView!
    weak var _alphaPlain:CCSprite!
    weak var _favPlain:CCSprite!
    weak var _gridItem:CCSprite!
    weak var _listItem:CCSprite!
    weak var _deviseLabel:CCLabelTTF!
    
    // Variable Static
    static var sAlphabet:Bool = false
    static var sDollars:Bool = true
    static var sList = true
    static var sFav = false
    
    
    
    func didLoadFromCCB(){
        _scrollViewCrypto.delegate = self
        let parentSlider:[CCNode]! = (_scrollViewCrypto!.children as? [CCNode])
        lSlider = parentSlider[0]
        for _ in 0..<100{lDataCrypto.append([:])}
        for _ in 0..<100{lDataCryptoAlphabet.append([:])}
        organizeCryptoDatas()
        alphabeticSort()
        createSlider()
    }
    
    func alphaView(){
        SliderCryptoScene.sAlphabet = !SliderCryptoScene.sAlphabet
        if SliderCryptoScene.sAlphabet {
            _alphaPlain.opacity = 0.8
        } else {
            _alphaPlain.opacity = 0.5
        }
       createSlider()
    }

    func scrollViewDidScroll(_ _scrollViewCrypto: CCScrollView!) {
        let lScrollPositionY = _scrollViewCrypto.scrollPosition.y;
        if lOptions {
            if lScrollPositionY > 600 {
                _optionsNode.animationManager.runAnimations(forSequenceNamed: "hideOptions")
                lOptions = !lOptions
            }
        }
        if !lOptions {
            if lScrollPositionY < 600 {
                _optionsNode.animationManager.runAnimations(forSequenceNamed: "displayOptions")
                lOptions = !lOptions
            }
        }
    }
    
    func changeView(){
        SliderCryptoScene.sList = !SliderCryptoScene.sList
        lNbItemOnSlider = SliderCryptoScene.sList ? 100 : 34
        createSlider()
    }
    
    func changeDevise(){
        SliderCryptoScene.sDollars = !SliderCryptoScene.sDollars
        _deviseLabel.string = SliderCryptoScene.sDollars ? "€" : "$"
        createSlider()
    }
    
    func detailView(_ pSender:CCButton){
        print(pSender.name)
    }
    
    func createSlider(){
        lSlider.removeAllChildren()
        lItemHeight = SliderCryptoScene.sList ? lItemCryptoList.contentSize.height : lItemCryptoGrid.contentSize.height
        lSlider.contentSize.height = lItemHeight * lNbItemOnSlider
        if SliderCryptoScene.sList {
            createSliderList()
        } else {
            createSliderGrid()
        }
    }

    func createSliderList(){
        for var i in 0..<lDataCrypto.count{
            var item:CCNode = CCBReader.load("ItemCrypto")
            item.position = CGPoint.init(x: 0, y: lItemHeight * lNbItemOnSlider - lItemHeight * CGFloat(i+1))
            var itemChildren:Array = item.children
            for obj in itemChildren {
                editItem(obj, i)
            }
            lSlider.addChild(item)
        }
    }

    func createSliderGrid(){
        var posIndex = 0;
        for i in stride(from: 0, to: lDataCrypto.count, by: 3) {
            var tempi = i
            var item:CCNode = CCBReader.load("ItemCryptoGrid")
            item.position = CGPoint.init(x: 0, y: lItemHeight * 34 - lItemHeight * CGFloat(posIndex+1))
            var itemChildrens:Array = item.children
            for itemChildren in itemChildrens {
                print(tempi)
                if tempi + 1 > lDataCrypto.count {
                    print("error")
                    (itemChildren as! CCNode).visible = false
                } else {
                    var itemChildrenChildrens:Array = (itemChildren as! CCNode).children
                    for itemChildrenChildren in itemChildrenChildrens {
                        editItem(itemChildrenChildren, tempi)
                    }
                    tempi = tempi+1
                }
            }
            lSlider.addChild(item)
            posIndex = posIndex + 1
        }
    }
    
    func editItem(_ lElement:Any, _ lIndex:Int){
        var lCryptoData = SliderCryptoScene.sAlphabet ? lDataCryptoAlphabet![lIndex] : lDataCrypto![lIndex]
        if let sprite = lElement as? CCSprite {
            if sprite.name.elementsEqual("light") {
                let img = sprite.children[0] as! CCSprite
                img.spriteFrame = CCSpriteFrame.init(imageNamed: "coinMarketCap/\(lCryptoData["img"]!)")
            }
        }
        if let colorNode = lElement as? CCNodeColor {
            colorNode.color = CCColor(uiColor: UIColor(red: 40/255.0, green: 53/255.0, blue: 61/255.0, alpha: 1.0));
        }
        if let btn = lElement as? CCButton {
            btn.name = "\(lCryptoData["rank"]!)";
            btn.setTarget(self, selector: #selector(detailView))
        }
        if let label = lElement as? CCLabelTTF {
            if label.name.elementsEqual("cryptoName") {
                label.string = "\(lCryptoData["name"]!)"
            }
            if label.name.elementsEqual("shortName") {
                label.string = "\(lCryptoData["symbol"]!)"
            }
            if label.name.elementsEqual("value") {
                let lPrice = SliderCryptoScene.sDollars ? lCryptoData["price"]! : (lCryptoData["price"]! as! CGFloat) * CGFloat(0.88)
                label.string = SliderCryptoScene.sDollars ? "$ \(lPrice)" : "\(lPrice) €"
            }
            if label.name.elementsEqual("percent") {
                let floatPercent = (lCryptoData["change7"]! as! NSNumber).floatValue
                label.string = "\(floatPercent)"
                if floatPercent > 0 {
                    label.color = CCColor(uiColor: UIColor(red: 0, green: 1, blue: 0, alpha: 1.0));
                } else if floatPercent < 0 {
                    label.color = CCColor(uiColor: UIColor(red: 1, green: 0, blue: 0, alpha: 1.0));
                }
            }
        }
    }
    
    func organizeCryptoDatas(){
        let cryptoDatas = unwrapJson(HttpRequest.sCryptoDataParsed!["data"]!)
        for(_,value) in cryptoDatas {
            self.lTemplateCrypto = [:]
            let cryptoData = unwrapJson(value)
            organizeCryptoData(cryptoData)
            let index = ((lTemplateCrypto["rank"] as? Int)!) - 1
            lTemplateCrypto["img"] = "\(lTemplateCrypto["name"]!).png"
            lDataCrypto![index] = self.lTemplateCrypto!
        }
    }
    
    func organizeCryptoData(_ pCryptoData:NSDictionary){
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
                self.lTemplateCrypto["symbol"] = value
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
                organizeCryptoData(lTempData)
                break
            case "USD" :
                let lTempData = unwrapJson(value)
                organizeCryptoData(lTempData)
                break
            default:
                break
            }
        }
    }
    
    func unwrapJson(_ data:Any) -> NSDictionary{
        if let lDataToReturn = data as? NSDictionary {
            return lDataToReturn
        } else {
            return [:]
        }
    }
    
    func alphabeticSort(){
        lDataCryptoAlphabet = lDataCrypto
        lDataCryptoAlphabet.sort {
            let lDataCryptoAlphabetA = ($0.0["name"] as! String).lowercased()
            let lDataCryptoAlphabetB = ($0.1["name"] as! String).lowercased()
            
            return lDataCryptoAlphabetA < lDataCryptoAlphabetB
        }
    }
    
}
