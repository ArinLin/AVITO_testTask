//
//  DetailViewModel.swift
//  Avito_testTask
//
//  Created by Arina on 24.08.2023.
//

import Foundation

final class DetailViewModel {
    var detail: Detail? = nil

    var service: AdvertisementServiceProtocol = AdvertisementService.advertisementService
    var viewState: Observable<ViewState> = Observable(ViewState.none)

        init(detailId: String) {
            fetchDetailInfo(id: detailId)
        }

    func fetchDetailInfo(id: String) {
        viewState.value = .loading
        service.fetchDetailAdvertisement(id: id) { result in
            switch result {
            case .success(let data):
                self.detail = data
                self.viewState.value = .loaded
            case .failure(let error):
                self.viewState.value = .error
            }
        }
    }
}
