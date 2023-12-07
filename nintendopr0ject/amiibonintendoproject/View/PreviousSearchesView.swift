//
//  PreviousSearchesView.swift
//  amiibonintendoproject
//
//  Created by Dušky Papulák on 03/12/2023.
//

import Foundation
import SwiftUI

struct PreviousSearchesView: View {
    @ObservedObject var amiiboListVM: AmiiboListVM

    var body: some View {
        VStack {
            Text("Previous Searches:")
                .font(.headline)
                .padding()

            List(amiiboListVM.previousSearches, id: \.self) { searchText in
                Text(searchText)
            }
        }
    }
}
