//
//  ContentTableViewCell.swift
//  iMovie
//
//  Created by Sajith Konara on 2021-08-24.
//

import UIKit

class ContentTableViewCell: UITableViewCell {

    @IBOutlet weak var contentLabel: UILabel!
    
    
    func setContent(for content:String){
        contentLabel.text = content
    }
    
    
}
