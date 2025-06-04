//
//  OnboardingViewController.swift
//  VideoPlayer
//
//  Created by Даниил on 3.06.25.
//

import UIKit
import SnapKit

class OnboardingViewController: UIViewController {
    // MARK: - Typealiases
    
    typealias Texts = GlobalConstants.Texts
    typealias Constants = GlobalConstants.Constants
    
    // MARK: - Properties
        
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = .zero
        layout.minimumInteritemSpacing = .zero
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.bouncesHorizontally = false
        collectionView.alwaysBounceHorizontal = false
        collectionView.register(OnboardingViewCell.self, forCellWithReuseIdentifier: OnboardingViewCell.identifier)
        collectionView.backgroundColor = .clear
        collectionView.isPagingEnabled = true
        
        return collectionView
    }()
    
    private let viewModel: IOngboardingViewModel = OnboardingViewModel()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
    }
}

private extension OnboardingViewController {
    // MARK: Methods
    
    func configureUI() {
        view.backgroundColor = .systemBackground
        
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        let nextButton = UIButton(type: .system)
        nextButton.setTitle(Texts.nextTitle, for: .normal)
        nextButton.tintColor = .white
        nextButton.addAction(UIAction(handler: { [weak self] _ in
            self?.nextButtonTapped()
        }), for: .touchUpInside)
        
        view.addSubview(nextButton)
        nextButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(Constants.verticalSpacing)
            make.right.equalToSuperview().inset(Constants.horizontalSpacing)
        }
    }
    
    func nextButtonTapped() {
        let index = viewModel.getNextPage()
        collectionView.scrollToItem(at: IndexPath(item: index, section: .zero), at: .centeredHorizontally, animated: true)
    }
}

extension OnboardingViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    // MARK: CollectionView Methods
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.numberOfPages
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OnboardingViewCell.identifier, for: indexPath) as? OnboardingViewCell else { return UICollectionViewCell() }
        
        cell.configure(with: viewModel.getPage(at: indexPath.row))
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        collectionView.bounds.size
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let cell = cell as? OnboardingViewCell else { return }
        cell.willShow()
        
        viewModel.setCurrentPage(index: indexPath.row)
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let cell = cell as? OnboardingViewCell else { return }
        cell.didHide()
    }
}
