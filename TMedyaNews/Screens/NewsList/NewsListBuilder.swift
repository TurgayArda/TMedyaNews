//
//  NewsListBuilder.swift
//  TMedyaNews
//
//  Created by Arda Sisli on 18.12.2023.
//

import Foundation

final class NewsListBuilder {
    static func make() -> NewsListVC {
        let vc = NewsListVC()
        let service = HttpClient(client: URLSession.shared)
        let viewModel = NewsListViewModel(service: service)
        let router = NewsListRouter(view: vc)
        vc.viewModel = viewModel
        vc.router = router
        return vc
        
    }
}
