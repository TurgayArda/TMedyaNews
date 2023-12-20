//
//  NewsListCollectionCellViewModel.swift
//  TMedyaNews
//
//  Created by Arda Sisli on 18.12.2023.
//

import Foundation

protocol NewsCategoryCollectionCellViewModelProtocol {
    func getItemName() -> String
    func getImageURL() -> String
}

class  NewsCategoryCollectionCellViewModel: NewsCategoryCollectionCellViewModelProtocol {
    private var newsList: ItemList?
    
    init(newsList: ItemList) {
        self.newsList = newsList
    }
    
    func getItemName() -> String {
        guard let name = newsList?.title else {
            return ""
        }
        
        return name
    }
    
    func getImageURL() -> String {
        guard let poster = newsList?.imageURL  else {
            return ""
        }
        
        return poster
    }
    
}
