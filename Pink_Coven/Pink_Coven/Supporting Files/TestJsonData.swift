//
//  TestJsonData.swift
//  Pink_Coven
//
//  Created by Lam Nguyen on 1/3/22.
//

import Foundation

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
