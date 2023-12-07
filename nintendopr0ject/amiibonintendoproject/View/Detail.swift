//
//  Detail.swift
//  amiibonintendoproject
//
//  Created by Dušky Papulák on 29/11/2023.
//

import SwiftUI
struct Detail: View {
    @ObservedObject var amiiboview:  ViewModelAmiibo
    
    init(amiiboview: ViewModelAmiibo) {
        self.amiiboview = amiiboview
    }
    
    var body: some View {
        
        VStack {
            
            HStack {
                VStack {
                    Image(systemName: "gamecontroller")
                        .padding(.bottom, 12)
                    Image(systemName: "info.circle")
                }
                .onAppear {
                    self.amiiboview.loadImage()
                }
                
                VStack(alignment: .leading) {
                    Text(self.amiiboview.game)
                        .padding(.bottom, 5)
                    Text(self.amiiboview.series)
                }
                .padding(.leading)
            }
            .foregroundColor(Color.gray)
            .font(.largeTitle)
            .offset(y: -25)
            
            HStack(alignment: .bottom) {
                self.amiiboview.image
                    .resizable()
                    .scaledToFit()
                    .frame(height: 400)
            
            }
            Text(self.amiiboview.character)
                .fontWeight(.bold)
            .font(.custom("Cochin",fixedSize: 50))
            .padding()        }
    }
}
            
            
            struct Detail_Previews: PreviewProvider {
                static var previews: some View {
                    Detail(amiiboview: ViewModelAmiibo(amiibo: amiibo1))
                }
            }
