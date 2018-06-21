//
//  ViewController.swift
//  CoreData
//
//  Created by Mohammad Farhoudi on 08/06/2018.
//  Copyright © 2018 Elvotra. All rights reserved.
//

import UIKit

class CompaniesController: UITableViewController, companyDetailedControllerDelegate {

    var companies = [Company]()

    
    let cellID = "cellID"
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        view.backgroundColor = .white
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = .darkGreen
        tableView.separatorColor = .white
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
        navigationItem.title = "Companies"
        setupNavBarItems()
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        
        cell.backgroundColor = .tealColor
        
        let company = companies[indexPath.item]
        cell.textLabel?.text = company.name
        cell.textLabel?.textColor = .white
        cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return companies.count
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
    
}

