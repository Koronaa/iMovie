//
//  CharacterInfoViewModel.swift
//  iMovie
//
//  Created by Sajith Konara on 2021-08-28.
//

import Foundation
import RxSwift
import RxCocoa

class CharacterInfoViewModel{
    
    fileprivate let modelLayer = ModelLayerIMPL(networkLayer: NetworkLayerIMPL(), translationLayer: TranslationLayer())
    fileprivate let bag = DisposeBag()
    
    var selectedEndpoint:URL
    
    var error = PublishSubject<Error?>()
    var name = PublishSubject<String?>()
    var gender = PublishSubject<String?>()
    var birthYear = PublishSubject<String?>()
    
    init(selectedEndpoint:URL) {
        self.selectedEndpoint = selectedEndpoint
    }
    
    func getCharacterInfo(onComplete: (() -> ())? = nil){
        modelLayer.getCharacter(for: selectedEndpoint) { characterObservable in
            characterObservable.subscribe(onNext: { characterResponse,error in
                if error == nil{
                    self.name.onNext(characterResponse?.name ?? "N/A")
                    self.birthYear.onNext(characterResponse?.birthYear ?? "N/A")
                    self.gender.onNext(characterResponse?.gender.capitalized ?? "N/A")
                }
                self.error.onNext(error)
                onComplete?()
            }).disposed(by: self.bag)
        }
    }
}
