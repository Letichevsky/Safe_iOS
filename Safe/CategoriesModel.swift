//
//  CategoriesModel.swift
//  Safe
//
//  Created by VL on 15/11/2024.
//

import SwiftUI

struct CategoryModel: Hashable {
    let categoryTitle: String
    let categoryImage: String
}

class ExpenseCategoriesModel: ObservableObject {
    @Published var categories: [CategoryModel] = [
        CategoryModel(categoryTitle: "Home", categoryImage: "house.fill"),
        CategoryModel(categoryTitle: "Car", categoryImage: "car.side.fill"),
        CategoryModel(categoryTitle: "Food", categoryImage: "fork.knife"),
        CategoryModel(categoryTitle: "Fuel", categoryImage: "fuelpump.fill"),
        CategoryModel(categoryTitle: "Coffee", categoryImage: "cup.and.saucer.fill"),
        CategoryModel(categoryTitle: "Sport", categoryImage: "figure.highintensity.intervaltraining"),
        CategoryModel(categoryTitle: "Travel", categoryImage: "airplane"),
        CategoryModel(categoryTitle: "Transport", categoryImage: "cablecar.fill"),
        CategoryModel(categoryTitle: "Media", categoryImage: "wifi"),
        CategoryModel(categoryTitle: "Add new", categoryImage: "plus.circle.fill")
    ]
}

class IncomeCategoriesModel: ObservableObject {
    @Published var categories: [CategoryModel] = [
        CategoryModel(categoryTitle: "Job", categoryImage: "building.2.fill"),
        CategoryModel(categoryTitle: "Deposit", categoryImage: "building.columns.fill"),
        CategoryModel(categoryTitle: "Cripto", categoryImage: "bitcoinsign.circle.fill"),
        CategoryModel(categoryTitle: "Hobby", categoryImage: "figure.badminton"),
        CategoryModel(categoryTitle: "Add new", categoryImage: "plus.circle.fill")
    ]
}
