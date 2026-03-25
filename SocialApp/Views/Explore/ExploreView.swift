import SwiftUI

struct ExploreView: View {
    @StateObject private var exploreViewModel = ExploreViewModel()
    @StateObject private var searchViewModel = UserSearchViewModel()

    var body: some View {
        NavigationStack {
            Group {
                if !searchViewModel.searchText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                    // Search mode: show user search results
                    searchContent
                } else if searchViewModel.showRecentSearches {
                    // Show recent searches when search bar is focused with no query
                    recentSearchesList
                } else {
                    // Default: show explore grid
                    exploreContent
                }
            }
            .navigationTitle("Explore")
            .searchable(text: $searchViewModel.searchText, prompt: "Search")
            .navigationDestination(for: User.self) { user in
                UserProfileView(user: user)
            }
            .navigationDestination(for: Post.self) { post in
                PostDetailView(post: post)
            }
            .task {
                await exploreViewModel.loadExplorePosts()
            }
        }
    }

    // MARK: - Explore Grid Content

    @ViewBuilder
    private var exploreContent: some View {
        if exploreViewModel.isLoading {
            ProgressView()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        } else {
            ExploreGridView(gridItems: exploreViewModel.gridItems)
        }
    }

    // MARK: - Search Content

    @ViewBuilder
    private var searchContent: some View {
        if searchViewModel.isSearching {
            ProgressView()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        } else if !searchViewModel.searchResults.isEmpty {
            List(searchViewModel.searchResults) { user in
                NavigationLink(value: user) {
                    UserSearchRow(user: user)
                }
                .simultaneousGesture(TapGesture().onEnded {
                    searchViewModel.addRecentSearch(user)
                })
            }
            .listStyle(.plain)
        } else {
            ContentUnavailableView(
                "No users found",
                systemImage: "person.slash",
                description: Text("Try a different search term.")
            )
        }
    }

    // MARK: - Recent Searches

    private var recentSearchesList: some View {
        List {
            RecentSearchesSection(
                users: searchViewModel.recentSearches,
                onTap: { user in
                    searchViewModel.addRecentSearch(user)
                },
                onClear: {
                    searchViewModel.clearRecentSearches()
                }
            )
        }
        .listStyle(.plain)
    }
}

// MARK: - Preview

#Preview {
    ExploreView()
}
