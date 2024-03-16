//
//  SettingView.swift
//  VoiceMemo
//
//  Created by JungWoo Choi on 15/3/2024.
//

import SwiftUI

struct SettingView: View {
  
  @Environment(HomeViewModel.self) var homeViewModel
  
    var body: some View {
        VStack {
          TitleView()
          
          Spacer()
            .frame(height: 35)
          
          TotalTabCountView()
          
          
          TotalTabMoveView()
          
          Spacer()
        }
    }
}

// MARK: - TitleView
private struct TitleView: View {
  fileprivate var body: some View {
    HStack {
      Text("Setting")
        .font(.system(size: 30, weight: .bold))
        .foregroundStyle(.customBlack)
      
      Spacer()
    }
    .padding(.horizontal, 30)
    .padding(.top, 45)
  }
}

// MARK: - TotalTabCountView
private struct TotalTabCountView: View {
  @Environment(HomeViewModel.self) var homeViewModel
  
  fileprivate var body: some View {
    HStack {
      Spacer()
      TabCountView(title: "To do", count: homeViewModel.todosCount)
      Spacer()
      TabCountView(title: "VoiceMemo", count: homeViewModel.memosCount)
      Spacer()
      TabCountView(title: "Memo", count: homeViewModel.voiceRecordersCount)
      Spacer()
    }
  }
}

// MARK: - TabCountView
private struct TabCountView: View {
  private var title: String
  private var count: Int
  
  init(
    title: String,
    count: Int
  ) {
    self.title = title
    self.count = count
  }
  
  fileprivate var body: some View {
    VStack(spacing: 5) {
      Text(title)
        .font(.system(size: 14))
        .foregroundStyle(.customBlack)
      
      Text("\(count)")
        .font(.system(size: 30, weight: .medium))
        .foregroundStyle(.customBlack)
    }
  }
}

// MARK: - TotalTabMoveView
private struct TotalTabMoveView: View {
  @Environment(HomeViewModel.self) var homeViewModel
  
  fileprivate var body: some View {
    VStack {
      Rectangle()
        .fill(.customGray1)
        .frame(height: 1)
      
      TabMoveView(title: "To do List", tabAction: {
        homeViewModel.changeSelectedTab(Tab.todoList)
      })
      TabMoveView(title: "Memo List", tabAction: {
        homeViewModel.changeSelectedTab(Tab.memo)
      })
      TabMoveView(title: "Voice Recorder", tabAction: {
        homeViewModel.changeSelectedTab(Tab.voiceRecorder)
      })
      TabMoveView(title: "Timer", tabAction: {
        homeViewModel.changeSelectedTab(Tab.timer)
      })
      
      Rectangle()
        .fill(.customGray1)
        .frame(height: 1)
    }
  }
}

private struct TabMoveView: View {
  private var title: String
  private var tabAction: () -> Void
  
  fileprivate init(
    title: String,
    tabAction: @escaping () -> Void
  ) {
    self.title = title
    self.tabAction = tabAction
  }
  
  fileprivate var body: some View {
    Button {
      tabAction()
    } label: {
      HStack {
        Text(title)
          .font(.system(size: 14))
          .foregroundStyle(.customBlack)
        
        Spacer()
        
        Image("arrowRight")
      }
    }
    .padding(.all, 20)
  }
}

#Preview {
    SettingView()
    .environment(HomeViewModel())
}
