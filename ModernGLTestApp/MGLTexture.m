//
//  MGLTexture.m
//  ModernGLTestApp
//
//  Created by Uli Kusterer on 13/09/15.
//  Copyright (c) 2015 Uli Kusterer. All rights reserved.
//

#import "MGLTexture.h"
#import "MGLMacros.h"
#import <OpenGL/gl3.h>


@implementation MGLTexture

+(instancetype) textureFromResource: (NSString*)inFilename
{
    return [[self alloc] initFromResource: inFilename bundle: NSBundle.mainBundle];
}

+(instancetype) textureFromResource: (NSString*)inFilename bundle: (NSBundle*)inBundle
{
    return [[self alloc] initFromResource: inFilename bundle: inBundle];
}

-(instancetype) init
{
    return [self initWithID: 0];
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


-(instancetype)   initFromResource: (NSString*)inFilename
{
    return [self initFromResource: inFilename bundle: NSBundle.mainBundle];
}


-(instancetype) initFromResource: (NSString*)inFilename bundle: (NSBundle*)inBundle
{
    NSURL               *   theFileURL = [inBundle URLForImageResource: inFilename];
    if( !theFileURL )
    {
        NSLog( @"Couldn't find texture %@", inFilename );
        return nil;
    }
    NSData              *   compressedData = [NSData dataWithContentsOfURL: theFileURL];
    if( !compressedData )
    {
        NSLog( @"Couldn't read texture %@", inFilename );
        return nil;
    }
    NSBitmapImageRep    *   bitmap = [[NSBitmapImageRep alloc] initWithData: compressedData];
    if( !bitmap )
    {
        NSLog( @"Couldn't decode texture %@", inFilename );
        return nil;
    }
    GLint   samplesPerPixel = (GLint)[bitmap samplesPerPixel];
    glPixelStorei( GL_UNPACK_ROW_LENGTH, (GLint)[bitmap bytesPerRow] / samplesPerPixel );
    MGLLogIfError();
    glPixelStorei( GL_UNPACK_ALIGNMENT, 1 );
    MGLLogIfError();

    GLuint  theID;
    glGenTextures( 1, &theID );
    MGLLogIfError();
    glBindTexture( GL_TEXTURE_2D, theID );
    MGLLogIfError();
    
    glTexParameteri( GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR );
    MGLLogIfError();
    glTexParameteri( GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR );
    MGLLogIfError();
    
    NSInteger   bitsPerSample = [bitmap bitsPerSample];
 
    if( ![bitmap isPlanar] && (samplesPerPixel == 3 || samplesPerPixel == 4) && bitsPerSample == 8 )
    {
        glTexImage2D(GL_TEXTURE_2D,
                     0,
                     samplesPerPixel == 4 ? GL_RGBA8 : GL_RGB8,
                     (GLsizei)[bitmap pixelsWide],
                     (GLsizei)[bitmap pixelsHigh],
                     0,
                     samplesPerPixel == 4 ? GL_RGBA : GL_RGB,
                     GL_UNSIGNED_BYTE,
                     [bitmap bitmapData] );
        MGLLogIfError();
    }
    else
    {
        NSLog( @"Texture %@ has an unsupported bitmap data layout", inFilename );
        return nil;
    }
    
    self = [self initWithID: theID];
    return self;
}


-(void) bind
{
    glBindTexture( GL_TEXTURE_2D, _id );
    MGLLogIfError();
}

@end
