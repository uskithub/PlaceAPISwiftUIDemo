//
//  PredictingTextField.swift
//  PlaceDemo
//
//  Created by 斉藤 祐輔 on 2022/03/16.
//

import SwiftUI

struct PredictingTextField: View {

    var title: String
    @Binding var text: String
    
    @Binding var predictableValues: Array<String>
    @Binding var predictedValues: Array<String>

    @State var interval: Double
    
    @State private var isBeingEdited: Bool = false

    init(_ title: String = ""
         , text: Binding<String>
         , predictableValues: Binding<Array<String>>
         , predictedValues: Binding<Array<String>>
         , interval: Double = 0.1
    ) {
        self.title = title
        self._text = text
        
        self._predictableValues = predictableValues
        self._predictedValues = predictedValues
        
        self.interval = interval
    }
    
    
    var body: some View {
        
        TextField(
            self.title
            , text: self.$text
            , onEditingChanged: { isEditing in
                self.realTimePrediction(status: isEditing)
            }
            , onCommit: { self.makePrediction() }
        )
         
    }
    
    private func realTimePrediction(status: Bool) {
        self.isBeingEdited = status
        if status {
            Timer.scheduledTimer(withTimeInterval: self.interval, repeats: true) { timer in
                self.makePrediction()
                
                if self.isBeingEdited == false {
                    timer.invalidate()
                }
            }
        }
    }
    
    private func capitalizeFirstLetter(smallString: String) -> String {
        return smallString.prefix(1).capitalized + smallString.dropFirst()
    }
    
    private func makePrediction() {
        self.predictedValues = []
        if !self.text.isEmpty{
            for value in self.predictableValues {
                if self.text.split(separator: " ").count > 1 {
                    self.makeMultiPrediction(value: value)
                }else {
                    if value.contains(self.text) || value.contains(self.capitalizeFirstLetter(smallString: self.text)){
                        if !self.predictedValues.contains(String(value)) {
                            self.predictedValues.append(String(value))
                        }
                    }
                }
            }
        }
    }
    
    private func makeMultiPrediction(value: String) {
        for subString in self.text.split(separator: " ") {
            if value.contains(String(subString)) || value.contains(self.capitalizeFirstLetter(smallString: String(subString))){
                if !self.predictedValues.contains(value) {
                    self.predictedValues.append(value)
                }
            }
        }
    }
}

//struct PredictingTextField_Previews: PreviewProvider {
//    static var previews: some View {
//        PredictingTextField()
//    }
//}
