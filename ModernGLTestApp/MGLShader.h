//
//  MGLShader.h
//  ModernGLTestApp
//
//  Created by Uli Kusterer on 13/09/15.
//  Copyright (c) 2015 Uli Kusterer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <OpenGL/OpenGL.h>

@interface MGLShader : NSObject

+(instancetype) shaderFromResource: (NSString*)inFilename;
+(instancetype) shaderFromResource: (NSString*)inFilename inBundle: (NSBundle*)theBundle;

-(instancetype) initFromResource: (NSString*)inFilename;
-(instancetype) initFromResource: (NSString*)inFilename inBundle: (NSBundle*)theBundle;
-(instancetype) initWithID: (GLuint)inID NS_DESIGNATED_INITIALIZER;

@property (assign,readonly) GLuint      id;
@property (copy) NSString*              fragmentDataLocationName;
@property (assign) GLuint               colorNumber;

@end
