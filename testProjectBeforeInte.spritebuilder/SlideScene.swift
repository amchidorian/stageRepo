import Foundation

class SlideScene: CCNode, CCScrollViewDelegate {
    
    weak var _scrollView: CCScrollView!
    weak var _num1, _num2, _num3: CCSprite!
    weak var _btnCloseSlide: CCButton!
    weak var _btnOpenSlide: CCButton!
    weak var _logButton: CCNode!
    weak var _nodeBtnOpenSlide: CCNode!
    weak var _nodeBtnCloseSlide: CCNode!
    weak var _pagination: CCNode!
    weak var _pinScene: CCScene!
    var allPage:[CCSprite] = []
    var indexPage:Int!;
    
     func didLoadFromCCB(){
        _scrollView.delegate = self
        self.allPage  = [_num1,_num2,_num3]
        indexPage = 0
        self.displayImg()
        self._scrollView.visible = false;
        _logButton.animationManager.runAnimations(forSequenceNamed: "closeSlide")
    }
    

func closeSlide(){
    _logButton.animationManager.runAnimations(forSequenceNamed: "closeSlide")
}

func openSlide(){
    self._scrollView.visible = true;
    self.indexPage = Int(0);
    self._scrollView.horizontalPage = Int32(0)
    self.displayImg();
    _logButton.animationManager.runAnimations(forSequenceNamed: "openSlide")
}

func displayImg(){
    for n in 0...(allPage.count-1) {
        if indexPage == n {
            allPage[n].visible = true;
        } else {
            allPage[n].visible = false;
        }
    }
}

func scrollViewDidScroll(_ scrollView: CCScrollView!) {
    
    print("did scroll")
    print(indexPage)
    self.indexPage = Int(_scrollView!.horizontalPage);
    print(indexPage)
    self.displayImg();
}



}
