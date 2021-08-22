//
//  UIHelper.swift
//  iMovie
//
//  Created by Sajith Konara on 2021-08-22.
//

import Foundation
import UIKit
import BRYXBanner

class UIHelper{
    
    private static func makeViewController(storyBoardName:String, viewControllerName:String) -> UIViewController {
        return UIStoryboard(name: storyBoardName, bundle: nil).instantiateViewController(withIdentifier: viewControllerName)
    }
    
    static func makeViewController<T:UIViewController>(in storyboard:UIConstants.StoryBoard = .Main,viewControllerName:UIConstants.StoryBoardID) -> T{
        return makeViewController(storyBoardName: storyboard.rawValue, viewControllerName: viewControllerName.rawValue) as! T
    }
    
    static func makeHomeNavigationController() -> UINavigationController{
        makeViewController(storyBoardName: UIConstants.StoryBoard.Main.rawValue, viewControllerName: UIConstants.StoryBoardID.HomeNC.rawValue) as! UINavigationController
    }
    
    static func hide(navigationController controller:UINavigationController?){
        if let navController = controller{
            navController.setNavigationBarHidden(true, animated: true)
        }
    }
    
    static func roundCorners(view :UIView, corners: UIRectCorner, radius: CGFloat){
        let path = UIBezierPath(roundedRect: view.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        view.layer.mask = mask
    }
    
    static func addCornerRadius(to view:UIView,withRadius radius:CGFloat = 4, withborder:Bool = false,using borderColor:CGColor = UIColor.black.cgColor){
        view.layer.cornerRadius = radius
        if (withborder){
            view.layer.borderWidth = 0.5
            view.layer.borderColor = borderColor
        }
    }
    
    private static func makeBanner(for error:Error) -> Banner{
        return Banner(title: error.title, subtitle: error.message, backgroundColor: .red)
    }
    
    static func showBanner(for error:Error){
        makeBanner(for: error).show()
    }
    
    static func showRetryBanner(for error:inout Error,onTap:@escaping (()->Void)) -> Banner{
        error.message += "Tap here to retry."
        let banner = UIHelper.makeBanner(for: error)
        banner.dismissesOnTap = true
        banner.dismissesOnSwipe = false
        banner.didTapBlock = onTap
        return banner
    }
    
}
