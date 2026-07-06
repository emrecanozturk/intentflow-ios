import SwiftUI

struct DemoRootView: View {
    var body: some View {
        TabView {
            LoginDemoScreen()
                .tabItem {
                    Label("Login", systemImage: "person.crop.circle")
                }

            CheckoutDemoScreen()
                .tabItem {
                    Label("Checkout", systemImage: "creditcard")
                }

            PermissionDemoScreen()
                .tabItem {
                    Label("Permission", systemImage: "hand.raised")
                }

            ExampleIndexScreen()
                .tabItem {
                    Label("More", systemImage: "square.grid.2x2")
                }
        }
    }
}
