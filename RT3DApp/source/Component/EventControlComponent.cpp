#include "PlatformPrecomp.h"
#include "Irrlicht/IrrlichtManager.h"
using namespace irr;
using namespace scene;
using namespace io;

#include "BaseApp.h"
#include "Irrlicht/source/CCameraSceneNode.h"
#include "util/GLESUtils.h"
#include "Entity/EntityUtils.h"
#include "Component/EventControlComponent.h"

#ifdef _IRR_COMPILE_WITH_GUI_

EventControlComponent::EventControlComponent()
{
    m_bTurningNow   = false;
    m_rotateSpeed   = 100.0f;
    m_moveSpeed     = 10.0f;
    m_firstUpdate   = true;
}

EventControlComponent::~EventControlComponent()
{
    BaseApp::GetBaseApp()->m_sig_update.disconnect(boost::bind(&EventControlComponent::OnUpdate, this, _1));
}

void EventControlComponent::SetSpeed(f32 rotateSpeed, f32 moveSpeed)
{
    m_rotateSpeed   = rotateSpeed;
    m_moveSpeed     = moveSpeed;
}

void EventControlComponent::AddGuiButton()
{
	video::IVideoDriver*    driver = IrrlichtManager::GetIrrlichtManager()->GetDriver();
	IrrlichtDevice*         device = IrrlichtManager::GetIrrlichtManager()->GetDevice();
	gui::IGUIEnvironment*   gui    = device->getGUIEnvironment();
	core::dimension2d<u32>  screen = driver->getScreenSize();

#ifdef __APPLE__
    
    gui->addButton(core::rect<int>(85,screen.Height-300,155,screen.Height-250), NULL, GUI_ID_BUTTON_DIR_FORWARD, L"D_Up");
	gui->addButton(core::rect<int>(85,screen.Height-100,155,screen.Height-50),  NULL, GUI_ID_BUTTON_DIR_BACK,    L"D_Dn");
	gui->addButton(core::rect<int>(05,screen.Height-200,75,screen.Height-150), NULL, GUI_ID_BUTTON_DIR_LEFT,    L"D_Lt");
	gui->addButton(core::rect<int>(85,screen.Height-200,155,screen.Height-150), NULL, GUI_ID_BUTTON_DIR_RIGHT,   L"D_Rt");
    
	gui->addButton(core::rect<int>(screen.Width-155,screen.Height-300,screen.Width-85,screen.Height-250), NULL, GUI_ID_BUTTON_ROLL_UP,   L"R_Up");
	gui->addButton(core::rect<int>(screen.Width-155,screen.Height-100,screen.Width-85,screen.Height-50), NULL, GUI_ID_BUTTON_ROLL_DOWN, L"R_Dn");
	gui->addButton(core::rect<int>(screen.Width-155,screen.Height-200,screen.Width-85,screen.Height-150), NULL, GUI_ID_BUTTON_ROLL_LEFT, L"R_Lt");
	gui->addButton(core::rect<int>(screen.Width-75,screen.Height-200,screen.Width-5,screen.Height-150), NULL, GUI_ID_BUTTON_ROLL_RIGHT,L"R_Rt");
#else

    gui->addButton(core::rect<int>(85,screen.Height-350,155,screen.Height-300), NULL, GUI_ID_BUTTON_DIR_FORWARD, L"D_Up");
	gui->addButton(core::rect<int>(85,screen.Height-150,155,screen.Height-100),  NULL, GUI_ID_BUTTON_DIR_BACK,    L"D_Dn");
	gui->addButton(core::rect<int>(05,screen.Height-250,75,screen.Height-200), NULL, GUI_ID_BUTTON_DIR_LEFT,    L"D_Lt");
	gui->addButton(core::rect<int>(165,screen.Height-250,235,screen.Height-200), NULL, GUI_ID_BUTTON_DIR_RIGHT,   L"D_Rt");
    
	gui->addButton(core::rect<int>(screen.Width-155,screen.Height-350,screen.Width-85,screen.Height-300), NULL, GUI_ID_BUTTON_ROLL_UP,   L"R_Up");
	gui->addButton(core::rect<int>(screen.Width-155,screen.Height-150,screen.Width-85,screen.Height-100), NULL, GUI_ID_BUTTON_ROLL_DOWN, L"R_Dn");
	gui->addButton(core::rect<int>(screen.Width-235,screen.Height-250,screen.Width-165,screen.Height-200), NULL, GUI_ID_BUTTON_ROLL_LEFT, L"R_Lt");
	gui->addButton(core::rect<int>(screen.Width-75,screen.Height-250,screen.Width-5,screen.Height-200), NULL, GUI_ID_BUTTON_ROLL_RIGHT,L"R_Rt");
#endif
    
    BaseApp::GetBaseApp()->m_sig_update.connect(1, boost::bind(&EventControlComponent::OnUpdate, this, _1));
}

void EventControlComponent::SendKey(irr::EKEY_CODE key, bool bIsDown)
{
	irr::SEvent ev;

	ev.EventType             = irr::EET_KEY_INPUT_EVENT;
	ev.KeyInput.Char         = 0;
	ev.KeyInput.Key          = key; //irr::KEY_UP;
	ev.KeyInput.Control      = false;
	ev.KeyInput.PressedDown  = bIsDown;
	ev.KeyInput.Shift        = false;
    
	IrrlichtManager::GetIrrlichtManager()->GetDevice()->getInputReceivingSceneManager()->postEventFromUser(ev);
}

