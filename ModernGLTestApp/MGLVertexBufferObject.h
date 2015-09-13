//
//  MGLVertexBufferObject.h
//  ModernGLTestApp
//
//  Created by Uli Kusterer on 13/09/15.
//  Copyright (c) 2015 Uli Kusterer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <OpenGL/OpenGL.h>

@interface MGLVertexBufferObject : NSObject

@property (readonly,assign) GLuint  id;

+(instancetype) vertexBufferObjectWithVertices: (float*)inVertices size: (int)inSize usage: (GLenum)inUsage;

-(instancetype) initWithVertices: (float*)inVertices size: (int)inSize usage: (GLenum)inUsage;
-(instancetype) initWithID: (GLuint)inID;

@end
