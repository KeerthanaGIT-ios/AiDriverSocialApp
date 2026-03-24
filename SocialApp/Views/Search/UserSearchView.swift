import SwiftUI

struct UserSearchView: View {
    @StateObject private var viewModel = UserSearchViewModel()

    var body: some View {
        NavigationStack {
            Group {
                if viewModel.isSearching {
                    ProgressView()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else if viewModel.showRecentSearches {
                    recentSearchesList
                } else if !viewModel.searchText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty && !viewModel.searchResults.isEmpty {
                    searchResultsList
                } else if !viewModel.searchText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty && viewModel.searchResults.isEmpty {
                    ContentUnavailableView(
                        "No users found",
                        systemImage: "person.slash",
                        description: Text("Try a different search term.")
                    )
                } else {
                    ContentUnavailableView(
                        "Search Users",
                        systemImage: "magnifyingglass",
                        description: Text("Find people by name or username.")
                    )
                }
            }
            .navigationTitle("Explore")
            .searchable(text: $viewModel.searchText, prompt: "Search users...")
            .navigationDestination(for: User.self) { user in
                UserProfileView(user: user)
            }
        }
    }

    // MARK: - Recent Searches

    private var recentSearchesList: some View {
        List {
            RecentSearchesSection(
                users: viewModel.recentSearches,
                onTap: { user in
                    viewModel.addRecentSearch(user)
                },
                onClear: {
                    viewModel.clearRecentSearches()
                }
            )
        }
        .listStyle(.plain)
    }

    // MARK: - Search Results

    private var searchResultsList: some View {
        List(viewModel.searchResults) { user in
            NavigationLink(value: user) {
                UserSearchRow(user: user)
            }
            .simultaneousGesture(TapGesture().onEnded {
                viewModel.addRecentSearch(user)
            })
        }
        .listStyle(.plain)
    }
}

// MARK: - Preview

#Preview {
    UserSearchView()
}
