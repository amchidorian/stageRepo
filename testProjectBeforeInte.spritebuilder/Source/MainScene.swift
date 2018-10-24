import Foundation

class MainScene : CCNode{

    
    func didLoadFromCCB(){
        let fm:FileManager = FileManager.default
        let path = Bundle.main.resourcePath!
        
        do {
            let items = try fm.contentsOfDirectory(atPath: "\(path)/Published-iOS/coinMarketCap/resources-phonehd")
            
            for item in items {
                print("Found \(item)")
            }
        } catch {
            // failed to read directory – bad permissions, perhaps?
        }
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
