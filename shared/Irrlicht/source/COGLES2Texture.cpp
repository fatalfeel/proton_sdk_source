// Copyright (C) 2013 Patryk Nadrowski
// Heavily based on the OpenGL driver implemented by Nikolaus Gebhardt
// OpenGL ES driver implemented by Christian Stehno and first OpenGL ES 2.0
// driver implemented by Amundis.
// This file is part of the "Irrlicht Engine".
// For conditions of distribution and use, see copyright notice in Irrlicht.h

#include "IrrCompileConfig.h"

#ifdef _IRR_COMPILE_WITH_OGLES2_

//by stone
#ifdef ANDROID_NDK
#include "PlatformSetup.h"
#include <GLES2/gl2.h>
#include <GLES2/gl2ext.h>
#else
#include <OpenGLES/ES2/gl.h>
#endif

#include "COGLES2Driver.h"
#include "COGLES2Texture.h"
#include "os.h"
#include "CImage.h"
#include "CColorConverter.h"
#include "irrTypes.h"
#include "irrString.h"
#include "BuiltInFont.h"
#include "FileSystem/FileManager.h"

/*#if !defined(_IRR_COMPILE_WITH_IPHONE_DEVICE_)
#include <GLES2/gl2.h>
#include <GLES2/gl2ext.h>
#include <EGL/egl.h>
#endif*/

namespace
{
#ifndef GL_BGRA
// we need to do this for the IMG_BGRA8888 extension
int GL_BGRA=GL_RGBA;
#endif
}

