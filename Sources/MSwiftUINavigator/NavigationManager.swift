//
//  NavigationManager.swift
//  MNavigator
//
//  Created by Mahmoud Abdelshafi on 01/09/2023.
//

import Foundation
import SwiftUI
import UIKit
import FittedSheets

public protocol Navigator: View {
    // In a view where you want to use a navigator, the view must implement [AppNavigator].
    // It should be implemented in the main screen.
}

// MARK: - Shared value-

extension Navigator {
    /// The shared instance of the `NavigationManager`.
    public var navigator: NavigationManager {
        return NavigationManager.shared
    }
}

public extension EnvironmentValues {
    /// The shared instance of the `NavigationManager`.
    var navigator: NavigationManager {
        return NavigationManager.shared
    }
}

// MARK: - Enum PopPositionType -

public enum PopPositionType {
    case first, last
}

// MARK: - NavigationManager -

/// This Swift file defines a navigation solution for SwiftUI applications, leveraging the UIKit navigation system. It provides a set of functions and extensions under the `NavigationManager` struct to facilitate common navigation tasks such as presenting views, pushing views, handling sheets, dialogs, and action sheets, as well as managing the app's navigation stack.

/// The `NavigationManager` struct is designed to simplify and streamline the navigation logic within SwiftUI views, making it easier to navigate between different screens, present modals, and manage the navigation stack. It also includes utility functions for finding and retrieving the current navigation controller within the app's view controller hierarchy.

/// This navigation solution integrates seamlessly with SwiftUI views and can be used to create sophisticated navigation flows in your SwiftUI-based iOS applications while harnessing the power of UIKit's navigation capabilities.

/// Note: This file assumes that UIKit is used for navigation, and it provides a bridge between SwiftUI and UIKit for handling navigation tasks effectively.

public struct NavigationManager {
    /// The shared instance of the `NavigationManager`.
    public static let shared = NavigationManager()
    
    private init() {}
    
    /// Reset the root window of the app with a new view.
    ///
    /// - Parameters:
    ///   - rootView: A closure that returns the root view.
    public func resetRootWindow<T: View>(rootView: () -> T) {
        let window =  UIApplication.shared.keyWindowScene
        window.isHidden = false
        let hostingVC = UIHostingController(rootView: RootApp(view: rootView()))
        let mainNavVC = UINavigationController(rootViewController: hostingVC)
        mainNavVC.navigationBar.isHidden = true
        window.rootViewController = mainNavVC
        window.makeKeyAndVisible()
    }
    
    /// Push a new view above the current view.
    ///
    /// - Parameters:
    ///   - view: A closure that returns the view to push.
    ///   - animated: Optional. Whether to animate the transition. Default is true.
    public func pushView<T: View>(view: () -> T,
                                  animated: Bool? = nil) {
        let nav = NavigationManager.getCurrentNavigationController()
        let swipView = view().onBackSwipe {
            dismiss()
        }
        nav?.pushViewController(UIHostingController(rootView: swipView), animated: animated ?? true)
    }
    
    /// Present a new view above the current view with custom transition and presentation styles.
    ///
    /// - Parameters:
    ///   - transitionStyle: Optional. The transition style. Default is .coverVertical.
    ///   - presentStyle: Optional. The presentation style. Default is .fullScreen.
    ///   - animated: Optional. Whether to animate the presentation. Default is true.
    ///   - view: A closure that returns the view to present.
    public func presentView<T: View>(transitionStyle: UIModalTransitionStyle? = nil,
                                     presentStyle: UIModalPresentationStyle? = nil,
                                     animated: Bool? = nil, view: () -> T) {
        guard let topViewController = UIApplication.shared.topViewController()
        else {
            return
        }
        topViewController.modalTransitionStyle = transitionStyle ?? .coverVertical
        topViewController.modalPresentationStyle = presentStyle ?? .fullScreen
        topViewController.present(UIHostingController(rootView: view()), animated: animated ?? true)
    }
    
    /// Dismiss the current view.
    ///
    /// - Parameters:
    ///   - animated: Optional. Whether to animate the dismissal. Default is true.
    ///   - completion: Optional. A closure to be called upon completion of dismissal.
    public func dismiss(animated: Bool? = nil,
                        completion: (() -> Void)? = nil) {
        guard let topViewController = UIApplication.shared.topViewController()
        else {
            return
        }
        guard let navigation = topViewController.navigationController else {
            topViewController.dismiss(animated: animated ?? true)
            return
        }
        navigation.popViewController(animated: animated ?? true)
    }
    
    /// Pop to the root view.
    ///
    /// - Parameters:
    ///   - animated: Optional. Whether to animate the transition. Default is true.
    public func popToRootView(animated: Bool? = nil) {
        let nav = NavigationManager.getCurrentNavigationController()
        nav?.popToRootViewController(animated: animated ?? true)
    }
    
