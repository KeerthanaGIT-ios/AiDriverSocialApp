import SwiftUI

struct FeedView: View {
    @StateObject private var viewModel = FeedViewModel()

    var body: some View {
        Group {
            if viewModel.isLoading && viewModel.posts.isEmpty {
                loadingView
            } else if let error = viewModel.error, viewModel.posts.isEmpty {
                errorView(message: error)
            } else if viewModel.posts.isEmpty {
                emptyView
            } else {
                feedContent
            }
        }
        .background(Color(.systemBackground))
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Text("SocialApp")
                    .font(.title3)
                    .fontWeight(.bold)
            }
        }
        .task {
            await viewModel.loadPosts()
            viewModel.stories = Story.mockStories
        }
    }

    // MARK: - Feed Content

    private var feedContent: some View {
        ScrollView {
            LazyVStack(spacing: 0) {
                StoriesBarView(stories: viewModel.stories)

                Divider()

                ForEach(viewModel.posts) { post in
                    PostCardView(
                        post: post,
                        isLiked: post.isLikedByCurrentUser,
                        isBookmarked: post.isBookmarkedByCurrentUser,
                        onLike: { viewModel.toggleLike(on: post) },
                        onDoubleTapLike: { viewModel.likeViaDoubleTap(on: post) },
                        onComment: { /* TODO: navigate to comments */ },
                        onShare: { /* TODO: share sheet */ },
                        onBookmark: { viewModel.toggleBookmark(on: post) }
                    )

                    Divider()
                }
            }
        }
        .refreshable {
            await viewModel.loadPosts()
        }
    }

    // MARK: - State Views

    private var loadingView: some View {
        VStack(spacing: 16) {
            ProgressView()
                .controlSize(.large)
            Text("Loading posts...")
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }

    private func errorView(message: String) -> some View {
        ContentUnavailableView {
            Label("Something Went Wrong", systemImage: "exclamationmark.triangle")
        } description: {
            Text(message)
        } actions: {
            Button("Try Again") {
                Task { await viewModel.loadPosts() }
            }
            .buttonStyle(.bordered)
        }
    }

    private var emptyView: some View {
        ContentUnavailableView {
            Label("No Posts Yet", systemImage: "text.bubble")
        } description: {
            Text("When people you follow share something, it will show up here.")
        }
    }
}

// MARK: - Preview

#Preview {
    NavigationStack {
        FeedView()
    }
}
