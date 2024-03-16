//
//  MemoListView.swift
//  VoiceMemo
//
//  Created by JungWoo Choi on 13/3/2024.
//

import SwiftUI

struct MemoListView: View {
  @Environment(Path.self) private var path
  @Environment(MemoListViewModel.self) private var memoListViewModel
  @Environment(HomeViewModel.self) private var homeViewModel
  
  var body: some View {
    @Bindable var memoListViewModel = memoListViewModel
    ZStack {
      VStack {
        if !memoListViewModel.memos.isEmpty {
          CustomNavigationBar(
            isDisplayLeftBtn: false,
            rightBtnAction: {
              memoListViewModel.navigationRightBtnTapped()
            },
            rightBtnType: memoListViewModel.navigationBarRightBtnMode
          )
        } else {
          Spacer()
            .frame(height: 30)
        }
        
        TitleView()
        
        if memoListViewModel.memos.isEmpty {
          AnnouncementView()
        } else {
          MemoListContentView()
            .padding(.top, 20)
        }
      }
      
      WrightMemoBtnView()
        .padding(.trailing, 20)
        .padding(.bottom, 50)
    }
    .alert(
      "Remove \(memoListViewModel.removeMemoCount) memo",
      isPresented: $memoListViewModel.isdisplayRemoveMemoAlert
    ) {
      Button(role: .destructive) {
        memoListViewModel.removeBtnTapped()
      } label: {
        Text("Delete")
      }
      
      Button(role: .cancel) {
        //
      } label: {
        Text("Cancel")
      }
    }
    .onChange(of: memoListViewModel.memos) { _, memos in
      homeViewModel.setTodosCount(memos.count)
    }
  }
}

// MARK: - TitleView
private struct TitleView: View {
  @Environment(MemoListViewModel.self) private var memoListViewModel
  
  fileprivate var body: some View {
    HStack {
      if memoListViewModel.memos.isEmpty {
        Text("Add new memo")
      } else {
        Text("There are \(memoListViewModel.memos.count) memos\n in the List")
      }
      
      Spacer()
    }
    .font(.system(size: 30, weight: .bold))
    .padding(.leading, 20)
  }
}

// MARK: - AnnouncementView
private struct AnnouncementView: View {
  fileprivate var body: some View {
    VStack {
      Spacer()
      
      Image("pencil")
        .renderingMode(.template)
      
      Text("Memo.......")
      Text("Memo.......")
      Text("Memo.......")
      
      Spacer()
    }
    .font(.system(size: 16))
    .foregroundStyle(.customGray2)
  }
}

// MARK: - MemoListcontentView
private struct MemoListContentView: View {
  @Environment(MemoListViewModel.self) private var memoListViewModel
  
  fileprivate var body: some View {
    VStack {
      HStack {
        Text("Memo List")
          .font(.system(size: 16, weight: .bold))
          .padding(.leading, 20)
        
        Spacer()
      }
      
      ScrollView {
        VStack(spacing: 0) {
          Rectangle()
            .fill(.customGray0)
            .frame(height: 1)
          
          ForEach(memoListViewModel.memos, id: \.self) { memo in
            MemoCellView(memo: memo)
          }
        }
      }
    }
  }
}

// MARK: - MemoCellView
private struct MemoCellView: View {
  @Environment(Path.self) private var path
  @Environment(MemoListViewModel.self) private var memoListViewModel
  @State private var isRemoveSelected: Bool
  private var memo: Memo
  
  fileprivate init(
    isRemoveSelected: Bool = false,
    memo: Memo
  ) {
    _isRemoveSelected = State(initialValue: isRemoveSelected)
    self.memo = memo
  }
  
  fileprivate var body: some View {
    Button {
      path.paths.append(.memoView(isCreateMode: false, memo: memo))
    } label: {
      VStack(spacing: 10) {
        HStack {
          VStack(alignment: .leading) {
            Text(memo.title)
              .lineLimit(1)
              .font(.system(size: 16))
              .foregroundStyle(.customBlack)
            
            Text(memo.convertedDate)
              .font(.system(size: 12))
              .foregroundStyle(.customIconGray)
          }
          
          Spacer()
          
          if memoListViewModel.isEditMemoMode {
            Button {
              isRemoveSelected.toggle()
              memoListViewModel.memoRemoveSelectedBoxTapped(memo)
            } label: {
              isRemoveSelected ? Image("selectedBox") : Image("unSelectedBox")
            }
          }
        }
        .padding(.horizontal, 30)
        .padding(.top, 10)
        
        Rectangle()
          .fill(.customGray0)
          .frame(height: 1)
      }
    }

  }
}

// MARK: - WriteMemoBtnView
private struct WrightMemoBtnView: View {
  @Environment(Path.self) private var path
  
  fileprivate var body: some View {
    VStack {
      Spacer()
      
      HStack {
        Spacer()
        
        Button {
          path.paths.append(.memoView(isCreateMode: true, memo: nil))
        } label: {
          Circle()
            .fill(.customGreen)
            .frame(width: 64, height: 64)
            .overlay {
              Image(systemName: "pencil")
                .resizable()
                .frame(width: 32, height: 24)
                .foregroundStyle(.customWhite)
            }
        }
      }
    }
  }
}

#Preview {
  MemoListView()
    .environment(Path())
    .environment(MemoListViewModel())
    .environment(HomeViewModel())
}
