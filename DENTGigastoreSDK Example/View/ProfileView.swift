//
//  ProfileView.swift
//  DENTGigastoreSDK Example
//
//  Created by Silvio Hinspeter on 18.02.25.
//

import SwiftUI
import DENTGigastoreSDK

struct ProfileView: View {
    
    // MARK: - Properties
    
    @State public var profile: GigastoreESIMProfile? = nil
    
    // MARK: - Body
    
    @Binding var loading: Bool
    @Binding var activeError: Error?
    
    // MARK: - Body
    
    var body: some View {
        ScrollView {
            if let profileNotNil = profile {
                ProfileRow(profile: profileNotNil,
                           loading: $loading,
                           activeError: $activeError)
            }
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        AllProfilesView(loading: true)
    }
}

