//
//  ContentView.swift
//  TestData
//
//  Created by Serhii on 26.11.2024.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @StateObject private var viewModel: ContentViewModel
    
    init(modelContext: ModelContext) {
        _viewModel = StateObject(wrappedValue: ContentViewModel(modelContext: modelContext))
    }
    
    var body: some View {
        NavigationSplitView {
            List {
                ForEach(viewModel.items) { item in
                    NavigationLink {
                        Text("Item at \(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))")
                    } label: {
                        Text(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))
                    }
                }
                .onDelete(perform: viewModel.deleteItems)

            }
            .refreshable {
                viewModel.fetchItems()
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    Button(action: viewModel.addItem) {
                        Label("Add Item", systemImage: "plus")
                    }
                }
            }
        } detail: {
            Text("Select an item")
        }
        .onAppear {
            viewModel.syncCloudKit()
        }
    }
}

#Preview {
    let schema = Schema([
        Item.self,
    ])
    let configuration = ModelConfiguration(isStoredInMemoryOnly: true)
    let modelContainer = try! ModelContainer(for: schema, configurations: [configuration])
    ContentView(modelContext: modelContainer.mainContext)
        .modelContainer(modelContainer)
}
