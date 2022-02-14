//
//  ToDo13App.swift
//  ToDo13
//
//  Created by Didier Delhaisse on 14/02/2022.
//

import SwiftUI

@main
struct ToDo13App: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
