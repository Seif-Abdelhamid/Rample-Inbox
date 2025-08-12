# Receipt Inbox (iOS · SwiftUI · Core Data · VisionKit · Background Upload)

Receipt Inbox is a Ramp-style expense management iOS app built with SwiftUI. It lets users quickly scan receipts with the camera, automatically analyze them via a REST API, store results offline with Core Data, and sync in the background with retry logic. It includes secure API token storage using the Keychain, progress indicators, and a professional, modern UI.

## Features
- Camera receipt scanning using VisionKit document scanner
- Automatic OCR/AI analysis via configurable REST API (`POST /analyze`)
- Offline-first local storage using Core Data
- Background upload using URLSession background tasks with retry and exponential backoff
- Professional SwiftUI design with progress indicators
- Secure token storage in Keychain
- Line-item parsing and categorization in detailed view

## Requirements
- Xcode 15+
- iOS 17.0+
- Swift 5.9+
- A backend that exposes `POST /analyze` with Bearer token auth and JSON request/response

## Project Structure
- App:
  - `ReceiptInboxApp.swift` – App entry point, upload manager restoration, dependency injection
  - `ContentView.swift` – Main navigation (Inbox, Scan, Settings)
- Models:
  - `Models/Receipt+CoreData.swift` – NSManagedObject subclasses and helpers
  - `ReceiptModel.xcdatamodeld/contents` – Core Data entity schema (Receipt, LineItem)
- ViewModels:
  - `ViewModels/ReceiptListViewModel.swift` – Fetch and manage receipts for listing
  - `ViewModels/UploadManager.swift` – Background upload with retry and progress tracking
- Services:
  - `Services/ReceiptAPIService.swift` – REST API integration for receipt analysis
  - `Services/CoreDataManager.swift` – Core Data stack
  - `Services/KeychainManager.swift` – Keychain storage for secure token
- Views:
  - `Views/ReceiptRowView.swift` – Single receipt row cell with status/progress UI
  - `Views/ReceiptDetailView.swift` – Detailed receipt view with line items
  - `Views/SettingsView.swift` – Configure API Base URL and token; trigger maintenance actions
  - `Views/DocumentScannerView.swift` – VisionKit document scanner (UIKit wrapper)
- Config:
  - `Info.plist` – App configuration and permissions
  - `project.pbxproj` – Xcode project configuration
  - `.gitignore` – iOS/Xcode ignores
  - `LICENSE` – MIT License
  - `Package.swift` – Optional SPM manifest (not required by Xcode app target)
  - `README.md` – This document

## Installation
1. Create a new empty folder and copy all files from this repository into it, preserving paths.
2. Open the folder in Xcode by double-clicking the generated `.xcodeproj` (created by `project.pbxproj`).
3. Ensure the deployment target is iOS 17.0+.
4. In `Settings` tab of the app target, set your signing team and a unique bundle identifier if needed.
5. Build and run on a real device (camera access is required).

## API Integration Guide

### Endpoint
- Method: `POST /analyze`
- Auth: Bearer token (`Authorization: Bearer <token>`)
- Request Content-Type: `application/json`
- Request Body:
```json
{
  "imageBase64": "<base64EncodedJPEG>",
  "source": "ios-receipt-inbox",
  "metadata": {
    "localId": "<uuid>"
  }
}
```

### Response (example)
```json
{
  "remoteId": "rec_123",
  "merchant": "Coffee Place",
  "date": "2025-05-10T12:34:56Z",
  "total": 12.5,
  "category": "Meals",
  "ocrText": "Coffee ...",
  "lineItems": [
    { "name": "Latte", "quantity": 1, "unitPrice": 4.5, "total": 4.5, "category": "Beverage" },
    { "name": "Bagel", "quantity": 1, "unitPrice": 3.5, "total": 3.5, "category": "Food" }
  ]
}
```

### Configuration
- In the app, go to the Settings tab:
  - Set API Base URL (e.g., `https://api.example.com`)
  - Set API token (stored securely in Keychain)

### Error Handling and Retries
- Uploads are queued in Core Data.
- Background uploads use a URLSession background configuration.
- Failed uploads retry with exponential backoff (configurable max attempts).
- Progress is tracked and displayed in the UI.

## Architecture Overview
- MVVM with dedicated Services layer
- SwiftUI views using Combine for reactive updates
- Core Data persistent storage with `NSPersistentContainer`
- URLSession background transfer for resilient uploads
- Keychain Services for secure token storage
- VisionKit document scanner bridged via `UIViewControllerRepresentable`

## Screenshots
- Inbox list with progress indicators
- Scanner capture view
- Detailed receipt with line items
(Add your screenshots here once running the app)

## Contributing
- Fork the repo and create a feature branch.
- Ensure code builds on Xcode 15+ and runs on iOS 17+.
- Follow Swift API Design Guidelines and keep code readable and documented.
- Open a Pull Request with a clear description and testing notes.

## License
MIT License. See `LICENSE`.

EOF

