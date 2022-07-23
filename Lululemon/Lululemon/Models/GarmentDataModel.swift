import Foundation
import Combine

fileprivate enum Constants {
    static let userDefaultsGarmentListKey = "garmentList"
}

final class GarmentDataModel: ObservableObject {
    @Published var garmentList: [Garment] = [] {
        didSet {
            self.updateGarmentList()
            self.sortGarmentList()
        }
    }
    
    init(list: [Garment]? = nil) {
        if let garmentList = list {
            self.garmentList = garmentList
            self.updateGarmentList()
            self.sortGarmentList()
        } else {
            self.garmentList = self.loadGarmentList()
        }
    }
    
    var alphaFilteredGarmentList: [Garment]?
    var dateFilteredGarmentList: [Garment]?
    
    private func sortGarmentList() {
        self.alphaFilteredGarmentList = self.garmentList.sorted { $0.name < $1.name }
        self.dateFilteredGarmentList = self.garmentList.sorted { $0.creationDate > $1.creationDate }
    }
    
    func addGarment(name: String) {
        self.garmentList.append(Garment(name: name, creationDate: Date()))
    }

    func updateGarmentList() {
        UserDefaults.standard.set(
            self.createDictionaryFromGarmentArray(),
            forKey: Constants.userDefaultsGarmentListKey
        )
//        UserDefaults.standard.synchronize()
    }
    
    func createGarmentList(garmentNames: [String]) {
        var garments = [String: Date]()
        for garmentName in garmentNames {
            garments[garmentName] = Date()
        }
        self.garmentList = self.createGarmentArrayFromDictionary(garments)
    }
    
    func createDictionaryFromGarmentArray() -> [String: Date] {
        var garmentDictionary: [String: Date] = [:]
        self.garmentList.forEach { garmentDictionary[$0.name] = $0.creationDate }
        return garmentDictionary
    }
    
    func loadGarmentList() -> [Garment] {
        let garmentList = UserDefaults.standard.object(
            forKey: Constants.userDefaultsGarmentListKey
        ) as? [String: Date] ?? [:]
        return self.createGarmentArrayFromDictionary(garmentList)
    }
    
    func createGarmentArrayFromDictionary(_ garments: [String: Date]) -> [Garment] {
        return garments.map { Garment(name: $0, creationDate: $1) }
    }
    
    func resetSavedGarmentsList() {
        self.garmentList = []
        UserDefaults.standard.removeObject(forKey: Constants.userDefaultsGarmentListKey)
    }
}

struct Garment: Codable, Equatable, Identifiable {
    let name: String
    let creationDate: Date
    var id: String { creationDate.description }
}
