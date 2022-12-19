//
//  AllProfilesView.swift
//  DENTGigastoreSDK example
//
//  Created by Christian Trümper on 21.04.21.
//

import SwiftUI
import DENTGigastoreSDK

struct AllProfilesView: View {
    
    // MARK: - Properties
    
    @State var loading: Bool
    @State private(set) var activeError: Error?
    @State public var profiles: [GigastoreESIMProfile] = []
    
    var isPresentingAlert: Binding<Bool> {
        return Binding<Bool>(get: {
            return self.activeError != nil
        }, set: { newValue in
            guard !newValue else {
                return
            }
            self.activeError = nil
        })
    }
    
    // MARK: - Body
    
    var body: some View {
        VStack {
            LoadingView(isShowing: $loading, content: {
                ZStack {
                    if self.profiles.count == 0 && !self.loading {
                        Text("No profiles found")
                            .fontWeight(.regular)
                            .font(.title3)
                            .frame(minWidth: 0, maxWidth: .infinity)
                    } else {
                        EsimProfilesList(profiles: profiles,
                                         loading: $loading,
                                         activeError: $activeError)
                    }
                }
            })
            
        }.onAppear {
            ​Gigastore.getAllProfiles(completion: { (profiles, error) -> Void in
                if let _profiles = profiles {
                    self.profiles = _profiles
                }
                
                if let error = error {
                    self.activeError = error
                }
                
                print("Profiles: \(profiles ?? []), error: \(String(describing: error))")
            
                self.loading = false
            })

        }.alert(isPresented: isPresentingAlert, content: {
            Alert(title: Text("Error"), message: Text("\(self.activeError?.localizedDescription ?? "")"), dismissButton: .cancel())
        }).navigationBarTitle("All profiles", displayMode: .inline)
    }

}

fileprivate struct EsimProfilesList: View {
    
    // MARK: - Properties
    
    var profiles: [GigastoreESIMProfile]
    @Binding var loading: Bool
    @Binding var activeError: Error?
    
    // MARK: - Body
    
    var body: some View {
        ScrollView {
            VStack {
                ForEach(self.profiles, id: \.id, content: { profile in
                    ProfileRow(profile: profile,
                               loading: $loading,
                               activeError: $activeError)
                })
            }
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct AllProfilesView_Previews: PreviewProvider {
    static var previews: some View {
        AllProfilesView(loading: true)
    }
}
