//
//  TransactionsList.swift
//  Safe
//
//  Created by VL on 15/11/2024.
//

import SwiftUI

struct TransactionsList: View {
    
    @StateObject var trModel: TransactionsModel
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                ForEach(trModel.transactions.reversed(), id: \.self) { transaction in
                    Text("\(transaction.amount, specifier: "%.2f")")
                        .font(.title)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                }
            }
            .padding(.horizontal)
        }
        .frame(maxWidth: .infinity)
        .padding(.top, 40)
        
    }
}

#Preview {
    let testModel = TransactionsModel()
    testModel.transactions = [
        Transaction(amount: 23.09),
        Transaction(amount: -45.50),
        Transaction(amount: 100.00)
    ] // Пример данных для предпросмотра
    return TransactionsList(trModel: testModel)
}
