import Foundation

struct BibleData {
    static let books: [BibleBook] = [
        // Old Testament
        BibleBook(id: "gen", name: "Genesis", abbreviation: "Gen", chapters: 50, testament: .old),
        BibleBook(id: "exo", name: "Exodus", abbreviation: "Exo", chapters: 40, testament: .old),
        BibleBook(id: "lev", name: "Leviticus", abbreviation: "Lev", chapters: 27, testament: .old),
        BibleBook(id: "num", name: "Numbers", abbreviation: "Num", chapters: 36, testament: .old),
        BibleBook(id: "deu", name: "Deuteronomy", abbreviation: "Deu", chapters: 34, testament: .old),
        BibleBook(id: "jos", name: "Joshua", abbreviation: "Jos", chapters: 24, testament: .old),
        BibleBook(id: "jdg", name: "Judges", abbreviation: "Jdg", chapters: 21, testament: .old),
        BibleBook(id: "rut", name: "Ruth", abbreviation: "Rut", chapters: 4, testament: .old),
        BibleBook(id: "1sa", name: "1 Samuel", abbreviation: "1Sa", chapters: 31, testament: .old),
        BibleBook(id: "2sa", name: "2 Samuel", abbreviation: "2Sa", chapters: 24, testament: .old),
        BibleBook(id: "1ki", name: "1 Kings", abbreviation: "1Ki", chapters: 22, testament: .old),
        BibleBook(id: "2ki", name: "2 Kings", abbreviation: "2Ki", chapters: 25, testament: .old),
        BibleBook(id: "1ch", name: "1 Chronicles", abbreviation: "1Ch", chapters: 29, testament: .old),
        BibleBook(id: "2ch", name: "2 Chronicles", abbreviation: "2Ch", chapters: 36, testament: .old),
        BibleBook(id: "ezr", name: "Ezra", abbreviation: "Ezr", chapters: 10, testament: .old),
        BibleBook(id: "neh", name: "Nehemiah", abbreviation: "Neh", chapters: 13, testament: .old),
        BibleBook(id: "est", name: "Esther", abbreviation: "Est", chapters: 10, testament: .old),
        BibleBook(id: "job", name: "Job", abbreviation: "Job", chapters: 42, testament: .old),
        BibleBook(id: "psa", name: "Psalms", abbreviation: "Psa", chapters: 150, testament: .old),
        BibleBook(id: "pro", name: "Proverbs", abbreviation: "Pro", chapters: 31, testament: .old),
        BibleBook(id: "ecc", name: "Ecclesiastes", abbreviation: "Ecc", chapters: 12, testament: .old),
        BibleBook(id: "sng", name: "Song of Solomon", abbreviation: "Sng", chapters: 8, testament: .old),
        BibleBook(id: "isa", name: "Isaiah", abbreviation: "Isa", chapters: 66, testament: .old),
        BibleBook(id: "jer", name: "Jeremiah", abbreviation: "Jer", chapters: 52, testament: .old),
        BibleBook(id: "lam", name: "Lamentations", abbreviation: "Lam", chapters: 5, testament: .old),
        BibleBook(id: "ezk", name: "Ezekiel", abbreviation: "Ezk", chapters: 48, testament: .old),
        BibleBook(id: "dan", name: "Daniel", abbreviation: "Dan", chapters: 12, testament: .old),
        BibleBook(id: "hos", name: "Hosea", abbreviation: "Hos", chapters: 14, testament: .old),
        BibleBook(id: "jol", name: "Joel", abbreviation: "Jol", chapters: 3, testament: .old),
        BibleBook(id: "amo", name: "Amos", abbreviation: "Amo", chapters: 9, testament: .old),
        BibleBook(id: "oba", name: "Obadiah", abbreviation: "Oba", chapters: 1, testament: .old),
        BibleBook(id: "jon", name: "Jonah", abbreviation: "Jon", chapters: 4, testament: .old),
        BibleBook(id: "mic", name: "Micah", abbreviation: "Mic", chapters: 7, testament: .old),
        BibleBook(id: "nam", name: "Nahum", abbreviation: "Nam", chapters: 3, testament: .old),
        BibleBook(id: "hab", name: "Habakkuk", abbreviation: "Hab", chapters: 3, testament: .old),
        BibleBook(id: "zep", name: "Zephaniah", abbreviation: "Zep", chapters: 3, testament: .old),
        BibleBook(id: "hag", name: "Haggai", abbreviation: "Hag", chapters: 2, testament: .old),
        BibleBook(id: "zec", name: "Zechariah", abbreviation: "Zch", chapters: 14, testament: .old),
        BibleBook(id: "mal", name: "Malachi", abbreviation: "Mal", chapters: 4, testament: .old),
        // New Testament
        BibleBook(id: "mat", name: "Matthew", abbreviation: "Mat", chapters: 28, testament: .new),
        BibleBook(id: "mrk", name: "Mark", abbreviation: "Mrk", chapters: 16, testament: .new),
        BibleBook(id: "luk", name: "Luke", abbreviation: "Luk", chapters: 24, testament: .new),
        BibleBook(id: "jhn", name: "John", abbreviation: "Jhn", chapters: 21, testament: .new),
        BibleBook(id: "act", name: "Acts", abbreviation: "Act", chapters: 28, testament: .new),
        BibleBook(id: "rom", name: "Romans", abbreviation: "Rom", chapters: 16, testament: .new),
        BibleBook(id: "1co", name: "1 Corinthians", abbreviation: "1Co", chapters: 16, testament: .new),
        BibleBook(id: "2co", name: "2 Corinthians", abbreviation: "2Co", chapters: 13, testament: .new),
        BibleBook(id: "gal", name: "Galatians", abbreviation: "Gal", chapters: 6, testament: .new),
        BibleBook(id: "eph", name: "Ephesians", abbreviation: "Eph", chapters: 6, testament: .new),
        BibleBook(id: "php", name: "Philippians", abbreviation: "Php", chapters: 4, testament: .new),
        BibleBook(id: "col", name: "Colossians", abbreviation: "Col", chapters: 4, testament: .new),
        BibleBook(id: "1th", name: "1 Thessalonians", abbreviation: "1Th", chapters: 5, testament: .new),
        BibleBook(id: "2th", name: "2 Thessalonians", abbreviation: "2Th", chapters: 3, testament: .new),
        BibleBook(id: "1ti", name: "1 Timothy", abbreviation: "1Ti", chapters: 6, testament: .new),
        BibleBook(id: "2ti", name: "2 Timothy", abbreviation: "2Ti", chapters: 4, testament: .new),
        BibleBook(id: "tit", name: "Titus", abbreviation: "Tit", chapters: 3, testament: .new),
        BibleBook(id: "phm", name: "Philemon", abbreviation: "Phm", chapters: 1, testament: .new),
        BibleBook(id: "heb", name: "Hebrews", abbreviation: "Heb", chapters: 13, testament: .new),
        BibleBook(id: "jas", name: "James", abbreviation: "Jas", chapters: 5, testament: .new),
        BibleBook(id: "1pe", name: "1 Peter", abbreviation: "1Pe", chapters: 5, testament: .new),
        BibleBook(id: "2pe", name: "2 Peter", abbreviation: "2Pe", chapters: 3, testament: .new),
        BibleBook(id: "1jn", name: "1 John", abbreviation: "1Jn", chapters: 5, testament: .new),
        BibleBook(id: "2jn", name: "2 John", abbreviation: "2Jn", chapters: 1, testament: .new),
        BibleBook(id: "3jn", name: "3 John", abbreviation: "3Jn", chapters: 1, testament: .new),
        BibleBook(id: "jud", name: "Jude", abbreviation: "Jud", chapters: 1, testament: .new),
        BibleBook(id: "rev", name: "Revelation", abbreviation: "Rev", chapters: 22, testament: .new),
    ]

