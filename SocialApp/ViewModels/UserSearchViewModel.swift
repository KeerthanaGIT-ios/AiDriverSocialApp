import Foundation
import Combine

@MainActor
final class UserSearchViewModel: ObservableObject {

    // MARK: - Published State

    @Published var searchText: String = ""
    @Published var searchResults: [User] = []
    @Published var recentSearches: [User] = []
    @Published var isSearching: Bool = false

    // MARK: - Dependencies

    private let repository: UserSearchRepository
    private var cancellables = Set<AnyCancellable>()

    init(repository: UserSearchRepository = UserSearchRepository()) {
        self.repository = repository
        observeSearchText()
    }

    // MARK: - Computed

    var showRecentSearches: Bool {
        searchText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty && !recentSearches.isEmpty
    }

    // MARK: - Actions

    func addRecentSearch(_ user: User) {
        // Remove existing occurrence to avoid duplicates
        recentSearches.removeAll { $0.id == user.id }
        // Insert at the front
        recentSearches.insert(user, at: 0)
        // Cap at 10
        if recentSearches.count > 10 {
            recentSearches = Array(recentSearches.prefix(10))
        }
    }

    func clearRecentSearches() {
        recentSearches = []
    }

    // MARK: - Private

    private func observeSearchText() {
        $searchText
            .debounce(for: .seconds(0.3), scheduler: RunLoop.main)
            .removeDuplicates()
            .sink { [weak self] query in
                guard let self else { return }
                Task {
                    await self.performSearch(query: query)
                }
            }
            .store(in: &cancellables)
    }

    private func performSearch(query: String) async {
        let trimmed = query.trimmingCharacters(in: .whitespacesAndNewlines)

        guard !trimmed.isEmpty else {
            searchResults = []
            isSearching = false
            return
        }

        isSearching = true

        do {
            searchResults = try await repository.searchUsers(query: trimmed)
        } catch {
            searchResults = []
        }

        isSearching = false
    }
}
