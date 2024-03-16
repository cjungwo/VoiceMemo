//
//  HomeView.swift
//  VoiceMemo
//
//  Created by JungWoo Choi on 12/3/2024.
//

import SwiftUI

struct HomeView: View {
  @Environment(Path.self) var path
  @Environment(HomeViewModel.self) var homeViewModel
  
    var body: some View {
      ZStack {
        MainTabView(homeViewModel: homeViewModel)
        
        SeperatorLineView()
      }
    }
}

// MARK: - MainTabView
private struct MainTabView: View {
  @Bindable var homeViewModel: HomeViewModel
  
  fileprivate var body: some View {
    TabView(selection: $homeViewModel.selectedTab) {
      TodoListView()
        .tabItem {
            Image(
              homeViewModel.selectedTab == .todoList
              ? "todoIcon_selected"
              : "todoIcon"
            )
        }
        .tag(Tab.todoList)
      
      MemoListView()
        .tabItem {
            Image(
              homeViewModel.selectedTab == .memo
              ? "memoIcon_selected"
              : "memoIcon"
            )
        }
        .tag(Tab.memo)
      
      VoiceRecorderView()
        .tabItem {
            Image(
              homeViewModel.selectedTab == .voiceRecorder
              ? "recordIcon_selected"
              : "recordIcon"
            )
        }
        .tag(Tab.voiceRecorder)
      
      TimerView()
        .tabItem {
            Image(
              homeViewModel.selectedTab == .timer
              ? "timerIcon_selected"
              : "timerIcon"
            )
        }
        .tag(Tab.timer)
      
      SettingView()
        .tabItem {
            Image(
              homeViewModel.selectedTab == .setting
              ? "settingIcon_selected"
              : "settingIcon"
            )
        }
        .tag(Tab.setting)
    }
  }
}

// MARK: - SeperatorLineView
private struct SeperatorLineView: View {
  fileprivate var body: some View {
    VStack {
      Spacer()
      
      Rectangle()
        .fill(
          LinearGradient(
            gradient: Gradient(colors: [.white, .gray.opacity(0.1)]),
            startPoint: .top,
            endPoint: .bottom
          )
        )
        .frame(height: 10)
        .padding(.bottom, 60)
    }
  }
}

#Preview {
  HomeView()
    .environment(Path())
    .environment(HomeViewModel())
    .environment(TodoListViewModel())
    .environment(MemoListViewModel())
}
