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
    
    // MARK: - Body

    var body: some View {
        VStack {
            InputViewWithButton(title: "SDK Key",
                                buttonTitle: "Set SDK Key",
                                inputText: $sdkKey,
                                isButtonEnabled: !sdkKey.isEmpty) {
                ​Gigastore.load(withSDKKey: self.sdkKey)
                sdkKeySet = true
            }.padding(.bottom, 4)
            
            NavigationLink("", destination: MainView(), isActive: $sdkKeySet)
                .isDetailLink(false)
                .hidden()
        }
        .padding(.horizontal, StyleConstants.Spacing.xl)
    }
}
