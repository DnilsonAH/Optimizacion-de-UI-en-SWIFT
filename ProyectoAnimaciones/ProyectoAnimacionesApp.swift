import SwiftUI

@main
struct ProyectoAnimacionesApp: App {
    // Use @StateObject for ModelData to ensure it's created and persists across the app's lifecycle.
    // This replaces @State for ObservableObjects in the App struct.
    @StateObject private var modelData = ModelData()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                // Change .environment to .environmentObject for ObservableObject
                .environmentObject(modelData)
        }
    }
}
