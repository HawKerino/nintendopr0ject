//
//  NetworkError.swift
//  amiibonintendoproject
//
//  Created by Dušky Papulák on 29/11/2023.
//

import Foundation
enum NetworkError: Error {
    case noData
    case cannotReachServer
    case responseError(code: Int, message: String)
    case decodingError
}
