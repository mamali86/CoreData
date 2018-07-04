//
//  PersistenceContainerManager.swift
//  ElvotraCoreData
//
//  Created by Mohammad Farhoudi on 22/06/2018.
//  Copyright © 2018 Elvotra. All rights reserved.
//

import Foundation
import UIKit
import CoreData


struct CoreDataManager  {
    
    static let sharedInstance = CoreDataManager()
    
    
    let persistenceContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "CoreData")
        container.loadPersistentStores { (storeDescription, err) in
            
        if let err = err {
            
        fatalError("Loading of store failed: \(err)")
                }
                }
        
        return container
    
    }()
    
     func fetchCompanies() ->[Company] {
        
        let context = persistenceContainer.viewContext
        let fetchRequest = NSFetchRequest<Company>(entityName: "Company")
        
        do {
            
            let companies = try context.fetch(fetchRequest)
            
            return companies

            
        } catch let err {
            
            print("Failed to fecth companies", err)
            return []
        }
        
        
    }

    
//    let persistenceContainer = NSPersistentContainer(name: "CoreData")
//
//    persistenceContainer.loadPersistentStores { (storeDescription, err) in
//
//    if let err = err {
//
//    fatalError("Loading of store failed: \(err)")
//    }
//    }
//
//    let context = persistenceContainer.viewContext
    
}
