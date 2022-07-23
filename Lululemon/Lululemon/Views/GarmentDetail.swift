
import SwiftUI

struct GarmentDetail: View {
    private enum Constants {
        static let navigationTitle = Text("ADD")
        static let saveButtonName = "Save"
        static let textFieldTitle = "Garment Name:"
    }
    
    @EnvironmentObject var garmentData: GarmentDataModel
    @Binding var showAddGarmentView: Bool
    @State var garmentToAdd = ""
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    Group {
                        Text(Constants.textFieldTitle)
                        TextField(
                            "",
                            text: $garmentToAdd
                        )
                        .textFieldStyle(.roundedBorder)
                    }
                    .listRowSeparator(.hidden)
                }
                .listStyle(.plain)
                .border(.black)
            }
            .navigationTitle(Constants.navigationTitle)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                Button {
                    self.saveGarment()
                } label: {
                    Text(Constants.saveButtonName)
                }
                .disabled($garmentToAdd.wrappedValue.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
            }
        }
    }
    
    private func saveGarment() {
        self.garmentData.addGarment(name: self.garmentToAdd)
        self.showAddGarmentView = false
    }
}

struct GarmentDetail_Previews: PreviewProvider {
    static var previews: some View {
        GarmentDetail(showAddGarmentView: .constant(false))
    }
}
