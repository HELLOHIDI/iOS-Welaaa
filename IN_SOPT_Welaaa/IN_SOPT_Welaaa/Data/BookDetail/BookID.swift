//
//  BookID.swift
//  IN_SOPT_Welaaa
//
//  Created by 류희재 on 2022/11/25.
//

import Foundation

struct BookID: Codable {
    let book: [BookIDData]
}

struct BookIDData: Codable {
    let id: Int
    let title: String
    let image: String
    let description: String
    let author: String
}

