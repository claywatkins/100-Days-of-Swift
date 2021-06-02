//
//  ContentView.swift
//  WeSplit
//
//  Created by Clayton Watkins on 5/28/21.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = ""
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 2
    @State private var numberOfPeopleString = "4"
    @State private var useRedText = false


    let tipPercentages = [10, 15, 20, 25, 0]
    var tipSelection: Int {
        let tipSelection = tipPercentages[tipPercentage]
        return tipSelection
    }
    
    var totalPerPerson: Double {
        let peopleCount = Double(Int(numberOfPeopleString) ?? 0)
        let tipSelection = Double(tipPercentages[tipPercentage])
        let orderAmount = Double(checkAmount) ?? 0
        let tipValue = orderAmount / 100 * tipSelection
        let grandTotal = orderAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount
        checkSelection()
        return amountPerPerson
    }
    var grandTotal: Double {
        let tipSelection = Double(tipPercentages[tipPercentage])
        let orderAmount = Double(checkAmount) ?? 0
        let tipValue = orderAmount / 100 * tipSelection
        let grandTotal = orderAmount + tipValue
        return grandTotal
    }
    
    func checkSelection() {
        if tipSelection == 0 {
            DispatchQueue.main.async {
                useRedText = true
            }
        } else {
            DispatchQueue.main.async {
                useRedText = false
            }
        }
    }
    
    var body: some View {
        NavigationView {
            Form{
                Section {
                    TextField("Amount", text: $checkAmount)
                        .keyboardType(.decimalPad)
                    // Using a Picker
//                    Picker("Number of People:", selection: $numberOfPeople) {
//                        ForEach(2..<100) {
//                            Text("\($0) people")
//                        }
//                    }
                    
                    // Challenge: Use a textfield
                    TextField("Number of People", text: $numberOfPeopleString)
                        .keyboardType(.decimalPad)
                }
            
                Section(header: Text("How much tip percentage?")){
                        Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(0 ..< tipPercentages.count){
                            Text("\(self.tipPercentages[$0])%")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text("Amount per person:")) {
                    Text("$\(totalPerPerson, specifier: "%.2f")")
                        .foregroundColor(useRedText ? .red : .black)
                }
                
                Section(header: Text("Total check amount")) {
                    Text("$\(grandTotal, specifier: "%.2f")")
                        .foregroundColor(useRedText ? .red : .black)
                }
            }
            .navigationTitle("We Split")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
