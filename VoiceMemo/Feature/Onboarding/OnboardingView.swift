//
//  OnboardingView.swift
//  VoiceMemo
//
//  Created by JungWoo Choi on 11/3/2024.
//

import SwiftUI

struct OnboardingView: View {
  @State var path = Path()
  @State var viewModel = OnboardingViewModel()
  @State var homeViewModel = HomeViewModel()
  @State var todoListViewModel = TodoListViewModel()
  @State var memoListViewModel = MemoListViewModel()
  
  var body: some View {
    NavigationStack(path: $path.paths) {
      OnboardingContentView(viewModel: viewModel)
        .navigationDestination(for: PathType.self) { pathType in
          switch pathType {
          case .homeView:
            HomeView()
              .navigationBarBackButtonHidden()
              .environment(homeViewModel)
              .environment(todoListViewModel)
              .environment(memoListViewModel)
            
          case .todoView:
            TodoView()
              .navigationBarBackButtonHidden()
              .environment(todoListViewModel)
            
          case let .memoView(isCreateMode, memo):
            MemoView(
              memoViewModel: isCreateMode
              ? .init(memo: .init(title: "", content: "", date: .now))
              : .init(memo: memo ?? .init(title: "", content: "", date: .now)),
              isCreateMode: isCreateMode
            )
              .navigationBarBackButtonHidden()
              .environment(memoListViewModel)
          }
        }
    }
    .environment(path)
  }
}

// MARK: - OnboardingContentView
private struct OnboardingContentView: View {
  private var viewModel: OnboardingViewModel
  
  fileprivate init(viewModel: OnboardingViewModel) {
    self.viewModel = viewModel
  }
  
  fileprivate var body: some View {
    VStack {
      OnboardingCellListView(viewModel: viewModel)
      
      Spacer()
      
      StartBtnView()
      
      Spacer()
    }
    .ignoresSafeArea()
  }
}

// MARK: - OnboardingCellListView
private struct OnboardingCellListView: View {
  private var viewModel: OnboardingViewModel
  @State private var selectedIndex: Int
  
  fileprivate init(
    viewModel: OnboardingViewModel,
    selectedIndex: Int = 0
  ) {
    self.viewModel = viewModel
    self.selectedIndex = selectedIndex
  }
  
  fileprivate var body: some View {
    TabView(selection: $selectedIndex) {
      ForEach(Array(viewModel.onboardingContents.enumerated()), id: \.element) { index, onboardingContent in
         OnboardingCellView(onboardingContent: onboardingContent)
          .tag(index)
      }
    }
    .tabViewStyle(.page(indexDisplayMode: .never))
    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 1.3)
    .background(
      selectedIndex % 2 == 0
      ? Color.customSky
      : Color.customBackgroundGreen
    )
    .clipped()
  }
}

// MARK: - OnboardingCellView
private struct OnboardingCellView: View {
  private var onboardingContent: OnboardingContent
  
  fileprivate init(onboardingContent: OnboardingContent) {
    self.onboardingContent = onboardingContent
  }
  
  fileprivate var body: some View {
    VStack {
      Image(onboardingContent.imageStr)
        .resizable()
        .scaledToFit()
      
      HStack {
        Spacer()
        
        VStack {
          Spacer()
            .frame(height: 46)
          
          Text(onboardingContent.title)
            .font(.system(size: 16, weight: .bold))
          
          Spacer()
            .frame(height: 5)
          
          Text(onboardingContent.subTitle)
            .font(.system(size: 16))
        }
        
        Spacer()
      }
      .background(Color.customWhite)
      .clipShape(.rect)
    }
    .shadow(radius: 10)
  }
}

// MARK: - StartBtnView
private struct StartBtnView: View {
  @Environment(Path.self) private var path
  
  fileprivate var body: some View {
    Button {
      path.paths.append(.homeView)
    } label: {
      HStack {
        Text("Start")
          .font(.system(size: 16, weight: .medium))
          .foregroundStyle(.customGreen)
        
        Image("startHome")
          .renderingMode(.template)
          .foregroundStyle(.customGreen)
      }
    }
  }
}

#Preview {
  OnboardingView()
}
