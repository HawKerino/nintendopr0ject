//
//  API.swift
//  amiibonintendoproject
//
//  Created by Dušky Papulák on 29/11/2023.
//

import Foundation
final class API {
    private let baseURL = URL(string: "https://www.amiiboapi.com/api/amiibo/")!
    public static var shared = API()
}

// MARK: implement get method
extension API {
    
    public func get(completion: @escaping (Result<APIResponse, NetworkError>) -> Void) {
        
        let task = URLSession.shared.dataTask(with: self.baseURL) { data, response, error in
            
            guard let response = response as? HTTPURLResponse else {
                completion(.failure(.cannotReachServer))
                return
            }
            
            if !(200...299).contains(response.statusCode) {
                completion(.failure(.responseError(code: response.statusCode, message: "server returns error code")))
                return
            }
            
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            
            do {
                let responseData = try JSONDecoder().decode(APIResponse.self, from: data)
                completion(.success(responseData))
            } catch {
                completion(.failure(.decodingError))
            }
            
        }
        
        task.resume()
    }
}
