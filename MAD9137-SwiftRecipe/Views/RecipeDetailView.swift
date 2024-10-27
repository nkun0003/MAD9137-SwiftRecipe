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

    // State variables for edit mode and storing updated recipe details
    @State private var isEditing = false // track whether we're in edit mode
    @State private var editedTitle: String = "" // store edited title
    @State private var editedIngredients: String = "" // store edited ingredients
    @State private var editedSteps: String = "" // store edited steps
    @State private var showAlert = false
    @State private var alertMessage = ""

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                // Display the recipe image
                Image(recipe.imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: .infinity)
                    .cornerRadius(10)
                    .padding(.bottom)

                // Title TextField for editing or showing the recipe title
                if isEditing {
                    TextField("Title", text: $editedTitle)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.bottom)
                } else {
                    Text(recipe.title)
                        .font(.largeTitle)
                        .padding(.bottom)
                }

                // Ingredients Section
                Text("Ingredients")
                    .font(.headline)
                    .frame(maxWidth: .infinity, alignment: .leading)

                if isEditing {
                    TextField("Ingredients (comma-separated)", text: $editedIngredients)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                } else {
                    ForEach(recipe.ingredients, id: \.self) { ingredient in
                        Text("• \(ingredient)")
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }

                // Steps Section
                Text("Steps")
                    .font(.headline)
                    .padding(.top)
                    .frame(maxWidth: .infinity, alignment: .leading)

                if isEditing {
                    TextField("Steps (comma-separated)", text: $editedSteps)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                } else {
                    ForEach(recipe.steps, id: \.self) { step in
                        Text(step)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }
            }
            .padding()

            Spacer()

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
        .navigationTitle(isEditing ? "Edit Recipe" : "") // the condition change title based on mode
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(isEditing ? "Save" : "Edit") {
                    if isEditing {
                        saveChanges()
                    } else {
                        startEditing()
                    }
                    isEditing.toggle() // this method to toggle edit mode
                }
            }
        }
        // the delete button that triggers the ActionSheet
        VStack {
            Button(action: {
                showingActionSheet = true // when click show the ActionSheet
            }) {
                Image(systemName: "trash.circle.fill")
                    .font(.largeTitle)
                    .foregroundColor(.red)
            }
            Text("Delete Recipe")
                .font(.caption)
                .foregroundColor(.black)
        }
        .alert("Notice", isPresented: $showAlert) {
            Button("OK", role: .cancel) {
                presentationMode.wrappedValue.dismiss() // close the view after saving
            }
        } message: {
            Text(alertMessage)
        }
        .onAppear {
            // Initialize the text fields with the current recipe's data when the view appears
            editedTitle = recipe.title
            editedIngredients = recipe.ingredients.joined(separator: ", ")
            editedSteps = recipe.steps.joined(separator: ", ")
        }
        .alert("Notice", isPresented: $showAlert) {
            Button("OK", role: .cancel) {
                presentationMode.wrappedValue.dismiss() // close the view after saving
            }
        } message: {
            Text(alertMessage)
        }
    }

    // Function to delete the recipe and dismiss the view
    private func deleteRecipe() {
        if let index = recipes.firstIndex(where: { $0.id == recipe.id }) {
            recipes.remove(at: index)
            presentationMode.wrappedValue.dismiss() // Dismiss the view after deletion
        }
        alertMessage = "Recipe successful deleted!"
        showAlert = true
    }

    // Function to enter edit mode
    private func startEditing() {
        editedTitle = recipe.title
        editedIngredients = recipe.ingredients.joined(separator: ", ")
        editedSteps = recipe.steps.joined(separator: ", ")
    }

    // Function to save the changes made to the recipe
    private func saveChanges() {
        if let index = recipes.firstIndex(where: { $0.id == recipe.id }) {
            recipes[index].title = editedTitle
            recipes[index].ingredients = editedIngredients.split(separator: ",").map { $0.trimmingCharacters(in: .whitespaces) }
            recipes[index].steps = editedSteps.split(separator: ",").map { $0.trimmingCharacters(in: .whitespaces) }
        }
        alertMessage = "Recipe was successful edited!"
        showAlert = true
    }
}
