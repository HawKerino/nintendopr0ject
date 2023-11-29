//
//  AmiiboListVM.swift
//  amiibonintendoproject
//
//  Created by Dušky Papulák on 29/11/2023.
//

import Foundation
import SwiftUI
final class AmiiboListVM: ObservableObject {
    
    @Published var amiibos = [ViewModelAmiibo]()
    @Published var showAlert: Bool = false
    
    func fetchAmiibo() {
        
        let apiClient = API()
        apiClient.get { result in
            
            switch result {
            case .success(let responseData):
                DispatchQueue.main.async {
                    self.amiibos = responseData.amiibo.map(ViewModelAmiibo.init)
                }
            case .failure(let error):
                print("[AmiiboListVM]: \(error)")
                self.showAlert = true
            }
        }
    }
    
}

extension AmiiboListVM {
    
    var alert: Alert {
        
        Alert(
            title: Text("Failed to fetch amiibos"),
            message: Text("Server error"),
            dismissButton: .default(Text("OK"), action: { self.showAlert = false })
        )
    }
}
