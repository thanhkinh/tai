import SwiftUI

struct PlayerView: View {
    @EnvironmentObject var audioManager: AudioManager
    @EnvironmentObject var bibleStore: BibleStore

    @State private var showPassagePicker = false
    @State private var showAudioVersionPicker = false
    @State private var showSpeedPicker = false
    @State private var showTimerPicker = false

    var body: some View {
        VStack(spacing: 0) {
            // Top navigation bar
            topBar

            // Upgrade banner
            upgradeBanner

            // Scripture text display
            scriptureText

            Spacer()

            // Bottom controls
            bottomControls
        }
        .background(Color(.systemGray6))
        .onAppear {
            audioManager.loadAudio(
                book: bibleStore.currentBook,
                chapter: bibleStore.currentChapter,
                version: bibleStore.selectedAudioVersion
            )
        }
        .onReceive(NotificationCenter.default.publisher(for: .chapterPlaybackFinished)) { _ in
            handleChapterFinished()
        }
        .sheet(isPresented: $showPassagePicker) {
            PassagePickerView()
        }
        .sheet(isPresented: $showAudioVersionPicker) {
            AudioVersionPickerView()
        }
        .confirmationDialog("Playback Speed:", isPresented: $showSpeedPicker) {
            ForEach(PlaybackSpeed.allCases, id: \.self) { speed in
                Button(speed.label) {
                    bibleStore.playbackSpeed = speed
                    audioManager.setPlaybackSpeed(speed)
                }
            }
            Button("Cancel", role: .cancel) {}
        }
        .confirmationDialog("Timer:", isPresented: $showTimerPicker) {
            ForEach(SleepTimer.allCases, id: \.self) { timer in
                Button(timer.label) {
                    bibleStore.startSleepTimer(timer)
                }
            }
            Button("Cancel", role: .cancel) {}
        }
    }

    // MARK: - Top Bar

    private var topBar: some View {
        HStack {
            Button {
                showPassagePicker = true
            } label: {
                HStack(spacing: 4) {
                    Image(systemName: "chevron.down")
                        .font(.caption)
                    Text(bibleStore.passageLabel)
                        .font(.subheadline)
                        .fontWeight(.medium)
                }
            }

            Spacer()

            Button {
                showAudioVersionPicker = true
            } label: {
                HStack(spacing: 4) {
                    Image(systemName: "chevron.down")
                        .font(.caption)
                    Text(bibleStore.selectedAudioVersion.name)
                        .font(.subheadline)
                        .fontWeight(.medium)
                }
            }
        }
        .foregroundColor(.white)
        .padding(.horizontal, 16)
        .padding(.vertical, 10)
        .background(Color(red: 0.45, green: 0.15, blue: 0.15))
    }

    // MARK: - Upgrade Banner

