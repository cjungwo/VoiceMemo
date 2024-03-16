//
//  Path.swift
//  VoiceMemo
//
//  Created by JungWoo Choi on 12/3/2024.
//

import Foundation

@Observable class Path {
  var paths: [PathType]
  
  init(paths: [PathType] = []) {
    self.paths = paths
  }
}
