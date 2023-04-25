//
//  Generated file. Do not edit.
//

// clang-format off

#import "GeneratedPluginRegistrant.h"

#if __has_include(<dialogflow_grpc/DialogflowGrpcPlugin.h>)
#import <dialogflow_grpc/DialogflowGrpcPlugin.h>
#else
@import dialogflow_grpc;
#endif

#if __has_include(<path_provider_foundation/PathProviderPlugin.h>)
#import <path_provider_foundation/PathProviderPlugin.h>
#else
@import path_provider_foundation;
#endif

@implementation GeneratedPluginRegistrant

+ (void)registerWithRegistry:(NSObject<FlutterPluginRegistry>*)registry {
  [DialogflowGrpcPlugin registerWithRegistrar:[registry registrarForPlugin:@"DialogflowGrpcPlugin"]];
  [PathProviderPlugin registerWithRegistrar:[registry registrarForPlugin:@"PathProviderPlugin"]];
}

@end
