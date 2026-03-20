import SwiftUI

struct PassagePickerView: View {
    @EnvironmentObject var audioManager: AudioManager
    @EnvironmentObject var bibleStore: BibleStore
    @Environment(\.dismiss) private var dismiss

    @State private var selectedTab = 0  // 0 = Bible, 1 = Plans
    @State private var selectedBook: BibleBook?
    @State private var selectedChapter: Int?

    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // Bible / Plans toggle
                Picker("", selection: $selectedTab) {
                    Text("Bible").tag(0)
                    Text("Plans").tag(1)
                }
                .pickerStyle(.segmented)
                .padding(.horizontal, 80)
                .padding(.vertical, 12)

                if selectedTab == 0 {
                    bibleBookList
                } else {
                    plansPlaceholder
                }
            }
            .navigationTitle("Go to Passage")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "chevron.left")
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Go") {
                        if let book = selectedBook {
                            let chapter = selectedChapter ?? 1
                            bibleStore.navigateTo(book: book, chapter: chapter)
                            audioManager.loadAudio(
                                book: book,
                                chapter: chapter,
                                version: bibleStore.selectedAudioVersion
                            )
                            dismiss()
                        }
                    }
                    .disabled(selectedBook == nil)
                }
            }
        }
        .onAppear {
            selectedBook = bibleStore.currentBook
            selectedChapter = bibleStore.currentChapter
        }
    }

    private var bibleBookList: some View {
        ScrollViewReader { proxy in
            List {
                ForEach(Array(BibleData.books.enumerated()), id: \.element.id) { index, book in
                    Button {
                        selectedBook = book
                        selectedChapter = 1
                    } label: {
                        HStack {
                            Text(book.name)
                                .foregroundColor(selectedBook?.id == book.id ? .primary : .primary)
                                .fontWeight(selectedBook?.id == book.id ? .bold : .regular)

                            Spacer()

                            Text("\(index + 1)")
                                .foregroundColor(.secondary)
                                .font(.subheadline)
                        }
                    }
                    .listRowBackground(
                        selectedBook?.id == book.id
                            ? Color(.systemGray4)
                            : Color.clear
                    )
                    .id(book.id)
                }
            }
            .listStyle(.plain)
            .onAppear {
                proxy.scrollTo(bibleStore.currentBook.id, anchor: .center)
            }
        }
    }

    private var plansPlaceholder: some View {
        VStack {
            Spacer()
            Text("Reading plans coming soon")
                .foregroundColor(.secondary)
            Spacer()
        }
    }
}

#Preview {
    PassagePickerView()
        .environmentObject(AudioManager())
        .environmentObject(BibleStore())
}
