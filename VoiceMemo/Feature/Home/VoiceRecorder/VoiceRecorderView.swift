//
//  VoiceRecorderView.swift
//  VoiceMemo
//
//  Created by JungWoo Choi on 13/3/2024.
//

import SwiftUI

struct VoiceRecorderView: View {
  @Bindable private var voiceRecorderViewModel = VoiceRecorderViewModel()
  @Environment(HomeViewModel.self) private var homeViewModel
  
  var body: some View {
    ZStack {
      VStack {
        TitleView()
        
        if voiceRecorderViewModel.recordedFiles.isEmpty {
          AnnouncementView()
        } else {
          VoiceRecorderListView(voiceRecorderViewModel: voiceRecorderViewModel)
            .padding(.top, 15)
        }
        
        Spacer()
      }
      
      RecordBtnView(voiceRecorderViewModel: voiceRecorderViewModel)
        .padding(.trailing, 20)
        .padding(.bottom, 50)
    }
    .alert(
      "Delete selected voice record?",
      isPresented: $voiceRecorderViewModel.isDisplayRemoveVoiceRecorderAlert
    ) {
      Button(role: .destructive) {
        voiceRecorderViewModel.removeSelectedVoiceRecord()
      } label: {
        Text("Delete")
      }
      Button(role: .cancel) {
        //
      } label: {
        Text("Cancel")
      }
    }
    .alert(
      voiceRecorderViewModel.alertMessage,
      isPresented: $voiceRecorderViewModel.isDisplayAlert
    ) {
      Button(role: .cancel) {
        //
      } label: {
        Text("Check")
      }
    }
    .onChange(of: voiceRecorderViewModel.recordedFiles) { _, recordedFiles in
      homeViewModel.setTodosCount(recordedFiles.count)
    }
  }
}

// MARK: - TitleView
private struct TitleView: View {
  fileprivate var body: some View {
    HStack {
      Text("Voice Recorder")
        .font(.system(size: 30, weight: .bold))
        .foregroundStyle(.customBlack)
      
      Spacer()
    }
    .padding(.horizontal, 30)
    .padding(.top, 30)
  }
}

// MARK: - AnnouncementView
private struct AnnouncementView: View {
  fileprivate var body: some View {
    VStack(spacing: 15) {
      Divider()
        .foregroundStyle(.customIconGray)
      
      Spacer()
        .frame(height: 150)
      
      Image("pencil")
        .renderingMode(.template)
      
      Text("There is any voice record")
      
      Spacer()
    }
    .font(.system(size: 16))
    .foregroundStyle(.customGray2)
  }
}

// MARK: - VoiceRecorderListView
private struct VoiceRecorderListView: View {
  private var voiceRecorderViewModel: VoiceRecorderViewModel
  
  fileprivate init(voiceRecorderViewModel: VoiceRecorderViewModel) {
    self.voiceRecorderViewModel = voiceRecorderViewModel
  }
  
  fileprivate var body: some View {
    ScrollView {
      VStack {
        Rectangle()
          .fill(.customCoolGray)
          .frame(height: 1)
        
        ForEach(voiceRecorderViewModel.recordedFiles, id: \.self) { recordedFile in
            VoiceRecorderCellView(
              voiceRecorderViewModel: voiceRecorderViewModel,
              recordedFile: recordedFile
            )
        }
      }
    }
  }
}

// MARK: - VoiceRecorderCellView
private struct VoiceRecorderCellView: View {
  private var voiceRecorderViewModel: VoiceRecorderViewModel
  private var recordedFile: URL
  private var creationDate: Date?
  private var duration: TimeInterval?
  private var progressBarValue: Float {
    if voiceRecorderViewModel.selectedRecordFile == recordedFile
        && (voiceRecorderViewModel.isPlaying || voiceRecorderViewModel.isPaused) {
      return Float(voiceRecorderViewModel.playedTime) / Float(duration ?? 1)
    } else {
      return 0
    }
  }
  
