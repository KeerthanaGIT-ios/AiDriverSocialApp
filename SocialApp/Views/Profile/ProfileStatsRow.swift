import SwiftUI

struct ProfileStatsRow: View {
    let postsCount: Int
    let followersCount: Int
    let followingCount: Int

    var body: some View {
        HStack(spacing: 0) {
            statColumn(count: postsCount, label: "Posts")

            Divider()
                .frame(height: 36)

            statColumn(count: followersCount, label: "Followers")

            Divider()
                .frame(height: 36)

            statColumn(count: followingCount, label: "Following")
        }
    }

    private func statColumn(count: Int, label: String) -> some View {
        VStack(spacing: 4) {
            Text("\(count)")
                .font(.title3)
                .fontWeight(.bold)

            Text(label)
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity)
        .accessibilityElement(children: .combine)
        .accessibilityLabel("\(count) \(label)")
    }
}

// MARK: - Preview

#Preview {
    ProfileStatsRow(postsCount: 12, followersCount: 1240, followingCount: 328)
        .padding()
}
