import Foundation

/// Repository that wraps a ChatServiceProtocol and provides a clean interface for ViewModels.
/// ViewModels interact with this repository instead of touching services directly.
final class ChatRepository: @unchecked Sendable {

    private let service: ChatServiceProtocol

    init(service: ChatServiceProtocol = MockChatService()) {
        self.service = service
    }

    // MARK: - Public Interface

    /// Fetches all conversations, sorted by most recent first.
    func fetchConversations() async throws -> [Conversation] {
        do {
            return try await service.fetchConversations()
        } catch let error as ChatServiceError {
            throw mapError(error)
        } catch {
            throw ChatRepositoryError.underlying(error)
        }
    }

    /// Fetches messages for a given conversation.
    func fetchMessages(conversationID: String) async throws -> [Message] {
        do {
            return try await service.fetchMessages(conversationID: conversationID)
        } catch let error as ChatServiceError {
            throw mapError(error)
        } catch {
            throw ChatRepositoryError.underlying(error)
        }
    }

    /// Sends a message.
    func sendMessage(_ message: Message) async throws {
        do {
            try await service.sendMessage(message)
        } catch let error as ChatServiceError {
            throw mapError(error)
        } catch {
            throw ChatRepositoryError.underlying(error)
        }
    }

    // MARK: - Error Mapping

    private func mapError(_ error: ChatServiceError) -> ChatRepositoryError {
        switch error {
        case .conversationNotFound:
            return .conversationNotFound
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

enum ChatRepositoryError: LocalizedError {
    case conversationNotFound
    case dataCorrupted
    case offline
    case underlying(Error)

    var errorDescription: String? {
        switch self {
        case .conversationNotFound:
            return "The conversation could not be found."
        case .dataCorrupted:
            return "The chat data appears to be corrupted."
        case .offline:
            return "You appear to be offline. Please check your connection and try again."
        case .underlying(let error):
            return error.localizedDescription
        }
    }
}
