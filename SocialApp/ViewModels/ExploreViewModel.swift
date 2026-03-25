import Foundation

@MainActor
final class ExploreViewModel: ObservableObject {

    // MARK: - Published State

    @Published var gridItems: [ExploreGridItem] = []
    @Published var isLoading: Bool = false

    // MARK: - Dependencies

    private let repository: ExploreRepository

    init(repository: ExploreRepository = ExploreRepository()) {
        self.repository = repository
    }

    // MARK: - Actions

    func loadExplorePosts() async {
        isLoading = true

        do {
            let posts = try await repository.fetchExplorePosts()
            gridItems = posts.enumerated().map { index, post in
                ExploreGridItem(
                    id: post.id,
                    post: post,
                    isFeatured: index % 6 == 0
                )
            }
        } catch {
            gridItems = []
        }

        isLoading = false
    }
}
