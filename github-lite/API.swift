//  This file was automatically generated and should not be edited.

import Apollo

public final class UserQuery: GraphQLQuery {
  public static let operationString =
    "query User {\n  viewer {\n    __typename\n    login\n    name\n    avatarUrl\n  }\n}"

  public init() {
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Query"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("viewer", type: .nonNull(.object(Viewer.selections))),
    ]

    public var snapshot: Snapshot

    public init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    public init(viewer: Viewer) {
      self.init(snapshot: ["__typename": "Query", "viewer": viewer.snapshot])
    }

    /// The currently authenticated user.
    public var viewer: Viewer {
      get {
        return Viewer(snapshot: snapshot["viewer"]! as! Snapshot)
      }
      set {
        snapshot.updateValue(newValue.snapshot, forKey: "viewer")
      }
    }

    public struct Viewer: GraphQLSelectionSet {
      public static let possibleTypes = ["User"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("login", type: .nonNull(.scalar(String.self))),
        GraphQLField("name", type: .scalar(String.self)),
        GraphQLField("avatarUrl", type: .nonNull(.scalar(String.self))),
      ]

      public var snapshot: Snapshot

      public init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      public init(login: String, name: String? = nil, avatarUrl: String) {
        self.init(snapshot: ["__typename": "User", "login": login, "name": name, "avatarUrl": avatarUrl])
      }

      public var __typename: String {
        get {
          return snapshot["__typename"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "__typename")
        }
      }

      /// The username used to login.
      public var login: String {
        get {
          return snapshot["login"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "login")
        }
      }

      /// The user's public profile name.
      public var name: String? {
        get {
          return snapshot["name"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "name")
        }
      }

      /// A URL pointing to the user's public avatar.
      public var avatarUrl: String {
        get {
          return snapshot["avatarUrl"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "avatarUrl")
        }
      }
    }
  }
}