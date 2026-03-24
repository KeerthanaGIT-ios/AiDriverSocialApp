import SwiftUI

struct ChatDetailView: View {
    @ObservedObject var viewModel: ChatDetailViewModel

    var body: some View {
        VStack(spacing: 0) {
            ScrollViewReader { proxy in
                ScrollView {
                    LazyVStack(spacing: 8) {
                        ForEach(viewModel.messages) { message in
                            MessageBubble(message: message)
                                .id(message.id)
                        }
                    }
                    .padding(.horizontal, 12)
                    .padding(.vertical, 8)
                }
                .onChange(of: viewModel.messages.count) { _, _ in
                    scrollToBottom(proxy: proxy)
                }
                .onAppear {
                    scrollToBottom(proxy: proxy)
                }
            }

            MessageInputBar { text in
                viewModel.sendMessage(text: text)
            }
        }
        .navigationTitle(viewModel.participant.displayName)
        .navigationBarTitleDisplayMode(.inline)
        .task {
            await viewModel.loadMessages()
        }
    }

    private func scrollToBottom(proxy: ScrollViewProxy) {
        guard let lastMessage = viewModel.messages.last else { return }
        withAnimation(.easeOut(duration: 0.2)) {
            proxy.scrollTo(lastMessage.id, anchor: .bottom)
        }
    }
}

// MARK: - Preview

#Preview {
    NavigationStack {
        ChatDetailView(
            viewModel: ChatDetailViewModel(
                conversationID: "conv-001",
                participant: .mockAlice
            )
        )
    }
}
