//
//  ContentView.swift
//  UnitConverter
//
//  Created by Kevin Hoàng on 03.05.21.
//

import SwiftUI

struct ContentView: View {
    
    @State private var input = ""
    @State private var inputUnit = 0
    @State private var outputUnit = 1
    private let units = ["Celsius", "Fahrenheit", "Kelvin"]
    
    var convertedValue: Double {
        switch inputUnit {
        case 0:
            // unit is c
            switch outputUnit {
            case 1:
                // make f
                guard let input = Double(input) else {return 0}
                return input * 1.8 + 32
            case 2:
                // make k
                guard let input = Double(input) else {return 0}
                return input + 273.15
            default:
                return Double(input) ?? 0
            }
        case 1:
            // unit is f
            switch outputUnit {
            case 0:
                // make c
                guard let input = Double(input) else {return 0}
                let minuend = input - 32
                return minuend / 1.8
            case 2:
                // make k
                guard let input = Double(input) else {return 0}
                let minuend = input - 32
                return minuend / 1.8 + 273.15
            default:
                return Double(input) ?? 0
            }
        default:
            // unit is k
            switch outputUnit {
            case 0:
                // make c
                guard let input = Double(input) else {return 0}
                return input - 273.15
            case 1:
                // make f
                guard let input = Double(input) else {return 0}
                let minuend = input - 32
                return minuend / 1.8 - 273.15
            default:
                return Double(input) ?? 0
            }
        }
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Temperature", text: $input)
                        .keyboardType(.decimalPad)
                }
                
                Section(header: Text("Convert from")) {
                    Picker("Input Unit", selection: $inputUnit) {
                        ForEach(0..<units.count) {
                            Text("\(units[$0])")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text("To")) {
                    Picker("Input Unit", selection: $outputUnit) {
                        ForEach(0..<units.count) {
                            Text("\(units[$0])")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text("Converted value")) {
                    Text("\(convertedValue, specifier: "%.2f") \(units[outputUnit])")
                }
            }
            .navigationTitle("Converter")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
