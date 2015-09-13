//
//  MGLVertexBufferObject.m
//  ModernGLTestApp
//
//  Created by Uli Kusterer on 13/09/15.
//  Copyright (c) 2015 Uli Kusterer. All rights reserved.
//

#import "MGLVertexBufferObject.h"
#import "MGLMacros.h"
#import <OpenGL/gl.h>


@implementation MGLVertexBufferObject

+(instancetype) vertexBufferObjectWithVertices: (float*)inVertices size: (int)inSize usage: (GLenum)inUsage
{
    return [[self alloc] initWithVertices: inVertices size: inSize usage: inUsage];
}


-(instancetype) initWithVertices: (float*)inVertices size: (int)inSize usage: (GLenum)inUsage
{
    GLuint  theID;
    glGenBuffers(1, &theID);

    GLfloat vertices[] = {
        0.0f, 0.5f,
        0.5f, -0.5f,
        -0.5f, -0.5f
    };

    glBindBuffer(GL_ARRAY_BUFFER, theID);
    MGLLogIfError();
    glBufferData(GL_ARRAY_BUFFER, inSize, vertices, inUsage);
    MGLLogIfError();
    
    return [self initWithID: theID];
}


-(instancetype) initWithID: (GLuint)inID
{
    self = [super init];
    if( self )
    {
        _id = inID;
    }
    return self;
}

@end
