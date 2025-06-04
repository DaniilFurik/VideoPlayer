//
//  OnboardingViewCell.swift
//  VideoPlayer
//
//  Created by Даниил on 4.06.25.
//

import UIKit
import AVKit

class OnboardingViewCell: UICollectionViewCell {
    // MARK: - Typealiases
    
    typealias Constants = GlobalConstants.Constants
    
    // MARK: - Properties
    
    static var identifier: String { "\(Self.self)" }
    
    private var player: AVPlayer?
    private var playerLayer: AVPlayerLayer?
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        return label
    }()
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        player?.pause()
        player = nil
        playerLayer?.removeFromSuperlayer()
        playerLayer = nil
        
        titleLabel.text = nil
        NotificationCenter.default.removeObserver(self)
    }
}

extension OnboardingViewCell {
    // MARK: - Methods
    
    func configure(with model: OnboardingModel) {
        titleLabel.text = model.title
        
        guard let url = Bundle.main.url(forResource: model.videoFileName, withExtension: .extensionMP4) else { return }
        
        let player = AVPlayer(url: url)
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = contentView.bounds
        playerLayer.videoGravity = .resizeAspectFill
        contentView.layer.insertSublayer(playerLayer, at: .zero)
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(playerDidFinishPlaying(_:)),
            name: .AVPlayerItemDidPlayToEndTime,
            object: player.currentItem
        )
        
        self.player = player
        self.playerLayer = playerLayer
    }
    
    func willShow() {
        player?.play()
    }
    
    func didHide() {
        player?.pause()
    }
}

private extension OnboardingViewCell {
    // MARK: - Private Methods
    
    func configureUI() {
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(Constants.titleSpacing)
            make.centerX.equalToSuperview()
        }
    }
    
    @objc func playerDidFinishPlaying(_ notification: Notification) {
        player?.seek(to: .zero)
        player?.play()
    }
}
