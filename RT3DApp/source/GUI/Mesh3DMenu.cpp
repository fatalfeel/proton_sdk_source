#include "PlatformPrecomp.h"
#include "Mesh3DMenu.h"
//#include "Entity/EntityUtils.h"
#include "MainMenu.h"
#include "Irrlicht/IrrlichtManager.h"
#include "driverChoice.h"
#include "Component/EventControlComponent.h"
#include "FileSystem/FileSystemZip.h"

using namespace irr;
using namespace core;
using namespace scene;
using namespace video;

/*void Mesh3DMenuOnSelect(VariantList *pVList) //0=vec2 point of click, 1=entity sent from
{
	Entity *pEntClicked = pVList->m_variant[1].GetEntity();

	LogMsg("Clicked %s entity at %s", pEntClicked->GetName().c_str(),pVList->m_variant[1].Print().c_str());

	if (pEntClicked->GetName() == "Back")
	{
		//SlideScreen(pEntClicked->GetParent(), false);
		MessageManager::GetMessageManager()->CallEntityFunction(pEntClicked->GetParent(), 500, "OnDelete", NULL);
		MainMenuCreate(pEntClicked->GetParent()->GetParent());

		IrrlichtManager::GetIrrlichtManager()->ClearScene();
	}

	Entity::GetEntityManager()->PrintTreeAsText(); //useful for debugging
}*/

