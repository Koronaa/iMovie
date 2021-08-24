//
//  MovieCollectionViewCellViewModel.swift
//  iMovie
//
//  Created by Sajith Konara on 2021-08-22.
//

import Foundation

class MovieTableViewCellViewModel{
    
    let movie:MovieInfo
    
    init(movie:MovieInfo) {
        self.movie = movie
    }
    
    
    var name:String{
        return movie.title
    }
    
    var year:String{
        return movie.releaseDate.year
    }
    
    var imageURL:URL{
        return movie.posterURL
    }
    
}
