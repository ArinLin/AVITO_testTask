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

    func fetchDetailInfo(id: String) {
        service.fetchDetailAdvertisement(id: id) { result in
            switch result {
            case .success(let data):
                self.detail = data
            case .failure(let error):
                print(error)
            }
        }
    }
}
