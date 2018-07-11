//
//  ViewController.swift
//  CoreData
//
//  Created by Mohammad Farhoudi on 08/06/2018.
//  Copyright © 2018 Elvotra. All rights reserved.
//

import UIKit
import CoreData

class CompaniesController: UITableViewController {

    
    var companies = [Company]() 

    let cellID = "cellID"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.companies = CoreDataManager.sharedInstance.fetchCompanies()
        
        view.backgroundColor = .white
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = .darkGreen
        tableView.separatorColor = .white
        tableView.register(CompanyCell.self, forCellReuseIdentifier: cellID)
        navigationItem.title = "Companies"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Reset", style: .plain, target: self, action: #selector(handleReset))
        setupNavBarItems()
    }
    
    
    @objc private func handleReset() {
        // Accessing the context to access and modify objects in CoreData
        let context = CoreDataManager.sharedInstance.persistenceContainer.viewContext
        
        companies.forEach { (company) in
            context.delete(company)
        }
        
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: Company.fetchRequest())
        
        do {
            try context.execute(batchDeleteRequest)
            var indexPathsToRemove = [IndexPath]()
            
            for (index, _) in companies.enumerated() {
                let indexPath = IndexPath(row: index, section: 0)
                indexPathsToRemove.append(indexPath)
            }
            
            companies.removeAll()
            tableView.deleteRows(at: indexPathsToRemove, with: .left)
            tableView.reloadData()
            
        } catch let err {
            
            print("Failed to delete from CoreData", err)
        }
    }
    

    fileprivate func setupNavBarItems() {
        setupNavigationItems(selector: #selector(handlePlus))
    }
    
    @objc fileprivate func handlePlus() {
        let companyDetailedController = CompanyDetailedController()
        let navController = CustomNavigationController(rootViewController: companyDetailedController)
        companyDetailedController.delegate = self
        present(navController, animated: true, completion: nil)
    }
    

    
}

