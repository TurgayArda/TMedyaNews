//
//  NewsListHeaderCollectionViewCell.swift
//  TMedyaNews
//
//  Created by Arda Sisli on 18.12.2023.
//

import UIKit

protocol RouteTapped {
    func navigateToVC(id: String)
}

class NewsListHeaderCollectionViewCell: UICollectionViewCell {
    
    //MARK: - Views
    
    private lazy var newsListCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .white
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(
            NewsListCollectionViewCell.self,
            forCellWithReuseIdentifier: NewsListCollectionViewCell.Identifier.path.rawValue
        )
        
        return collectionView
    }()
    
    var delegate: RouteTapped?
    var provider = NewsListCollectionProvider()
    var itemList: [ItemList] = []
    
    enum Identifier: String {
        case path = "Cell"
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure() {
        contentView.backgroundColor = .white
        provider.delegate = self
        newsListCollectionView.delegate = provider
        newsListCollectionView.dataSource = provider
        contentView.addSubview(newsListCollectionView)
        makeConstraints()
    }
    
    func reset() {
        itemList.removeAll()
    }
    
    func loadProvider() {
        provider.load(value: itemList)
    }
    
    func saveModel(value: [ItemList]) {
        itemList = value
        loadProvider()
        newsListCollectionView.reloadData()
    }
}

extension NewsListHeaderCollectionViewCell: NewsListCollectionProviderDelegate {
    func getWidth() -> CGFloat {
        return contentView.frame.size.width
    }
    
    func routerTapped(id: String) {
        delegate?.navigateToVC(id: id)
    }
}

//MARK: - Constraints

extension NewsListHeaderCollectionViewCell {
    private func makeConstraints() {
        newsListCollectionView.snp.makeConstraints { make in
            make.top.bottom.left.right.equalTo(contentView)
        }
    }
}
