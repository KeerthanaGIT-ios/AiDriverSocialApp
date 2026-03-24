import SwiftUI

struct PostActionBar: View {
    let likeCount: Int
    let commentCount: Int
    let isLiked: Bool

    var onLike: () -> Void
    var onComment: () -> Void
    var onShare: () -> Void

    var body: some View {
        HStack(spacing: 0) {
            actionButton(
                icon: isLiked ? "heart.fill" : "heart",
                label: formattedCount(likeCount),
                tint: isLiked ? .red : .secondary,
                accessibilityLabel: isLiked ? "Unlike" : "Like",
                action: onLike
            )

            Spacer()

            actionButton(
                icon: "bubble.right",
                label: formattedCount(commentCount),
                tint: .secondary,
                accessibilityLabel: "Comment",
                action: onComment
            )

            Spacer()

            actionButton(
                icon: "square.and.arrow.up",
                label: nil,
                tint: .secondary,
                accessibilityLabel: "Share",
                action: onShare
            )
        }
    }

    // MARK: - Subviews

    @ViewBuilder
    private func actionButton(
        icon: String,
        label: String?,
        tint: Color,
        accessibilityLabel: String,
        action: @escaping () -> Void
    ) -> some View {
        Button(action: action) {
            HStack(spacing: 4) {
                Image(systemName: icon)
                    .font(.subheadline)
                if let label {
                    Text(label)
                        .font(.caption)
                }
            }
            .foregroundStyle(tint)
            .padding(.vertical, 6)
            .padding(.horizontal, 12)
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
        .accessibilityLabel(accessibilityLabel)
    }

    // MARK: - Helpers

    private func formattedCount(_ count: Int) -> String {
        if count >= 1_000_000 {
            return String(format: "%.1fM", Double(count) / 1_000_000)
        } else if count >= 1_000 {
            return String(format: "%.1fK", Double(count) / 1_000)
        }
        return "\(count)"
    }
}

// MARK: - Preview

#Preview {
    VStack(spacing: 20) {
        PostActionBar(
            likeCount: 42,
            commentCount: 7,
            isLiked: false,
            onLike: {},
            onComment: {},
            onShare: {}
        )
        PostActionBar(
            likeCount: 1234,
            commentCount: 53,
            isLiked: true,
            onLike: {},
            onComment: {},
            onShare: {}
        )
    }
    .padding()
}
