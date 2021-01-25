//
//  ContentView.swift
//  Tarefa 1
//
//  Created by Talita Groppo on 22/01/2021.
//

import SwiftUI

struct ContentView: View {
    @State private var output = 0.0
    @State private var input = ""
    @State private var inputMeasure = "ML"
    @State private var outputMeasure = "mL"
    
    let typesOfVolum = ["ML", "kL", "L", "dL", "cL", "mL"]
    
    var body: some View {
        Form {
            Section(header: Text("Input")) {
                TextField("Colocar dado para conversão", text: $input)
            }
            
            Section(header: Text("Medidas para conversão")) {
                Picker("Medida do input", selection: $inputMeasure) {
                    ForEach(typesOfVolum, id: \.self) { type in
                        Text(type).tag(type)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                
                Picker("Medida do output", selection: $outputMeasure) {
                    ForEach(typesOfVolum, id: \.self) { type in
                        Text(type).tag(type)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
            }
            
            Section(header: Text("Output")) {
                HStack {
                    Button("Calcular") {
                        calcularMedida()
                    }
                    Spacer()
                    Text("\(String(format: "%.10f", output)) \(outputMeasure)")
                }
            }
        }
    }
    
    func calcularMedida() {
        let internalInput = Double(input) ?? 0.0
        
        var volum: Measurement<UnitVolume>
        
        switch inputMeasure {
        case "ML":
            volum = Measurement(value: internalInput, unit: UnitVolume.megaliters)
        case "kL":
            volum = Measurement(value: internalInput, unit: UnitVolume.kiloliters)
        case "L":
            volum = Measurement(value: internalInput, unit: UnitVolume.liters)
        case "dL":
            volum = Measurement(value: internalInput, unit: UnitVolume.deciliters)
        case "cL":
            volum = Measurement(value: internalInput, unit: UnitVolume.centiliters)
        default:
            volum = Measurement(value: internalInput, unit: UnitVolume.milliliters)
        }
        
        switch outputMeasure {
        case "ML":
            volum.convert(to: .megaliters)
        case "kL":
            volum.convert(to: .kiloliters)
        case "L":
            volum.convert(to: .liters)
        case "dL":
            volum.convert(to: .deciliters)
        case "cL":
            volum.convert(to: .centiliters)
        default:
            volum.convert(to: .milliliters)
        }
        
        
        output = volum.value
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
