//
//  companyDetailedController.swift
//  CoreData
//
//  Created by Mohammad Farhoudi on 10/06/2018.
//  Copyright © 2018 Elvotra. All rights reserved.
//

import UIKit
import CoreData


protocol companyDetailedControllerDelegate {
    func didAddCompany(company: Company)
    func didEditCompany(company: Company)
}


class CompanyDetailedController: UIViewController {
    
    var delegate: companyDetailedControllerDelegate?
    
    var company: Company? {
        didSet{
            
            nameTextFiled.text = company?.name
            guard let founded = company?.founded else {return}
            datePicker.date = founded
            
        }
    }
    
    
    let datePicker: UIDatePicker = {
        let dp = UIDatePicker()
        dp.datePickerMode = .date
        dp.translatesAutoresizingMaskIntoConstraints = false
        return dp
        
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "name"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let nameTextFiled: UITextField = {
        let textFiled = UITextField()
        textFiled.translatesAutoresizingMaskIntoConstraints = false
        textFiled.placeholder = "Enter Company"
        return textFiled
        
    }()
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.title = company == nil ? "Create Company" : "Edit Company"
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.darkGreen
        navigationItem.leftBarButtonItem =  UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleDismiss))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(handleSave))
        
        setupUI()
    }
    

    @objc fileprivate func handleDismiss() {
        
        dismiss(animated: true, completion: nil)
    }
    
    
    @objc fileprivate func handleSave() {
        
        
        if self.company == nil {
            
         createComany()
            
        } else {
            
          editCompany()
            
        }
        
    }
    
    
    fileprivate func editCompany() {
        
        let context = CoreDataManager.sharedInstance.persistenceContainer.viewContext

        
        company?.name = nameTextFiled.text
        company?.founded = datePicker.date
        do {
            try context.save()

            dismiss(animated: true) {
                
                self.delegate?.didEditCompany(company: self.company!)
            }
        } catch let saveErr {
            print("Failed to save company", saveErr)
        }
    
    }
    
    fileprivate func createComany() {
        
        let context = CoreDataManager.sharedInstance.persistenceContainer.viewContext
        let company = NSEntityDescription.insertNewObject(forEntityName: "Company", into: context)
        
        company.setValue(nameTextFiled.text, forKey: "name")
        company.setValue(datePicker.date, forKey: "founded")

        
        // perform the save
        do {
            try context.save()
            dismiss(animated: true) {
                self.delegate?.didAddCompany(company: company as! Company)
            }
        } catch let saveErr {
            print("Failed to save company", saveErr)
        }
    }
    
   
    fileprivate func setupUI() {
        
        let lightBlueView = UIView()
        lightBlueView.backgroundColor = UIColor.lightBlue
        lightBlueView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(lightBlueView)
        
        
        lightBlueView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        lightBlueView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        lightBlueView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        lightBlueView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        
        view.addSubview(nameLabel)
        nameLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        nameLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        nameLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        nameLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        view.addSubview(nameTextFiled)
        nameTextFiled.topAnchor.constraint(equalTo: nameLabel.topAnchor, constant: 0).isActive = true
        nameTextFiled.leftAnchor.constraint(equalTo: nameLabel.rightAnchor, constant: 0).isActive = true
        nameTextFiled.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        nameTextFiled.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        
        view.addSubview(datePicker)
        datePicker.topAnchor.constraint(equalTo: nameLabel.bottomAnchor).isActive = true
        datePicker.rightAnchor.constraint(equalTo: lightBlueView.rightAnchor).isActive = true
        datePicker.leftAnchor.constraint(equalTo: lightBlueView.leftAnchor).isActive = true
        datePicker.bottomAnchor.constraint(equalTo: lightBlueView.bottomAnchor).isActive = true


    }
    

}
