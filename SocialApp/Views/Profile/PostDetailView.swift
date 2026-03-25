import SwiftUI

struct PostDetailView: View {
    let post: Post


    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 12) {
                // Author header
                HStack(spacing: 10) {
                    AvatarView(
                        url: post.author.avatarURL,
                        displayName: post.author.displayName,
                        size: 40
                    )

                    VStack(alignment: .leading, spacing: 2) {
                        Text(post.author.displayName)
                            .font(.subheadline)
                            .fontWeight(.semibold)

                        Text("@\(post.author.username)")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }

                    Spacer()
                }
                .padding(.horizontal)

                // Image
                if let imageURL = post.imageURL {
                    AsyncImage(url: imageURL) { phase in
                        switch phase {
                        case .success(let image):
                            image
                                .resizable()
                                .scaledToFit()
                                .frame(maxWidth: .infinity)
                        case .failure:
                            Rectangle()
                                .fill(Color(.systemGray5))
                                .aspectRatio(1, contentMode: .fit)
                                .overlay {
                                    Image(systemName: "photo")
                                        .font(.largeTitle)
                                        .foregroundStyle(.secondary)
                                }
                        case .empty:
                            ProgressView()
                                .frame(maxWidth: .infinity)
                                .frame(height: 300)
                        @unknown default:
                            EmptyView()
                        }
                    }
                }

                // Text content
                VStack(alignment: .leading, spacing: 8) {
                    // Likes and comments
                    HStack(spacing: 16) {
                        Label("\(post.likeCount)", systemImage: post.isLikedByCurrentUser ? "heart.fill" : "heart")
                            .foregroundStyle(post.isLikedByCurrentUser ? .red : .primary)

                        Label("\(post.commentCount)", systemImage: "bubble.right")
                    }
                    .font(.subheadline)

                    // Caption
                    Text(post.textContent)
                        .font(.subheadline)
                }
                .padding(.horizontal)
            }
        }
        .navigationTitle("Post")
        .navigationBarTitleDisplayMode(.inline)
    }
}

// MARK: - Preview

#Preview {
    NavigationStack {
        PostDetailView(post: Post.mockPosts[0])
    }
}
