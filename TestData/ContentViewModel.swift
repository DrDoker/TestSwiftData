//
//  ContentViewModel.swift
//  TestData
//
//  Created by Serhii on 27.11.2024.
//

import SwiftUI

@MainActor
@Observable
final class ContentViewModel {
    private let dataSource: DataSource = DataSource.shared
    var items: [Item] = []

    init() {
        loadItems()
    }

    func loadItems() {
        items = dataSource.fetchItems()
    }

    func addItem() {
        let newItem = Item(timestamp: Date())
        dataSource.addItem(newItem)
        loadItems()
    }

    func deleteItems(at offsets: IndexSet) {
        for index in offsets {
            let item = items[index]
            dataSource.deleteItem(item)
        }
        loadItems()
    }
}
