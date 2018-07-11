//
//  CreateCompanyController.swift
//  ElvotraCoreData
//
//  Created by Mohammad Farhoudi on 10/07/2018.
//  Copyright © 2018 Elvotra. All rights reserved.
//

import UIKit


class CreateCompanyController: UIViewController {
    
    var company: Company?
    
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        setupNavigationBarCancel()
        navigationItem.title = "Create Company"
        view.backgroundColor = UIColor.darkGreen
    
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(handleSave))
        
        
        setUpUI()
    }
    
    
    @objc func handleSave() {
        
        guard let nameTextFieldOutput = nameTextFiled.text else {return}
        let error = CoreDataManager.sharedInstance.createEmployee(employeeName: nameTextFieldOutput)
        
        if let error = error {
            
            print("error")
        } else {
            dismiss(animated: true, completion: nil)

        }
        

    }
    
    
    func setUpUI() {
        
        let lightBlueView = setupLightBlueView(height: 50)

        view.addSubview(nameLabel)
//        nameLabel.topAnchor.constraint(equalTo: lightBlueView.bottomAnchor, constant: 0).isActive = true
        nameLabel.leftAnchor.constraint(equalTo: lightBlueView.leftAnchor, constant: 16).isActive = true
        nameLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        nameLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        
        view.addSubview(nameTextFiled)
        nameTextFiled.topAnchor.constraint(equalTo: nameLabel.topAnchor, constant: 0).isActive = true
        nameTextFiled.leftAnchor.constraint(equalTo: nameLabel.rightAnchor, constant: 0).isActive = true
        nameTextFiled.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        nameTextFiled.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
}
