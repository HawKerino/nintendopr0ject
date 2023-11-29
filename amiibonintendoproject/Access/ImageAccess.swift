//
//  ImageAccess.swift
//  amiibonintendoproject
//
//  Created by Dušky Papulák on 29/11/2023.
//

import Foundation
final class ImageAccess {
    
    static var shared = ImageAccess()
 
    func loadImage(url: URL, completion: @escaping (Result<Data, NetworkError>) -> Void) {
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            
            print("[RemoteImage]: Loading images...")
            
            completion(.success(data))
        }
        
        task.resume()
    }
    
}
