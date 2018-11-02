//
//  PinScene.swift
//  ze iOS
//
//  Created by Dorian Pikcio on 19/10/2018.
//  Copyright © 2018 Apportable. All rights reserved.
//

import Foundation

class PinScene: CCNode {
    
    // Variable Locale
    var lCreatePin:[Int] = []
    var lValidatePin:[Int] = []
    var lUpdatePin:[Int] = []
    var lPinNumber:Int!;
    var lDigitIcons:[CCSprite] = []
    var lPinLength:Int = 4
    
    // Variable Statique
    static var sFinalPinCode:[Int]!
    static var sStep:Int!;
    
    //Variable de Design
    weak var _label:CCLabelTTF!
    weak var _labelSecondStep:CCLabelTTF!
    weak var _clippingNode:CCClippingNode!
    weak var _myCircle:CCSprite!
    weak var _digit1, _digit2, _digit3, _digit4: CCSprite!
    
    // Init
     func didLoadFromCCB(){
        lDigitIcons = [_digit1, _digit2, _digit3, _digit4]
        hideDigit()
        setLabel()
        _clippingNode.stencil = _myCircle;
        _clippingNode.alphaThreshold = 0.25;
    }
    
    // Method called by a click on a pin button
    func btnClick(_ pSender:CCButton){
        getNumberPressed(pSender.name)
        pSender.animationManager.runAnimations(forSequenceNamed: "btnClick" + String(lPinNumber))
        switch PinScene.sStep {
            case 1:
                if lCreatePin.count < lPinLength {
                    managePinCodeStepCreate(lPinNumber)
                }
            break
            case 2:
                if lValidatePin.count < lPinLength {
                    managePinCodeStepValidate(lPinNumber)
                }
            break
            case 3 :
                if lCreatePin.count < lPinLength {
                    managePinCodeStepUpdate(lPinNumber)
                }
            break
            default:
                btnCancel()
        }
    }
    
    // Method called by a click on the Clear Button
    func btnCancel(){
        PinScene.sStep = PinScene.sStep == 2 ? 1 : PinScene.sStep
        setLabel()
        hideDigit()
        lCreatePin = []
        lValidatePin = []
    }
    
    // func managing the code pin for the creating step.
    internal func managePinCodeStepCreate(_ pNumber:Int){
        lCreatePin.append(pNumber)
        displayDigit(lCreatePin.count)
        if lCreatePin.count == lPinLength {
            scheduleOnce(#selector(switchStep), delay: 0.5)
        }
    }
    
    // func managing the code pin for the validating step.
    internal func managePinCodeStepValidate(_ pNumber:Int){
        lValidatePin.append(pNumber)
        displayDigit(lValidatePin.count)
        if lValidatePin.count == lPinLength {
            if lCreatePin == lValidatePin {
                PinScene.sFinalPinCode = lValidatePin
                closePinScene()
            } else {
                scheduleOnce(#selector(switchStep), delay: 0.5)
                lCreatePin = []
                lCreatePin = []
            }
        }else{
            displayDigit(lValidatePin.count)
        }
    }
    
    // func managing the code pin for the Update and Delete step.
    internal func managePinCodeStepUpdate(_ pNumber:Int){
        print(PinScene.sFinalPinCode)
        lUpdatePin.append(pNumber)
        displayDigit(lUpdatePin.count)
        if lUpdatePin.count == lPinLength {
            if lUpdatePin == PinScene.sFinalPinCode {
                scheduleOnce(#selector(switchStep), delay: 0.5)
            } else {
                btnCancel()
                lUpdatePin = []
            }
        }
    }
    
    // func that switch the step when a step end;
    internal func switchStep(){
        switch PinScene.sStep {
            case 1:
                PinScene.sStep = 2
            break
            case 2:
                PinScene.sStep = 1
            break
            case 3 :
                if PinMenuScene.sPinAction {
                    PinScene.sStep = 1
                } else {
                    PinScene.sFinalPinCode = nil
                    closePinScene()
                }
            break
            default:
                btnCancel()
        }
        setLabel()
        hideDigit()
    }
    
    // func that retrieve the number of the pressed button
    internal func getNumberPressed(_ pBtnName:String){
        for char in pBtnName {
            if let number = Int(String(char)) {
                lPinNumber = number
            }
        }
    }
    
    // Display the plain button when a user tap a btn.
    internal func displayDigit(_ pIndex:Int){
        for i in 0...(pIndex-1) {
            lDigitIcons[i].visible = true;
        }
    }
    
    // Hide all the plain button
    func hideDigit(){
        for i in 0...(lDigitIcons.count-1) {
            lDigitIcons[i].visible = false;
        }
    }
    
    // Func taht close the pinScene
    func closePinScene(){
        let lGameplayScene = CCBReader.load(asScene:"MainScene")
        let lTransition = CCTransition(fadeWithDuration: 1.0)
        CCDirector.shared().present(lGameplayScene, with: lTransition)
    }
    
    // Method that update the label based on the static var sStep
    internal func setLabel(){
        switch PinScene.sStep {
        case 1:
            _label.string = "ENTER YOUR CODE PIN"
        break
        case 2:
            _label.string = "VALID YOUR CODE PIN"
        break
        case 3 :
            _label.string = "ENTER YOUR CURRENT CODE PIN"
        break
        default:
            _label.string = "ERROR"
        }
    }
}
