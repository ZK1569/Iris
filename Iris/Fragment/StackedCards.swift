//
//  StackedCards.swift
//  Iris
//
//  Created by Cristian Ursu on 31/03/2024.
//

import SwiftUI

struct StackedCardsFragment: View {
    @Binding var mangasDisplay: [MangaModel]
    var body: some View {
        HStack {
            GeometryReader {
                let size = $0.size
                
                ScrollView(.horizontal) {
                    HStack(spacing: 0) {
                        ForEach($mangasDisplay) { $manga in
                            NavigationLink(destination: {}) {
                                DisplayMangaCoverFragment(manga: $manga)
                                    // INFO: Width of the cards
                                    .padding(.horizontal, 40)
                                    .frame(width: size.width)
                                    .visualEffect { content, geometryProxy in
                                        content
                                            .scaleEffect(scale(geometryProxy, scale: 0.1), anchor: .trailing)
                                            .rotationEffect(rotation(geometryProxy, rotation: 2))
                                            .offset(x: minX(geometryProxy))
                                            .offset(x: excessMinX(geometryProxy, offset: 2))
                                        
                                    }
                            }
                            .zIndex(mangasDisplay.zIndex(manga))
                        }
                    }
                    // .padding(.vertical, 15)
                }
                .scrollTargetBehavior(.paging)
                .scrollIndicators(.hidden)
            }
            // INFO: Height of the card
            .frame(height: 410)
        }
    }
    
    func minX(_ proxy: GeometryProxy) -> CGFloat {
        let minX = proxy.frame(in: .scrollView(axis: .horizontal)).minX
        return minX < 0 ? 0 : -minX
    }
    
    func progress(_ proxy: GeometryProxy, limit: CGFloat = 2) -> CGFloat {
        let maxX = proxy.frame(in: .scrollView(axis: .horizontal)).maxX
        let width = proxy.bounds(of: .scrollView(axis: .horizontal))?.width ?? 0
        
        let progress = (maxX / width) - 1.0
        let cappedProgress = min(progress, limit)
        
        return cappedProgress
    }
    
    func scale(_ proxy: GeometryProxy, scale: CGFloat = 0.1) -> CGFloat {
        let progress = progress(proxy, limit: 2)
        
        return 1 - (progress * scale)
    }
    
    func excessMinX(_ proxy: GeometryProxy, offset: CGFloat = 10) -> CGFloat {
        let progress = progress(proxy)
        
        return progress * offset
    }
    
    func rotation(_ proxy: GeometryProxy, rotation: CGFloat = 5) -> Angle {
        let progress = progress(proxy)
        
        return .init(degrees: progress * rotation)
    }
}

#Preview {
    StackedCardsFragment(mangasDisplay: .constant(mangaSampleData))
}
