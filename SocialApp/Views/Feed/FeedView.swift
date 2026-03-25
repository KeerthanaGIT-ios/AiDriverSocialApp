import SwiftUI

struct FeedView: View {
    @ObservedObject var viewModel: FeedViewModel

    var body: some View {
        NavigationStack {
            Group {
                if viewModel.isLoading && viewModel.posts.isEmpty {
                    loadingView
                } else if let error = viewModel.error {
                    errorView(message: error)
                } else if viewModel.posts.isEmpty {
                    emptyView
                } else {
                    feedList
                }
            }
            .navigationTitle("Feed")
            .task {
                await viewModel.loadPosts()
            }
        }
    }

    // MARK: - Feed List

    private var feedList: some View {
        ScrollView {
            LazyVStack(spacing: 12) {
                ForEach(viewModel.posts) { post in
                    PostCell(
                        post: post,
                        onLike: { viewModel.toggleLike(on: post) },
                        onComment: { /* TODO: navigate to comments */ },
                        onShare: { /* TODO: share sheet */ }
                    )
                }
            }
            .padding(.horizontal)
            .padding(.vertical, 8)
        }
        .background(Color(.systemGroupedBackground))
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
    FeedView(viewModel: FeedViewModel())
}
