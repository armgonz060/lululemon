
import SwiftUI

struct ContentView: View {
    var body: some View {
        GarmentList()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let testList = [
            Garment(name: "Lululemon Shirt", creationDate: Date())
        ]
        ContentView()
            .environmentObject(GarmentDataModel(list: testList))
    }
}
