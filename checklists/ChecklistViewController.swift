//
//  ViewController.swift
//  checklists
//
//  Created by Tim Fosteman on 2020-01-07.
//  Copyright © 2020 Fostemans. All rights reserved.
//

import UIKit

class ChecklistViewController: UITableViewController {

    var items = [ChecklistItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    // MARK:- Table View Data Source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChecklistItem", for: indexPath)
        let item = items[indexPath.row]
        configureText(for: cell, with: item)
        configureCheckmark(for: cell, with: item)
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
        if item.checked {
            c.accessoryType = .checkmark
        } else {
            c.accessoryType = .none
        }
    }
    
    func configureText(for cell: UITableViewCell, with item: ChecklistItem) {
        let label = cell.viewWithTag(1) as! UILabel
        label.text = item.text
    }
    
    //MARK:- Actions
    @IBAction func addItem() {
        let newRowIndex = items.count
        
        let item = ChecklistItem()
        item.text = "new row"
        items.append(item)
        
        let indexPath = IndexPath(row: newRowIndex, section: 0)
        let indexPaths = [indexPath]
        tableView.insertRows(at: indexPaths, with: .automatic)
    }
}

