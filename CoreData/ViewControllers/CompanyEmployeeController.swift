//
//  CompanyEmployeeController.swift
//  ElvotraCoreData
//
//  Created by Mohammad Farhoudi on 10/07/2018.
//  Copyright © 2018 Elvotra. All rights reserved.
//

import Foundation
import UIKit



class CompanyEmployeeController: UITableViewController {
    
    var company: Company?

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.title = company?.name
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.backgroundColor = UIColor.darkGreen
        setupNavigationItems(selector: #selector(handlePlus))
        
        
    }
    

    @objc func handlePlus() {
        let createCompanyController = CreateCompanyController()
        let navController = UINavigationController(rootViewController: createCompanyController)
    
        present(navController, animated: true, completion: nil)
    }
    
    
}
