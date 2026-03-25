import Foundation

// MARK: - Protocol

protocol ExploreServiceProtocol {
    func fetchExplorePosts() async throws -> [Post]
}

// MARK: - Errors

enum ExploreServiceError: LocalizedError {
    case fetchFailed
    case unknown(Error)

    var errorDescription: String? {
        switch self {
        case .fetchFailed:
            return "Failed to fetch explore posts."
        case .unknown(let error):
            return error.localizedDescription
        }
    }
}

// MARK: - Mock Implementation

final class MockExploreService: ExploreServiceProtocol {

    func fetchExplorePosts() async throws -> [Post] {
        // Simulate network delay
        try? await Task.sleep(for: .milliseconds(200))
        return Post.mockPosts.shuffled()
    }
}
