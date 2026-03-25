import SwiftUI

struct StoryItemView: View {
    let user: User
    let hasUnseenStory: Bool
    let isCurrentUser: Bool
    var onTap: () -> Void

    var body: some View {
        Button(action: onTap) {
            VStack(spacing: 4) {
                ZStack(alignment: .bottomTrailing) {
                    // Gradient ring
                    Circle()
                        .stroke(
                            hasUnseenStory
                                ? AnyShapeStyle(
                                    AngularGradient(
                                        colors: [.purple, .pink, .orange, .yellow, .purple],
                                        center: .center
                                    )
                                )
                                : AnyShapeStyle(Color(.systemGray4)),
                            lineWidth: 3
                        )
                        .frame(width: 70, height: 70)
                        .overlay {
                            AvatarView(
                                url: user.avatarURL,
                                displayName: user.displayName,
                                size: 64
                            )
                            .padding(3) // gap between ring and avatar
                        }

                    // "+" badge for current user
                    if isCurrentUser {
                        ZStack {
                            Circle()
                                .fill(.blue)
                                .frame(width: 22, height: 22)
                            Circle()
                                .stroke(Color(.systemBackground), lineWidth: 2)
                                .frame(width: 22, height: 22)
                            Image(systemName: "plus")
                                .font(.system(size: 12, weight: .bold))
                                .foregroundStyle(.white)
                        }
                        .offset(x: 2, y: 2)
                    }
                }

                Text(isCurrentUser ? "Your Story" : user.username)
                    .font(.caption)
                    .lineLimit(1)
                    .frame(width: 70)
                    .foregroundStyle(.primary)
            }
        }
        .buttonStyle(.plain)
        .accessibilityLabel(isCurrentUser ? "Your story" : "\(user.displayName) story")
    }
}

// MARK: - Preview

#Preview {
    HStack(spacing: 12) {
        StoryItemView(
            user: .currentUser,
            hasUnseenStory: false,
            isCurrentUser: true,
            onTap: {}
        )
        StoryItemView(
            user: .mockBob,
            hasUnseenStory: true,
            isCurrentUser: false,
            onTap: {}
        )
        StoryItemView(
            user: .mockCarla,
            hasUnseenStory: false,
            isCurrentUser: false,
            onTap: {}
        )
    }
    .padding()
}
