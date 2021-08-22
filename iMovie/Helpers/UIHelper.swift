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
    
    private static func makeBanner(for error:Error) -> Banner{
        return Banner(title: error.title, subtitle: error.message, backgroundColor: .red)
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
