//
//  FeedCell.swift
//  Pink_Coven
//
//  Created by M_2022814 on 1/1/22.
//

import SwiftUI
import Combine

struct FeedCell: View {
    var post: Post
    let placeholderImage = UIImage(systemName: "photo")!
    @State var postImage: UIImage? = nil
    @State private var subscriptions:
    Set<AnyCancellable> = []
    
    var body: some View {
        VStack {
            Image(uiImage: postImage ?? placeholderImage)
                .resizable()
                .scaledToFit()
                .cornerRadius(15)
                .overlay({
                    VStack(spacing: 15) {
                        Button(action: {}) {
                            Image("filled")
                        }
                        Button(action: {}) {
                            Image("comment")
                        }
                        Button(action: {}) {
                            Image("share")
                        }
                    }
                    .padding()
                    .shadow(radius: 3)
                }(), alignment: .bottomTrailing)
                .onAppear {
                    guard let imageId = self.post.id else {
                        return
                    }
                    let client = APIClient()
                    let request = DownloadImageRequest(imageId: imageId)
                    client.publisherForRequest(request)
                        .replaceError(with: placeholderImage)
                        .sink { image in
                            postImage = image
                        }
                        .store(in: &subscriptions)
                }
            CommentCell(post: post)
            }
        .buttonStyle(PlainButtonStyle())
        
    }
}

struct FeedCell_Previews: PreviewProvider {
    static var previews: some View {
        let createdDate = Date().advanced(by: TimeInterval(exactly: -5*60)!)
        let post = Post(caption: "can you code me up a spell?", createdAt: createdDate, createdBy: "UserName")
        return Group {
            FeedCell(post: post)
            FeedCell(post: post, postImage: UIImage(named: "friends")!)
                
        }.previewLayout(.sizeThatFits)

    }
}
