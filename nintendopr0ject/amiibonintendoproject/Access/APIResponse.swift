//
//  APIResponse.swift
//  amiibonintendoproject
//
//  Created by Dušky Papulák on 29/11/2023.
//

import Foundation
struct APIResponse: Decodable {
    let amiibo: [Amiibo]
}
