//
//  NewsDetailVC.swift
//  TMedyaNews
//
//  Created by Arda Sisli on 18.12.2023.
//

import UIKit

class NewsDetailVC: UIViewController {
    
    //MARK: - Views
    
    private lazy var parentScrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        scroll.showsVerticalScrollIndicator = false
        scroll.backgroundColor = .white
        scroll.contentSize = CGSize(width: 0 , height: view.frame.height)
        scroll.backgroundColor = .white
        return scroll
    }()
    
    private let parentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .lastBaseline
        stackView.distribution = .equalSpacing
        stackView.spacing = 4
        return stackView
    }()
    
    private lazy var categoryName: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 16)
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()
    
    private lazy var detailTitle: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 22)
        label.textColor = .black
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var detailDescription: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 16)
        label.textColor = .black
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var detailImage: UIImageView = {
        let label = UIImageView()
        return label
    }()
    
    
    //MARK: - Properties
    
    var viewModel: NewsDetailViewModelProtocol?
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initDelegate()
        viewModel?.fetchNewsDetail()
    }
    
    //MARK: - Private Func
    
    private func initDelegate() {
        viewModel?.delegate = self
        
        configure()
    }
    
    private func configure() {
        view.backgroundColor = .gray
        self.title = "Star"
        
        view.addSubview(parentScrollView)
        parentScrollView.addSubview(parentStackView)
        parentStackView.addArrangedSubview(categoryName)
        parentStackView.addArrangedSubview(detailTitle)
        parentStackView.addArrangedSubview(detailImage)
        parentStackView.addArrangedSubview(detailDescription)
        
        makeConstraints()
    }
    
    private func propertyUI() {
        detailTitle.text = viewModel?.getDetailTitle()
        detailDescription.text = viewModel?.getDetailDescription().html2String
        categoryName.text = viewModel?.getCategoryName()
        if let url = URL(string: viewModel?.getDetailImage() ?? "") {
            detailImage.kf.setImage(with: url)
        }
    }
}

//MARK: - NewsDetailViewModelDelegate

extension NewsDetailVC: NewsDetailViewModelDelegate {
    func handleOutPut(_ output: NewsDetailViewModelOutPut) {
        switch output {
        case .itemDetail:
            DispatchQueue.main.async {
                self.propertyUI()
            }
            
        case .error(let error):
            print(error)
        }
    }
}

//MARK: HTML to String

extension Data {
    var html2AttributedString: NSAttributedString? {
        do {
            return try NSAttributedString(data: self, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            print("error:", error)
            return  nil
        }
    }
    var html2String: String { html2AttributedString?.string ?? "" }
}

extension StringProtocol {
    var html2AttributedString: NSAttributedString? {
        Data(utf8).html2AttributedString
    }
    var html2String: String {
        html2AttributedString?.string ?? ""
    }
}


//MARK: - Constraints

extension NewsDetailVC {
    func makeConstraints() {
        parentScrollView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.left.equalTo(view).offset(0)
            make.right.equalTo(view).offset(0)
            make.width.equalTo(view.frame.size.width)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        parentStackView.snp.makeConstraints { make in
            make.top.bottom.trailing.leading.equalTo(parentScrollView)
            make.width.equalTo(parentScrollView.snp.width)
        }
        
        categoryName.snp.makeConstraints { make in
            make.top.equalTo(32)
            make.left.equalTo(16)
        }
        
        detailTitle.snp.makeConstraints { make in
            make.left.equalTo(16)
            make.right.equalTo(-16)
            make.top.equalTo(categoryName.snp.bottom).offset(24)
        }
        
        detailImage.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX)
            make.height.equalTo(UIScreen.screenHeight / 3)
            make.width.equalTo(UIScreen.screenWidth / 1.2)
            make.top.equalTo(detailTitle.snp.bottom).offset(24)
        }
        
        detailDescription.snp.makeConstraints { make in
            make.left.equalTo(16)
            make.right.equalTo(-16)
            make.top.equalTo(detailImage.snp.bottom).offset(24)
        }
    }
}
