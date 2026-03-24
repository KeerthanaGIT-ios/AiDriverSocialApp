import Foundation

struct User: Identifiable, Codable, Hashable {
    let id: String
    let displayName: String
    let username: String
    let avatarURL: URL?
}

// MARK: - Mock Data

extension User {
    static let mockAlice = User(
        id: "user-001",
        displayName: "Alice Johnson",
        username: "alicej",
        avatarURL: URL(string: "https://i.pravatar.cc/150?u=alice")
    )

    static let mockBob = User(
        id: "user-002",
        displayName: "Bob Smith",
        username: "bobsmith",
        avatarURL: URL(string: "https://i.pravatar.cc/150?u=bob")
    )

    static let mockCarla = User(
        id: "user-003",
        displayName: "Carla Reyes",
        username: "carlareyes",
        avatarURL: URL(string: "https://i.pravatar.cc/150?u=carla")
    )

    static let mockDave = User(
        id: "user-004",
        displayName: "Dave Kim",
        username: "davekim",
        avatarURL: nil
    )
}
