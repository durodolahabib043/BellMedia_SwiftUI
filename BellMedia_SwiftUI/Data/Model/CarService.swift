
import Foundation

enum CarError: Error {
    case error
}

protocol CarsProtocol : AnyObject {
    func getCars(fileName: String) async -> Result<[Car], Error>
}

class CarService : CarsProtocol {
    func getCars(fileName: String) async -> Result<[Car], Error> {
        guard let path = Bundle.main.path(forResource: fileName, ofType: "json") else {
            return Result.failure(CarError.error)
        }
        
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
            let cars = try JSONDecoder().decode([Car].self, from: data)

            return Result.success(cars)
        } catch {
            return Result.failure(error)
        }
    }
}
