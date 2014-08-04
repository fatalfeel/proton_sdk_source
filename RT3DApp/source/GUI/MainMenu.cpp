#include "PlatformPrecomp.h"
#include "Irrlicht/IrrlichtManager.h"
using namespace irr;
using namespace scene;
using namespace io;

#include "App.h"
#include "MainMenu.h"
#include "Mesh3DMenu.h"

#include "TerrainMenu.h"
#include "QuakeMenu.h"
#include "QuakeShaderMenu.h"
#include "HouseMenu.h"
#include "ShaderMenu.h"
#include "StencilMenu.h"

/*void MainMenuOnSelect(VariantList *pVList) //0=vec2 point of click, 1=entity sent from
{
	Entity *pEntClicked = pVList->m_variant[1].GetEntity();

	LogMsg("Clicked %s entity at %s", pEntClicked->GetName().c_str(),pVList->m_variant[1].Print().c_str());


	if (pEntClicked->GetName() == "Debug")
	{
		//overlay the debug menu over this one
		pEntClicked->GetParent()->RemoveComponentByName("FocusInput");
		DebugMenuCreate(pEntClicked->GetParent());
	}

	if (pEntClicked->GetName() == "Mesh3D")
	{
		SlideScreen(pEntClicked->GetParent(), false);
		MessageManager::GetMessageManager()->CallEntityFunction(pEntClicked->GetParent(), 500, "OnDelete", NULL);
		Mesh3DMenuCreate(pEntClicked->GetParent()->GetParent());
	}

	if (pEntClicked->GetName() == "Terrain")
	{
		SlideScreen(pEntClicked->GetParent(), false);
		MessageManager::GetMessageManager()->CallEntityFunction(pEntClicked->GetParent(), 500, "OnDelete", NULL);
		TerrainMenuCreate(pEntClicked->GetParent()->GetParent());
	}

	if (pEntClicked->GetName() == "Map")
	{
		SlideScreen(pEntClicked->GetParent(), false);
		MessageManager::GetMessageManager()->CallEntityFunction(pEntClicked->GetParent(), 500, "OnDelete", NULL);
		MapMenuCreate(pEntClicked->GetParent()->GetParent());

	}

	if (pEntClicked->GetName() == "Map3")
	{
		SlideScreen(pEntClicked->GetParent(), false);
		MessageManager::GetMessageManager()->CallEntityFunction(pEntClicked->GetParent(), 500, "OnDelete", NULL);
		Map3MenuCreate(pEntClicked->GetParent()->GetParent());
	
	}

	Entity::GetEntityManager()->PrintTreeAsText(); //useful for debugging
}*/

/*Entity * MainMenuCreate(Entity *pParentEnt)
{
	Entity *pBG = CreateOverlayEntity(pParentEnt, "MainMenu", "interface/summary_bg.rttex", 0,0);
	EntitySetScaleBySize(pBG, GetScreenSize());
	AddFocusIfNeeded(pBG);
	
	Entity *pButtonEntity;
	float x = 50;
	float y = 40;
	float ySpacer = 45;
	
	pButtonEntity = CreateTextButtonEntity(pBG, "Debug", x, y, "Debug Options"); y += ySpacer;
	pButtonEntity->GetShared()->GetFunction("OnButtonSelected")->m_sig_function.connect(&MainMenuOnSelect);
	//pButtonEntity->GetVar("alignment")->Set(uint32(ALIGNMENT_CENTER));

	pButtonEntity = CreateTextButtonEntity(pBG, "Mesh3D", x, y, "3D Animated Mesh"); y += ySpacer;
	pButtonEntity->GetShared()->GetFunction("OnButtonSelected")->m_sig_function.connect(&MainMenuOnSelect);
	//pButtonEntity->GetVar("alignment")->Set(uint32(ALIGNMENT_CENTER));
	
	pButtonEntity = CreateTextButtonEntity(pBG, "Terrain", x, y, "3D Terrain"); y += ySpacer;
	pButtonEntity->GetShared()->GetFunction("OnButtonSelected")->m_sig_function.connect(&MainMenuOnSelect);
	//pButtonEntity->GetVar("alignment")->Set(uint32(ALIGNMENT_CENTER));

	pButtonEntity = CreateTextButtonEntity(pBG, "Map", x, y, "Quake style BSP map"); y += ySpacer;
	pButtonEntity->GetShared()->GetFunction("OnButtonSelected")->m_sig_function.connect(&MainMenuOnSelect);

	x = 330;
	y = 40;
	
	pButtonEntity = CreateTextButtonEntity(pBG, "Map3", x, y, "3D Scene"); y += ySpacer;
	pButtonEntity->GetShared()->GetFunction("OnButtonSelected")->m_sig_function.connect(&MainMenuOnSelect);
	
	//for android, so the back key (or escape on windows/OSX) will quit out of the game
	EntityComponent *pComp = pBG->AddComponent(new CustomInputComponent);
	//tell the component which key has to be hit for it to be activated
	pComp->GetFunction("OnActivated")->m_sig_function.connect(1, boost::bind(&App::OnExitApp, GetApp(), _1));
	pComp->GetVar("keycode")->Set(uint32(VIRTUAL_KEY_BACK));



	SlideScreen(pBG, true);

	return pBG;
}*/

//by stone
enum EnMenuSelect
{
    ANIMESH,
    TERRAIN,
    QUAKE,
    QUAKESHADER,
    HOUSESCENE,
    HIGHSHADER,
	STENCIL
};

Entity* MainMenuCreate(Entity* pParentEnt)
{
    Entity* pBG;
	EnMenuSelect menuid = STENCIL;
    
    switch(menuid)
    {
        case ANIMESH:
            pBG = Mesh3DMenuCreate(pParentEnt);
            break;
        
        case TERRAIN:
            pBG = TerrainMenuCreate(pParentEnt);
            break;
            
        case QUAKE:
            pBG = QuakeMenuCreate(pParentEnt);
            break;
            
        case QUAKESHADER:
            pBG = QuakeShaderMenuCreate(pParentEnt);
            break;
            
        case HOUSESCENE:
            pBG = HouseMenuCreate(pParentEnt);
            break;
            
        case HIGHSHADER:
            pBG = ShaderMenuCreate(pParentEnt);
            break;

		case STENCIL:
            pBG = StencilMenuCreate(pParentEnt);
            break;
    }

	return pBG;
}