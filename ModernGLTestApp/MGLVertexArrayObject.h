//
//  MGLVertexArrayObject.h
//  ModernGLTestApp
//
//  Created by Uli Kusterer on 13/09/15.
//  Copyright (c) 2015 Uli Kusterer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <OpenGL/OpenGL.h>


@interface MGLVertexArrayObject : NSObject

@property (readonly,assign) GLuint  id;

+(instancetype) vertexArrayObject;

-(instancetype) initWithID: (GLuint)inID NS_DESIGNATED_INITIALIZER;

-(void) bind;

@end
