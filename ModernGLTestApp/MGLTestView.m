//
//  MGLTestView.m
//  Interconnect2D
//
//  Created by Uli Kusterer on 10/09/15.
//  Copyright (c) 2015 Uli Kusterer. All rights reserved.
//

#import "MGLTestView.h"
#import "MGLTestLayer.h"


@implementation MGLTestView

-(id)	initWithFrame:(NSRect)frameRect
{
	self = [super initWithFrame: frameRect];
	if( self )
	{
		[self mgl_commonInit];
	}
	return self;
}


-(id)	initWithCoder:(NSCoder *)coder
{
	self = [super initWithCoder: coder];
	if( self )
	{
		[self mgl_commonInit];
	}
	return self;
}


-(void)	mgl_commonInit
{
	self.layer = [MGLTestLayer layer];
	self.wantsLayer = YES;
}


-(MGLTestLayer*)	playerLayer
{
	return (MGLTestLayer*)self.layer;
}

@end
