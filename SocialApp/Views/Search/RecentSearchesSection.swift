import SwiftUI

struct RecentSearchesSection: View {
    let users: [User]
    var onTap: (User) -> Void
    var onClear: () -> Void

    var body: some View {
        Section {
            ForEach(users) { user in
                Button {
                    onTap(user)
                } label: {
                    UserSearchRow(user: user)
                }
                .buttonStyle(.plain)
            }
        } header: {
            HStack {
                Text("Recent")
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundStyle(.primary)

                Spacer()

                Button("Clear") {
                    onClear()
                }
                .font(.subheadline)
                .foregroundStyle(.blue)
            }
            .padding(.bottom, 4)
        }
    }
}

// MARK: - Preview

#Preview {
    List {
        RecentSearchesSection(
            users: [.mockAlice, .mockBob, .mockCarla],
            onTap: { _ in },
            onClear: {}
        )
    }
}
