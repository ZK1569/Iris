//
//  Home.swift
//  Iris
//
//  Created by Cristian Ursu on 30/03/2024.
//

import SwiftUI

struct HomeView: View {
    @State private var currentTab: TabModel = tabs_[0]
    @State private var tabs: [TabModel] = tabs_
    @State private var contentOffset: CGFloat = 0
    @State private var indicatorWidth: CGFloat = 0
    @State private var indicatorPosition: CGFloat = 0
    var body: some View {

        TabView(selection: $currentTab) {
            ForEach(tabs) { tab in
                GeometryReader(content: { _ in
                    tab.view
                        .padding(.top, 55)
                })
                .clipped()
                .ignoresSafeArea(edges: .bottom)
                .offsetX{ rect in
                    if currentTab.title == tab.title {
                        contentOffset = rect.minX - (rect.width * CGFloat(index(of: tab)))
                    }
                    
                    updateTabFrame(rect.width)
                }
                .tag(tab)
            }
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
        .ignoresSafeArea(edges: .bottom)
        .overlay(alignment: .top, content: {
            TabsView()
        })
    }
    
    @ViewBuilder
    func TabsView() -> some View {
        HStack(spacing: 0) {
            ForEach($tabs) { $tab in
                Text(tab.title)
                    .fontWeight(.semibold)
                    .offsetX { rect in
                        tab.minX = rect.minX
                        tab.width = rect.width
                    }
                if tabs.last != tab {
                    Spacer(minLength: 0)
                }
            }
        }
        .padding([.top, .horizontal], 15)
        .overlay(alignment: .bottomLeading, content: {
            Rectangle()
                .cornerRadius(2)
                .frame(width: indicatorWidth, height: 4)
                .offset(x: indicatorPosition, y: 10)
        })
    }
            
    
    
    func updateTabFrame(_ tabViewWidth: CGFloat) {
        let inputRange = tabs.indices.compactMap { index -> CGFloat? in
            return CGFloat(index) * tabViewWidth
        }
        
        let outputRangeForWidth = tabs.compactMap { tab -> CGFloat? in
            return tab.width
        }
        
        let outputRangeForPosition = tabs.compactMap { tab -> CGFloat? in
            return tab.minX
        }
        
        let widthInterpolation = LinearInterpolation(inputRange: inputRange, outputRange: outputRangeForWidth)
        let positionInterpolation = LinearInterpolation(inputRange: inputRange, outputRange: outputRangeForPosition)
        
        indicatorWidth = widthInterpolation.calculate(for: -contentOffset)
        indicatorPosition = positionInterpolation.calculate(for: -contentOffset)
        
    }
    
    func index(of tab: TabModel) -> Int {
        return tabs.firstIndex(of: tab) ?? 0
    }

}

struct Home_Preview: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
