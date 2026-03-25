import Foundation

/// Repository that wraps a PostServiceProtocol and provides a clean interface for ViewModels.
/// ViewModels interact with this repository instead of touching services directly.
final class PostRepository: @unchecked Sendable {

    private let service: PostServiceProtocol

    init(service: PostServiceProtocol = MockPostService()) {
        self.service = service
    }

    // MARK: - Public Interface

    /// Fetches all posts, sorted by most recent first.
    func fetchPosts() async throws -> [Post] {
        do {
            return try await service.fetchPosts()
        } catch let error as PostServiceError {
            throw mapError(error)
        } catch {
            throw PostRepositoryError.underlying(error)
        }
    }

    /// Fetches posts by a specific user.
    func fetchPosts(byUserID userID: String) async throws -> [Post] {
        do {
            return try await service.fetchPosts(byUserID: userID)
        } catch let error as PostServiceError {
            throw mapError(error)
        } catch {
            throw PostRepositoryError.underlying(error)
        }
    }

    /// Toggles like status on a post for the given user.
    func toggleLike(postID: String, userID: String) async throws {
        do {
            try await service.toggleLike(postID: postID, userID: userID)
        } catch let error as PostServiceError {
            throw mapError(error)
        } catch {
            throw PostRepositoryError.underlying(error)
        }
    }

    /// Creates a new post.
    func createPost(_ post: Post) async throws {
        do {
            try await service.createPost(post)
        } catch let error as PostServiceError {
            throw mapError(error)
        } catch {
            throw PostRepositoryError.underlying(error)
        }
    }

    // MARK: - Error Mapping

    private func mapError(_ error: PostServiceError) -> PostRepositoryError {
        switch error {
        case .notFound:
            return .postNotFound
        case .decodingFailed:
            return .dataCorrupted
        case .networkUnavailable:
            return .offline
        case .unknown(let underlyingError):
            return .underlying(underlyingError)
        }
    }
}

// MARK: - Repository Errors

enum PostRepositoryError: LocalizedError {
    case postNotFound
    case dataCorrupted
    case offline
    case underlying(Error)

    var errorDescription: String? {
        switch self {
        case .postNotFound:
            return "The post could not be found."
        case .dataCorrupted:
            return "The post data appears to be corrupted."
        case .offline:
            return "You appear to be offline. Please check your connection and try again."
        case .underlying(let error):
            return error.localizedDescription
        }
    }
}