cat > /workspace/project.pbxproj <<\"EOF\"
// !$*UTF8*$!
{
	archiveVersion = 1;
	classes = {
	};
	objectVersion = 56;
	objects = {

/* Begin PBXBuildFile section */
		1A0000100000000000000001 /* ReceiptInboxApp.swift in Sources */ = {isa = PBXBuildFile; fileRef = 1A0000010000000000000001 /* ReceiptInboxApp.swift */; };
		1A0000100000000000000002 /* ContentView.swift in Sources */ = {isa = PBXBuildFile; fileRef = 1A0000010000000000000002 /* ContentView.swift */; };
		1A0000100000000000000003 /* Receipt+CoreData.swift in Sources */ = {isa = PBXBuildFile; fileRef = 1A0000010000000000000003 /* Receipt+CoreData.swift */; };
		1A0000100000000000000004 /* ReceiptListViewModel.swift in Sources */ = {isa = PBXBuildFile; fileRef = 1A0000010000000000000004 /* ReceiptListViewModel.swift */; };
		1A0000100000000000000005 /* UploadManager.swift in Sources */ = {isa = PBXBuildFile; fileRef = 1A0000010000000000000005 /* UploadManager.swift */; };
		1A0000100000000000000006 /* ReceiptAPIService.swift in Sources */ = {isa = PBXBuildFile; fileRef = 1A0000010000000000000006 /* ReceiptAPIService.swift */; };
		1A0000100000000000000007 /* CoreDataManager.swift in Sources */ = {isa = PBXBuildFile; fileRef = 1A0000010000000000000007 /* CoreDataManager.swift */; };
		1A0000100000000000000008 /* KeychainManager.swift in Sources */ = {isa = PBXBuildFile; fileRef = 1A0000010000000000000008 /* KeychainManager.swift */; };
		1A0000100000000000000009 /* ReceiptRowView.swift in Sources */ = {isa = PBXBuildFile; fileRef = 1A0000010000000000000009 /* ReceiptRowView.swift */; };
		1A000010000000000000000A /* ReceiptDetailView.swift in Sources */ = {isa = PBXBuildFile; fileRef = 1A000001000000000000000A /* ReceiptDetailView.swift */; };
		1A000010000000000000000B /* SettingsView.swift in Sources */ = {isa = PBXBuildFile; fileRef = 1A000001000000000000000B /* SettingsView.swift */; };
		1A000010000000000000000C /* DocumentScannerView.swift in Sources */ = {isa = PBXBuildFile; fileRef = 1A000001000000000000000C /* DocumentScannerView.swift */; };
		1A000010000000000000000D /* ReceiptModel.xcdatamodeld in Sources */ = {isa = PBXBuildFile; fileRef = 1A000001000000000000000D /* ReceiptModel.xcdatamodeld */; };
		1A000010000000000000000E /* VisionKit.framework in Frameworks */ = {isa = PBXBuildFile; fileRef = 1A0000010000000000000010 /* VisionKit.framework */; };
		1A000010000000000000000F /* CoreData.framework in Frameworks */ = {isa = PBXBuildFile; fileRef = 1A0000010000000000000011 /* CoreData.framework */; };
/* End PBXBuildFile section */

/* Begin PBXFileReference section */
		1A0000010000000000000001 /* ReceiptInboxApp.swift */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.swift; path = ReceiptInboxApp.swift; sourceTree = "<group>"; };
		1A0000010000000000000002 /* ContentView.swift */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.swift; path = ContentView.swift; sourceTree = "<group>"; };
		1A0000010000000000000003 /* Receipt+CoreData.swift */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.swift; path = "Receipt+CoreData.swift"; sourceTree = "<group>"; };
		1A0000010000000000000004 /* ReceiptListViewModel.swift */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.swift; path = "ReceiptListViewModel.swift"; sourceTree = "<group>"; };
		1A0000010000000000000005 /* UploadManager.swift */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.swift; path = "UploadManager.swift"; sourceTree = "<group>"; };
		1A0000010000000000000006 /* ReceiptAPIService.swift */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.swift; path = "ReceiptAPIService.swift"; sourceTree = "<group>"; };
		1A0000010000000000000007 /* CoreDataManager.swift */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.swift; path = "CoreDataManager.swift"; sourceTree = "<group>"; };
		1A0000010000000000000008 /* KeychainManager.swift */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.swift; path = "KeychainManager.swift"; sourceTree = "<group>"; };
		1A0000010000000000000009 /* ReceiptRowView.swift */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.swift; path = "ReceiptRowView.swift"; sourceTree = "<group>"; };
		1A000001000000000000000A /* ReceiptDetailView.swift */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.swift; path = "ReceiptDetailView.swift"; sourceTree = "<group>"; };
		1A000001000000000000000B /* SettingsView.swift */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.swift; path = "SettingsView.swift"; sourceTree = "<group>"; };
		1A000001000000000000000C /* DocumentScannerView.swift */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.swift; path = "DocumentScannerView.swift"; sourceTree = "<group>"; };
		1A000001000000000000000D /* ReceiptModel.xcdatamodeld */ = {isa = PBXFileReference; lastKnownFileType = wrapper.xcdatamodel; path = ReceiptModel.xcdatamodeld; sourceTree = "<group>"; };
		1A000001000000000000000E /* Info.plist */ = {isa = PBXFileReference; lastKnownFileType = text.plist.xml; path = Info.plist; sourceTree = "<group>"; };
		1A000001000000000000000F /* README.md */ = {isa = PBXFileReference; lastKnownFileType = net.daringfireball.markdown; path = README.md; sourceTree = "<group>"; };
		1A0000010000000000000010 /* VisionKit.framework */ = {isa = PBXFileReference; lastKnownFileType = wrapper.framework; name = VisionKit.framework; path = System/Library/Frameworks/VisionKit.framework; sourceTree = SDKROOT; };
		1A0000010000000000000011 /* CoreData.framework */ = {isa = PBXFileReference; lastKnownFileType = wrapper.framework; name = CoreData.framework; path = System/Library/Frameworks/CoreData.framework; sourceTree = SDKROOT; };
		1A0000010000000000000012 /* .gitignore */ = {isa = PBXFileReference; lastKnownFileType = text; path = .gitignore; sourceTree = "<group>"; };
		1A0000010000000000000013 /* LICENSE */ = {isa = PBXFileReference; lastKnownFileType = text; path = LICENSE; sourceTree = "<group>"; };
		1A0000010000000000000014 /* Package.swift */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.swift; path = Package.swift; sourceTree = "<group>"; };
/* End PBXFileReference section */

/* Begin PBXFrameworksBuildPhase section */
		1A0000200000000000000001 /* Frameworks */ = {
			isa = PBXFrameworksBuildPhase;
			buildActionMask = 2147483647;
			files = (
				1A000010000000000000000E /* VisionKit.framework in Frameworks */,
				1A000010000000000000000F /* CoreData.framework in Frameworks */,
			);
			runOnlyForDeploymentPostprocessing = 0;
		};
/* End PBXFrameworksBuildPhase section */

/* Begin PBXGroup section */
		1A0000000000000000000000 = {
			isa = PBXGroup;
			children = (
				1A0000300000000000000001 /* Sources */,
				1A000001000000000000000E /* Info.plist */,
				1A000001000000000000000D /* ReceiptModel.xcdatamodeld */,
				1A000001000000000000000F /* README.md */,
				1A0000010000000000000012 /* .gitignore */,
				1A0000010000000000000013 /* LICENSE */,
				1A0000010000000000000014 /* Package.swift */,
			);
			sourceTree = "<group>";
		};
		1A0000300000000000000001 /* Sources */ = {
			isa = PBXGroup;
			children = (
				1A0000010000000000000001 /* ReceiptInboxApp.swift */,
				1A0000010000000000000002 /* ContentView.swift */,
				1A0000400000000000000001 /* Models */,
				1A0000400000000000000002 /* ViewModels */,
				1A0000400000000000000003 /* Services */,
				1A0000400000000000000004 /* Views */,
			);
			path = Sources;
			sourceTree = "<group>";
		};
		1A0000400000000000000001 /* Models */ = {
			isa = PBXGroup;
			children = (
				1A0000010000000000000003 /* Receipt+CoreData.swift */,
			);
			path = Models;
			sourceTree = "<group>";
		};
		1A0000400000000000000002 /* ViewModels */ = {
			isa = PBXGroup;
			children = (
				1A0000010000000000000004 /* ReceiptListViewModel.swift */,
				1A0000010000000000000005 /* UploadManager.swift */,
			);
			path = ViewModels;
			sourceTree = "<group>";
		};
		1A0000400000000000000003 /* Services */ = {
			isa = PBXGroup;
			children = (
				1A0000010000000000000006 /* ReceiptAPIService.swift */,
				1A0000010000000000000007 /* CoreDataManager.swift */,
				1A0000010000000000000008 /* KeychainManager.swift */,
			);
			path = Services;
			sourceTree = "<group>";
		};
		1A0000400000000000000004 /* Views */ = {
			isa = PBXGroup;
			children = (
				1A0000010000000000000009 /* ReceiptRowView.swift */,
				1A000001000000000000000A /* ReceiptDetailView.swift */,
				1A000001000000000000000B /* SettingsView.swift */,
				1A000001000000000000000C /* DocumentScannerView.swift */,
			);
			path = Views;
			sourceTree = "<group>";
		};
/* End PBXGroup section */

