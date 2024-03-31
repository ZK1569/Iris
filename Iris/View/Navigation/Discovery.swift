//
//  Discovery.swift
//  Iris
//
//  Created by Cristian Ursu on 30/03/2024.
//

import SwiftUI

struct DiscoveryView: View {
    @State private var mangas: [MangaModel] = mangaSampleData
    
    @State private var showError: Bool = false
    @State private var errorMessage: String = ""
    var body: some View {
        NavigationStack {
            StackedCardsFragment(mangasDisplay: $mangas)
        }
        .onAppear {
            Task {
                do {
                    mangas = try await apiCall.getRandomMangas()
                } catch {
                    errorMessage = error.localizedDescription
                    showError = true
                }           
            }
        }
        .alert("Erreur", isPresented: $showError) {
            Button("OK", role: .cancel) { }
        } message: {
            Text(errorMessage)
        }
    }
}

#Preview {
    DiscoveryView()
}
