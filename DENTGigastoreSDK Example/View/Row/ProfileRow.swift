//
//  ProfileRow.swift
//  DENTGigastoreSDK example
//
//  Created by Christian Trümper on 22.04.21.
//

import SwiftUI
import DENTGigastoreSDK

struct ProfileRow: View
{
    var profile: GigastoreESIMProfile
    @Binding var loading: Bool
    @Binding var activeError: Error?
    
    var body: some View {
        VStack(alignment: .leading, spacing: StyleConstants.Spacing.m) {
            HStack {
                Text("ID: ").fontWeight(.semibold)
                Text("\(profile.id ?? "")")
            }
            
            Divider()
            
            HStack {
                Text("IMSI: ").fontWeight(.semibold)
                Text("\(profile.imsi ?? "")")
            }
            
            Divider()
            
            HStack {
                Text("ICCID: ").fontWeight(.semibold)
                Text("\(profile.iccid ?? "")")
            }
            
            Divider()
            
            HStack {
                Text("State: ").fontWeight(.semibold)
                Text("\(profile.state?.rawValue ?? "Unknown")")
            }
            
            Button(action: {
                // self.loading = true
                ​Gigastore.installProfile(profile: profile, completion: { (profile, error) -> Void in
                    self.loading = false
                    
                    if error != nil {
                        self.activeError = error
                    }
                })
                 
            }) {
                HStack {
                    Text("Install profile")
                        .fontWeight(.semibold)
                        .font(.title2)
                        .frame(minWidth: 0, maxWidth: .infinity)
                }
                .padding()
                .foregroundColor(Color.white)
                .background(Color.blue)
                .cornerRadius(StyleConstants.CornerRadius.m)
            }
            .disabled(profile.state != GigastoreESIMProfile.State.released)
            .padding(.bottom, StyleConstants.Spacing.s)
        }.padding()
        .background(RoundedRectangle(cornerRadius: StyleConstants.CornerRadius.m).stroke())
        .padding()
    }
}

