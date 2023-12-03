//
//  AmiiboPage.swift
//  amiibonintendoproject
//
//  Created by Dušky Papulák on 29/11/2023.
//

import Foundation
import SwiftUI

struct SearchBarView: View {
    @Binding var searchText: String
    var onSearchAction: () -> Void

    var body: some View {
        HStack {
            ZStack(alignment: .leading) {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.gray)
                    .padding(.leading, 10)

                TextField("Search", text: $searchText, onCommit: {
                    onSearchAction()
                })
                .padding(10)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .padding(.leading, 40)
            }
            .padding(.trailing, 8)

            Button(action: {
                searchText=""
                onSearchAction()
            }) {
                Text("Cancel")
                    .foregroundColor(.blue)
                    .padding(.trailing, 10)
            }
        }
    }
}

struct AmiiboPage: View {
    @ObservedObject var amiiboListVM = AmiiboListVM()
    @State private var searchText = ""

    init() {
        self.amiiboListVM.fetchAmiibo()
        self.searchText = self.amiiboListVM.loadSearchText()
    }

    var body: some View {
        NavigationView {
            VStack {
                SearchBarView(searchText: $searchText) {
                    self.amiiboListVM.fetchAmiibo()
                    self.amiiboListVM.saveSearchText(self.searchText)
                }

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
                    },
                    trailing:
                    HStack {
                        NavigationLink(destination: PreviousSearchesView(amiiboListVM: amiiboListVM)) {
                            Image(systemName: "clock")
                        }
                    }
                )
            }
            .padding()
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
