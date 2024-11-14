//
//  SafeApp.swift
//  Safe
//
//  Created by VL on 14/11/2024.
//

import SwiftUI

@main
struct SafeApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
