//
//  MGLTestLayer.m
//  Interconnect2D
//
//  Created by Uli Kusterer on 10/09/15.
//  Copyright (c) 2015 Uli Kusterer. All rights reserved.
//

#import "MGLTestLayer.h"
#import <OpenGL/gl3.h>
#import <OpenGL/OpenGL.h>
#import "MGLProgram.h"
#import "MGLShader.h"
#import "MGLVertexArrayObject.h"
#import "MGLVertexBufferObject.h"
#import "MGLMacros.h"


@interface MGLTestLayer ()
{
    MGLProgram*             _program;
    MGLShader*              _vertexShader;
    MGLShader*              _fragmentShader;
    MGLVertexArrayObject*   _vao;
    MGLVertexBufferObject*  _vbo;
    GLint                   _posAttrib;
}

@end


@implementation MGLTestLayer

-(id)	init
{
	self = [super init];
	if( self )
	{
		
	}
	return self;
}


-(void)	dealloc
{
    glDeleteProgram( _program.id );
    
    GLuint  buffer = _vbo.id;
    glDeleteBuffers( 1, &buffer);
    
    buffer = _vao.id;
    glDeleteVertexArrays( 1, &buffer);
}


-(void) mgl_setupContext
{
	glClearColor( 0.0, 0.0, 0.0, 1.0 );

    _vertexShader = [MGLShader shaderWithType: GL_VERTEX_SHADER fromResource: @"MainVertexShader"];
    _fragmentShader = [MGLShader shaderWithType: GL_FRAGMENT_SHADER fromResource: @"MainFragmentShader"];
    _fragmentShader.colorNumber = 0;
    _fragmentShader.fragmentDataLocationName = @"outColor";
    _program = [MGLProgram program];
    [_program attachShader: _vertexShader];
    [_program attachShader: _fragmentShader];
    [_program link];

    _posAttrib = glGetAttribLocation( _program.id, "position" );
}


-(void)	drawInCGLContext: (CGLContextObj)ctx pixelFormat: (CGLPixelFormatObj)pf
		forLayerTime: (CFTimeInterval)t displayTime: (const CVTimeStamp *)ts
{
    CGLSetCurrentContext( ctx );
    
	glClear( GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT );
	
    [_program use];
    
    if( !_vao )
    {
        _vao = [MGLVertexArrayObject vertexArrayObject];
        [_vao bind];
    }
    
    float vertices[] = {
         0.0f,  0.5f, // Vertex 1 (X, Y)
         0.5f, -0.5f, // Vertex 2 (X, Y)
        -0.5f, -0.5f  // Vertex 3 (X, Y)
    };
	
    if( !_vbo )
    {
        _vbo = [MGLVertexBufferObject vertexBufferObjectWithVertices: vertices size: sizeof(vertices) usage:GL_STATIC_DRAW];
    }
    
    glEnableVertexAttribArray( _posAttrib );
    MGLLogIfError();
    glVertexAttribPointer( _posAttrib, 2, GL_FLOAT, GL_FALSE, 0, 0 );   // Tell OpenGL how to lay out "position" in the shader's input. Operates on & remembers the current VBO.
    MGLLogIfError();
    
    glDrawArrays(GL_TRIANGLES, 0, 3);
    MGLLogIfError();
	
	// Call super to finalize the drawing.
	[super drawInCGLContext: ctx pixelFormat: pf forLayerTime: t displayTime: ts];
}


- (CGLPixelFormatObj)copyCGLPixelFormatForDisplayMask:(uint32_t)mask
{
	CGLPixelFormatObj		pixelFormat = NULL;
	GLint					numPixelFormats = 0;
    CGLPixelFormatAttribute attribs[] =  {
        kCGLPFADisplayMask, (CGLPixelFormatAttribute)0,
        kCGLPFAColorSize, (CGLPixelFormatAttribute)24,
        kCGLPFAAlphaSize, (CGLPixelFormatAttribute)8,
        kCGLPFAAccelerated,
        kCGLPFADoubleBuffer,
        kCGLPFAAllowOfflineRenderers,
        kCGLPFAOpenGLProfile, (CGLPixelFormatAttribute)kCGLOGLPVersion_3_2_Core,
        0
    };
    attribs[1] = mask;

    
    CGLError err = CGLChoosePixelFormat(attribs, &pixelFormat, &numPixelFormats);
    if( err != kCGLNoError )
        NSLog( @"CGLChoosePixelFormat gave error %d", err );
    
    return pixelFormat;
}


-(CGLContextObj)    copyCGLContextForPixelFormat:(CGLPixelFormatObj)pf
{
    CGLContextObj   context = [super copyCGLContextForPixelFormat: pf];
    CGLContextObj   oldContext = CGLGetCurrentContext();
    CGLSetCurrentContext( context );
    [self mgl_setupContext];
    CGLSetCurrentContext( oldContext );
    
    return context;
}

@end
