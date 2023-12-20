//
//  LiveCollectionViewCell.swift
//  TMedyaNews
//
//  Created by Arda Sisli on 18.12.2023.
//

import UIKit
import SnapKit
import AVFoundation
import AVKit

class LiveCollectionViewCell: UICollectionViewCell {
    
    //MARK: - Views
    
    lazy var playerViewController: AVPlayerViewController = {
        let vc = AVPlayerViewController()
        vc.allowsPictureInPicturePlayback = false
        return vc
    }()
    
    //MARK: - Properties
    
    var player = AVPlayer()
    var isCellVisible: Bool = false
    
    //MARK: - Id
    
    enum Identifier: String {
        case path = "CellLive"
    }
    
    //MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Private Func
    
    private func configure() {
        contentView.backgroundColor = .white
        playerViewController.view.frame.size.height = contentView.frame.size.height
        playerViewController.view.frame.size.width  = contentView.frame.size.width
        contentView.addSubview(playerViewController.view)
    }
    
    func configure(with videoURL: URL) {
        if isCellVisible == false {
            player = AVPlayer(url: videoURL)
            playerViewController.player = player
            playerViewController.player?.play()
            self.isCellVisible = true
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(appBecomeActive), name: UIApplication.didBecomeActiveNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(appResignActive), name: UIApplication.willResignActiveNotification, object: nil)
    }
    
    func stopVideo() {
        player.volume = 0.0
    }
    
    @objc func appBecomeActive() {
        if player.rate == 0 {
            player.volume = 1.0
            playerViewController.player = player
            playerViewController.player?.play()
        }else{
            player.volume = 1.0
            playerViewController.player = player
            playerViewController.player?.play()
        }
        
    }
    
    @objc func appResignActive() {
        playerViewController.player = nil
    }
}
