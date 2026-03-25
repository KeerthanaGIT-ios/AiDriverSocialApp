import Foundation

@MainActor
final class UserProfileViewModel: ObservableObject {

    // MARK: - Published State

    @Published var posts: [Post] = []
    @Published var isFollowing: Bool = false
    @Published var isLoading: Bool = false

    // MARK: - Dependencies

    let user: User
    private let repository: PostRepository

    // MARK: - Computed Properties

    var isCurrentUser: Bool {
        user.id == User.currentUser.id
    }

    var postsCount: Int {
        posts.count
    }

    var followersCount: Int {
        user.followersCount
    }

    var followingCount: Int {
        user.followingCount
    }

    // MARK: - Init

    init(user: User, repository: PostRepository = PostRepository()) {
        self.user = user
        self.repository = repository
    }

    // MARK: - Actions

    func loadProfile() async {
        isLoading = true

        do {
            posts = try await repository.fetchPosts(byUserID: user.id)
        } catch {
            // Silently handle — posts will remain empty
        }

        isLoading = false
    }

    func toggleFollow() {
        isFollowing.toggle()
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
        let userID = User.currentUser.id
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
            }
        }
    }
}
