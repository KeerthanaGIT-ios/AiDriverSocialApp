import SwiftUI

private let gridSpacing: CGFloat = 1

// MARK: - Row of 3 Small Squares

struct ExploreSmallRow: View {
    let items: [ExploreGridItem]

    var body: some View {
        GeometryReader { geo in
            let cellSize = (geo.size.width - gridSpacing * CGFloat(items.count - 1)) / CGFloat(max(items.count, 1))

            HStack(spacing: gridSpacing) {
                ForEach(items) { item in
                    NavigationLink(value: item.post) {
                        ExploreGridCell(post: item.post)
                            .frame(width: cellSize, height: cellSize)
                    }
                    .buttonStyle(.plain)
                }
            }
        }
        .frame(height: cellHeight(columns: max(items.count, 3)))
    }

    private func cellHeight(columns: Int) -> CGFloat {
        (UIScreen.main.bounds.width - gridSpacing * CGFloat(columns - 1)) / CGFloat(columns)
    }
}

// MARK: - Pattern A: Large Left + 2 Small Right

struct ExplorePatternARow: View {
    let items: [ExploreGridItem]

    var body: some View {
        let totalWidth = UIScreen.main.bounds.width
        let smallSize = (totalWidth - gridSpacing * 2) / 3
        let largeSize = smallSize * 2 + gridSpacing

        HStack(spacing: gridSpacing) {
            // Large cell on left
            if items.count > 0 {
                NavigationLink(value: items[0].post) {
                    ExploreGridCell(post: items[0].post)
                        .frame(width: largeSize, height: largeSize)
                }
                .buttonStyle(.plain)
            }

            // 2 small cells stacked on right
            VStack(spacing: gridSpacing) {
                if items.count > 1 {
                    NavigationLink(value: items[1].post) {
                        ExploreGridCell(post: items[1].post)
                            .frame(width: smallSize, height: smallSize)
                    }
                    .buttonStyle(.plain)
                }
                if items.count > 2 {
                    NavigationLink(value: items[2].post) {
                        ExploreGridCell(post: items[2].post)
                            .frame(width: smallSize, height: smallSize)
                    }
                    .buttonStyle(.plain)
                }
            }
        }
        .frame(width: totalWidth, height: largeSize)
    }
}

// MARK: - Pattern B: 2 Small Left + Large Right

struct ExplorePatternBRow: View {
    let items: [ExploreGridItem]

    var body: some View {
        let totalWidth = UIScreen.main.bounds.width
        let smallSize = (totalWidth - gridSpacing * 2) / 3
        let largeSize = smallSize * 2 + gridSpacing

        HStack(spacing: gridSpacing) {
            // 2 small cells stacked on left
            VStack(spacing: gridSpacing) {
                if items.count > 0 {
                    NavigationLink(value: items[0].post) {
                        ExploreGridCell(post: items[0].post)
                            .frame(width: smallSize, height: smallSize)
                    }
                    .buttonStyle(.plain)
                }
                if items.count > 1 {
                    NavigationLink(value: items[1].post) {
                        ExploreGridCell(post: items[1].post)
                            .frame(width: smallSize, height: smallSize)
                    }
                    .buttonStyle(.plain)
                }
            }

            // Large cell on right
            if items.count > 2 {
                NavigationLink(value: items[2].post) {
                    ExploreGridCell(post: items[2].post)
                        .frame(width: largeSize, height: largeSize)
                }
                .buttonStyle(.plain)
            }
        }
        .frame(width: totalWidth, height: largeSize)
    }
}

// MARK: - Previews

#Preview("Small Row") {
    NavigationStack {
        ExploreSmallRow(items: Post.mockPosts.prefix(3).map { p in
            ExploreGridItem(id: p.id, post: p, isFeatured: false)
        })
    }
}

#Preview("Pattern A") {
    NavigationStack {
        ExplorePatternARow(items: Post.mockPosts.prefix(3).map { p in
            ExploreGridItem(id: p.id, post: p, isFeatured: false)
        })
    }
}

#Preview("Pattern B") {
    NavigationStack {
        ExplorePatternBRow(items: Post.mockPosts.prefix(3).map { p in
            ExploreGridItem(id: p.id, post: p, isFeatured: false)
        })
    }
}
