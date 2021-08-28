//
//  MovieInfoViewModelTests.swift
//  iMovieTests
//
//  Created by Sajith Konara on 2021-08-28.
//

import XCTest
@testable import iMovie

class MovieInfoViewModelTests: XCTestCase {
    
    var movie:MovieInfo?
    var sut:MovieInfoViewModel?
    
    override func setUpWithError() throws {
        movie =  MovieInfo(title: "Test Movie", openingCrawl: "Test Description", director: "Test Director", producer: "Test Producer", releaseDate: "", characterEndpoints: ["https://swapi.dev/api/people/1/"])
        sut = MovieInfoViewModel(movie: movie!)
    }
    
    override func tearDownWithError() throws {
        sut = nil
        movie = nil
    }
    
    func testHelperMethods(){
        let sut = self.sut!
        XCTAssertNotNil(sut.posterURL)
        XCTAssertNotNil(sut.title)
        XCTAssertNotNil(sut.releasedYear)
        XCTAssertNotNil(sut.releasedDate)
        XCTAssertNotNil(sut.description)
        XCTAssertNotNil(sut.directorName)
        XCTAssertNotNil(sut.producerInfo)
        XCTAssertNotNil(sut.chaaracterEndPoints)
        sut.setSelectedEndpoint(for: 0)
        XCTAssertNotNil(sut.selectedCharacterEndpoint)
    }
}
