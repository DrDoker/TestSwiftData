//
//  ContentView.swift
//  TestData
//
//  Created by Serhii on 26.11.2024.
//

import SwiftUI

struct ContentView: View {
    @State private var viewModel = ContentViewModel()

    var body: some View {
        NavigationSplitView {
            List {
                ForEach(viewModel.items) { item in
                    NavigationLink(destination: Text("Item at \(item.timestamp, format: .dateTime)")) {
                        Text(item.timestamp, format: .dateTime)
                    }
                }
                .onDelete { offsets in
                    viewModel.deleteItems(at: offsets)
                }
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
            .refreshable {
                viewModel.loadItems()
            }
        } detail: {
            Text("Select an item")
        }
    }
}
