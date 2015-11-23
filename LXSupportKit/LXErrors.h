//
//  LXErrors.h
//  LXSupportKit
//
//  Created by Stan Chang Khin Boon on 5/6/15.
//  Copyright (c) 2015 lxcid. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "LXDefines.h"

LXSUPPORTKIT_EXTERN NSString * const LXSupportKitErrorDomain;

/// `LXErrorCode` codes are used for errors in the domain `LXSupportKitErrorDomain`.
typedef NS_ENUM(NSInteger, LXErrorCode) {
    /// The operation is in an invalid state and could not continue.
    LXErrorCodeInvalidState = 1,
};
