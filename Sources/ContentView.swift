import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var context
    @EnvironmentObject private var uploadManager: UploadManager

    @State private var isShowingScanner = false

    var body: some View {
        TabView {
            NavigationStack {
                ReceiptListView()
                    .navigationTitle("Inbox")
                    .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button { isShowingScanner = true } label: { Image(systemName: "camera.viewfinder") }
                                .accessibilityLabel("Scan Receipt")
                        }
                    }
            }
            .tabItem { Label("Inbox", systemImage: "tray.full") }

            NavigationStack { ScannerEntryView(isShowingScanner: ).navigationTitle("Scan") }
                .tabItem { Label("Scan", systemImage: "camera") }

            NavigationStack { SettingsView().navigationTitle("Settings") }
                .tabItem { Label("Settings", systemImage: "gearshape") }
        }
        .sheet(isPresented: ) {
            DocumentScannerView { result in
                isShowingScanner = false
                switch result {
                case .success(let images):
                    guard let first = images.first, let data = first.jpegData(compressionQuality: 0.9) else { return }
                    context.perform {
                        let receipt = Receipt(context: context)
                        receipt.id = UUID()
                        receipt.createdAt = Date()
                        receipt.updatedAt = Date()
                        receipt.status = .pending
                        receipt.uploadAttempts = 0
                        receipt.imageData = data
                        do { try context.save(); uploadManager.enqueuePendingUploads() } catch { print("Save error: \(error)") }
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
            Image(systemName: "doc.text.viewfinder").font(.system(size: 60)).foregroundStyle(.tint)
            Text("Scan your receipt").font(.title2).bold()
            Text("Use the camera to capture a receipt. It will be analyzed automatically and stored offline.").font(.callout).multilineTextAlignment(.center).foregroundStyle(.secondary)
            Button { isShowingScanner = true } label: { Label("Open Scanner", systemImage: "camera.viewfinder").frame(maxWidth: .infinity) }
                .buttonStyle(.borderedProminent).padding(.horizontal)
            Spacer()
        }.padding()
    }
}

private struct ReceiptListView: View {
    @Environment(\.managedObjectContext) private var context
    @EnvironmentObject private var uploadManager: UploadManager

    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Receipt.createdAt, ascending: false)], animation: .default)
    private var receipts: FetchedResults<Receipt>

    var body: some View {
        List {
            ForEach(receipts) { receipt in
                NavigationLink { ReceiptDetailView(receipt: receipt) } label: {
                    ReceiptRowView(receipt: receipt).environmentObject(uploadManager)
                }
            }.onDelete(perform: delete)
        }
        .overlay {
            if receipts.isEmpty { ContentUnavailableView("No Receipts", systemImage: "tray", description: Text("Scan a receipt to get started.")) }
        }
        .toolbar { EditButton() }
    }

    private func delete(at offsets: IndexSet) {
        for index in offsets { context.delete(receipts[index]) }
        do { try context.save() } catch { print("Delete error: \(error)") }
    }
}
