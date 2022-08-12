#import "FlutterUpolloPlugin.h"
#if __has_include(<flutter_upollo/flutter_upollo-Swift.h>)
#import <flutter_upollo/flutter_upollo-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "flutter_upollo-Swift.h"
#endif

@implementation FlutterUpolloPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftFlutterUpolloPlugin registerWithRegistrar:registrar];
}
@end
