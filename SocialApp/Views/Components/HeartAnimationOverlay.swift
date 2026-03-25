import SwiftUI

struct HeartAnimationOverlay: View {
    @Binding var isAnimating: Bool

    @State private var scale: CGFloat = 0
    @State private var opacity: Double = 0

    var body: some View {
        Image(systemName: "heart.fill")
            .font(.system(size: 80))
            .foregroundStyle(.white)
            .shadow(color: .black.opacity(0.3), radius: 10, x: 0, y: 4)
            .scaleEffect(scale)
            .opacity(opacity)
            .onChange(of: isAnimating) { _, newValue in
                if newValue {
                    runAnimation()
                }
            }
    }

    private func runAnimation() {
        // Phase 1: Scale up and fade in
        withAnimation(.easeOut(duration: 0.2)) {
            scale = 1.3
            opacity = 1
        }

        // Phase 2: Hold briefly, then scale out and fade
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            withAnimation(.easeIn(duration: 0.3)) {
                scale = 1.5
                opacity = 0
            }
        }

        // Phase 3: Reset
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.9) {
            scale = 0
            isAnimating = false
        }
    }
}

// MARK: - Preview

#Preview {
    ZStack {
        Color.gray
        HeartAnimationOverlay(isAnimating: .constant(true))
    }
}
