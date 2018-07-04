//
//  CompanyTableViewController.swift
//  ElvotraCoreData
//
//  Created by Mohammad Farhoudi on 04/07/2018.
//  Copyright © 2018 Elvotra. All rights reserved.
//

import UIKit


extension CompaniesController {
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! CompanyCell
        
        cell.backgroundColor = .tealColor
        
        let company = companies[indexPath.item]
        cell.company = company
        return cell
        
    }
    
    
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        let label = UILabel()
        label.text = "No companies available..."
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
        
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return self.companies.isEmpty == true ? 150 : 0
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return companies.count
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete") { (_, _) in
            
            let company = self.companies[indexPath.item]
            self.companies.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            
            let context = CoreDataManager.sharedInstance.persistenceContainer.viewContext
            context.delete(company)
            
            //perssiting the deletion
            
            do {
                try context.save()
            } catch let saveErr {
                print("error in deleting company", saveErr)
                
            }
        }
        
        let editAction = UITableViewRowAction(style: .normal, title: "Edit", handler: editHandler)
        
        deleteAction.backgroundColor = UIColor.lightRed
        editAction.backgroundColor = UIColor.darkGreen
        
        return [deleteAction, editAction]
    }
    
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = .lightBlue
        return view
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    
    
    fileprivate func editHandler(action: UITableViewRowAction, indexPath: IndexPath) {
        
        let editController = CompanyDetailedController()
        let navController = CustomNavigationController(rootViewController: editController)
        editController.delegate = self
        editController.company = self.companies[indexPath.item]
        present(navController, animated: true, completion: nil)
        
    }
    
    
    
    
    
    
}
