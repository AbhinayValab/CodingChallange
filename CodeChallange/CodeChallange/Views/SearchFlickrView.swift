//
//  SearchFlickrView.swift
//  CodeChallange
//
//  Created by Abhinay Chary on 4/24/25.
//

import SwiftUI

struct SearchFlickrView: View {
    
    @StateObject var viewModel = FlickrSearchViewModel()
    let columns = [GridItem(.adaptive(minimum: 100), spacing: 16)]
    
    var body: some View {
        NavigationStack {
            VStack {
                TextField("Search", text: $viewModel.searchText)
                    .textFieldStyle(.roundedBorder)
                    .padding()
                
                if viewModel.isLoading {
                    ProgressView().padding()
                }
                
                if let error = viewModel.errorMessage {
                    Text("Error: \(error)").foregroundColor(.red)
                }
                
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 16) {
                        ForEach(viewModel.images) { image in
                            NavigationLink(destination: ImageDetailView(image: image)) {
                                ImageGridItemView(imageURL: image.media.m)
                            }
                        }
                    }.padding()
                }
            }
            .navigationTitle("Flickr Search")
        }
    }
}

struct ImageGridItemView: View {
    let imageURL: String
    
    var body: some View {
        AsyncImage(url: URL(string: imageURL)) { phase in
            switch phase {
            case .success(let image):
                image.resizable()
                    .aspectRatio(contentMode: .fill)
            case .failure:
                Color.red.opacity(0.3)
            case .empty:
                Color.gray.opacity(0.2)
            @unknown default:
                Color.gray
            }
        }
        .frame(width: 100, height: 100)
        .clipped()
        .cornerRadius(8)
    }
}

#Preview {
    SearchFlickrView()
}

//                                    AsyncImage(url: URL(string: image.media.m)) { image in
//                                        image.resizable().aspectRatio(contentMode: .fill)
//                                    } placeholder: {
//                                        Color.gray.opacity(0.2)
//                                    }
//                                    .frame(width: 100, height: 100)
//                                    .clipped()
//                                    .cornerRadius(8)
