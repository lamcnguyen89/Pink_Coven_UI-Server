//
//  MainView.swift
//  Pink_Coven
//
//  Created by M_2022814 on 1/1/22.
//

import SwiftUI

import SwiftUI
import Combine

struct MainView: View {
    @State var showingLogin = true
    @State var showingPostView = false
    @StateObject var userData = UserData()
    let signInPublisher = NotificationCenter.default
        .publisher(for: .signInNotification)
        .receive(on: RunLoop.main)
    let signOutPublisher = NotificationCenter.default
        .publisher(for: .signOutNotification)
        .receive(on: RunLoop.main)

    var body: some View {
        TabView(selection: $userData.selectedTab) {
            FeedView()
                .tabItem {
                    Image("home")
                    Text("Home")
                }.tag(0)
            Text("")
                .sheet(isPresented: $showingPostView) {
                    CreatePostView()
                        .environmentObject(userData)
                }
                .tabItem {
                    Image("photo")
                    Text("Post")
                }.tag(1)
            Text("Tab Content 3")
                .tabItem {
                    Image("profile")
                    Text("Profile")
                }.tag(2)
        }
        .accentColor(.pink)
        .fullScreenCover(isPresented: $showingLogin) {
          LoginSignupView()
        }
        .onReceive(signInPublisher) { _ in
          showingLogin = false
        }
        .onReceive(signOutPublisher) { _ in
          showingLogin = true
        }
        .onReceive(userData.$selectedTab) { _ in
            self.showingPostView = (userData.selectedTab == 1)
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(showingLogin: false)
    }
}
