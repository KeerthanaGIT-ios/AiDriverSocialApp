import Foundation
import PhotosUI
import SwiftUI
import Combine

@MainActor
final class CreatePostViewModel: ObservableObject {

    // MARK: - Published State

    @Published var selectedImageItem: PhotosPickerItem? {
        didSet {
            if selectedImageItem != nil {
                Task { await loadImage() }
            }
        }
    }
    @Published var selectedImage: UIImage?
    @Published var caption: String = ""
    @Published var isPosting: Bool = false
    @Published var didFinishPosting: Bool = false

    // MARK: - Computed

    var canShare: Bool {
        selectedImage != nil
    }

    // MARK: - Actions

    func loadImage() async {
        guard let item = selectedImageItem else { return }

        do {
            if let data = try await item.loadTransferable(type: Data.self),
               let uiImage = UIImage(data: data) {
                selectedImage = uiImage
            }
        } catch {
            // Silently fail — user can re-pick
            selectedImage = nil
        }
    }

    func createPost(feedViewModel: FeedViewModel) {
        guard canShare else { return }
        isPosting = true

        let post = Post(
            id: UUID().uuidString,
            author: .currentUser,
            textContent: caption,
            imageURL: nil,
            likeCount: 0,
            commentCount: 0,
            isLikedByCurrentUser: false,
            createdAt: Date()
        )

        feedViewModel.addPost(post)
        isPosting = false
        didFinishPosting = true
    }

    func reset() {
        selectedImageItem = nil
        selectedImage = nil
        caption = ""
        isPosting = false
        didFinishPosting = false
    }
}
