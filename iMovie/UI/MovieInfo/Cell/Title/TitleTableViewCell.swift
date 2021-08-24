//
//  TitleTableViewCell.swift
//  iMovie
//
//  Created by Sajith Konara on 2021-08-24.
//

import UIKit

class TitleTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    
    
    func setContent(title:String,subTitle:String){
        titleLabel.text = title
        subtitleLabel.text = subTitle
    }
}
