
import SwiftUI

struct GarmentList: View {
    private enum Constants {
        static let navigationTitle = Text("List")
        static let pickerTitle = "Sorting Type"
        static let addGarmentButtonName = "plus.circle"
    }
    
    enum SortingType: String, CaseIterable, Identifiable {
        case alpha = "Alpha"
        case creationTime = "Creation Time"
        var id: Self { self }
    }

    @EnvironmentObject var garmentData: GarmentDataModel
    @State var showAddGarmentView = false
    @State private var sortingType: SortingType = .alpha
    
    private var sortedGarments: [Garment] {
        let sortedGarments = self.sortingType == .alpha ? garmentData.alphaFilteredGarmentList : garmentData.dateFilteredGarmentList
        return sortedGarments ?? []
    }

    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                Picker(Constants.pickerTitle, selection: $sortingType) {
                        ForEach(SortingType.allCases) { type in
                            Text(type.rawValue)
                                .tag(type)
                        }
                    }
                    .pickerStyle(.segmented)
                    .padding()
                    .border(.black)
                
                List(self.sortedGarments) { garment in
                    Text(garment.name)
                }
                .listStyle(.plain)
            }
            .navigationTitle(Constants.navigationTitle)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                Button {
                    self.showAddGarmentView.toggle()
                } label: {
                    Image(systemName: Constants.addGarmentButtonName)
                        .renderingMode(.template)
                        .foregroundColor(.black)
                }
                .sheet(isPresented: $showAddGarmentView) {
                    GarmentDetail(showAddGarmentView: $showAddGarmentView)
                }
            }
        }
    }
}

struct GarmentList_Previews: PreviewProvider {
    static var previews: some View {
        let testList = [
            Garment(name: "Lululemon Shirt", creationDate: Date())
        ]
        GarmentList()
            .environmentObject(GarmentDataModel(list: testList))
    }
}
