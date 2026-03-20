import Foundation
import AVFoundation
import Combine
import MediaPlayer

class AudioManager: ObservableObject {
    @Published var isPlaying = false
    @Published var currentTime: TimeInterval = 0
    @Published var duration: TimeInterval = 0
    @Published var isLoading = false

    private var player: AVPlayer?
    private var timeObserver: Any?
    private var cancellables = Set<AnyCancellable>()

    init() {
        setupAudioSession()
        setupRemoteCommands()
        setupSleepTimerObserver()
    }

    private func setupAudioSession() {
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .spokenAudio)
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            print("Audio session setup failed: \(error)")
        }
    }

    private func setupRemoteCommands() {
        let commandCenter = MPRemoteCommandCenter.shared()

        commandCenter.playCommand.addTarget { [weak self] _ in
            self?.play()
            return .success
        }

        commandCenter.pauseCommand.addTarget { [weak self] _ in
            self?.pause()
            return .success
        }

        commandCenter.togglePlayPauseCommand.addTarget { [weak self] _ in
            self?.togglePlayPause()
            return .success
        }
    }

    private func setupSleepTimerObserver() {
        NotificationCenter.default.publisher(for: .sleepTimerFired)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.pause()
            }
            .store(in: &cancellables)
    }

    func loadAudio(book: BibleBook, chapter: Int, version: AudioVersion) {
        // In a production app, this would load from a real API/CDN.
        // For demo purposes, we simulate loading with sample audio.
        isLoading = true
        player?.pause()
        removeTimeObserver()

        // Simulate a network load delay
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            guard let self = self else { return }
            self.isLoading = false
            self.duration = 180 // Simulated 3 min chapter
            self.currentTime = 0
            self.updateNowPlaying(book: book, chapter: chapter, version: version)
        }
    }

    func play() {
        isPlaying = true
        player?.play()
        startSimulatedPlayback()
    }

    func pause() {
        isPlaying = false
        player?.pause()
    }

    func togglePlayPause() {
        if isPlaying {
            pause()
        } else {
            play()
        }
    }

    func seek(to time: TimeInterval) {
        currentTime = min(max(time, 0), duration)
    }

    func setPlaybackSpeed(_ speed: PlaybackSpeed) {
        player?.rate = Float(speed.rawValue)
    }

    private var simulationTimer: Timer?

    private func startSimulatedPlayback() {
        simulationTimer?.invalidate()
        simulationTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] timer in
            guard let self = self else { timer.invalidate(); return }
            DispatchQueue.main.async {
                if self.isPlaying && self.currentTime < self.duration {
                    self.currentTime += 1
                } else if self.currentTime >= self.duration {
                    self.isPlaying = false
                    timer.invalidate()
                    NotificationCenter.default.post(name: .chapterPlaybackFinished, object: nil)
                }
            }
        }
    }

    private func removeTimeObserver() {
        simulationTimer?.invalidate()
        if let observer = timeObserver, let player = player {
            player.removeTimeObserver(observer)
            timeObserver = nil
        }
    }

    private func updateNowPlaying(book: BibleBook, chapter: Int, version: AudioVersion) {
        var info = [String: Any]()
        info[MPMediaItemPropertyTitle] = "\(book.name) \(chapter)"
        info[MPMediaItemPropertyArtist] = version.name
        info[MPMediaItemPropertyAlbumTitle] = "Holy Bible"
        info[MPNowPlayingInfoPropertyElapsedPlaybackTime] = currentTime
        info[MPMediaItemPropertyPlaybackDuration] = duration
        MPNowPlayingInfoCenter.default().nowPlayingInfo = info
    }

    deinit {
        removeTimeObserver()
    }
}

extension Notification.Name {
    static let chapterPlaybackFinished = Notification.Name("chapterPlaybackFinished")
}