  fileprivate init(
    voiceRecorderViewModel: VoiceRecorderViewModel,
    recordedFile: URL
  ) {
    self.voiceRecorderViewModel = voiceRecorderViewModel
    self.recordedFile = recordedFile
    (self.creationDate, self.duration) = voiceRecorderViewModel.getFileInfo(for: recordedFile)
  }
  
  fileprivate var body: some View {
    VStack {
      Button {
        voiceRecorderViewModel.voiceRecordCellTapped(recordedFile)
      } label: {
        VStack {
          HStack {
            Text(recordedFile.lastPathComponent)
              .font(.system(size: 15, weight: .bold))
              .foregroundStyle(.customBlack)
            
            Spacer()
          }
          
          Spacer()
            .frame(height: 5)
          
          HStack {
            if let creationDate = creationDate {
              Text(creationDate.formattedVoiceRecorderTime)
                .font(.system(size: 14))
                .foregroundStyle(.customIconGray)
            }
            
            Spacer()
            
            if voiceRecorderViewModel.selectedRecordFile != recordedFile,
               let duration = duration {
              Text(duration.formattedTimeInterval)
                .font(.system(size: 14))
                .foregroundStyle(.customIconGray)
            }
          }
        }
      }
      .padding(.horizontal, 20)
      
      if voiceRecorderViewModel.selectedRecordFile == recordedFile {
        VStack {
          ProgressBar(progress: progressBarValue)
            .frame(height: 2)
          
          Spacer()
            .frame(height: 5)
          
          HStack {
            Text(voiceRecorderViewModel.playedTime.formattedTimeInterval)
              .font(.system(size: 10, weight: .medium))
              .foregroundStyle(.customIconGray)
            
            Spacer()
            
            if let duration = duration {
              Text(duration.formattedTimeInterval)
                .font(.system(size: 10, weight: .medium))
                .foregroundStyle(.customIconGray)
            }
          }
          
          Spacer()
            .frame(height: 10)
          
          HStack {
            Spacer()
            
            Button {
              if voiceRecorderViewModel.isPaused {
                voiceRecorderViewModel.resumePlaying()
              } else {
                voiceRecorderViewModel.startPlaying(recordingURL: recordedFile)
              }
            } label: {
              Image("play")
                .renderingMode(.template)
                .foregroundStyle(.customBlack)
            }
            
            Spacer()
              .frame(width: 10)
            
            Button {
              if voiceRecorderViewModel.isPlaying {
                voiceRecorderViewModel.pausePlaying()
              }
            } label: {
              Image("pause")
                .renderingMode(.template)
                .foregroundStyle(.customBlack)
            }
            
            Spacer()
            
            Button {
              voiceRecorderViewModel.removeBtnTapped()
            } label: {
              Image("trash")
                .renderingMode(.template)
                .resizable()
                .frame(width: 30, height: 30)
                .foregroundStyle(.customBlack)
            }
          }
        }
        .padding(.horizontal, 20)
      }
      Rectangle()
        .fill(.customGray2)
        .frame(height: 1)
    }
  }
}

// MARK: - ProgressBar
private struct ProgressBar: View {
  private var progress: Float
  
  fileprivate init(progress: Float) {
    self.progress = progress
  }
  
  fileprivate var body: some View {
    GeometryReader { geometry in
      ZStack(alignment: .leading) {
        Rectangle()
          .fill(.customGray2)
        
        Rectangle()
          .fill(.customGreen)
          .frame(width: CGFloat(self.progress) * geometry.size.width)
      }
    }
  }
}

// MARK: - RecordBtnView
private struct RecordBtnView: View {
  private var voiceRecorderViewModel: VoiceRecorderViewModel
  
  fileprivate init(voiceRecorderViewModel: VoiceRecorderViewModel) {
    self.voiceRecorderViewModel = voiceRecorderViewModel
  }
  
  fileprivate var body: some View {
    VStack {
      Spacer()
      
      HStack {
        Spacer()
        
        Button {
          voiceRecorderViewModel.recordBtnTapped()
        } label: {
          if voiceRecorderViewModel.isRecording {
            Image("mic_recording")
          } else {
            Image("mic")
          }
        }

      }
    }
  }
}

#Preview {
  VoiceRecorderView()
    .environment(HomeViewModel())
}
