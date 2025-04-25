//
//  ImageDetailView.swift
//  CodeChallange
//
//  Created by Abhinay Chary on 4/24/25.
//

import SwiftUI

struct ImageDetailView: View {
    let image: FlickrImage

    var body: some View {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    AsyncImage(url: URL(string: image.media.m)) { image in
                        image.resizable().aspectRatio(contentMode: .fit)
                    } placeholder: {
                        Color.gray.opacity(0.2)
                    }

                    Text("Title: \(image.title)").font(.headline)
                    Text("Author: \(image.author)").font(.subheadline)
                    Text("Published: \(formatDate(image.published))")
                        .font(.footnote)
                        .foregroundColor(.gray)
                    Text("Description:")
                    Text(parseDescription(image.description))
                        .font(.body)
                }
                .padding()
            }
            .navigationTitle("Image Detail")
        }

        func formatDate(_ dateStr: String) -> String {
            let formatter = ISO8601DateFormatter()
            if let date = formatter.date(from: dateStr) {
                let displayFormatter = DateFormatter()
                displayFormatter.dateStyle = .medium
                return displayFormatter.string(from: date)
            }
            return dateStr
        }

        func parseDescription(_ html: String) -> String {
            // Quick & dirty HTML stripping
            return html.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression)
        }
}
