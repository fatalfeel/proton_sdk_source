LOCAL_PATH := $(call my-dir)

##################################
########### bullet.a #############
##################################

include $(CLEAR_VARS)

LOCAL_MODULE := bullet
SHARED := ../../../shared
LOCAL_ARM_MODE := arm

EXTBULLET := $(SHARED)/Bullet

#LOCAL_CPP_FEATURES += exceptions
LOCAL_CPP_FEATURES += rtti

APP_DEBUG := $(strip $(NDK_DEBUG))
ifeq ($(APP_DEBUG),0)
	LOCAL_CFLAGS := -DANDROID_NDK -DBUILD_ANDROID -DGC_BUILD_ANDROID -DNDEBUG -DHAVE_NEON=1 -mfpu=neon -mfloat-abi=softfp
	LOCAL_CPPFLAGS := -DGC_BUILD_C -DANDROID_NDK -DBUILD_ANDROID -DNDEBUG -DHAVE_NEON=1 -mfpu=neon -mfloat-abi=softfp
else
	LOCAL_CFLAGS := -DANDROID_NDK -DBUILD_ANDROID -DGC_BUILD_ANDROID -D_DEBUG -DHAVE_NEON=1 -mfpu=neon -mfloat-abi=softfp
	LOCAL_CPPFLAGS := -DGC_BUILD_C -DANDROID_NDK -DBUILD_ANDROID -D_DEBUG -DHAVE_NEON=1 -mfpu=neon -mfloat-abi=softfp
endif

LOCAL_C_INCLUDES := \
$(LOCAL_PATH)/$(APP) \
$(LOCAL_PATH)/$(SHARED) \
$(LOCAL_PATH)/$(SHARED)/ClanLib-2.0/Sources \
$(LOCAL_PATH)/$(SHARED)/util/boost \
$(LOCAL_PATH)/$(EXTBULLET) \
$(LOCAL_PATH)/$(SHARED)/Irrlicht/include
                
