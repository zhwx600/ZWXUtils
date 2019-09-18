//
//  UIControl+ZSound.m
//  Pods
//
//  Created by zwx on 2017/11/22.
//

#import "UIControl+ZSound.h"
#import <objc/runtime.h>
#import <AVFoundation/AVFoundation.h>


// Key for the dictionary of sounds for control events.
static char const * const z_kSoundsKey = "z_kSoundsKey";

@implementation UIControl (ZSound)

- (void)z_setSoundNamed:(NSString *)name forControlEvent:(UIControlEvents)controlEvent
{
    // Remove the old UI sound.
    NSString *oldSoundKey = [NSString stringWithFormat:@"%zd", controlEvent];
    AVAudioPlayer *oldSound = [self z_sounds][oldSoundKey];
    [self removeTarget:oldSound action:@selector(play) forControlEvents:controlEvent];
    
    // Set appropriate category for UI sounds.
    // Do not mute other playing audio.
    [[AVAudioSession sharedInstance] setCategory:@"AVAudioSessionCategoryAmbient" error:nil];
    
    // Find the sound file.
    NSString *file = [name stringByDeletingPathExtension];
    NSString *extension = [name pathExtension];
    NSURL *soundFileURL = [[NSBundle mainBundle] URLForResource:file withExtension:extension];
    
    NSError *error = nil;
    
    // Create and prepare the sound.
    AVAudioPlayer *tapSound = [[AVAudioPlayer alloc] initWithContentsOfURL:soundFileURL error:&error];
    NSString *controlEventKey = [NSString stringWithFormat:@"%zd", controlEvent];
    NSMutableDictionary *sounds = [self z_sounds];
    [sounds setObject:tapSound forKey:controlEventKey];
    [tapSound prepareToPlay];
    if (!tapSound) {
        NSLog(@"Couldn't add sound - error: %@", error);
        return;
    }
    
    // Play the sound for the control event.
    [self addTarget:tapSound action:@selector(play) forControlEvents:controlEvent];
}


#pragma mark - Associated objects setters/getters

- (void)setZ_sounds:(NSMutableDictionary *)sounds
{
    objc_setAssociatedObject(self, z_kSoundsKey, sounds, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSMutableDictionary *)z_sounds
{
    NSMutableDictionary *sounds = objc_getAssociatedObject(self, z_kSoundsKey);
    
    // If sounds is not yet created, create it.
    if (!sounds) {
        sounds = [[NSMutableDictionary alloc] initWithCapacity:2];
        // Save it for later.
        [self setZ_sounds:sounds];
    }
    
    return sounds;
}

@end
