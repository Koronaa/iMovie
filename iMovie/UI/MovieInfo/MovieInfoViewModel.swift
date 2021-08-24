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
    
    //TODO:DI
    
    fileprivate let modelLayer = ModelLayerIMPL(networkLayer: NetworkLayerIMPL(), translationLayer: TranslationLayer())
    fileprivate let bag = DisposeBag()
    
    var movie:MovieInfo
    var character = BehaviorRelay<CharacterResponse?>(value: nil)
    var error = BehaviorRelay<Error?>(value: nil)
    
    var headerTitles:[String?] = [nil,nil,"Director","Producer","Released Date","Characters"]
    
    init(movie:MovieInfo) {
        self.movie = movie
    }
    
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
    
    var selectedCharacterEndpoint:String?
    
    
    func getEndpoint(for index:Int) -> URL{
        return URL(string: chaaracterEndPoints[index])!
    }
    
    func getCharacterInfo(for URL:URL){
        modelLayer.getCharacter(for: URL) { characterResponseObservable in
            characterResponseObservable.subscribe(onNext: { characterResponse,error in
                if let characterInfo = characterResponse{
                    self.character.accept(characterInfo)
                }else{
                    self.error.accept(error)
                }
            }).disposed(by: self.bag)
        }
    }
}
