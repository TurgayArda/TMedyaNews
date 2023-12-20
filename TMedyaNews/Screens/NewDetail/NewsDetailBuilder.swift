//
//  NewsDetailBuilder.swift
//  TMedyaNews
//
//  Created by Arda Sisli on 18.12.2023.
//

import Foundation

final class NewsDetailBuilder {
    static func makeID(id: String) -> NewsDetailVC {
        let vc = NewsDetailVC()
        let service = HttpClient(client: URLSession.shared)
        let viewModel = NewsDetailViewModel(service: service, id: id)
        vc.viewModel = viewModel
        return vc
    }
}
