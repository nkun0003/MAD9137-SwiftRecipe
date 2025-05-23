//
//  RecipeListView.swift
//  MAD9137-SwiftRecipe
//
//  Created by Rocien Nkunga on 23/10/2024.
//

import SwiftUI

struct RecipeListView: View {
    // list of the recipes
    @State private var recipes: [Recipe] = [
        Recipe(
            title: "Spaghetti",
            description: "Classic Italian pasta.",
            ingredients: ["Pasta", "Tomato Sauce"],
            steps: ["Boil pasta", "Add sauce", "Serve hot"],
            imageName: "spaghetti"
        ),
        Recipe(
            title: "Pancakes",
            description: "Fluffy breakfast pancakes.",
            ingredients: ["Flour", "Eggs", "Milk"],
            steps: ["Mix ingredients", "Cook on pan", "Serve hot"],
            imageName: "pancakes"
        ),
        Recipe(
            title: "Grilled Cheese Sandwich",
            description: "Crispy and melty sandwich.",
            ingredients: ["Bread", "Cheese", "Butter"],
            steps: ["Butter the bread", "Add cheese", "Grill until golden brown"],
            imageName: "grilledcheesesandwich"
        ),
        Recipe(
            title: "Chicken Curry",
            description: "A spicy and flavorful curry.",
            ingredients: ["Chicken", "Curry powder", "Coconut milk", "Onions"],
            steps: ["Cook onions", "Add chicken and spices", "Simmer in coconut milk"],
            imageName: "Chicken Curry"
        ),
        Recipe(
            title: "Caesar Salad",
            description: "A fresh and crunchy salad.",
            ingredients: ["Romaine lettuce", "Croutons", "Parmesan", "Caesar dressing"],
            steps: ["Chop lettuce", "Add croutons and Parmesan", "Drizzle dressing"],
            imageName: "Caesar Salad"
        ),
        Recipe(
            title: "Beef Tacos",
            description: "Mexican street food favorite.",
            ingredients: ["Taco shells", "Ground beef", "Lettuce", "Cheese", "Salsa"],
            steps: ["Cook ground beef", "Fill taco shells", "Add toppings"],
            imageName: "Beef Tacos"
        ),

        Recipe(
            title: "Avocado Toast",
            description: "A healthy breakfast option.",
            ingredients: ["Bread", "Avocado", "Salt", "Pepper", "Lemon juice"],
            steps: ["Toast bread", "Mash avocado with seasoning", "Spread on toast"],
            imageName: "Avocado Toast"
        ),
        Recipe(
            title: "Tomato Soup",
            description: "A warm and comforting soup.",
            ingredients: ["Tomatoes", "Onion", "Garlic", "Vegetable broth"],
            steps: ["Sauté onions and garlic", "Add tomatoes and broth", "Blend until smooth"],
            imageName: "Tomato Soup"
        ),
        Recipe(
            title: "Chocolate Chip Cookies",
            description: "Crispy on the outside, chewy on the inside.",
            ingredients: ["Flour", "Butter", "Sugar", "Chocolate chips"],
            steps: ["Mix ingredients", "Scoop onto baking tray", "Bake until golden"],
            imageName: "Chocolate Chip Cookies"
        ),
    ]

    @State private var searchText: String = ""
    @State private var showingAddRecipe = false // state just to track if add view is shown

    // this statement simply says if there is not input on the search bar then the full list of recipe is shown, otherwise
    var filteredRecipes: [Recipe] {
        if searchText.isEmpty {
            return recipes
        } else {
            return recipes.filter { $0.title.contains(searchText) }
        }
    }

    var body: some View {
        NavigationView {
            VStack {
                // Filter recipes
                TextField("Search Recipes...", text: $searchText)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())

                // list of recipes
                List {
                    ForEach(filteredRecipes) { recipe in
                        NavigationLink(destination: RecipeDetailView(recipe: recipe, recipes: $recipes)) { // added recipe: recipe and the other one for RecipeDetails parameter as RecipeDetailView is designed to display the details of specific
                            HStack {
                                Image(recipe.imageName)
                                    .resizable()
                                    .frame(width: 100, height: 100)
                                    .clipShape(Circle())

                                VStack(alignment: .leading) {
                                    Text(recipe.title).font(.headline)
                                    Text(recipe.description).font(.subheadline).foregroundColor(.gray)
                                }
                            }
                        }
                    }
                }
                .navigationTitle("Recipes")

                VStack {
                    Button(action: {
                        showingAddRecipe = true
                    }) {
                        Image(systemName: "plus.circle.fill")
                            .font(.largeTitle)
                            .foregroundColor(.green)
                    }
                    Text("Add Recipe")
                        .font(.caption)
                        .foregroundColor(.black)
                }

                // this .sheet presents the AddRecipeView as a modal
                .sheet(isPresented: $showingAddRecipe) {
                    AddRecipeView(recipes: $recipes)
                }
            }
        }
    }
}

#Preview {
    RecipeListView()
}
