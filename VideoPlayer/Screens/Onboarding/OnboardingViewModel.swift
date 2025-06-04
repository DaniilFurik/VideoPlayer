//
//  OnboardingViewModel.swift
//  VideoPlayer
//
//  Created by Даниил on 4.06.25.
//

import AVKit

protocol IOngboardingViewModel {
    var numberOfPages: Int { get }
    func getPage(at index: Int) -> OnboardingModel
    func getNextPage() -> Int
    func setCurrentPage(index: Int)
}

final class OnboardingViewModel {
    // MARK: - Typealiases
    
    typealias Texts = GlobalConstants.Texts
    typealias FileNames = GlobalConstants.FileNames
    
    // MARK: - Properties
    
    private var pages: [OnboardingModel]
    private var currentPageIndex: Int = .zero
    
    var numberOfPages: Int {
        return pages.count
    }
    
    init() {
        pages = [
            OnboardingModel(title: Texts.firstVideoTitle, videoFileName: FileNames.firstVideo),
            OnboardingModel(title: Texts.secondVideoTitle, videoFileName: FileNames.secondVideo),
            OnboardingModel(title: Texts.thirdVideoTitle, videoFileName: FileNames.thirdVideo)
        ]
    }
}

extension OnboardingViewModel: IOngboardingViewModel {
    // MARK: - Methods
    
    func getPage(at index: Int) -> OnboardingModel {
        return pages[index]
    }
    
    func setCurrentPage(index: Int) {
        currentPageIndex = index
    }
    
    func getNextPage() -> Int {
        if currentPageIndex + 1 < pages.count {
            currentPageIndex += 1
        } else {
            currentPageIndex = .zero
        }
        
        return currentPageIndex
    }
}
