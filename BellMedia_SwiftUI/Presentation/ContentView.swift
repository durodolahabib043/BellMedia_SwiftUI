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
            ZStack {
                Color.white
                VStack {
                    headerView()
                    Spacer()
                        ScrollView {
                            LazyVStack(alignment: .leading,spacing: 10) {
                                ForEach(viewModel.cars ?? []) { car in
                                    Print(car.model)
                                    ListCell(row: 0, model: car)
                                }
                            }
                        }
                }
                
                
            }
            
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("GUIDOMIA")
        }
        
        .task {
            Task {
                await viewModel.fetchCarDetails()
            }
        }
    }
    
    @ViewBuilder
    private func headerView() -> some View {
        if let path = Bundle.main.path(forResource: "Tacoma.jpg", ofType: nil) {
            let url = URL(fileURLWithPath: path)
            AsyncImage(url: url) { image in
                image.resizable()
                    .frame(height: 300)
            } placeholder: {
                ProgressView()
            }
            .frame(maxWidth: .infinity)
            .overlay(alignment: .bottomLeading) {
                VStack(alignment: .leading) {
                    Text("Tacoma 2021").foregroundColor(.white).font(.title)
                    Text("Get your's now").foregroundColor(.white).font(.subheadline)
                }
                .padding()
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
