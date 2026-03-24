import SwiftUI

struct ChatListView: View {
    @StateObject private var viewModel = ChatListViewModel()
    @Binding var navigationPath: NavigationPath

    var body: some View {
        NavigationStack(path: $navigationPath) {
            Group {
                if viewModel.isLoading && viewModel.conversations.isEmpty {
                    loadingView
                } else if viewModel.conversations.isEmpty {
                    emptyView
                } else {
                    conversationList
                }
            }
            .navigationTitle("Messages")
            .navigationDestination(for: Conversation.self) { conversation in
                ChatDetailView(
                    viewModel: ChatDetailViewModel(
                        conversationID: conversation.id,
                        participant: conversation.participant
                    )
                )
            }
            .task {
                await viewModel.loadConversations()
            }
        }
    }

    // MARK: - Conversation List

    private var conversationList: some View {
        List(viewModel.conversations) { conversation in
            Button {
                navigationPath.append(conversation)
            } label: {
                ChatListRow(conversation: conversation)
            }
            .listRowInsets(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
        }
        .listStyle(.plain)
        .refreshable {
            await viewModel.loadConversations()
        }
    }

    // MARK: - State Views

    private var loadingView: some View {
        VStack(spacing: 16) {
            ProgressView()
                .controlSize(.large)
            Text("Loading messages...")
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }

    private var emptyView: some View {
        ContentUnavailableView {
            Label("No Messages", systemImage: "bubble.left.and.bubble.right")
        } description: {
            Text("When you start a conversation, it will appear here.")
        }
    }
}

// MARK: - Preview

#Preview {
    ChatListView(navigationPath: .constant(NavigationPath()))
}
