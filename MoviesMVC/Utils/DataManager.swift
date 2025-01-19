//
//  DataManager.swift
//  MoviesMVC-UIKit
//
//  Created by Kenyi Rodriguez on 18/01/25.
//

import CoreData

class DataManager {
    
    static let current = DataManager()
    
    lazy var presistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "Peliculas")
        container.loadPersistentStores { descripcion, error in
            if let error = error {
                print("ERROR TO LOAD MOVIES DB: \(error.localizedDescription)")
            }
        }
        
        return container
    }()
    
    func saveContext() {
        let context = self.presistentContainer.viewContext
        if context.hasChanges {
            try? context.save()
        }
    }
}
