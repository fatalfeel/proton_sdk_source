// Copyright (C) 2009-2010 Amundis
// Heavily based on the OpenGL driver implemented by Nikolaus Gebhardt
// and OpenGL ES driver implemented by Christian Stehno
// This file is part of the "Irrlicht Engine".
// For conditions of distribution and use, see copyright notice in Irrlicht.h

attribute vec4 inVertexPosition;
attribute vec4 inVertexColor;
attribute vec2 inTexCoord0;

varying vec2 vTextureCoord;
varying vec4 vVertexColor;

void main()
{
	gl_Position   = inVertexPosition;
	vTextureCoord = inTexCoord0;
	vVertexColor  = inVertexColor.bgra;
}

