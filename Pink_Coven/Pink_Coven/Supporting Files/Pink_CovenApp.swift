//
//  Pink_CovenApp.swift
//  Pink_Coven
//
//  Created by M_2022814 on 1/1/22.
//

import SwiftUI
import Swifter

@main
struct Pink_CovenApp: App {
    
  // TODO: temp server code until API is ready
  // TODO: remove JsonData from target when this is removed
  
let server: HttpServer = {
    let server = HttpServer()
    // We use a different port so unit tests will still work
    try? server.start(8081)

    server.POST["/api/v1/user"] = { _ in HttpResponse.ok(.text(TestJsonData.goodPosts)) }
    server.POST["/api/v1/post"] = { _ in HttpResponse.ok(.text(TestJsonData.postUploaded))}
    server.POST["/api/v1/image"] = {_ in HttpResponse.ok(.text(""))}
    return server
  }()

  var body: some Scene {
    WindowGroup {
      MainView()
    }
  }
}


