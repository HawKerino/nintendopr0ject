//
//  AmiiboPage.swift
//  amiibonintendoproject
//
//  Created by Dušky Papulák on 29/11/2023.
//

import Foundation
import SwiftUI

struct FullScreenSearchView: View {
    @Binding var searchText: String
    @Binding var isSearching: Bool

    var body: some View {
        VStack {
            TextField("Search", text: $searchText, onCommit: {
                // Perform search here
                self.isSearching = false
            })
            .padding(10)
            .background(Color(.systemGray6))
            .cornerRadius(8)
            .padding(40)

            HStack {
                Button(action: {
                    // Perform search here
                    self.isSearching = false
                }) {
                    Text("Search")
                        .foregroundColor(.blue)
                        .padding(10)
                }

                Spacer()

                Button(action: {
                    // Clear search text, cancel search, and dismiss the view
                    self.searchText = ""
                    self.isSearching = false
                }) {
                    Text("Cancel")
                        .foregroundColor(.blue)
                        .padding(10)
                }
            }
        }
        .padding()
    }
}

struct AmiiboPage: View {
    @ObservedObject var amiiboListVM = AmiiboListVM()
    @State private var searchText = ""
    @State private var isSearching = false

    init() {
        self.amiiboListVM.fetchAmiibo()
        self.searchText = self.amiiboListVM.loadSearchText()
    }

    var body: some View {
        NavigationView {
            ZStack {
                Image("wallpaper")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)

                VStack {
                    Button(action: {
                        // Set isSearching to true when the "Search" button is tapped
                        self.isSearching = true
                    }) {
                        Text("Search")
                            .foregroundColor(.blue)
                            .padding(10)
                    }

                    List {
                        ForEach(self.filteredAmiibos(), id: \.id) { amiiboview in
                            AmiiboPageRow(amiiboview: amiiboview).listRowBackground(Color.black.opacity(0.5))
                        }
                    }
                    .scrollContentBackground(.hidden)
                    .background(Color.clear)
                    .alert(isPresented: self.$amiiboListVM.showAlert) {
                        self.amiiboListVM.alert
                    }
                    .navigationBarTitle("AmiiboPage", displayMode: .inline)
                    .foregroundColor(Color.white)
                    .navigationBarItems(
                        trailing: HStack {
                            NavigationLink(destination: PreviousSearchesView(amiiboListVM: amiiboListVM)) {
                                Image(systemName: "clock")
                            }
                        }
                    )
                }
                .padding()
            }
            .sheet(isPresented: $isSearching) {
                FullScreenSearchView(searchText: $searchText, isSearching: $isSearching)
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
