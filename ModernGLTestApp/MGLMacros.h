//
//  MGLMacros.h
//  ModernGLTestApp
//
//  Created by Uli Kusterer on 13/09/15.
//  Copyright (c) 2015 Uli Kusterer. All rights reserved.
//

#ifndef ModernGLTestApp_MGLMacros_h
#define ModernGLTestApp_MGLMacros_h

#define MGLLogIfError() do{ GLenum err; while( (err = glGetError()) != GL_NO_ERROR) { NSLog( @"%s:%d: OpenGL error: %d", __FILE__, __LINE__, err); } }while(0)

#endif
