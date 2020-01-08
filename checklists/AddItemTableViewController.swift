//
//  AddItemTableViewController.swift
//  checklists
//
//  Created by Tim Fosteman on 2020-01-07.
//  Copyright © 2020 Fostemans. All rights reserved.
//

import UIKit

protocol AddItemTableViewControllerDelegate: class {
    func addItemDidCancel(_ controller: AddItemTableViewController)
    func addItem(_ controller: AddItemTableViewController, didFinishAdding item: ChecklistItem)
}

class AddItemTableViewController: UITableViewController, UITextFieldDelegate {

    @IBOutlet weak var doneBarButton: UIBarButtonItem!
    @IBOutlet weak var itemDescription: UITextField!
    weak var delegate: AddItemTableViewControllerDelegate?
    var itemToEdit: ChecklistItem?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
        if let item = itemToEdit {
            navigationItem.title = "Edit Item"
            itemDescription.text = item.text
        }
        
    }
    //MARK: - Table view polishing
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        itemDescription.becomeFirstResponder()
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return nil
    }
    
    // MARK:- Actions
    
    @IBAction func done() {
        let item = ChecklistItem()
        item.text = itemDescription.text!
        delegate?.addItem(self, didFinishAdding: item)
    }
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        delegate?.addItemDidCancel(self)
    }
    
    //MARK: - Delegates
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let oldText = textField.text!
        let stringRange = Range(range, in: oldText)!
        let newText = oldText.replacingCharacters(in: stringRange, with: string)
        
        doneBarButton.isEnabled = !newText.isEmpty
        return true
        
    }
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        doneBarButton.isEnabled = false
        return true
    }
    
}
