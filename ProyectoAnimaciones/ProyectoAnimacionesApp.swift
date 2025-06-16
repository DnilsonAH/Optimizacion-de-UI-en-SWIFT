//
//  ProyectoAnimacionesApp.swift
//  ProyectoAnimaciones
//
//  Created by Dnilson Achahuanco on 16/06/25.
//

import SwiftUI
@main
struct ProyectoAnimacionesApp: App {

    @StateObject var modelData = ModelData() // Crea una única fuente de verdad



    var body: some Scene {

        WindowGroup {

            ContentView()

                .environmentObject(modelData)

        }

    }

}
