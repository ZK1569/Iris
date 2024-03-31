//
//  Tab.swift
//  Iris
//
//  Created by Cristian Ursu on 30/03/2024.
//

import SwiftUI

struct TabModel: Identifiable, Hashable {
    var id: UUID = .init()
    var title: String
    var view: AnyView
    var width: CGFloat = 0
    var minX: CGFloat = 0
    
    static func == (lhs: TabModel, rhs: TabModel) -> Bool {
        lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

var tabs_: [TabModel] = [
    .init(title: "Home", view: AnyView(DiscoveryView()) ),
    .init(title: "Like", view: AnyView(LikeView())),
    .init(title: "Search", view: AnyView(SearchView())),
]
