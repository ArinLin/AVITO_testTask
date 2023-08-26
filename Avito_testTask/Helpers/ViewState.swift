//
//  ViewState.swift
//  Avito_testTask
//
//  Created by Arina on 25.08.2023.
//

import Foundation

enum ViewState: String {
    case none
    case error
    case loading
    case loaded

    var message: String {
        switch self {
        case .none:
            return "unknown"
        case .error:
            return "не удалось загрузить"
        case .loading:
            return "загружается"
        case .loaded:
            return "загрузилось"
        }
    }
}
