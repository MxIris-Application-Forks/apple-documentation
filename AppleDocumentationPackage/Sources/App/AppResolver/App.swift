import Foundation
import SwiftUI
import Router
import AppleDocClient
import AppleDocClientLive
import RootPage
import AllTechnologiesPage

public struct App: SwiftUI.App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) private var appDelegate

    public init() {}

    public var body: some Scene {
        WindowGroup {
            RootPage()
                .environment(\.router, appDelegate.router)
                .environment(\.appleDocClient, appDelegate.appleDocClient)
        }
    }
}

private final class AppDelegate: UIResponder, UIApplicationDelegate {
    lazy var router = Router(provider: RoutingProviderImpl())

    lazy var appleDocClient = AppleDocClient.live(session: .shared)
}

private struct RoutingProviderImpl: RoutingProvider {
    func route(for target: any Routing) -> some View {
        switch target {
        case is Routings.AllTechnologiesPage:
            AllTechnologiesPage()

        default:
            Text("unhandled route: \(String(describing: target))")
        }
    }
}
