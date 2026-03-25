import SwiftUI
import PhotosUI

struct CreatePostView: View {

    @ObservedObject var viewModel: CreatePostViewModel
    let feedViewModel: FeedViewModel

    var body: some View {
        NavigationStack {
            Group {
                if viewModel.selectedImage != nil {
                    CreatePostComposeView(
                        viewModel: viewModel,
                        feedViewModel: feedViewModel,
                        onCancel: { viewModel.reset() }
                    )
                } else {
                    imagePicker
                }
            }
        }
    }

    // MARK: - Image Picker Prompt

    private var imagePicker: some View {
        VStack(spacing: 24) {
            Spacer()

            VStack(spacing: 16) {
                Image(systemName: "camera.on.rectangle.fill")
                    .font(.system(size: 56))
                    .foregroundStyle(
                        LinearGradient(
                            colors: [.purple, .pink, .orange],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )

                Text("New Post")
                    .font(.title2)
                    .fontWeight(.bold)

                Text("Select a photo to share")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }

            PhotosPicker(
                selection: $viewModel.selectedImageItem,
                matching: .images,
                photoLibrary: .shared()
            ) {
                Text("Choose from Library")
                    .font(.headline)
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .background(
                        LinearGradient(
                            colors: [.purple, .pink, .orange],
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 14))
                    .padding(.horizontal, 40)
            }

            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.systemGroupedBackground))
        .navigationTitle("New Post")
    }
}

// MARK: - Preview

#Preview {
    CreatePostView(
        viewModel: CreatePostViewModel(),
        feedViewModel: FeedViewModel()
    )
}
