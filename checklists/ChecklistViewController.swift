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
}

