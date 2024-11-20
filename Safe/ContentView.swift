//
//  ContentView.swift
//  Safe
//
//  Created by VL on 14/11/2024.
//

import SwiftUI

struct ContentView: View {
    @State var balance: Double = 0

    @StateObject var trModel = TransactionsModel()
    @StateObject var expenseCatModel = ExpenseCategoriesModel()
    @StateObject var incomeCatModel = IncomeCategoriesModel()

    @State var isAddingTransaction = false
    @State var isDeductTransaction = false
    @State var newTransactionAmount = ""

    var totalBalance: Double {
        balance + trModel.transactions.reduce(0) { $0 + $1.amount }
    }
    
    @State var isTransactionList: Bool = false
    
    let columns = [
            GridItem(.flexible()),
            GridItem(.flexible()),
            GridItem(.flexible()),
            GridItem(.flexible())
        ]
    
    var body: some View {
        NavigationView {
            ZStack {
                Rectangle()
                    .fill(LinearGradient(
                        gradient: Gradient(colors: [
//                                Color(hex: "#2a5298"),
                                Color(hex: "##1e3c72"),
//                                Color(hex: "#537895"),
                                Color(hex: "#09203f")
                            ]),
                            startPoint: .top,
                            endPoint: .bottom
                    ))
                    .ignoresSafeArea()
                
                VStack(spacing: 40) {
                    Spacer()
                    
                    VStack {
                        Text("\(totalBalance, specifier: "%.2f")")
                            .font(.largeTitle)
                        Text("balance")
                    }
                    
                    Button(action: {
                        isTransactionList.toggle()
                    }, label: {
                        Text("Transactions list")
                    })
                    .sheet(isPresented: $isTransactionList, content: {
                        TransactionsList(trModel: trModel)
                    })
                    
                    Spacer()
                    
                    HStack {
                        
                        Spacer()
                        
                        ZStack {
                            Circle()
                                .fill(Material.ultraThinMaterial)
                                .frame(width: 100, height: 100)
                            Button(action: {
                                isDeductTransaction = true
                            }, label: {
                                Image(systemName: "minus")
                            })
                            .font(.largeTitle)
                            .foregroundColor(.white)
                            .frame(width: 100, height: 100)
                            .clipShape(Circle())
                        }
                        .overlay(Circle().stroke(Material.thin, lineWidth: 4))
                        .frame(width: 100, height: 100)
                        
                        Spacer()
                        
                        ZStack {
                            Circle()
                                .fill(Material.ultraThinMaterial)
                                .frame(width: 100, height: 100)
                            Button(action: {
                                isAddingTransaction = true
                            }, label: {
                                Image(systemName: "plus")
                            })
                            .font(.largeTitle)
                            .foregroundColor(.white)
                            .frame(width: 100, height: 100)
                            .clipShape(Circle())
                        }
                        .overlay(Circle().stroke(Material.thin, lineWidth: 4))
                        .frame(width: 100, height: 100)
                        
                        Spacer()
                    }
                    .frame(maxWidth: .infinity)
                }
                .navigationTitle("Safe")
                .sheet(isPresented: $isAddingTransaction) {
                        VStack(spacing: 20) {
                            Text("Введите сумму")
                                .font(.headline)
                            
                            TextField("Сумма", text: $newTransactionAmount)
                                .keyboardType(.decimalPad)
                                .padding()
                                .background(Color(.systemGray6))
                                .cornerRadius(8)
                                .padding(.horizontal)
                            
                            Button("Добавить") {
                                addBalance()
                            }
                            .padding()
                            .disabled(newTransactionAmount.isEmpty)
                            
                            ScrollView {
                                        LazyVGrid(columns: columns, spacing: 20) {
                                            ForEach(incomeCatModel.categories, id: \.self) { category in
                                                VStack(spacing: 10) {
                                                    Image(systemName: category.categoryImage)
                                                    Text(category.categoryTitle)
                                                }
                                            }
                                        }
                                        .padding()
                                    }
                        }
                        .padding(.top, 40)
                }
                .sheet(isPresented: $isDeductTransaction) {
                        VStack(spacing: 20) {
                            Text("Введите сумму")
                                .font(.headline)
                            
                            TextField("Сумма", text: $newTransactionAmount)
                                .keyboardType(.decimalPad)
                                .padding()
                                .background(Color(.systemGray6))
                                .cornerRadius(8)
                                .padding(.horizontal)
                            
                            Button("Добавить") {
                                deductBalance()
                            }
                            .padding()
                            .disabled(newTransactionAmount.isEmpty)
                            
                            ScrollView {
                                        LazyVGrid(columns: columns, spacing: 20) {
                                            ForEach(expenseCatModel.categories, id: \.self) { category in
                                                VStack(spacing: 10) {
                                                    Image(systemName: category.categoryImage)
                                                    Text(category.categoryTitle)
                                                }
                                            }
                                        }
                                        .padding()
                                    }
                        }
                        .padding(.top, 40)
                }
            }
        }
    }
    func addBalance() {
        // Заменяем запятую на точку
        let formattedAmount = newTransactionAmount.replacingOccurrences(of: ",", with: ".")
        
        if let amount = Double(formattedAmount) {
            let transaction = Transaction(amount: amount)
            trModel.transactions.append(transaction)
            newTransactionAmount = ""
            isAddingTransaction = false
        } else {
            print("Некорректный ввод")
        }
    }
    
    func deductBalance() {
        // Заменяем запятую на точку
        let formattedAmount = newTransactionAmount.replacingOccurrences(of: ",", with: ".")
        
        if let amount = Double(formattedAmount) {
            let transaction = Transaction(amount: -amount)
            trModel.transactions.append(transaction)
            newTransactionAmount = ""
            isDeductTransaction = false
        } else {
            print("Некорректный ввод")
        }
    }
}

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let r, g, b: UInt64
        switch hex.count {
        case 6: // RGB (например, #00FF00)
            (r, g, b) = ((int >> 16) & 0xFF, (int >> 8) & 0xFF, int & 0xFF)
        default:
            (r, g, b) = (0, 0, 0)
        }
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: 1
        )
    }
}

#Preview {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
