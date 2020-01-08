//
//  ViewController.swift
//  checklists
//
//  Created by Tim Fosteman on 2020-01-07.
//  Copyright © 2020 Fostemans. All rights reserved.
//

import UIKit

class ChecklistViewController: UITableViewController, itemDetailTableViewControllerDelegate {

    var items = [ChecklistItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Add Item Segue" {
            let controller = segue.destination as! ItemDetailViewController
            controller.delegate = self
        } else if segue.identifier == "Edit Item Segue" {
            let controller = segue.destination as! ItemDetailViewController
            controller.delegate = self
            
            if let indexPath = tableView.indexPath(for: sender as! UITableViewCell) {
                controller.itemToEdit = items[indexPath.row]
            }
        }
    }
    
    // MARK:- Table View Data Source
    func addItemDidCancel(_ controller: ItemDetailViewController) {
        navigationController?.popViewController(animated: true)
    }
    
    func addItem(_ controller: ItemDetailViewController, didFinishAdding item: ChecklistItem) {
        let newRowIndex = items.count
        items.append(item)
        let indexPath = IndexPath(row: newRowIndex, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
        
        navigationController?.popViewController(animated: true)
    }
    func addItem(_ controller: ItemDetailViewController, didFinishEditing item: ChecklistItem) {
        if let index = items.firstIndex(of: item) {
            let indexPath = IndexPath(row: index, section: 0)
            if let cell = tableView.cellForRow(at: indexPath) {
                configureText(for: cell, with: item)
            }
        }
        navigationController?.popViewController(animated: true)
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChecklistItem", for: indexPath)
        let item = items[indexPath.row]
        configureCheckmark(for: cell, with: item)
        configureText(for: cell, with: item)
        
        return cell
    }

    override func tableView(_ t: UITableView, didSelectRowAt i: IndexPath) {
        if let cell = t.cellForRow(at: i) {
            let item = items[i.row]
            item.toggleChecked()
            configureCheckmark(for: cell, with: item)
        }
        t.deselectRow(at: i, animated: true)
    }
    
    override func tableView(_ t: UITableView, commit editionStyle: UITableViewCell.EditingStyle, forRowAt i: IndexPath) {
        items.remove(at: i.row)
        let indexPaths = [i]
        tableView.deleteRows(at: indexPaths, with: .automatic)
    }
   
    func configureCheckmark(for c: UITableViewCell, with item: ChecklistItem) {
        let label = c.viewWithTag(3) as! UILabel
        
        if item.checked {
            label.text = "√"
        } else {
            label.text = ""
        }
    }
    
    func configureText(for c: UITableViewCell, with item: ChecklistItem) {
        
        let label = c.viewWithTag(4) as! UILabel
        
        label.text = item.text
    }
    
    
}

