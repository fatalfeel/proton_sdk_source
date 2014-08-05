// Copyright (C) 2009-2010 Amundis
// Heavily based on the OpenGL driver implemented by Nikolaus Gebhardt
// and OpenGL ES driver implemented by Christian Stehno
// This file is part of the "Irrlicht Engine".
// For conditions of distribution and use, see copyright notice in Irrlicht.h

precision mediump float;

uniform int uTextureUsage;
uniform sampler2D uTextureUnit;

varying vec2 vTextureCoord;
varying vec4 vVertexColor;

void main()
{
	vec4 Color = vVertexColor;

	if (bool(uTextureUsage))
		Color *= texture2D(uTextureUnit, vTextureCoord);

	gl_FragColor = Color;
}
