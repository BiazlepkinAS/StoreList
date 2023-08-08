//
//  Model.swift
//  StoreList
//
//  Created by Andrei Bezlepkin on 8.08.23.
//

import UIKit

class StoreListItem: Codable {
    
    var title: String
    var date: Date
    var isCompleted: Bool
    
    init(title: String, date: Date, isCompleted: Bool) {
        self.title = title
        self.date = date
        self.isCompleted = isCompleted
    }
}

class Model {
    
    var items: [StoreListItem] = []
    
    func addItem(title: String) {
        items.append(StoreListItem(title: title, date: Date(), isCompleted: false))
    }
    
    func deleteItem(atIndex index: Int) {
        items.remove(at: index)
    }
    
    func renameItem(atIndex index: Int, newTitle: String){
        items[index].title = newTitle
    }
    
    func toggleItems(atIndex index: Int) {
        items[index].isCompleted.toggle()
    }
    
}
