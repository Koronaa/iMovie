//
//  MovieTableViewCell.swift
//  iMovie
//
//  Created by Sajith Konara on 2021-08-22.
//

import UIKit
import Kingfisher

class MovieTableViewCell: UITableViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieYearLabel: UILabel!
    
    
    var movieInfo:MovieTableViewCellViewModel!{
        didSet{
            DispatchQueue.main.async {
                self.setupUI()
                self.movieImageView.kf.setImage(with: self.movieInfo.imageURL)
                self.movieTitleLabel.text = self.movieInfo.name
                self.movieYearLabel.text = self.movieInfo.year
            }
        }
    }
    
    private func setupUI(){
        UIHelper.addCornerRadius(to: containerView,withRadius: 15.0)
        UIHelper.roundCorners(view: movieImageView, corners: [.topLeft,.topRight], radius: 15.0)
    }
    
}
