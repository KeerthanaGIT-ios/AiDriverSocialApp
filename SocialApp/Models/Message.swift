import Foundation

struct Message: Identifiable, Codable {
    let id: String
    let conversationID: String
    let senderID: String
    let text: String
    let timestamp: Date

    var isFromCurrentUser: Bool {
        senderID == "current-user"
    }
}

// MARK: - Mock Data

extension Message {
    static func mockMessages(for conversationID: String) -> [Message] {
        let now = Date()
        return [
            Message(
                id: "\(conversationID)-msg-001",
                conversationID: conversationID,
                senderID: "other-user",
                text: "Hey! How's it going?",
                timestamp: now.addingTimeInterval(-3600)
            ),
            Message(
                id: "\(conversationID)-msg-002",
                conversationID: conversationID,
                senderID: "current-user",
                text: "Pretty good! Just finished that SwiftUI project I was telling you about.",
                timestamp: now.addingTimeInterval(-3500)
            ),
            Message(
                id: "\(conversationID)-msg-003",
                conversationID: conversationID,
                senderID: "other-user",
                text: "Oh nice, the social app? How did it turn out?",
                timestamp: now.addingTimeInterval(-3400)
            ),
            Message(
                id: "\(conversationID)-msg-004",
                conversationID: conversationID,
                senderID: "current-user",
                text: "Really well actually. The feed is working smoothly with async/await.",
                timestamp: now.addingTimeInterval(-3300)
            ),
            Message(
                id: "\(conversationID)-msg-005",
                conversationID: conversationID,
                senderID: "other-user",
                text: "That's awesome. Are you using MVVM?",
                timestamp: now.addingTimeInterval(-3200)
            ),
            Message(
                id: "\(conversationID)-msg-006",
                conversationID: conversationID,
                senderID: "current-user",
                text: "Yep, strict MVVM with repositories and services. Keeps everything clean.",
                timestamp: now.addingTimeInterval(-3100)
            ),
            Message(
                id: "\(conversationID)-msg-007",
                conversationID: conversationID,
                senderID: "other-user",
                text: "Love that pattern. We should pair on something together sometime.",
                timestamp: now.addingTimeInterval(-3000)
            ),
            Message(
                id: "\(conversationID)-msg-008",
                conversationID: conversationID,
                senderID: "current-user",
                text: "Definitely! Let's plan something for next week.",
                timestamp: now.addingTimeInterval(-2900)
            ),
            Message(
                id: "\(conversationID)-msg-009",
                conversationID: conversationID,
                senderID: "other-user",
                text: "Sounds good! I'll send you some ideas later today.",
                timestamp: now.addingTimeInterval(-2800)
            ),
            Message(
                id: "\(conversationID)-msg-010",
                conversationID: conversationID,
                senderID: "current-user",
                text: "Perfect, talk soon!",
                timestamp: now.addingTimeInterval(-2700)
            ),
        ]
    }
}
