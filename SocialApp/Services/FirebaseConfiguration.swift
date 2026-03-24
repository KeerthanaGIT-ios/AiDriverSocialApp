import Foundation

#if canImport(FirebaseCore)
import FirebaseCore
#endif

/// Handles one-time Firebase SDK setup.
/// Call `FirebaseConfiguration.configure()` at app launch.
enum FirebaseConfiguration {

    /// Configures Firebase if the SDK is available and GoogleService-Info.plist is present.
    /// Safe to call even if Firebase is not yet integrated -- it will simply do nothing.
    static func configure() {
        #if canImport(FirebaseCore)
        // Only configure if GoogleService-Info.plist exists in the bundle
        if let _ = Bundle.main.path(forResource: "GoogleService-Info", ofType: "plist") {
            if FirebaseApp.app() == nil {
                FirebaseApp.configure()
            }
        } else {
            print("[FirebaseConfiguration] GoogleService-Info.plist not found. Running with mock data.")
        }
        #else
        print("[FirebaseConfiguration] Firebase SDK not available. Running with mock data.")
        #endif
    }
}
