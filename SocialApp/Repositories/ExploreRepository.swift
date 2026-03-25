import Foundation

/// Repository that wraps an ExploreServiceProtocol and provides a clean interface for ViewModels.
/// ViewModels interact with this repository instead of touching services directly.
final class ExploreRepository: @unchecked Sendable {

    private let service: ExploreServiceProtocol

    init(service: ExploreServiceProtocol = MockExploreService()) {
        self.service = service
    }

    // MARK: - Public Interface

    /// Fetches explore posts shuffled for discovery.
    func fetchExplorePosts() async throws -> [Post] {
        do {
            return try await service.fetchExplorePosts()
        } catch let error as ExploreServiceError {
            throw mapError(error)
        } catch {
            throw ExploreRepositoryError.underlying(error)
        }
    }

    // MARK: - Error Mapping

    private func mapError(_ error: ExploreServiceError) -> ExploreRepositoryError {
        switch error {
        case .fetchFailed:
            return .fetchFailed
        case .unknown(let underlyingError):
            return .underlying(underlyingError)
        }
    }
}

// MARK: - Repository Errors

enum ExploreRepositoryError: LocalizedError {
    case fetchFailed
    case underlying(Error)

    var errorDescription: String? {
        switch self {
        case .fetchFailed:
            return "Unable to load explore posts at this time."
        case .underlying(let error):
            return error.localizedDescription
        }
    }
}
