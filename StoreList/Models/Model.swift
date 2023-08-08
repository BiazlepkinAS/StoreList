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
    let url = FileManager.default.urls(for: .libraryDirectory, in: .userDomainMask)[0].appending(path: "ownDataBase.data")
    var items: [StoreListItem] = []
    init() {
        loadData()
    }
    
    func addItem(title: String) {
        items.append(StoreListItem(title: title, date: Date(), isCompleted: false))
        saveData()
    }
    
    func deleteItem(atIndex index: Int) {
        items.remove(at: index)
        saveData()
    }
    
    func renameItem(atIndex index: Int, newTitle: String){
        items[index].title = newTitle
        saveData()
    }
    
    func toggleItems(atIndex index: Int) {
        items[index].isCompleted.toggle()
        saveData()
    }
    
    private func saveData() {
        let data = try? JSONEncoder().encode(items)
        try? data?.write(to: url)
    }
    
    private func loadData() {
        if let data = try? Data(contentsOf: url) {
            items = (try? JSONDecoder().decode([StoreListItem].self, from: data)) ?? []
        }
    }
    
}
