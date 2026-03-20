import SwiftUI

struct AudioVersionPickerView: View {
    @EnvironmentObject var audioManager: AudioManager
    @EnvironmentObject var bibleStore: BibleStore
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationView {
            List {
                ForEach(BibleData.audioVersions) { version in
                    Button {
                        if !version.isPremium {
                            bibleStore.selectedAudioVersion = version
                            audioManager.loadAudio(
                                book: bibleStore.currentBook,
                                chapter: bibleStore.currentChapter,
                                version: version
                            )
                            dismiss()
                        }
                    } label: {
                        HStack {
                            Text(version.name)
                                .foregroundColor(.primary)

                            Spacer()

                            if version.isPremium {
                                Image(systemName: "lock.fill")
                                    .foregroundColor(.blue)
                            } else {
                                Image(systemName: "arrow.down.to.line")
                                    .foregroundColor(.gray)
                            }
                        }
                    }
                }
            }
            .listStyle(.plain)
            .navigationTitle("Choose Audio")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "chevron.left")
                    }
                }
            }
        }
    }
}

#Preview {
    AudioVersionPickerView()
        .environmentObject(AudioManager())
        .environmentObject(BibleStore())
}