void Mesh3DInitScene()
{
	IAnimatedMesh*				mesh;
	IAnimatedMeshSceneNode*     node;
	scene::ISceneNodeAnimator*  anim;
	scene::ISceneManager*		smgr   = IrrlichtManager::GetIrrlichtManager()->GetScene();
	IrrlichtDevice*				device = IrrlichtManager::GetIrrlichtManager()->GetDevice();
	video::IVideoDriver*		driver = IrrlichtManager::GetIrrlichtManager()->GetDriver();
	
	std::string					load_zip;
	std::string					load_data;
	std::string					reload_path;
	FileSystemZip*				pfilesystem			= NULL;
	io::IReadFile*				memfile				= NULL;
	byte*						apk_buffer			= NULL;
	byte*						buff_extract		= NULL;
	int							size				= 0;
	int							apk_size			= 0;

	if (!IrrlichtManager::GetIrrlichtManager()->GetDevice())
	{
		LogError("Error initializing Irrlicht");
		return;
	}
	
	IrrlichtManager::GetIrrlichtManager()->GetDevice()->getTimer()->setTime(0);
		
    device->getSceneManager()->addLightSceneNode(0, vector3df(-5,5,0), SColorf(1.0f,1.0f,1.0f), 1000.0f);
	device->getSceneManager()->addLightSceneNode(0, vector3df(5,5,0), SColorf(1.0f,1.0f,1.0f), 1000.0f);
	    
    //mesh = smgr->getMesh( (GetBaseAppPath() + "game/sydney.md2").c_str());
    //mesh = smgr->getMesh( (GetBaseAppPath() + "game/dwarf.x").c_str());
    /*mesh = smgr->getMesh( (GetBaseAppPath() + "game/squirrel.x").c_str());
	node = smgr->addAnimatedMeshSceneNode( mesh );
	node->setMaterialTexture(0, driver->getTexture((GetBaseAppPath()+"game/squirrel_skin.png").c_str()));
	node->setMaterialFlag(EMF_LIGHTING, true);
    
	anim = smgr->createRotationAnimator(core::vector3df(0,0.3f,0));
    node->addAnimator(anim);
    anim->drop();*/

		
//////////////////////////////mesh/////////////////////////////////////////////////
	load_zip	= (GetBaseAppPath() + "game/squirrel.zip").c_str();
	load_data	= "squirrel.x";
	reload_path	= (GetBaseAppPath() + "game/squirrel.x").c_str();
	
#ifdef ANDROID_NDK
	apk_buffer	= FileManager::GetFileManager()->Get(load_zip.c_str(), &apk_size, false, false);
	pfilesystem	= new FileSystemZip();
	pfilesystem->Init_unzMemory(apk_buffer, apk_size);
	buff_extract = pfilesystem->Get_unz(load_data, &size);
#else
	pfilesystem = new FileSystemZip();
	pfilesystem->Init_unz(load_zip.c_str());
	buff_extract = pfilesystem->Get_unz(load_data.c_str(), &size);

#endif
	
	memfile = device->getFileSystem()->createMemoryReadFile(buff_extract, size, reload_path.c_str(), true);
	mesh	= smgr->getMesh( memfile );
	node	= smgr->addAnimatedMeshSceneNode( mesh );
	
	if( apk_buffer )
	{
		delete apk_buffer;
		apk_buffer = NULL;
	}

	if( buff_extract )
	{
		delete buff_extract;
		buff_extract = NULL;
	}
					
	if( pfilesystem )
	{
		delete pfilesystem;
		pfilesystem = NULL;
	}

//////////////////////////////texture/////////////////////////////////////////////////
	load_zip	= (GetBaseAppPath() + "game/squirrel_skin.zip").c_str();
	load_data	= "squirrel_skin.jpg";
	reload_path	= (GetBaseAppPath() + "game/squirrel_skin.jpg").c_str();
	
#ifdef ANDROID_NDK
	apk_buffer	= FileManager::GetFileManager()->Get(load_zip.c_str(), &apk_size, false, false);
	pfilesystem	= new FileSystemZip();
	pfilesystem->Init_unzMemory(apk_buffer, apk_size);
	buff_extract = pfilesystem->Get_unz(load_data, &size);
#else
	pfilesystem = new FileSystemZip();
	pfilesystem->Init_unz(load_zip.c_str());
	buff_extract = pfilesystem->Get_unz(load_data.c_str(), &size);
#endif
		
	memfile = device->getFileSystem()->createMemoryReadFile(buff_extract, size, reload_path.c_str(), true);
	node->setMaterialTexture( 0, IrrlichtManager::GetIrrlichtManager()->GetDriver()->getTexture( memfile ));
    node->setMaterialFlag(EMF_LIGHTING, true);
    anim = smgr->createRotationAnimator(core::vector3df(0,0.3f,0));
    node->addAnimator(anim);
    anim->drop();

	if( apk_buffer )
	{
		delete apk_buffer;
		apk_buffer = NULL;
	}

	if( buff_extract )
	{
		delete buff_extract;
		buff_extract = NULL;
	}
		
	if( pfilesystem )
	{
		delete pfilesystem;
		pfilesystem = NULL;
	}

//////////////////////////////////cam/////////////////////////////////////////////    
   	ICameraSceneNode* camera = smgr->addCameraSceneNodeFPS(0, 100.0f, .02f, 0, 0, 0, true, 1.0f);
	//camera->addCameraSceneNode(0, vector3df(0,2,-10));
	camera->setPosition(core::vector3df(0,2,-10));
	float fov = float(GetPrimaryGLX())/ float(GetPrimaryGLY());
	camera->setAspectRatio(fov);
	camera->setFOV((120 * M_PI / 360.0f));

#ifdef _IRR_COMPILE_WITH_GUI_
	EventControlComponent* receiver = new EventControlComponent();
    receiver->AddGuiButton();
	device->setEventReceiver(receiver);
#endif
}

Entity * Mesh3DMenuCreate(Entity *pParentEnt)
{
	Entity *pBG = pParentEnt->AddEntity(new Entity("Mesh3DMenu"));

	//AddFocusIfNeeded(pBG);
	
	/*Entity *pButtonEntity;
	pButtonEntity = CreateTextButtonEntity(pBG, "Back", iPhoneMapX(240),iPhoneMapY(290), "Back"); 

	pButtonEntity->GetShared()->GetFunction("OnButtonSelected")->m_sig_function.connect(&Mesh3DMenuOnSelect);
	pButtonEntity->GetVar("alignment")->Set(uint32(ALIGNMENT_CENTER));

	SlideScreen(pBG, true);*/
	
	Mesh3DInitScene();
	return pBG;
}

//by stone test bug
/*Entity* MainMenuCreate(Entity *pParentEnt)
{
    Entity *pBG = Mesh3DMenuCreate(pParentEnt);
    return pBG;
}*/
