//
//  ViewController.swift
//  CoreData
//
//  Created by Mohammad Farhoudi on 08/06/2018.
//  Copyright © 2018 Elvotra. All rights reserved.
//

import UIKit
import CoreData

class CompaniesController: UITableViewController, companyDetailedControllerDelegate {

    
    var companies = [Company]() 

    let cellID = "cellID"
    
    
    fileprivate func fetchCompanies() {
        
        let context = CoreDataManager.sharedInstance.persistenceContainer.viewContext
        let fetchRequest = NSFetchRequest<Company>(entityName: "Company")
        
        do {
            
            let companies = try context.fetch(fetchRequest)
            self.companies = companies
            
        } catch let err {
            
            print("Failed to fecth companies", err)
        }
    
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        fetchCompanies()
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
    
    
    fileprivate func editHandler(action: UITableViewRowAction, indexPath: IndexPath) {
        
        let editController = CompanyDetailedController()
        let navController = CustomNavigationController(rootViewController: editController)
        editController.delegate = self
        editController.company = self.companies[indexPath.item]
        present(navController, animated: true, completion: nil)
        
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = .lightBlue
        return view
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    
    fileprivate func setupNavBarItems() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "plus").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handlePlus))
    }
    
    @objc fileprivate func handlePlus() {
        let companyDetailedController = CompanyDetailedController()
        let navController = CustomNavigationController(rootViewController: companyDetailedController)
        companyDetailedController.delegate = self
        present(navController, animated: true, completion: nil)
    }
    
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

