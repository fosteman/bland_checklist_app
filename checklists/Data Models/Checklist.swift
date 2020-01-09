//
//  Checklist.swift
//  checklists
//
//  Created by Tim Fosteman on 2020-01-08.
//  Copyright © 2020 Fostemans. All rights reserved.
//

import UIKit

class Checklist: NSObject, Codable {
    var name = ""
    var items = [ChecklistItem]()
    
    init(name: String) {
        self.name = name
        super.init()
    }
}
