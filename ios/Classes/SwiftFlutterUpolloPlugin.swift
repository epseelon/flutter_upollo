import Flutter
import UIKit
import Userwatch

public class SwiftFlutterUpolloPlugin: NSObject, FlutterPlugin {
    var userwatch: UserwatchClient?

    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "flutter_upollo", binaryMessenger: registrar.messenger())
        let instance = SwiftFlutterUpolloPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }

    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch (call.method) {
        case "getPlatformVersion":
            result("iOS " + UIDevice.current.systemVersion)
        case "init":
            let arguments = call.arguments as! Dictionary<String, Any>
            do {
                userwatch = try UserwatchClient(publicApiKey: arguments["publicApiKey"] as! String)
                result(nil)
            } catch {
                result(FlutterError.init(code: "INIT_ERROR", message: "Could not initialize Userwatch", details: error))
            }
        case "assess":
            if (userwatch == nil) {
                result(FlutterError.init(code: "NOT_INITIALIZED", message: "You need to call init before assess", details: nil))
            } else {
                let arguments = call.arguments as! [String: Any]
                let eventType = Uwproto_EventType(rawValue: arguments["eventType"] as! Int)

                let userInfoMap = arguments["userInfo"] as! [String: Any]
                var userInfo = Uwproto_UserInfo()
                userInfo.userID = userInfoMap["userId"] as? String ?? ""
                userInfo.userName = userInfoMap["userName"] as? String ?? ""
                userInfo.userEmail = userInfoMap["userEmail"] as? String ?? ""
                userInfo.userPhone = userInfoMap["userPhone"] as? String ?? ""
                userInfo.userImage = userInfoMap["userImage"] as? String ?? ""
                userInfo.customerSuppliedValues = userInfoMap["customerSuppliedValues"] as? [String: String] ?? [:]

                userwatch?.assess(userinfo: userInfo, did: eventType!, callback: { response in
                    result([
                        "action": response.action.rawValue,
                        "flags": response.flags.map { flag in [
                            "type": flag.type.rawValue,
                            "firstFlagged": flag.firstFlagged.seconds,
                            "mostRecentlyFlagged": flag.mostRecentlyFlagged.seconds,
                        ]},
                        "usingVpn": response.isUsingVpn,
                        "usingTor": response.isUsingTor,
                        "userInfo": [
                            "userId": response.userInfo.userID,
                            "userEmail": response.userInfo.userEmail,
                            "userPhone": response.userInfo.userPhone,
                            "userName": response.userInfo.userName,
                            "userImage": response.userInfo.userImage,
                            "customerSuppliedValues": response.userInfo.customerSuppliedValues,
                            "addresses": response.userInfo.addresses.map { address in
                                [
                                    "type": address.type.rawValue,
                                    "address": [
                                        "revision": address.address.revision,
                                        "regionCode": address.address.regionCode,
                                        "languageCode": address.address.languageCode,
                                        "postalCode": address.address.postalCode,
                                        "sortingCode": address.address.sortingCode,
                                        "administrativeArea": address.address.administrativeArea,
                                        "locality": address.address.locality,
                                        "sublocality": address.address.sublocality,
                                        "addressLines": address.address.addressLines,
                                        "recipients": address.address.recipients,
                                        "organization": address.address.organization,
                                    ]
                                ]
                            },
                        ],
                        "deviceInfo": [
                            "deviceId": response.deviceInfo.deviceID,
                            "os": response.deviceInfo.os,
                            "deviceClass": response.deviceInfo.deviceClass.rawValue,
                            "deviceName": response.deviceInfo.deviceName,
                            "userAgent": response.deviceInfo.userAgent,
                            "browser": response.deviceInfo.browser,
                            "lastUsed": response.deviceInfo.lastUsed.seconds,
                            "blockedGlobally": response.deviceInfo.blockedGlobally,
                            "blockedForThisUser": response.deviceInfo.blockedForThisUser,
                        ] as [String: Any],
                        "geoInfo": [
                            "geoIpLatLng": [
                                "latitude": response.geoInfo.geoIpLatlng.latitude,
                                "longitude": response.geoInfo.geoIpLatlng.longitude,
                            ],
                            "geoIpCity": response.geoInfo.geoIpCity,
                            "geoIpSubregion": response.geoInfo.geoIpSubregion,
                            "geoIpRegion": response.geoInfo.geoIpRegion,
                            "lastHere": response.geoInfo.lastHere.seconds,
                        ] as [String: Any],
                        "supportedChallenges": response.supportedChallenges.map { type in
                            type.rawValue
                        },
                        "requestId": response.requestID,
                        "eventType": response.eventType.rawValue,
                    ] as [String: Any])
                }, failure: { error in
                    result(FlutterError.init(
                            code: "TRACK_ERROR",
                            message: "Error while tracking: ${exception.message}",
                            details: error
                    ))
                })
            }
        case "track":
            if (userwatch == nil) {
                result(FlutterError.init(code: "NOT_INITIALIZED", message: "You need to call init before track", details: nil))
            } else {
                let arguments = call.arguments as! [String: Any]
                let eventType = Uwproto_EventType(rawValue: arguments["eventType"] as! Int)

                let userInfoMap = arguments["userInfo"] as! [String: Any]
                var userInfo = Uwproto_UserInfo()
                userInfo.userID = userInfoMap["userId"] as? String ?? ""
                userInfo.userName = userInfoMap["userName"] as? String ?? ""
                userInfo.userEmail = userInfoMap["userEmail"] as? String ?? ""
                userInfo.userPhone = userInfoMap["userPhone"] as? String ?? ""
                userInfo.userImage = userInfoMap["userImage"] as? String ?? ""
                userInfo.customerSuppliedValues = userInfoMap["customerSuppliedValues"] as? [String: String] ?? [:]

                userwatch?.track(userinfo: userInfo, did: eventType!, callback: { response in
                    result([
                        "eventToken": response.eventToken
                    ])
                }, failure: { error in
                    result(FlutterError.init(
                            code: "TRACK_ERROR",
                            message: "Error while tracking: ${exception.message}",
                            details: error
                    ))
                })
            }
        default:
            result(FlutterMethodNotImplemented)
        }
    }
}