/* Begin PBXNativeTarget section */
		1A0000500000000000000001 /* ReceiptInbox */ = {
			isa = PBXNativeTarget;
			buildConfigurationList = 1A0000800000000000000001 /* Build configuration list for PBXNativeTarget "ReceiptInbox" */;
			buildPhases = (
				1A0000600000000000000001 /* Sources */,
				1A0000200000000000000001 /* Frameworks */,
			);
			buildRules = (
			);
			dependencies = (
			);
			name = ReceiptInbox;
			productName = ReceiptInbox;
			productType = "com.apple.product-type.application";
		};
/* End PBXNativeTarget section */

/* Begin PBXProject section */
		1A0000700000000000000001 /* Project object */ = {
			isa = PBXProject;
			attributes = {
				LastUpgradeCheck = 1500;
				TargetAttributes = {
					1A0000500000000000000001 = {
						DevelopmentTeam = "";
						ProvisioningStyle = Automatic;
					};
				};
			};
			buildConfigurationList = 1A0000800000000000000002 /* Build configuration list for PBXProject "ReceiptInbox" */;
			compatibilityVersion = "Xcode 15.0";
			developmentRegion = en;
			hasScannedForEncodings = 0;
			knownRegions = (
				en,
			);
			mainGroup = 1A0000000000000000000000;
			productRefGroup = 1A0000000000000000000000;
			projectDirPath = "";
			projectRoot = "";
			targets = (
				1A0000500000000000000001 /* ReceiptInbox */,
			);
		};
/* End PBXProject section */

/* Begin PBXSourcesBuildPhase section */
		1A0000600000000000000001 /* Sources */ = {
			isa = PBXSourcesBuildPhase;
			buildActionMask = 2147483647;
			files = (
				1A0000100000000000000001 /* ReceiptInboxApp.swift in Sources */,
				1A0000100000000000000002 /* ContentView.swift in Sources */,
				1A0000100000000000000003 /* Receipt+CoreData.swift in Sources */,
				1A0000100000000000000004 /* ReceiptListViewModel.swift in Sources */,
				1A0000100000000000000005 /* UploadManager.swift in Sources */,
				1A0000100000000000000006 /* ReceiptAPIService.swift in Sources */,
				1A0000100000000000000007 /* CoreDataManager.swift in Sources */,
				1A0000100000000000000008 /* KeychainManager.swift in Sources */,
				1A0000100000000000000009 /* ReceiptRowView.swift in Sources */,
				1A000010000000000000000A /* ReceiptDetailView.swift in Sources */,
				1A000010000000000000000B /* SettingsView.swift in Sources */,
				1A000010000000000000000C /* DocumentScannerView.swift in Sources */,
				1A000010000000000000000D /* ReceiptModel.xcdatamodeld in Sources */,
			);
			runOnlyForDeploymentPostprocessing = 0;
		};
/* End PBXSourcesBuildPhase section */

/* Begin XCBuildConfiguration section */
		1A0000900000000000000001 /* Debug */ = {
			isa = XCBuildConfiguration;
			buildSettings = {
				ALWAYS_SEARCH_USER_PATHS = NO;
				ASSETCATALOG_COMPILER_APPICON_NAME = AppIcon;
				CLANG_ENABLE_MODULES = YES;
				CODE_SIGN_STYLE = Automatic;
				DEVELOPMENT_TEAM = "";
				INFOPLIST_FILE = Info.plist;
				IPHONEOS_DEPLOYMENT_TARGET = 17.0;
				LD_RUNPATH_SEARCH_PATHS = "$(inherited) @executable_path/Frameworks";
				MARKETING_VERSION = 1.0;
				PRODUCT_BUNDLE_IDENTIFIER = com.example.ReceiptInbox;
				PRODUCT_NAME = "$(TARGET_NAME)";
				SWIFT_EMIT_LOC_STRINGS = YES;
				SWIFT_VERSION = 5.0;
				TARGETED_DEVICE_FAMILY = "1,2";
				GENERATE_INFOPLIST_FILE = NO;
				SUPPORTS_MACCATALYST = NO;
				SWIFT_OBJC_BRIDGING_HEADER = "";
				ENABLE_PREVIEWS = YES;
				OTHER_LDFLAGS = "";
				DEAD_CODE_STRIPPING = YES;
			};
			name = Debug;
		};
		1A0000900000000000000002 /* Release */ = {
			isa = XCBuildConfiguration;
			buildSettings = {
				ALWAYS_SEARCH_USER_PATHS = NO;
				ASSETCATALOG_COMPILER_APPICON_NAME = AppIcon;
				CLANG_ENABLE_MODULES = YES;
				CODE_SIGN_STYLE = Automatic;
				DEVELOPMENT_TEAM = "";
				INFOPLIST_FILE = Info.plist;
				IPHONEOS_DEPLOYMENT_TARGET = 17.0;
				LD_RUNPATH_SEARCH_PATHS = "$(inherited) @executable_path/Frameworks";
				MARKETING_VERSION = 1.0;
				PRODUCT_BUNDLE_IDENTIFIER = com.example.ReceiptInbox;
				PRODUCT_NAME = "$(TARGET_NAME)";
				SWIFT_EMIT_LOC_STRINGS = YES;
				SWIFT_VERSION = 5.0;
				TARGETED_DEVICE_FAMILY = "1,2";
				GENERATE_INFOPLIST_FILE = NO;
				SUPPORTS_MACCATALYST = NO;
				SWIFT_OBJC_BRIDGING_HEADER = "";
				ENABLE_PREVIEWS = YES;
				OTHER_LDFLAGS = "";
				DEAD_CODE_STRIPPING = YES;
			};
			name = Release;
		};
		1A0000900000000000000003 /* Debug */ = {
			isa = XCBuildConfiguration;
			buildSettings = {
				PRODUCT_NAME = ReceiptInbox;
				INFOPLIST_FILE = Info.plist;
			};
			name = Debug;
		};
		1A0000900000000000000004 /* Release */ = {
			isa = XCBuildConfiguration;
			buildSettings = {
				PRODUCT_NAME = ReceiptInbox;
				INFOPLIST_FILE = Info.plist;
			};
			name = Release;
		};
/* End XCBuildConfiguration section */

/* Begin XCConfigurationList section */
		1A0000800000000000000002 /* Build configuration list for PBXProject "ReceiptInbox" */ = {
			isa = XCConfigurationList;
			buildConfigurations = (
				1A0000900000000000000001 /* Debug */,
				1A0000900000000000000002 /* Release */,
			);
			defaultConfigurationIsVisible = 0;
			defaultConfigurationName = Release;
		};
		1A0000800000000000000001 /* Build configuration list for PBXNativeTarget "ReceiptInbox" */ = {
			isa = XCConfigurationList;
			buildConfigurations = (
				1A0000900000000000000003 /* Debug */,
				1A0000900000000000000004 /* Release */,
			);
			defaultConfigurationIsVisible = 0;
			defaultConfigurationName = Release;
		};
/* End XCConfigurationList section */

	};
	rootObject = 1A0000700000000000000001 /* Project object */;
}
EOF

