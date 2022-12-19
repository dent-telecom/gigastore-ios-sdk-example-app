//
//  VersionView.swift
//  DENTGigastoreSDK Example
//
//  Created by Carl Zeitler on 13.12.22.
//

import SwiftUI

struct VersionView: View {
    
    // MARK: - Properties
    
    private var version: String = String(format: "%@-%@ (%@)",
                                         ConfigEnvironment.getConfig(key: .bundleShortVersionString),
                                         ConfigEnvironment.getConfig(key: .bundleVersion),
                                         ConfigEnvironment.getConfig(key: .versionControlRevision))
    
    // MARK: - Body
    
    var body: some View {
        VStack {
            Spacer()
            
            Text("Version: \(self.version)")
                .font(.footnote)
                .fontWeight(.regular)
                .multilineTextAlignment(.center)
                .frame(minWidth: 0, maxWidth: .infinity)
                .padding()
        }
    }
}

struct VersionView_Previews: PreviewProvider {
    static var previews: some View {
        VersionView()
    }
}
