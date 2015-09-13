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

+(instancetype) shaderWithType: (GLenum)inType fromResource: (NSString*)inFilename;
+(instancetype) shaderWithType: (GLenum)inType fromResource: (NSString*)inFilename inBundle: (NSBundle*)theBundle;

-(instancetype) initWithType: (GLenum)inType fromResource: (NSString*)inFilename;
-(instancetype) initWithType: (GLenum)inType fromResource: (NSString*)inFilename inBundle: (NSBundle*)theBundle;
-(instancetype) initWithID: (GLuint)inID NS_DESIGNATED_INITIALIZER;

@property (assign,readonly) GLuint      id;
@property (copy) NSString*              fragmentDataLocationName;
@property (assign) GLuint               colorNumber;

@end
