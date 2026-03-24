import Foundation

struct Post: Identifiable, Codable {
    let id: String
    let author: User
    let textContent: String
    var caption: String = ""
    let imageURL: URL?
    var likeCount: Int
    var commentCount: Int
    var isLikedByCurrentUser: Bool
    var isBookmarkedByCurrentUser: Bool = false
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
    ]
}
