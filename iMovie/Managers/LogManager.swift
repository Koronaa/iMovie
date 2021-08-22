//
//  LogManager.swift
//  iMovie
//
//  Created by Sajith Konara on 2021-08-22.
//

import Foundation

func Log(_ message:String, file:String = #file , calledBy:String = #function){
    #if DEBUG
    let className = file.components(separatedBy: "/").last ?? ""
    print("LOG ==> \(className) ::: \(calledBy) ::: \(message)")
    #endif
}

