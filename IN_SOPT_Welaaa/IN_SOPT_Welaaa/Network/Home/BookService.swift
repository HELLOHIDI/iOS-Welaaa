//
//  BookService.swift
//  IN_SOPT_Welaaa
//
//  Created by 류희재 on 2022/11/25.
//

import Foundation

import Moya

enum BookService {
    case getBook
    case getBookDetail(bookId: Int)
}

extension BookService: TargetType {
    var baseURL: URL {
        return URL(string: URLs.baseURL)!
    }
    
    var path: String {
        switch self {
        case .getBook:
            return URLs.book
        case .getBookDetail(let bookId):
            return URLs.bookDetail.replacingOccurrences(of: "{bookId}", with: "\(bookId)")
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getBook:
            return .get
        case .getBookDetail:
            return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .getBook:
            return .requestPlain
        case .getBookDetail(let bookId):
            return .requestParameters(parameters: ["bookId": bookId], encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String: String]? {
        switch self {
        case .getBook, .getBookDetail:
            return [
                "Content-Type": "application/json"
            ]
        }
    }
}

