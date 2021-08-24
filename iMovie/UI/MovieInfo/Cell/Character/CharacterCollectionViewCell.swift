//
//  CharacterCollectionViewCell.swift
//  iMovie
//
//  Created by Sajith Konara on 2021-08-22.
//

import UIKit

class CharacterCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    
     func setupUI(){
        UIHelper.circular(view: imageView)
        imageView.image = UIImage(named: "character")!
    }
    

}
