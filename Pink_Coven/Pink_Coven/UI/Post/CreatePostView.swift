//
//  CreatePostView.swift
//  Pink_Coven
//
//  Created by M_2022814 on 1/1/22.
//

import SwiftUI

struct CreatePostView: View {
    @State var showNext = false
    @State var postImage = UIImage()
    var body: some View {
        NavigationView {
            // What is trailing closure syntax??!
            VStack {
                TakePhotoView(onPhotoCapture: { image in
                    postImage = image
                    showNext = true
                })
                NavigationLink(destination: Image(uiImage: postImage), isActive: $showNext) {
                    EmptyView()
                }
            }
        }
    }
}

struct CreatePostView_Previews: PreviewProvider {
    static var previews: some View {
        CreatePostView()
    }
}
