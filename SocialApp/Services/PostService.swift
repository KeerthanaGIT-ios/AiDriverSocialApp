import Foundation

// MARK: - Errors

enum PostServiceError: LocalizedError {
    case notFound
    case decodingFailed
    case networkUnavailable
    case unknown(Error)

    var errorDescription: String? {
        switch self {
        case .notFound:
            return "Post not found."
        case .decodingFailed:
            return "Failed to decode post data."
        case .networkUnavailable:
            return "Network is unavailable. Please check your connection."
        case .unknown(let error):
            return error.localizedDescription
        }
    }
}

// MARK: - Protocol

protocol PostServiceProtocol {
    func fetchPosts() async throws -> [Post]
    func toggleLike(postID: String, userID: String) async throws
    func createPost(_ post: Post) async throws
}

// MARK: - Firebase Implementation

#if canImport(FirebaseFirestore)
import FirebaseFirestore

final class FirebasePostService: PostServiceProtocol {

    private let db = Firestore.firestore()
    private let collectionName = "posts"

    func fetchPosts() async throws -> [Post] {
        do {
            let snapshot = try await db.collection(collectionName)
                .order(by: "createdAt", descending: true)
                .getDocuments()

            return try snapshot.documents.compactMap { document in
                try postFromDocument(document)
            }
        } catch _ as DecodingError {
            throw PostServiceError.decodingFailed
        } catch {
            throw PostServiceError.unknown(error)
        }
    }

    func toggleLike(postID: String, userID: String) async throws {
        let postRef = db.collection(collectionName).document(postID)
        let likeRef = postRef.collection("likes").document(userID)

        do {
            let likeDoc = try await likeRef.getDocument()

            if likeDoc.exists {
                // Unlike: remove the like document and decrement count
                try await likeRef.delete()
                try await postRef.updateData([
                    "likeCount": FieldValue.increment(Int64(-1))
                ])
            } else {
                // Like: add a like document and increment count
                try await likeRef.setData([
                    "userID": userID,
                    "createdAt": FieldValue.serverTimestamp()
                ])
                try await postRef.updateData([
                    "likeCount": FieldValue.increment(Int64(1))
                ])
            }
        } catch {
            throw PostServiceError.unknown(error)
        }
    }

    func createPost(_ post: Post) async throws {
        do {
            let data = documentDataFromPost(post)
            try await db.collection(collectionName).document(post.id).setData(data)
        } catch {
            throw PostServiceError.unknown(error)
        }
    }

    // MARK: - Mapping Helpers

    private func postFromDocument(_ document: DocumentSnapshot) throws -> Post {
        guard let data = document.data() else {
            throw PostServiceError.notFound
        }

        guard let authorData = data["author"] as? [String: Any],
              let authorID = authorData["id"] as? String,
              let displayName = authorData["displayName"] as? String,
              let username = authorData["username"] as? String else {
            throw PostServiceError.decodingFailed
        }

        let avatarURLString = authorData["avatarURL"] as? String
        let avatarURL = avatarURLString.flatMap { URL(string: $0) }

        let author = User(
            id: authorID,
            displayName: displayName,
            username: username,
            avatarURL: avatarURL
        )

        guard let textContent = data["textContent"] as? String else {
            throw PostServiceError.decodingFailed
        }

        let imageURLString = data["imageURL"] as? String
        let imageURL = imageURLString.flatMap { URL(string: $0) }

        let likeCount = data["likeCount"] as? Int ?? 0
        let commentCount = data["commentCount"] as? Int ?? 0
        let isLikedByCurrentUser = data["isLikedByCurrentUser"] as? Bool ?? false

        let createdAt: Date
        if let timestamp = data["createdAt"] as? Timestamp {
            createdAt = timestamp.dateValue()
        } else {
            createdAt = Date()
        }

        return Post(
            id: document.documentID,
            author: author,
            textContent: textContent,
            imageURL: imageURL,
            likeCount: likeCount,
            commentCount: commentCount,
            isLikedByCurrentUser: isLikedByCurrentUser,
            createdAt: createdAt
        )
    }

    private func documentDataFromPost(_ post: Post) -> [String: Any] {
        var data: [String: Any] = [
            "author": [
                "id": post.author.id,
                "displayName": post.author.displayName,
                "username": post.author.username,
                "avatarURL": post.author.avatarURL?.absoluteString as Any
            ],
            "textContent": post.textContent,
            "likeCount": post.likeCount,
            "commentCount": post.commentCount,
            "isLikedByCurrentUser": post.isLikedByCurrentUser,
            "createdAt": Timestamp(date: post.createdAt)
        ]

        if let imageURL = post.imageURL {
            data["imageURL"] = imageURL.absoluteString
        }

        return data
    }
}
#endif

// MARK: - Mock Implementation

final class MockPostService: PostServiceProtocol {

    private var posts: [Post] = Post.mockPosts

    func fetchPosts() async throws -> [Post] {
        // Simulate network delay
        try? await Task.sleep(for: .milliseconds(300))
        return posts
    }

    func toggleLike(postID: String, userID: String) async throws {
        guard let index = posts.firstIndex(where: { $0.id == postID }) else {
            throw PostServiceError.notFound
        }

        posts[index].isLikedByCurrentUser.toggle()

        if posts[index].isLikedByCurrentUser {
            posts[index].likeCount += 1
        } else {
            posts[index].likeCount -= 1
        }
    }

    func createPost(_ post: Post) async throws {
        posts.insert(post, at: 0)
    }
}
