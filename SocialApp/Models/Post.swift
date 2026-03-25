import Foundation

struct Post: Identifiable, Codable, Hashable {
    let id: String
    let author: User
    let textContent: String
    let imageURL: URL?
    var likeCount: Int
    var commentCount: Int
    var isLikedByCurrentUser: Bool
    let createdAt: Date
}

// MARK: - Mock Data

extension Post {
    static let mockPosts: [Post] = [
        Post(
            id: "post-001",
            author: .mockAlice,
            textContent: "Just wrapped up an amazing hike through the redwoods. Nature really puts things in perspective.",
            imageURL: URL(string: "https://picsum.photos/seed/hike/600/400"),
            likeCount: 42,
            commentCount: 7,
            isLikedByCurrentUser: false,
            createdAt: Date().addingTimeInterval(-3600)
        ),
        Post(
            id: "post-002",
            author: .mockBob,
            textContent: "Hot take: tabs are better than spaces. Fight me.",
            imageURL: nil,
            likeCount: 128,
            commentCount: 53,
            isLikedByCurrentUser: true,
            createdAt: Date().addingTimeInterval(-7200)
        ),
        Post(
            id: "post-003",
            author: .mockCarla,
            textContent: "Launched my new portfolio site today! Months of work finally paying off. Link in bio.",
            imageURL: URL(string: "https://picsum.photos/seed/portfolio/600/400"),
            likeCount: 89,
            commentCount: 12,
            isLikedByCurrentUser: false,
            createdAt: Date().addingTimeInterval(-18000)
        ),
        Post(
            id: "post-004",
            author: .mockDave,
            textContent: "Morning coffee and a good book. Simple pleasures.",
            imageURL: URL(string: "https://picsum.photos/seed/coffee/600/400"),
            likeCount: 31,
            commentCount: 4,
            isLikedByCurrentUser: true,
            createdAt: Date().addingTimeInterval(-86400)
        ),
        Post(
            id: "post-005",
            author: .mockAlice,
            textContent: "Anyone else excited about WWDC this year? I have a feeling we are getting some huge SwiftUI updates.",
            imageURL: nil,
            likeCount: 67,
            commentCount: 21,
            isLikedByCurrentUser: false,
            createdAt: Date().addingTimeInterval(-172800)
        ),
        Post(
            id: "post-006",
            author: .mockAlice,
            textContent: "Golden hour at the beach. Sometimes you just need to unplug.",
            imageURL: URL(string: "https://picsum.photos/400?random=1"),
            likeCount: 95,
            commentCount: 14,
            isLikedByCurrentUser: true,
            createdAt: Date().addingTimeInterval(-259200)
        ),
        Post(
            id: "post-007",
            author: .mockAlice,
            textContent: "New desk setup is finally complete! Productivity mode activated.",
            imageURL: URL(string: "https://picsum.photos/400?random=2"),
            likeCount: 73,
            commentCount: 9,
            isLikedByCurrentUser: false,
            createdAt: Date().addingTimeInterval(-345600)
        ),
        Post(
            id: "post-008",
            author: .mockEva,
            textContent: "Street photography walk through downtown. Found some incredible light.",
            imageURL: URL(string: "https://picsum.photos/400?random=3"),
            likeCount: 112,
            commentCount: 18,
            isLikedByCurrentUser: false,
            createdAt: Date().addingTimeInterval(-432000)
        ),
        Post(
            id: "post-009",
            author: .mockAlice,
            textContent: "Just shipped v2.0 of my app! Huge thanks to everyone who beta tested.",
            imageURL: URL(string: "https://picsum.photos/400?random=4"),
            likeCount: 201,
            commentCount: 34,
            isLikedByCurrentUser: true,
            createdAt: Date().addingTimeInterval(-518400)
        ),
        Post(
            id: "post-010",
            author: .mockGrace,
            textContent: "Training my first neural network from scratch. The loss curve is beautiful.",
            imageURL: URL(string: "https://picsum.photos/400?random=5"),
            likeCount: 88,
            commentCount: 11,
            isLikedByCurrentUser: false,
            createdAt: Date().addingTimeInterval(-604800)
        ),
        Post(
            id: "post-011",
            author: .mockAlice,
            textContent: "Rainy day coding session with some lo-fi beats. Pure bliss.",
            imageURL: URL(string: "https://picsum.photos/400?random=6"),
            likeCount: 54,
            commentCount: 6,
            isLikedByCurrentUser: false,
            createdAt: Date().addingTimeInterval(-691200)
        ),
        Post(
            id: "post-012",
            author: .mockBob,
            textContent: "Finally tried that new ramen place downtown. 10/10 would recommend.",
            imageURL: URL(string: "https://picsum.photos/400?random=7"),
            likeCount: 76,
            commentCount: 15,
            isLikedByCurrentUser: true,
            createdAt: Date().addingTimeInterval(-777600)
        ),
    ]
}
