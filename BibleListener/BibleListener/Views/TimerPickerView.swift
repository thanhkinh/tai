import SwiftUI

struct TimerPickerView: View {
    @EnvironmentObject var bibleStore: BibleStore
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        VStack(spacing: 0) {
            Text("Timer:")
                .font(.subheadline)
                .foregroundColor(.secondary)
                .padding(.top, 16)
                .padding(.bottom, 8)

            ForEach(SleepTimer.allCases, id: \.label) { timer in
                Button(action: {
                    bibleStore.startSleepTimer(timer)
                    dismiss()
                }) {
                    Text(timer.label)
                        .font(.title3)
                        .foregroundColor(.blue)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 12)
                }
                Divider()
            }

            Button("Cancel") {
                dismiss()
            }
            .font(.title3)
            .foregroundColor(.blue)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 14)
            .background(Color(.systemGray6))
        }
        .background(Color(.systemGray5))
        .cornerRadius(14)
        .padding(.horizontal, 10)
    }
}
