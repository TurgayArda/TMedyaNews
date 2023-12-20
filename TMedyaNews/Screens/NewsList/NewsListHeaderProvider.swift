//
//  NewsListProvider.swift
//  TMedyaNews
//
//  Created by Arda Sisli on 18.12.2023.
//

import UIKit

protocol NewsListHeaderProviderProtocol {
    var delegate: NewsListHeaderProviderDelegate? { get set }
    func update(with viewmodel: NewsListViewModelProtocol)
}

protocol NewsListHeaderProviderDelegate {
    func getWidth() -> CGFloat
    func navigate(id: String)
}

class NewsListHeaderProvider: NSObject {
    var delegate: NewsListHeaderProviderDelegate?
    var listTitle: [String] = []
    var videoURL = String()
    var categoryList: [[ItemList]] = [[]]
}

extension NewsListHeaderProvider: NewsListHeaderProviderProtocol {
    func update(with viewmodel: NewsListViewModelProtocol) {
        self.listTitle = viewmodel.getCategoryTitle()
        self.videoURL = viewmodel.getVideoURL()
        self.categoryList = viewmodel.getItemListData()
    }
}

//MARK: - UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, RouteTapped

extension NewsListHeaderProvider: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, RouteTapped {
    func navigateToVC(id: String) {
        delegate?.navigate(id: id)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return listTitle.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LiveCollectionViewCell.Identifier.path.rawValue, for: indexPath) as? LiveCollectionViewCell else {
                return UICollectionViewCell()
            }
            
            if let videoURL = URL(string: videoURL) {
                cell.configure(with: videoURL)
            }
            
            return cell
            
        default:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NewsListHeaderCollectionViewCell.Identifier.path.rawValue, for: indexPath) as? NewsListHeaderCollectionViewCell else {
                return UICollectionViewCell()
            }
            
            cell.delegate = self
            cell.reset()
            
            let data = categoryList[indexPath.section]
            cell.saveModel(value: data)
            
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                     withReuseIdentifier: NewsCategoryCollectionReusableView.identifier,
                                                                     for: indexPath) as! NewsCategoryCollectionReusableView
        
        switch indexPath.section {
        case 0:
            header.titleLabel.text = ""
            
            return header
        default:
            header.titleLabel.text = listTitle[indexPath.section - 1]
            
            return header
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        var padding = 0.0
        
        switch section {
        case 0:
            padding = 0
        default:
            padding = 10
        }
        
        return UIEdgeInsets(top: padding, left: 0, bottom: 10, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        guard let width = delegate?.getWidth() else { return CGSize(width: 30, height: 30) }
        switch section {
        case 0:
            return CGSize(width: 0,
                          height: 0)
        default:
            return CGSize(width: width,
                          height: 40)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width
        let flowLayout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0)
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.minimumLineSpacing = 0
        
        switch indexPath.section {
        case 0:
            let height = width
            return CGSize(width: width, height: height)
        default:
            let height = width * 0.55
            return CGSize(width: width, height: height)
            
        }
    }
}
