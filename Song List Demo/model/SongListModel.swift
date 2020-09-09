//
//  SongListModel.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on September 9, 2020

import Foundation
import UIKit
import ObjectMapper

//MARK: - SongListModel
public struct SongListModel: Mappable,Codable {

    var resultCount : Int?
    var results : [Result]?
    public init?(map: Map) {}
    init() {
    }
    mutating public func mapping(map: Map) {
       resultCount <- map["resultCount"]
       results <- map["results"]
    }

}
