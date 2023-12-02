//
//  AmiiboPage.swift
//  amiibonintendoproject
//
//  Created by Dušky Papulák on 29/11/2023.
//

import Foundation
import SwiftUI

struct AmiiboPage: View {
    @ObservedObject var amiiboListVM = AmiiboListVM()
    @State private var searchText = ""

    init() {
        self.amiiboListVM.fetchAmiibo()
    }

    var body: some View {
            NavigationView {
                VStack {
                    TextField("Search", text: $searchText)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()

                    List {
                        ForEach(self.filteredAmiibos(), id: \.id) { amiiboview in
                            AmiiboPageRow(amiiboview: amiiboview)
                        }
                    }
                    .alert(isPresented: self.$amiiboListVM.showAlert) {
                        self.amiiboListVM.alert
                    }
                    .navigationBarTitle("AmiiboPage", displayMode: .inline)
                    .navigationBarItems(leading:
                        Button(action: {
                            self.amiiboListVM.fetchAmiibo()
                        }) {
                            Image(systemName: "arrow.clockwise.icloud")
                        }
                    )
                }
            }
        }

        private func filteredAmiibos() -> [ViewModelAmiibo] {
            if searchText.isEmpty {
                return amiiboListVM.amiibos
            } else {
                return amiiboListVM.amiibos.filter {
                    $0.character.lowercased().contains(searchText.lowercased()) ||
                    $0.game.lowercased().contains(searchText.lowercased())
                }
            }
        }
    }
