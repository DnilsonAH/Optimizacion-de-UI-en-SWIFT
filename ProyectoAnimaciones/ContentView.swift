//
//  ContentView.swift
//  ProyectoAnimaciones
//
//  Created by Dnilson Achahuanco on 16/06/25.
//

import SwiftUI

struct ContentView: View {
    // This is the correct way to declare an @EnvironmentObject
    @EnvironmentObject var modelData: ModelData

    var body: some View {
        NavigationView { // Note: NavigationView is deprecated in iOS 16+, consider NavigationStack
            List {
                ForEach(modelData.hikes) { hike in
                    NavigationLink {
                        HikeView(hike: hike)
                    } label: {
                        VStack {
                            Text("ID: \(hike.id)")
                                .bold()
                            Spacer()
                            Text("Name: \(hike.name)")
                            Spacer()
                        }
                        .padding(5)
                    }
                }
            }
            .animation(.default, value: modelData.hikes) // Consider more specific animations if needed
            .navigationTitle("Hikes")
        }
    }
}
