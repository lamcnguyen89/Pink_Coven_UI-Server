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

enum TestJsonData {
    static let goodPosts = """
        [
            {   "id" : "891D789B-042C-4A4A-BB85-0DAAC9D828FC"
                "createdAt" : "2020-04-01T12:00:00Z",
                "caption" : "Dead inside #soulless #demonic",
                "createdByUser" : "WickedOne"
            },
            {   "id" : "869F7419-5EC9-4862-BB66-0FB2F537668E"
                "createdAt" : "2020-03-11T04:44:00Z",
                "caption" : "Blinding Light #angelcraft #hallucinations",
                "createdByUser" : "SummerSolstice"
            },
            {   "id" : "5FAE834B-F385-458A-BBC6-6A6511D5E1E3"
                "createdAt" : "2020-01-03T17:32:00Z",
                "caption" : "Cozy Cabin #escape #ritualfun",
                "createdByUser" : "HiddenMeanings"
            },
        ]
        """
    
    static let badPosts = """
        [
            "bad json"
        ]
        """
    
    static let goodSignUp = """
      {
        "username": "username",
        "email": "email@example.com"
      }
      """
    
    static let postUploaded = """
        {
          "id": "7D1EA5FA-3BB0-4CE4-AADB-DCCA549D3F51",
          "createdAt": "2020-09-03T12:00:00Z",
          "caption": "Dummy description",
          "createdByUser": "Jerry"
        }

    """
}
