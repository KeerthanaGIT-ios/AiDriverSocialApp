import SwiftUI

struct PostDetailView: View {
    let post: Post
    var onLikeToggle: (() -> Void)?

    var body: some View {
        ScrollView {
            PostCell(
                post: post,
                onLike: { onLikeToggle?() },
                onComment: { /* TODO: navigate to comments */ },
                onShare: { /* TODO: share sheet */ }
            )
            .padding()
        }
        .background(Color(.systemGroupedBackground))
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
