//
//  Recipe.swift
//  MAD9137-SwiftRecipe
//
//  Created by Rocien Nkunga on 23/10/2024.
//

import Foundation //imported this cause it is the framework which will allow access to UUID

// my recipe model to store the details of a recipe
struct Recipe: Identifiable {
    var id = UUID() // Unique ID for each recipe
    var title: String // Recipe title
    var description: String // Short description
    var ingredients: [String] // List of ingredients
    var steps: [String] // List of steps to prepare the recipe
    var imageName: String
}
