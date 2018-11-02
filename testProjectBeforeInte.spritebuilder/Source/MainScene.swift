import Foundation

class MainScene : CCNode{
    
    func didLoadFromCCB(){
        HttpRequest().apiRequest("https://api.coinmarketcap.com/v2/ticker/")
    }
    
    // Func redirecting toward the PinCode
    // Watch if a PinCode is already store in sFinalPinCode.
    func goToPin(){
        if PinScene.sFinalPinCode == nil{
            PinScene.sStep = 1;
            let lGameplayScene = CCBReader.load(asScene:"PinScene")
            let lTransition = CCTransition(fadeWithDuration: 1.0)
            CCDirector.shared().present(lGameplayScene, with: lTransition)
        }else{
            let lGameplayScene = CCBReader.load(asScene:"MenuPinScene")
            let lTransition = CCTransition(fadeWithDuration: 1.0)
            CCDirector.shared().present(lGameplayScene, with: lTransition)
        }
    }
    
    //Func redirecting toward the HomeSlide
    func goToSlide(){
        let lGameplayScene = CCBReader.load(asScene:"SlideScene")
        let lTransition = CCTransition(fadeWithDuration: 1.0)
        CCDirector.shared().present(lGameplayScene, with:
            lTransition)
    }
    
    //Func redirecting toward the CryptoSlide
    func goToSlideCrypto(){
        let lGameplayScene = CCBReader.load(asScene:"CryptoScene")
        let lTransition = CCTransition(fadeWithDuration: 1.0)
        CCDirector.shared().present(lGameplayScene, with:
            lTransition)
    }
}
