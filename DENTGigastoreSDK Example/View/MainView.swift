//
//  MainView.swift
//  DENTGigastoreSDK Example
//
//  Created by Christian Trümper on 12.07.21.
//

import SwiftUI
import DENTGigastoreSDK

struct MainView: View {
    
    // MARK: - Properties
    
    @State private(set) var activeError: Error?
    @State private var itemValue: String = ""
    @State private var metatagValue: String = "foo_tag"
    
    @State private var userTokenValue: String = "foo_token"
    @State private var profileUidValue: String = ""
    
    @State var isEsimCapable = false
    
    @State var loading: Bool = false
    
    @State var profile: GigastoreESIMProfile?
    @State private var isNavigating = false
    
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
        LoadingView(isShowing: $loading, content: {
            ScrollView(/*@START_MENU_TOKEN@*/.vertical/*@END_MENU_TOKEN@*/, showsIndicators: false, content: {
                VStack(alignment: .leading, spacing: StyleConstants.Spacing.l) {
                    DeviceInformationView(isEsimCapable: isEsimCapable)
                    
                    DividerView()
                    
                    LoadProfileView(isNavigating: $isNavigating,
                                    profileUidValue: $profileUidValue,
                                    loading: $loading,
                                    profile: $profile,
                                    activeError: $activeError,
                                    isEsimCapable: isEsimCapable)
                    
                    NavigationLink(
                        destination: ProfileView(profile: profile,
                                                loading: $loading,
                                                activeError: $activeError),
                        isActive: $isNavigating
                    ) { }.hidden()

                    
                    DividerView()
                    
                    HeadlineView("Custom User Token")
                    
                    InputViewWithButton(title: "User Token",
                                        buttonTitle: "Set User Token",
                                        inputText: $userTokenValue) {
                        ​Gigastore.setUserToken(userToken: self.userTokenValue)
                    }
                    
                    DividerView()
                    
                    HeadlineView("Load Profiles Connected To Device")
                        .fixedSize(horizontal: false, vertical: true)
                    
                    NavigationLink(destination: AllProfilesView(loading: true)) {
                        Text("Load profiles")
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .padding()
                            .foregroundColor(Color.white)
                            .background(Color.blue)
                            .cornerRadius(StyleConstants.CornerRadius.m)
                    }
                    
                    DividerView()
                    
                    ActivateItemView(itemValue: $itemValue,
                                     metatagValue: $metatagValue,
                                     loading: $loading,
                                     profile: $profile,
                                     activeError: $activeError,
                                     isEsimCapable: isEsimCapable)
                    
                    VersionView()
                }
                .frame(maxHeight: .infinity)
                .padding([.horizontal, .bottom], StyleConstants.Spacing.xl)
            })
        })
        .onAppear {
            ​Gigastore.isEsimCapable(completion: { (isCapable) -> Void in
                print("isCapable: \(isCapable)")
                self.isEsimCapable = isCapable
            })
            
        }.alert(isPresented: isPresentingAlert, content: {
            Alert(title: Text("Error"),
                  message: Text("Message: \(self.activeError?.localizedDescription ?? "") \n Code: \(self.activeError?.errorCode ?? 0)"),
                  dismissButton: .cancel())
        })
        .navigationTitle("Gigastore SDK")
        .navigationBarTitleDisplayMode(.inline)
    }
}

fileprivate struct DeviceInformationView: View {
    
    // MARK: - Properties
    
    var isEsimCapable: Bool
    
    // MARK: - Body
    
    var body: some View {
        VStack(alignment: .leading) {
            HeadlineView("eSIM Capability")
            
            Text("eSIM capable: \(self.isEsimCapable == true ? "Yes": "No")")
                .multilineTextAlignment(.leading)
                .padding(.bottom, 8)
        }
    }
}

fileprivate struct ActivateItemView: View {
    
    // MARK: - Properties
    
    @Binding var itemValue: String
    @Binding var metatagValue: String
    @Binding var loading: Bool
    
    @Binding var profile: GigastoreESIMProfile?
    @Binding var activeError: Error?
    var isEsimCapable: Bool
    
    // MARK: - Body
    
    var body: some View {
        VStack(alignment: .leading) {
            HeadlineView("Activate an item")
            
            LabelTextFieldView(textValue: $itemValue, text: "Inventory item")
            
            InputViewWithButton(title: "Meta tag",
                                buttonTitle: "Activate Item",
                                inputText: $metatagValue) {
                self.loading = true
                
                ​Gigastore.activateItem(inventoryItem: self.itemValue,
                                        metaTag: self.metatagValue,
                                        completion: { (profile, error) -> Void in
                    self.loading = false
                    
                    if let _profile = profile {
                        self.profile = _profile
                    }
                    
                    if error != nil {
                        self.activeError = error
                    }
                })
            }
        }
    }
}

fileprivate struct LoadProfileView: View {
    
    // MARK: - Properties
    
    @Binding var isNavigating: Bool
    @Binding var profileUidValue: String
    @Binding var loading: Bool
    
    @Binding var profile: GigastoreESIMProfile?
    @Binding var activeError: Error?
    var isEsimCapable: Bool
    
    // MARK: - Body
       
    var body: some View {
        VStack(alignment: .leading) {
            HeadlineView("Get Profile")
            
            InputViewWithButton(title: "Profile UID",
                                buttonTitle: "Load profile",
                                inputText: $profileUidValue) {
                self.loading = true
                                
                ​Gigastore.getProfile(profileUID: self.profileUidValue,
                                      completion: { (profile, error) -> Void in
                    self.loading = false
                                        
                    if let _profile = profile {
                        self.profile = _profile
                        self.isNavigating = true
                    }
                    
                    if error != nil {
                        self.activeError = error
                    }
                })
            }
        }
    }
}

fileprivate struct DividerView: View {
    var body: some View {
        Divider().padding(.vertical, StyleConstants.Spacing.l)
    }
}

fileprivate struct HeadlineView: View {
    
    // MARK: - Properties
    
    var text: String
    
    // MARK: - Body
    
    var body: some View {
        Text(text)
            .font(Font.system(.title))
            .fontWeight(.semibold)
            .padding(.bottom, StyleConstants.Spacing.l)
    }
    
    // MARK: - Public API
    
    init(_ text: String) {
        self.text = text
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
