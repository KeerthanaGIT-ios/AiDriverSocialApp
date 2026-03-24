import SwiftUI

struct PostCell: View {
    let post: Post
    var onLike: () -> Void
    var onComment: () -> Void
    var onShare: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // MARK: Author Row
            HStack(spacing: 10) {
                AvatarView(url: post.author.avatarURL, displayName: post.author.displayName)

                VStack(alignment: .leading, spacing: 2) {
                    Text(post.author.displayName)
                        .font(.subheadline)
                        .fontWeight(.semibold)

                    HStack(spacing: 4) {
                        Text("@\(post.author.username)")
                            .font(.caption)
                            .foregroundStyle(.secondary)

                        Text("~")
                            .font(.caption)
                            .foregroundStyle(.secondary)

                        Text(post.createdAt, style: .relative)
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                }

                Spacer()
            }

            // MARK: Text Content
            Text(post.textContent)
                .font(.body)
                .lineLimit(nil)
                .fixedSize(horizontal: false, vertical: true)

            // MARK: Post Image
            if let imageURL = post.imageURL {
                AsyncImage(url: imageURL) { phase in
                    switch phase {
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(maxWidth: .infinity)
                            .frame(height: 200)
                            .clipped()
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                    case .failure:
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color(.systemGray5))
                            .frame(height: 200)
                            .overlay {
                                Image(systemName: "photo")
                                    .font(.title2)
                                    .foregroundStyle(.secondary)
                            }
                    case .empty:
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color(.systemGray6))
                            .frame(height: 200)
                            .overlay(ProgressView())
                    @unknown default:
                        EmptyView()
                    }
                }
            }

            // MARK: Action Bar
            Divider()

            PostActionBar(
                likeCount: post.likeCount,
                commentCount: post.commentCount,
                isLiked: post.isLikedByCurrentUser,
                onLike: onLike,
                onComment: onComment,
                onShare: onShare
            )
        }
        .padding()
        .background(Color(.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .shadow(color: .black.opacity(0.06), radius: 8, x: 0, y: 2)
    }
}

// MARK: - Preview

#Preview {
    ScrollView {
        VStack(spacing: 12) {
            PostCell(
                post: Post.mockPosts[0],
                onLike: {},
                onComment: {},
                onShare: {}
            )
            PostCell(
                post: Post.mockPosts[1],
                onLike: {},
                onComment: {},
                onShare: {}
            )
        }
        .padding()
    }
    .background(Color(.systemGroupedBackground))
}
