
import XCTest
@testable import Lululemon

class LululemonGarmentData_Tests: XCTestCase {
    
    let garmentData = GarmentDataModel()
    let garmentNames = ["a", "b", "test", "tester", "A", "Z", "z"]
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        self.garmentData.createGarmentList(garmentNames: self.garmentNames)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        self.garmentData.resetSavedGarmentsList()
    }
    
    func test_LululemonGarmentData_createGarmentArrayFromGarmentNames_shouldBeTrue() {
        let gamrmentsCount = garmentNames.count
        
        XCTAssert(self.garmentData.garmentList.count == gamrmentsCount, "Could not create Garment List from array of garment strings")
    }

    func test_LululemonGarmentData_createGarmentDictionaryFromGarmentArray_shouldBeTrue() {
        let garmentDictionary = self.garmentData.createDictionaryFromGarmentArray()
        let garmentArray = self.garmentData.createGarmentArrayFromDictionary(garmentDictionary)
        
        XCTAssert(garmentArray.count == garmentDictionary.count, "Could not create Garment Dictionary from array of Garments")
    }
    
    func test_LululemonGarmentData_updateGarmentList_shouldBeTrue() {
        let initialGarmentListCount = self.garmentData.garmentList.count
        
        let newGarments = ["Shirt", "Pants"]
        newGarments.forEach { self.garmentData.addGarment(name: $0) }
        
        XCTAssert(initialGarmentListCount + newGarments.count == self.garmentData.garmentList.count, "Could not add new garments to garment list")
    }
    
    func test_LululemonGarmentData_loadGarmentList_shouldBeTrue() {
        let initialGarmentList = self.garmentData.garmentList
        
        let loadedGarmetList = self.garmentData.loadGarmentList()
        
        var garmentListLoaded = true
        for garment in initialGarmentList {
            if loadedGarmetList.contains(where: { loadedGarment in
                garment.name != loadedGarment.name
            }) {
                garmentListLoaded = false
            }
        }
        
        XCTAssert(garmentListLoaded == false, "Could not load garment list from memory")
    }
    
    func test_LululemonGarmentData_resetGarmentList_shouldBeTrue() {
        let initialCount = self.garmentData.garmentList.count
        
        self.garmentData.resetSavedGarmentsList()
        
        let resetCount = self.garmentData.garmentList.count
        
        XCTAssert(initialCount != resetCount, "Could not reset garment list from memory")
    }
}
