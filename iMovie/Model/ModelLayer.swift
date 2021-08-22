//
//  ModelLayer.swift
//  iMovie
//
//  Created by Sajith Konara on 2021-08-22.
//

import Foundation
import RxSwift

typealias MoviesResponseBlock = (Observable<(MoviesResponse?,Error?)>)->Void
typealias CharacterResponseBlock = (Observable<(CharacterResponse?,Error?)>)->Void

protocol ModelLayer {
    func getMovies(onCompleted: @escaping MoviesResponseBlock)
    func getCharacter(for endpoint:URL,onCompleted: @escaping CharacterResponseBlock)
}


class ModelLayerIMPL:ModelLayer{
    
    fileprivate let networkLayer:NetworkLayerIMPL
    fileprivate let translationLayer:TranslationLayer
    fileprivate let bag = DisposeBag()
    
    init(networkLayer:NetworkLayerIMPL,translationLayer:TranslationLayer) {
        self.networkLayer = networkLayer
        self.translationLayer = translationLayer
    }
    
    func getMovies(onCompleted: @escaping MoviesResponseBlock) {
        let url = URL(string: URLConstants.Api.Path.getMovies)!
        networkLayer.getResponseJSON(for: url) { dataObservable in
            dataObservable.subscribe(onNext: { data,error in
                if let responseData = data{
                    self.translationLayer.getMovies(from: responseData) { movieResponseObservable in
                        movieResponseObservable.subscribe(onNext: { movieResponse,error in
                            if let movies = movieResponse{
                                onCompleted(Observable.just((movies,nil)))
                            }else{
                                onCompleted(Observable.just((nil,error)))
                            }
                        }).disposed(by: self.bag)
                    }
                }else{
                    onCompleted(Observable.just((nil,error)))
                }
            }).disposed(by: self.bag)
        }
    }
    
    func getCharacter(for endpoint: URL, onCompleted: @escaping CharacterResponseBlock) {
        networkLayer.getResponseJSON(for: endpoint) { dataObservable in
            dataObservable.subscribe(onNext: { data,error in
                if let responseData = data{
                    self.translationLayer.getCharacter(from: responseData) { characterResponseObservable in
                        characterResponseObservable.subscribe(onNext: { characterResponse,error in
                            if let character = characterResponse{
                                onCompleted(Observable.just((character,nil)))
                            }else{
                                onCompleted(Observable.just((nil,error)))
                            }
                        }).disposed(by: self.bag)
                    }
                }else{
                    onCompleted(Observable.just((nil,error)))
                }
            }).disposed(by: self.bag)
        }
    }
    
    
    
    
    
    
}
