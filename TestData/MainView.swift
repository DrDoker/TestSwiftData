//
//  MainView.swift
//  TestData
//
//  Created by Serhii on 28.11.2024.
//


import SwiftUI

struct MainView: View {
    @Environment(\.modelContext) private var modelContext
    
    var body: some View {
        TabView {
            FirstView(modelContext: modelContext)
                .tabItem {
                    Label("First", systemImage: "1.circle")
                }
            
            SecondView()
                .tabItem {
                    Label("Second", systemImage: "2.circle")
                }
        }
    }
}
