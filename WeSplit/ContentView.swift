//
//  ContentView.swift
//  WeSplit
//
//  Created by Amber Spadafora on 9/17/20.
//  Copyright © 2020 Amber Spadafora. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedStudent = 0
    @State private var checkAmount = ""
    @State private var numberOfPeople = ""
    @State private var tipPercentage = 2
    let tipPercentages = [10, 15, 20, 25, 0]
    
    var peopleCount: Double {
        return Double(numberOfPeople) ?? 1
    }
    var tipSelection: Double {
        return Double(tipPercentages[tipPercentage])
    }
    var orderAmount: Double {
        return Double(checkAmount) ?? 0
    }
    
    var tipValue: Double {
        let tipVal = orderAmount / 100 * tipSelection
        return tipVal
    }
    var totalPerPerson: Double {
        let grandTotal = tipValue + orderAmount
        let amountPerPerson = grandTotal / peopleCount
        return amountPerPerson
    }
    var grandTotal: Double {
        return tipValue + orderAmount
    }
    
    var isTipping: Bool {
        return tipPercentage == tipPercentages.count - 1 ? false : true
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount", text: $checkAmount)
                        .keyboardType(.decimalPad)
                    TextField("Number of People", text: $numberOfPeople)
                    .keyboardType(.decimalPad)
                }
                Section(header: Text("How much tip did you want to leave?")) {
                    Picker("Tip Percentage", selection: $tipPercentage) {
                        ForEach(0 ..< tipPercentages.count){
                            Text("\(self.tipPercentages[$0])%")
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                }
                Section(header: Text("Amount per person")) {
                    Text("$\(totalPerPerson, specifier: "%.2f")")
                }
                Section(header: Text("Grand Total")) {
                    Text("$\(grandTotal, specifier: "%.2f")").background(isTipping ? Color.white : Color.red)
                }
            }.navigationBarTitle("WeSplit")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
