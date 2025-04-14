import AppKit
import SwiftUI

struct MainView: View {
    var viewModel: MainViewModel = .init()

    @State
    var error: String?

    @State
    var isPresentedError: Bool = false

    var body: some View {
        Image(nsImage: NSApplication.shared.applicationIconImage)
            .resizable()
            .frame(width: 100, height: 100)

        Form {
            Section {
                HStack {
                    Text("Install Helper")

                    Spacer()

                    Button {
                        Task {
                            do {
                                try await viewModel.installHelper()
                            } catch {
                                print(error)
                                self.error = "\(error)"
                                self.isPresentedError = true
                            }
                        }
                    } label: {
                        if viewModel.isHelperConnected {
                            Image(systemName: "checkmark.circle.fill")
                                .foregroundColor(.green)
                                .font(.title2)
                        } else {
                            Image(systemName: "arrow.down.circle.fill")
                                .foregroundColor(.blue)
                                .font(.title2)
                        }
                    }
                }
                .buttonStyle(PlainButtonStyle())
            }
        }
        .formStyle(.grouped)
        .alert("Error", isPresented: $isPresentedError, presenting: error) { _ in
            Text("OK")
        } message: { error in
            Text("\(error)")
        }
        .frame(minWidth: 300)
    }
}

@available(macOS 14.0, *)
#Preview {
    MainView()
}
