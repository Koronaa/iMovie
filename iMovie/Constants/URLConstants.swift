//
//  URLConstants.swift
//  iMovie
//
//  Created by Sajith Konara on 2021-08-22.
//

import Foundation
struct URLConstants {
    

    struct Api {
        static let HOST = "https://swapi.dev/api"
        
        struct Path {
            
            static var getMovies:String{
                return HOST + "/films/"
            }
        }
    }
}
