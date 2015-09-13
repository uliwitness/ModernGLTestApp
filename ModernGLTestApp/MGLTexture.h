//
//  MGLTexture.h
//  ModernGLTestApp
//
//  Created by Uli Kusterer on 13/09/15.
//  Copyright (c) 2015 Uli Kusterer. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <OpenGL/OpenGL.h>


@interface MGLTexture : NSObject

@property (assign,readonly) GLuint id;

+(instancetype) textureFromResource: (NSString*)inFilename;
+(instancetype) textureFromResource: (NSString*)inFilename bundle: (NSBundle*)inBundle;

-(instancetype) initFromResource: (NSString*)inFilename;
-(instancetype) initFromResource: (NSString*)inFilename bundle: (NSBundle*)inBundle;
-(instancetype) initWithID: (GLuint)inID NS_DESIGNATED_INITIALIZER;

-(void) bind;

@end
