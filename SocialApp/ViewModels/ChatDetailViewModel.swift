import Foundation

@MainActor
final class ChatDetailViewModel: ObservableObject {

    // MARK: - Published State

    @Published var messages: [Message] = []
    @Published var isLoading: Bool = false
    @Published var error: String?

    // MARK: - Properties

    let conversationID: String
    let participant: User

    // MARK: - Dependencies

    private let repository: ChatRepository

    init(
        conversationID: String,
        participant: User,
        repository: ChatRepository = ChatRepository()
    ) {
        self.conversationID = conversationID
        self.participant = participant
        self.repository = repository
    }

    // MARK: - Actions

    func loadMessages() async {
        isLoading = true
        error = nil

        do {
            messages = try await repository.fetchMessages(conversationID: conversationID)
        } catch {
            self.error = error.localizedDescription
        }

        isLoading = false
    }

    func sendMessage(text: String) {
        let trimmed = text.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return }

        let message = Message(
            id: UUID().uuidString,
            conversationID: conversationID,
            senderID: "current-user",
            text: trimmed,
            timestamp: Date()
        )

        // Optimistic local append
        messages.append(message)

        // Fire-and-forget to repository
        Task {
            do {
                try await repository.sendMessage(message)
            } catch {
                self.error = error.localizedDescription
            }
        }
    }
}