namespace irr
{
namespace video
{

//! constructor for usual textures
COGLES2Texture::COGLES2Texture(IImage* origImage, const io::path& name, void* mipmapData, COGLES2Driver* driver)
	: ITexture(name), ColorFormat(ECF_A8R8G8B8), Driver(driver), Image(0), MipImage(0),
	TextureName(0), InternalFormat(GL_RGBA), PixelFormat(GL_BGRA_EXT),
	PixelType(GL_UNSIGNED_BYTE), MipLevelStored(0),
	IsRenderTarget(false), IsCompressed(false), AutomaticMipmapUpdate(false),
	ReadOnlyLock(false), KeepImage(true)
{
	#ifdef _DEBUG
	setDebugName("COGLES2Texture");
	#endif

	//by stone
	m_bRequestReload = false;

/*#ifndef GL_BGRA
	// whoa, pretty badly implemented extension...
	if (Driver->FeatureAvailable[COGLES2ExtensionHandler::IRR_IMG_texture_format_BGRA8888] ||
		Driver->FeatureAvailable[COGLES2ExtensionHandler::IRR_EXT_texture_format_BGRA8888] ||
		Driver->FeatureAvailable[COGLES2ExtensionHandler::IRR_APPLE_texture_format_BGRA8888])
		GL_BGRA = 0x80E1;
	else
		GL_BGRA = GL_RGBA;
#endif*/

	HasMipMaps = Driver->getTextureCreationFlag(ETCF_CREATE_MIP_MAPS);
	getImageValues(origImage);

	if (IsCompressed)
	{
		Image = origImage;
		Image->grab();
		KeepImage = false;
	}
	else if (ImageSize==TextureSize)
	{
		Image = Driver->createImage(ColorFormat, ImageSize);
		origImage->copyTo(Image);
	}
	else
	{
		Image = Driver->createImage(ColorFormat, TextureSize);
		origImage->copyToScaling(Image);
	}

	glGenTextures(1, &TextureName);
	uploadTexture(true, mipmapData);

	if (!KeepImage)
	{
		Image->drop();
		Image=0;
	}
}


//! constructor for basic setup (only for derived classes)
COGLES2Texture::COGLES2Texture(const io::path& name, COGLES2Driver* driver)
	: ITexture(name), ColorFormat(ECF_A8R8G8B8), Driver(driver), Image(0), MipImage(0),
	TextureName(0), InternalFormat(GL_RGBA), PixelFormat(GL_BGRA_EXT),
	PixelType(GL_UNSIGNED_BYTE), MipLevelStored(0), HasMipMaps(true),
	IsRenderTarget(false), IsCompressed(false), AutomaticMipmapUpdate(false),
	ReadOnlyLock(false), KeepImage(true)
{
	#ifdef _DEBUG
	setDebugName("COGLES2Texture");
	#endif
}


//! destructor
COGLES2Texture::~COGLES2Texture()
{
	// Remove this texture from current texture list as well

	for (u32 i = 0; i < Driver->MaxSupportedTextures; ++i)
		if (Driver->CurrentTexture[i] == this)
		{
			Driver->setActiveTexture(i, 0);
			Driver->getBridgeCalls()->setTexture(i);
			//Driver->CurrentTexture[i] = 0;
			Driver->CurrentTexture.set(i, 0);
		}

	// Remove this texture from active materials as well	

	for (u32 i = 0; i < MATERIAL_MAX_TEXTURES; ++i)
	{
		if (Driver->Material.TextureLayer[i].Texture == this)
			Driver->Material.TextureLayer[i].Texture = 0;

		if (Driver->LastMaterial.TextureLayer[i].Texture == this)
			Driver->LastMaterial.TextureLayer[i].Texture = 0;
	}

	if (TextureName)
		glDeleteTextures(1, &TextureName);
	if (Image)
		Image->drop();
}


//! Choose best matching color format, based on texture creation flags
ECOLOR_FORMAT COGLES2Texture::getBestColorFormat(ECOLOR_FORMAT format)
{
	return format; //SETH

	/*ECOLOR_FORMAT destFormat = ECF_A8R8G8B8;

	if (!IImage::isCompressedFormat(format))
	{
		switch (format)
		{
			case ECF_A1R5G5B5:
				if (!Driver->getTextureCreationFlag(ETCF_ALWAYS_32_BIT))
					destFormat = ECF_A1R5G5B5;
				break;
			case ECF_R5G6B5:
				if (!Driver->getTextureCreationFlag(ETCF_ALWAYS_32_BIT))
					destFormat = ECF_A1R5G5B5;
				break;
			case ECF_A8R8G8B8:
				if (Driver->getTextureCreationFlag(ETCF_ALWAYS_16_BIT) ||
					Driver->getTextureCreationFlag(ETCF_OPTIMIZED_FOR_SPEED))
					destFormat = ECF_A1R5G5B5;
				break;
			case ECF_R8G8B8:
				if (Driver->getTextureCreationFlag(ETCF_ALWAYS_16_BIT) ||
					Driver->getTextureCreationFlag(ETCF_OPTIMIZED_FOR_SPEED))
					destFormat = ECF_A1R5G5B5;
				break;
			default:
				break;
		}
	}
	else
		destFormat = format;

	if (Driver->getTextureCreationFlag(ETCF_NO_ALPHA_CHANNEL))
	{
		switch (destFormat)
		{
			case ECF_A1R5G5B5:
				destFormat = ECF_R5G6B5;
				break;
			case ECF_A8R8G8B8:
				destFormat = ECF_R8G8B8;
				break;
			default:
				break;
		}
	}

	return destFormat;*/
}


//! Get the OpenGL color format parameters based on the given Irrlicht color format
void COGLES2Texture::getFormatParameters(ECOLOR_FORMAT format, GLint& internalFormat, GLint& filtering,
	GLenum& pixelFormat, GLenum& type, void(*&convert)(const void*, s32, void*))
{
	switch(format)
	{
		case ECF_A1R5G5B5:
			internalFormat = GL_RGBA;
			filtering = GL_LINEAR;
			pixelFormat = GL_RGBA;
			type = GL_UNSIGNED_SHORT_5_5_5_1;
			convert = CColorConverter::convert_A1R5G5B5toR5G5B5A1;
			break;
		case ECF_R5G6B5:
			internalFormat = GL_RGB;
			filtering = GL_LINEAR;
			pixelFormat = GL_RGB;
			type = GL_UNSIGNED_SHORT_5_6_5;
			break;
		case ECF_R8G8B8:
			internalFormat = GL_RGB;
			filtering = GL_LINEAR;
			pixelFormat = GL_RGB;
			type = GL_UNSIGNED_BYTE;
			//convert = CColorConverter::convert_R8G8B8toB8G8R8; //by stone
			break;
		case ECF_A8R8G8B8:
			filtering = GL_LINEAR;
			type = GL_UNSIGNED_BYTE;
			/*if (!Driver->queryOpenGLFeature(COGLES2ExtensionHandler::IRR_IMG_texture_format_BGRA8888) &&
				!Driver->queryOpenGLFeature(COGLES2ExtensionHandler::IRR_EXT_texture_format_BGRA8888) &&
				!Driver->queryOpenGLFeature(COGLES2ExtensionHandler::IRR_APPLE_texture_format_BGRA8888))
			{
				internalFormat = GL_RGBA;
				pixelFormat = GL_RGBA;
				convert = CColorConverter::convert_A8R8G8B8toA8B8G8R8;
			}
			else
			{
				internalFormat = GL_BGRA;
				pixelFormat = GL_BGRA;
			}*/
			//by stone, fixed android png 32bits
			internalFormat = GL_RGBA;
			pixelFormat = GL_RGBA;
			convert = CColorConverter::convert_A8R8G8B8toA8B8G8R8;
			break;
#ifdef GL_EXT_texture_compression_s3tc
		case ECF_DXT1:
			internalFormat = GL_COMPRESSED_RGBA_S3TC_DXT1_EXT;
			filtering = GL_LINEAR;
			pixelFormat = GL_BGRA;
			type = GL_COMPRESSED_RGBA_S3TC_DXT1_EXT;
			break;
#endif
#ifdef GL_EXT_texture_compression_s3tc
		case ECF_DXT2:
		case ECF_DXT3:
			internalFormat = GL_COMPRESSED_RGBA_S3TC_DXT3_EXT;
			filtering = GL_LINEAR;
			pixelFormat = GL_BGRA;
			type = GL_COMPRESSED_RGBA_S3TC_DXT3_EXT;
			break;
#endif
#ifdef GL_EXT_texture_compression_s3tc
		case ECF_DXT4:
		case ECF_DXT5:
			internalFormat = GL_COMPRESSED_RGBA_S3TC_DXT5_EXT;
			filtering = GL_LINEAR;
			pixelFormat = GL_BGRA;
			type = GL_COMPRESSED_RGBA_S3TC_DXT5_EXT;
			break;
#endif
#ifdef GL_IMG_texture_compression_pvrtc
		case ECF_PVRTC_RGB2:
			internalFormat = GL_COMPRESSED_RGB_PVRTC_2BPPV1_IMG;
			filtering = GL_LINEAR;
			pixelFormat = GL_RGB;
			type = GL_COMPRESSED_RGB_PVRTC_2BPPV1_IMG;
			break;
#endif
#ifdef GL_IMG_texture_compression_pvrtc
		case ECF_PVRTC_ARGB2:
			internalFormat = GL_COMPRESSED_RGBA_PVRTC_2BPPV1_IMG;
			filtering = GL_LINEAR;
			pixelFormat = GL_RGBA;
			type = GL_COMPRESSED_RGBA_PVRTC_2BPPV1_IMG;
			break;
#endif
#ifdef GL_IMG_texture_compression_pvrtc
		case ECF_PVRTC_RGB4:
			internalFormat = GL_COMPRESSED_RGB_PVRTC_4BPPV1_IMG;
			filtering = GL_LINEAR;
			pixelFormat = GL_RGB;
			type = GL_COMPRESSED_RGB_PVRTC_4BPPV1_IMG;
			break;
#endif
#ifdef GL_IMG_texture_compression_pvrtc
		case ECF_PVRTC_ARGB4:
			internalFormat = GL_COMPRESSED_RGBA_PVRTC_4BPPV1_IMG;
			filtering = GL_LINEAR;
			pixelFormat = GL_RGBA;
			type = GL_COMPRESSED_RGBA_PVRTC_4BPPV1_IMG;
			break;
#endif
#ifdef GL_IMG_texture_compression_pvrtc2
		case ECF_PVRTC2_ARGB2:
			internalFormat = GL_COMPRESSED_RGBA_PVRTC_2BPPV2_IMG;
			filtering = GL_LINEAR;
			pixelFormat = GL_RGBA;
			type = GL_COMPRESSED_RGBA_PVRTC_2BPPV2_IMG;
			break;
#endif
#ifdef GL_IMG_texture_compression_pvrtc2
		case ECF_PVRTC2_ARGB4:
			internalFormat = GL_COMPRESSED_RGBA_PVRTC_4BPPV2_IMG;
			filtering = GL_LINEAR;
			pixelFormat = GL_RGBA;
			type = GL_COMPRESSED_RGBA_PVRTC_4BPPV2_IMG;
			break;
#endif
#ifdef GL_OES_compressed_ETC1_RGB8_texture
		case ECF_ETC1:
			internalFormat = GL_ETC1_RGB8_OES;
			filtering = GL_LINEAR;
			pixelFormat = GL_RGB;
			type = GL_ETC1_RGB8_OES;
			break;
#endif
#ifdef GL_ES_VERSION_3_0 // TO-DO - fix when extension name will be available
		case ECF_ETC2_RGB:
			internalFormat = GL_COMPRESSED_RGB8_ETC2;
			filtering = GL_LINEAR;
			pixelFormat = GL_RGB;
			type = GL_COMPRESSED_RGB8_ETC2;
			break;
#endif
#ifdef GL_ES_VERSION_3_0 // TO-DO - fix when extension name will be available
		case ECF_ETC2_ARGB:
			internalFormat = GL_COMPRESSED_RGBA8_ETC2_EAC;
			filtering = GL_LINEAR;
			pixelFormat = GL_RGBA;
			type = GL_COMPRESSED_RGBA8_ETC2_EAC;
			break;
#endif
		default:
			os::Printer::log("Unsupported texture format", ELL_ERROR);
			break;
	}

	// Hack for iPhone SDK, which requires a different InternalFormat
#ifdef _IRR_IPHONE_PLATFORM_
	if (internalFormat == GL_BGRA)
		internalFormat = GL_RGBA;
#endif
}


// prepare values ImageSize, TextureSize, and ColorFormat based on image
void COGLES2Texture::getImageValues(IImage* image)
{
	if (!image)
	{
		os::Printer::log("No image for OpenGL ES2 texture.", ELL_ERROR);
		return;
	}

	ImageSize = image->getDimension();

	if ( !ImageSize.Width || !ImageSize.Height)
	{
		os::Printer::log("Invalid size of image for OpenGL ES2 Texture.", ELL_ERROR);
		return;
	}

	const f32 ratio = (f32)ImageSize.Width/(f32)ImageSize.Height;
	if ((ImageSize.Width>Driver->MaxTextureSize) && (ratio >= 1.0f))
	{
		ImageSize.Width = Driver->MaxTextureSize;
		ImageSize.Height = (u32)(Driver->MaxTextureSize/ratio);
	}
	else if (ImageSize.Height>Driver->MaxTextureSize)
	{
		ImageSize.Height = Driver->MaxTextureSize;
		ImageSize.Width = (u32)(Driver->MaxTextureSize*ratio);
	}
	TextureSize=ImageSize.getOptimalSize(false);

	ColorFormat = getBestColorFormat(image->getColorFormat());

	IsCompressed = IImage::isCompressedFormat(image->getColorFormat());
}


//! copies the the texture into an open gl texture.
void COGLES2Texture::uploadTexture(bool newTexture, void* mipmapData, u32 level)
{
	// check which image needs to be uploaded
	IImage* image = level?MipImage:Image;
	if (!image)
	{
		os::Printer::log("No image for OpenGL ES2 texture to upload", ELL_ERROR);
		return;
	}

	// get correct opengl color data values
	GLint oldInternalFormat = InternalFormat;
	GLint filtering = GL_LINEAR;
	void(*convert)(const void*, s32, void*) = 0;
	getFormatParameters(ColorFormat, InternalFormat, filtering, PixelFormat, PixelType, convert);

	// make sure we don't change the internal format of existing images
	if (!newTexture)
		InternalFormat = oldInternalFormat;

    Driver->setActiveTexture(0, this);
	Driver->getBridgeCalls()->setTexture(0);

	if (Driver->testGLError())
		os::Printer::log("Could not bind Texture", ELL_ERROR);

	// mipmap handling for main texture
	if (!level && newTexture)
	{
		// auto generate if possible and no mipmap data is given
		if (!IsCompressed && HasMipMaps && !mipmapData && Driver->queryFeature(EVDF_MIP_MAP_AUTO_UPDATE))
		{
			if (Driver->getTextureCreationFlag(ETCF_OPTIMIZED_FOR_SPEED))
				glHint(GL_GENERATE_MIPMAP_HINT, GL_FASTEST);
			else if (Driver->getTextureCreationFlag(ETCF_OPTIMIZED_FOR_QUALITY))
				glHint(GL_GENERATE_MIPMAP_HINT, GL_NICEST);
			else
				glHint(GL_GENERATE_MIPMAP_HINT, GL_DONT_CARE);

			AutomaticMipmapUpdate=true;
		}

		// enable bilinear filter without mipmaps
		if (filtering == GL_LINEAR)
			StatesCache.BilinearFilter = true;
		else
			StatesCache.BilinearFilter = false;

		StatesCache.TrilinearFilter = false;
		StatesCache.MipMapStatus = false;

		glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, filtering);
		glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, filtering);
	}

