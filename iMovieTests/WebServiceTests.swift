//
//  WebServiceTests.swift
//  iMovieTests
//
//  Created by Sajith Konara on 2021-08-22.
//

import XCTest
import RxSwift
@testable import iMovie

class WebServiceTests: XCTestCase {
    
    var sut:ModelLayerIMPL?
    var bag:DisposeBag?
    var timeout:TimeInterval = 5.0
    
    override func setUpWithError() throws {
        sut = ModelLayerIMPL(networkLayer: NetworkLayerIMPL(), translationLayer: TranslationLayer())
        bag = DisposeBag()
    }
    
    override func tearDownWithError() throws {
        sut = nil
        bag = nil
    }
    
    func testFetchMovies(){
        let sut = self.sut!
        let expect = XCTestExpectation(description: "Fetch Movies")
        
        sut.getMovies(onCompleted: { movieObservable in
            expect.fulfill()
            XCTAssertNotNil(movieObservable)
            movieObservable.subscribe(onNext: { movieResponse,error in
                XCTAssertNotNil(movieResponse)
                XCTAssertNil(error)
                expect.fulfill()
            }).disposed(by: self.bag!)
        })
        wait(for: [expect], timeout: timeout)
    }
    
    func testFetchCharacterInfo(){
        let sut = self.sut!
        let expect = XCTestExpectation(description: "Fetch 1st movie's 1st character info")
        sut.getMovies(onCompleted: { movieObservable in
            XCTAssertNotNil(movieObservable)
            movieObservable.subscribe(onNext: { movieResponse,error in
                XCTAssertNotNil(movieResponse)
                XCTAssertNil(error)
                let firstMovie = movieResponse?.results?.first
                XCTAssertNotNil(firstMovie)
                let firstCharacterEndpoint = firstMovie?.characterEndpoints.first
                XCTAssertNotNil(firstCharacterEndpoint)
                let url = URL(string: firstCharacterEndpoint!)!
                sut.getCharacter(for: url) { characterObservable in
                    expect.fulfill()
                    characterObservable.subscribe(onNext: { characterResponse,error in
                        XCTAssertNotNil(characterResponse)
                        XCTAssertNil(error)
                        expect.fulfill()
                    }).disposed(by: self.bag!)
                }
            }).disposed(by: self.bag!)
        })
        wait(for: [expect], timeout: timeout)
    }
    
}
