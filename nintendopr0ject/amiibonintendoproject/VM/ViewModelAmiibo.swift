//
//  ViewModelAmiibo.swift
//  amiibonintendoproject
//
//  Created by Dušky Papulák on 29/11/2023.
//

import Foundation
import UIKit
import SwiftUI

final class ViewModelAmiibo: ObservableObject, Identifiable {
    
    let amiibo: Amiibo
    @Published var image: Image = Image(systemName: "xmark.octagon")
    
    init(amiibo: Amiibo) {
        self.amiibo = amiibo
    }
    
    var series: String {
        self.amiibo.amiiboSeries
    }
    
    var character: String {
        self.amiibo.character
    }
    
    var game: String {
        self.amiibo.gameSeries
    }
    
    var imageURL: URL? {
        URL(string: self.amiibo.image)
    }
    func loadImage() {
            if let imageURL = imageURL {
                ImageAccess.shared.loadImage(url: imageURL) { result in
                    switch result {
                    case .success(let response):
                        
                        if let uiImage = UIImage(data: response) {
                            
                            DispatchQueue.main.async {
                                self.image = Image(uiImage: uiImage)
                            }
                        }
                        
                    case .failure(let error):
                        print(error)
                    }
                }
            }
            
        }
        
    }
