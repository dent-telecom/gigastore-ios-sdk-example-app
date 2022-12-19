//
//  LoadingView.swift
//  DENTGigastoreSDK Example
//
//  Created by Christian Trümper on 21.04.21.
//

import SwiftUI

struct LoadingView<Content: View>: View {

    @Binding var isShowing: Bool
    @ViewBuilder var content: () -> Content

    var body: some View {
        
        GeometryReader { geometry in
            
            ZStack(alignment: .center) {

                self.content()
                    .disabled(self.isShowing)
                    .blur(radius: self.isShowing ? 3 : 0)

                VStack {
                    ProgressView("Loading...")
                }
                .frame(width: geometry.size.width / 2,
                       height: geometry.size.height / 5)
                .background(Color.secondary.opacity(0.2))
                .foregroundColor(Color.primary)
                .cornerRadius(StyleConstants.CornerRadius.m)
                .opacity(self.isShowing ? 1 : 0)
            }
        }
    }
}
