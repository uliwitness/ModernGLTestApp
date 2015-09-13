//
//  MGLProgram.h
//  ModernGLTestApp
//
//  Created by Uli Kusterer on 13/09/15.
//  Copyright (c) 2015 Uli Kusterer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <OpenGL/OpenGL.h>


@class MGLShader;


@interface MGLProgram : NSObject

@property (assign,readonly) GLuint      id;
@property (strong,readonly) NSArray*    shaders;

+(instancetype) program;

-(instancetype)   initWithID: (GLuint)inID NS_DESIGNATED_INITIALIZER;
-(instancetype)   init;

-(void) attachShader: (MGLShader*)inShader; // Add a shader.

-(void) link;   // Commit changes made to this program.

-(void) use;

@end
