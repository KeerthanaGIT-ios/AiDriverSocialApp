import SwiftUI

struct AvatarView: View {
    let url: URL?
    let displayName: String
    var size: CGFloat = 40

    var body: some View {
        AsyncImage(url: url) { phase in
            switch phase {
            case .success(let image):
                image
                    .resizable()
                    .scaledToFill()
            case .failure:
                initialsView
            case .empty:
                ProgressView()
                    .frame(width: size, height: size)
            @unknown default:
                initialsView
            }
        }
        .frame(width: size, height: size)
        .clipShape(Circle())
        .overlay(
            Circle()
                .stroke(Color(.systemGray4), lineWidth: 0.5)
        )
        .accessibilityLabel("\(displayName) avatar")
    }

    // MARK: - Initials Fallback

    private var initialsView: some View {
        ZStack {
            Circle()
                .fill(Color.accentColor.opacity(0.2))
            Text(initials)
                .font(.system(size: size * 0.38, weight: .semibold, design: .rounded))
                .foregroundStyle(Color.accentColor)
        }
    }

    private var initials: String {
        let parts = displayName.split(separator: " ")
        let letters = parts.prefix(2).compactMap(\.first)
        return String(letters).uppercased()
    }
}

// MARK: - Preview

#Preview("With URL") {
    AvatarView(url: URL(string: "https://i.pravatar.cc/150?u=demo"), displayName: "Alice Johnson", size: 60)
}

#Preview("No URL") {
    AvatarView(url: nil, displayName: "Dave Kim", size: 60)
}
