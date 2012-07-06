

#import <Foundation/Foundation.h>
#import "JRCaptureObject.h"
#import "JRCaptureUser.h"
#import "JRCaptureError.h"

typedef enum
{
    JRNativeSigninNone = 0,
    JRNativeSigninUsernamePassword,
    JRNativeSigninEmailPassword,
} JRNativeSigninType;

typedef enum
{
    JRCaptureRecordNewlyCreated,           // now it exists, and it is new
    JRCaptureRecordExists,                //IsExisting, // present?? // already created, not new
    JRCaptureRecordMissingRequiredFields, // not created, does not exist
} JRCaptureRecordStatus;

@class JRActivityObject;

//- (void)updateDidSucceedForObject:(JRCaptureObject *)object context:(NSObject *)context;
//- (void)updateDidFailForObject:(JRCaptureObject *)object withError:(NSError *)error context:(NSObject *)context;

@protocol JRCaptureAuthenticationDelegate <NSObject>
@optional

- (void)engageAuthenticationDialogDidFailToShowWithError:(NSError*)error;

- (void)engageAuthenticationDidNotComplete;


- (void)engageAuthenticationDidSucceedForUser:(NSDictionary *)engageAuthInfo forProvider:(NSString *)provider;

- (void)captureAuthenticationDidSucceedForUser:(JRCaptureUser*)captureUser withToken:(NSString *)captureToken
                                     andStatus:(JRCaptureRecordStatus)status;

- (void)engageAuthenticationDidFailWithError:(NSError*)error forProvider:(NSString*)provider;

- (void)captureAuthenticationDidFailWithError:(NSError*)error forProvider:(NSString*)provider;

@end

@protocol JRCaptureSocialSharingDelegate <JRCaptureAuthenticationDelegate>
@optional
- (void)engageSharingDialogDidFailToShowWithError:(NSError*)error;

//- (void)jrSocialDidNotCompletePublishing;
- (void)socialSharingDidNotComplete;

//- (void)jrSocialDidCompletePublishing;
- (void)socialSharingDidComplete;

//- (void)jrSocialDidPublishActivity:(JRActivityObject*)activity forProvider:(NSString*)provider;
- (void)socialSharingDidSucceedForActivity:(JRActivityObject*)activity onProvider:(NSString*)provider;

- (void)socialSharingDidFailForActivity:(JRActivityObject*)activity withError:(NSError*)error onProvider:(NSString*)provider;

@end

@interface JRCapture : NSObject

+ (void)setCaptureApiDomain:(NSString *)newCaptureApidDomain captureUIDomain:(NSString *)newCaptureUIDomain
                   clientId:(NSString *)newClientId andEntityTypeName:(NSString *)newEntityTypeName;

+ (void)setEngageAppId:(NSString *)appId;

+ (void)setEngageAppId:(NSString *)appId captureApiDomain:(NSString *)newCaptureApidDomain
       captureUIDomain:(NSString *)newCaptureUIDomain clientId:(NSString *)newClientId
     andEntityTypeName:(NSString *)newEntityTypeName;

+ (NSString *)captureMobileEndpointUrl;
+ (void)setAccessToken:(NSString *)newAccessToken;
+ (void)setCreationToken:(NSString *)newCreationToken;


+ (void)startAuthenticationForDelegate:(id<JRCaptureAuthenticationDelegate>)delegate;

+ (void)startAuthenticationWithNativeSignin:(JRNativeSigninType)nativeSigninState
                                forDelegate:(id<JRCaptureAuthenticationDelegate>)delegate;

+ (void)startAuthenticationDialogOnProvider:(NSString*)provider
                                forDelegate:(id<JRCaptureAuthenticationDelegate>)delegate;


+ (void)startAuthenticationDialogWithNativeSignin:(JRNativeSigninType)nativeSigninState
                      andCustomInterfaceOverrides:(NSDictionary*)customInterfaceOverrides
                                      forDelegate:(id<JRCaptureAuthenticationDelegate>)delegate;

+ (void)startAuthenticationDialogOnProvider:(NSString*)provider
               withCustomInterfaceOverrides:(NSDictionary*)customInterfaceOverrides
                                forDelegate:(id<JRCaptureAuthenticationDelegate>)delegate;

+ (void)startSocialPublishingDialogWithActivity:(JRActivityObject*)activity
                                    forDelegate:(id<JRCaptureSocialSharingDelegate>)delegate;

+ (void)startSocialPublishingDialogWithActivity:(JRActivityObject*)activity
                   withCustomInterfaceOverrides:(NSDictionary*)customInterfaceOverrides
                                    forDelegate:(id<JRCaptureSocialSharingDelegate>)delegate;

@end
