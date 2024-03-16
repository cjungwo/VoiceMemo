//
//  TimerView.swift
//  VoiceMemo
//
//  Created by JungWoo Choi on 14/3/2024.
//

import SwiftUI

struct TimerView: View {
  @State var timerViewModel = TimerViewModel()
  
    var body: some View {
      if timerViewModel.isDisplaySetTimeView {
        SetTimerView(timerViewModel: timerViewModel)
      } else {
        TimerOperationView(timerViewModel: timerViewModel)
      }
    }
}

// MARK: - SetTimerView
private struct SetTimerView: View {
  private var timerViewModel: TimerViewModel
  
  fileprivate init(timerViewModel: TimerViewModel) {
    self.timerViewModel = timerViewModel
  }
  
  fileprivate var body: some View {
    VStack {
      TitleView()
      
      Spacer()
        .frame(maxHeight: 150)
      
      timePickerView(timerViewModel: timerViewModel)
      
      Spacer()
        .frame(height: 30)
      
      TimerCreateBtnView(timerViewModel: timerViewModel)
      
      Spacer()
    }
  }
}

// MARK: - TitleView
private struct TitleView: View {
  fileprivate var body: some View {
    HStack {
      Text("Timer")
        .font(.system(size: 30, weight: .bold))
        .foregroundStyle(.customBlack)
      
      Spacer()
    }
    .padding(.horizontal, 30)
    .padding(.top, 30)
  }
}

// MARK: - TimePickerView
private struct timePickerView: View {
  @Bindable private var timerViewModel: TimerViewModel
  
  fileprivate init(timerViewModel: TimerViewModel) {
    self.timerViewModel = timerViewModel
  }
  
  fileprivate var body: some View {
    VStack {
      Rectangle()
        .fill(.customGray2)
        .frame(height: 1)
      
      HStack {
        Picker("Hour", selection: $timerViewModel.time.hours) {
          ForEach(0..<24) { hour in
            Text("\(hour)")
          }
        }
        
        Picker("Minute", selection: $timerViewModel.time.minutes) {
          ForEach(0..<60) { minute in
            Text("\(minute)")
          }
        }
        
        Picker("Second", selection: $timerViewModel.time.seconds) {
          ForEach(0..<60) { second in
            Text("\(second)")
          }
        }
      }
      .labelsHidden()
      .pickerStyle(.wheel)
      
      Rectangle()
        .fill(.customGray2)
        .frame(height: 1)
    }
  }
}

// MARK: - TimerCreateBtnView
private struct TimerCreateBtnView: View {
  private var timerViewModel: TimerViewModel
  
  fileprivate init(timerViewModel: TimerViewModel) {
    self.timerViewModel = timerViewModel
  }
  
  fileprivate var body: some View {
    Button {
      timerViewModel.settingBtnTapped()
    } label: {
      Text("Setting")
        .font(.system(size: 18, weight: .bold))
        .foregroundStyle(.customGreen)
    }
  }
}

// MARK: - TimerOperationView
private struct TimerOperationView: View {
  private var timerViewModel: TimerViewModel
  
  fileprivate init(timerViewModel: TimerViewModel) {
    self.timerViewModel = timerViewModel
  }
  
  fileprivate var body: some View {
    VStack {
      
      Spacer()
      
      ZStack {
        VStack {
          Text("\(timerViewModel.timeRemaining.formattedTimeString)")
            .font(.system(size: 28))
            .foregroundStyle(.customBlack)
            .monospaced()
          
          HStack(alignment: .bottom) {
            Image(systemName: "bell.fill")
            
            Text("\(timerViewModel.time.convertedSeconds.formattedSettingTime)")
              .font(.system(size: 16))
              .foregroundStyle(.customBlack)
              .padding(.top, 10)
          }
        }
        
        Circle()
          .stroke(.customOrange, lineWidth: 6)
          .frame(width: 350, height: 350)
      }

      Spacer()
        .frame(height: 20)
      
      HStack {
        Button {
          timerViewModel.cancelBtnTapped()
        } label: {
          Text("Cancel")
            .font(.system(size: 14))
            .foregroundStyle(.customBlack)
            .padding(.vertical, 25)
            .padding(.horizontal, 7)
            .background(
              Circle()
                .fill(.customGray2.opacity(0.3))
            )
        }
        
        Spacer()
        
        Button {
          timerViewModel.pauseOrRestartBtnTapped()
        } label: {
          Text(timerViewModel.isPaused ? "Restart" : "Pause")
            .font(.system(size: 14))
            .foregroundStyle(.customBlack)
            .padding(.vertical, 25)
            .padding(.horizontal, 7)
            .background(
              Circle()
                .fill(Color(red: 1, green: 0.75, blue: 0.52).opacity(0.3))
            )
        }
      }
      .padding(.horizontal, 20)
      
      Spacer()
    }
  }
}

#Preview {
    TimerView()
}
