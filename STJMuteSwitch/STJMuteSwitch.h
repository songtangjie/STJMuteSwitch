//
//  STJMuteSwitch.h
//  STJMuteSwitch
//
//  Created by william on 2019/11/26.
//  Copyright © 2019 william. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol STJMuteSwitchDelegate <NSObject>

- (void)isMuted:(BOOL)muted;

@end

@interface STJMuteSwitch : NSObject

/**
 Your delegate
 */
@property (nonatomic, weak) id<STJMuteSwitchDelegate> delegate;

/** Creates a shared instance
 */
+ (STJMuteSwitch *)sharedInstance;

/** Determines if the device is muted, wait for delegate callback using isMuted: on your delegate.
 */
- (void)detectMuteSwitch;

@end

NS_ASSUME_NONNULL_END
