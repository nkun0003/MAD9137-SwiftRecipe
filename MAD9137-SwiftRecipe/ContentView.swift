//
//  ContentView.swift
//  MAD9137-SwiftRecipe
//
//  Created by Rocien Nkunga on 23/10/2024.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            RecipeListView()
                .navigationTitle("Recipe List")
        }
    }
}

#Preview {
    ContentView()
}
