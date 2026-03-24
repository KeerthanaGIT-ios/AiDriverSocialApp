import Foundation

struct Conversation: Identifiable, Codable, Hashable {
    let id: String
    let participant: User
    let lastMessageText: String
    let lastMessageTimestamp: Date
    let unreadCount: Int
}

// MARK: - Mock Data

extension Conversation {
    static let mockConversations: [Conversation] = [
        Conversation(
            id: "conv-001",
            participant: .mockAlice,
            lastMessageText: "Sounds good! I'll send you some ideas later today.",
            lastMessageTimestamp: Date().addingTimeInterval(-2800),
            unreadCount: 2
        ),
        Conversation(
            id: "conv-002",
            participant: .mockBob,
            lastMessageText: "Haha yeah, tabs forever!",
            lastMessageTimestamp: Date().addingTimeInterval(-7200),
            unreadCount: 0
        ),
        Conversation(
            id: "conv-003",
            participant: .mockCarla,
            lastMessageText: "Thanks for the feedback on my portfolio!",
            lastMessageTimestamp: Date().addingTimeInterval(-18000),
            unreadCount: 1
        ),
        Conversation(
            id: "conv-004",
            participant: .mockDave,
            lastMessageText: "See you at the coffee shop tomorrow morning.",
            lastMessageTimestamp: Date().addingTimeInterval(-86400),
            unreadCount: 0
        ),
    ]
}
