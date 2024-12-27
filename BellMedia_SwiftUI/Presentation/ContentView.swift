//
//  ContentView.swift
//  BellMedia_SwiftUI
//
//  Created by Habib Durodola on 12/16/24.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel = CarViewModel()
    @State private var isExpanded: [UUID: Bool] = [:]
    @State private var sampleCar: [String] = []
    
    
    var body: some View {
        NavigationStack {
            
            ScrollView {
                LazyVStack(alignment: .leading,spacing: 10) {
                    ForEach(viewModel.cars ?? []) { car in
                        
                        
                        ZStack(alignment: .leading) {
                            HStack {
                                VStack {
                                    if let path = Bundle.main.path(forResource: car.image, ofType: nil) {
                                        let url = URL(fileURLWithPath: path)
                                        AsyncImage(url: url) { image in
                                            image.resizable()
                                                .frame(height: 100)
                                        } placeholder: {
                                            ProgressView()
                                        }
                                        .frame(maxWidth: 100)
                                    }
                                    Print("habib \(car.prosList)")
                                    
                                  //sampleCar = car.prosList
                                    if isExpanded[car.id] ?? false {
                                        
                                        VStack {
                                            
                                            Text("Year: \(Int.random(in: 2000..<2026)) ")
                                                .font(.footnote)
                                                .animation(.easeInOut)
                                            if  !car.prosList.isEmpty {
                                                Text(car.prosList[0])
                                            }
                                           
                                            
                                            
                                            /*
                                             
                                             ForEach(sampleCar,id: \.self){ prolist in
                                                 print("habib \(prolist)")
                                                // Text(prolist)
                                             }
                                             */
                                         //   print("habib is here \(sampleCar)")
                                   
                                        }
                                        
                                        
                                    }
                                    
                                }
                                
                                VStack(spacing: 14) {
                                    Text(car.make)
                                    Text("\(car.customerPrice/1000) K")
                                    /*
                                     if isExpanded[car.id] ?? false {
                                     Text("Year: \(Int.random(in: 2000..<2026))")
                                     .font(.footnote)
                                     }
                                     */
                                    
                                }
                                .background(.red)
                            }
                            
                            Button(action: {
                                isExpanded[car.id] = !(isExpanded[car.id] ?? false)
                            }) {
                                Color.clear
                            }
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                        }
                        
                        .padding()
                        
                    }
                }
                //.frame(maxWidth: .infinity)
                
                
            }
            
        }
        .task {
            Task {
                await viewModel.fetchCarDetails()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


extension View {
    func Print(_ vars: Any...) -> some View {
        for v in vars { print(v) }
        return EmptyView()
    }
}
