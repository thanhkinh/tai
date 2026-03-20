import SwiftUI

@main
struct BibleListenerApp: App {
    @StateObject private var audioManager = AudioManager()
    @StateObject private var bibleStore = BibleStore()

    var body: some Scene {
        WindowGroup {
            PlayerView()
                .environmentObject(audioManager)
                .environmentObject(bibleStore)
        }
    }
}
