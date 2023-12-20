//
//  NewsListProvider.swift
//  TMedyaNews
//
//  Created by Arda Sisli on 18.12.2023.
//

import UIKit

protocol NewsListCollectionProviderProtocol {
    var delegate: NewsListCollectionProviderDelegate? { get set }
    func load(value: [ItemList])
    func loadTitle(value: [String])
}

protocol NewsListCollectionProviderDelegate {
    func getWidth() -> CGFloat
    func routerTapped(id: String)
}

class NewsListCollectionProvider: NSObject {
    
    var delegate: NewsListCollectionProviderDelegate?
    var listItem: [ItemList] = []
    var listTitle: [String] = []
}

//MARK: - HomePageListProviderProtocol

extension NewsListCollectionProvider: NewsListCollectionProviderProtocol {
    func load(value: [ItemList]) {
        self.listItem = value
    }
    
    func loadTitle(value: [String]) {
        self.listTitle = value
    }
}

//MARK: - UICollectionViewDataSource, UICollectionViewDelegateFlowLayout

extension NewsListCollectionProvider: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listItem.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NewsListCollectionViewCell.Identifier.path.rawValue, for: indexPath) as? NewsListCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let  viewModel = NewsCategoryCollectionCellViewModel(newsList: listItem[indexPath.row])
        cell.saveModel(viewModel: viewModel)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let with = collectionView.bounds.width
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0)
        flowLayout.minimumInteritemSpacing = 10
        flowLayout.minimumLineSpacing = 10
        let width = (with) / 3.2
        let height = width * 1.6
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.routerTapped(id: listItem[indexPath.row].itemID ?? "")
    }
}
