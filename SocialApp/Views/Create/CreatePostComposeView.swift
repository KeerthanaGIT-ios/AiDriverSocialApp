import SwiftUI

struct CreatePostComposeView: View {

    @ObservedObject var viewModel: CreatePostViewModel
    let feedViewModel: FeedViewModel
    let onCancel: () -> Void

    var body: some View {
        VStack(spacing: 0) {
            ScrollView {
                VStack(spacing: 16) {
                    // Image Preview
                    if let image = viewModel.selectedImage {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: .infinity)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                            .padding(.horizontal)
                    }

                    Divider()
                        .padding(.horizontal)

                    // Caption Input
                    ZStack(alignment: .topLeading) {
                        if viewModel.caption.isEmpty {
                            Text("Write a caption...")
                                .foregroundStyle(.tertiary)
                                .padding(.horizontal, 20)
                                .padding(.vertical, 12)
                        }

                        TextEditor(text: $viewModel.caption)
                            .scrollContentBackground(.hidden)
                            .frame(minHeight: 100)
                            .padding(.horizontal, 16)
                            .padding(.vertical, 4)
                    }
                }
                .padding(.top, 16)
            }
        }
        .navigationTitle("New Post")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button("Cancel") {
                    onCancel()
                }
                .foregroundStyle(.primary)
            }

            ToolbarItem(placement: .confirmationAction) {
                Button("Share") {
                    viewModel.createPost(feedViewModel: feedViewModel)
                }
                .fontWeight(.semibold)
                .foregroundStyle(
                    LinearGradient(
                        colors: [.purple, .pink, .orange],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
                .disabled(!viewModel.canShare || viewModel.isPosting)
            }
        }
    }
}

// MARK: - Preview

#Preview {
    NavigationStack {
        CreatePostComposeView(
            viewModel: {
                let vm = CreatePostViewModel()
                vm.selectedImage = UIImage(systemName: "photo.fill")
                return vm
            }(),
            feedViewModel: FeedViewModel(),
            onCancel: {}
        )
    }
}
