LOCAL_PATH := $(call my-dir)

##################################
########### bullet.a #############
##################################

include $(CLEAR_VARS)

LOCAL_MODULE := libbullet
SHARED := ../../../shared
LOCAL_ARM_MODE := arm

BULLETSRC := $(SHARED)/Bullet

#LOCAL_CPP_FEATURES += exceptions
LOCAL_CPP_FEATURES += rtti

APP_DEBUG := $(strip $(NDK_DEBUG))
ifeq ($(APP_DEBUG),0)
	LOCAL_CFLAGS := -DANDROID_NDK -DBUILD_ANDROID -DGC_BUILD_ANDROID -DNDEBUG -DHAVE_NEON=1 -mfpu=neon -mfloat-abi=softfp
	LOCAL_CPPFLAGS := -DGC_BUILD_C -DANDROID_NDK -DBUILD_ANDROID -DNDEBUG -DHAVE_NEON=1 -mfpu=neon -mfloat-abi=softfp
else
	LOCAL_CFLAGS := -DANDROID_NDK -DBUILD_ANDROID -DGC_BUILD_ANDROID -D_DEBUG -DHAVE_NEON=1 -mfpu=neon -mfloat-abi=softfp
	LOCAL_CPPFLAGS := -DGC_BUILD_C -DANDROID_NDK -DBUILD_ANDROID -D_DEBUG -DHAVE_NEON=1 -mfpu=neon -mfloat-abi=softfp
	LOCAL_STRIP_MODULE := false
endif

LOCAL_C_INCLUDES := \
$(LOCAL_PATH)/$(APP) \
$(LOCAL_PATH)/$(SHARED) \
$(LOCAL_PATH)/$(SHARED)/ClanLib-2.0/Sources \
$(LOCAL_PATH)/$(SHARED)/util/boost \
$(LOCAL_PATH)/$(SHARED)/Bullet \
$(LOCAL_PATH)/$(SHARED)/Irrlicht/include
                