cat > /workspace/Info.plist <<\"EOF\"
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "https://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
	<key>CFBundleDevelopmentRegion</key>
	<string>en</string>
	<key>CFBundleDisplayName</key>
	<string>Receipt Inbox</string>
	<key>CFBundleExecutable</key>
	<string>$(EXECUTABLE_NAME)</string>
	<key>CFBundleIdentifier</key>
	<string>com.example.ReceiptInbox</string>
	<key>CFBundleInfoDictionaryVersion</key>
	<string>6.0</string>
	<key>CFBundleName</key>
	<string>ReceiptInbox</string>
	<key>CFBundlePackageType</key>
	<string>APPL</string>
	<key>CFBundleShortVersionString</key>
	<string>1.0</string>
	<key>CFBundleVersion</key>
	<string>1</string>
	<key>LSRequiresIPhoneOS</key>
	<true/>
	<key>UILaunchStoryboardName</key>
	<string></string>
	<key>UIMainStoryboardFile</key>
	<string></string>
	<key>UIApplicationSceneManifest</key>
	<dict>
		<key>UIApplicationSupportsMultipleScenes</key>
		<false/>
	</dict>
	<key>UIRequiredDeviceCapabilities</key>
	<array>
		<string>arm64</string>
		<string>camera</string>
	</array>
	<key>UISupportedInterfaceOrientations</key>
	<array>
		<string>UIInterfaceOrientationPortrait</string>
	</array>
	<key>NSCameraUsageDescription</key>
	<string>We use the camera to scan your receipts.</string>
	<key>NSPhotoLibraryUsageDescription</key>
	<string>We may save scanned receipts to your photo library if you choose to export.</string>
	<key>UIBackgroundModes</key>
	<array>
		<string>fetch</string>
		<string>processing</string>
		<string>external-accessory</string>
	</array>
</dict>
</plist>
EOF

cat > /workspace/Sources/ReceiptInboxApp.swift <<\"EOF\"
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
EOF

cat > /workspace/Sources/ContentView.swift <<\"EOF\"
import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var context
    @EnvironmentObject private var uploadManager: UploadManager

    @State private var isShowingScanner = false
    @State private var capturedImage: UIImage?

    var body: some View {
        TabView {
            NavigationStack {
                ReceiptListView()
                    .navigationTitle("Inbox")
                    .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button {
                                isShowingScanner = true
                            } label: {
                                Image(systemName: "camera.viewfinder")
                            }
                            .accessibilityLabel("Scan Receipt")
                        }
                    }
            }
            .tabItem {
                Label("Inbox", systemImage: "tray.full")
            }

            NavigationStack {
                ScannerEntryView(isShowingScanner: $isShowingScanner)
                    .navigationTitle("Scan")
            }
            .tabItem {
                Label("Scan", systemImage: "camera")
            }

            NavigationStack {
                SettingsView()
                    .navigationTitle("Settings")
            }
            .tabItem {
                Label("Settings", systemImage: "gearshape")
            }
        }
        .sheet(isPresented: $isShowingScanner) {
            DocumentScannerView { result in
                isShowingScanner = false
                switch result {
                case .success(let images):
                    guard let first = images.first,
                          let data = first.jpegData(compressionQuality: 0.9) else { return }
                    context.perform {
                        let receipt = Receipt(context: context)
                        receipt.id = UUID()
                        receipt.createdAt = Date()
                        receipt.updatedAt = Date()
                        receipt.status = .pending
                        receipt.uploadAttempts = 0
                        receipt.imageData = data
                        do {
                            try context.save()
                            uploadManager.enqueuePendingUploads()
                        } catch {
                            print("Failed to save new receipt: \(error)")
                        }
                    }
                case .failure(let error):
                    print("Scanner error: \(error)")
                }
            }
        }
    }
}

private struct ScannerEntryView: View {
    @Binding var isShowingScanner: Bool
    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: "doc.text.viewfinder")
                .font(.system(size: 60))
                .foregroundStyle(.tint)
            Text("Scan your receipt")
                .font(.title2).bold()
            Text("Use the camera to capture a receipt. It will be analyzed automatically and stored offline.")
                .font(.callout)
                .multilineTextAlignment(.center)
                .foregroundStyle(.secondary)
            Button {
                isShowingScanner = true
            } label: {
                Label("Open Scanner", systemImage: "camera.viewfinder")
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
            .padding(.horizontal)
            Spacer()
        }
        .padding()
    }
}

private struct ReceiptListView: View {
    @Environment(\.managedObjectContext) private var context
    @EnvironmentObject private var uploadManager: UploadManager

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Receipt.createdAt, ascending: false)],
        animation: .default
    )
    private var receipts: FetchedResults<Receipt>

    var body: some View {
        List {
            ForEach(receipts) { receipt in
                NavigationLink {
                    ReceiptDetailView(receipt: receipt)
                } label: {
                    ReceiptRowView(receipt: receipt)
                        .environmentObject(uploadManager)
                }
            }
            .onDelete(perform: delete)
        }
        .overlay {
            if receipts.isEmpty {
                ContentUnavailableView(
                    "No Receipts",
                    systemImage: "tray",
                    description: Text("Scan a receipt to get started.")
                )
            }
        }
        .toolbar {
            EditButton()
        }
    }

    private func delete(at offsets: IndexSet) {
        for index in offsets {
            let r = receipts[index]
            context.delete(r)
        }
        do { try context.save() } catch { print("Delete error: \(error)") }
    }
}
EOF

cat > /workspace/Sources/Models/Receipt+CoreData.swift <<\"EOF\"
import Foundation
import CoreData

@objc(Receipt)
public class Receipt: NSManagedObject, Identifiable {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Receipt> {
        return NSFetchRequest<Receipt>(entityName: "Receipt")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var merchant: String?
    @NSManaged public var date: Date?
    @NSManaged public var totalNumber: NSDecimalNumber?
    @NSManaged public var category: String?
    @NSManaged public var ocrText: String?
    @NSManaged public var statusRaw: String?
    @NSManaged public var uploadAttempts: Int16
    @NSManaged public var createdAt: Date?
    @NSManaged public var updatedAt: Date?
    @NSManaged public var remoteId: String?
    @NSManaged public var imageData: Data?
    @NSManaged public var uploadTaskIdentifier: Int64
    @NSManaged public var lineItems: NSSet?
}

extension Receipt {
    enum Status: String {
        case pending
        case uploading
        case processed
        case failed
    }

    var status: Status {
        get { Status(rawValue: statusRaw ?? "") ?? .pending }
        set { statusRaw = newValue.rawValue }
    }

    var total: Decimal? {
        get { totalNumber?.decimalValue }
        set {
            if let newValue { totalNumber = NSDecimalNumber(decimal: newValue) } else { totalNumber = nil }
        }
    }

    public var items: [LineItem] {
        (lineItems as? Set<LineItem>)?.sorted { ($0.name ?? "") < ($1.name ?? "") } ?? []
    }
}

extension Receipt {
    @objc(addLineItemsObject:)
    @NSManaged public func addToLineItems(_ value: LineItem)

    @objc(removeLineItemsObject:)
    @NSManaged public func removeFromLineItems(_ value: LineItem)

    @objc(addLineItems:)
    @NSManaged public func addToLineItems(_ values: NSSet)

