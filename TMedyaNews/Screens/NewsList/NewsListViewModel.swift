//
//  NewsListViewModel.swift
//  TMedyaNews
//
//  Created by Arda Sisli on 18.12.2023.
//

import Foundation

protocol NewsListViewModelProtocol {
    var delegate: NewsListViewModelDelegate? { get set}
    func fetchNewsList()
    func getCategoryTitle() -> [String]
    func getVideoURL() -> String
    func getItemListData() -> [[ItemList]]
}

enum NewsListViewModelOutPut {
    case itemList
    case error((String))
}

protocol NewsListViewModelDelegate {
    func handleOutPut(_ output: NewsListViewModelOutPut)
}

class NewsListViewModel {
    var delegate: NewsListViewModelDelegate?
    var service: HttpClientProtocol?
    var categoryTitleList: [String] = []
    var categoryList: [[ItemList]] = [[]]
    
    init(service: HttpClientProtocol) {
        self.service = service
    }
}

extension NewsListViewModel: NewsListViewModelProtocol {
    func fetchNewsList() {
        guard let url = URL(string: NetworkConstant.NewsListGenreNetwork.newsListGenreURL()) else { return }
        service?.fetchData(url: url, completion: { [delegate] (result: Result<ItemListResult, Error>) in
            switch result {
            case .success(let success):
                guard let datumList = success.data else { return }
                self.fetchItemList(datumList: datumList)
                
            case .failure(let failure):
                delegate?.handleOutPut(.error(failure.localizedDescription))
                
            }
        })
    }
    
    func fetchItemList(datumList: [Datum]) {
        let itemList = datumList.first?.itemList
        var index = 0
        for item in itemList! {
            if let categoryIndex = categoryList.firstIndex(where: { $0.first?.category?.categoryID == item.category?.categoryID }) {
                categoryList[categoryIndex].append(item)
            } else {
                categoryTitleList.append(item.category?.title ?? "")
                categoryList.append([item])
                index += 1
            }
        }
        
        delegate?.handleOutPut(.itemList)
    }
    
    func getItemListData() -> [[ItemList]] {
        categoryList
    }
    
    func getCategoryTitle() -> [String] {
        categoryTitleList
    }
    
    func getVideoURL() -> String {
        NewsScreensConstant.NewsVideo.videoURL()
    }
}
