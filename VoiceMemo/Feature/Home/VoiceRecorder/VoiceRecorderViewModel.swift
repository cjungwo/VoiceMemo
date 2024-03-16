//
//  VoiceRecorderViewModel.swift
//  VoiceMemo
//
//  Created by JungWoo Choi on 13/3/2024.
//

import AVFoundation

@Observable class VoiceRecorderViewModel: NSObject, AVAudioPlayerDelegate {
  var isDisplayRemoveVoiceRecorderAlert: Bool
  var isDisplayAlert: Bool
  var alertMessage: String
  
  /// Record
  var audioRecorder: AVAudioRecorder?
  var isRecording: Bool
  
  /// Play
  var audioPlayer: AVAudioPlayer?
  var isPlaying: Bool
  var isPaused: Bool
  var playedTime: TimeInterval
  private var progressTimer: Timer?
  
  /// File
  var recordedFiles: [URL]
  
  ///  selected File
  var selectedRecordFile: URL?
  
  init(
    isDisplayRemoveVoiceRecorder: Bool = false,
    isDisplayErrorAlert: Bool = false,
    errorAlertMessage: String = "",
    audioRecorder: AVAudioRecorder? = nil,
    isRecording: Bool = false,
    audioPlayer: AVAudioPlayer? = nil,
    isPlaying: Bool = false,
    isPaused: Bool = false,
    playedTime: TimeInterval = 0,
    progressTimer: Timer? = nil,
    recordedFile: [URL] = [],
    selectedRecordFile: URL? = nil
  ) {
    self.isDisplayRemoveVoiceRecorderAlert = isDisplayRemoveVoiceRecorder
    self.isDisplayAlert = isDisplayErrorAlert
    self.alertMessage = errorAlertMessage
    self.audioRecorder = audioRecorder
    self.isRecording = isRecording
    self.audioPlayer = audioPlayer
    self.isPlaying = isPlaying
    self.isPaused = isPaused
    self.playedTime = playedTime
    self.progressTimer = progressTimer
    self.recordedFiles = recordedFile
    self.selectedRecordFile = selectedRecordFile
  }
}


// MARK: - View
extension VoiceRecorderViewModel {
  func voiceRecordCellTapped(_ recordedFile: URL) {
    if selectedRecordFile != recordedFile {
      stopPlaying()
      selectedRecordFile = recordedFile
    }
  }
  
  func removeBtnTapped() {
    setIsDisplayRemoveVoiceRecorderAlert(true)
  }
  
  func removeSelectedVoiceRecord() {
    guard let fileToRemove = selectedRecordFile,
          let indexToRemove = recordedFiles.firstIndex(of: fileToRemove) else {
      displayAlert(message: "Cannot found selected voice record file")
      return
    }
    
    do {
      try FileManager.default.removeItem(at: fileToRemove)
      recordedFiles.remove(at: indexToRemove)
      selectedRecordFile = nil
      stopPlaying()
      displayAlert(message: "Successfully remove selected voice record file")
    } catch {
      displayAlert(message: "ERROR: Fail to remove selected voice record file")
    }
  }
  
  private func setIsDisplayRemoveVoiceRecorderAlert(_ isDisplay: Bool) {
    isDisplayRemoveVoiceRecorderAlert = isDisplay
  }
  
  private func setErrorAlertMessage(_ message: String) {
    alertMessage = message
  }
  
  private func setIsDisplayAlert(_ isDisplay: Bool) {
    isDisplayAlert = isDisplay
  }
  
  private func displayAlert(message: String) {
    setErrorAlertMessage(message)
    setIsDisplayAlert(true)
  }
}

// MARK: - Record
extension VoiceRecorderViewModel {
  func recordBtnTapped() {
    selectedRecordFile = nil
    
    if isPlaying {
      stopPlaying()
      startRecording()
    } else if isRecording {
      stopRecording()
    } else {
      startRecording()
    }
  }
  
  private func startRecording() {
    let fileURL = getDocumentDirectory().appendingPathComponent("New Record \(recordedFiles.count + 1)")
    let settings = [
      AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
      AVSampleRateKey: 12000,
      AVNumberOfChannelsKey: 1,
      AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
    ]
    
    do {
      audioRecorder = try AVAudioRecorder(url: fileURL, settings: settings)
      audioRecorder?.record()
      self.isRecording = true
    } catch {
      displayAlert(message: "ERROR: Fail to record voice record")
    }
  }
  
  private func stopRecording() {
    audioRecorder?.stop()
    self.recordedFiles.append(self.audioRecorder!.url)
    self.isRecording = false
  }
  
  private func getDocumentDirectory() -> URL {
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    return paths[0]
  }
}


// MARK: - Play
extension VoiceRecorderViewModel {
  func startPlaying(recordingURL: URL) {
    do {
      audioPlayer = try AVAudioPlayer(contentsOf: recordingURL)
      audioPlayer?.delegate = self
      audioPlayer?.play()
      self.isPlaying = true
      self.isPaused = false
      self.progressTimer = Timer.scheduledTimer(
        withTimeInterval: 0.1,
        repeats: true
      ) { _ in
        self.updateCurrentTime()
      }
    } catch {
      displayAlert(message: "ERROR: Fail")
    }
  }
  
  private func updateCurrentTime() {
    self.playedTime = audioPlayer?.currentTime ?? 0
  }
  
  private func stopPlaying() {
    audioPlayer?.stop()
    playedTime = 0
    self.progressTimer?.invalidate()
    self.isPlaying = false
    self.isPaused = false
  }
  
  func pausePlaying() {
    audioPlayer?.pause()
    self.isPaused = true
  }
  
  func resumePlaying() {
    audioPlayer?.play()
    self.isPaused = false
  }
  
  func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
    self.isPlaying = false
    self.isPaused = false
  }
  
  func getFileInfo(for url: URL) -> (Date?, TimeInterval?) {
    let fileManager = FileManager.default
    var creationDate: Date?
    var duration: TimeInterval?
    
    do {
//      let fileAttributes = try fileManager.attributesOfItem(atPath: url.path)
      let fileAttributes = try fileManager.attributesOfItem(atPath: url.path)
      creationDate = fileAttributes[.creationDate] as? Date
    } catch {
      displayAlert(message: "ERROR: Cannot load information of selected voice record file")
    }
    
    do {
      let audioPlayer = try AVAudioPlayer(contentsOf: url)
      duration = audioPlayer.duration
    } catch {
      displayAlert(message: "ERROR: Cannot load play time of selected voice record file")
    }
    
    return (creationDate, duration)
  }
}
