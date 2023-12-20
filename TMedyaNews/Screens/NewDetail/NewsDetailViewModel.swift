//
//  NewsDetailViewModel.swift
//  TMedyaNews
//
//  Created by Arda Sisli on 18.12.2023.
//

import Foundation

protocol NewsDetailViewModelProtocol {
    var delegate: NewsDetailViewModelDelegate? { get set}
    func fetchNewsDetail()
    func getCategoryName() -> String
    func getDetailTitle() -> String
    func getDetailDescription() -> String
    func getDetailImage() -> String
    func getNewsDetailList() -> NewsDetail?
}

enum NewsDetailViewModelOutPut {
    case itemDetail
    case error((String))
}

protocol NewsDetailViewModelDelegate {
    func handleOutPut(_ output: NewsDetailViewModelOutPut)
}

class NewsDetailViewModel {
    var delegate: NewsDetailViewModelDelegate?
    var service: HttpClientProtocol?
    var id: String?
    var newsDetail: NewsDetail?
    
    init(service: HttpClientProtocol, id: String) {
        self.service = service
        self.id = id
    }
}

extension NewsDetailViewModel: NewsDetailViewModelProtocol {
    func fetchNewsDetail() {
        guard let id else { return }
        guard let url = URL(string: NetworkConstant.NewsDetailGenreNetwork.newsDetailGenreURL(id: id)) else { return }
        service?.fetchData(url: url, completion: { [delegate] (result: Result<NewsDetailResult, Error>) in
            switch result {
            case .success(let success):
                guard let itemDetail = success.data?.newsDetail else { return }
                delegate?.handleOutPut(.itemDetail)
                self.newsDetail = itemDetail
            case .failure(let failure):
                delegate?.handleOutPut(.error(failure.localizedDescription))
                
            }
        })
    }
    
    func getDetailTitle() -> String {
        newsDetail?.title ?? ""
    }
    
    func getDetailImage() -> String {
        newsDetail?.imageURL ?? ""
    }
    
    func getCategoryName() -> String {
        newsDetail?.category?.title ?? ""
    }
    
    func getDetailDescription() -> String {
        newsDetail?.bodyText ?? ""
    }
    
    func getNewsDetailList() -> NewsDetail? {
        newsDetail
    }
    
}
