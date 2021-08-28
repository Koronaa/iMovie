//
//  HomeViewModelTests.swift
//  iMovieTests
//
//  Created by Sajith Konara on 2021-08-28.
//

import XCTest
@testable import iMovie

class HomeViewModelTests: XCTestCase {
    
    var sut:HomeViewModel?
    
    override func setUpWithError() throws {
        sut = HomeViewModel()
    }
    
    override func tearDownWithError() throws {
        sut = nil
    }
    
    func testFetchMovies(){
        let sut = self.sut!
        let expect = XCTestExpectation(description: "Fetch movies")
        sut.getMovies {
            XCTAssertNotNil(sut.movies.value)
            XCTAssertNil(sut.error.value)
            expect.fulfill()
        }
        wait(for: [expect], timeout: 10.0)
    }
}
