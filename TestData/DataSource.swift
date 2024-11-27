//
//  DataSource.swift
//  TestData
//
//  Created by Serhii on 27.11.2024.
//


import Foundation
import SwiftData
import CloudKit

@MainActor
final class DataSource {
    private let modelContainer: ModelContainer
    private let modelContext: ModelContext
    
    static let shared = DataSource()
    
    private init() {
        let sharedModelContainer: ModelContainer = {
            let schema = Schema([
                Item.self
            ])
            let modelConfiguration = ModelConfiguration(
                schema: schema,
                isStoredInMemoryOnly: false
            )

            do {
                return try ModelContainer(for: schema, configurations: [modelConfiguration])
            } catch {
                fatalError("Could not create ModelContainer: \(error)")
            }
        }()
        
        modelContainer = sharedModelContainer
        modelContext = modelContainer.mainContext
    }

    func addItem(_ item: Item) {
        modelContext.insert(item)
        saveContext()
    }

    func fetchItems() -> [Item] {
        let fetchDescriptor = FetchDescriptor<Item>()
        return (try? modelContext.fetch(fetchDescriptor)) ?? []
    }

    func deleteItem(_ item: Item) {
        modelContext.delete(item)
        saveContext()
    }

    private func saveContext() {
        do {
            try modelContext.save()
        } catch {
            print("Ошибка сохранения данных: \(error.localizedDescription)")
        }
    }
}
