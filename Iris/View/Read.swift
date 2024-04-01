//
//  Read.swift
//  Iris
//
//  Created by Cristian Ursu on 31/03/2024.
//

import SwiftUI

struct ReadView: View {
    @Binding var manga_name: String
    @Binding var chapter: String
    
    @State private var pages: [String] = []
    
    @State private var showError: Bool = false
    @State private var errorMessage: String = ""
    
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach($pages, id: \.self) { page in
                    ReadpageFramgent(url: page)
                }
            }
        }
        .ignoresSafeArea(.all)
        .toolbar(.hidden)
        .onAppear {
            Task{
                do {
                    pages = try await apiCall.getMangaPages(manga_name: manga_name, chapter: chapter)
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
    ReadView(
        manga_name: .constant("berserk"),
        chapter: .constant("1")
    )
}
