import Foundation

struct Story: Identifiable, Hashable {
    let id: String
    let user: User
    let hasUnseenStory: Bool
    let thumbnailURL: URL?
}

// MARK: - Mock Data

extension Story {
    static let mockStories: [Story] = User.mockAllUsers
        .filter { $0.id != User.currentUser.id }
        .enumerated()
        .map { index, user in
            Story(
                id: "story-\(user.id)",
                user: user,
                hasUnseenStory: index % 2 == 0, // alternating seen/unseen
                thumbnailURL: user.avatarURL
            )
        }
}
