//
//  SetSDKKeyView.swift
//  DENTGigastoreSDK Example
//
//  Created by Carl Zeitler on 13.12.22.
//

import SwiftUI
import DENTGigastoreSDK

struct SetSDKKeyView: View {
    
    // MARK: - Properties
    
    @State var sdkKey: String = ""
    @State var sdkKeySet: Bool = false
    @State var isTestMode: Bool = false
    
    // MARK: - Body

    var body: some View {
        VStack {
            Toggle(isOn: $isTestMode) {
                Text("TestMode")
                    .font(.headline)
            }
            .toggleStyle(SwitchToggleStyle(tint: Color.blue))
            .padding(.bottom, 12)
            
            InputViewWithButton(title: "SDK Key",
                                buttonTitle: "Set SDK Key",
                                inputText: $sdkKey,
                                isButtonEnabled: !sdkKey.isEmpty) {
                ​Gigastore.load(withSDKKey: self.sdkKey, testMode: self.isTestMode)
                sdkKeySet = true
            }.padding(.bottom, 4)
            
            NavigationLink("", destination: MainView(), isActive: $sdkKeySet)
                .isDetailLink(false)
                .hidden()
        }
        .padding(.horizontal, StyleConstants.Spacing.xl)
    }
}