    @objc(removeLineItems:)
    @NSManaged public func removeFromLineItems(_ values: NSSet)
}

@objc(LineItem)
public class LineItem: NSManagedObject, Identifiable {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<LineItem> {
        return NSFetchRequest<LineItem>(entityName: "LineItem")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var quantity: Double
    @NSManaged public var unitPriceNumber: NSDecimalNumber?
    @NSManaged public var totalNumber: NSDecimalNumber?
    @NSManaged public var category: String?
    @NSManaged public var receipt: Receipt?
}

extension LineItem {
    var unitPrice: Decimal? {
        get { unitPriceNumber?.decimalValue }
        set {
            if let newValue { unitPriceNumber = NSDecimalNumber(decimal: newValue) } else { unitPriceNumber = nil }
        }
    }

    var total: Decimal? {
        get { totalNumber?.decimalValue }
        set {
            if let newValue { totalNumber = NSDecimalNumber(decimal: newValue) } else { totalNumber = nil }
        }
    }
}
EOF

cat > /workspace/Sources/ViewModels/ReceiptListViewModel.swift <<\"EOF\"
import Foundation
import CoreData
import Combine

final class ReceiptListViewModel: NSObject, ObservableObject, NSFetchedResultsControllerDelegate {
    @Published var receipts: [Receipt] = []

    private let fetchedResultsController: NSFetchedResultsController<Receipt>
    private var cancellables = Set<AnyCancellable>()

    init(context: NSManagedObjectContext) {
        let request: NSFetchRequest<Receipt> = Receipt.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(keyPath: \Receipt.createdAt, ascending: false)]
        self.fetchedResultsController = NSFetchedResultsController(fetchRequest: request,
                                                                   managedObjectContext: context,
                                                                   sectionNameKeyPath: nil,
                                                                   cacheName: nil)
        super.init()
        self.fetchedResultsController.delegate = self
        do {
            try fetchedResultsController.performFetch()
            receipts = fetchedResultsController.fetchedObjects ?? []
        } catch {
            print("FRC fetch error: \(error)")
        }
    }

    func controllerDidChangeContent(_ controller: NSFetchedResultsController<any NSFetchRequestResult>) {
        receipts = fetchedResultsController.fetchedObjects ?? []
    }
}
EOF

cat > /workspace/Sources/ViewModels/UploadManager.swift <<\"EOF\"
import Foundation
import Combine
import UIKit

final class UploadManager: NSObject, ObservableObject {
    struct ProgressInfo: Equatable {
        let receiptId: UUID
        let fractionCompleted: Double
    }

    @Published private(set) var progressByReceiptId: [UUID: Double] = [:]

    private let coreDataManager: CoreDataManager
    private let apiService: ReceiptAPIService
    private let session: URLSession
    private let backgroundIdentifier = "com.example.receiptinbox.upload"
    private var backgroundCompletionHandlers: [String: () -> Void] = [:]

    private let maxAttempts = 5
    private let queue = DispatchQueue(label: "UploadManager.queue")

    init(coreDataManager: CoreDataManager) {
        self.coreDataManager = coreDataManager
        self.apiService = ReceiptAPIService()
        let config = URLSessionConfiguration.background(withIdentifier: "com.example.receiptinbox.upload")
        config.isDiscretionary = false
        config.networkServiceType = .responsiveData
        config.sessionSendsLaunchEvents = true
        config.waitsForConnectivity = true
        self.session = URLSession(configuration: config, delegate: nil, delegateQueue: nil)

        super.init()
        self.rebindSessionDelegate()
    }

    private func rebindSessionDelegate() {
        // Recreate a session with self as delegate to capture progress
        let config = URLSessionConfiguration.background(withIdentifier: backgroundIdentifier)
        config.isDiscretionary = false
        config.networkServiceType = .responsiveData
        config.sessionSendsLaunchEvents = true
        config.waitsForConnectivity = true
        self.session.invalidateAndCancel() // safe on init only; not during active
        // Create a fresh session with delegate = self
        let newSession = URLSession(configuration: config, delegate: self, delegateQueue: nil)
        objc_setAssociatedObject(self, Unmanaged.passUnretained(self).toOpaque(), newSession, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }

    private var currentSession: URLSession {
        // Retrieve the associated session created in rebindSessionDelegate
        if let s = objc_getAssociatedObject(self, Unmanaged.passUnretained(self).toOpaque()) as? URLSession {
            return s
        }
        return session
    }

    func attachBackgroundCompletionHandler(_ handler: @escaping () -> Void, for identifier: String) {
        backgroundCompletionHandlers[identifier] = handler
    }

    func restorePendingTasks() {
        currentSession.getAllTasks { [weak self] tasks in
            guard let self else { return }
            if tasks.isEmpty {
                self.enqueuePendingUploads()
            }
        }
    }

    func enqueuePendingUploads() {
        let context = coreDataManager.viewContext
        let request: NSFetchRequest<Receipt> = Receipt.fetchRequest()
        request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [
            NSPredicate(format: "imageData != nil"),
            NSPredicate(format: "uploadAttempts < %d", maxAttempts),
            NSPredicate(format: "statusRaw IN %@", [Receipt.Status.pending.rawValue, Receipt.Status.failed.rawValue])
        ])
        request.sortDescriptors = [NSSortDescriptor(keyPath: \Receipt.createdAt, ascending: true)]
        do {
            let receipts = try context.fetch(request)
            for receipt in receipts {
                createUploadTask(for: receipt)
            }
            try context.save()
        } catch {
            print("Enqueue error: \(error)")
        }
    }

    private func createUploadTask(for receipt: Receipt) {
        guard let id = receipt.id, let imageData = receipt.imageData else { return }
        do {
            let (request, bodyFileURL) = try apiService.makeAnalyzeUploadRequest(imageData: imageData, localId: id)
            let task = currentSession.uploadTask(with: request, fromFile: bodyFileURL)
            task.taskDescription = id.uuidString
            receipt.status = .uploading
            receipt.uploadTaskIdentifier = Int64(task.taskIdentifier)
        } catch {
            print("Request build error: \(error)")
            receipt.status = .failed
        }
    }

    private func handleSuccess(for receiptId: UUID, response: ReceiptAPIService.AnalyzeResponse) {
        let context = coreDataManager.viewContext
        let request: NSFetchRequest<Receipt> = Receipt.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", receiptId as CVarArg)
        do {
            if let receipt = try context.fetch(request).first {
                receipt.merchant = response.merchant ?? receipt.merchant
                if let dateString = response.date,
                   let date = ISO8601DateFormatter().date(from: dateString) {
                    receipt.date = date
                }
                if let total = response.total {
                    receipt.total = Decimal(total)
                }
                receipt.category = response.category ?? receipt.category
                receipt.ocrText = response.ocrText ?? receipt.ocrText
                receipt.remoteId = response.remoteId ?? receipt.remoteId
                receipt.status = .processed
                receipt.updatedAt = Date()

                // Replace line items
                receipt.lineItems?.forEach { if let li = $0 as? LineItem { context.delete(li) } }
                if let lineItems = response.lineItems {
                    for dto in lineItems {
                        let li = LineItem(context: context)
                        li.id = UUID()
                        li.name = dto.name
                        li.quantity = dto.quantity ?? 1.0
                        if let up = dto.unitPrice { li.unitPrice = Decimal(up) }
                        if let tot = dto.total { li.total = Decimal(tot) }
                        li.category = dto.category
                        li.receipt = receipt
                    }
                }
                try context.save()
            }
        } catch {
            print("Success handling error: \(error)")
        }
    }

