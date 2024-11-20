//
//  TransactionsModel.swift
//  Safe
//
//  Created by VL on 15/11/2024.
//

import SwiftUI

struct Transaction: Identifiable, Hashable {
    let id = UUID() // Уникальный идентификатор
    let amount: Double
//    let category: CategoryModel
//    let date: Date
}

//class TransactionsModel: ObservableObject {
//    @Published var transactions: [Transaction] = [Transaction(amount: 4000, category: CategoryModel, date: Date())]
//}

class TransactionsModel: ObservableObject {
    @Published var transactions: [Transaction] = [Transaction(amount: 3400), Transaction(amount: -45.37), Transaction(amount: -24.73), Transaction(amount: -12.45), Transaction(amount: -36.20), Transaction(amount: -48.96), Transaction(amount: -12.48), Transaction(amount: -49.96), Transaction(amount: 4900), Transaction(amount: -25.13), Transaction(amount: -14.98), Transaction(amount: -24.63), Transaction(amount: -37.70), Transaction(amount: -11.90), Transaction(amount: -38.25)]
}