LOCAL_SRC_FILES := \
$(EXTBULLET)/BulletCollision/BroadphaseCollision/btAxisSweep3.cpp \
$(EXTBULLET)/BulletCollision/BroadphaseCollision/btBroadphaseProxy.cpp \
$(EXTBULLET)/BulletCollision/BroadphaseCollision/btCollisionAlgorithm.cpp \
$(EXTBULLET)/BulletCollision/BroadphaseCollision/btDbvt.cpp \
$(EXTBULLET)/BulletCollision/BroadphaseCollision/btDbvtBroadphase.cpp \
$(EXTBULLET)/BulletCollision/BroadphaseCollision/btDispatcher.cpp \
$(EXTBULLET)/BulletCollision/BroadphaseCollision/btMultiSapBroadphase.cpp \
$(EXTBULLET)/BulletCollision/BroadphaseCollision/btOverlappingPairCache.cpp \
$(EXTBULLET)/BulletCollision/BroadphaseCollision/btQuantizedBvh.cpp \
$(EXTBULLET)/BulletCollision/BroadphaseCollision/btSimpleBroadphase.cpp \
\
$(EXTBULLET)/BulletCollision/CollisionDispatch/btActivatingCollisionAlgorithm.cpp \
$(EXTBULLET)/BulletCollision/CollisionDispatch/btBoxBoxCollisionAlgorithm.cpp \
$(EXTBULLET)/BulletCollision/CollisionDispatch/btBox2dBox2dCollisionAlgorithm.cpp \
$(EXTBULLET)/BulletCollision/CollisionDispatch/btBoxBoxDetector.cpp \
$(EXTBULLET)/BulletCollision/CollisionDispatch/btCollisionDispatcher.cpp \
$(EXTBULLET)/BulletCollision/CollisionDispatch/btCollisionObject.cpp \
$(EXTBULLET)/BulletCollision/CollisionDispatch/btCollisionWorld.cpp \
$(EXTBULLET)/BulletCollision/CollisionDispatch/btCompoundCollisionAlgorithm.cpp \
$(EXTBULLET)/BulletCollision/CollisionDispatch/btConvexConcaveCollisionAlgorithm.cpp \
$(EXTBULLET)/BulletCollision/CollisionDispatch/btConvexConvexAlgorithm.cpp \
$(EXTBULLET)/BulletCollision/CollisionDispatch/btConvexPlaneCollisionAlgorithm.cpp \
$(EXTBULLET)/BulletCollision/CollisionDispatch/btConvex2dConvex2dAlgorithm.cpp \
$(EXTBULLET)/BulletCollision/CollisionDispatch/btDefaultCollisionConfiguration.cpp \
$(EXTBULLET)/BulletCollision/CollisionDispatch/btEmptyCollisionAlgorithm.cpp \
$(EXTBULLET)/BulletCollision/CollisionDispatch/btGhostObject.cpp \
$(EXTBULLET)/BulletCollision/CollisionDispatch/btInternalEdgeUtility.cpp \
$(EXTBULLET)/BulletCollision/CollisionDispatch/btManifoldResult.cpp \
$(EXTBULLET)/BulletCollision/CollisionDispatch/btSimulationIslandManager.cpp \
$(EXTBULLET)/BulletCollision/CollisionDispatch/btSphereBoxCollisionAlgorithm.cpp \
$(EXTBULLET)/BulletCollision/CollisionDispatch/btSphereSphereCollisionAlgorithm.cpp \
$(EXTBULLET)/BulletCollision/CollisionDispatch/btSphereTriangleCollisionAlgorithm.cpp \
$(EXTBULLET)/BulletCollision/CollisionDispatch/btUnionFind.cpp \
$(EXTBULLET)/BulletCollision/CollisionDispatch/SphereTriangleDetector.cpp \
\
$(EXTBULLET)/BulletCollision/CollisionShapes/btBoxShape.cpp \
$(EXTBULLET)/BulletCollision/CollisionShapes/btBox2dShape.cpp \
$(EXTBULLET)/BulletCollision/CollisionShapes/btBvhTriangleMeshShape.cpp \
$(EXTBULLET)/BulletCollision/CollisionShapes/btCapsuleShape.cpp \
$(EXTBULLET)/BulletCollision/CollisionShapes/btCollisionShape.cpp \
$(EXTBULLET)/BulletCollision/CollisionShapes/btCompoundShape.cpp \
$(EXTBULLET)/BulletCollision/CollisionShapes/btConcaveShape.cpp \
$(EXTBULLET)/BulletCollision/CollisionShapes/btConeShape.cpp \
$(EXTBULLET)/BulletCollision/CollisionShapes/btConvexHullShape.cpp \
$(EXTBULLET)/BulletCollision/CollisionShapes/btConvexInternalShape.cpp \
$(EXTBULLET)/BulletCollision/CollisionShapes/btConvexPointCloudShape.cpp \
$(EXTBULLET)/BulletCollision/CollisionShapes/btConvexShape.cpp \
$(EXTBULLET)/BulletCollision/CollisionShapes/btConvex2dShape.cpp \
$(EXTBULLET)/BulletCollision/CollisionShapes/btConvexTriangleMeshShape.cpp \
$(EXTBULLET)/BulletCollision/CollisionShapes/btCylinderShape.cpp \
$(EXTBULLET)/BulletCollision/CollisionShapes/btEmptyShape.cpp \
$(EXTBULLET)/BulletCollision/CollisionShapes/btHeightfieldTerrainShape.cpp \
$(EXTBULLET)/BulletCollision/CollisionShapes/btMinkowskiSumShape.cpp \
$(EXTBULLET)/BulletCollision/CollisionShapes/btMultimaterialTriangleMeshShape.cpp \
$(EXTBULLET)/BulletCollision/CollisionShapes/btMultiSphereShape.cpp \
$(EXTBULLET)/BulletCollision/CollisionShapes/btOptimizedBvh.cpp \
$(EXTBULLET)/BulletCollision/CollisionShapes/btPolyhedralConvexShape.cpp \
$(EXTBULLET)/BulletCollision/CollisionShapes/btScaledBvhTriangleMeshShape.cpp \
$(EXTBULLET)/BulletCollision/CollisionShapes/btShapeHull.cpp \
$(EXTBULLET)/BulletCollision/CollisionShapes/btSphereShape.cpp \
$(EXTBULLET)/BulletCollision/CollisionShapes/btStaticPlaneShape.cpp \
$(EXTBULLET)/BulletCollision/CollisionShapes/btStridingMeshInterface.cpp \
$(EXTBULLET)/BulletCollision/CollisionShapes/btTetrahedronShape.cpp \
$(EXTBULLET)/BulletCollision/CollisionShapes/btTriangleBuffer.cpp \
$(EXTBULLET)/BulletCollision/CollisionShapes/btTriangleCallback.cpp \
$(EXTBULLET)/BulletCollision/CollisionShapes/btTriangleIndexVertexArray.cpp \
$(EXTBULLET)/BulletCollision/CollisionShapes/btTriangleIndexVertexMaterialArray.cpp \
$(EXTBULLET)/BulletCollision/CollisionShapes/btTriangleMesh.cpp \
$(EXTBULLET)/BulletCollision/CollisionShapes/btTriangleMeshShape.cpp \
$(EXTBULLET)/BulletCollision/CollisionShapes/btUniformScalingShape.cpp \
\
$(EXTBULLET)/BulletCollision/Gimpact/btContactProcessing.cpp \
$(EXTBULLET)/BulletCollision/Gimpact/btGenericPoolAllocator.cpp \
$(EXTBULLET)/BulletCollision/Gimpact/btGImpactBvh.cpp \
$(EXTBULLET)/BulletCollision/Gimpact/btGImpactCollisionAlgorithm.cpp \
$(EXTBULLET)/BulletCollision/Gimpact/btGImpactQuantizedBvh.cpp \
$(EXTBULLET)/BulletCollision/Gimpact/btGImpactShape.cpp \
$(EXTBULLET)/BulletCollision/Gimpact/btTriangleShapeEx.cpp \
$(EXTBULLET)/BulletCollision/Gimpact/gim_box_set.cpp \
$(EXTBULLET)/BulletCollision/Gimpact/gim_contact.cpp \
$(EXTBULLET)/BulletCollision/Gimpact/gim_memory.cpp \
$(EXTBULLET)/BulletCollision/Gimpact/gim_tri_collision.cpp \
\
$(EXTBULLET)/BulletCollision/NarrowPhaseCollision/btContinuousConvexCollision.cpp \
$(EXTBULLET)/BulletCollision/NarrowPhaseCollision/btConvexCast.cpp \
$(EXTBULLET)/BulletCollision/NarrowPhaseCollision/btGjkConvexCast.cpp \
$(EXTBULLET)/BulletCollision/NarrowPhaseCollision/btGjkEpa2.cpp \
$(EXTBULLET)/BulletCollision/NarrowPhaseCollision/btGjkEpaPenetrationDepthSolver.cpp \
$(EXTBULLET)/BulletCollision/NarrowPhaseCollision/btGjkPairDetector.cpp \
$(EXTBULLET)/BulletCollision/NarrowPhaseCollision/btMinkowskiPenetrationDepthSolver.cpp \
$(EXTBULLET)/BulletCollision/NarrowPhaseCollision/btPersistentManifold.cpp \
$(EXTBULLET)/BulletCollision/NarrowPhaseCollision/btRaycastCallback.cpp \
$(EXTBULLET)/BulletCollision/NarrowPhaseCollision/btSubSimplexConvexCast.cpp \
$(EXTBULLET)/BulletCollision/NarrowPhaseCollision/btVoronoiSimplexSolver.cpp \
\
$(EXTBULLET)/BulletDynamics/Character/btKinematicCharacterController.cpp \
$(EXTBULLET)/BulletDynamics/ConstraintSolver/btConeTwistConstraint.cpp \
$(EXTBULLET)/BulletDynamics/ConstraintSolver/btContactConstraint.cpp \
$(EXTBULLET)/BulletDynamics/ConstraintSolver/btGeneric6DofConstraint.cpp \
$(EXTBULLET)/BulletDynamics/ConstraintSolver/btGeneric6DofSpringConstraint.cpp \
$(EXTBULLET)/BulletDynamics/ConstraintSolver/btHinge2Constraint.cpp \
$(EXTBULLET)/BulletDynamics/ConstraintSolver/btHingeConstraint.cpp \
$(EXTBULLET)/BulletDynamics/ConstraintSolver/btPoint2PointConstraint.cpp \
$(EXTBULLET)/BulletDynamics/ConstraintSolver/btSequentialImpulseConstraintSolver.cpp \
$(EXTBULLET)/BulletDynamics/ConstraintSolver/btSliderConstraint.cpp \
$(EXTBULLET)/BulletDynamics/ConstraintSolver/btSolve2LinearConstraint.cpp \
$(EXTBULLET)/BulletDynamics/ConstraintSolver/btTypedConstraint.cpp \
$(EXTBULLET)/BulletDynamics/ConstraintSolver/btUniversalConstraint.cpp \
\
$(EXTBULLET)/BulletDynamics/Dynamics/btContinuousDynamicsWorld.cpp \
$(EXTBULLET)/BulletDynamics/Dynamics/btDiscreteDynamicsWorld.cpp \
$(EXTBULLET)/BulletDynamics/Dynamics/btRigidBody.cpp \
$(EXTBULLET)/BulletDynamics/Dynamics/btSimpleDynamicsWorld.cpp \
$(EXTBULLET)/BulletDynamics/Dynamics/Bullet-C-API.cpp \
\
$(EXTBULLET)/BulletDynamics/Vehicle/btRaycastVehicle.cpp \
$(EXTBULLET)/BulletDynamics/Vehicle/btWheelInfo.cpp \
\
$(EXTBULLET)/LinearMath/btAlignedAllocator.cpp \
$(EXTBULLET)/LinearMath/btConvexHull.cpp \
$(EXTBULLET)/LinearMath/btGeometryUtil.cpp \
$(EXTBULLET)/LinearMath/btQuickprof.cpp \
$(EXTBULLET)/LinearMath/btSerializer.cpp \
\
$(EXTBULLET)/BulletSoftBody/btDefaultSoftBodySolver.cpp \
$(EXTBULLET)/BulletSoftBody/btSoftBody.cpp \
$(EXTBULLET)/BulletSoftBody/btSoftBodyConcaveCollisionAlgorithm.cpp \
$(EXTBULLET)/BulletSoftBody/btSoftBodyHelpers.cpp \
$(EXTBULLET)/BulletSoftBody/btSoftBodyRigidBodyCollisionConfiguration.cpp \
$(EXTBULLET)/BulletSoftBody/btSoftRigidCollisionAlgorithm.cpp \
$(EXTBULLET)/BulletSoftBody/btSoftRigidDynamicsWorld.cpp \
$(EXTBULLET)/BulletSoftBody/btSoftSoftCollisionAlgorithm.cpp

