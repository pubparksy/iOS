//
//  Book.swift
//  BookFinderWithCodable
//
//  Created by sy on 10/22/24.
//

import Foundation

// Api 명세에서 지정한 key:value 형태의 key와 _ 까지 동일한 이름이어야 함.
// 사용 안할 key면 안 써도 됨

struct Book:Codable {
    let title:String
    let publisher:String
    let authors:[String]
    let thumbnail:String
    let price:Int
    let status:String
    let url: String
}


// api가 제공하는 Key의 이름이 != 플젝 필드명과 적합하지 않아서, 바꾸고 싶다면 enum 사용

//struct Meta:Codable {
//    let is_end:Bool
//    let pageable_count:Int
//    let total_count:Int
//}

struct Meta:Codable {
    let isEnd:Bool
    let pageableCount:Int
    let totalCount:Int
    
    enum CodingKeys:String, CodingKey {  // CodingKeys = 예약어. 정해진 규칙이라 이렇게 적기
        case isEnd = "is_end"
        case pageableCount = "pageable_count"
        case totalCount = "total_count"
    }
}



//struct Master:Codable {
//    let meta:Meta
//    let documents:[Book]
//}

struct Master:Codable {
    let meta:Meta
    let books:[Book]
    enum CodingKeys:String, CodingKey {
        case meta
        case books = "documents"
    }
}
