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
            author: .mockEva,
            textContent: "Sunset from my balcony tonight was unreal.",
            imageURL: URL(string: "https://picsum.photos/400?random=6"),
            likeCount: 112,
            commentCount: 15,
            isLikedByCurrentUser: false,
            createdAt: Date().addingTimeInterval(-5400)
        ),
        Post(
            id: "post-007",
            author: .mockFrank,
            textContent: "Finally nailed that sourdough recipe after 10 attempts.",
            imageURL: URL(string: "https://picsum.photos/400?random=7"),
            likeCount: 74,
            commentCount: 9,
            isLikedByCurrentUser: true,
            createdAt: Date().addingTimeInterval(-10800)
        ),
        Post(
            id: "post-008",
            author: .mockGrace,
            textContent: "Street photography walk through downtown. Found some gems.",
            imageURL: URL(string: "https://picsum.photos/400?random=8"),
            likeCount: 203,
            commentCount: 28,
            isLikedByCurrentUser: false,
            createdAt: Date().addingTimeInterval(-14400)
        ),
        Post(
            id: "post-009",
            author: .mockHenry,
            textContent: "New personal record at the gym today! Consistency pays off.",
            imageURL: URL(string: "https://picsum.photos/400?random=9"),
            likeCount: 56,
            commentCount: 8,
            isLikedByCurrentUser: false,
            createdAt: Date().addingTimeInterval(-21600)
        ),
        Post(
            id: "post-010",
            author: .mockIvy,
            textContent: "My watercolor painting from this weekend's art class.",
            imageURL: URL(string: "https://picsum.photos/400?random=10"),
            likeCount: 145,
            commentCount: 19,
            isLikedByCurrentUser: true,
            createdAt: Date().addingTimeInterval(-28800)
        ),
        Post(
            id: "post-011",
            author: .mockJack,
            textContent: "Road trip through the Pacific Coast Highway. Every turn is a postcard.",
            imageURL: URL(string: "https://picsum.photos/400?random=11"),
            likeCount: 287,
            commentCount: 34,
            isLikedByCurrentUser: false,
            createdAt: Date().addingTimeInterval(-36000)
        ),
        Post(
            id: "post-012",
            author: .mockKate,
            textContent: "Homemade pasta night with friends. Nothing beats fresh tagliatelle.",
            imageURL: URL(string: "https://picsum.photos/400?random=12"),
            likeCount: 93,
            commentCount: 11,
            isLikedByCurrentUser: false,
            createdAt: Date().addingTimeInterval(-43200)
        ),
        Post(
            id: "post-013",
            author: .mockLeo,
            textContent: "Late night coding session. This new feature is coming together nicely.",
            imageURL: URL(string: "https://picsum.photos/400?random=13"),
            likeCount: 38,
            commentCount: 5,
            isLikedByCurrentUser: true,
            createdAt: Date().addingTimeInterval(-50400)
        ),
        Post(
            id: "post-014",
            author: .mockBob,
            textContent: "Visited the botanical gardens today. Spring blooms are incredible.",
            imageURL: URL(string: "https://picsum.photos/400?random=14"),
            likeCount: 167,
            commentCount: 22,
            isLikedByCurrentUser: false,
            createdAt: Date().addingTimeInterval(-57600)
        ),
        Post(
            id: "post-015",
            author: .mockCarla,
            textContent: "Beach day with the crew. Perfect weather.",
            imageURL: URL(string: "https://picsum.photos/400?random=15"),
            likeCount: 211,
            commentCount: 31,
            isLikedByCurrentUser: true,
            createdAt: Date().addingTimeInterval(-64800)
        ),
        Post(
            id: "post-016",
            author: .mockDave,
            textContent: "Trying out film photography for the first time. Love the grain.",
            imageURL: URL(string: "https://picsum.photos/400?random=16"),
            likeCount: 78,
            commentCount: 13,
            isLikedByCurrentUser: false,
            createdAt: Date().addingTimeInterval(-72000)
        ),
        Post(
            id: "post-017",
            author: .mockEva,
            textContent: "Weekend farmers market haul. So many fresh veggies!",
            imageURL: URL(string: "https://picsum.photos/400?random=17"),
            likeCount: 64,
            commentCount: 7,
            isLikedByCurrentUser: false,
            createdAt: Date().addingTimeInterval(-79200)
        ),
        Post(
            id: "post-018",
            author: .mockGrace,
            textContent: "City lights from the rooftop. This view never gets old.",
            imageURL: URL(string: "https://picsum.photos/400?random=18"),
            likeCount: 324,
            commentCount: 42,
            isLikedByCurrentUser: true,
            createdAt: Date().addingTimeInterval(-86400)
        ),
        Post(
            id: "post-019",
            author: .mockHenry,
            textContent: "Morning run through the park. Best way to start the day.",
            imageURL: URL(string: "https://picsum.photos/400?random=19"),
            likeCount: 49,
            commentCount: 6,
            isLikedByCurrentUser: false,
            createdAt: Date().addingTimeInterval(-93600)
        ),
        Post(
            id: "post-020",
            author: .mockAlice,
            textContent: "Adopted this little guy today. Meet Pixel!",
            imageURL: URL(string: "https://picsum.photos/400?random=20"),
            likeCount: 456,
            commentCount: 67,
            isLikedByCurrentUser: true,
            createdAt: Date().addingTimeInterval(-100800)
        ),
    ]
}
