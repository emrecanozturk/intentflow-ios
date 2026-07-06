import SwiftUI

struct ExampleIndexScreen: View {
    var body: some View {
        NavigationStack {
            List {
                Section("Source Examples") {
                    Label("SwiftUI Device Connection", systemImage: "iphone.gen3")
                    Label("UIKit Upload Retry", systemImage: "arrow.up.doc")
                }

                Section("Architecture") {
                    Label("Core mode: human-first workflow architecture", systemImage: "flowchart")
                    Label("AI mode: manifest, rules, traces, validator", systemImage: "sparkles")
                }
            }
            .navigationTitle("IntentFlow")
        }
    }
}
