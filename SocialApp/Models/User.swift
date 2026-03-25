import Foundation

struct User: Identifiable, Codable, Hashable {
    let id: String
    let displayName: String
    let username: String
    let avatarURL: URL?
    var bio: String? = nil
    var followersCount: Int = 0
    var followingCount: Int = 0
}

// MARK: - Mock Data

extension User {
    static let mockAlice = User(
        id: "user-001",
        displayName: "Alice Johnson",
        username: "alicej",
        avatarURL: URL(string: "https://i.pravatar.cc/150?u=alice"),
        bio: "iOS developer & nature lover. Building apps that make a difference.",
        followersCount: 1240,
        followingCount: 328
    )

    static let mockBob = User(
        id: "user-002",
        displayName: "Bob Smith",
        username: "bobsmith",
        avatarURL: URL(string: "https://i.pravatar.cc/150?u=bob"),
        bio: "Tabs over spaces. Full-stack engineer. Coffee enthusiast.",
        followersCount: 892,
        followingCount: 415
    )

    static let mockCarla = User(
        id: "user-003",
        displayName: "Carla Reyes",
        username: "carlareyes",
        avatarURL: URL(string: "https://i.pravatar.cc/150?u=carla"),
        bio: "UX designer & front-end dev. Pixel perfectionist.",
        followersCount: 2100,
        followingCount: 189
    )

    static let mockDave = User(
        id: "user-004",
        displayName: "Dave Kim",
        username: "davekim",
        avatarURL: nil,
        bio: "Simple living. Good coffee. Great code.",
        followersCount: 340,
        followingCount: 122
    )

    static let mockEva = User(
        id: "user-005",
        displayName: "Eva Chen",
        username: "evachen",
        avatarURL: URL(string: "https://i.pravatar.cc/150?u=eva"),
        bio: "Product manager by day, photographer by night.",
        followersCount: 3500,
        followingCount: 275
    )

    static let mockFrank = User(
        id: "user-006",
        displayName: "Frank Torres",
        username: "frankt",
        avatarURL: URL(string: "https://i.pravatar.cc/150?u=frank"),
        bio: "Backend engineer. Rust advocate. Open source contributor.",
        followersCount: 670,
        followingCount: 310
    )

    static let mockGrace = User(
        id: "user-007",
        displayName: "Grace Liu",
        username: "graceliu",
        avatarURL: URL(string: "https://i.pravatar.cc/150?u=grace"),
        bio: "Machine learning researcher. Tea connoisseur.",
        followersCount: 1890,
        followingCount: 445
    )

    static let mockHenry = User(
        id: "user-008",
        displayName: "Henry Park",
        username: "henryp",
        avatarURL: URL(string: "https://i.pravatar.cc/150?u=henry"),
        bio: "DevOps & cloud infrastructure. Always automating.",
        followersCount: 520,
        followingCount: 198
    )

    static let mockIvy = User(
        id: "user-009",
        displayName: "Ivy Morgan",
        username: "ivymorgan",
        avatarURL: URL(string: "https://i.pravatar.cc/150?u=ivy"),
        bio: "Data scientist exploring the world one dataset at a time.",
        followersCount: 1450,
        followingCount: 367
    )

    static let mockJack = User(
        id: "user-010",
        displayName: "Jack Wilson",
        username: "jackw",
        avatarURL: URL(string: "https://i.pravatar.cc/150?u=jack"),
        bio: "Mobile developer. Android & iOS. Love cross-platform.",
        followersCount: 780,
        followingCount: 290
    )

    static let mockKate = User(
        id: "user-011",
        displayName: "Kate Rivera",
        username: "katerivera",
        avatarURL: URL(string: "https://i.pravatar.cc/150?u=kate"),
        bio: "Security engineer. CTF player. Always learning.",
        followersCount: 2300,
        followingCount: 156
    )

    static let mockLeo = User(
        id: "user-012",
        displayName: "Leo Zhang",
        username: "leozhang",
        avatarURL: nil,
        bio: "Game developer & 3D artist. Building immersive worlds.",
        followersCount: 430,
        followingCount: 211
    )

    /// The current logged-in user (Alice).
    static let currentUser = User.mockAlice

    static let mockAllUsers: [User] = [
        .mockAlice, .mockBob, .mockCarla, .mockDave,
        .mockEva, .mockFrank, .mockGrace, .mockHenry,
        .mockIvy, .mockJack, .mockKate, .mockLeo
    ]
}
