import SwiftUI

struct ChatListRow: View {
    let conversation: Conversation

    var body: some View {
        HStack(spacing: 12) {
            AvatarView(
                url: conversation.participant.avatarURL,
                displayName: conversation.participant.displayName,
                size: 48
            )

            VStack(alignment: .leading, spacing: 4) {
                Text(conversation.participant.displayName)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundStyle(.primary)

                Text(conversation.lastMessageText)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .lineLimit(1)
            }

            Spacer()

            VStack(alignment: .trailing, spacing: 6) {
                Text(conversation.lastMessageTimestamp, style: .relative)
                    .font(.caption)
                    .foregroundStyle(.secondary)

                if conversation.unreadCount > 0 {
                    Text("\(conversation.unreadCount)")
                        .font(.caption2)
                        .fontWeight(.bold)
                        .foregroundStyle(.white)
                        .frame(minWidth: 20, minHeight: 20)
                        .background(Color.blue)
                        .clipShape(Circle())
                }
            }
        }
        .padding(.vertical, 4)
        .accessibilityLabel("Conversation with \(conversation.participant.displayName)")
    }
}

// MARK: - Preview

#Preview {
    List {
        ChatListRow(conversation: Conversation.mockConversations[0])
        ChatListRow(conversation: Conversation.mockConversations[1])
        ChatListRow(conversation: Conversation.mockConversations[2])
    }
}
