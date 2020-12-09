//
//  Book.swift
//  Test_Task


import Foundation
import ObjectMapper

class Book: Mappable {
    var title: String?
    var author: String?
    var publisher: String?
    var language: String?
    var pages: Int?
    var identifier: String?
    var year: Int?
    var edition: Int?
    var library: String?
    var bookmarked: String?
    
    required init?(map: Map){

    }
    
    func mapping(map: Map) {
        title      <- map["title"]
        author     <- map["author"]
        publisher  <- map["publisher"]
        language   <- map["language"]
        pages      <- map["pages"]
        identifier <- map["identifier"]
        year       <- map["year"]
        edition    <- map["edition"]
        library    <- map["library"]
        bookmarked <- map["bookmarked"]
    }
}
