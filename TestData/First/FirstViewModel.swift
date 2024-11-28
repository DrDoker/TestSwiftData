//
//  ContentViewModel.swift
//  TestData
//
//  Created by Serhii on 27.11.2024.
//

import SwiftUI
import SwiftData

final class FirstViewModel: ObservableObject {
    private let dataManager: DataManager
    @Published var items: [Item] = []
    
    init(modelContext: ModelContext) {
        self.dataManager = DataManager(modelContext: modelContext)
        fetchItems()
    }
    
    func fetchItems() {
        items = dataManager.fetchItems()
    }
    
    func addItem() {
        let newItem = Item(timestamp: Date())
        dataManager.save(newItem)
        fetchItems()
    }
    
    func deleteItems(at offsets: IndexSet) {
        for index in offsets {
            let item = items[index]
            dataManager.delete(item)
        }
        fetchItems()
    }
    
    func syncCloudKit() {
        dataManager.syncWithCloudKit()
    }
}
