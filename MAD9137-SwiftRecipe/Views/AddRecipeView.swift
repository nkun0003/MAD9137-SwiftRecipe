//
//  AddRecipeView.swift
//  MAD9137-SwiftRecipe
//
//  Created by Rocien Nkunga on 23/10/2024.
//

import SwiftUI

struct AddRecipeView: View {
    @Binding var recipes: [Recipe] // here just binding to the recipes list, just allows updating the recipes from RecipeListView
    @Environment(\.presentationMode) var presentationMode // accessing presentation state, helping on closing the form after saving etc...

    // those variables will be my inputs string type
    @State private var title: String = ""
    @State private var description: String = ""
    @State private var ingredients: String = ""
    @State private var steps: String = ""

    var body: some View {
        Form {
            Section(header: Text("Recipe Details")) {
                TextField("Title", text: $title)
                TextField("Description", text: $description)
            }

            Section(header: Text("Ingredients")) {
                TextField("Enter ingredients (comma-separated)", text: $ingredients)
            }

            Section(header: Text("Steps")) {
                TextField("Enter steps (comma-separated)", text: $steps)
            }

            Button("Save") {
                let newRecipe = Recipe(
                    title: title,
                    description: description,
                    ingredients: ingredients.split(separator: ",").map { $0.trimmingCharacters(in: .whitespaces) },
                    steps: steps.split(separator: ",").map { $0.trimmingCharacters(in: .whitespaces) }
                )
                recipes.append(newRecipe) // here appending the above recipe that was inputed
                presentationMode.wrappedValue.dismiss() // Close the view after saving
            }
        }
        .navigationTitle("Add Recipe")
    }
}
