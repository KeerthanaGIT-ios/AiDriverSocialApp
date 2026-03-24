import Foundation

// MARK: - Protocol

protocol ChatServiceProtocol {
    func fetchConversations() async throws -> [Conversation]
    func fetchMessages(conversationID: String) async throws -> [Message]
    func sendMessage(_ message: Message) async throws
}

// MARK: - Errors

enum ChatServiceError: LocalizedError {
    case conversationNotFound
    case decodingFailed
    case networkUnavailable
    case unknown(Error)

    var errorDescription: String? {
        switch self {
        case .conversationNotFound:
            return "Conversation not found."
        case .decodingFailed:
            return "Failed to decode chat data."
        case .networkUnavailable:
            return "Network is unavailable. Please check your connection."
        case .unknown(let error):
            return error.localizedDescription
        }
    }
}

// MARK: - Mock Implementation

final class MockChatService: ChatServiceProtocol {

    private var conversations: [Conversation] = Conversation.mockConversations
    private var messagesByConversation: [String: [Message]] = [:]

    init() {
        // Pre-populate mock messages for each conversation
        for conversation in conversations {
            messagesByConversation[conversation.id] = Message.mockMessages(for: conversation.id)
        }
    }

    func fetchConversations() async throws -> [Conversation] {
        try? await Task.sleep(for: .milliseconds(200))
        return conversations.sorted { $0.lastMessageTimestamp > $1.lastMessageTimestamp }
    }

    func fetchMessages(conversationID: String) async throws -> [Message] {
        try? await Task.sleep(for: .milliseconds(200))
        guard let messages = messagesByConversation[conversationID] else {
            throw ChatServiceError.conversationNotFound
        }
        return messages.sorted { $0.timestamp < $1.timestamp }
    }

    func sendMessage(_ message: Message) async throws {
        try? await Task.sleep(for: .milliseconds(200))
        var messages = messagesByConversation[message.conversationID] ?? []
        messages.append(message)
        messagesByConversation[message.conversationID] = messages

        // Update conversation's last message
        if let index = conversations.firstIndex(where: { $0.id == message.conversationID }) {
            let existing = conversations[index]
            conversations[index] = Conversation(
                id: existing.id,
                participant: existing.participant,
                lastMessageText: message.text,
                lastMessageTimestamp: message.timestamp,
                unreadCount: existing.unreadCount
            )
        }
    }
}
