//
//  MovieInfoViewModel.swift
//  iMovie
//
//  Created by Sajith Konara on 2021-08-22.
//

import Foundation
import RxSwift
import RxCocoa

class MovieInfoViewModel{
    
    fileprivate let modelLayer = ModelLayerIMPL(networkLayer: NetworkLayerIMPL(), translationLayer: TranslationLayer())
    fileprivate let bag = DisposeBag()
    
    var movie:MovieInfo
    var character = BehaviorRelay<CharacterResponse?>(value: nil)
    var error = BehaviorRelay<Error?>(value: nil)
    
    let headerTitles:[String?] = [nil,nil,"Director","Producer","Released Date","Characters"]
    
    init(movie:MovieInfo) {
        self.movie = movie
    }
    
    var selectedCharacterEndpoint:URL?
    
    var posterURL:URL{
        return movie.posterURL
    }
    
    var title:String{
        return movie.title
    }
    
    var releasedYear:String{
        return movie.releaseDate.year
    }
    
    var releasedDate:String{
        return movie.releaseDate
    }
    
    var description:String{
        return movie.openingCrawl
    }
    
    var directorName:String{
        return movie.director
    }
    
    var producerInfo:String{
        return movie.producer
    }
    
    var chaaracterEndPoints:[String]{
        return movie.characterEndpoints
    }
    
    func setSelectedEndpoint(for index:Int){
        self.selectedCharacterEndpoint =  URL(string: chaaracterEndPoints[index])
    }
}
