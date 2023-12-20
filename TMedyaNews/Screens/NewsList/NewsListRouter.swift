//
//  NewsListRouter.swift
//  TMedyaNews
//
//  Created by Arda Sisli on 19.12.2023.
//

import UIKit

protocol NewsListRouterProtocol {
    func navigate(id: String)
}

class NewsListRouter: NewsListRouterProtocol {
    let view: UIViewController
    
    init( view: UIViewController) {
        self.view = view
    }
    
    func navigate(id: String) {
        let vc = NewsDetailBuilder.makeID(id: id)
        view.navigationController?.pushViewController(vc, animated: true)
    }
}