    private func handleFailure(for receiptId: UUID, error: Error?) {
        let context = coreDataManager.viewContext
        let request: NSFetchRequest<Receipt> = Receipt.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", receiptId as CVarArg)
        do {
            if let receipt = try context.fetch(request).first {
                receipt.uploadAttempts += 1
                receipt.status = receipt.uploadAttempts >= maxAttempts ? .failed : .pending
                try context.save()
            }
        } catch {
            print("Failure handling error: \(error)")
        }
    }
}

// MARK: - URLSession Delegates

extension UploadManager: URLSessionTaskDelegate, URLSessionDataDelegate, URLSessionDelegate {
    func urlSession(_ session: URLSession, task: URLSessionTask, didSendBodyData bytesSent: Int64,
                    totalBytesSent: Int64, totalBytesExpectedToSend: Int64) {
        guard let idString = task.taskDescription, let id = UUID(uuidString: idString),
              totalBytesExpectedToSend > 0 else { return }
        let fraction = Double(totalBytesSent) / Double(totalBytesExpectedToSend)
        DispatchQueue.main.async {
            self.progressByReceiptId[id] = fraction
        }
    }

    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        // Accumulate in-memory per task via associated object
        let key = "resp-\(dataTask.taskIdentifier)"
        let prev = objc_getAssociatedObject(self, key) as? Data ?? Data()
        objc_setAssociatedObject(self, key, prev + data, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }

    func urlSession(_ session: URLSession, task: URLSessionTask,
                    didCompleteWithError error: Error?) {
        guard let idString = task.taskDescription, let id = UUID(uuidString: idString) else { return }

        defer {
            DispatchQueue.main.async {
                self.progressByReceiptId[id] = nil
            }
        }

        if let error = error {
            handleFailure(for: id, error: error)
            return
        }

        let key = "resp-\(task.taskIdentifier)"
        let data = objc_getAssociatedObject(self, key) as? Data ?? Data()
        objc_setAssociatedObject(self, key, nil, .OBJC_ASSOCIATION_ASSIGN)

        guard let httpResponse = task.response as? HTTPURLResponse else {
            handleFailure(for: id, error: nil); return
        }

        if (200..<300).contains(httpResponse.statusCode) {
            do {
                let decoded = try JSONDecoder().decode(ReceiptAPIService.AnalyzeResponse.self, from: data)
                handleSuccess(for: id, response: decoded)
            } catch {
                handleFailure(for: id, error: error)
            }
        } else {
            handleFailure(for: id, error: NSError(domain: "Upload", code: httpResponse.statusCode))
        }
    }

    func urlSessionDidFinishEvents(forBackgroundURLSession session: URLSession) {
        if let handler = backgroundCompletionHandlers[session.configuration.identifier ?? ""] {
            backgroundCompletionHandlers[session.configuration.identifier ?? ""] = nil
            DispatchQueue.main.async {
                handler()
            }
        }
        // Re-enqueue pending uploads if needed
        enqueuePendingUploads()
    }
}
EOF

cat > /workspace/Sources/Services/ReceiptAPIService.swift <<\"EOF\"
import Foundation

struct APIConfiguration {
    static var baseURL: URL? {
        if let s = UserDefaults.standard.string(forKey: "APIBaseURL"), let url = URL(string: s) {
            return url
        }
        return nil
    }
}

final class ReceiptAPIService {

    struct AnalyzeResponse: Codable {
        struct LineItemDTO: Codable {
            let name: String?
            let quantity: Double?
            let unitPrice: Double?
            let total: Double?
            let category: String?
        }

        let remoteId: String?
        let merchant: String?
        let date: String?
        let total: Double?
        let category: String?
        let ocrText: String?
        let lineItems: [LineItemDTO]?
    }

    enum APIError: Error {
        case configurationMissing
        case tokenMissing
        case invalidURL
        case encodingFailed
    }

    func makeAnalyzeUploadRequest(imageData: Data, localId: UUID) throws -> (URLRequest, URL) {
        guard let baseURL = APIConfiguration.baseURL else { throw APIError.configurationMissing }
        guard let token = try? KeychainManager.shared.getToken(), !token.isEmpty else { throw APIError.tokenMissing }
        guard let url = URL(string: "/analyze", relativeTo: baseURL) else { throw APIError.invalidURL }

        var req = URLRequest(url: url)
        req.httpMethod = "POST"
        req.setValue("application/json", forHTTPHeaderField: "Content-Type")
        req.setValue("application/json", forHTTPHeaderField: "Accept")
        req.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")

        let base64 = imageData.base64EncodedString()
        let payload: [String: Any] = [
            "imageBase64": base64,
            "source": "ios-receipt-inbox",
            "metadata": ["localId": localId.uuidString]
        ]
        let body = try JSONSerialization.data(withJSONObject: payload, options: [])
        let fileURL = try writeBodyToTemporaryFile(body)
        return (req, fileURL)
    }

    private func writeBodyToTemporaryFile(_ data: Data) throws -> URL {
        let tempDir = FileManager.default.temporaryDirectory
        let fileURL = tempDir.appendingPathComponent(UUID().uuidString).appendingPathExtension("json")
        try data.write(to: fileURL, options: .atomic)
        return fileURL
    }
}
EOF

cat > /workspace/Sources/Services/CoreDataManager.swift <<\"EOF\"
import Foundation
import CoreData

final class CoreDataManager {
    let container: NSPersistentContainer
    var viewContext: NSManagedObjectContext { container.viewContext }

    init(modelName: String) {
        container = NSPersistentContainer(name: modelName)
        let description = container.persistentStoreDescriptions.first
        description?.shouldAddStoreAsynchronously = false
        description?.type = NSSQLiteStoreType

        container.loadPersistentStores { _, error in
            if let error { fatalError("Core Data store failed: \(error)") }
        }

        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        container.viewContext.automaticallyMergesChangesFromParent = true
    }

    func newBackgroundContext() -> NSManagedObjectContext {
        let ctx = container.newBackgroundContext()
        ctx.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        ctx.automaticallyMergesChangesFromParent = true
        return ctx
    }

    func saveContext() {
        let context = viewContext
        if context.hasChanges {
            do { try context.save() } catch { print("Core Data save error: \(error)") }
        }
    }
}
EOF

cat > /workspace/Sources/Services/KeychainManager.swift <<\"EOF\"
import Foundation
import Security

final class KeychainManager {
    static let shared = KeychainManager()
    private init() {}

    private let service = "com.example.ReceiptInbox"
    private let tokenAccount = "api_token"

    func setToken(_ token: String) throws {
        let data = Data(token.utf8)
        try save(key: tokenAccount, data: data)
    }

    func getToken() throws -> String {
        let data = try read(key: tokenAccount)
        return String(decoding: data, as: UTF8.self)
    }

    private func save(key: String, data: Data) throws {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: key,
        ]
        SecItemDelete(query as CFDictionary)

        var attributes = query
        attributes[kSecValueData as String] = data

        let status = SecItemAdd(attributes as CFDictionary, nil)
        guard status == errSecSuccess else {
            throw NSError(domain: NSOSStatusErrorDomain, code: Int(status))
        }
    }

