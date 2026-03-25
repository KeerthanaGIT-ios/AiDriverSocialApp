import Foundation

@MainActor
final class FeedViewModel: ObservableObject {

    // MARK: - Published State

    @Published var posts: [Post] = []
    @Published var isLoading: Bool = false
    @Published var error: String?

    // MARK: - Dependencies

    private let repository: PostRepository

    // Default uses MockPostService so the app runs without Firebase configured.
    init(repository: PostRepository = PostRepository()) {
        self.repository = repository
    }

    // MARK: - Actions

    func loadPosts() async {
        isLoading = true
        error = nil

        do {
            posts = try await repository.fetchPosts()
        } catch {
            self.error = error.localizedDescription
        }

        isLoading = false
    }

    func addPost(_ post: Post) {
        posts.insert(post, at: 0)
    }

    func toggleLike(on post: Post) {
        guard let index = posts.firstIndex(where: { $0.id == post.id }) else { return }

        // Optimistic UI update
        posts[index].isLikedByCurrentUser.toggle()

        if posts[index].isLikedByCurrentUser {
            posts[index].likeCount += 1
        } else {
            posts[index].likeCount -= 1
        }

        // Fire-and-forget service call
        let postID = post.id
        let userID = "current-user" // TODO: replace with real authenticated user ID
        Task {
            do {
                try await repository.toggleLike(postID: postID, userID: userID)
            } catch {
                // Revert optimistic update on failure
                if let idx = posts.firstIndex(where: { $0.id == postID }) {
                    posts[idx].isLikedByCurrentUser.toggle()
                    if posts[idx].isLikedByCurrentUser {
                        posts[idx].likeCount += 1
                    } else {
                        posts[idx].likeCount -= 1
                    }
                }
                self.error = error.localizedDescription
            }
        }
    }
}
