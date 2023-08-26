//
//  HomeViewModel.swift
//  Avito_testTask
//
//  Created by Arina on 24.08.2023.
//

import Foundation

final class HomeViewModel {
    private let service: AdvertisementServiceProtocol
    
    init(service: AdvertisementServiceProtocol) {
        self.service = service
        self.fetchAdvertisements()
    }
    
    var advertisements: Observable<[Advertisement]> = Observable([])
    var viewState: Observable<ViewState> = Observable(ViewState.none)
    
    func fetchAdvertisements() {
        viewState.value = .loading
        service.fetchAdvertisements { result in
            switch result {
            case .success(let data):
                self.advertisements.value = data.advertisements
                self.viewState.value = .loaded
            case .failure:
                self.viewState.value = .error
            }
        }
    }
}
