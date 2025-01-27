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
    @State private var selectedcar = 0
    @State private var filteredCars: [Car]?
      
    let carType = ["All", "Range Rover", "Roadster", "3300i", "GLE coupe"]
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.white
                VStack {
                        ScrollView {
                            headerView()
                            searchView()
                            LazyVStack(alignment: .leading,spacing: 10) {
                                ForEach(filteredCars ?? []) { car in
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
        .onChange(of: selectedcar, perform: { newValue in
            Print("this changed \(newValue)")
            if selectedcar == 0 {
                /// return all cars
                filteredCars = viewModel.cars
            } else {
                filteredCars = viewModel.cars?.filter({ car in
                    car.model == carType[newValue]
                })
            }
        })
        
        .task {
            Task {
                await viewModel.fetchCarDetails()
                filteredCars = viewModel.cars
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
    
    @ViewBuilder
    private func searchView() -> some View {
        Section {
            HStack {
                Text("Select your filter")
                Spacer()
                Picker("Filter ", selection: $selectedcar) {
                    ForEach(0..<carType.count, id: \.self) {
                        Text(carType[$0])
                    }
                }.pickerStyle(.menu)
            }
            .padding()
        
        }
        .accentColor(.black)
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