	// now get image data and upload to GPU

	u32 compressedImageSize = IImage::getCompressedImageSize(ColorFormat, image->getDimension().Width, image->getDimension().Height);

	void* source = image->lock();

	IImage* tmpImage = 0;

	if (convert)
	{
		tmpImage = new CImage(image->getColorFormat(), image->getDimension());
		void* dest = tmpImage->lock();
		convert(source, image->getDimension().getArea(), dest);
		image->unlock();
		source = dest;
	}

	if (newTexture)
	{
		if (IsCompressed)
		{
			glCompressedTexImage2D(GL_TEXTURE_2D, 0, InternalFormat, image->getDimension().Width,
				image->getDimension().Height, 0, compressedImageSize, source);
		}
		else
			glTexImage2D(GL_TEXTURE_2D, level, InternalFormat, image->getDimension().Width,
				image->getDimension().Height, 0, PixelFormat, PixelType, source);
	}
	else
	{
		if (IsCompressed)
		{
			glCompressedTexSubImage2D(GL_TEXTURE_2D, level, 0, 0, image->getDimension().Width,
				image->getDimension().Height, PixelFormat, compressedImageSize, source);
		}
		else
			glTexSubImage2D(GL_TEXTURE_2D, level, 0, 0, image->getDimension().Width,
				image->getDimension().Height, PixelFormat, PixelType, source);
	}

