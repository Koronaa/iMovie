//
//  UIConstants.swift
//  iMovie
//
//  Created by Sajith Konara on 2021-08-22.
//

import Foundation

class UIConstants{
    
    enum StoryBoardID:String{
        case HomeVC = "homeVC"
        case MovieInfoVC = "MovieInfoVC"
        case CharacterInfoVC = "CharacterInfoVC"
    }
    
    enum StoryBoard:String{
        case Main = "Main"
    }
    
    enum Cell:String{
        case MovieTableViewCell = "movieTVC"
        case ContentTableViewCell = "contentTVC"
        case CharacterCollectionViewCell = "characterCVC"
        case TitleTableViewCell = "titleTVC"
    }
}
