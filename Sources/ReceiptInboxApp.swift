import SwiftUI
import CoreData
import UIKit

@main
struct ReceiptInboxApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    private let coreDataManager = CoreDataManager(modelName: "ReceiptModel")
    @StateObject private var uploadManager: UploadManager

    init() {
        let manager = UploadManager(coreDataManager: coreDataManager)
        _uploadManager = StateObject(wrappedValue: manager)
        appDelegate.uploadManager = manager
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, coreDataManager.viewContext)
                .environmentObject(uploadManager)
        }
    }
}

final class AppDelegate: NSObject, UIApplicationDelegate {
    var uploadManager: UploadManager?

    func application(_ application: UIApplication,
                     handleEventsForBackgroundURLSession identifier: String,
                     completionHandler: @escaping () -> Void) {
        uploadManager?.attachBackgroundCompletionHandler(completionHandler, for: identifier)
    }

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        uploadManager?.restorePendingTasks()
        return true
    }
}
