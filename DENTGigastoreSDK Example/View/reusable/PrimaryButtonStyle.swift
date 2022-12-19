//
//  PrimaryButtonStyle.swift
//  DENTGigastoreSDK Example
//
//  Created by Carl Zeitler on 13.12.22.
//

import SwiftUI

struct PrimaryButtonStyle: ButtonStyle {
    
    // MARK: - Properties
    
    @Environment(\.isEnabled) var isEnabled
    
    // MARK: - Body
    
    func makeBody(configuration: SwiftUI.ButtonStyle.Configuration) -> some View {
        configuration.label
        .frame(minWidth: 0, maxWidth: .infinity)
        .padding()
        .foregroundColor(Color.white)
        .background(backgroundColorForCurrentState(isEnabled: isEnabled, isPressed: configuration.isPressed))
        .cornerRadius(StyleConstants.CornerRadius.m)
    }
    
    private func backgroundColorForCurrentState(isEnabled: Bool, isPressed: Bool) -> Color {
        if !isEnabled {
            return Color.gray
        }
        
        if isPressed {
            return Color.blue.opacity(0.8)
        }
        else {
            return Color.blue
        }
    }
    
}
