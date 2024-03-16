//
//  MemoViewModel.swift
//  VoiceMemo
//
//  Created by JungWoo Choi on 13/3/2024.
//

import Foundation

class MemoViewModel: ObservableObject {
  @Published var memo: Memo
  
  init(memo: Memo) {
    self.memo = memo
  }
}