    private var upgradeBanner: some View {
        Text("Upgrade for $1.99 to listen offline")
            .font(.subheadline)
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 8)
            .background(Color(red: 0.8, green: 0.65, blue: 0.2))
    }

    // MARK: - Scripture Text

    private var scriptureText: some View {
        ScrollView {
            Text(sampleVerseText)
                .font(.title)
                .fontWeight(.medium)
                .foregroundColor(.primary)
                .padding(24)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
    }

    // MARK: - Bottom Controls

    private var bottomControls: some View {
        VStack(spacing: 12) {
            // Speed, Repeat, Timer row
            HStack {
                Button {
                    showSpeedPicker = true
                } label: {
                    Text(bibleStore.playbackSpeed.label)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }

                Spacer()

                Button {
                    cycleRepeatMode()
                } label: {
                    Text(bibleStore.repeatMode.rawValue)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }

                Spacer()

                Button {
                    showTimerPicker = true
                } label: {
                    if let remaining = bibleStore.sleepTimerRemaining {
                        Text(formatTime(remaining))
                            .font(.subheadline)
                            .foregroundColor(.blue)
                    } else {
                        Text("Timer")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                }
            }
            .padding(.horizontal, 24)

            // Play/Pause button
            HStack(spacing: 40) {
                Button {
                    goToPreviousChapter()
                } label: {
                    Image(systemName: "backward.fill")
                        .font(.title2)
                        .foregroundColor(.secondary)
                }

                Button {
                    audioManager.togglePlayPause()
                } label: {
                    Image(systemName: audioManager.isPlaying ? "pause.circle.fill" : "play.circle.fill")
                        .font(.system(size: 64))
                        .foregroundColor(.gray)
                }

                Button {
                    goToNextChapter()
                } label: {
                    Image(systemName: "forward.fill")
                        .font(.title2)
                        .foregroundColor(.secondary)
                }
            }

            // Progress bar
            if audioManager.duration > 0 {
                ProgressView(value: audioManager.currentTime, total: audioManager.duration)
                    .padding(.horizontal, 24)
                    .tint(.gray)
            }

            // Copyright and Log In row
            HStack {
                Image(systemName: "c.circle")
                    .font(.caption)
                    .foregroundColor(.secondary)

                Spacer()

                Button("Log In") {
                    // Log in action
                }
                .font(.subheadline)
                .foregroundColor(.secondary)
            }
            .padding(.horizontal, 24)
            .padding(.bottom, 8)
        }
        .padding(.top, 8)
        .background(Color(.systemBackground))
    }

    // MARK: - Helpers

    private func handleChapterFinished() {
        switch bibleStore.repeatMode {
        case .chapter:
            audioManager.seek(to: 0)
            audioManager.loadAudio(
                book: bibleStore.currentBook,
                chapter: bibleStore.currentChapter,
                version: bibleStore.selectedAudioVersion
            )
            audioManager.play()
        case .book:
            if bibleStore.currentChapter < bibleStore.currentBook.chapters {
                _ = bibleStore.nextChapter()
                audioManager.loadAudio(
                    book: bibleStore.currentBook,
                    chapter: bibleStore.currentChapter,
                    version: bibleStore.selectedAudioVersion
                )
                audioManager.play()
            } else {
                bibleStore.navigateTo(book: bibleStore.currentBook, chapter: 1)
                audioManager.loadAudio(
                    book: bibleStore.currentBook,
                    chapter: 1,
                    version: bibleStore.selectedAudioVersion
                )
                audioManager.play()
            }
        case .none:
            if bibleStore.nextChapter() {
                audioManager.loadAudio(
                    book: bibleStore.currentBook,
                    chapter: bibleStore.currentChapter,
                    version: bibleStore.selectedAudioVersion
                )
                audioManager.play()
            }
        }
    }

    private func goToNextChapter() {
        if bibleStore.nextChapter() {
            audioManager.loadAudio(
                book: bibleStore.currentBook,
                chapter: bibleStore.currentChapter,
                version: bibleStore.selectedAudioVersion
            )
            audioManager.play()
        }
    }

    private func goToPreviousChapter() {
        if bibleStore.previousChapter() {
            audioManager.loadAudio(
                book: bibleStore.currentBook,
                chapter: bibleStore.currentChapter,
                version: bibleStore.selectedAudioVersion
            )
            audioManager.play()
        }
    }

    private func cycleRepeatMode() {
        let modes = RepeatMode.allCases
        if let idx = modes.firstIndex(of: bibleStore.repeatMode) {
            let next = (idx + 1) % modes.count
            bibleStore.repeatMode = modes[next]
        }
    }

    private func formatTime(_ seconds: TimeInterval) -> String {
        let mins = Int(seconds) / 60
        let secs = Int(seconds) % 60
        return String(format: "%d:%02d", mins, secs)
    }

    private var sampleVerseText: String {
        // Sample verse texts for demo
        let samples: [String: [Int: String]] = [
            "zec": [
                1: "Then the angel who talked with me returned and woke me up, like someone awakened from sleep.",
                2: "He asked me, \"What do you see?\"\n\nI answered, \"I see a solid gold lampstand with a bowl at the top and seven lamps on it, with seven channels to the lamps.",
                4: "Then the angel who talked with me returned and woke me up, like someone awakened from sleep."
            ],
            "gen": [
                1: "In the beginning God created the heavens and the earth. Now the earth was formless and empty, darkness was over the surface of the deep, and the Spirit of God was hovering over the waters.\n\nAnd God said, \"Let there be light,\" and there was light. God saw that the light was good, and he separated the light from the darkness."
            ]
        ]

        return samples[bibleStore.currentBook.id]?[bibleStore.currentChapter]
            ?? "Chapter \(bibleStore.currentChapter) of \(bibleStore.currentBook.name)\n\nAudio will play the full chapter text from the selected Bible version. Tap play to begin listening."
    }
}

#Preview {
    PlayerView()
        .environmentObject(AudioManager())
        .environmentObject(BibleStore())
}