bool EventControlComponent::OnEvent(const SEvent& event)
{
    int  id;
        
    m_lastevent = event;
    
    if (event.EventType == EET_GUI_EVENT)
    {
        switch(event.GUIEvent.EventType)
        {
			case gui::EGET_MENU_ITEM_SELECTED:
                // a menu item was clicked
				return true;
                
			case gui::EGET_FILE_SELECTED:
				return true;
                
			case gui::EGET_SCROLL_BAR_CHANGED:
				return true;
                
			case gui::EGET_COMBO_BOX_CHANGED:
				return true;
                
			case gui::EGET_BUTTON_CLICKED:
                
                id  = event.GUIEvent.Caller->getID();
                
                switch(id)
                {
                    case GUI_ID_BUTTON_DIR_FORWARD:
                        if( event.MouseInput.Event == EMIE_LMOUSE_PRESSED_DOWN)
                        {
                            SendKey(irr::KEY_UP, true);
                        }
                        else
                        {
                            SendKey(irr::KEY_UP, false);
                        }
                        return true;
                        
                    case GUI_ID_BUTTON_DIR_BACK:
                        if( event.MouseInput.Event == EMIE_LMOUSE_PRESSED_DOWN)
                        {
                            SendKey(irr::KEY_DOWN, true);
                        }
                        else
                        {
                            SendKey(irr::KEY_DOWN, false);
                        }
                        return true;
                        
                    case GUI_ID_BUTTON_DIR_LEFT:
                        if( event.MouseInput.Event == EMIE_LMOUSE_PRESSED_DOWN)
                        {
                            SendKey(irr::KEY_LEFT, true);
                        }
                        else
                        {
                            SendKey(irr::KEY_LEFT, false);
                        }
                        return true;
                        
                    case GUI_ID_BUTTON_DIR_RIGHT:
                        if( event.MouseInput.Event == EMIE_LMOUSE_PRESSED_DOWN)
                        {
                            SendKey(irr::KEY_RIGHT, true);
                        }
                        else
                        {
                            SendKey(irr::KEY_RIGHT, false);
                        }
                        return true;
                        
                        //////////////////////////////
                    case GUI_ID_BUTTON_ROLL_UP:
                        if( event.MouseInput.Event == EMIE_LMOUSE_PRESSED_DOWN)
                            m_bTurningNow = true;
                        else
                            m_bTurningNow = false;
                        return true;
                        
                    case GUI_ID_BUTTON_ROLL_DOWN:
                        if( event.MouseInput.Event == EMIE_LMOUSE_PRESSED_DOWN)
                            m_bTurningNow = true;
                        else
                            m_bTurningNow = false;
                        return true;
                        
                    case GUI_ID_BUTTON_ROLL_LEFT:
                        if( event.MouseInput.Event == EMIE_LMOUSE_PRESSED_DOWN)
                            m_bTurningNow = true;
                        else
                            m_bTurningNow = false;
                        return true;
                        
                    case GUI_ID_BUTTON_ROLL_RIGHT:
                        if( event.MouseInput.Event == EMIE_LMOUSE_PRESSED_DOWN)
                            m_bTurningNow = true;
                        else
                            m_bTurningNow = false;
                        return true;
                }
				break;
                
			default:
				break;
        }
    }
    
    return false;
}

void EventControlComponent::OnUpdate(VariantList* pVList)
{
    if (m_bTurningNow)
	{
		irr::scene::CCameraSceneNode* camera = (irr::scene::CCameraSceneNode*) IrrlichtManager::GetIrrlichtManager()->GetScene()->getActiveCamera();
		
        core::matrix4   mat;
		core::vector3df pos                 = camera->getPosition();
        core::vector3df target              = (camera->getTarget() - camera->getPosition());
        core::vector3df relativeRotation    = target.getHorizontalAngle();
		int             id					= -1;

		if (m_lastevent.EventType == EET_GUI_EVENT)
		{
			switch(m_lastevent.GUIEvent.EventType)
			{
				case gui::EGET_BUTTON_CLICKED:
					id = m_lastevent.GUIEvent.Caller->getID();
					break;
			}
		}
    
        //update it
		float sensitivityX = 2;
		float sensitivityY = 2;
        
        switch( id )
        {
            case GUI_ID_BUTTON_ROLL_UP:
                relativeRotation.X -= BaseApp::GetBaseApp()->GetGameDelta()*sensitivityY;
                                
                break;
                
            case GUI_ID_BUTTON_ROLL_DOWN:
                relativeRotation.X += BaseApp::GetBaseApp()->GetGameDelta()*sensitivityY;
                               
                break;
                
            case GUI_ID_BUTTON_ROLL_LEFT:
                relativeRotation.Y -= BaseApp::GetBaseApp()->GetGameDelta()*sensitivityX;
                                
                break;
                
            case GUI_ID_BUTTON_ROLL_RIGHT:
                relativeRotation.Y += BaseApp::GetBaseApp()->GetGameDelta()*sensitivityX;
                               
                break;
        }
        
        target.set(0,0, core::max_(1.f, pos.getLength()));
        mat.setRotationDegrees(core::vector3df(relativeRotation.X, relativeRotation.Y, 0));
        mat.transformVect(target);
/////////////////
        // write translation
        camera->setPosition(pos);
        
        // write right target
        target += pos;
        camera->setTarget(target);
  	}
}

#endif
