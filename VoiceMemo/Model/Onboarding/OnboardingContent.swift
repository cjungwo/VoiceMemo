//
//  OnboardingContent.swift
//  VoiceMemo
//
//  Created by JungWoo Choi on 11/3/2024.
//

import Foundation

struct OnboardingContent: Hashable {
    var imageStr: String
    var title: String
    var subTitle: String
    
    init(
        imageStr: String,
        title: String,
        subTitle: String
    ) {
        self.imageStr = imageStr
        self.title = title
        self.subTitle = subTitle
    }
}
