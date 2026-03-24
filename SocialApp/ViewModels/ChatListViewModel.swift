import Foundation

@MainActor
final class ChatListViewModel: ObservableObject {

    // MARK: - Published State

    @Published var conversations: [Conversation] = []
    @Published var isLoading: Bool = false
    @Published var error: String?

    // MARK: - Dependencies

    private let repository: ChatRepository

    init(repository: ChatRepository = ChatRepository()) {
        self.repository = repository
    }

    // MARK: - Actions

    func loadConversations() async {
        isLoading = true
        error = nil

        do {
            conversations = try await repository.fetchConversations()
        } catch {
            self.error = error.localizedDescription
        }

        isLoading = false
    }
}
