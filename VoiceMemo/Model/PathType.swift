//
//  PathType.swift
//  VoiceMemo
//
//  Created by JungWoo Choi on 12/3/2024.
//

import Foundation

enum PathType: Hashable {
  case homeView
  case todoView
  case memoView(isCreateMode: Bool, memo: Memo?)
}
