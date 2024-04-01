//
//  ReadPage.swift
//  Iris
//
//  Created by Cristian Ursu on 31/03/2024.
//

import SwiftUI

struct ReadpageFramgent: View {
    @Binding var url: String
    var body: some View {

            AsyncImage(url: URL(string: url)) { phrase in
                if let image = phrase.image {
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                } else if phrase.error != nil {
                    Text("An error occurred when accessing the image")
                } else {
                    ProgressView()
                }
            }
            .frame(minHeight: 400)
    }
}

#Preview {
    ReadpageFramgent(url: .constant("https://drive.google.com/uc?export=view&id=1ZHdsHl0igz7Hh83Tef2RFdVN36ioaTbc"))
}