	if (convert)
	{
		tmpImage->unlock();
		tmpImage->drop();
	}
	else
		image->unlock();

	if (!level && newTexture)
	{
		if (IsCompressed && !mipmapData)
		{
			if (image->hasMipMaps())
				mipmapData = static_cast<u8*>(image->lock())+compressedImageSize;
			else
				HasMipMaps = false;
		}

		regenerateMipMapLevels(mipmapData);

		if (HasMipMaps) // might have changed in regenerateMipMapLevels
		{
			// enable bilinear mipmap filter
			GLint filteringMipMaps = GL_LINEAR_MIPMAP_NEAREST;

			if (filtering == GL_LINEAR)
				StatesCache.BilinearFilter = true;
			else
			{
				StatesCache.BilinearFilter = false;
				filteringMipMaps = GL_NEAREST_MIPMAP_NEAREST;
			}

			StatesCache.TrilinearFilter = false;
			StatesCache.MipMapStatus = false;

			glTexParameteri( GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, filteringMipMaps);
			glTexParameteri( GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, filtering);
		}
	}

	if (Driver->testGLError())
		os::Printer::log("Could not glTexImage2D", ELL_ERROR);

	Driver->setActiveTexture(0, 0);
	Driver->getBridgeCalls()->setTexture(0);
}