    /// Present a sheet above the current view with customizable sizes using the FittedSheets library.
    ///
    /// - Parameters:
    ///   - sizes: Optional. An array of `SheetSize` options. Default is [.intrinsic].
    ///   - view: A closure that returns the view to present as a sheet.
    ///
    /// Note: This function utilizes the FittedSheets library available at: https://github.com/gordontucker/FittedSheets
    ///
    /// Example usage:
    ///
    /// ```swift
    /// navigator.presentSheet(sizes: [.fixed(300)], view: {
    ///     CustomSheetContentView()
    /// })
    /// ```
    ///
    /// - Important: Make sure to include the FittedSheets library in your project for this function to work.
    public func presentSheet<T: View>(sizes: [SheetSize] = [.intrinsic],
                                      view: () -> T) {
        let appHostingController =  UIHostingController(rootView: view())
        appHostingController.view.backgroundColor = UIColor.clear

        var options = SheetOptions()
        options.pullBarHeight = 0
        options.shouldExtendBackground = false
        options.useFullScreenMode = false
        options.shrinkPresentingViewController = false

        let sheet = SheetViewController(controller: appHostingController,
                                        sizes: sizes, options: options)
        sheet.treatPullBarAsClear = true
        sheet.overlayColor = UIColor.black.withAlphaComponent(0.2)
        sheet.minimumSpaceAbovePullBar = 1
        sheet.cornerRadius = 30
        sheet.gripSize = CGSize(width: 142, height: 0)
        sheet.gripColor = UIColor.clear
        let window = UIApplication.shared.windows.first
        /// adjust bottom pading from safearea
        let bottomPadding = window?.safeAreaInsets.bottom
        sheet.additionalSafeAreaInsets = UIEdgeInsets(top: 0,
                                                      left: 0,
                                                      bottom: -(bottomPadding ?? 0), right: 0)

        sheet.contentViewController.contentBackgroundColor = .clear
        sheet.contentViewController.childViewController.view.backgroundColor = .clear
        sheet.contentViewController.view.backgroundColor = .clear

        let nav = NavigationManager.getCurrentNavigationController()
        nav?.present(sheet, animated: true, completion: nil)
    }
    
    /// Dismiss the currently presented sheet.
    ///
    /// - Parameters:
    ///   - animated: Optional. Whether to animate the dismissal. Default is true.
    ///   - completion: Optional. A closure to be called upon completion of dismissal.
    public func dismissSheet(animated: Bool? = nil,
                             completion: (() -> Void)? = nil) {
        dismiss()
    }
    
    /// Present a dialog above the current view.
    ///
    /// - Parameters:
    ///   - view: A closure that returns the view to present as a dialog.
    ///   - animated: Optional. Whether to animate the presentation. Default is false.
    public func presentDialog<T: View>(view: @escaping () -> T,
                                       animated: Bool? = nil) {
        let dialog = EmptyView()
            .presentAsNavigatorDialog(dialogContent: view)
            .ignoresSafeArea()
            .background(Color.black.opacity(0.0))
        let hostingController = UIHostingController(rootView: dialog)
        hostingController.view.backgroundColor = .clear
        hostingController.modalPresentationStyle =  .overCurrentContext
        guard let topViewController = UIApplication.shared.topViewController() else { return }
        topViewController.present(hostingController, animated: false)
    }
    
    /// Present an action sheet above the current view.
    ///
    /// - Parameters:
    ///   - actionSheet: A closure that returns the action sheet content.
    ///   - animated: Optional. Whether to animate the presentation. Default is false.
    public func presentActionSheet(actionSheet: @escaping () -> ActionSheet,
                                   animated: Bool? = nil) {
        let actionSheet = EmptyView()
            .presentAsNavigatorActionSheet(actionSheetContent: actionSheet)
            .ignoresSafeArea()
            .background(Color.clear)
        let hostingController = UIHostingController(rootView: actionSheet)
        hostingController.view.backgroundColor = .clear
        hostingController.view.isOpaque = false
        hostingController.modalPresentationStyle =  .overCurrentContext
        guard let topViewController = UIApplication.shared.topViewController()
        else {
            return
        }
        topViewController.present(hostingController, animated: false)
    }
    
    /// Pop to a specific view type in the navigation stack.
    ///
    /// - Parameters:
    ///   - typeOfView: The type of view to pop to.
    ///   - animated: Optional. Whether to animate the transition. Default is true.
    ///   - inPosition: Optional. The position type to search for the view. Default is .last.
    public func popToView<T: View>(_ typeOfView: T.Type,
                                   animated: Bool? = nil,
                                   inPosition: PopPositionType? = .last) {
        let nav = NavigationManager.getCurrentNavigationController()
        
        switch inPosition {
        case .last:
            if let vc = nav?.viewControllers.last(where: { $0 is UIHostingController<T> }) {
                nav?.popToViewController(vc, animated: animated ?? true)
            }
        case .first:
            if let vc = nav?.viewControllers.first(where: { $0 is UIHostingController<T> }) {
                nav?.popToViewController(vc, animated: animated ?? true)
            }
        default:
            break
        }
    }
    
    /// Get the current root view of the app.
    ///
    /// - Returns: The root view as a `RootApp<AnyView>` if found, otherwise nil.
    public func getCurrentView() ->  RootApp<AnyView>? {
        let nav = NavigationManager.getCurrentNavigationController()
        if let viewController = nav?.viewControllers.last,
           let  hostingController = viewController as? UIHostingController<RootApp<AnyView>> {
            return hostingController.rootView
        }
        return nil
    }
    
}

/// Utility functions for finding and retrieving the current navigation controller.
extension NavigationManager {
    /// Recursively searches for a navigation controller in the view controller hierarchy.
    ///
    /// - Parameter viewController: The view controller to start the search from.
    /// - Returns: The found `UINavigationController` or `nil` if not found.
    private static func findNavigationController(viewController: UIViewController?) -> UINavigationController? {
        guard let viewController = viewController else {
            return nil
        }
        
        if let navigationController = viewController as? UINavigationController {
            return navigationController
        }
        
        for childViewController in viewController.children {
            return findNavigationController(viewController: childViewController)
        }
        
        return nil
    }
    
    /// Retrieves the current navigation controller for the app.
    ///
    /// - Returns: The current `UINavigationController` or `nil` if not found.
    private static func getCurrentNavigationController() -> UINavigationController? {
        let nav = findNavigationController(viewController: UIApplication.shared.windows.filter { $0.isKeyWindow }.first?.rootViewController)
        return nav
    }
    
}

