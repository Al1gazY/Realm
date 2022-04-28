//
//  ViewViewController.swift
//  RMLab
//
//  Created by Aligazy Kismetov on 28.04.2022.
//

import UIKit
import RealmSwift

class ViewViewController: UIViewController {

    @IBOutlet weak var dateL: UILabel!
    @IBOutlet weak var itemL: UILabel!
    public var item: ToDoListItem?
    public var deletionHandler: (() -> Void)?
    
    private let realm = try! Realm()
    
    static let dateFormatter: DateFormatter = {
        let dateformatter = DateFormatter()
        dateformatter.dateStyle = .medium
        return dateformatter
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        itemL.text = item?.item
        dateL.text = Self.dateFormatter.string(from: item!.date)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(Diddelete))
        // Do any additional setup after loading the view.
    }
    
    @objc private func Diddelete(){
        guard let myItem = self.item else{
            return
        }
        
        realm.beginWrite()
        realm.delete(myItem)
        
        try! realm.commitWrite()
        
        deletionHandler?()
        navigationController?.popToRootViewController(animated: true)
    }
    



}
