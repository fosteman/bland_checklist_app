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
    @IBOutlet weak var itemName: UITextField!
    weak var delegate: AddItemTableViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //disable large title
        navigationItem.largeTitleDisplayMode = .never
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    //MARK: - Table view polishing
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        itemName.becomeFirstResponder()
    }
    
    // MARK: - Table view data source
    
    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return nil
    }
    
    // MARK:- Actions
    
    @IBAction func done() {
        let item = ChecklistItem()
        item.text = itemName.text!
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
