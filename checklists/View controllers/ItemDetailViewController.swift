//
//  itemDetailTableViewController.swift
//  checklists
//
//  Created by Tim Fosteman on 2020-01-07.
//  Copyright © 2020 Fostemans. All rights reserved.
//

import UIKit

protocol itemDetailTableViewControllerDelegate: class {
    func addItemDidCancel(_ controller: ItemDetailViewController)
    func addItem(_ controller: ItemDetailViewController, didFinishAdding item: ChecklistItem)
    func EditItem(_ controller: ItemDetailViewController, didFinishEditing item: ChecklistItem)
}

class ItemDetailViewController: UITableViewController, UITextFieldDelegate {

    @IBOutlet weak var doneBarButton: UIBarButtonItem!
    @IBOutlet weak var itemDescription: UITextField!
    weak var delegate: itemDetailTableViewControllerDelegate?
    var itemToEdit: ChecklistItem?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
        if let item = itemToEdit {
            navigationItem.title = "Edit Item"
            itemDescription.text = item.text
            doneBarButton.isEnabled = true
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
        if let item = itemToEdit {
            item.text = itemDescription.text!
            delegate?.EditItem(self, didFinishEditing: item)
        } else {
            let item = ChecklistItem()
            item.text = itemDescription.text!
            delegate?.addItem(self, didFinishAdding: item)
        }
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
