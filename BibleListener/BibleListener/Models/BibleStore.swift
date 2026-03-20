import Foundation
import Combine

class BibleStore: ObservableObject {
    @Published var currentBook: BibleBook
    @Published var currentChapter: Int
    @Published var selectedAudioVersion: AudioVersion
    @Published var playbackSpeed: PlaybackSpeed = .x1
    @Published var sleepTimer: SleepTimer = .none
    @Published var repeatMode: RepeatMode = .none

    @Published var sleepTimerRemaining: TimeInterval?
    private var sleepTimerTask: Timer?

    let books = BibleData.books
    let audioVersions = BibleData.audioVersions

    init() {
        self.currentBook = BibleData.books.first(where: { $0.id == "gen" })!
        self.currentChapter = 1
        self.selectedAudioVersion = BibleData.audioVersions.first(where: { $0.id == "niv_drama" })!
    }

    func navigateTo(book: BibleBook, chapter: Int) {
        currentBook = book
        currentChapter = min(chapter, book.chapters)
    }

    func nextChapter() -> Bool {
        if let (book, chapter) = BibleData.nextChapter(after: currentBook, chapter: currentChapter) {
            navigateTo(book: book, chapter: chapter)
            return true
        }
        return false
    }

    func previousChapter() -> Bool {
        if let (book, chapter) = BibleData.previousChapter(before: currentBook, chapter: currentChapter) {
            navigateTo(book: book, chapter: chapter)
            return true
        }
        return false
    }

    func startSleepTimer(_ timer: SleepTimer) {
        sleepTimerTask?.invalidate()
        sleepTimer = timer

        guard let seconds = timer.seconds else {
            sleepTimerRemaining = nil
            return
        }

        sleepTimerRemaining = seconds
        sleepTimerTask = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] t in
            guard let self = self else { t.invalidate(); return }
            DispatchQueue.main.async {
                if let remaining = self.sleepTimerRemaining, remaining > 0 {
                    self.sleepTimerRemaining = remaining - 1
                } else {
                    self.sleepTimerRemaining = nil
                    self.sleepTimer = .none
                    t.invalidate()
                    NotificationCenter.default.post(name: .sleepTimerFired, object: nil)
                }
            }
        }
    }

    var passageLabel: String {
        "\(currentBook.abbreviation) \(currentChapter)"
    }
}

extension Notification.Name {
    static let sleepTimerFired = Notification.Name("sleepTimerFired")
}
