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


@interface MGLTestLayer ()
{
    
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
	
}


-(void) mgl_setupContext
{
	glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
}


-(void)	drawInCGLContext: (CGLContextObj)ctx pixelFormat: (CGLPixelFormatObj)pf
		forLayerTime: (CFTimeInterval)t displayTime: (const CVTimeStamp *)ts
{
    CGLSetCurrentContext( ctx );
    
    [self mgl_setupContext];
    
	glClearColor( 0.0, 0.0, 0.0, 1.0 );
	glClear( GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT );
	glMatrixMode( GL_MODELVIEW );
	glLoadIdentity();
	glPushMatrix();

    [self mgl_setupContext];
    
    float vertices[] = {
         0.0f,  0.5f, // Vertex 1 (X, Y)
         0.5f, -0.5f, // Vertex 2 (X, Y)
        -0.5f, -0.5f  // Vertex 3 (X, Y)
    };
	
    MGLVertexArrayObject*   vao = [MGLVertexArrayObject vertexArrayObject];
    [vao bind];
    
    MGLVertexBufferObject*  vbo = [MGLVertexBufferObject vertexBufferObjectWithVertices: vertices size: sizeof(vertices) usage:GL_STATIC_DRAW];
    
    MGLShader* vertexShader = [MGLShader shaderFromResource: @"MainVertexShader"];
    MGLShader* fragmentShader = [MGLShader shaderFromResource: @"MainFragmentShader"];
    fragmentShader.colorNumber = 0;
    fragmentShader.fragmentDataLocationName = @"outColor";
    MGLProgram* program = [MGLProgram program];
    [program attachShader: vertexShader];
    [program attachShader: fragmentShader];
    [program link];
    [program use];
    
    GLint posAttrib = glGetAttribLocation( program.id, "position" );
    glVertexAttribPointer( posAttrib, 2, GL_FLOAT, GL_FALSE, 0, 0 );   // Tell OpenGL how to lay out "position" in the shader's input. Operates on & remembers the current VBO.
    glEnableVertexAttribArray(posAttrib);
    
    glDrawArrays(GL_TRIANGLES, 0, 3);

	glPopMatrix();
	
	// Call super to finalize the drawing.
	[super drawInCGLContext: ctx pixelFormat: pf forLayerTime: t displayTime: ts];
    
    glDeleteProgram( program.id );
    glDeleteShader( vertexShader.id );
    glDeleteShader( fragmentShader.id );
    
    GLuint  buffer = vbo.id;
    glDeleteBuffers( 1, &buffer);
    
    buffer = vao.id;
    glDeleteVertexArraysAPPLE( 1, &buffer);
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

@end
