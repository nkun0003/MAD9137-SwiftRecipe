//
//  RecipeDetailView.swift
//  MAD9137-SwiftRecipe
//
//  Created by Rocien Nkunga on 23/10/2024.
//

import SwiftUI

struct RecipeDetailView: View {
    var recipe: Recipe // this is the selected recipe
    @Binding var recipes: [Recipe] // binding to modify the original recipes array
    @Environment(\.presentationMode) var presentationMode // this just to dismiss the view

    @State private var showingActionSheet = false // state to show ActionSheet

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                Text("Ingredients")
                    .font(.headline)
                    .frame(maxWidth: .infinity, alignment: .leading)

                ForEach(recipe.ingredients, id: \.self) { ingredient in
                    Text("• \(ingredient)")
                        .frame(maxWidth: .infinity, alignment: .leading)
                }

                Text("Steps")
                    .font(.headline)
                    .padding(.top)
                    .frame(maxWidth: .infinity, alignment: .leading)

                ForEach(recipe.steps, id: \.self) { step in
                    Text(step)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
            .padding()

            Spacer()

            // the delete button that triggers the ActionSheet
            Button(action: {
                showingActionSheet = true // when click show the ActionSheet
            }) {
                Text("Delete Recipe")
                    .padding()
                    .background(Color.red)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding()
            .actionSheet(isPresented: $showingActionSheet) {
                ActionSheet(
                    title: Text("Confirm Delete"),
                    message: Text("Are you sure you want to delete this recipe?"),
                    buttons: [
                        .destructive(Text("Delete")) {
                            deleteRecipe() // here calling delete function if confirmed
                        },
                        .cancel()
                    ]
                )
            }
            .padding()
        }
        .navigationTitle(recipe.title)
    }

    // function to delete the recipe and dismiss the view
    private func deleteRecipe() {
        if let index = recipes.firstIndex(where: { $0.id == recipe.id }) {
            recipes.remove(at: index)
            presentationMode.wrappedValue.dismiss() // dismiss the view after deletion
        }
    }
}
