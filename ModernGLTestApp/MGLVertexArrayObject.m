//
//  MGLVertexArrayObject.m
//  ModernGLTestApp
//
//  Created by Uli Kusterer on 13/09/15.
//  Copyright (c) 2015 Uli Kusterer. All rights reserved.
//

#import "MGLVertexArrayObject.h"
#import "MGLMacros.h"
#import <OpenGL/gl3.h>


@implementation MGLVertexArrayObject

+(instancetype) vertexArrayObject
{
    return [[self alloc] init];
}


-(instancetype) initWithID: (GLuint)inID
{
    self = [super init];
    if( self )
        self->_id = inID;
    return self;
}


-(instancetype) init
{
    GLuint  theID = 0;
    glGenVertexArrays( 1, &theID );
    MGLLogIfError();
    
    return [self initWithID: theID];
}


-(void) bind
{
    glBindVertexArray( _id );
    MGLLogIfError();
}

@end
