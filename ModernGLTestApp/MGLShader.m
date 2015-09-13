//
//  MGLShader.m
//  ModernGLTestApp
//
//  Created by Uli Kusterer on 13/09/15.
//  Copyright (c) 2015 Uli Kusterer. All rights reserved.
//

#import "MGLShader.h"
#import "MGLMacros.h"
#import <OpenGL/gl3.h>


@implementation MGLShader

+(instancetype) shaderFromResource: (NSString*)inFilename
{
    MGLShader*  shader = [[self.class alloc] initFromResource: inFilename inBundle: NSBundle.mainBundle];
    
    return shader;
}

+(instancetype) shaderFromResource: (NSString*)inFilename inBundle: (NSBundle*)theBundle
{
    MGLShader*  shader = [[self.class alloc] initFromResource: inFilename inBundle: theBundle];
    
    return shader;
}


-(instancetype) initFromResource: (NSString*)inFilename
{
    MGLShader*  shader = [self initFromResource: inFilename inBundle: NSBundle.mainBundle];
    
    return shader;
}

-(instancetype) initFromResource: (NSString*)inFilename inBundle: (NSBundle*)theBundle
{
    GLenum      inType = [inFilename.pathExtension isEqualToString: @"fsh"] ? GL_FRAGMENT_SHADER : GL_VERTEX_SHADER;
    GLuint theID = glCreateShader(inType);
    const char* const mainVertexShaderSource = [NSString stringWithContentsOfURL: [theBundle URLForResource: [inFilename stringByDeletingPathExtension] withExtension: [inFilename pathExtension]] encoding: NSUTF8StringEncoding error: NULL].UTF8String;
    if( mainVertexShaderSource == NULL )
    {
        NSLog( @"Couldn't read shader %@", inFilename );
        return nil;
    }
    glShaderSource(theID, 1, &mainVertexShaderSource, NULL);
    MGLLogIfError();
    glCompileShader(theID);
    MGLLogIfError();
    
    GLint status;
    glGetShaderiv(theID, GL_COMPILE_STATUS, &status);
    if( status != GL_TRUE )
        NSLog(@"Couldn't compile shader %@", inFilename);
    
    char buffer[1024] = {0};
    glGetShaderInfoLog(theID, sizeof(buffer), NULL, buffer);
    if( buffer[0] != '\0' )
        NSLog(@"Shader %@ says:\n%s", inFilename, buffer);
    
    self = [self initWithID: theID];
    return self;
}


-(id)   init
{
    self = [self initWithID: 0];
    return self;
}


-(id)   initWithID: (GLuint)inID
{
    self = [super init];
    if( self )
        _id = inID;
    return self;
}

@end
