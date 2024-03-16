//
//  OnboardingViewModel.swift
//  VoiceMemo
//
//  Created by JungWoo Choi on 11/3/2024.
//

import Foundation

@Observable class OnboardingViewModel {
  var onboardingContents: [OnboardingContent]
  
  init(
    onboardingContents: [OnboardingContent] = [
      .init(
        imageStr: "onboarding_1",
        title: "Todo List",
        subTitle: "Todo list로 언제 어디서든 해야할 일을 한 눈에"
      ),
      .init(
        imageStr: "onboarding_2",
        title: "Memo List",
        subTitle: "Todo list로 언제 어디서든 해야할 일을 한 눈에"
      ),
      .init(
        imageStr: "onboarding_3",
        title: "Voice memo",
        subTitle: "Todo list로 언제 어디서든 해야할 일을 한 눈에"
      ),
      .init(
        imageStr: "onboarding_4",
        title: "Timer",
        subTitle: "Todo list로 언제 어디서든 해야할 일을 한 눈에"
      )
    ]
  ) {
    self.onboardingContents = onboardingContents
  }
}
