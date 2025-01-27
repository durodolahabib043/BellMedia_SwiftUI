//
//  ListCell.swift
//  BellMedia_SwiftUI
//
//  Created by Habib Durodola on 1/24/25.
//

import SwiftUI

struct ListCell: View {
    
    @State private var tapped: Bool = false
    var row: Int
    let model : Car
    
    var body: some View {
        ZStack {
            VStack {
                HStack(spacing: 10) {
                    carImage(imageUrl: model.image)
                    collapsedView()
                    
                    Spacer()
                }
                .onTapGesture {
                    withAnimation(.easeInOut(duration: 0.5)) {
                        tapped.toggle()
                    }
                }
                
                if tapped {
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Pros")
                        ForEach(model.prosList.indices, id: \.self) { index in
                            if !model.prosList[index].isEmpty {
                                HStack() {
                                    Text("•")
                                        .font(.body)
                                    Text(model.prosList[index])
                                        .font(.body)
                                    Spacer()
                                }
                            }
                        }
                    }
                    .padding()
                    
                }
                Divider()
            }
    
        }
    }
    
    @ViewBuilder
    private func carImage(imageUrl: String) -> some View{
        if let path = Bundle.main.path(forResource: imageUrl, ofType: nil) {
            let url = URL(fileURLWithPath: path)
            AsyncImage(url: url) { image in
                image.resizable()
                    .frame(height: 150)
            } placeholder: {
                ProgressView()
            }
            .frame(maxWidth: 200)
        }
    }
    
    @ViewBuilder
    private func collapsedView() -> some View {
        VStack(alignment: .leading) {
            Text(model.model).font(.title).foregroundColor(.gray)
            Text("\(model.marketPrice/100) K").font(.subheadline).foregroundColor(.gray)
        }

    }
}

struct ListCell_Previews: PreviewProvider {
    static var previews: some View {
       ListCell(row: 0, model: Car(consList: ["KKK"], customerPrice: 1, make: "BMW", marketPrice: 123000, model: "Benz", prosList: ["PPP"], rating: 34, image: "BMW_330i.jpg"))
    }
}
