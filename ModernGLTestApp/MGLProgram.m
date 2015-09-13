//
//  MGLProgram.m
//  ModernGLTestApp
//
//  Created by Uli Kusterer on 13/09/15.
//  Copyright (c) 2015 Uli Kusterer. All rights reserved.
//

/*
    A program is a collection of shaders.
*/

#import "MGLProgram.h"
#import "MGLShader.h"
#import "MGLMacros.h"
#import <OpenGL/gl3.h>


@interface MGLProgram ()
{
    NSMutableArray  *   _shaders;
}

@end


@implementation MGLProgram

+(instancetype) program
{
    return [[self alloc] init];
}

-(instancetype)   initWithID: (GLuint)inID
{
    self = [super init];
    if( self )
    {
        _id = inID;
        _shaders = [NSMutableArray array];
    }
    
    return self;
}


-(instancetype)   init
{
    return [self initWithID: glCreateProgram()];
}


-(void) attachShader: (MGLShader*)inShader
{
    [_shaders addObject: inShader];
    glAttachShader( _id, inShader.id );
    MGLLogIfError();
}


-(NSArray*) shaders
{
    return _shaders;
}


-(void) link
{
    for( MGLShader* currShader in _shaders )
    {
        if( currShader.fragmentDataLocationName )
        {
            glBindFragDataLocation( _id, currShader.colorNumber, currShader.fragmentDataLocationName.UTF8String );
            MGLLogIfError();
        }
    }
    
    glLinkProgram( _id );
    MGLLogIfError();
    
    GLint logLength;

    glGetProgramiv( _id, GL_INFO_LOG_LENGTH, &logLength );
    MGLLogIfError();

    if( logLength > 0 )
    {
        NSMutableData* logObj = [NSMutableData dataWithLength: logLength];
        glGetProgramInfoLog( _id, logLength, &logLength, logObj.mutableBytes );
        MGLLogIfError();
    }

    GLint status;
    glGetProgramiv( _id, GL_LINK_STATUS, &status);
    MGLLogIfError();

    if( status == GL_FALSE )
    {
        NSLog( @"Link status is false." );
    }

    for( MGLShader* currShader in _shaders )
    {
        glDeleteShader( currShader.id );
        MGLLogIfError();
    }
}


-(void) use
{
    glUseProgram( _id );
    MGLLogIfError();
}


-(GLint)   uniformNamed: (const char*)inName
{
    return glGetUniformLocation( _id, inName );
}


-(GLint)   attributeNamed: (const char*)inName
{
    return glGetAttribLocation( _id, inName );
}

@end
