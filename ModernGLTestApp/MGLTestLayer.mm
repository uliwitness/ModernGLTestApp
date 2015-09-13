//
//  MGLTestLayer.m
//  Interconnect2D
//
//  Created by Uli Kusterer on 10/09/15.
//  Copyright (c) 2015 Uli Kusterer. All rights reserved.
//

#import "MGLTestLayer.h"
#import <OpenGL/gl.h>
#import <OpenGL/OpenGL.h>


@interface MGLTestLayer ()
{
    GLuint vertexBuffer;
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
    if( !vertexBuffer )
    {
        glGenBuffers(1, &vertexBuffer);

        printf("%u\n", vertexBuffer);
    }
}


-(void)	drawInCGLContext: (CGLContextObj)ctx pixelFormat: (CGLPixelFormatObj)pf
		forLayerTime: (CFTimeInterval)t displayTime: (const CVTimeStamp *)ts
{
    [self mgl_setupContext];
    
	CGFloat		contentsScale = [self respondsToSelector: @selector(contentsScale)] ? self.contentsScale : 1.0;
	
	CGRect 		bounds = self.bounds;
	
	glClearColor( 0.0, 0.0, 0.0, 1.0 );
	glClear( GL_COLOR_BUFFER_BIT );
	glMatrixMode( GL_MODELVIEW );
	glLoadIdentity();
	glPushMatrix();
	glOrtho( 0, bounds.size.width  * contentsScale, 0, bounds.size.height * contentsScale, -1, 1 );
	glViewport(0, 0, bounds.size.width * contentsScale, bounds.size.height * contentsScale);
	
	// +++ Test drawing code.
	glBegin(GL_QUADS);
		glColor3f(1, 1, 1);
		glVertex2f( bounds.origin.x, bounds.origin.y );
		
		glColor3f(0, 1, 1);
		glVertex2f( bounds.origin.x, bounds.origin.y +bounds.size.height);
		
		glColor3f(0, 0, 1);
		glVertex2f( bounds.origin.x +bounds.size.width, bounds.origin.y +bounds.size.height);
		
		glColor3f(1, 0, 1);
		glVertex2f( bounds.origin.x +bounds.size.width, bounds.origin.y );
	glEnd();
	// +++ End of test drawing code.
	
	glPopMatrix();
	
	// Call super to finalize the drawing.
	[super drawInCGLContext: ctx pixelFormat: pf forLayerTime: t displayTime: ts];
}


-(CGLPixelFormatObj)	copyCGLPixelFormatForDisplayMask: (uint32_t)mask
{
	CGLPixelFormatObj		pixelFormat = NULL;
	GLint					numPixelFormats = 0;
	CGLPixelFormatAttribute	attrib[] = {
		kCGLPFANoRecovery,
		kCGLPFAAccelerated,
		kCGLPFADepthSize, (CGLPixelFormatAttribute)16,
		kCGLPFADoubleBuffer,
        kCGLPFAOpenGLProfile, (CGLPixelFormatAttribute)kCGLOGLPVersion_3_2_Core,
		(CGLPixelFormatAttribute)0
	};
	CGLError err = CGLChoosePixelFormat( attrib, &pixelFormat, &numPixelFormats );
    if( err != kCGLNoError )
        NSLog( @"CGLChoosePixelFormat gave error %d", err );

	return pixelFormat;
}

@end
