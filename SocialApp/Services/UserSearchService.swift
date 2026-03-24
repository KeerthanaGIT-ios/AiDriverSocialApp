import Foundation

// MARK: - Protocol

protocol UserSearchServiceProtocol {
    func searchUsers(query: String) async throws -> [User]
}

// MARK: - Errors

enum UserSearchServiceError: LocalizedError {
    case searchFailed
    case unknown(Error)

    var errorDescription: String? {
        switch self {
        case .searchFailed:
            return "User search failed."
        case .unknown(let error):
            return error.localizedDescription
        }
    }
}

// MARK: - Mock Implementation

final class MockUserSearchService: UserSearchServiceProtocol {

    func searchUsers(query: String) async throws -> [User] {
        // Simulate network delay
        try? await Task.sleep(for: .milliseconds(150))

        let trimmed = query.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return [] }

        let lowercasedQuery = trimmed.lowercased()

        return User.mockAllUsers.filter { user in
            user.displayName.lowercased().contains(lowercasedQuery) ||
            user.username.lowercased().contains(lowercasedQuery)
        }
    }
}
