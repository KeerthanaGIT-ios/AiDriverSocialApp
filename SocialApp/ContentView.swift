import SwiftUI

struct ContentView: View {

    @State private var selectedTab: Tab = .feed
    @State private var chatNavigationPath = NavigationPath()
    @StateObject private var feedViewModel = FeedViewModel()
    @StateObject private var createPostViewModel = CreatePostViewModel()

    enum Tab: String, CaseIterable {
        case feed, search, create, chat, profile
    }

    private var isInChatDetail: Bool {
        !chatNavigationPath.isEmpty
    }

    var body: some View {
        ZStack(alignment: .bottom) {
            // Content
            Group {
                switch selectedTab {
                case .feed:
                    NavigationStack { FeedView(viewModel: feedViewModel) }
                case .search:
                    UserSearchView()
                case .create:
                    CreatePostView(viewModel: createPostViewModel, feedViewModel: feedViewModel)
                case .chat:
                    ChatListView(navigationPath: $chatNavigationPath)
                case .profile:
                    NavigationStack {
                        Text("Profile")
                            .font(.title2)
                            .foregroundStyle(.secondary)
                            .navigationTitle("Profile")
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding(.bottom, isInChatDetail ? 0 : 72)

            // Premium Tab Bar — hidden in chat detail
            if !isInChatDetail {
                premiumTabBar
            }
        }
        .onChange(of: createPostViewModel.didFinishPosting) { _, finished in
            if finished {
                selectedTab = .feed
                createPostViewModel.reset()
            }
        }
    }

    // MARK: - Premium Tab Bar

    private var premiumTabBar: some View {
        HStack(spacing: 0) {
            ForEach(Tab.allCases, id: \.self) { tab in
                tabButton(for: tab)
            }
        }
        .padding(.horizontal, 8)
        .padding(.top, 12)
        .padding(.bottom, 28)
        .background(
            Rectangle()
                .fill(.ultraThinMaterial)
                .overlay(
                    Rectangle()
                        .fill(
                            LinearGradient(
                                colors: [
                                    Color(.systemBackground).opacity(0.8),
                                    Color(.systemBackground).opacity(0.6)
                                ],
                                startPoint: .bottom,
                                endPoint: .top
                            )
                        )
                )
                .overlay(alignment: .top) {
                    Divider().opacity(0.3)
                }
                .ignoresSafeArea()
        )
    }

    private func tabButton(for tab: Tab) -> some View {
        Button {
            withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                selectedTab = tab
            }
        } label: {
            VStack(spacing: 4) {
                if tab == .create {
                    // Special create button
                    ZStack {
                        RoundedRectangle(cornerRadius: 12)
                            .fill(
                                LinearGradient(
                                    colors: [.purple, .pink, .orange],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                            )
                            .frame(width: 40, height: 32)
                            .shadow(color: .purple.opacity(0.4), radius: 8, y: 4)

                        Image(systemName: "plus")
                            .font(.system(size: 16, weight: .bold))
                            .foregroundStyle(.white)
                    }
                } else {
                    Image(systemName: iconName(for: tab))
                        .font(.system(size: 22, weight: selectedTab == tab ? .semibold : .regular))
                        .symbolEffect(.bounce, value: selectedTab == tab)
                        .foregroundStyle(
                            selectedTab == tab
                                ? AnyShapeStyle(
                                    LinearGradient(
                                        colors: [.purple, .pink],
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    )
                                )
                                : AnyShapeStyle(Color(.systemGray))
                        )
                        .frame(height: 32)
                }

                // Label
                Text(tabLabel(for: tab))
                    .font(.system(size: 10, weight: selectedTab == tab ? .semibold : .regular))
                    .foregroundStyle(
                        selectedTab == tab ? Color.primary : Color(.systemGray)
                    )
            }
            .frame(maxWidth: .infinity)
        }
        .buttonStyle(.plain)
    }

    // MARK: - Helpers

    private func iconName(for tab: Tab) -> String {
        switch tab {
        case .feed: return selectedTab == tab ? "house.fill" : "house"
        case .search: return selectedTab == tab ? "magnifyingglass.circle.fill" : "magnifyingglass"
        case .create: return "plus"
        case .chat: return selectedTab == tab ? "bubble.left.and.bubble.right.fill" : "bubble.left.and.bubble.right"
        case .profile: return selectedTab == tab ? "person.fill" : "person"
        }
    }

    private func tabLabel(for tab: Tab) -> String {
        switch tab {
        case .feed: return "Home"
        case .search: return "Explore"
        case .create: return "Create"
        case .chat: return "Chat"
        case .profile: return "Profile"
        }
    }
}

#Preview {
    ContentView()
}
