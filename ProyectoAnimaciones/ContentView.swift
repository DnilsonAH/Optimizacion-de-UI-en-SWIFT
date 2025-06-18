import SwiftUI

struct ContentView: View {
    // Change @Environment(ModelData.self) to @EnvironmentObject var modelData: ModelData
    @EnvironmentObject var modelData: ModelData
    
    var body: some View {
        // NavigationSplitView is available from iOS 16, which Xcode 14.2 supports.
        // If you encounter issues, you might need to use NavigationView.
        NavigationSplitView {
            List(modelData.hikes) { hike in
                NavigationLink {
                    HikeView(hike: hike)
                } label: {
                    HStack {
                        
                        VStack(alignment: .leading) {
                            Text(hike.name)
                                .font(.headline)
                            Text(hike.distanceText)
                        }
                        
                        Spacer()
                    }
                }
            }
            .navigationTitle("Hikes")
        } detail: {
            Text("Select a Hike")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            // Change .environment(ModelData()) to .environmentObject(ModelData())
            .environmentObject(ModelData())
    }
}
