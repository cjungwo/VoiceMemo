//
//  CustomNavigationBar.swift
//  VoiceMemo
//
//  Created by JungWoo Choi on 12/3/2024.
//

import SwiftUI

struct CustomNavigationBar: View {
  let isDisplayLeftBtn: Bool
  let isdisplayRightBtn: Bool
  let leftBtnAction: () -> Void
  let rightBtnAction: () -> Void
  let rightBtnType: NavigationBtnType
  
  init(
    isDisplayLeftBtn: Bool = true,
    isdisplayRightBtn: Bool = true,
    leftBtnAction: @escaping () -> Void = {},
    rightBtnAction: @escaping () -> Void = {},
    rightBtnType: NavigationBtnType = .edit
  ) {
    self.isDisplayLeftBtn = isDisplayLeftBtn
    self.isdisplayRightBtn = isdisplayRightBtn
    self.leftBtnAction = leftBtnAction
    self.rightBtnAction = rightBtnAction
    self.rightBtnType = rightBtnType
  }
  
    var body: some View {
        HStack {
          if isDisplayLeftBtn {
            Button {
              leftBtnAction()
            } label: {
              Image("leftArrow")
            }
          }
          
          Spacer()
          
          if isdisplayRightBtn {
            Button {
              rightBtnAction()
            } label: {
              if rightBtnType == .close {
                Image("close")
              } else {
                Text(rightBtnType.rawValue.capitalized)
                  .foregroundStyle(.customBlack)
              }
            }
          }
        }
        .padding(.horizontal, 20)
        .frame(height: 20)
    }
}

#Preview {
    CustomNavigationBar()
}
