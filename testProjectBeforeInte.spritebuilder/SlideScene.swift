import Foundation

class SlideScene: CCNode, CCScrollViewDelegate {
    
    // Variable Locale
    var lAllPage:[CCSprite] = []
    var lIndexPage:Int!;
    
    //Variable de design
    weak var _scrollView: CCScrollView!
    weak var _num1, _num2, _num3: CCSprite!
    weak var _btnCloseSlide: CCButton!
    weak var _btnOpenSlide: CCButton!
    weak var _logButton: CCNode!
    weak var _nodeBtnOpenSlide: CCNode!
    weak var _nodeBtnCloseSlide: CCNode!
    weak var _pagination: CCNode!
    weak var _pinScene: CCScene!
    
    // init
    func didLoadFromCCB(){
        _scrollView.delegate = self
        self.lAllPage  = [_num1,_num2,_num3]
        lIndexPage = 0
        self.displayImg()
        self._scrollView.visible = false;
        _logButton.animationManager.runAnimations(forSequenceNamed: "closeSlide")
    }
 
    // Func closing the slide with the animation closeSlide
    func closeSlide(){
        _logButton.animationManager.runAnimations(forSequenceNamed: "closeSlide")
    }

    // Func opening the slide with the animation openSlide
    func openSlide(){
        self._scrollView.visible = true;
        self.lIndexPage = Int(0);
        self._scrollView.horizontalPage = Int32(0)
        self.displayImg();
        _logButton.animationManager.runAnimations(forSequenceNamed: "openSlide")
    }

    // Func detecting the slide page change.
    func scrollViewDidScroll(_ scrollView: CCScrollView!) {
    self.lIndexPage = Int(_scrollView!.horizontalPage);
    self.displayImg();
}
    
    // Func displaying the right image depending on the slide position
    // store in lIndexPage
    func displayImg(){
        for n in 0...(lAllPage.count-1) {
            if lIndexPage == n {
                lAllPage[n].visible = true;
            } else {
                lAllPage[n].visible = false;
            }
        }
    }
}
