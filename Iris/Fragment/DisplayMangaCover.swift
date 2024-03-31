//
//  DisplayMangaCover.swift
//  Iris
//
//  Created by Cristian Ursu on 31/03/2024.
//

import SwiftUI

struct DisplayMangaCoverFragment: View {
    @Binding var manga: MangaModel
    var body: some View {
        if manga.coverUrl != "default_cover" {
            AsyncImage(url: URL(string: manga.coverUrl)) { phrase in
                if let image = phrase.image {
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .cornerRadius(15)
                } else if phrase.error != nil {
                    Image("default_cover")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .cornerRadius(15)
                } else {
                    ProgressView()
                }
            }
        } else {
            ProgressView()
        }
    }
}

#Preview {
    DisplayMangaCoverFragment(manga: .constant(mangaSampleData[0]))
}
