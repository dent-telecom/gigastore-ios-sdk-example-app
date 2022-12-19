//
//  CustomTextFieldView.swift
//  DENTGigastoreSDK Example
//
//  Created by Christian Trümper on 02.07.21.
//

import SwiftUI

struct LabelTextFieldView: View {
    
    @Binding var textValue: String
    
    @State var text: String = "Text"
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(self.text)
                .font(.headline)
    
            TextField("", text: $textValue)
                .padding(.all)
                .background(Color.secondary.opacity(0.2))
                .cornerRadius(StyleConstants.CornerRadius.m)
                .foregroundColor(Color.primary)
        }
    }
}

struct CustomTextFieldView_Previews: PreviewProvider {
    static var previews: some View {
        LabelTextFieldView(textValue: .constant("Text"))
    }
}
