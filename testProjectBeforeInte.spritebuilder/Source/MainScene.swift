import Foundation

class MainScene : CCNode{

    
    func didLoadFromCCB(){
        
    }
    
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
    
    func goToSlide(){
        let gameplayScene = CCBReader.load(asScene:"SlideScene")
        let transition = CCTransition(fadeWithDuration: 1.0)
        CCDirector.shared().present(gameplayScene, with:
            transition)
    }
    
    func goToSlideCrypto(){
        let gameplayScene = CCBReader.load(asScene:"CryptoScene")
        let transition = CCTransition(fadeWithDuration: 1.0)
        CCDirector.shared().present(gameplayScene, with:
            transition)
    }
}
