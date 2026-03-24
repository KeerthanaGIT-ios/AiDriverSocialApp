import SwiftUI

struct UserSearchRow: View {
    let user: User

    var body: some View {
        HStack(spacing: 12) {
            AvatarView(
                url: user.avatarURL,
                displayName: user.displayName,
                size: 44
            )

            VStack(alignment: .leading, spacing: 2) {
                Text(user.displayName)
                    .font(.subheadline)
                    .fontWeight(.bold)
                    .foregroundStyle(.primary)

                Text("@\(user.username)")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }

            Spacer()
        }
        .padding(.vertical, 4)
        .accessibilityLabel("\(user.displayName), @\(user.username)")
    }
}

// MARK: - Preview

#Preview {
    List {
        UserSearchRow(user: .mockAlice)
        UserSearchRow(user: .mockBob)
        UserSearchRow(user: .mockDave)
    }
}
