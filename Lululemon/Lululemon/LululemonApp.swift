//
//  LululemonApp.swift
//  Lululemon
//
//  Created by Armando Gonzalez on 7/15/22.
//

import SwiftUI

@main
struct LululemonApp: App {
    @StateObject private var garmentData = GarmentDataModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(self.garmentData)
        }
    }
}
