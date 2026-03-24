import SwiftUI

struct StoriesBarView: View {
    let stories: [Story]

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 12) {
                // Current user's story (always first)
                StoryItemView(
                    user: .currentUser,
                    hasUnseenStory: false,
                    isCurrentUser: true,
                    onTap: { /* TODO: open camera / story creator */ }
                )

                // Other users' stories
                ForEach(stories) { story in
                    StoryItemView(
                        user: story.user,
                        hasUnseenStory: story.hasUnseenStory,
                        isCurrentUser: false,
                        onTap: { /* TODO: open story viewer */ }
                    )
                }
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
        }
    }
}

// MARK: - Preview

#Preview {
    StoriesBarView(stories: Story.mockStories)
}
