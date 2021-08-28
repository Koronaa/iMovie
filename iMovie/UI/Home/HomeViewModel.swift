//
//  HomeViewModel.swift
//  iMovie
//
//  Created by Sajith Konara on 2021-08-22.
//

import Foundation
import RxSwift
import RxCocoa

class HomeViewModel{
    
    fileprivate let modelLayer = ModelLayerIMPL(networkLayer: NetworkLayerIMPL(), translationLayer: TranslationLayer())
    fileprivate let bag = DisposeBag()
    
    var movies = BehaviorRelay<[MovieInfo]?>(value: nil)
    var error = BehaviorRelay<Error?>(value: nil)
    
    
    func getMovies(onComplete: (() -> ())? = nil){
        modelLayer.getMovies { movieResponseObservable in
            movieResponseObservable.subscribe(onNext: { movieResponse,error in
                if let movies = movieResponse?.results{
                    self.movies.accept(movies)
                }else{
                    self.error.accept(error)
                }
                onComplete?()
            }).disposed(by: self.bag)
        }
    }
    
}

