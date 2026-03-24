import SwiftUI

struct UserProfileView: View {
    let user: User

    var body: some View {
        VStack(spacing: 12) {
            AvatarView(
                url: user.avatarURL,
                displayName: user.displayName,
                size: 100
            )

            Text(user.displayName)
                .font(.title)
                .fontWeight(.bold)

            Text("@\(user.username)")
                .font(.subheadline)
                .foregroundStyle(.secondary)

            Spacer()

            Text("Profile details coming soon")
                .font(.subheadline)
                .foregroundStyle(.gray)

            Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity)
        .navigationTitle(user.displayName)
        .navigationBarTitleDisplayMode(.inline)
    }
}

// MARK: - Preview

#Preview {
    NavigationStack {
        UserProfileView(user: .mockAlice)
    }
}
