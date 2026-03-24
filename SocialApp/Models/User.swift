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

    static let mockEva = User(
        id: "user-005",
        displayName: "Eva Chen",
        username: "evachen",
        avatarURL: URL(string: "https://i.pravatar.cc/150?u=eva")
    )

    static let mockFrank = User(
        id: "user-006",
        displayName: "Frank Torres",
        username: "frankt",
        avatarURL: URL(string: "https://i.pravatar.cc/150?u=frank")
    )

    static let mockGrace = User(
        id: "user-007",
        displayName: "Grace Liu",
        username: "graceliu",
        avatarURL: URL(string: "https://i.pravatar.cc/150?u=grace")
    )

    static let mockHenry = User(
        id: "user-008",
        displayName: "Henry Park",
        username: "henryp",
        avatarURL: URL(string: "https://i.pravatar.cc/150?u=henry")
    )

    static let mockIvy = User(
        id: "user-009",
        displayName: "Ivy Morgan",
        username: "ivymorgan",
        avatarURL: URL(string: "https://i.pravatar.cc/150?u=ivy")
    )

    static let mockJack = User(
        id: "user-010",
        displayName: "Jack Wilson",
        username: "jackw",
        avatarURL: URL(string: "https://i.pravatar.cc/150?u=jack")
    )

    static let mockKate = User(
        id: "user-011",
        displayName: "Kate Rivera",
        username: "katerivera",
        avatarURL: URL(string: "https://i.pravatar.cc/150?u=kate")
    )

    static let mockLeo = User(
        id: "user-012",
        displayName: "Leo Zhang",
        username: "leozhang",
        avatarURL: nil
    )

    static let mockAllUsers: [User] = [
        .mockAlice, .mockBob, .mockCarla, .mockDave,
        .mockEva, .mockFrank, .mockGrace, .mockHenry,
        .mockIvy, .mockJack, .mockKate, .mockLeo
    ]
}
