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
            steps: ["Boil pasta", "Add sauce", "Serve hot"]
        ),
        Recipe(
            title: "Pancakes",
            description: "Fluffy breakfast pancakes.",
            ingredients: ["Flour", "Eggs", "Milk"],
            steps: ["Mix ingredients", "Cook on pan", "Serve hot"]
        ),
        Recipe(
            title: "Grilled Cheese Sandwich",
            description: "Crispy and melty sandwich.",
            ingredients: ["Bread", "Cheese", "Butter"],
            steps: ["Butter the bread", "Add cheese", "Grill until golden brown"]
        ),
        Recipe(
            title: "Chicken Curry",
            description: "A spicy and flavorful curry.",
            ingredients: ["Chicken", "Curry powder", "Coconut milk", "Onions"],
            steps: ["Cook onions", "Add chicken and spices", "Simmer in coconut milk"]
        ),
        Recipe(
            title: "Caesar Salad",
            description: "A fresh and crunchy salad.",
            ingredients: ["Romaine lettuce", "Croutons", "Parmesan", "Caesar dressing"],
            steps: ["Chop lettuce", "Add croutons and Parmesan", "Drizzle dressing"]
        ),
        Recipe(
            title: "Beef Tacos",
            description: "Mexican street food favorite.",
            ingredients: ["Taco shells", "Ground beef", "Lettuce", "Cheese", "Salsa"],
            steps: ["Cook ground beef", "Fill taco shells", "Add toppings"]
        ),
        Recipe(
            title: "Tomato Soup",
            description: "A warm and comforting soup.",
            ingredients: ["Tomatoes", "Onion", "Garlic", "Vegetable broth"],
            steps: ["Sauté onions and garlic", "Add tomatoes and broth", "Blend until smooth"]
        ),
        Recipe(
            title: "Chocolate Chip Cookies",
            description: "Crispy on the outside, chewy on the inside.",
            ingredients: ["Flour", "Butter", "Sugar", "Chocolate chips"],
            steps: ["Mix ingredients", "Scoop onto baking tray", "Bake until golden"]
        ),
        Recipe(
            title: "Avocado Toast",
            description: "A healthy breakfast option.",
            ingredients: ["Bread", "Avocado", "Salt", "Pepper", "Lemon juice"],
            steps: ["Toast bread", "Mash avocado with seasoning", "Spread on toast"]
        ),
        Recipe(
            title: "Stir-fried Vegetables",
            description: "A quick and healthy dish.",
            ingredients: ["Broccoli", "Carrots", "Bell peppers", "Soy sauce"],
            steps: ["Chop vegetables", "Stir-fry with soy sauce", "Serve hot"]
        ),
        Recipe(
            title: "Spaghetti Carbonara",
            description: "Classic Italian pasta with a creamy sauce.",
            ingredients: ["Spaghetti", "Eggs", "Parmesan", "Pancetta", "Black pepper"],
            steps: ["Cook pasta", "Fry pancetta", "Mix eggs and cheese", "Combine with pasta and pancetta"]
        ),
        Recipe(
            title: "Mango Smoothie",
            description: "A refreshing tropical drink.",
            ingredients: ["Mango", "Yogurt", "Honey", "Ice", "Milk"],
            steps: ["Blend all ingredients", "Serve chilled"]
        ),
        Recipe(
            title: "Veggie Omelette",
            description: "A nutritious breakfast option.",
            ingredients: ["Eggs", "Spinach", "Mushrooms", "Cheese", "Salt", "Pepper"],
            steps: ["Whisk eggs", "Cook vegetables", "Pour eggs over veggies", "Sprinkle cheese and fold"]
        )
    ]

    @State private var searchText: String = ""

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
                TextField("Search Recipes...", text: $searchText)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())

                List(filteredRecipes) { recipe in
                    NavigationLink(destination: RecipeDetailView(recipe: recipe)) {
                        VStack(alignment: .leading) {
                            Text(recipe.title).font(.headline)
                            Text(recipe.description)
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                    }
                }
                .navigationTitle("SwiftRecipe")
            }
        }
    }
}

#Preview {
    RecipeListView()
}
