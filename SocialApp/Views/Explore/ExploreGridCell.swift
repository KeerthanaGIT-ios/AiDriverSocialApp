import SwiftUI

struct ExploreGridCell: View {
    let post: Post

    var body: some View {
        GeometryReader { geometry in
            if let imageURL = post.imageURL {
                AsyncImage(url: imageURL) { phase in
                    switch phase {
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(width: geometry.size.width, height: geometry.size.height)
                            .clipped()
                    case .failure:
                        placeholderView
                            .frame(width: geometry.size.width, height: geometry.size.height)
                    case .empty:
                        ProgressView()
                            .frame(width: geometry.size.width, height: geometry.size.height)
                            .background(Color(.systemGray6))
                    @unknown default:
                        placeholderView
                            .frame(width: geometry.size.width, height: geometry.size.height)
                    }
                }
            } else {
                textPlaceholderView
                    .frame(width: geometry.size.width, height: geometry.size.height)
            }
        }
        .clipped()
        .accessibilityLabel("Post by \(post.author.displayName)")
    }

    // MARK: - Placeholder Views

    private var placeholderView: some View {
        Rectangle()
            .fill(Color(.systemGray5))
            .overlay {
                Image(systemName: "photo")
                    .font(.title2)
                    .foregroundStyle(.secondary)
            }
    }

    private var textPlaceholderView: some View {
        Rectangle()
            .fill(Color(.systemGray5))
            .overlay {
                Text(post.textContent)
                    .font(.caption2)
                    .foregroundStyle(.primary)
                    .multilineTextAlignment(.center)
                    .lineLimit(4)
                    .padding(8)
            }
    }
}

// MARK: - Preview

#Preview {
    HStack(spacing: 1) {
        ExploreGridCell(post: Post.mockPosts[0])
            .frame(width: 130, height: 130)
        ExploreGridCell(post: Post.mockPosts[0])
            .frame(width: 130, height: 261)
    }
    .padding()
}