LOCAL_SRC_FILES := \
$(BULLETSRC)/BulletCollision/BroadphaseCollision/btAxisSweep3.cpp \
$(BULLETSRC)/BulletCollision/BroadphaseCollision/btBroadphaseProxy.cpp \
$(BULLETSRC)/BulletCollision/BroadphaseCollision/btCollisionAlgorithm.cpp \
$(BULLETSRC)/BulletCollision/BroadphaseCollision/btDbvt.cpp \
$(BULLETSRC)/BulletCollision/BroadphaseCollision/btDbvtBroadphase.cpp \
$(BULLETSRC)/BulletCollision/BroadphaseCollision/btDispatcher.cpp \
$(BULLETSRC)/BulletCollision/BroadphaseCollision/btMultiSapBroadphase.cpp \
$(BULLETSRC)/BulletCollision/BroadphaseCollision/btOverlappingPairCache.cpp \
$(BULLETSRC)/BulletCollision/BroadphaseCollision/btQuantizedBvh.cpp \
$(BULLETSRC)/BulletCollision/BroadphaseCollision/btSimpleBroadphase.cpp \
\
$(BULLETSRC)/BulletCollision/CollisionDispatch/btActivatingCollisionAlgorithm.cpp \
$(BULLETSRC)/BulletCollision/CollisionDispatch/btBoxBoxCollisionAlgorithm.cpp \
$(BULLETSRC)/BulletCollision/CollisionDispatch/btBox2dBox2dCollisionAlgorithm.cpp \
$(BULLETSRC)/BulletCollision/CollisionDispatch/btBoxBoxDetector.cpp \
$(BULLETSRC)/BulletCollision/CollisionDispatch/btCollisionDispatcher.cpp \
$(BULLETSRC)/BulletCollision/CollisionDispatch/btCollisionObject.cpp \
$(BULLETSRC)/BulletCollision/CollisionDispatch/btCollisionWorld.cpp \
$(BULLETSRC)/BulletCollision/CollisionDispatch/btCompoundCollisionAlgorithm.cpp \
$(BULLETSRC)/BulletCollision/CollisionDispatch/btConvexConcaveCollisionAlgorithm.cpp \
$(BULLETSRC)/BulletCollision/CollisionDispatch/btConvexConvexAlgorithm.cpp \
$(BULLETSRC)/BulletCollision/CollisionDispatch/btConvexPlaneCollisionAlgorithm.cpp \
$(BULLETSRC)/BulletCollision/CollisionDispatch/btConvex2dConvex2dAlgorithm.cpp \
$(BULLETSRC)/BulletCollision/CollisionDispatch/btDefaultCollisionConfiguration.cpp \
$(BULLETSRC)/BulletCollision/CollisionDispatch/btEmptyCollisionAlgorithm.cpp \
$(BULLETSRC)/BulletCollision/CollisionDispatch/btGhostObject.cpp \
$(BULLETSRC)/BulletCollision/CollisionDispatch/btInternalEdgeUtility.cpp \
$(BULLETSRC)/BulletCollision/CollisionDispatch/btManifoldResult.cpp \
$(BULLETSRC)/BulletCollision/CollisionDispatch/btSimulationIslandManager.cpp \
$(BULLETSRC)/BulletCollision/CollisionDispatch/btSphereBoxCollisionAlgorithm.cpp \
$(BULLETSRC)/BulletCollision/CollisionDispatch/btSphereSphereCollisionAlgorithm.cpp \
$(BULLETSRC)/BulletCollision/CollisionDispatch/btSphereTriangleCollisionAlgorithm.cpp \
$(BULLETSRC)/BulletCollision/CollisionDispatch/btUnionFind.cpp \
$(BULLETSRC)/BulletCollision/CollisionDispatch/SphereTriangleDetector.cpp \
\
$(BULLETSRC)/BulletCollision/CollisionShapes/btBoxShape.cpp \
$(BULLETSRC)/BulletCollision/CollisionShapes/btBox2dShape.cpp \
$(BULLETSRC)/BulletCollision/CollisionShapes/btBvhTriangleMeshShape.cpp \
$(BULLETSRC)/BulletCollision/CollisionShapes/btCapsuleShape.cpp \
$(BULLETSRC)/BulletCollision/CollisionShapes/btCollisionShape.cpp \
$(BULLETSRC)/BulletCollision/CollisionShapes/btCompoundShape.cpp \
$(BULLETSRC)/BulletCollision/CollisionShapes/btConcaveShape.cpp \
$(BULLETSRC)/BulletCollision/CollisionShapes/btConeShape.cpp \
$(BULLETSRC)/BulletCollision/CollisionShapes/btConvexHullShape.cpp \
$(BULLETSRC)/BulletCollision/CollisionShapes/btConvexInternalShape.cpp \
$(BULLETSRC)/BulletCollision/CollisionShapes/btConvexPointCloudShape.cpp \
$(BULLETSRC)/BulletCollision/CollisionShapes/btConvexShape.cpp \
$(BULLETSRC)/BulletCollision/CollisionShapes/btConvex2dShape.cpp \
$(BULLETSRC)/BulletCollision/CollisionShapes/btConvexTriangleMeshShape.cpp \
$(BULLETSRC)/BulletCollision/CollisionShapes/btCylinderShape.cpp \
$(BULLETSRC)/BulletCollision/CollisionShapes/btEmptyShape.cpp \
$(BULLETSRC)/BulletCollision/CollisionShapes/btHeightfieldTerrainShape.cpp \
$(BULLETSRC)/BulletCollision/CollisionShapes/btMinkowskiSumShape.cpp \
$(BULLETSRC)/BulletCollision/CollisionShapes/btMultimaterialTriangleMeshShape.cpp \
$(BULLETSRC)/BulletCollision/CollisionShapes/btMultiSphereShape.cpp \
$(BULLETSRC)/BulletCollision/CollisionShapes/btOptimizedBvh.cpp \
$(BULLETSRC)/BulletCollision/CollisionShapes/btPolyhedralConvexShape.cpp \
$(BULLETSRC)/BulletCollision/CollisionShapes/btScaledBvhTriangleMeshShape.cpp \
$(BULLETSRC)/BulletCollision/CollisionShapes/btShapeHull.cpp \
$(BULLETSRC)/BulletCollision/CollisionShapes/btSphereShape.cpp \
$(BULLETSRC)/BulletCollision/CollisionShapes/btStaticPlaneShape.cpp \
$(BULLETSRC)/BulletCollision/CollisionShapes/btStridingMeshInterface.cpp \
$(BULLETSRC)/BulletCollision/CollisionShapes/btTetrahedronShape.cpp \
$(BULLETSRC)/BulletCollision/CollisionShapes/btTriangleBuffer.cpp \
$(BULLETSRC)/BulletCollision/CollisionShapes/btTriangleCallback.cpp \
$(BULLETSRC)/BulletCollision/CollisionShapes/btTriangleIndexVertexArray.cpp \
$(BULLETSRC)/BulletCollision/CollisionShapes/btTriangleIndexVertexMaterialArray.cpp \
$(BULLETSRC)/BulletCollision/CollisionShapes/btTriangleMesh.cpp \
$(BULLETSRC)/BulletCollision/CollisionShapes/btTriangleMeshShape.cpp \
$(BULLETSRC)/BulletCollision/CollisionShapes/btUniformScalingShape.cpp \
\
$(BULLETSRC)/BulletCollision/Gimpact/btContactProcessing.cpp \
$(BULLETSRC)/BulletCollision/Gimpact/btGenericPoolAllocator.cpp \
$(BULLETSRC)/BulletCollision/Gimpact/btGImpactBvh.cpp \
$(BULLETSRC)/BulletCollision/Gimpact/btGImpactCollisionAlgorithm.cpp \
$(BULLETSRC)/BulletCollision/Gimpact/btGImpactQuantizedBvh.cpp \
$(BULLETSRC)/BulletCollision/Gimpact/btGImpactShape.cpp \
$(BULLETSRC)/BulletCollision/Gimpact/btTriangleShapeEx.cpp \
$(BULLETSRC)/BulletCollision/Gimpact/gim_box_set.cpp \
$(BULLETSRC)/BulletCollision/Gimpact/gim_contact.cpp \
$(BULLETSRC)/BulletCollision/Gimpact/gim_memory.cpp \
$(BULLETSRC)/BulletCollision/Gimpact/gim_tri_collision.cpp \
\
$(BULLETSRC)/BulletCollision/NarrowPhaseCollision/btContinuousConvexCollision.cpp \
$(BULLETSRC)/BulletCollision/NarrowPhaseCollision/btConvexCast.cpp \
$(BULLETSRC)/BulletCollision/NarrowPhaseCollision/btGjkConvexCast.cpp \
$(BULLETSRC)/BulletCollision/NarrowPhaseCollision/btGjkEpa2.cpp \
$(BULLETSRC)/BulletCollision/NarrowPhaseCollision/btGjkEpaPenetrationDepthSolver.cpp \
$(BULLETSRC)/BulletCollision/NarrowPhaseCollision/btGjkPairDetector.cpp \
$(BULLETSRC)/BulletCollision/NarrowPhaseCollision/btMinkowskiPenetrationDepthSolver.cpp \
$(BULLETSRC)/BulletCollision/NarrowPhaseCollision/btPersistentManifold.cpp \
$(BULLETSRC)/BulletCollision/NarrowPhaseCollision/btRaycastCallback.cpp \
$(BULLETSRC)/BulletCollision/NarrowPhaseCollision/btSubSimplexConvexCast.cpp \
$(BULLETSRC)/BulletCollision/NarrowPhaseCollision/btVoronoiSimplexSolver.cpp \
\
$(BULLETSRC)/BulletDynamics/Character/btKinematicCharacterController.cpp \
$(BULLETSRC)/BulletDynamics/ConstraintSolver/btConeTwistConstraint.cpp \
$(BULLETSRC)/BulletDynamics/ConstraintSolver/btContactConstraint.cpp \
$(BULLETSRC)/BulletDynamics/ConstraintSolver/btGeneric6DofConstraint.cpp \
$(BULLETSRC)/BulletDynamics/ConstraintSolver/btGeneric6DofSpringConstraint.cpp \
$(BULLETSRC)/BulletDynamics/ConstraintSolver/btHinge2Constraint.cpp \
$(BULLETSRC)/BulletDynamics/ConstraintSolver/btHingeConstraint.cpp \
$(BULLETSRC)/BulletDynamics/ConstraintSolver/btPoint2PointConstraint.cpp \
$(BULLETSRC)/BulletDynamics/ConstraintSolver/btSequentialImpulseConstraintSolver.cpp \
$(BULLETSRC)/BulletDynamics/ConstraintSolver/btSliderConstraint.cpp \
$(BULLETSRC)/BulletDynamics/ConstraintSolver/btSolve2LinearConstraint.cpp \
$(BULLETSRC)/BulletDynamics/ConstraintSolver/btTypedConstraint.cpp \
$(BULLETSRC)/BulletDynamics/ConstraintSolver/btUniversalConstraint.cpp \
\
$(BULLETSRC)/BulletDynamics/Dynamics/btContinuousDynamicsWorld.cpp \
$(BULLETSRC)/BulletDynamics/Dynamics/btDiscreteDynamicsWorld.cpp \
$(BULLETSRC)/BulletDynamics/Dynamics/btRigidBody.cpp \
$(BULLETSRC)/BulletDynamics/Dynamics/btSimpleDynamicsWorld.cpp \
$(BULLETSRC)/BulletDynamics/Dynamics/Bullet-C-API.cpp \
\
$(BULLETSRC)/BulletDynamics/Vehicle/btRaycastVehicle.cpp \
$(BULLETSRC)/BulletDynamics/Vehicle/btWheelInfo.cpp \
\
$(BULLETSRC)/LinearMath/btAlignedAllocator.cpp \
$(BULLETSRC)/LinearMath/btConvexHull.cpp \
$(BULLETSRC)/LinearMath/btGeometryUtil.cpp \
$(BULLETSRC)/LinearMath/btQuickprof.cpp \
$(BULLETSRC)/LinearMath/btSerializer.cpp \
\
$(BULLETSRC)/BulletSoftBody/btDefaultSoftBodySolver.cpp \
$(BULLETSRC)/BulletSoftBody/btSoftBody.cpp \
$(BULLETSRC)/BulletSoftBody/btSoftBodyConcaveCollisionAlgorithm.cpp \
$(BULLETSRC)/BulletSoftBody/btSoftBodyHelpers.cpp \
$(BULLETSRC)/BulletSoftBody/btSoftBodyRigidBodyCollisionConfiguration.cpp \
$(BULLETSRC)/BulletSoftBody/btSoftRigidCollisionAlgorithm.cpp \
$(BULLETSRC)/BulletSoftBody/btSoftRigidDynamicsWorld.cpp \
$(BULLETSRC)/BulletSoftBody/btSoftSoftCollisionAlgorithm.cpp

