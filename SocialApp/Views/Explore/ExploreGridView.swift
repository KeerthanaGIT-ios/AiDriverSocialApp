import SwiftUI

struct ExploreGridView: View {
    let gridItems: [ExploreGridItem]

    var body: some View {
        ScrollView {
            LazyVStack(spacing: 1) {
                ForEach(Array(chunkedGroups.enumerated()), id: \.offset) { index, group in
                    let patternIndex = index % 4

                    switch patternIndex {
                    case 0:
                        ExploreSmallRow(items: group)
                    case 1:
                        ExplorePatternARow(items: group)
                    case 2:
                        ExploreSmallRow(items: group)
                    case 3:
                        ExplorePatternBRow(items: group)
                    default:
                        ExploreSmallRow(items: group)
                    }
                }
            }
        }
    }

    // MARK: - Chunk items into groups of 3

    private var chunkedGroups: [[ExploreGridItem]] {
        stride(from: 0, to: gridItems.count, by: 3).map { startIndex in
            let endIndex = min(startIndex + 3, gridItems.count)
            return Array(gridItems[startIndex..<endIndex])
        }
    }
}

// MARK: - Preview

#Preview {
    NavigationStack {
        ExploreGridView(
            gridItems: Post.mockPosts.enumerated().map { index, post in
                ExploreGridItem(id: post.id, post: post, isFeatured: index % 6 == 0)
            }
        )
    }
}
