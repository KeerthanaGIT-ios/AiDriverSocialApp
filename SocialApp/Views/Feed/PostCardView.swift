import SwiftUI

struct PostCardView: View {
    let post: Post
    let isLiked: Bool
    let isBookmarked: Bool

    var onLike: () -> Void
    var onDoubleTapLike: () -> Void
    var onComment: () -> Void
    var onShare: () -> Void
    var onBookmark: () -> Void

    @State private var showHeartAnimation = false

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // MARK: Header
            headerRow

            // MARK: Post Image
            if let imageURL = post.imageURL {
                postImage(url: imageURL)
            }

            // MARK: Action Bar
            InstagramPostActionBar(
                isLiked: isLiked,
                isBookmarked: isBookmarked,
                onLike: onLike,
                onComment: onComment,
                onShare: onShare,
                onBookmark: onBookmark
            )
            .padding(.horizontal, 12)
            .padding(.top, 8)

            // MARK: Likes Count
            likesSection

            // MARK: Caption
            captionSection

            // MARK: Comments Link
            commentsLink

            // MARK: Timestamp
            Text(post.createdAt, style: .relative)
                .font(.caption)
                .foregroundStyle(.secondary)
                .padding(.horizontal, 12)
                .padding(.top, 2)
                .padding(.bottom, 12)
        }
        .background(Color(.systemBackground))
    }

    // MARK: - Header Row

    private var headerRow: some View {
        HStack(spacing: 8) {
            AvatarView(
                url: post.author.avatarURL,
                displayName: post.author.displayName,
                size: 32
            )

            Text(post.author.username)
                .font(.subheadline)
                .fontWeight(.bold)

            Spacer()

            Button {
                // TODO: post options menu
            } label: {
                Image(systemName: "ellipsis")
                    .foregroundStyle(.gray)
            }
            .accessibilityLabel("More options")
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 8)
    }

    // MARK: - Post Image

    private func postImage(url: URL) -> some View {
        GeometryReader { geo in
            AsyncImage(url: url) { phase in
                switch phase {
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: geo.size.width, height: geo.size.width)
                        .clipped()
                case .failure:
                    Rectangle()
                        .fill(Color(.systemGray5))
                        .frame(width: geo.size.width, height: geo.size.width)
                        .overlay {
                            Image(systemName: "photo")
                                .font(.title)
                                .foregroundStyle(.secondary)
                        }
                case .empty:
                    Rectangle()
                        .fill(Color(.systemGray6))
                        .frame(width: geo.size.width, height: geo.size.width)
                        .overlay(ProgressView())
                @unknown default:
                    EmptyView()
                }
            }
        }
        .aspectRatio(1, contentMode: .fit)
        .clipped()
        .overlay {
            HeartAnimationOverlay(isAnimating: $showHeartAnimation)
        }
        .onTapGesture(count: 2) {
            showHeartAnimation = true
            onDoubleTapLike()
        }
    }

    // MARK: - Likes Section

    @ViewBuilder
    private var likesSection: some View {
        if post.likeCount > 0 {
            Group {
                if post.likeCount > 1 {
                    HStack(spacing: 0) {
                        Text("Liked by ")
                        Text(post.author.username == "bobsmith" ? "carlareyes" : "bobsmith")
                            .fontWeight(.bold)
                        Text(" and ")
                        Text("\(post.likeCount - 1) others")
                            .fontWeight(.bold)
                    }
                    .font(.subheadline)
                } else {
                    Text("1 like")
                        .font(.subheadline)
                        .fontWeight(.bold)
                }
            }
            .padding(.horizontal, 12)
            .padding(.top, 4)
        }
    }

    // MARK: - Caption Section

    @ViewBuilder
    private var captionSection: some View {
        let captionText = post.caption.isEmpty ? post.textContent : post.caption
        if !captionText.isEmpty {
            HStack(spacing: 0) {
                Text(post.author.username)
                    .fontWeight(.bold)
                + Text(" ")
                + Text(captionText)
            }
            .font(.subheadline)
            .lineLimit(2)
            .padding(.horizontal, 12)
            .padding(.top, 2)
        }
    }

    // MARK: - Comments Link

    @ViewBuilder
    private var commentsLink: some View {
        if post.commentCount > 0 {
            Button {
                onComment()
            } label: {
                Text("View all \(post.commentCount) comments")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
            .buttonStyle(.plain)
            .padding(.horizontal, 12)
            .padding(.top, 2)
        }
    }
}

// MARK: - Preview

#Preview {
    ScrollView {
        VStack(spacing: 0) {
            PostCardView(
                post: Post.mockPosts[0],
                isLiked: false,
                isBookmarked: false,
                onLike: {},
                onDoubleTapLike: {},
                onComment: {},
                onShare: {},
                onBookmark: {}
            )
            Divider()
            PostCardView(
                post: Post.mockPosts[1],
                isLiked: true,
                isBookmarked: true,
                onLike: {},
                onDoubleTapLike: {},
                onComment: {},
                onShare: {},
                onBookmark: {}
            )
        }
    }
}
