import SwiftUI

struct ProfilePostsGridView: View {
    let posts: [Post]

    private let columns = [
        GridItem(.flexible(), spacing: 2),
        GridItem(.flexible(), spacing: 2),
        GridItem(.flexible(), spacing: 2),
    ]

    var body: some View {
        LazyVGrid(columns: columns, spacing: 2) {
            ForEach(posts) { post in
                NavigationLink(value: post) {
                    gridCell(for: post)
                }
            }
        }
    }

    @ViewBuilder
    private func gridCell(for post: Post) -> some View {
        Color.clear
            .aspectRatio(1, contentMode: .fit)
            .overlay {
                if let imageURL = post.imageURL {
                    AsyncImage(url: imageURL) { phase in
                        switch phase {
                        case .success(let image):
                            image
                                .resizable()
                                .scaledToFill()
                        case .failure:
                            placeholderView
                        case .empty:
                            ProgressView()
                        @unknown default:
                            placeholderView
                        }
                    }
                } else {
                    placeholderView
                }
            }
            .clipped()
    }

    private var placeholderView: some View {
        Rectangle()
            .fill(Color(.systemGray5))
            .overlay {
                Image(systemName: "text.alignleft")
                    .font(.title2)
                    .foregroundStyle(.secondary)
            }
    }
}

// MARK: - Preview

#Preview {
    NavigationStack {
        ScrollView {
            ProfilePostsGridView(posts: Post.mockPosts)
        }
    }
}
