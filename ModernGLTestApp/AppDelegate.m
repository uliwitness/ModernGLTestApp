//
//  AppDelegate.m
//  ModernGLTestApp
//
//  Created by Uli Kusterer on 13/09/15.
//  Copyright (c) 2015 Uli Kusterer. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@property (weak) IBOutlet NSWindow *window;
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    [self.window center];
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

@end
