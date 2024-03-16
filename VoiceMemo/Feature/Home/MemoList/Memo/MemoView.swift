//
//  MemoView.swift
//  VoiceMemo
//
//  Created by JungWoo Choi on 12/3/2024.
//

import SwiftUI

struct MemoView: View {
  @Environment(Path.self) var path
  @Environment(MemoListViewModel.self) var memoListViewModel
  @State var memoViewModel: MemoViewModel
  @State var isCreateMode: Bool = true
  
  var body: some View {
    ZStack {
      VStack {
        CustomNavigationBar(
          leftBtnAction: {
            path.paths.removeLast()
          },
          rightBtnAction: {
            if isCreateMode {
              memoListViewModel.addMemo(memoViewModel.memo)
            } else {
              memoListViewModel.updateMemo(memoViewModel.memo)
            }
            path.paths.removeLast()
          },
          rightBtnType: isCreateMode ? .create : .complete
        )
        
        MemoTitleView(
          memoViewModel: memoViewModel,
          isCreateMode: $isCreateMode
        )
        .padding(.top, 20)
        
        MemoContentInputView(memoViewModel: memoViewModel)
          .padding(.top, 10)
        
        if !isCreateMode {
          RemoveMemoBtnView(memoViewModel: memoViewModel)
            .padding(.trailing, 20)
            .padding(.bottom, 10)
        }
        
        Spacer()
      }
      .padding(.top, 20)
    }
  }
}

// MARK: - MemoTitleView
private struct MemoTitleView: View {
  @Bindable private var memoViewModel: MemoViewModel
  @FocusState private var isTitleFieldFocused: Bool
  @Binding private var isCreateMode: Bool

  fileprivate init(
    memoViewModel: MemoViewModel,
    isCreateMode: Binding<Bool>
  ) {
    self.memoViewModel = memoViewModel
    self._isCreateMode = isCreateMode
  }
  
  fileprivate var body: some View {
    TextField(
      "Enter title:",
      text: $memoViewModel.memo.title
    )
    .font(.system(size: 30))
    .padding(.horizontal, 20)
    .focused($isTitleFieldFocused)
    .onAppear {
      if isCreateMode {
        isTitleFieldFocused = true
      }
    }
  }
}

// MARK: - MemoContentInputView
private struct MemoContentInputView: View {
  @Bindable private var memoViewModel: MemoViewModel
  
  fileprivate init(memoViewModel: MemoViewModel) {
    self.memoViewModel = memoViewModel
  }
  
  fileprivate var body: some View {
    ZStack(alignment: .topLeading) {
      TextEditor(text: $memoViewModel.memo.content)
        .font(.system(size: 16))
      
      if memoViewModel.memo.content.isEmpty {
        Text("Enter content...")
          .font(.system(size: 16))
          .foregroundStyle(.customGray1)
          .allowsHitTesting(false)
          .padding(.top, 10)
          .padding(.leading, 5)
      }
    }
    .padding(.horizontal, 20)
  }
}

// MARK: RemoveMemoBtnView
private struct RemoveMemoBtnView: View {
  @Environment(Path.self) var path
  @Environment(MemoListViewModel.self) var memoListViewModel
  private var memoViewModel: MemoViewModel
  
  fileprivate init(memoViewModel: MemoViewModel) {
    self.memoViewModel = memoViewModel
  }
  
  fileprivate var body: some View {
    VStack {
      Spacer()
      
      HStack {
        Spacer()
        
        Button {
          memoListViewModel.removeMemo(memoViewModel.memo)
          path.paths.removeLast()
        } label: {
          Image("trash")
            .resizable()
            .frame(width: 40, height: 40)
        }

      }
    }
  }
}

#Preview {
  MemoView(
    memoViewModel: MemoViewModel(
      memo: .init(
        title: "",
        content: "",
        date: .init()
      )
    )
  )
  .environment(Path())
  .environment(MemoListViewModel())
}
