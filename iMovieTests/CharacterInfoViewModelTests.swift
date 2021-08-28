//
//  CharacterInfoViewModelTests.swift
//  iMovieTests
//
//  Created by Sajith Konara on 2021-08-28.
//

import XCTest
import RxSwift

@testable import iMovie

class CharacterInfoViewModelTests: XCTestCase {
    
    
    var sut:CharacterInfoViewModel?
    var bag:DisposeBag?
    
    override func setUpWithError() throws {
        bag = DisposeBag()
    }
    
    override func tearDownWithError() throws {
        bag = nil
        sut = nil
    }
    
    
    func testGetCharacterInfo(){
        self.sut = CharacterInfoViewModel(selectedEndpoint: URL(string: "https://swapi.dev/api/people/4/")!)
        let sut = self.sut!
        let bag = self.bag!
        let expect = XCTestExpectation(description: "Fetch chatacter info for valid endpoint")
        
        sut.error.asObservable().subscribe { error in
            XCTAssertNil(error.element!)
        }.disposed(by: bag)
        sut.name.asObservable().subscribe { name in
            XCTAssertNotNil(name.element!)
        }.disposed(by: bag)
        sut.birthYear.asObservable().subscribe { birthYear in
            XCTAssertNotNil(birthYear.element!)
        }.disposed(by: bag)
        sut.gender.asObservable().subscribe { gender in
            XCTAssertNotNil(gender.element!)
        }.disposed(by: bag)
        
        sut.getCharacterInfo(){
            expect.fulfill()
        }
        wait(for: [expect], timeout: 10.0)
    }
    
    func testGetCharacterInfoForInvalidURL(){
        self.sut = CharacterInfoViewModel(selectedEndpoint: URL(string: "https://swapi.dev/api/people/*/")!)
        let sut = self.sut!
        let bag = self.bag!
        let expect = XCTestExpectation(description: "Fetch chatacter info invalid endpoint")
        
        sut.error.asObservable().subscribe { error in
            XCTAssertNotNil(error.element!)
        }.disposed(by: bag)
        sut.name.asObservable().subscribe { name in
            XCTAssertNil(name.element!)
        }.disposed(by: bag)
        sut.birthYear.asObservable().subscribe { birthYear in
            XCTAssertNil(birthYear.element!)
        }.disposed(by: bag)
        sut.gender.asObservable().subscribe { gender in
            XCTAssertNil(gender.element!)
        }.disposed(by: bag)
        
        sut.getCharacterInfo(){
            expect.fulfill()
        }
        wait(for: [expect], timeout: 10.0)
    }
    
}
