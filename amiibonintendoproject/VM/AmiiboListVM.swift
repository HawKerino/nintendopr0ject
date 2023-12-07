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
    @Published var previousSearches: [String] = []

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

    var alert: Alert {
        Alert(
            title: Text("Failed to fetch amiibos"),
            message: Text("Server error"),
            dismissButton: .default(Text("OK"), action: { self.showAlert = false })
        )
    }

    func saveSearchText(_ searchText: String) {
        UserDefaults.standard.set(searchText, forKey: "SearchText")
        if !searchText.isEmpty {
            previousSearches.insert(searchText, at: 0)
            UserDefaults.standard.set(previousSearches, forKey: "PreviousSearches")
        }
    }

    func loadSearchText() -> String {
        return UserDefaults.standard.string(forKey: "SearchText") ?? ""
    }

    func loadPreviousSearches() -> [String] {
        if let storedSearches = UserDefaults.standard.array(forKey: "PreviousSearches") as? [String] {
            return storedSearches
        }
        return []
    }
}