include $(BUILD_STATIC_LIBRARY)

##################################
########## rtphysics.so ##########
##################################

include $(CLEAR_VARS)

LOCAL_MODULE := rtphysics
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
EXTBULLET := $(SHARED)/Bullet

#LOCAL_CPP_FEATURES += exceptions
LOCAL_CPP_FEATURES += rtti

#release flags
#LOCAL_CFLAGS := -DANDROID_NDK -DBUILD_ANDROID -DGC_BUILD_ANDROID -DNDEBUG -D_IRR_STATIC_LIB_ -DRT_IRRBULLET
#LOCAL_CPPFLAGS := -DGC_BUILD_C -DANDROID_NDK -DBUILD_ANDROID -DNDEBUG -D_IRR_STATIC_LIB_ -DRT_IRRBULLET
#debug flags
#LOCAL_CFLAGS := -DANDROID_NDK -DBUILD_ANDROID -DGC_BUILD_ANDROID -D_DEBUG -D_IRR_STATIC_LIB_ -DRT_IRRBULLET
#LOCAL_CPPFLAGS := -DGC_BUILD_C -DANDROID_NDK -DBUILD_ANDROID -D_DEBUG -D_IRR_STATIC_LIB_ -DRT_IRRBULLET

APP_DEBUG := $(strip $(NDK_DEBUG))
ifeq ($(APP_DEBUG),0)
	LOCAL_CFLAGS := -DANDROID_NDK -DBUILD_ANDROID -DGC_BUILD_ANDROID -DNDEBUG -D_IRR_STATIC_LIB_ -DRT_IRRBULLET -DHAVE_NEON=1 -mfpu=neon -mfloat-abi=softfp
	LOCAL_CPPFLAGS := -DGC_BUILD_C -DANDROID_NDK -DBUILD_ANDROID -DNDEBUG -D_IRR_STATIC_LIB_ -DRT_IRRBULLET -DHAVE_NEON=1 -mfpu=neon -mfloat-abi=softfp
