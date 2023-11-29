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
    
    init() {
        self.amiiboListVM.fetchAmiibo()
    }
    
    var body: some View {
        NavigationView {
            
            List(self.amiiboListVM.amiibos) { amiiboview in
            
                AmiiboPageRow(amiiboview: amiiboview)
            }
            .alert(isPresented: self.$amiiboListVM.showAlert) {
                self.amiiboListVM.alert
            }
            .navigationBarTitle("AmiiboPage", displayMode: .inline)
            .navigationBarItems(leading:
                Button(
                    action: { self.amiiboListVM.fetchAmiibo()
                        
                }) {
                    Image(systemName: "arrow.clockwise.icloud")
                }
            )
        }
    }
}

struct AmiiboPage_Previews: PreviewProvider {
    static var previews: some View {
        AmiiboPage()
    }
}
