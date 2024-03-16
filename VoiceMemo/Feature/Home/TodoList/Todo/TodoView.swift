//
//  TodoView.swift
//  VoiceMemo
//
//  Created by JungWoo Choi on 12/3/2024.
//

import SwiftUI

struct TodoView: View {
  @Environment(Path.self) var path
  @Environment(TodoListViewModel.self) var todoListViewModel
  @State private var todoViewModel = TodoViewModel()
  
  var body: some View {
    VStack {
      CustomNavigationBar(
        leftBtnAction: {
          path.paths.removeLast()
        },
        rightBtnAction: {
          todoListViewModel.addTodo(
            .init(title: todoViewModel.title,
                  time: todoViewModel.time,
                  day: todoViewModel.day,
                  selected: false
                 )
          )
          path.paths.removeLast()
        },
        rightBtnType: .create
      )
      
      TitleView()
        .padding(.top, 20)
      
      Spacer()
        .frame(height: 20)
      
      TodoTitleView(todoViewModel: todoViewModel)
        .padding(.leading, 20)
      
      SelectTimeView(todoViewModel: todoViewModel)
      
      SelectDayView(todoViewModel: todoViewModel)
        .padding(.leading, 20)
      
    }
  }
}

// MARK: - TitleView
private struct TitleView: View {
  fileprivate var body: some View {
    HStack {
      Text("Add to do List.")
      
      Spacer()
    }
    .font(.system(size: 30, weight: .bold))
    .padding(.leading, 20)
  }
}

// MARK: - TodoTitleView
private struct TodoTitleView: View {
  @Bindable private var todoViewModel: TodoViewModel
  
  fileprivate init(todoViewModel: TodoViewModel) {
    self.todoViewModel = todoViewModel
  }
  
  fileprivate var body: some View {
    TextField("Write Title", text: $todoViewModel.title)
  }
}

// MARK: - SelectTimeView
private struct SelectTimeView: View {
  @Bindable private var todoViewModel: TodoViewModel
  
  fileprivate init(todoViewModel: TodoViewModel) {
    self.todoViewModel = todoViewModel
  }
  
  fileprivate var body: some View {
    VStack {
      Rectangle()
        .fill(.customGray0)
        .frame(height: 1)
      
      DatePicker(
        "",
        selection: $todoViewModel.time,
        displayedComponents: [.hourAndMinute]
      )
      .labelsHidden()
      .datePickerStyle(WheelDatePickerStyle())
      .frame(maxWidth: .infinity, alignment: .center)
      
      Rectangle()
        .fill(.customGray0)
        .frame(height: 1)
    }
  }
}

// MARK: - SelectDayView
private struct SelectDayView: View {
  @Bindable private var todoViewModel: TodoViewModel
  
  fileprivate init(todoViewModel: TodoViewModel) {
    self.todoViewModel = todoViewModel
  }
  
  fileprivate var body: some View {
    VStack(spacing: 5) {
      HStack {
        Text("Date")
          .foregroundStyle(.customIconGray)
        
        Spacer()
      }
      
      HStack {
        Button {
          todoViewModel.setIsDisplayCalender(true)
        } label: {
          Text("\(todoViewModel.day.formattedDay)")
            .font(.system(size: 18, weight: .medium))
            .foregroundStyle(.customGreen)
        }
        .popover(isPresented: $todoViewModel.isDisplayCalender) {
          DatePicker(
            "",
            selection: $todoViewModel.day,
            displayedComponents: .date
          )
          .labelsHidden()
          .datePickerStyle(GraphicalDatePickerStyle())
          .frame(maxWidth: .infinity, alignment: .center)
          .padding()
          .onChange(of: todoViewModel.day) {
            todoViewModel.setIsDisplayCalender(false)
          }
        }
      }
      
      Spacer()
    }
  }
}

#Preview {
  TodoView()
    .environment(Path())
    .environment(TodoListViewModel())
}
