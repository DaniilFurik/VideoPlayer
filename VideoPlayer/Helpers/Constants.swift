//
//  Constants.swift
//  VideoPlayer
//
//  Created by Даниил on 4.06.25.
//

import UIKit

enum GlobalConstants {
    enum Texts {
        static let nextTitle = "Next"
        
        static let firstVideoTitle = "First video"
        static let secondVideoTitle = "Second video"
        static let thirdVideoTitle = "Third video"
    }

    enum Constants {
        static let verticalSpacing: CGFloat = 16
        static let horizontalSpacing: CGFloat = 16
        static let titleSpacing: CGFloat = 48
    }
    
    enum FileNames {
        static let firstVideo = "Testdrive_01"
        static let secondVideo = "Testdrive_02"
        static let thirdVideo = "Testdrive_03"
        static let extensionMP4 = "mp4"
    }
}

extension String {
    static let extensionMP4 = "mp4"
}
