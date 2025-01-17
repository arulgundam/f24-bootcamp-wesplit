//
//  ContentView.swift
//  WeSplit
//
//  Created by Arul Gundam on 10/14/2024.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    
    @FocusState private var amountIsFocused: Bool
    
    /// Bonus challenge:
    let localCurrency: FloatingPointFormatStyle<Double>.Currency = .currency(code: Locale.current.currency?.identifier ?? "USD")
    
    /// Challenge 2:
    var totalAmount: Double {
        let tipSelection = Double(tipPercentage)
        let tipValue = checkAmount / 100 * tipSelection
        
        return checkAmount + tipValue
    }

    /// Challenge 3:
//  let tipPercentages = [10, 15, 20, 25, 0]
    var totalPerPerson: Double {
        totalAmount / Double(numberOfPeople + 2)
    }

    var body: some View {
        NavigationView {
            Form {
                Section {
                    /// Bonus challenge:
                    TextField("Amount", value: $checkAmount, format: localCurrency)
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(2 ..< 100) {
                            Text("\($0) people")
                        }
                    }
//                  .pickerStyle(.navigationLink)
                }
                Section {
                    Picker("Tip percentage", selection: $tipPercentage) {
                        /// Challenge 3:
                        /* ForEach(tipPercentages, id: \.self) {
                            Text($0, format: .percent)
                        } */
                        ForEach(0 ..< 101) {
                            Text("\($0)%")
                        }
                    }
                    /// Challenge 3:
//                  .pickerStyle(.segmented)
                    .pickerStyle(.navigationLink)
                } header: {
                    Text("How much tip do you want to leave?")
                }
                /// Challenge 2:
                Section {
                    /// Bonus challenge:
                    Text(totalAmount, format: localCurrency)
                    /// Project 3, challenge 1:
                        .foregroundColor(tipPercentage == 0 ? .red : .primary)
                } header: {
                    Text("Total amount:")
                }
                Section {
                    /// Bonus challenge:
                    Text(totalPerPerson, format: localCurrency)
                /// Challenge 1:
                } header: {
                    Text("Amount per person:")
                }
            }
            .navigationTitle("WeSplit")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
