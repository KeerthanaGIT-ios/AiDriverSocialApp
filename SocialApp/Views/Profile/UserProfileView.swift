import SwiftUI

struct UserProfileView: View {
    let user: User

    @StateObject private var viewModel: UserProfileViewModel

    init(user: User) {
        self.user = user
        _viewModel = StateObject(wrappedValue: UserProfileViewModel(user: user))
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                ProfileHeaderView(user: user)
                    .padding(.top, 12)

                if !viewModel.isCurrentUser {
                    followButton
                }

                ProfileStatsRow(
                    postsCount: viewModel.postsCount,
                    followersCount: viewModel.followersCount,
                    followingCount: viewModel.followingCount
                )
                .padding(.horizontal)

                Divider()

                ProfilePostsGridView(posts: viewModel.posts)
            }
        }
        .navigationTitle(user.displayName)
        .navigationBarTitleDisplayMode(.inline)
        .navigationDestination(for: Post.self) { post in
            PostDetailView(
                post: post,
                onLikeToggle: { viewModel.toggleLike(on: post) }
            )
        }
        .task {
            await viewModel.loadProfile()
        }
    }

    // MARK: - Follow Button

    private var followButton: some View {
        Button {
            viewModel.toggleFollow()
        } label: {
            Text(viewModel.isFollowing ? "Following" : "Follow")
                .font(.subheadline)
                .fontWeight(.semibold)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 8)
                .foregroundStyle(viewModel.isFollowing ? .blue : .white)
                .background(
                    viewModel.isFollowing
                        ? AnyShapeStyle(.clear)
                        : AnyShapeStyle(.blue)
                )
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(.blue, lineWidth: viewModel.isFollowing ? 1 : 0)
                )
        }
        .padding(.horizontal, 32)
        .accessibilityLabel(viewModel.isFollowing ? "Unfollow" : "Follow")
    }
}

// MARK: - Preview

#Preview {
    NavigationStack {
        UserProfileView(user: .mockAlice)
    }
}
