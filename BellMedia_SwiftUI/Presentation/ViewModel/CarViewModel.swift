
import Foundation

protocol CarViewModelling : AnyObject, ObservableObject {
    func fetchCarDetails() async
    
    /*
     var  displaySectionData: ((_ data: [Section<SectionType>]) -> Void)? {get set}
     func getListOfCars(car: [Car])-> [SectionType]
     func getFilteredCar(cars: [Car]) -> SectionType
     func didSelectCarModel(make: String?, model: String?)
     */

}

class CarViewModel : CarViewModelling {
    @Published var cars: [Car]?
  //  var displaySectionData: (([Section<SectionType>]) -> Void)?
    
    let carService: CarsProtocol
    
    init(carService: CarsProtocol = CarService()){
        self.carService = carService
    }
    
    @MainActor
    func fetchCarDetails() async {
        let result =  await carService.getCars(fileName: "car_list")
        switch result {
        case .success(let car):
            cars = car
            print("habib \(car)")
            //self.cars = car.map { $0 }
        case .failure(let err):
            print("error occur ") // todo
        }
        
    }

    
}


