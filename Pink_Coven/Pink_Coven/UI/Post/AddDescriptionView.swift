//
//  AddDescriptionView.swift
//  Pink_Coven
//
//  Created by M_2022814 on 1/2/22.
//

import SwiftUI

struct AddDescriptionView: View {
  var image: UIImage
  @State var description = ""
  @StateObject private var controller = PostController()
  @EnvironmentObject var userData: UserData

  var body: some View {
    VStack(alignment: .leading) {
      HStack {
        Image(uiImage: image)
          .resizable()
          .scaledToFill()
          .frame(width: 100, height: 160)
          .clipped()
        Spacer()
      }

      Text("Add a description:")
      TextEditor(text: $description)
      Spacer()

      HStack {
        Spacer()
        ZStack {
          if controller.isRunning {
            ProgressView()
          }
          Button(action: {
            controller.uploadPost(withDescription: description, image: image)
          }) {
            Text("Post")
          }
          .foregroundColor(controller.isRunning ? .gray : .pink)
          .disabled(controller.isRunning)
          .onReceive(controller.$postUploaded) {
            completed in
            if completed {
                self.userData.selectedTab = 0
            }
          }
        }
      }
      .padding(.vertical)
    }
    .padding(.horizontal)
  }
}

struct AddDescriptionView_Previews: PreviewProvider {
  static var previews: some View {
    AddDescriptionView(image: UIImage(named: "puppies")!)
        .environmentObject(UserData())
  }
}

