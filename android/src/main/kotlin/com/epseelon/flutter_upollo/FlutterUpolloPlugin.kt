/*
 * MIT License
 *
 * Copyright (c) 2022 Epseelon OÜ
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 */

package com.epseelon.flutter_upollo

import android.content.Context
import androidx.annotation.NonNull
import co.userwatch.a.m0
import co.userwatch.android.UserwatchClient
import co.userwatch.proto.*
import com.google.type.postalAddress
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

/** FlutterUpolloPlugin */
class FlutterUpolloPlugin : FlutterPlugin, MethodCallHandler {
    private lateinit var applicationContext: Context

    /// The MethodChannel that will the communication between Flutter and native Android
    ///
    /// This local reference serves to register the plugin with the Flutter Engine and unregister it
    /// when the Flutter Engine is detached from the Activity
    private lateinit var channel: MethodChannel

    private var userwatch: UserwatchClient? = null

    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "flutter_upollo")
        channel.setMethodCallHandler(this)
        applicationContext = flutterPluginBinding.applicationContext;
    }

    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
        when (call.method) {
            "getPlatformVersion" -> result.success("Android ${android.os.Build.VERSION.RELEASE}")
            "init" -> {
                val publicApiKey: String = call.argument<String>("publicApiKey")!!
                val options: Map<String, String>? = call.argument("options");
                userwatch = UserwatchClient(applicationContext, publicApiKey, options)
                result.success(null)
            }
            "assess" -> {
                if (userwatch == null) {
                    result.error("NOT_INITIALIZED", "You need to call init before assess", null)
                } else {
                    val eventType = EventType.forNumber(call.argument<Int>("eventType")!!)
                    val userInfoMap = call.argument<Map<String, Any>>("userInfo")
                    if (userInfoMap == null) {
                        result.error("MISSING_USER_INFO", "userInfo is not specified", null)
                    } else {
                        val csvMap = userInfoMap["customerSuppliedValues"]
                        val addressList = userInfoMap["addresses"]

                        @Suppress("UNCHECKED_CAST")
                        val userInfo = userInfo {
                            userId = userInfoMap["userId"] as String? ?: ""
                            userName = userInfoMap["userName"] as String? ?: ""
                            userEmail = userInfoMap["userEmail"] as String? ?: ""
                            userImage = userInfoMap["userImage"] as String? ?: ""
                            userPhone = userInfoMap["userPhone"] as String? ?: ""
                            if (csvMap != null && csvMap is Map<*, *> && csvMap.isNotEmpty()) {
                                customerSuppliedValues.putAll(csvMap as Map<String, String>)
                            }
                            if (addressList != null && addressList is List<*> && addressList.isNotEmpty()) {
                                addresses.addAll((addressList as List<Map<String, Any>>).map { physicalAddressMap ->
                                    val postalAddressMap = physicalAddressMap["address"] as Map<String, Any>

                                    physicalAddress {
                                        type = AddressType.forNumber(physicalAddressMap["type"] as Int)
                                        address = postalAddress {
                                            revision = postalAddressMap["revision"] as Int
                                            regionCode = postalAddressMap["regionCode"] as String
                                            languageCode = postalAddressMap["languageCode"] as String? ?: ""
                                            postalCode = postalAddressMap["postalCode"] as String? ?: ""
                                            sortingCode = postalAddressMap["sortingCode"] as String? ?: ""
                                            administrativeArea = postalAddressMap["administrativeArea"] as String? ?: ""
                                            locality = postalAddressMap["locality"] as String? ?: ""
                                            sublocality = postalAddressMap["sublocality"] as String? ?: ""
                                            if(postalAddressMap["addressLines"] != null) {
                                                addressLines.addAll(postalAddressMap["addressLines"] as List<String>)
                                            }
                                            if(postalAddressMap["recipients"] != null) {
                                                recipients.addAll(postalAddressMap["recipients"] as List<String>)
                                            }
                                            organization = postalAddressMap["organization"] as String? ?: ""
                                        }
                                    }
                                })
                            }
                        }
                        userwatch!!.assess(userInfo, eventType)
                            .handle { analysisResponse, exception ->
                                if (exception != null) {
                                    result.error(
                                        "ASSESS_ERROR",
                                        "Error while assessing: ${exception.message}",
                                        exception
                                    )
                                } else {
                                    val analysisResponseMap = mapOf(
                                        "action" to analysisResponse.action.number,
                                        "flags" to analysisResponse.flagsList.map { flag ->
                                            mapOf<String, Any?>(
                                                "type" to flag.type.number,
                                                "firstFlagged" to flag.firstFlaggedOrNull?.seconds,
                                                "mostRecentlyFlagged" to flag.mostRecentlyFlaggedOrNull?.seconds,
                                                "ignoredUntil" to flag.ignoredUntilOrNull?.seconds
                                            )
                                        },
                                        "usingVpn" to analysisResponse.isUsingVpn,
                                        "usingTor" to analysisResponse.isUsingTor,
                                        "userInfo" to mapOf<String, Any?>(
                                            "userId" to analysisResponse.userInfo.userId,
                                            "userEmail" to analysisResponse.userInfo.userEmail,
                                            "userPhone" to analysisResponse.userInfo.userPhone,
                                            "userName" to analysisResponse.userInfo.userName,
                                            "userImage" to analysisResponse.userInfo.userImage,
                                            "customerSuppliedValues" to analysisResponse.userInfo.customerSuppliedValuesMap,
                                            "addresses" to null,
                                            /*FIXME "addresses" to analysisResponse.userInfo.addressesList.map { address ->
                                                mapOf(
                                                    "type" to address.type.number,
                                                    "address" to mapOf(
                                                        "revision" to address.address.revision,
                                                        "regionCode" to,
                                                        "languageCode" to,
                                                        "postalCode" to,
                                                        "sortingCode" to,
                                                        "administrativeArea" to,
                                                        "locality" to,
                                                        "sublocality" to,
                                                        "addressLines" to,
                                                        "recipients" to,
                                                        "organization" to,
                                                    )
                                                )
                                            },*/
                                        ),
                                        "deviceInfo" to mapOf<String, Any?>(
                                            "deviceId" to analysisResponse.deviceInfo.deviceId,
                                            "os" to analysisResponse.deviceInfo.os,
                                            "deviceClass" to analysisResponse.deviceInfo.deviceClass.number,
                                            "deviceName" to analysisResponse.deviceInfo.deviceName,
                                            "userAgent" to analysisResponse.deviceInfo.userAgent,
                                            "browser" to analysisResponse.deviceInfo.browser,
                                            "lastUsed" to analysisResponse.deviceInfo.lastUsedOrNull?.seconds,
                                            "blockedGlobally" to analysisResponse.deviceInfo.blockedGlobally,
                                            "blockedForThisUser" to analysisResponse.deviceInfo.blockedForThisUser
                                        ),
                                        "geoInfo" to mapOf(
                                            "geoIpLatlng" to mapOf<String, Any>(
                                                "latitude" to analysisResponse.geoInfo.geoIpLatlng.latitude,
                                                "longitude" to analysisResponse.geoInfo.geoIpLatlng.longitude
                                            ),
                                            "geoIpCity" to analysisResponse.geoInfo.geoIpCity,
                                            "geoIpSubregion" to analysisResponse.geoInfo.geoIpSubregion,
                                            "geoIpRegion" to analysisResponse.geoInfo.geoIpRegion,
                                            "lastHere" to analysisResponse.geoInfo.lastHereOrNull?.seconds
                                        ),
                                        "supportedChallenges" to analysisResponse.supportedChallengesList.map { challengeType ->
                                            challengeType.number
                                        },
                                        "requestId" to analysisResponse.requestId,
                                        "eventType" to analysisResponse.eventType.number,
                                    )
                                    result.success(analysisResponseMap)
                                }
                            }.get()
                    }
                }
            }
            "track" -> {
                if (userwatch == null) {
                    result.error("NOT_INITIALIZED", "You need to call init before track", null)
                } else {
                    val eventType = EventType.forNumber(call.argument<Int>("eventType")!!)
                    val userInfoMap = call.argument<Map<String, Any>>("userInfo")
                    if (userInfoMap == null) {
                        result.error("MISSING_USER_INFO", "userInfo is not specified", null)
                    } else {
                        val userInfo = userInfo {
                            userId = userInfoMap["userId"] as String? ?: ""
                            userName = userInfoMap["userName"] as String? ?: ""
                            userEmail = userInfoMap["userEmail"] as String? ?: ""
                            userImage = userInfoMap["userImage"] as String? ?: ""
                            userPhone = userInfoMap["userPhone"] as String? ?: ""
                            //FIXME customerSuppliedValues
                            //FIXME addresses
                        }
                        userwatch!!.track(userInfo, eventType).handle { eventResponse, exception ->
                            if (exception != null) {
                                result.error(
                                    "TRACK_ERROR",
                                    "Error while tracking: ${exception.message}",
                                    exception
                                )
                            } else {
                                val eventResponseMap = mapOf<String, Any>(
                                    "eventToken" to eventResponse.eventToken
                                )
                                result.success(eventResponseMap)
                            }
                        }.get()
                    }
                }
            }
            else -> result.notImplemented()
        }
    }

    private fun decodeEventType(eventTypeString: String?): EventType? {
        return when (eventTypeString) {
            "unspecified" -> EventType.EVENT_TYPE_UNSPECIFIED
            "login" -> EventType.EVENT_TYPE_LOGIN
            "register" -> EventType.EVENT_TYPE_REGISTER
            "attemptPurchase" -> EventType.EVENT_TYPE_ATTEMPT_PURCHASE
            "completePurchase" -> EventType.EVENT_TYPE_COMPLETE_PURCHASE
            "attemptRedeemOffer" -> EventType.EVENT_TYPE_ATTEMPT_REDEEM_OFFER
            "redeemedOffer" -> EventType.EVENT_TYPE_REDEEMED_OFFER
            "verifyDevice" -> EventType.EVENT_TYPE_VERIFY_DEVICE
            "reportDevice" -> EventType.EVENT_TYPE_REPORT_DEVICE
            "addTeamMember" -> EventType.EVENT_TYPE_ADD_TEAM_MEMBER
            "removeTeamMember" -> EventType.EVENT_TYPE_REMOVE_TEAM_MEMBER
            "addPaymentMethod" -> EventType.EVENT_TYPE_ADD_PAYMENT_METHOD
            "attemptDeleteAccount" -> EventType.EVENT_TYPE_ATTEMPT_DELETE_ACCOUNT
            "customerDefined" -> EventType.EVENT_TYPE_CUSTOMER_DEFINED
            "startSubscription" -> EventType.EVENT_TYPE_START_SUBSCRIPTION
            "endSubscription" -> EventType.EVENT_TYPE_END_SUBSCRIPTION
            "heartbeat" -> EventType.EVENT_TYPE_HEARTBEAT
            "pageVisit" -> EventType.EVENT_TYPE_PAGE_VISIT
            "loginSuccess" -> EventType.EVENT_TYPE_LOGIN_SUCCESS
            "registerSuccess" -> EventType.EVENT_TYPE_REGISTER_SUCCESS
            "internal" -> EventType.EVENT_TYPE_INTERNAL
            else -> null
        }
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }
}
