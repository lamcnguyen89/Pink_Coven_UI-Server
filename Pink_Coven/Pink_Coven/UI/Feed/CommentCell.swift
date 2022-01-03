//
//  CommentCell.swift
//  Pink_Coven
//
//  Created by M_2022814 on 1/1/22.
//

import SwiftUI

struct CommentCell: View {
    var post: Post
    let formatter: RelativeDateTimeFormatter = {
        let formatter = RelativeDateTimeFormatter()
        formatter.dateTimeStyle = .named
        formatter.unitsStyle = .short
        return formatter
    }()
    // What the hell do the parenthesis after the closure do?
    // It assigns the result of calling the closure to the constant named formatter the first time you reference the constant named formatter
    // But why?
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack() {
                Image(systemName: "person.circle")
                    .resizable()
                    .aspectRatio(1.0, contentMode: .fit)
                    .frame(width: 40)
                    .clipShape(Circle())
                VStack(alignment: .leading) {
                    Text(post.createdByUser)
                        .font(.headline)
                        .foregroundColor(.pink)
                    Text(formatter.localizedString(for: post.createdAt, relativeTo: Date()))
                        .font(.caption)
                }
                Spacer()
            }
            Text(post.caption)
        }
    }
    
    
    
}

struct CommentCell_Previews: PreviewProvider {
    static var previews: some View {
        let activity = Date().advanced(by: TimeInterval(exactly: -5*60)!)
        let user = "MoonForest"
        let comment = "Can you code me up a living dream?"
        let post = Post(caption: comment, createdAt: activity, createdBy: user)
        CommentCell(post: post)
            .previewLayout(.sizeThatFits)
    }
}
