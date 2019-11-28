//
//  STJMuteSwitch.m
//  STJMuteSwitch
//
//  Created by william on 2019/11/26.
//  Copyright © 2019 william. All rights reserved.
//

#import "STJMuteSwitch.h"
#include <AudioToolbox/AudioToolbox.h>

@interface STJMuteSwitch ()

// 定时器
@property (nonatomic, strong) NSTimer *playbackTimer;
// 计数器
@property (nonatomic, assign) float soundDuration;

@end

@implementation STJMuteSwitch

#pragma mark - share
+ (STJMuteSwitch *)sharedInstance
{
    static STJMuteSwitch *shared = nil;
    static dispatch_once_t once = 0;
    dispatch_once(&once, ^{
        shared = [[STJMuteSwitch alloc] init];
    });
    return shared;
}

#pragma mark - Public Api
/// start
- (void)detectMuteSwitch
{
#if TARGET_IPHONE_SIMULATOR
    // The simulator doesn't support detection and can cause a crash so always return muted
    if ([self.delegate respondsToSelector:@selector(isMuted:)]) {
        [self.delegate isMuted:YES];
    }
    return;
#endif
    
    // iOS 5+ doesn't allow mute switch detection using state length detection
    // So we need to play a blank 100ms file and detect the playback length
    self.soundDuration = 0.0;
    
    SystemSoundID soundFileObject;
 
    NSURL *path = [[NSBundle bundleForClass:[self class]] URLForResource:@"detection" withExtension:@"aiff"];

    // Create a system sound object representing the sound file
    AudioServicesCreateSystemSoundID (
                                      (__bridge CFURLRef _Nonnull)(path),
                                      &soundFileObject
                                      );
    
    AudioServicesAddSystemSoundCompletion (soundFileObject,NULL,NULL,
                                           soundCompletionCallback,
                                           (__bridge void*) self);
    
    if (self.playbackTimer) {
        [self.playbackTimer invalidate];
        self.playbackTimer = nil;
    }
    // Start the playback timer
    self.playbackTimer = [NSTimer scheduledTimerWithTimeInterval:0.001 target:self selector:@selector(incrementTimer) userInfo:nil repeats:YES];
    // Play the sound
    AudioServicesPlaySystemSound(soundFileObject);
}

#pragma mark - PlaybackComplete
/// complete do something
- (void)playbackComplete
{
    if ([self.delegate respondsToSelector:@selector(isMuted:)]) {
        // If playback is far less than 10ms then we know the device is muted
//        NSLog(@"%f",self.soundDuration);
        [self.delegate isMuted:self.soundDuration < 0.010];
    }
    
    if (self.playbackTimer) {
        [self.playbackTimer invalidate];
        self.playbackTimer = nil;
    }
}

#pragma mark - Timer
/// Time Event
- (void)incrementTimer
{
    self.soundDuration += 0.001;
}

#pragma mark - Private Api
/// soundCompletionCallback
static void soundCompletionCallback (SystemSoundID mySSID, void* myself)
{
    AudioServicesDisposeSystemSoundID(mySSID);
    AudioServicesRemoveSystemSoundCompletion(mySSID);
    [[STJMuteSwitch sharedInstance] playbackComplete];
}

@end
