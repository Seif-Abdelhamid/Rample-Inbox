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
- 
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
