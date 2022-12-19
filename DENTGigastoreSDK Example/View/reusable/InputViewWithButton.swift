//
//  InputViewWithButton.swift
//  DENTGigastoreSDK Example
//
//  Created by Carl Zeitler on 13.12.22.
//

import SwiftUI

struct InputViewWithButton: View {
    
    // MARK: - Properties
    
    var title: String
    var buttonTitle: String
    @Binding var inputText: String
    
    var isButtonEnabled: Bool = true
    var buttonAction: (() -> ())
    
    // MARK: - Body
    
    var body: some View {
        VStack {
            LabelTextFieldView(textValue: $inputText, text: title)
                .padding(.bottom, StyleConstants.Spacing.m)
            
            Button(buttonTitle, action: {
                buttonAction()
            })
            .buttonStyle(PrimaryButtonStyle())
            .disabled(!isButtonEnabled)
        }
    }
}