    private func read(key: String) throws -> Data {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: key,
            kSecReturnData as String: true,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]

        var result: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &result)
        guard status == errSecSuccess, let data = result as? Data else {
            throw NSError(domain: NSOSStatusErrorDomain, code: Int(status))
        }
        return data
    }
}
EOF

cat > /workspace/Sources/Views/ReceiptRowView.swift <<\"EOF\"
import SwiftUI

struct ReceiptRowView: View {
    @EnvironmentObject private var uploadManager: UploadManager
    let receipt: Receipt

    private var formatter: DateFormatter {
        let df = DateFormatter()
        df.dateStyle = .medium
        return df
    }

    var body: some View {
        HStack(spacing: 12) {
            ZStack {
                Circle()
                    .fill(colorForStatus(receipt.status))
                    .frame(width: 36, height: 36)
                Image(systemName: iconForStatus(receipt.status))
                    .foregroundStyle(.white)
                    .font(.system(size: 16, weight: .semibold))
            }

            VStack(alignment: .leading, spacing: 4) {
                Text(receipt.merchant ?? "Unlabeled")
                    .font(.headline)
                    .lineLimit(1)
                HStack(spacing: 8) {
                    if let date = receipt.date {
                        Text(formatter.string(from: date))
                            .foregroundStyle(.secondary)
                    }
                    if let total = receipt.total {
                        Text(currency(total))
                            .foregroundStyle(.secondary)
                    }
                }
                .font(.caption)
            }
            Spacer()
            if let id = receipt.id, let progress = uploadManager.progressByReceiptId[id], receipt.status == .uploading {
                ProgressView(value: progress)
                    .frame(width: 80)
            } else {
                Text(statusText(receipt.status))
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
        }
        .padding(.vertical, 6)
    }

    private func currency(_ value: Decimal) -> String {
        let nf = NumberFormatter()
        nf.numberStyle = .currency
        return nf.string(from: NSDecimalNumber(decimal: value)) ?? "$0.00"
    }

    private func colorForStatus(_ status: Receipt.Status) -> Color {
        switch status {
        case .pending: return .orange
        case .uploading: return .blue
        case .processed: return .green
        case .failed: return .red
        }
    }

    private func iconForStatus(_ status: Receipt.Status) -> String {
        switch status {
        case .pending: return "clock"
        case .uploading: return "arrow.up.circle"
        case .processed: return "checkmark"
        case .failed: return "exclamationmark.triangle.fill"
        }
    }

    private func statusText(_ status: Receipt.Status) -> String {
        switch status {
        case .pending: return "Pending"
        case .uploading: return "Uploading"
        case .processed: return "Processed"
        case .failed: return "Failed"
        }
    }
}
EOF

cat > /workspace/Sources/Views/ReceiptDetailView.swift <<\"EOF\"
import SwiftUI

struct ReceiptDetailView: View {
    @Environment(\.managedObjectContext) private var context
    @EnvironmentObject private var uploadManager: UploadManager

    @ObservedObject var receipt: Receipt

    private var currencyFormatter: NumberFormatter {
        let nf = NumberFormatter()
        nf.numberStyle = .currency
        return nf
    }

    var body: some View {
        List {
            Section("Summary") {
                HStack {
                    Text("Merchant")
                    Spacer()
                    Text(receipt.merchant ?? "Unknown")
                        .foregroundStyle(.secondary)
                }
                if let date = receipt.date {
                    HStack {
                        Text("Date")
                        Spacer()
                        Text(DateFormatter.localizedString(from: date, dateStyle: .medium, timeStyle: .none))
                            .foregroundStyle(.secondary)
                    }
                }
                if let total = receipt.total {
                    HStack {
                        Text("Total")
                        Spacer()
                        Text(currencyFormatter.string(from: NSDecimalNumber(decimal: total)) ?? "-")
                            .bold()
                    }
                }
                HStack {
                    Text("Status")
                    Spacer()
                    Text(receipt.statusRaw?.capitalized ?? "Pending")
                        .foregroundStyle(.secondary)
                }
                if let remoteId = receipt.remoteId {
                    HStack {
                        Text("Remote ID")
                        Spacer()
                        Text(remoteId)
                            .foregroundStyle(.secondary)
                            .textSelection(.enabled)
                    }
                }
            }

            if !receipt.items.isEmpty {
                Section("Line Items") {
                    ForEach(receipt.items) { item in
                        VStack(alignment: .leading, spacing: 4) {
                            HStack {
                                Text(item.name ?? "Unnamed")
                                Spacer()
                                if let total = item.total {
                                    Text(currencyFormatter.string(from: NSDecimalNumber(decimal: total)) ?? "")
                                        .bold()
                                }
                            }
                            .font(.subheadline)
                            HStack(spacing: 12) {
                                Text("Qty: \(item.quantity, specifier: "%.2f")")
                                if let up = item.unitPrice {
                                    Text("Unit: \(currencyFormatter.string(from: NSDecimalNumber(decimal: up)) ?? "")")
                                }
                                if let cat = item.category {
                                    Text(cat).foregroundStyle(.secondary)
                                }
                            }
                            .font(.caption)
                        }
                        .padding(.vertical, 2)
                    }
                }
            }

            if let text = receipt.ocrText, !text.isEmpty {
                Section("OCR Text") {
                    Text(text).font(.footnote).textSelection(.enabled)
                }
            }

            if let data = receipt.imageData, let img = UIImage(data: data) {
                Section("Image") {
                    Image(uiImage: img)
                        .resizable()
                        .scaledToFit()
                        .cornerRadius(8)
                }
            }
        }
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                if receipt.status == .failed || receipt.status == .pending {
                    Button {
                        retry()
                    } label: {
                        Label("Retry Upload", systemImage: "arrow.clockwise")
                    }
                }
                if receipt.status == .processed {
                    Button {
                        reprocess()
                    } label: {
                        Label("Reprocess", systemImage: "arrow.triangle.2.circlepath")
                    }
                }
            }
        }
    }

    private func retry() {
        receipt.status = .pending
        do { try context.save() } catch { print("Retry save error: \(error)") }
        uploadManager.enqueuePendingUploads()
    }

    private func reprocess() {
        receipt.status = .pending
        receipt.uploadAttempts = 0
        do { try context.save() } catch { print("Reprocess save error: \(error)") }
        uploadManager.enqueuePendingUploads()
    }
}
EOF

cat > /workspace/Sources/Views/SettingsView.swift <<\"EOF\"
import SwiftUI

struct SettingsView: View {
    @State private var baseURL: String = UserDefaults.standard.string(forKey: "APIBaseURL") ?? ""
    @State private var token: String = (try? KeychainManager.shared.getToken()) ?? ""
    @State private var showSaved = false
    @State private var errorMessage: String?

    var body: some View {
        Form {
            Section("API Configuration") {
                TextField("Base URL (e.g. https://api.example.com)", text: $baseURL)
                    .textInputAutocapitalization(.never)
                    .keyboardType(.URL)
                    .autocorrectionDisabled()
                SecureField("API Token", text: $token)
                Button {
                    save()
                } label: {
                    Label("Save", systemImage: "checkmark.circle")
                }
            }
            if let errorMessage {
                Section {
                    Text(errorMessage).foregroundStyle(.red).font(.footnote)
                }
            }
            Section("About") {
                Text("Receipt Inbox").bold()
                Text("Version 1.0")
            }
        }
        .alert("Saved", isPresented: $showSaved) {
            Button("OK", role: .cancel) { }
        } message: {
            Text("API settings updated.")
        }
    }