    static let audioVersions: [AudioVersion] = [
        AudioVersion(id: "icb_wop", name: "ICB Word of Promise Next Generation", isPremium: true),
        AudioVersion(id: "kjv_drama", name: "KJV Dramatized", isPremium: false),
        AudioVersion(id: "kjv_max", name: "KJV Max McLean", isPremium: false),
        AudioVersion(id: "nirv_pure", name: "NIrV Pure Voice", isPremium: false),
        AudioVersion(id: "niv_drama", name: "NIV Dramatized", isPremium: false),
        AudioVersion(id: "niv_max", name: "NIV Max McLean", isPremium: false),
        AudioVersion(id: "niv_pure", name: "NIV Pure Voice", isPremium: false),
        AudioVersion(id: "nkjv_bob", name: "NKJV Voice Only (Bob Souer)", isPremium: true),
        AudioVersion(id: "nkjv_simon", name: "NKJV Voice Only (Simon Bubb)", isPremium: false),
        AudioVersion(id: "nkjv_drama", name: "NKJV Dramatized", isPremium: true),
        AudioVersion(id: "nkjv_tinasha", name: "NKJV Voice Only (Tinasha LaRaye)", isPremium: false),
        AudioVersion(id: "nvi_rafael", name: "NVI Rafael Cruz", isPremium: false),
        AudioVersion(id: "nvi_viva", name: "NVI Biblia Experiencia Viva", isPremium: false),
    ]

    static func book(byId id: String) -> BibleBook? {
        books.first { $0.id == id }
    }

    static func bookIndex(_ book: BibleBook) -> Int? {
        books.firstIndex(where: { $0.id == book.id })
    }

    static func nextChapter(after book: BibleBook, chapter: Int) -> (BibleBook, Int)? {
        if chapter < book.chapters {
            return (book, chapter + 1)
        }
        guard let idx = bookIndex(book), idx + 1 < books.count else { return nil }
        return (books[idx + 1], 1)
    }

    static func previousChapter(before book: BibleBook, chapter: Int) -> (BibleBook, Int)? {
        if chapter > 1 {
            return (book, chapter - 1)
        }
        guard let idx = bookIndex(book), idx > 0 else { return nil }
        let prevBook = books[idx - 1]
        return (prevBook, prevBook.chapters)
    }
}
