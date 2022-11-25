//
//  BookAPI.swift
//  IN_SOPT_Welaaa
//
//  Created by 류희재 on 2022/11/25.
//

import Foundation

import Moya

public class BookAPI {
    
    static let shared = BookAPI()
    
    public init() { }
    
    var bookProvider = MoyaProvider<BookService>()
    
    func getBookList(completion: @escaping (NetworkResult<Any>) -> Void) {
        bookProvider.request(.getBook) { result in
            switch result {
            case.success(let response):
                
                let statusCode = response.statusCode
                let data = response.data
                
                let networkResult = self.judgeBookStatus(by: statusCode, data)
                completion(networkResult)
    
            case .failure(let err):
                print(err)
            }
        }
    }
    
    func getBookDetail(bookId: Int, completion: @escaping (NetworkResult<Any>) -> Void) {
        bookProvider.request(.getBookDetail(bookId: bookId)) { result in
            switch result {
            case.success(let response):
                
                
                let statusCode = response.statusCode
                let data = response.data
                
                
                let networkResult = self.judgeBookDetailStatus(by: statusCode, data)
                completion(networkResult)
                
                print(1111, networkResult)
    
            case .failure(let err):
                print(err)
            }
        }
    }
    
    private func judgeBookStatus(by statusCode: Int, _ data: Data) -> NetworkResult<Any> {
        let decoder = JSONDecoder()
        
        guard let decodedData = try? decoder.decode(GenericResponse<[BookData]>.self, from: data) else {
            return .pathErr
        }
        
        switch statusCode {
        case 200:
            return .success(decodedData.data as Any)
        case 400..<500:
            return .requestErr(decodedData.message as Any)
        case 500:
            return .serverErr
        default:
            return .networkFail
        }
    }
    
    private func judgeBookDetailStatus(by statusCode: Int, _ data: Data) -> NetworkResult<Any> {
        let decoder = JSONDecoder()
        
        guard let decodedData = try? decoder.decode(GenericResponse<[BookIDData]>.self, from: data) else {
            return .pathErr
        }
        
        switch statusCode {
        case 200:
            return .success(decodedData.data as Any)
        case 400..<500:
            return .requestErr(decodedData.message as Any)
        case 500:
            return .serverErr
        default:
            return .networkFail
        }
    }
}


