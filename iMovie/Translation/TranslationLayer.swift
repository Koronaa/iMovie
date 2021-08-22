//
//  TranslationLayer.swift
//  iMovie
//
//  Created by Sajith Konara on 2021-08-22.
//

import Foundation
import RxSwift

class TranslationLayer{
    
    fileprivate let decorder = JSONDecoder()
    
    func getMovies(from responseData:Data,onCompleted: @escaping (_ observable:Observable<(movieReponse:MoviesResponse?,error:Error?)>)->Void){
        do{
            let movieResponse = try decorder.decode(MoviesResponse.self, from: responseData)
            onCompleted(Observable.just((movieResponse,nil)))
            Log("\(movieResponse)")
        }catch(let e){
            Log(e.localizedDescription)
            onCompleted(Observable.just((nil,showTranslationError())))
        }
    }
    
    func getCharacter(from responseData:Data,onCompleted: @escaping (_ observable:Observable<(characterResponse:CharacterResponse?,error:Error?)>)->Void){
        do{
            let characterResponse = try decorder.decode(CharacterResponse.self, from: responseData)
            onCompleted(Observable.just((characterResponse,nil)))
            Log("\(characterResponse)")
        }catch(let e){
            Log(e.localizedDescription)
            onCompleted(Observable.just((nil,showTranslationError())))
        }
    }
    
    
    private func showTranslationError() -> Error{
        return Error(title: "Translation Error!", message: "Something went wrong while translating data.")
    }
}
