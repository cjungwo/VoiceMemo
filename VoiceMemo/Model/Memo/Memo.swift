//
//  Memo.swift
//  VoiceMemo
//
//  Created by JungWoo Choi on 13/3/2024.
//

import Foundation

struct Memo: Hashable {
  var title: String
  var content: String
  var date: Date
  var id = UUID()
  
  var convertedDate: String {
    String("\(date.formattedTime) - \(date.formmatedDay)")
  }
}