include $(BUILD_STATIC_LIBRARY)

##################################
########## rtphysics.so ##########
##################################

include $(CLEAR_VARS)

LOCAL_MODULE := librtphysics
SHARED := ../../../shared
APP := ../../source
APPCOMP := ../../source/Component
LOCAL_ARM_MODE := arm

ENTITYSRC := $(SHARED)/Entity
CLANCORE := $(SHARED)/ClanLib-2.0/Sources/Core
IRRSRC :=  $(SHARED)/Irrlicht/source
IRRMESH := $(IRRSRC)
IRRSCENE := $(IRRSRC)
PNGSRC :=  $(SHARED)/Irrlicht/source/libpng
JPGSRC :=  $(SHARED)/Irrlicht/source/jpeglib
IRRBULLET := $(SHARED)/Irrlicht/irrBullet

#LOCAL_CPP_FEATURES += exceptions
LOCAL_CPP_FEATURES += rtti

APP_DEBUG := $(strip $(NDK_DEBUG))
ifeq ($(APP_DEBUG),0)
	LOCAL_CFLAGS := -DANDROID_NDK -DBUILD_ANDROID -DGC_BUILD_ANDROID -DNDEBUG -D_IRR_STATIC_LIB_ -DRT_IRRBULLET -DHAVE_NEON=1 -mfpu=neon -mfloat-abi=softfp
	LOCAL_CPPFLAGS := -DGC_BUILD_C -DANDROID_NDK -DBUILD_ANDROID -DNDEBUG -D_IRR_STATIC_LIB_ -DRT_IRRBULLET -DHAVE_NEON=1 -mfpu=neon -mfloat-abi=softfp
