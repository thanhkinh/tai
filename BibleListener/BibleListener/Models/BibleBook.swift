import Foundation

struct BibleBook: Identifiable, Hashable {
    let id: String
    let name: String
    let abbreviation: String
    let chapters: Int
    let testament: Testament

    enum Testament: String, CaseIterable {
        case old = "Old Testament"
        case new = "New Testament"
    }
}

struct BibleChapter: Identifiable, Hashable {
    var id: String { "\(book.id)_\(number)" }
    let book: BibleBook
    let number: Int
}

struct AudioVersion: Identifiable, Hashable {
    let id: String
    let name: String
    let isPremium: Bool
}

enum PlaybackSpeed: Double, CaseIterable {
    case x075 = 0.75
    case x1 = 1.0
    case x125 = 1.25
    case x15 = 1.5
    case x175 = 1.75
    case x2 = 2.0

    var label: String {
        switch self {
        case .x075: return ".75x"
        case .x1: return "1x"
        case .x125: return "1.25x"
        case .x15: return "1.5x"
        case .x175: return "1.75x"
        case .x2: return "2x"
        }
    }
}

enum SleepTimer: CaseIterable {
    case none
    case minutes5
    case minutes10
    case minutes15
    case minutes30
    case hour1
    case hours2

    var label: String {
        switch self {
        case .none: return "None"
        case .minutes5: return "5 minutes"
        case .minutes10: return "10 minutes"
        case .minutes15: return "15 minutes"
        case .minutes30: return "30 minutes"
        case .hour1: return "1 hour"
        case .hours2: return "2 hours"
        }
    }

    var seconds: TimeInterval? {
        switch self {
        case .none: return nil
        case .minutes5: return 300
        case .minutes10: return 600
        case .minutes15: return 900
        case .minutes30: return 1800
        case .hour1: return 3600
        case .hours2: return 7200
        }
    }
}

enum RepeatMode: String, CaseIterable {
    case none = "No Repeat"
    case chapter = "Repeat Chapter"
    case book = "Repeat Book"
}
