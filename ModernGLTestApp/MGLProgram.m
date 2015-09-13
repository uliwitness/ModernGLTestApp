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
}


-(void) use
{
    glUseProgram( _id );
    MGLLogIfError();
}

@end