else
	LOCAL_CFLAGS := -DANDROID_NDK -DBUILD_ANDROID -DGC_BUILD_ANDROID -D_DEBUG -D_IRR_STATIC_LIB_ -DRT_IRRBULLET -DHAVE_NEON=1 -mfpu=neon -mfloat-abi=softfp
	LOCAL_CPPFLAGS := -DGC_BUILD_C -DANDROID_NDK -DBUILD_ANDROID -D_DEBUG -D_IRR_STATIC_LIB_ -DRT_IRRBULLET -DHAVE_NEON=1 -mfpu=neon -mfloat-abi=softfp
endif

LOCAL_C_INCLUDES := \
$(LOCAL_PATH)/$(APP) \
$(LOCAL_PATH)/$(SHARED) \
$(LOCAL_PATH)/$(SHARED)/ClanLib-2.0/Sources \
$(LOCAL_PATH)/$(SHARED)/util/boost \
$(LOCAL_PATH)/$(EXTBULLET) \
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
$(ENTITYSRC)/Entity.cpp $(ENTITYSRC)/Component.cpp $(ENTITYSRC)/EntityUtils.cpp $(ENTITYSRC)/FocusInputComponent.cpp $(ENTITYSRC)/FocusRenderComponent.cpp $(ENTITYSRC)/FocusUpdateComponent.cpp \
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
\
$(IRRSRC)/CNullDriver.cpp $(IRRSRC)/COGLESDriver.cpp $(IRRSRC)/COGLESExtensionHandler.cpp $(IRRSRC)/COGLESTexture.cpp $(IRRSRC)/COGLES2Driver.cpp $(IRRSRC)/COGLES2ExtensionHandler.cpp $(IRRSRC)/COGLES2Texture.cpp $(IRRSRC)/COGLES2FixedPipelineRenderer.cpp $(IRRSRC)/COGLES2MaterialRenderer.cpp $(IRRSRC)/COGLES2NormalMapRenderer.cpp $(IRRSRC)/COGLES2ParallaxMapRenderer.cpp $(IRRSRC)/COGLES2Renderer2D.cpp $(IRRSRC)/BuiltInFont.cpp \
\
$(IRRBULLET)/boxshape.cpp $(IRRBULLET)/bulletworld.cpp $(IRRBULLET)/bvhtrianglemeshshape.cpp $(IRRBULLET)/collisioncallbackinformation.cpp $(IRRBULLET)/collisionobject.cpp \
$(IRRBULLET)/collisionobjectaffector.cpp $(IRRBULLET)/collisionobjectaffectorattract.cpp $(IRRBULLET)/collisionobjectaffectordelete.cpp $(IRRBULLET)/collisionshape.cpp $(IRRBULLET)/convexhullshape.cpp \
$(IRRBULLET)/gimpactmeshshape.cpp $(IRRBULLET)/irrbullet.cpp $(IRRBULLET)/irrbulletcommon.cpp $(IRRBULLET)/liquidbody.cpp $(IRRBULLET)/motionstate.cpp \
$(IRRBULLET)/physicsdebug.cpp $(IRRBULLET)/raycastvehicle.cpp $(IRRBULLET)/rigidbody.cpp $(IRRBULLET)/softbody.cpp $(IRRBULLET)/sphereshape.cpp \
$(IRRBULLET)/trianglemeshshape.cpp \
\
$(APP)/App.cpp $(APP)/GUI/MainMenu.cpp $(APP)/GUI/PhysicsHelloMenu.cpp \
$(APP)/Component/EventControlComponent.cpp

LOCAL_STATIC_LIBRARIES := bullet

#Need match _IRR_COMPILE_WITH_OGLES2_ of IrrCompileConfig.h
LOCAL_LDLIBS := -lGLESv1_CM -lGLESv2 -ldl -llog -lz

include $(BUILD_SHARED_LIBRARY)
