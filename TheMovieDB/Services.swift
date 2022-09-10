//
//  Services.swift
//  TheMovieDB
//
//  Created by Lucas on 11/08/2022.
//

import Foundation
import Alamofire
class MovieListService {
    
    var onCompleteFunction: (([MovieDTO]) -> Void)?
    var onErrorFunction: ((String) -> Void)?
    
    func getMovies(onComplete: @escaping ([MovieDTO]) -> Void,
                     onError: @escaping (String) -> Void) {
        
        //me guardo las funciones en una variable
        self.onCompleteFunction = onComplete
        self.onErrorFunction = onError
        
        // Llamo una funcion, le paso la url a la que pegarle, y la funcion que debe ejecutar cuando llegue la respuesta
        ApiManager.shared.get(url: Constants().movieURL,
                                 success: processResponse)
    }
        
    func processResponse(response: (Result<Data?, AFError>)) -> Void {
        switch response {
        case Result.success(let data):
            self.processSuccessfulResponse(data: data)
        case Result.failure(let error):
            self.processFailedResponse(error: error)
        }
    }
    
    func processSuccessfulResponse(data: Data?) {
        do {
            if let data = data {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = . convertFromSnakeCase
                let movieResponse = try decoder.decode(MovieListDTO.self, from: data)
                self.onCompleteFunction?(movieResponse.results)
            }
        } catch {
            self.onErrorFunction?("fallo la conversión del json")
        }
    }
    
    func processFailedResponse(error: AFError?) {
        let errorDescription: String = error?.errorDescription ?? "unknown error"
        self.onErrorFunction?("Fallo en el apimanager: \(errorDescription)")
    }
    
}
