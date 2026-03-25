import SwiftUI

struct ProfileHeaderView: View {
    let user: User

    var body: some View {
        VStack(spacing: 8) {
            AvatarView(
                url: user.avatarURL,
                displayName: user.displayName,
                size: 90
            )

            Text(user.displayName)
                .font(.title2)
                .fontWeight(.bold)

            Text("@\(user.username)")
                .font(.subheadline)
                .foregroundStyle(.secondary)

            if let bio = user.bio {
                Text(bio)
                    .font(.body)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 32)
                    .padding(.top, 4)
            }
        }
    }
}

// MARK: - Preview

#Preview {
    ProfileHeaderView(user: .mockAlice)
}
