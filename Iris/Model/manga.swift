//
//  manga.swift
//  Iris
//
//  Created by Cristian Ursu on 31/03/2024.
//

import SwiftUI

struct MangaModel: Identifiable, Codable {
    var id: UUID = .init()
    var coverUrl: String
    var title: String
    var description: String
    var year: Int16
    var status: String
    var lastChapter: String
    var lastVolume: String
}

var mangaSampleData: [MangaModel] = [
    .init(coverUrl: "default_cover", title: "Bakemonogatari", description: "Test description", year: 2019, status: "Done", lastChapter: "", lastVolume: "16"),
    .init(coverUrl: "default_cover", title: "Bakemonogatari 2", description: "Test description", year: 2019, status: "Done", lastChapter: "", lastVolume: "16"),
    .init(coverUrl: "default_cover", title: "Bakemonogatari 3", description: "Test description", year: 2019, status: "Done", lastChapter: "", lastVolume: "16"),
    .init(coverUrl: "default_cover", title: "Bakemonogatari 4", description: "Test description", year: 2019, status: "Done", lastChapter: "", lastVolume: "16"),
    .init(coverUrl: "default_cover", title: "Bakemonogatari 5", description: "Test description", year: 2019, status: "Done", lastChapter: "", lastVolume: "16"),
    .init(coverUrl: "default_cover", title: "Bakemonogatari 6", description: "Test description", year: 2019, status: "Done", lastChapter: "", lastVolume: "16"),
]

extension [MangaModel] {
    func zIndex(_ manga: MangaModel) -> CGFloat {
        if let index = firstIndex(where: {$0.id == manga.id }) {
            return CGFloat(count) - CGFloat(index)
        }
        
        return .zero
    }
}
