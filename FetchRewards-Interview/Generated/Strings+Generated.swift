// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum L10n {
  internal enum Alert {
    /// OK
    internal static let defaultAction = L10n.tr("Localizable", "alert.defaultAction", fallback: "OK")
    /// MealsDB
    internal static let title = L10n.tr("Localizable", "alert.title", fallback: "MealsDB")
  }
  internal enum Loading {
    internal enum Screen {
      internal enum Loading {
        /// Loading...
        internal static let status = L10n.tr("Localizable", "loading.screen.loading.status", fallback: "Loading...")
      }
    }
  }
  internal enum Meal {
    internal enum Details {
      internal enum Section {
        internal enum Header {
          /// Ingredients
          internal static let ingredients = L10n.tr("Localizable", "meal.details.section.header.ingredients", fallback: "Ingredients")
          /// Instructions
          internal static let instructions = L10n.tr("Localizable", "meal.details.section.header.instructions", fallback: "Instructions")
        }
      }
    }
  }
  internal enum Meals {
    internal enum List {
      /// Desserts
      internal static let title = L10n.tr("Localizable", "meals.list.title", fallback: "Desserts")
      internal enum Refreshcontrol {
        /// Fetching recipes...
        internal static let title = L10n.tr("Localizable", "meals.list.refreshcontrol.title", fallback: "Fetching recipes...")
      }
    }
  }
  internal enum UserFriendlyError {
    /// Sorry, something went wrong. Please try again.
    internal static let generic = L10n.tr("Localizable", "userFriendlyError.generic", fallback: "Sorry, something went wrong. Please try again.")
    /// Please check your network connection and try again.
    internal static let offline = L10n.tr("Localizable", "userFriendlyError.offline", fallback: "Please check your network connection and try again.")
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg..., fallback value: String) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: value, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
