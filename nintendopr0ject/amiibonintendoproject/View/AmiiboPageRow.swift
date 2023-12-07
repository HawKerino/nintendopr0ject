//
//  AmiiboPageRow.swift
//  amiibonintendoproject
//
//  Created by Dušky Papulák on 29/11/2023.
//

import Foundation
import SwiftUI

struct AmiiboPageRow: View {
    let amiiboview: ViewModelAmiibo
    
    var body: some View {
        NavigationLink(destination: Detail(amiiboview: self.amiiboview)) {
            
            VStack(alignment: .leading) {
                Text(self.amiiboview.character)
                Text(self.amiiboview.series)
                Text(self.amiiboview.game)
            }
            .padding(.leading)
            
        }
    }
}

struct AmiiboListRow_Previews: PreviewProvider {
    static var previews: some View {
        AmiiboPageRow(amiiboview: ViewModelAmiibo(amiibo: amiibo1))
            .previewLayout(.sizeThatFits)
    }
}
