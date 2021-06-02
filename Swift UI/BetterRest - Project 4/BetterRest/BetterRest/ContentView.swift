//
//  ContentView.swift
//  BetterRest
//
//  Created by Clayton Watkins on 5/29/21.
//

import SwiftUI

struct ContentView: View {
    @State private var sleepAmount = 8.0
    @State private var wakeUp = defaultWakeTime
    @State private var coffeeAmount = 1
    @State private var testDate = Date()
    @State private var bedTime = ""
    
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showingAlert = false
    
    static var defaultWakeTime: Date {
        var dateComponents = DateComponents()
        dateComponents.hour = 7
        dateComponents.minute = 0
        return Calendar.current.date(from: dateComponents) ?? Date()
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("When do you want to wake up?")) {
                    DatePicker("Please enter a time:",
                               selection:$wakeUp,
                               displayedComponents: .hourAndMinute)
                }
                Section(header: Text("Desired Amount of Sleep")) {
                    Stepper("\(sleepAmount, specifier: "%g") hours", value: $sleepAmount, in: 4...12, step: 0.25)
                }
                Section(header: Text("Daily Coffee Intake")) {
//                    Stepper(value: $coffeeAmount, in: 1...20) {
//                        if coffeeAmount == 1 {
//                            Text("1 cup")
//                        } else {
//                            Text("\(coffeeAmount) cups")
//                        }
//                    }
                    // MARK: - Challenge: Use a picker
                    Picker( "Amount of Coffee: ", selection: $coffeeAmount) {
                        ForEach(1 ..< 7) {
                            if $0 == 1{
                                Text("\($0) cup")
                            } else {
                                Text("\($0) cups")
                            }
                        }
                    }
                }
                
                // MARK: - Challenge: Dynamically show recommeded bedtime
                Section(header: Text("Recommended Bed Time")) {
                    let bedTime = calculateBedtime()
                    Text("Your recommened bedtime is: \(bedTime) ")
                        .font(.headline)
                }
            }
            .navigationBarTitle("Better Rest")
//            .navigationBarItems(trailing:
//                                    Button(action: calculateBedtime) {
//                                        Text("Calculate")
//                                    }
//                                    .alert(isPresented: $showingAlert) {
//                                        Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("Okay")))
//                                    }
//            )
        }
    }
    
    
    func calculateBedtime() -> String {
        let model = SleepCalculator()
        let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
        let hour = (components.hour ?? 0) * 60 * 60
        let minute = (components.minute ?? 0) * 60
        
        do {
            let predicition = try model.prediction(wake: Double(hour+minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
            let sleepTime = wakeUp - predicition.actualSleep
            let dateFormatter = DateFormatter()
            dateFormatter.timeStyle = .short
//            alertMessage = dateFormatter.string(from: sleepTime)
//            alertTitle = "Your ideal bedtime is..."
            return dateFormatter.string(from: sleepTime)
        } catch {
            print("Error getting prediction: \(error)")
            alertTitle = "Error"
            alertMessage = "Error getting predicition"
        }
//        showingAlert = true
        return "Error"
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