//! lock function
void* COGLES2Texture::lock(E_TEXTURE_LOCK_MODE mode, u32 mipmapLevel)
{
	// store info about which image is locked
	IImage* image = (mipmapLevel==0)?Image:MipImage;

	ReadOnlyLock |= (mode==ETLM_READ_ONLY);
	MipLevelStored = mipmapLevel;

	if (!Image)
		Image = new CImage(ECF_A8R8G8B8, ImageSize);
	if (IsRenderTarget)
	{
		u8* pPixels = static_cast<u8*>(Image->lock());
		if (!pPixels)
		{
			return 0;
		}
		// we need to keep the correct texture bound...
		GLint tmpTexture;
		glGetIntegerv(GL_TEXTURE_BINDING_2D, &tmpTexture);
		glBindTexture(GL_TEXTURE_2D, TextureName);

	// TODO ogl-es
	//	glGetTexImage(GL_TEXTURE_2D, 0, GL_BGRA, GL_UNSIGNED_BYTE, pPixels);

		// opengl images are horizontally flipped, so we have to fix that here.
		const u32 pitch=Image->getPitch();
		u8* p2 = pPixels + (ImageSize.Height - 1) * pitch;
		u8* tmpBuffer = new u8[pitch];
		for (u32 i=0; i < ImageSize.Height; i += 2)
		{
			memcpy(tmpBuffer, pPixels, pitch);
			memcpy(pPixels, p2, pitch);
			memcpy(p2, tmpBuffer, pitch);
			pPixels += pitch;
			p2 -= pitch;
		}
		delete [] tmpBuffer;
		Image->unlock();

		//reset old bound texture
		glBindTexture(GL_TEXTURE_2D, tmpTexture);
	}
	return Image->lock();
}


//! unlock function
void COGLES2Texture::unlock()
{
	// test if miplevel or main texture was locked
	IImage* image = MipImage?MipImage:Image;
	if (!image)
		return;
	// unlock image to see changes
	image->unlock();
	// copy texture data to GPU
	if (!ReadOnlyLock)
		uploadTexture(false, 0, MipLevelStored);
	ReadOnlyLock = false;
	// cleanup local image
	if (MipImage)
	{
		MipImage->drop();
		MipImage=0;
	}
	else if (!KeepImage)
	{
		Image->drop();
		Image=0;
	}
	// update information
	if (Image)
		ColorFormat=Image->getColorFormat();
	else
		ColorFormat=ECF_A8R8G8B8;
}


//! Returns size of the original image.
const core::dimension2d<u32>& COGLES2Texture::getOriginalSize() const
{
	return ImageSize;
}


//! Returns size of the texture.
const core::dimension2d<u32>& COGLES2Texture::getSize() const
{
	return TextureSize;
}


//! returns driver type of texture, i.e. the driver, which created the texture
E_DRIVER_TYPE COGLES2Texture::getDriverType() const
{
	return EDT_OGLES2;
}


//! returns color format of texture
ECOLOR_FORMAT COGLES2Texture::getColorFormat() const
{
	return ColorFormat;
}


//! returns pitch of texture (in bytes)
u32 COGLES2Texture::getPitch() const
{
	if (Image)
		return Image->getPitch();
	else
		return 0;
}


//! return open gl texture name
//GLuint COGLES2Texture::getOpenGLTextureName() const
GLuint COGLES2Texture::getOpenGLTextureName() //SETH
{
	//Reload(); //SETH
	
	return TextureName;
}


//! Returns whether this texture has mipmaps
bool COGLES2Texture::hasMipMaps() const
{
	return HasMipMaps;
}


