//
//  DataManager.swift
//  TestData
//
//  Created by Serhii on 27.11.2024.
//

import SwiftData
import CloudKit

final class DataManager {
    private let modelContext: ModelContext
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }
    
    func save(_ item: Item) {
        modelContext.insert(item)
        saveContext()
    }
    
    func delete(_ item: Item) {
        modelContext.delete(item)
        saveContext()
    }
    
    func fetchItems() -> [Item] {
        let descriptor = FetchDescriptor<Item>()
        return (try? modelContext.fetch(descriptor)) ?? []
    }
    
    private func saveContext() {
        do {
            try modelContext.save()
        } catch {
            print("Ошибка сохранения данных: \(error.localizedDescription)")
        }
    }
    
    func syncWithCloudKit() {
        let container = CKContainer.default()
        container.accountStatus { status, error in
            if let error = error {
                print("Ошибка проверки iCloud: \(error.localizedDescription)")
                return
            }
            if status == .available {
                print("iCloud доступен.")
            } else {
                print("iCloud недоступен.")
            }
        }
    }
}
