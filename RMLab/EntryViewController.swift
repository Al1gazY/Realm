//
//  EntryViewController.swift
//  RMLab
//
//  Created by Aligazy Kismetov on 28.04.2022.
//

import UIKit
import RealmSwift

class EntryViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var field: UITextField!
    @IBOutlet weak var date: UIDatePicker!
    
    private let realm = try! Realm()
    public var completionHandler: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        field.becomeFirstResponder()
        field.delegate = self
        
        date.setDate(Date(), animated: true)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(save))
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        field.resignFirstResponder()
        return true
    }
    
    @objc func save(){
        if let text = field.text, !text .isEmpty{
            let date = date.date
            
            realm.beginWrite()
            
            let newItem = ToDoListItem()
            newItem.date = date
            newItem.item = text
            realm.add(newItem)
            
            try! realm.commitWrite()
            
            completionHandler?()
            navigationController?.popToRootViewController(animated: true)
        }else{
            print("Add smtg")
        }
    }
    

}