//! Regenerates the mip map levels of the texture. Useful after locking and
//! modifying the texture
void COGLES2Texture::regenerateMipMapLevels(void* mipmapData)
{
	// texture require mipmaps?
	if (!HasMipMaps)
		return;

	// we don't use custom data for mipmaps.
	if (!mipmapData)
	{
		// compressed textures require custom data for prepare mipmaps.
		if (IsCompressed)
			return;

		// hardware doesn't support generate mipmaps for certain texture but image data doesn't exist or is wrong.
		if (!AutomaticMipmapUpdate && (!Image || (Image && ((Image->getDimension().Width==1) && (Image->getDimension().Height==1)))))
			return;
	}

	// hardware moethods for generate mipmaps.
	if (!mipmapData && AutomaticMipmapUpdate)
	{
		glGenerateMipmap(GL_TEXTURE_2D);

		return;
	}

	// Manually create mipmaps or use prepared version
	u32 compressedImageSize = 0;
	u32 width=Image->getDimension().Width;
	u32 height=Image->getDimension().Height;
	u32 i=0;
	u8* target = static_cast<u8*>(mipmapData);
	do
	{
		if (width>1)
			width>>=1;
		if (height>1)
			height>>=1;

		++i;

		if (!target)
			target = new u8[width*height*Image->getBytesPerPixel()];

		// create scaled version if no mipdata available
		if (!mipmapData)
			Image->copyToScaling(target, width, height, Image->getColorFormat());

		if (IsCompressed)
		{
			compressedImageSize = IImage::getCompressedImageSize(ColorFormat, width, height);

			glCompressedTexImage2D(GL_TEXTURE_2D, i, InternalFormat, width,
				height, 0, compressedImageSize, target);
		}
		else
			glTexImage2D(GL_TEXTURE_2D, i, InternalFormat, width, height,
					0, PixelFormat, PixelType, target);

		// get next prepared mipmap data if available
		if (mipmapData)
		{
			if (IsCompressed)
				mipmapData = static_cast<u8*>(mipmapData)+compressedImageSize;
			else
				mipmapData = static_cast<u8*>(mipmapData)+width*height*Image->getBytesPerPixel();

			target = static_cast<u8*>(mipmapData);
		}
	}
	while (width!=1 || height!=1);
	// cleanup
	if (!mipmapData)
		delete [] target;
}


bool COGLES2Texture::isRenderTarget() const
{
	return IsRenderTarget;
}


void COGLES2Texture::setIsRenderTarget(bool isTarget)
{
	IsRenderTarget = isTarget;
}


bool COGLES2Texture::isFrameBufferObject() const
{
	return false;
}


//! Bind Render Target Texture
void COGLES2Texture::bindRTT()
{
}


//! Unbind Render Target Texture
void COGLES2Texture::unbindRTT()
{
}


//! Get an access to texture states cache.
COGLES2Texture::SStatesCache& COGLES2Texture::getStatesCache() const
{
	return StatesCache;
}

//SETH
void COGLES2Texture::Unload()
{
    m_bRequestReload = true;

    if (Image)
    {
        LogMsg("Unloading texture %d (%s)", TextureName, getName().getPath().c_str());
        
        glDeleteTextures(1, &TextureName);
            
        Image->drop();
        Image = NULL;
        TextureName = 0;
    }
    else
    {
        LogMsg("Huh, texture already unloaded");
    }
        
}
    
//SETH
void COGLES2Texture::Reload()
{
	int						fsize;
	core::dimension2d<u32>	lmapsize(128,128);
	byte*					pbuffer 	= NULL;
	IImage*					origImage 	= NULL;
    bool 					bIsFont 	= false;
	    
    if (m_bRequestReload)
    {
		m_bRequestReload = false;

		//SpriteBank->addTexture of CGUIFont will glGenTextures for #DefaultFont
		if(getName().getPath().find(".lightmap.") != -1)
		{
			pbuffer		= FileManager::GetFileManager()->Get(getName().getPath().c_str(), &fsize, false, false);
			origImage	= Driver->createImageFromData(video::ECF_R8G8B8, lmapsize, pbuffer, false, true );
			delete pbuffer; //because memcpy(Data, data, Size.Height * Pitch) in CImage::CImage
		}			
		else
		{
			origImage = Driver->createImageFromFile(getName());
		}
	    
		if (!origImage)
		{
			origImage	= Driver->createImageFromFile( io::path("game/")+getName() );
			
			if (origImage)
			{
				LogMsg("Did trick for reloading .xml font");
			}
		}

		/*if (!origImage)
		{
			LogMsg("Unable to reload tex %s", getName().getPath().c_str());
			return;
		}*/

		if( origImage )
		{
			LogMsg("reloading %s into %d", getName().getPath().c_str(), TextureName);

			if (IsCompressed)
			{
				Image = origImage;
				Image->grab();
				KeepImage = false;
			}
			else if (ImageSize==TextureSize)
			{
				Image = Driver->createImage(ColorFormat, ImageSize);
				origImage->copyTo(Image);
			}
			else
			{
				Image = Driver->createImage(ColorFormat, TextureSize);
				origImage->copyToScaling(Image);
			}

			glGenTextures(1, &TextureName);
			//glBindTexture( GL_TEXTURE_2D, TextureName);
			uploadTexture(true, 0);

			if (bIsFont)
			{
				bool mipmap = Driver->getTextureCreationFlag(video::ETCF_CREATE_MIP_MAPS);
				Driver->setTextureCreationFlag(video::ETCF_CREATE_MIP_MAPS, false);

				Driver->setTextureCreationFlag(video::ETCF_CREATE_MIP_MAPS, mipmap);
				Driver->makeColorKeyTexture(this, core::position2di(0,0), false);
			}

			if (!KeepImage)
			{
				Image->drop();
				Image=0;
			}

			origImage->drop(); //by stone, need release
		}
    }
}

