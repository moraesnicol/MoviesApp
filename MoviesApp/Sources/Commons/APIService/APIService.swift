//
//  APIService.swift
//  MoviesApp
//
//  Created by Gabriel on 18/11/21.
//

import Foundation
import Alamofire


class APIService {
    
    typealias WebServiceMovie = (([Movie]?) -> Void)
    
    func fecthData(page: Int, withCompletion completion: @escaping WebServiceMovie ) {
        DispatchQueue.global().async  {
            let baseURL = "https://api.themoviedb.org/3/movie/now_playing?api_key=c2e78b4a8c14e65dd6e27504e6df95ad&language=pt-BR&page="
            let pageResquest = page
            print("\(pageResquest)")
            AF.request("\(baseURL)\(pageResquest)", method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil, interceptor: nil).response {
                (responseData) in
                
                guard let data = responseData.data else {return}
                
                do {
                    let response = try JSONDecoder().decode(Response.self, from: data)
                    print("@@@@@@@@ JSON == \(response)")
                    completion(response.results)
                } catch let error as NSError {
                    print("@@@@@@@@ ERROR == \(error)")
                }
            }
        }
    }
}
