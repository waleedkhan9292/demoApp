//
//  HomeController.swift
//  Wapp
//
//  Created by Macbook on 4/5/18.
//  Copyright © 2018 Macbook. All rights reserved.
//

import UIKit
import SDWebImage
import CoreLocation
class HomeController: UIViewController  {

//    var uiViewSideMenu : SideMenuController!
    var uiViewContoller : UIViewController!
    var viewControllers : NSArray = []
    var mediaType = ""
    
    @IBOutlet weak var uvSideMenu: UIView!
    @IBOutlet weak var uvContainer: UIView!
    
    // MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        setViewDidLoad()
    }
    
    // MARK: - Buttons Actions
    
    // MARK: - Functions
    private func setViewDidLoad() {
        uvSideMenu.alpha=0
        self.navigationController?.isNavigationBarHidden = true
        viewControllers=["HomeMapController"]
        self.changeHomeController(parrent: self, identifier: viewControllers[0] as! String)
        
    }
    
    func buttonsNot(menu: UIButton,back: UIButton,findAndRecovery: UIView,bookAndQueue:UIView) {
        menu.isHidden = !menu.isHidden
        back.isHidden = !back.isHidden
        findAndRecovery.isHidden = !findAndRecovery.isHidden
        bookAndQueue.isHidden = !bookAndQueue.isHidden
    }
    
    func changeHomeController(parrent: UIViewController,identifier:String)
    {
        let viewController=self.storyboard?.instantiateViewController(withIdentifier: identifier)
        if(uiViewContoller != nil) {
            uiViewContoller.willMove(toParent: nil)  // 1
            uiViewContoller.view.removeFromSuperview()
            uiViewContoller.removeFromParent()
        }
        if(viewController != nil) {
            addChild(viewController!)
            uvContainer.addSubview((viewController?.view)!)
            self.constrainViewEqual(holderView: uvContainer, view: (viewController?.view)!)
            viewController?.didMove(toParent: self)
            viewController?.willMove(toParent: self)
            uiViewContoller=viewController
            CommonMethod.fadeIn(view: uvContainer)
            
            if(uiViewContoller .isKind(of: HomeMapController.self))
            {
                (uiViewContoller as! HomeMapController).parrent=self
            }
        }
    }
    
    func openMenu(parrent: UIViewController)
    {
        let viewController=self.storyboard?.instantiateViewController(withIdentifier: "SideMenuController")
        if(viewController != nil)
        {
            addChild(viewController!)
            uvSideMenu.addSubview((viewController?.view)!)
            self.constrainViewEqual(holderView: uvSideMenu, view: (viewController?.view)!)
            viewController?.didMove(toParent: self)
            viewController?.willMove(toParent: self)
            uvSideMenu.alpha=1
            CommonMethod.swipeLeftToRight(view: uvSideMenu)
        }
    }
    
    func constrainViewEqual(holderView: UIView, view: UIView) {
        view.translatesAutoresizingMaskIntoConstraints = false
        //pin 100 points from the top of the super
        let pinTop = NSLayoutConstraint(item: view, attribute: .top, relatedBy: .equal,
                                        toItem: holderView, attribute: .top, multiplier: 1.0, constant: 0)
        let pinBottom = NSLayoutConstraint(item: view, attribute: .bottom, relatedBy: .equal,
                                           toItem: holderView, attribute: .bottom, multiplier: 1.0, constant: 0)
        let pinLeft = NSLayoutConstraint(item: view, attribute: .left, relatedBy: .equal,
                                         toItem: holderView, attribute: .left, multiplier: 1.0, constant: 0)
        let pinRight = NSLayoutConstraint(item: view, attribute: .right, relatedBy: .equal,
                                          toItem: holderView, attribute: .right, multiplier: 1.0, constant: 0)
        
        holderView.addConstraints([pinTop, pinBottom, pinLeft, pinRight])
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "HomeToMusicListSegue" {
            if let vc = segue.destination as? ItunesListController {
                vc.mediaType = mediaType
            }
        }
    }

}
