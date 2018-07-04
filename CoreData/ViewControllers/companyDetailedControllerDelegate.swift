//
//  companyDetailedControllerDelegate.swift
//  ElvotraCoreData
//
//  Created by Mohammad Farhoudi on 04/07/2018.
//  Copyright © 2018 Elvotra. All rights reserved.
//

import Foundation



extension CompaniesController: companyDetailedControllerDelegate {
    
    func didAddCompany(company: Company) {
        companies.append(company)
        let newindexPath = IndexPath(row: companies.count - 1, section: 0)
        tableView.insertRows(at: [newindexPath], with: .automatic)
    }
    
    func didEditCompany(company: Company) {
        
        guard let row = companies.index(of: company) else {return}
        let reloadIndexPath = IndexPath(row: row, section: 0)
        tableView.reloadRows(at: [reloadIndexPath], with: .middle)
        
    }
}