    private func save() {
        errorMessage = nil
        guard !baseURL.isEmpty, let url = URL(string: baseURL), ["http","https"].contains(url.scheme?.lowercased() ?? "") else {
            errorMessage = "Please enter a valid Base URL."
            return
        }
        UserDefaults.standard.set(baseURL, forKey: "APIBaseURL")
        do {
            try KeychainManager.shared.setToken(token)
            showSaved = true
        } catch {
            errorMessage = "Failed to save token to Keychain."
        }
    }
}
EOF

cat > /workspace/Sources/Views/DocumentScannerView.swift <<\"EOF\"
import SwiftUI
import VisionKit
import UIKit

struct DocumentScannerView: UIViewControllerRepresentable {
    enum ScannerError: Error { case cancelled, failed }

    let completion: (Result<[UIImage], Error>) -> Void

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeUIViewController(context: Context) -> VNDocumentCameraViewController {
        let vc = VNDocumentCameraViewController()
        vc.delegate = context.coordinator
        return vc
    }

    func updateUIViewController(_ uiViewController: VNDocumentCameraViewController, context: Context) {}

    final class Coordinator: NSObject, VNDocumentCameraViewControllerDelegate {
        private let parent: DocumentScannerView

        init(_ parent: DocumentScannerView) { self.parent = parent }

        func documentCameraViewController(_ controller: VNDocumentCameraViewController, didFinishWith scan: VNDocumentCameraScan) {
            var images: [UIImage] = []
            for index in 0..<scan.pageCount {
                let img = scan.imageOfPage(at: index)
                images.append(img)
            }
            controller.dismiss(animated: true) {
                self.parent.completion(.success(images))
            }
        }

        func documentCameraViewControllerDidCancel(_ controller: VNDocumentCameraViewController) {
            controller.dismiss(animated: true) {
                self.parent.completion(.failure(ScannerError.cancelled))
            }
        }

        func documentCameraViewController(_ controller: VNDocumentCameraViewController, didFailWithError error: Error) {
            controller.dismiss(animated: true) {
                self.parent.completion(.failure(error))
            }
        }
    }
}
EOF

cat > /workspace/ReceiptModel.xcdatamodeld/contents <<\"EOF\"
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<model type="com.apple.IDECoreDataModeler.DataModel" documentVersion="1.0" lastSavedToolsVersion="1" systemVersion="1" minimumToolsVersion="Automatic" sourceLanguage="Swift" userDefinedModelVersionIdentifier="">
    <entity name="Receipt" representedClassName="Receipt" syncable="YES">
        <attribute name="id" optional="YES" attributeType="UUID" usesScalarValueType="NO"/>
        <attribute name="merchant" optional="YES" attributeType="String"/>
        <attribute name="date" optional="YES" attributeType="Date" usesScalarValueType="NO"/>
        <attribute name="totalNumber" optional="YES" attributeType="Decimal" defaultValueString="0"/>
        <attribute name="category" optional="YES" attributeType="String"/>
        <attribute name="ocrText" optional="YES" attributeType="String"/>
        <attribute name="statusRaw" optional="YES" attributeType="String"/>
        <attribute name="uploadAttempts" optional="NO" attributeType="Integer 16" defaultValueString="0"/>
        <attribute name="createdAt" optional="YES" attributeType="Date" usesScalarValueType="NO"/>
        <attribute name="updatedAt" optional="YES" attributeType="Date" usesScalarValueType="NO"/>
        <attribute name="remoteId" optional="YES" attributeType="String"/>
        <attribute name="imageData" optional="YES" attributeType="Binary"/>
        <attribute name="uploadTaskIdentifier" optional="NO" attributeType="Integer 64" defaultValueString="0"/>
        <relationship name="lineItems" optional="YES" toMany="YES" deletionRule="Cascade" destinationEntity="LineItem" inverseName="receipt" inverseEntity="LineItem"/>
    </entity>
    <entity name="LineItem" representedClassName="LineItem" syncable="YES">
        <attribute name="id" optional="YES" attributeType="UUID" usesScalarValueType="NO"/>
        <attribute name="name" optional="YES" attributeType="String"/>
        <attribute name="quantity" optional="NO" attributeType="Double" defaultValueString="1"/>
        <attribute name="unitPriceNumber" optional="YES" attributeType="Decimal"/>
        <attribute name="totalNumber" optional="YES" attributeType="Decimal"/>
        <attribute name="category" optional="YES" attributeType="String"/>
        <relationship name="receipt" optional="YES" minCount="0" maxCount="1" deletionRule="Nullify" destinationEntity="Receipt" inverseName="lineItems" inverseEntity="Receipt"/>
    </entity>
    <elements>
        <element name="Receipt" positionX="-63" positionY="-18" width="128" height="270"/>
        <element name="LineItem" positionX="-63" positionY="306" width="128" height="180"/>
    </elements>
</model>
EOF

cat > /workspace/.gitignore <<\"EOF\"
# Xcode
.DS_Store
build/
DerivedData/
*.xcworkspace
*.xcuserdatad/
*.xccheckout
*.moved-aside
*.xcuserstate
*.swp
*.lock
index.lock
*.xcscmblueprint

# SwiftPM
/.build/
Packages/
Package.resolved

# CocoaPods
Pods/
Podfile.lock

# Carthage
Carthage/Build/

# fastlane
fastlane/report.xml
fastlane/Preview.html
fastlane/screenshots
fastlane/test_output

# Archives
*.xcarchive

# User-specific
*.perspectivev3
xcuserdata/
EOF

cat > /workspace/LICENSE <<\"EOF\"
MIT License

Copyright (c) 2025

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the “Software”), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
EOF

cat > /workspace/Package.swift <<\"EOF\"
// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "ReceiptInboxSupport",
    platforms: [
        .iOS(.v17)
    ],
    products: [
        .library(name: "ReceiptInboxSupport", targets: ["ReceiptInboxSupport"])
    ],
    targets: [
        .target(
            name: "ReceiptInboxSupport",
            path: "Sources",
            exclude: [
                "ReceiptInboxApp.swift",
                "ContentView.swift",
                "Models",
                "ViewModels",
                "Services",
                "Views",
                "Info.plist",
                "ReceiptModel.xcdatamodeld"
            ]
        )
    ]
)
EOF

# Remaining Swift files for services and views already created above

# Add missing imports for SwiftUI code referencing UIKit
cat > /workspace/Sources/Views/_Imports.swift <<\"EOF\"
import Foundation
import SwiftUI
import UIKit
EOF

# Add missing files: Views/ReceiptDetailView.swift and others already added.

# Git add, commit, and push
branch=$(git branch --show-current)
if [ -z "$branch" ]; then
  git checkout -b main
  branch=main
fi

git add -A
if git diff --cached --quiet; then
  echo "No changes to commit"
else
  git commit -m "feat: add iOS Receipt Inbox project structure and files (SwiftUI, Core Data, VisionKit, background uploads)"
fi

git push -u origin "$branch"
