//
//  AllListsViewController.swift
//  checklists
//
//  Created by Tim Fosteman on 2020-01-08.
//  Copyright © 2020 Fostemans. All rights reserved.
//

import UIKit

class AllListsViewController: UITableViewController, ListDetailViewControllerDelegate {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) { //Any는 모든 유형의 객체가 될 수 있다. 캐스팅 해서 사용
        if segue.identifier == "Show Checklist" {
            let controller = segue.destination as! ChecklistViewController //세그의 목적 뷰 컨트롤러를 캐스팅
            controller.checklist = sender as? Checklist //sender로 넘어온 객체를 캐스팅
        } else if segue.identifier == "Add Checklist" {
            let controller = segue.destination as! ListDetailViewController
            controller.delegate = self
        } else if segue.identifier == "Edit Checklist" {
            let controller = segue.destination as! ListDetailViewController
            controller.delegate = self
            controller.checklistToEdit = sender as! Checklist
        }
    }
    
    func listDetailViewControllerCancel(_ controller: ListDetailViewController) {
        navigationController?.popViewController(animated: true)
    }
    
    func listDetailViewController(_ controller: ListDetailViewController, didFinishAdding checklist: Checklist) {
        let newRowI = lists.count
        lists.append(checklist)
        let indexPath = IndexPath(row: newRowI, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
        
        navigationController?.popViewController(animated: true)
    }
    
    func listDetailViewController(_ controller: ListDetailViewController, didFinishEditing checklist: Checklist) {
        if let index = lists.firstIndex(of: checklist) {
            let indexPath = IndexPath(row: index, section: 0)
            if let cell = tableView.cellForRow(at: indexPath) {
                cell.textLabel!.text = checklist.name
            }
        }
        navigationController?.popViewController(animated: true)
    }
    
    var lists = Array<Checklist>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "ChecklistCell")
        
        var list = Checklist(name: "1")
        lists.append(list)
        list = Checklist(name: "2")
        lists.append(list)
    }

    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lists.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChecklistCell", for: indexPath)
        
        let checklist = lists[indexPath.row]
        cell.textLabel!.text = checklist.name
        cell.accessoryType = .detailDisclosureButton
        
        return cell
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        lists.remove(at: indexPath.row)
        
        tableView.deleteRows(at: [indexPath], with: .automatic)
    }
    // MARK: - Navigation

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let checklist = lists[indexPath.row]
        
        performSegue(withIdentifier: "Show Checklist", sender: checklist)
    }
    
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        let controller = storyboard!.instantiateViewController(withIdentifier: "ListDetailViewController") as! ListDetailViewController
        controller.delegate = self
        let checklist = lists[indexPath.row]
        controller.checklistToEdit = checklist
        navigationController?.pushViewController(controller, animated: true)
    }
    
    
    

}
