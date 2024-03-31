//
//  MangaDetail.swift
//  Iris
//
//  Created by Cristian Ursu on 31/03/2024.
//

import SwiftUI

struct MangaDetailView: View {
    @Binding var manga: MangaModel
    var body: some View {
        NavigationStack{
            ScrollView {
                VStack{
                    ZStack{
                        VStack{
                            Image("default_cover")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .edgesIgnoringSafeArea(.top)
                            
                            DescriptionView(manga: $manga)
                                .offset(y: -40)
                        }
                    }
                }
            }
        }
        .toolbar(.hidden)
    }
}

struct DescriptionView: View {
    @Binding var manga: MangaModel
    var body: some View {
        VStack(alignment: .leading) {
            Text(manga.title)
                .font(.title)
                .fontWeight(.bold)
            
            HStack{
                Spacer()
            }
            
            Text("Decription")
                .fontWeight(.medium)
                .padding(.vertical, 8)
            
            Text(manga.description)
                .lineSpacing(8.0)
                .opacity(0.6)
            
            HStack (alignment: .top){
                Button(action: {}) {
                    Text("Start Reading")
                        .padding()
                        .foregroundColor(.white)
                        .background(.green)
                        .cornerRadius(100)
                }
                Spacer()
                NavigationLink(destination: ReadView(
                    manga_name: .constant("berserk"),
                    chapter: .constant("1")
                )) {
                    Text("Continue Reading")
                        .padding()
                        .foregroundColor(.white)
                        .background(.blue)
                        .cornerRadius(100)
                }
            }
            .padding(.vertical)
            
            HStack (alignment: .top){
                VStack (alignment: .leading){
                    Text("Infos")
                        .fontWeight(.semibold)
                        .padding(.bottom, 4)
                    Text("Last Chapter : \(manga.lastChapter)")
                        .opacity(0.6)
                    Text("Last Volume : \(manga.lastChapter)")
                        .opacity(0.6)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                VStack (alignment: .leading){
                    Text("Other")
                        .fontWeight(.semibold)
                        .padding(.bottom, 4)
                    
                    Text("Year : \(manga.year)")
                        .opacity(0.6)
                    
                    Text("Status : \(manga.status)")
                        .opacity(0.6)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(.vertical)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(40)
    }
}

#Preview {
    MangaDetailView(manga: .constant(mangaSampleData[0]))
}
