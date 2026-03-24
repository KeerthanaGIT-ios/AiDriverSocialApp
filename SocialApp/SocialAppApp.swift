import SwiftUI

@main
struct SocialAppApp: App {

    init() {
        FirebaseConfiguration.configure()
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