else
	LOCAL_CFLAGS := -DANDROID_NDK -DBUILD_ANDROID -DGC_BUILD_ANDROID -D_DEBUG -D_IRR_STATIC_LIB_ -DRT_IRRBULLET -DHAVE_NEON=1 -mfpu=neon -mfloat-abi=softfp
	LOCAL_CPPFLAGS := -DGC_BUILD_C -DANDROID_NDK -DBUILD_ANDROID -D_DEBUG -D_IRR_STATIC_LIB_ -DRT_IRRBULLET -DHAVE_NEON=1 -mfpu=neon -mfloat-abi=softfp
	LOCAL_STRIP_MODULE := false
endif

LOCAL_C_INCLUDES := \
$(LOCAL_PATH)/$(APP) \
$(LOCAL_PATH)/$(SHARED) \
$(LOCAL_PATH)/$(SHARED)/ClanLib-2.0/Sources \
$(LOCAL_PATH)/$(SHARED)/util/boost \
$(LOCAL_PATH)/$(SHARED)/Bullet \
$(LOCAL_PATH)/$(SHARED)/Irrlicht/include

LOCAL_SRC_FILES := \
$(SHARED)/PlatformSetup.cpp $(SHARED)/android/AndroidUtils.cpp ../temp_final_cpp_src/AndroidApp.cpp \
$(SHARED)/Audio/AudioManager.cpp $(SHARED)/Audio/AudioManagerAndroid.cpp \
$(CLANCORE)/core_global.cpp \
$(CLANCORE)/Math/angle.cpp $(CLANCORE)/Math/mat3.cpp $(CLANCORE)/Math/mat4.cpp $(CLANCORE)/Math/rect.cpp $(CLANCORE)/Math/vec2.cpp $(CLANCORE)/Math/vec3.cpp $(CLANCORE)/Math/vec4.cpp \
$(CLANCORE)/System/mutex.cpp $(CLANCORE)/System/runnable.cpp $(CLANCORE)/System/system.cpp $(CLANCORE)/System/thread.cpp $(CLANCORE)/System/thread_local_storage.cpp $(CLANCORE)/System/thread_local_storage_impl.cpp $(CLANCORE)/System/Unix/thread_unix.cpp \
$(SHARED)/Manager/Console.cpp \
$(SHARED)/Manager/GameTimer.cpp $(SHARED)/Manager/MessageManager.cpp $(SHARED)/Manager/ResourceManager.cpp $(SHARED)/Manager/VariantDB.cpp $(SHARED)/Math/rtPlane.cpp \
$(SHARED)/Math/rtRect.cpp \
$(SHARED)/util/CRandom.cpp $(SHARED)/util/GLESUtils.cpp $(SHARED)/util/MathUtils.cpp $(SHARED)/util/MiscUtils.cpp $(SHARED)/util/RenderUtils.cpp $(SHARED)/util/ResourceUtils.cpp \
$(SHARED)/util/Variant.cpp $(SHARED)/util/boost/libs/signals/src/connection.cpp $(SHARED)/util/boost/libs/signals/src/named_slot_map.cpp $(SHARED)/util/boost/libs/signals/src/signal_base.cpp \
$(SHARED)/util/boost/libs/signals/src/slot.cpp $(SHARED)/util/boost/libs/signals/src/trackable.cpp $(SHARED)/BaseApp.cpp \
$(SHARED)/util/unzip/zip.c $(SHARED)/util/unzip/unzip.c $(SHARED)/util/unzip/ioapi.c $(SHARED)/util/unzip/ioapi_mem.c \
$(SHARED)/util/TextScanner.cpp \
$(SHARED)/Network/NetHTTP.cpp $(SHARED)/Network/NetSocket.cpp $(SHARED)/Network/NetUtils.cpp $(SHARED)/Audio/AudioManagerSDL.cpp  $(SHARED)/FileSystem/StreamingInstance.cpp \
$(SHARED)/FileSystem/StreamingInstanceZip.cpp $(SHARED)/FileSystem/StreamingInstanceFile.cpp $(SHARED)/FileSystem/FileSystem.cpp $(SHARED)/FileSystem/FileSystemZip.cpp \
$(SHARED)/FileSystem/FileManager.cpp \
\
$(ENTITYSRC)/Entity.cpp $(ENTITYSRC)/Component.cpp $(ENTITYSRC)/EntityUtils.cpp $(ENTITYSRC)/FocusRenderComponent.cpp $(ENTITYSRC)/FocusUpdateComponent.cpp \
\
$(SHARED)/Irrlicht/IrrlichtManager.cpp $(IRRSRC)/CAttributes.cpp $(IRRSRC)/CBoneSceneNode.cpp $(IRRSRC)/CColorConverter.cpp \
$(IRRSRC)/CDefaultSceneNodeAnimatorFactory.cpp $(IRRSRC)/CDefaultSceneNodeFactory.cpp $(IRRSRC)/CDepthBuffer.cpp $(IRRSRC)/CDummyTransformationSceneNode.cpp $(IRRSRC)/CEmptySceneNode.cpp \
$(IRRSRC)/CFPSCounter.cpp $(IRRSRC)/CGeometryCreator.cpp $(IRRSRC)/CLightSceneNode.cpp $(IRRSRC)/CLogger.cpp $(IRRSRC)/CMemoryFile.cpp \
$(IRRSRC)/CMeshCache.cpp $(IRRSRC)/CMeshManipulator.cpp $(IRRSRC)/CMeshSceneNode.cpp $(IRRSRC)/COCTLoader.cpp $(IRRSRC)/COctreeSceneNode.cpp \
$(IRRSRC)/CSkinnedMesh.cpp $(IRRSRC)/CTextSceneNode.cpp $(IRRSRC)/CTriangleBBSelector.cpp $(IRRSRC)/CTriangleSelector.cpp $(IRRSRC)/COctreeTriangleSelector.cpp \
$(IRRSRC)/CVideoModeList.cpp $(IRRSRC)/CVolumeLightSceneNode.cpp $(IRRSRC)/CWaterSurfaceSceneNode.cpp $(IRRSRC)/Irrlicht.cpp \
$(IRRSRC)/irrXML.cpp $(IRRSRC)/os.cpp $(IRRSRC)/CMetaTriangleSelector.cpp \
\
$(IRRSRC)/CCameraSceneNode.cpp $(IRRSRC)/CSceneNodeAnimatorCameraFPS.cpp $(IRRSRC)/CIrrDeviceIPhone.cpp $(IRRSRC)/CIrrDeviceStub.cpp \
\
$(IRRSRC)/CFileList.cpp $(IRRSRC)/CFileSystem.cpp $(IRRSRC)/CLimitReadFile.cpp $(IRRSRC)/CMountPointReader.cpp \
$(IRRSRC)/COSOperator.cpp $(IRRSRC)/CReadFile.cpp $(IRRSRC)/CWriteFile.cpp  $(IRRSRC)/CXMLReader.cpp  $(IRRSRC)/CXMLWriter.cpp \
$(IRRSRC)/CZBuffer.cpp $(IRRSRC)/CZipReader.cpp $(IRRSRC)/CProtonReader.cpp \
\
$(IRRSRC)/CImage.cpp $(IRRSRC)/CImageLoaderBMP.cpp $(IRRSRC)/CImageLoaderJPG.cpp $(IRRSRC)/CImageLoaderPNG.cpp  $(IRRSRC)/CImageLoaderRGB.cpp $(IRRSRC)/CImageLoaderTGA.cpp \
\
$(JPGSRC)/jcapimin.c $(JPGSRC)/jcapistd.c $(JPGSRC)/jccoefct.c $(JPGSRC)/jccolor.c $(JPGSRC)/jcdctmgr.c $(JPGSRC)/jchuff.c $(JPGSRC)/jcinit.c $(JPGSRC)/jcmainct.c \
$(JPGSRC)/jcmarker.c $(JPGSRC)/jcmaster.c $(JPGSRC)/jcomapi.c $(JPGSRC)/jcparam.c $(JPGSRC)/jcphuff.c $(JPGSRC)/jcprepct.c $(JPGSRC)/jcsample.c $(JPGSRC)/jctrans.c \
$(JPGSRC)/jdapimin.c $(JPGSRC)/jdapistd.c $(JPGSRC)/jdatadst.c $(JPGSRC)/jdatasrc.c $(JPGSRC)/jdcoefct.c $(JPGSRC)/jdcolor.c $(JPGSRC)/jddctmgr.c \
$(JPGSRC)/jdhuff.c $(JPGSRC)/jdinput.c $(JPGSRC)/jdmainct.c $(JPGSRC)/jdmarker.c $(JPGSRC)/jdmaster.c $(JPGSRC)/jdmerge.c $(JPGSRC)/jdphuff.c $(JPGSRC)/jdpostct.c \
$(JPGSRC)/jdsample.c $(JPGSRC)/jdtrans.c $(JPGSRC)/jerror.c $(JPGSRC)/jfdctflt.c $(JPGSRC)/jfdctfst.c $(JPGSRC)/jfdctint.c $(JPGSRC)/jidctflt.c $(JPGSRC)/jidctfst.c \
$(JPGSRC)/jidctint.c $(JPGSRC)/jidctred.c $(JPGSRC)/jmemmgr.c $(JPGSRC)/jmemnobs.c $(JPGSRC)/jquant1.c $(JPGSRC)/jquant2.c $(JPGSRC)/jutils.c \
\
$(PNGSRC)/png.c $(PNGSRC)/pngerror.c $(PNGSRC)/pnggccrd.c $(PNGSRC)/pngget.c $(PNGSRC)/pngmem.c $(PNGSRC)/pngpread.c $(PNGSRC)/pngread.c \
$(PNGSRC)/pngrio.c $(PNGSRC)/pngrtran.c $(PNGSRC)/pngrutil.c $(PNGSRC)/pngset.c $(PNGSRC)/pngtrans.c $(PNGSRC)/pngvcrd.c $(PNGSRC)/pngwio.c $(PNGSRC)/pngwtran.c \
\
$(IRRMESH)/C3DSMeshFileLoader.cpp $(IRRMESH)/CAnimatedMeshMD2.cpp $(IRRMESH)/CAnimatedMeshMD3.cpp $(IRRMESH)/CB3DMeshFileLoader.cpp $(IRRMESH)/CBSPMeshFileLoader.cpp $(IRRMESH)/CAnimatedMeshHalfLife.cpp \
$(IRRMESH)/CColladaFileLoader.cpp $(IRRMESH)/CCSMLoader.cpp $(IRRMESH)/CMD2MeshFileLoader.cpp $(IRRMESH)/CMD3MeshFileLoader.cpp $(IRRMESH)/CMS3DMeshFileLoader.cpp \
$(IRRMESH)/CMY3DMeshFileLoader.cpp $(IRRMESH)/COBJMeshFileLoader.cpp $(IRRMESH)/CQ3LevelMesh.cpp $(IRRMESH)/CQuake3ShaderSceneNode.cpp $(IRRMESH)/CXMeshFileLoader.cpp $(IRRMESH)/CDMFLoader.cpp $(IRRMESH)/CLMTSMeshFileLoader.cpp $(IRRMESH)/CLWOMeshFileLoader.cpp $(IRRMESH)/COgreMeshFileLoader.cpp $(IRRMESH)/CSMFMeshFileLoader.cpp $(IRRMESH)/CSTLMeshFileLoader.cpp \
\
$(IRRMESH)/CParticleAnimatedMeshSceneNodeEmitter.cpp $(IRRMESH)/CParticleAttractionAffector.cpp $(IRRMESH)/CParticleBoxEmitter.cpp $(IRRMESH)/CParticleCylinderEmitter.cpp $(IRRMESH)/CParticleFadeOutAffector.cpp \
$(IRRMESH)/CParticleGravityAffector.cpp $(IRRMESH)/CParticleMeshEmitter.cpp $(IRRMESH)/CParticlePointEmitter.cpp $(IRRMESH)/CParticleRingEmitter.cpp $(IRRMESH)/CParticleRotationAffector.cpp \
$(IRRMESH)/CParticleScaleAffector.cpp $(IRRMESH)/CParticleSphereEmitter.cpp $(IRRMESH)/CParticleSystemSceneNode.cpp \
\
$(IRRSCENE)/CAnimatedMeshSceneNode.cpp $(IRRSCENE)/CBillboardSceneNode.cpp $(IRRSCENE)/CCubeSceneNode.cpp $(IRRSCENE)/CSceneCollisionManager.cpp $(IRRSCENE)/CSceneManager.cpp \
$(IRRSCENE)/CSceneNodeAnimatorCameraMaya.cpp $(IRRSCENE)/CSceneNodeAnimatorCollisionResponse.cpp $(IRRSCENE)/CSceneNodeAnimatorDelete.cpp $(IRRSCENE)/CSceneNodeAnimatorFlyCircle.cpp $(IRRSCENE)/CSceneNodeAnimatorFlyStraight.cpp \
$(IRRSCENE)/CSceneNodeAnimatorFollowSpline.cpp $(IRRSCENE)/CSceneNodeAnimatorRotation.cpp $(IRRSCENE)/CSceneNodeAnimatorTexture.cpp $(IRRSCENE)/CShadowVolumeSceneNode.cpp $(IRRSCENE)/CSceneLoaderIrr.cpp \
\
$(IRRSCENE)/CDefaultGUIElementFactory.cpp $(IRRSCENE)/CGUIEnvironment.cpp \
$(IRRSCENE)/CGUIButton.cpp $(IRRSCENE)/CGUICheckBox.cpp $(IRRSCENE)/CGUIColorSelectDialog.cpp $(IRRSCENE)/CGUIComboBox.cpp $(IRRSCENE)/CGUIContextMenu.cpp $(IRRSCENE)/CGUIEditBox.cpp $(IRRSCENE)/CGUIFileOpenDialog.cpp \
$(IRRSCENE)/CGUIFont.cpp $(IRRSCENE)/CGUIImage.cpp $(IRRSCENE)/CGUIImageList.cpp $(IRRSCENE)/CGUIInOutFader.cpp $(IRRSCENE)/CGUIListBox.cpp $(IRRSCENE)/CGUIMenu.cpp $(IRRSCENE)/CGUIMeshViewer.cpp $(IRRSCENE)/CGUIMessageBox.cpp \
$(IRRSCENE)/CGUIModalScreen.cpp $(IRRSCENE)/CGUIScrollBar.cpp $(IRRSCENE)/CGUISkin.cpp $(IRRSCENE)/CGUISpinBox.cpp $(IRRSCENE)/CGUISpriteBank.cpp $(IRRSCENE)/CGUIStaticText.cpp $(IRRSCENE)/CGUITabControl.cpp $(IRRSCENE)/CGUITable.cpp \
$(IRRSCENE)/CGUIToolBar.cpp $(IRRSCENE)/CGUITreeView.cpp $(IRRSCENE)/CGUIWindow.cpp \
\
$(IRRSRC)/CSkyBoxSceneNode.cpp $(IRRSRC)/CSkyDomeSceneNode.cpp $(IRRSRC)/CSphereSceneNode.cpp $(IRRSRC)/CTerrainSceneNode.cpp $(IRRSRC)/CTerrainTriangleSelector.cpp \
$(IRRSRC)/CNullDriver.cpp $(IRRSRC)/COGLESDriver.cpp $(IRRSRC)/COGLESExtensionHandler.cpp $(IRRSRC)/COGLESTexture.cpp $(IRRSRC)/COGLES2Driver.cpp $(IRRSRC)/COGLES2ExtensionHandler.cpp $(IRRSRC)/COGLES2Texture.cpp $(IRRSRC)/COGLES2FixedPipelineRenderer.cpp $(IRRSRC)/COGLES2MaterialRenderer.cpp $(IRRSRC)/COGLES2NormalMapRenderer.cpp $(IRRSRC)/COGLES2ParallaxMapRenderer.cpp $(IRRSRC)/COGLES2Renderer2D.cpp $(IRRSRC)/BuiltInFont.cpp \
\
$(IRRBULLET)/boxshape.cpp $(IRRBULLET)/bulletworld.cpp $(IRRBULLET)/bvhtrianglemeshshape.cpp $(IRRBULLET)/collisioncallbackinformation.cpp $(IRRBULLET)/collisionobject.cpp \
$(IRRBULLET)/collisionobjectaffector.cpp $(IRRBULLET)/collisionobjectaffectorattract.cpp $(IRRBULLET)/collisionobjectaffectordelete.cpp $(IRRBULLET)/collisionshape.cpp $(IRRBULLET)/convexhullshape.cpp \
$(IRRBULLET)/gimpactmeshshape.cpp $(IRRBULLET)/irrbullet.cpp $(IRRBULLET)/irrbulletcommon.cpp $(IRRBULLET)/liquidbody.cpp $(IRRBULLET)/motionstate.cpp \
$(IRRBULLET)/physicsdebug.cpp $(IRRBULLET)/raycastvehicle.cpp $(IRRBULLET)/rigidbody.cpp $(IRRBULLET)/softbody.cpp $(IRRBULLET)/sphereshape.cpp \
$(IRRBULLET)/trianglemeshshape.cpp \
\
$(APP)/App.cpp $(APP)/GUI/MainMenu.cpp \
$(APP)/GUI/PhysicsHelloMenu.cpp \
$(APP)/Component/EventControlComponent.cpp

LOCAL_STATIC_LIBRARIES := libbullet
LOCAL_LDLIBS := -lGLESv1_CM -lGLESv2 -ldl -llog -lz

include $(BUILD_SHARED_LIBRARY)
