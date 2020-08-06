--
-- Author: MiYu
-- Date: 2014-02-13 14:47:31
--

TFLayer 			    = TFPanel
TFScene 			    = Scene
TFSprite 			    = Sprite
TFFollow 			    = Follow
TFCellScrollView 	    = TFTree
TFScrollViewCell 	    = TFTreeCell
TFMessageBox            = CCMessageBox
TFRenderTexture 	    = CCRenderTexture
TFLuaTime 			    = TFTime
rawset(TFTime, 'e', TFTime.endToLua)
rawset(TFTime, 'b', TFTime.begin)
TFMotionStreak 		    = CCMotionStreak
CCArmatureDataManager   = TFArmatureDataManager

ccBlendFunc 			= BlendFunc
CCScene 				= Scene

rawset(CCNode, "unregisterScriptHandler", function() end)