/* FBO Textures */

// helper function for render to texture
static bool checkOGLES2FBOStatus(COGLES2Driver* Driver);

//! RTT ColorFrameBuffer constructor
COGLES2FBOTexture::COGLES2FBOTexture(const core::dimension2d<u32>& size,
					const io::path& name, COGLES2Driver* driver,
					ECOLOR_FORMAT format)
	: COGLES2Texture(name, driver), DepthTexture(0), ColorFrameBuffer(0)
{
	#ifdef _DEBUG
	setDebugName("COGLES2Texture_FBO");
	#endif

	ImageSize = size;
	TextureSize = size;
	HasMipMaps = false;
	IsRenderTarget = true;
	ColorFormat = getBestColorFormat(format);

	switch (ColorFormat)
	{
	case ECF_A8R8G8B8:
		InternalFormat = GL_RGBA;
		PixelFormat = GL_RGBA;
		PixelType = GL_UNSIGNED_BYTE;
		break;
	case ECF_R8G8B8:
		InternalFormat = GL_RGB;
		PixelFormat = GL_RGB;
		PixelType = GL_UNSIGNED_BYTE;
		break;
		break;
	case ECF_A1R5G5B5:
		InternalFormat = GL_RGBA;
		PixelFormat = GL_RGBA;
		PixelType = GL_UNSIGNED_SHORT_5_5_5_1;
		break;
		break;
	case ECF_R5G6B5:
		InternalFormat = GL_RGB;
		PixelFormat = GL_RGB;
		PixelType = GL_UNSIGNED_SHORT_5_6_5;
		break;
	default:
		os::Printer::log( "color format not handled", ELL_WARNING );
		break;
	}

	// generate frame buffer
	glGenFramebuffers(1, &ColorFrameBuffer);
	bindRTT();

	// generate color texture
	glGenTextures(1, &TextureName);
    
    Driver->setActiveTexture(0, this);
	Driver->getBridgeCalls()->setTexture(0);
    
	glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
	glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_CLAMP_TO_EDGE);
	glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_CLAMP_TO_EDGE);
    
	StatesCache.BilinearFilter = true;        
    StatesCache.WrapU = ETC_CLAMP_TO_EDGE;
    StatesCache.WrapV = ETC_CLAMP_TO_EDGE;
            
	glTexImage2D(GL_TEXTURE_2D, 0, InternalFormat, ImageSize.Width, ImageSize.Height, 0, PixelFormat, PixelType, 0);

#ifdef _DEBUG
	driver->testGLError();
#endif

	// attach color texture to frame buffer
	glFramebufferTexture2D(GL_FRAMEBUFFER, GL_COLOR_ATTACHMENT0, GL_TEXTURE_2D, TextureName, 0);
#ifdef _DEBUG
	checkOGLES2FBOStatus(Driver);
#endif

	unbindRTT();

	Driver->setActiveTexture(0, 0);
	Driver->getBridgeCalls()->setTexture(0);
}


//! destructor
COGLES2FBOTexture::~COGLES2FBOTexture()
{
	if (DepthTexture)
		if (DepthTexture->drop())
			Driver->removeDepthTexture(DepthTexture);
	if (ColorFrameBuffer)
		glDeleteFramebuffers(1, &ColorFrameBuffer);
}


bool COGLES2FBOTexture::isFrameBufferObject() const
{
	return true;
}


//! Bind Render Target Texture
void COGLES2FBOTexture::bindRTT()
{
	if (ColorFrameBuffer != 0)
		glBindFramebuffer(GL_FRAMEBUFFER, ColorFrameBuffer);
}


//! Unbind Render Target Texture
void COGLES2FBOTexture::unbindRTT()
{
	if (ColorFrameBuffer != 0)
		glBindFramebuffer(GL_FRAMEBUFFER, 0);
}


/* FBO Depth Textures */

