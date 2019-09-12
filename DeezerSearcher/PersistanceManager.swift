//
//  PersistanceManager.swift
//  DeezerSearcher
//
//  Created by Dima Opalko on 9/12/19.
//  Copyright © 2019 Dima Opalko. All rights reserved.
//

import Foundation
import CoreData

final class PersistanceManager {
    
    private init() {}
    static let shared = PersistanceManager()
    
    // MARK: - Core Data stack
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "DeezerSearcher")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    func save() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
