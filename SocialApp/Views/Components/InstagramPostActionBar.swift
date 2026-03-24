import SwiftUI

struct InstagramPostActionBar: View {
    let isLiked: Bool
    let isBookmarked: Bool

    var onLike: () -> Void
    var onComment: () -> Void
    var onShare: () -> Void
    var onBookmark: () -> Void

    var body: some View {
        HStack {
            HStack(spacing: 16) {
                Button(action: onLike) {
                    Image(systemName: isLiked ? "heart.fill" : "heart")
                        .foregroundStyle(isLiked ? .red : .primary)
                }
                .accessibilityLabel(isLiked ? "Unlike" : "Like")

                Button(action: onComment) {
                    Image(systemName: "bubble.right")
                        .foregroundStyle(.primary)
                }
                .accessibilityLabel("Comment")

                Button(action: onShare) {
                    Image(systemName: "paperplane")
                        .foregroundStyle(.primary)
                }
                .accessibilityLabel("Share")
            }
            .font(.title3)

            Spacer()

            Button(action: onBookmark) {
                Image(systemName: isBookmarked ? "bookmark.fill" : "bookmark")
                    .foregroundStyle(.primary)
            }
            .font(.title3)
            .accessibilityLabel(isBookmarked ? "Remove bookmark" : "Bookmark")
        }
        .buttonStyle(.plain)
    }
}

// MARK: - Preview

#Preview {
    VStack(spacing: 20) {
        InstagramPostActionBar(
            isLiked: false,
            isBookmarked: false,
            onLike: {},
            onComment: {},
            onShare: {},
            onBookmark: {}
        )
        InstagramPostActionBar(
            isLiked: true,
            isBookmarked: true,
            onLike: {},
            onComment: {},
            onShare: {},
            onBookmark: {}
        )
    }
    .padding()
}