//! RTT DepthBuffer constructor
COGLES2FBODepthTexture::COGLES2FBODepthTexture(
		const core::dimension2d<u32>& size,
		const io::path& name,
		COGLES2Driver* driver,
		bool useStencil)
	: COGLES2Texture(name, driver), DepthRenderBuffer(0),
	StencilRenderBuffer(0), UseStencil(useStencil)
{
#ifdef _DEBUG
	setDebugName("COGLES2TextureFBO_Depth");
#endif

	ImageSize = size;
	TextureSize = size;
	InternalFormat = GL_RGBA;
	PixelFormat = GL_RGBA;
	PixelType = GL_UNSIGNED_BYTE;
	HasMipMaps = false;

	if (useStencil)
	{
		glGenRenderbuffers(1, &DepthRenderBuffer);
		glBindRenderbuffer(GL_RENDERBUFFER, DepthRenderBuffer);
#ifdef GL_OES_packed_depth_stencil
		if (Driver->queryOpenGLFeature(COGLES2ExtensionHandler::IRR_OES_packed_depth_stencil))
		{
			// generate packed depth stencil buffer
			glRenderbufferStorage(GL_RENDERBUFFER, GL_DEPTH24_STENCIL8_OES, ImageSize.Width, ImageSize.Height);
			StencilRenderBuffer = DepthRenderBuffer; // stencil is packed with depth
		}
		else // generate separate stencil and depth textures
#endif
		{
			glRenderbufferStorage(GL_RENDERBUFFER, Driver->getZBufferBits(), ImageSize.Width, ImageSize.Height);

			glGenRenderbuffers(1, &StencilRenderBuffer);
			glBindRenderbuffer(GL_RENDERBUFFER, StencilRenderBuffer);
			glRenderbufferStorage(GL_RENDERBUFFER, GL_STENCIL_INDEX8, ImageSize.Width, ImageSize.Height);
		}
	}
	else
	{
		// generate depth buffer
		glGenRenderbuffers(1, &DepthRenderBuffer);
		glBindRenderbuffer(GL_RENDERBUFFER, DepthRenderBuffer);
		glRenderbufferStorage(GL_RENDERBUFFER, Driver->getZBufferBits(), ImageSize.Width, ImageSize.Height);
	}
}


//! destructor
COGLES2FBODepthTexture::~COGLES2FBODepthTexture()
{
	if (DepthRenderBuffer)
		glDeleteRenderbuffers(1, &DepthRenderBuffer);

	if (StencilRenderBuffer && StencilRenderBuffer != DepthRenderBuffer)
		glDeleteRenderbuffers(1, &StencilRenderBuffer);
}


//combine depth texture and rtt
bool COGLES2FBODepthTexture::attach(ITexture* renderTex)
{
	if (!renderTex)
		return false;
	COGLES2FBOTexture* rtt = static_cast<COGLES2FBOTexture*>(renderTex);
	rtt->bindRTT();

	// attach stencil texture to stencil buffer
	if (UseStencil)
		glFramebufferRenderbuffer(GL_FRAMEBUFFER, GL_STENCIL_ATTACHMENT, GL_RENDERBUFFER, StencilRenderBuffer);

	// attach depth renderbuffer to depth buffer
	glFramebufferRenderbuffer(GL_FRAMEBUFFER, GL_DEPTH_ATTACHMENT, GL_RENDERBUFFER, DepthRenderBuffer);

	// check the status
	if (!checkOGLES2FBOStatus(Driver))
	{
		os::Printer::log("FBO incomplete");
		return false;
	}
	rtt->DepthTexture=this;
	grab(); // grab the depth buffer, not the RTT
	rtt->unbindRTT();
	return true;
}


//! Bind Render Target Texture
void COGLES2FBODepthTexture::bindRTT()
{
}


//! Unbind Render Target Texture
void COGLES2FBODepthTexture::unbindRTT()
{
}


bool checkOGLES2FBOStatus(COGLES2Driver* Driver)
{
	GLenum status = glCheckFramebufferStatus(GL_FRAMEBUFFER);

	switch (status)
	{
		case GL_FRAMEBUFFER_COMPLETE:
			return true;

		case GL_FRAMEBUFFER_INCOMPLETE_ATTACHMENT:
			os::Printer::log("FBO has one or several incomplete image attachments", ELL_ERROR);
			break;

		case GL_FRAMEBUFFER_INCOMPLETE_MISSING_ATTACHMENT:
			os::Printer::log("FBO missing an image attachment", ELL_ERROR);
			break;

		case GL_FRAMEBUFFER_INCOMPLETE_DIMENSIONS:
			os::Printer::log("FBO has one or several image attachments with different dimensions", ELL_ERROR);
			break;

		case GL_FRAMEBUFFER_UNSUPPORTED:
			os::Printer::log("FBO format unsupported", ELL_ERROR);
			break;

		default:
			break;
	}

	os::Printer::log("FBO error", ELL_ERROR);

	return false;
}


} // end namespace video
} // end namespace irr

#endif // _IRR_COMPILE_WITH_OGLES2_

