//
//  RecipeDetailView.swift
//  MAD9137-SwiftRecipe
//
//  Created by Rocien Nkunga on 23/10/2024.
//

import SwiftUI

struct RecipeDetailView: View {
    var recipe: Recipe // this is the selected recipe

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                Text("Ingredients").font(.headline)
                ForEach(recipe.ingredients, id: \.self) { ingredient in
                    Text("• \(ingredient)")
                }

                Text("Steps").font(.headline).padding(.top)
                ForEach(recipe.steps, id: \.self) { step in
                    Text(step)
                }
            }
            .padding()
        }
        .navigationTitle(recipe.title)
    }
}
