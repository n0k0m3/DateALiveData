local t = 
{
	version = 1,
	components = 
	{
		
		{
			controlID = "Panel-unlockGoods_Layer1_dating_Game",
			UUID = "00c52871_1992_4d58_8bbc_7880febe94fb",
			anchorPoint = "False",
			anchorPointX = "0",
			anchorPointY = "0",
			backGroundScale9Enable = "False",
			bgColorOpacity = "50",
			bIsOpenClipping = "False",
			classname = "MEPanel",
			colorType = "0;SingleColor:#FFE6E6E6;GraduallyChangingColorStart:#FFFFFFFF;GraduallyChangingColorEnd:#FFFFFFFF;vectorX:0;vectorY:0",
			DesignHeight = "640",
			DesignType = "0",
			DesignWidth = "960",
			dstBlendFunc = "771",
			height = "640",
			ignoreSize = "False",
			name = "Panel",
			PanelRelativeSizeModel = 
			{
				PanelRelativeEnable = true,
			},
			sizepercentx = "0",
			sizepercenty = "0",
			sizeType = "0",
			srcBlendFunc = "1",
			touchAble = "False",
			UILayoutViewModel = 
			{
				nType = 3,
			},
			uipanelviewmodel = 
			{
				Layout="Relative",
				nType = "3"
			},
			width = "1386",
			ZOrder = "1",
			components = 
			{
				
				{
					controlID = "Image_bg_Panel-unlockGoods_Layer1_dating_Game",
					UUID = "f6c9cec4_75ae_4b65_8c32_e299b1319fb1",
					anchorPoint = "False",
					anchorPointX = "0.5",
					anchorPointY = "0.5",
					backGroundScale9Enable = "False",
					classname = "MEImage",
					dstBlendFunc = "771",
					height = "640",
					ignoreSize = "False",
					name = "Image_bg",
					sizepercentx = "100",
					sizepercenty = "100",
					sizeType = "1",
					srcBlendFunc = "1",
					texturePath = "ui/271.png",
					touchAble = "False",
					UILayoutViewModel = 
					{
						PositionX = 693,
						PositionY = 320,
						relativeToName = "Panel",
						nType = 3,
						nGravity = 6,
						nAlign = 5
					},
					width = "1386",
					ZOrder = "1",
				},
				{
					controlID = "Panel_base_Panel-unlockGoods_Layer1_dating_Game",
					UUID = "7dd57249_dd8f_4436_94b9_37e394d0259a",
					anchorPoint = "False",
					anchorPointX = "0",
					anchorPointY = "0",
					backGroundScale9Enable = "False",
					bgColorOpacity = "50",
					bIsOpenClipping = "False",
					classname = "MEPanel",
					colorType = "0;SingleColor:#FFE6E6E6;GraduallyChangingColorStart:#FFFFFFFF;GraduallyChangingColorEnd:#FFFFFFFF;vectorX:0;vectorY:0",
					DesignHeight = "640",
					DesignType = "0",
					DesignWidth = "960",
					dstBlendFunc = "771",
					height = "640",
					ignoreSize = "False",
					name = "Panel_base",
					sizepercentx = "0",
					sizepercenty = "0",
					sizeType = "0",
					srcBlendFunc = "1",
					touchAble = "False",
					UILayoutViewModel = 
					{
						PositionX = 125,
						relativeToName = "Panel",
						nType = 3,
						nGravity = 6,
						nAlign = 5
					},
					uipanelviewmodel = 
					{
						Layout="Absolute",
						nType = "0"
					},
					width = "1136",
					ZOrder = "1",
					components = 
					{
						
						{
							controlID = "Spine_unlockGoodsBg_Panel_base_Panel-unlockGoods_Layer1_dating_Game",
							UUID = "36c00f28_c5a4_41fe_891b_bf4713077582",
							classname = "MESpine",
							dstBlendFunc = "771",
							name = "Spine_unlockGoodsBg",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							spineModel = 
							{
								SpinePath = "effect/dating/ui_dating_unlock/ui_dating_unlock",
								animationName = "ui_dating_unlock1",
								IsLoop = false,
								IsPlay = true,
								IsUseQueue = false,
								AnimationQueue = 
								{
									
								},
							},
							srcBlendFunc = "1",
							touchAble = "False",
							UILayoutViewModel = 
							{
								PositionX = 568,
								PositionY = 320,
							},
							ZOrder = "1",
						},
						{
							controlID = "Image_icon_Panel_base_Panel-unlockGoods_Layer1_dating_Game",
							UUID = "05976f2a_3b4e_4015_9817_bbc36eed0083",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							backGroundScale9Enable = "False",
							classname = "MEImage",
							dstBlendFunc = "771",
							height = "64",
							ignoreSize = "True",
							name = "Image_icon",
							scaleX = "0.95",
							scaleY = "0.95",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "770",
							texturePath = "icon/cg/001.png",
							touchAble = "False",
							UILayoutViewModel = 
							{
								PositionX = 572,
								PositionY = 319,
								IsPercent = true,
								PercentX = 50.38,
								PercentY = 49.9,
							},
							width = "64",
							ZOrder = "1",
						},
						{
							controlID = "Spine_unlockGoodsStar_Panel_base_Panel-unlockGoods_Layer1_dating_Game",
							UUID = "42caa489_c527_4bf2_88bc_79171933b29f",
							classname = "MESpine",
							dstBlendFunc = "771",
							name = "Spine_unlockGoodsStar",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							spineModel = 
							{
								SpinePath = "effect/dating/ui_dating_unlock/ui_dating_unlock",
								animationName = "ui_dating_unlock2",
								IsLoop = true,
								IsPlay = true,
								IsUseQueue = false,
								AnimationQueue = 
								{
									
								},
							},
							srcBlendFunc = "1",
							touchAble = "False",
							UILayoutViewModel = 
							{
								PositionX = 568,
								PositionY = 320,
							},
							ZOrder = "1",
						},
						{
							controlID = "Spine_unlockGoodsBottom_Panel_base_Panel-unlockGoods_Layer1_dating_Game",
							UUID = "07e3db2b_ae16_470b_b6ca_db622f10f7e2",
							classname = "MESpine",
							dstBlendFunc = "771",
							name = "Spine_unlockGoodsBottom",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							spineModel = 
							{
								SpinePath = "effect/dating/ui_dating_unlock/ui_dating_unlock",
								animationName = "ui_dating_unlock3",
								IsLoop = true,
								IsPlay = true,
								IsUseQueue = false,
								AnimationQueue = 
								{
									
								},
							},
							srcBlendFunc = "1",
							touchAble = "False",
							UILayoutViewModel = 
							{
								PositionX = 568,
								PositionY = 320,
							},
							ZOrder = "1",
						},
						{
							controlID = "Image_unlockCgTitle_Panel_base_Panel-unlockGoods_Layer1_dating_Game",
							UUID = "5eea658b_42a9_409c_b422_982e0be3156e",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							backGroundScale9Enable = "False",
							classname = "MEImage",
							dstBlendFunc = "771",
							height = "54",
							ignoreSize = "True",
							name = "Image_unlockCgTitle",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							texturePath = "ui/dating/unLock/001.png",
							touchAble = "False",
							UILayoutViewModel = 
							{
								PositionX = 568,
								PositionY = 64,
								IsPercent = true,
								PercentX = 50,
								PercentY = 10,
							},
							width = "178",
							ZOrder = "1",
						},
						{
							controlID = "Image_unlockDressTitle_Panel_base_Panel-unlockGoods_Layer1_dating_Game",
							UUID = "0c8b1355_1158_418a_bcd1_2d4483be5af3",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							backGroundScale9Enable = "False",
							classname = "MEImage",
							dstBlendFunc = "771",
							height = "54",
							ignoreSize = "True",
							name = "Image_unlockDressTitle",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							texturePath = "ui/dating/unLock/2.png",
							touchAble = "False",
							UILayoutViewModel = 
							{
								PositionX = 568,
								PositionY = 64,
								IsPercent = true,
								PercentX = 50,
								PercentY = 10,
							},
							width = "204",
							ZOrder = "1",
						},
					},
				},
			},
		},
	},
	actions = 
	{
		
	},
	respaths = 
	{
		textures = 
		{
			"ui/271.png",
			"icon/cg/001.png",
			"ui/dating/unLock/001.png",
			"ui/dating/unLock/2.png",
		},
		armatures = 
		{
			
		},
		movieclips = 
		{
			
		},
	},
}
return t

