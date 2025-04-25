//
//  FlickrSearchViewModel.swift
//  CodeChallange
//
//  Created by Abhinay Chary on 4/24/25.
//

import Foundation
import Combine


class FlickrSearchViewModel: ObservableObject {
    @Published var searchText = ""
    @Published var images: [FlickrImage] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    
    private var cancellables = Set<AnyCancellable>()
    private let service = FlickrAPIService()

    init() {
        $searchText
            .debounce(for: .milliseconds(500), scheduler: DispatchQueue.main)
            .removeDuplicates()
            .sink { [weak self] text in
                self?.searchImages(for: text)
            }
            .store(in: &cancellables)
    }

    func searchImages(for tags: String) {
        guard !tags.isEmpty else {
            images = []
            return
        }

        isLoading = true
        errorMessage = nil

        service.searchImages(tags: tags)
            .sink(receiveCompletion: { [weak self] completion in
                self?.isLoading = false
                if case .failure(let error) = completion {
                    self?.errorMessage = error.localizedDescription
                }
            }, receiveValue: { [weak self] items in
                self?.images = items
            })
            .store(in: &cancellables)
    }
}
