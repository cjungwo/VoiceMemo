//
//  MemoViewModel.swift
//  VoiceMemo
//
//  Created by JungWoo Choi on 13/3/2024.
//

import Foundation

@Observable class MemoViewModel {
  var memo: Memo
  
  init(memo: Memo) {
    self.memo = memo
  }
}
