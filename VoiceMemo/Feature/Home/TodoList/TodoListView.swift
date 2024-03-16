//
//  TodoListView.swift
//  VoiceMemo
//
//  Created by JungWoo Choi on 12/3/2024.
//

import SwiftUI

struct TodoListView: View {
  @Environment(Path.self) var path
  @Environment(TodoListViewModel.self) var todoListViewModel
  @Environment(HomeViewModel.self) var homeViewModel
  
  var body: some View {
    @Bindable var todoListViewModel = todoListViewModel
  
    
    WriteBtnView(content: {
      VStack {
        if !todoListViewModel.todos.isEmpty {
          CustomNavigationBar(
            isDisplayLeftBtn: false,
            rightBtnAction: {
              todoListViewModel.navigationRightBtnTapped()
            },
            rightBtnType: todoListViewModel.navigationBarRightBtnMode
          )
        } else {
          Spacer()
            .frame(height: 30)
        }
        
        TitleView()
        
        if todoListViewModel.todos.isEmpty {
          AnnouncementView()
        } else {
          TodoListContentView()
        }
      }
    }, action: {
      path.paths.append(.todoView)
    })
    .alert("Remove \(todoListViewModel.removeTodosCount) To do list", isPresented: $todoListViewModel.isDisplayRemoveTodoAlert) {
      Button(role: .destructive) {
        todoListViewModel.removeBtnTapped()
      } label: {
        Text("Delete")
      }
      
      Button(role: .cancel) {} label: {
        Text("Cancel")
      }
    }
    .onChange(of: todoListViewModel.todos) { _, todos in
      homeViewModel.setTodosCount(todos.count)
    }
  }
  
//  var titleView: some View {
//    Text("Title")
//  }
//  
//  func titoleView() -> some View {
//    Text("title")
//  }
}

// MARK: - TitleView
private struct TitleView: View {
  @Environment(TodoListViewModel.self) private var todoListViewModel
  
  fileprivate var body: some View {
    HStack {
      if todoListViewModel.todos.isEmpty {
        Text("Add To do list")
      } else {
        Text("There are \(todoListViewModel.todos.count)\n To do list")
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
    VStack(spacing: 15) {
      Spacer()
      
      Image("pencil")
        .renderingMode(.template)
      
      Text("To go to gym at 7 a.m")
      Text("To lecture at 9 a.m")
      Text("To tutorial at 10:30 a.m")
      
      Spacer()
    }
    .font(.system(size: 16))
    .foregroundStyle(.customGray2)
  }
}

// MARK: - TodoListContentView
private struct TodoListContentView: View {
  @Environment(TodoListViewModel.self) private var todoListViewModel
  
  fileprivate var body: some View {
    VStack {
      HStack {
        Text("To do List")
          .font(.system(size: 16, weight: .bold))
          .padding(.leading, 20)
        
        Spacer()
      }
      
      ScrollView {
        VStack(spacing: 0) {
          Rectangle()
            .fill(Color.customGray0)
            .frame(height: 1)
          
          ForEach(todoListViewModel.todos, id: \.self) { todo in
            TodoCellView(todo: todo)
          }
        }
      }
    }
  }
}

// MARK: - TodoCellView
private struct TodoCellView: View {
  @Environment(TodoListViewModel.self) private var todoListViewModel
  @State private var isRemoveSelected: Bool
  private var todo: Todo
  
  fileprivate init(
    isRemoveSelected: Bool = false,
    todo: Todo
  ) {
    _isRemoveSelected = State(initialValue: isRemoveSelected)
    self.todo = todo
  }
  
  fileprivate var body: some View {
    VStack(alignment: .leading, spacing: 20) {
      HStack {
        if !todoListViewModel.isEditTodoMode {
          Button {
            todoListViewModel.selectedBoxTapped(todo)
          } label: {
            todo.selected ? Image("selectedBox") : Image("unSelectedBox")
          }
        }
        
        VStack(alignment: .leading, spacing: 5) {
          Text(todo.title)
            .font(.system(size: 16))
            .foregroundStyle(todo.selected ? .customIconGray : .customBlack)
            .strikethrough(todo.selected)
          
          Text(todo.convertedDayAndTime)
            .font(.system(size: 16))
            .foregroundStyle(.customIconGray)
        }
        
        Spacer()
        
        if todoListViewModel.isEditTodoMode {
          Button {
            isRemoveSelected.toggle()
            todoListViewModel.todoRemoveSelectedBotTapped(todo)
          } label: {
            isRemoveSelected ? Image("selectedBox") : Image("unSelectedBox")
          }
        }
      }
      .padding(.horizontal, 20)
      .padding(.top, 10)
      
      Rectangle()
        .fill(.customGray0)
        .frame(height: 1)
    }
  }
}

// MARK: - FloatingWriteBtnView
private struct WriteTodoBtnView: View {
  @Environment(Path.self) var path
  
  fileprivate var body: some View {
    VStack {
      Spacer()
      
      HStack {
        Spacer()
        
        Button {
          path.paths.append(.todoView)
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
  TodoListView()
    .environment(Path())
    .environment(TodoListViewModel())
    .environment(HomeViewModel())
}
