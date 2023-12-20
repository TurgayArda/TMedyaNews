//
//  NewsListVC.swift
//  TMedyaNews
//
//  Created by Arda Sisli on 18.12.2023.
//

import UIKit

class NewsListVC: UIViewController {
    
    //MARK: - Views
    
    var newsListCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = .white
        collectionView.isScrollEnabled = true
        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.register(
            LiveCollectionViewCell.self,
            forCellWithReuseIdentifier: LiveCollectionViewCell.Identifier.path.rawValue
        )
        
        collectionView.register(
            NewsListHeaderCollectionViewCell.self,
            forCellWithReuseIdentifier: NewsListHeaderCollectionViewCell.Identifier.path.rawValue
        )
        
        collectionView.register(NewsCategoryCollectionReusableView.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: NewsCategoryCollectionReusableView.identifier
        )
        
        return collectionView
    }()
    
    //MARK: - Properties
    
    private var newsListHeaderProvider = NewsListHeaderProvider()
    
    var viewModel: NewsListViewModelProtocol?
    var router: NewsListRouterProtocol?
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initDelegate()
        viewModel?.fetchNewsList()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if let liveCell = findLiveCollectionViewCell() {
            liveCell.stopVideo()
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let liveCell = findLiveCollectionViewCell() {
            liveCell.appBecomeActive()
        }
    }
    
    //MARK: - Private Func
    
    private func findLiveCollectionViewCell() -> LiveCollectionViewCell? {
        let indexPath = IndexPath(item: 0, section: 0)
        if let cell = newsListCollectionView.cellForItem(at: indexPath) as? LiveCollectionViewCell {
            return cell
        }
        return nil
    }
    
    private func initDelegate() {
        viewModel?.delegate = self
        newsListHeaderProvider.delegate = self
        newsListCollectionView.delegate = newsListHeaderProvider
        newsListCollectionView.dataSource = newsListHeaderProvider
        
        configure()
    }
    
    private func configure() {
        self.title = NewsScreensConstant.UIConstant.title.rawValue
        view.backgroundColor = .gray
        view.addSubview(newsListCollectionView)
        
        makeConstraints()
    }
}

//MARK: - NewsListViewModelDelegate

extension NewsListVC: NewsListViewModelDelegate {
    func handleOutPut(_ output: NewsListViewModelOutPut) {
        switch output {
        case .itemList:
            guard let viewModel else { return }
            newsListHeaderProvider.update(with: viewModel)
            DispatchQueue.main.async {
                self.newsListCollectionView.reloadData()
            }
            
        case .error(let error):
            print(error)
        }
    }
}

//MARK: - NewsListHeaderProviderDelegate

extension NewsListVC: NewsListHeaderProviderDelegate {
    func getWidth() -> CGFloat {
        view.frame.size.width
    }
    
    func navigate(id: String) {
        router?.navigate(id: id)
    }
}

//MARK: - Constraints

extension NewsListVC {
    private func makeConstraints() {
        newsListCollectionView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}
