import SwiftUI

struct MessageBubble: View {
    let message: Message

    var body: some View {
        HStack {
            if message.isFromCurrentUser {
                Spacer(minLength: 60)
            }

            VStack(alignment: message.isFromCurrentUser ? .trailing : .leading, spacing: 4) {
                Text(message.text)
                    .font(.body)
                    .foregroundStyle(message.isFromCurrentUser ? .white : .primary)
                    .padding(.horizontal, 14)
                    .padding(.vertical, 10)
                    .background(
                        message.isFromCurrentUser
                            ? Color.blue
                            : Color(.systemGray5)
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 16))

                Text(message.timestamp, style: .time)
                    .font(.caption2)
                    .foregroundStyle(.secondary)
                    .padding(.horizontal, 4)
            }

            if !message.isFromCurrentUser {
                Spacer(minLength: 60)
            }
        }
    }
}

// MARK: - Preview

#Preview {
    VStack(spacing: 12) {
        MessageBubble(
            message: Message(
                id: "1",
                conversationID: "conv-001",
                senderID: "other-user",
                text: "Hey! How's it going?",
                timestamp: Date()
            )
        )
        MessageBubble(
            message: Message(
                id: "2",
                conversationID: "conv-001",
                senderID: "current-user",
                text: "Pretty good! Just working on some SwiftUI stuff.",
                timestamp: Date()
            )
        )
    }
    .padding()
}
