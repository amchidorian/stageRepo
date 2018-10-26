import Foundation

class MainScene : CCNode{

    
    func didLoadFromCCB(){
        
    }
    
    // Func redirecting toward the PinCode
    // Watch if a PinCode is already store in sFinalPinCode.
    func goToPin(){
        if PinScene.sFinalPinCode == nil{
            PinScene.sStep = 1;
            let gameplayScene = CCBReader.load(asScene:"PinScene")
            let transition = CCTransition(fadeWithDuration: 1.0)
            CCDirector.shared().present(gameplayScene, with: transition)
        }else{
            let gameplayScene = CCBReader.load(asScene:"MenuPinScene")
            let transition = CCTransition(fadeWithDuration: 1.0)
            CCDirector.shared().present(gameplayScene, with: transition)
        }
    }
    
    //Func redirecting toward the HomeSlide
    func goToSlide(){
        let gameplayScene = CCBReader.load(asScene:"SlideScene")
        let transition = CCTransition(fadeWithDuration: 1.0)
        CCDirector.shared().present(gameplayScene, with:
            transition)
    }
    
    //Func redirecting toward the CryptoSlide
    func goToSlideCrypto(){
        let gameplayScene = CCBReader.load(asScene:"CryptoScene")
        let transition = CCTransition(fadeWithDuration: 1.0)
        CCDirector.shared().present(gameplayScene, with:
            transition)
    }
}
