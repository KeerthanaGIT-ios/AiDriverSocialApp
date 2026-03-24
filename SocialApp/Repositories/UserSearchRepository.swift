import Foundation

/// Repository that wraps a UserSearchServiceProtocol and provides a clean interface for ViewModels.
/// ViewModels interact with this repository instead of touching services directly.
final class UserSearchRepository: @unchecked Sendable {

    private let service: UserSearchServiceProtocol

    init(service: UserSearchServiceProtocol = MockUserSearchService()) {
        self.service = service
    }

    // MARK: - Public Interface

    /// Searches users by query string.
    func searchUsers(query: String) async throws -> [User] {
        do {
            return try await service.searchUsers(query: query)
        } catch let error as UserSearchServiceError {
            throw mapError(error)
        } catch {
            throw UserSearchRepositoryError.underlying(error)
        }
    }

    // MARK: - Error Mapping

    private func mapError(_ error: UserSearchServiceError) -> UserSearchRepositoryError {
        switch error {
        case .searchFailed:
            return .searchFailed
        case .unknown(let underlyingError):
            return .underlying(underlyingError)
        }
    }
}

// MARK: - Repository Errors

enum UserSearchRepositoryError: LocalizedError {
    case searchFailed
    case underlying(Error)

    var errorDescription: String? {
        switch self {
        case .searchFailed:
            return "Unable to search for users at this time."
        case .underlying(let error):
            return error.localizedDescription
        }
    }
}
