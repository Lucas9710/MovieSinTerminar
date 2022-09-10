//
//  ApiManager.swift
//  TheMovieDB
//
//  Created by Lucas on 11/08/2022.
//

import Foundation
import Alamofire

class ApiManager {
    
    static let shared = ApiManager()
    
    func get(url : String, success : @escaping (Result<Data?, AFError>) -> Void){
        
        AF.request(url).response { response in
            success(response.result)
        }
    }
}
