local t = 
{
	version = 1,
	components = 
	{
		
		{
			controlID = "Panel-fairyHeroEnergyUnlockView_Layer1_fairyNew_Game",
			UUID = "de5afafe_6581_4917_91d2_53ce3e2e27d3",
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
			width = "1136",
			ZOrder = "1",
			components = 
			{
				
				{
					controlID = "Panel_base_Panel-fairyHeroEnergyUnlockView_Layer1_fairyNew_Game",
					UUID = "535304dc_b38c_4c42_ac81_ec9358c0fe63",
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
							controlID = "background_Panel_base_Panel-fairyHeroEnergyUnlockView_Layer1_fairyNew_Game",
							UUID = "f2ed4c0c_d61b_4f10_ad2b_5477fbd26f28",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							backGroundScale9Enable = "False",
							classname = "MEImage",
							dstBlendFunc = "771",
							height = "310",
							ignoreSize = "True",
							name = "background",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							texturePath = "ui/fairy_up/bg.png",
							touchAble = "True",
							UILayoutViewModel = 
							{
								PositionX = 568,
								PositionY = 321,
								IsPercent = true,
								PercentX = 50,
								PercentY = 50.16,
								LeftPositon = -181,
								TopPosition = 140,
								relativeToName = "Panel",
							},
							width = "1082",
							ZOrder = "1",
						},
						{
							controlID = "Panel_back_Panel_base_Panel-fairyHeroEnergyUnlockView_Layer1_fairyNew_Game",
							UUID = "0c05420a_7703_46d3_ab50_6d47ff9f7343",
							anchorPoint = "False",
							anchorPointX = "0",
							anchorPointY = "0",
							backGroundScale9Enable = "False",
							bgColorOpacity = "50",
							bIsOpenClipping = "False",
							classname = "MEPanel",
							colorType = "0;SingleColor:#FF000000;GraduallyChangingColorStart:#FFFFFFFF;GraduallyChangingColorEnd:#FFFFFFFF;vectorX:0;vectorY:0",
							DesignHeight = "640",
							DesignType = "0",
							DesignWidth = "960",
							dstBlendFunc = "771",
							height = "640",
							ignoreSize = "False",
							name = "Panel_back",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							touchAble = "False",
							UILayoutViewModel = 
							{
								PositionX = -2,
							},
							uipanelviewmodel = 
							{
								Layout="Absolute",
								nType = "0"
							},
							width = "1136",
							ZOrder = "1",
						},
						{
							controlID = "Spine_sprit_unlock_Panel_base_Panel-fairyHeroEnergyUnlockView_Layer1_fairyNew_Game",
							UUID = "e0caefc0_5302_46f7_98d1_6a7b0d3d33b4",
							classname = "MESpine",
							dstBlendFunc = "771",
							name = "Spine_sprit_unlock",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							spineModel = 
							{
								SpinePath = "effect/effect_heroGrow_ui27/effect_heroGrow_ui27",
								animationName = "ALL",
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
								PositionY = 519,
							},
							ZOrder = "1",
						},
						{
							controlID = "Label_tips_Panel_base_Panel-fairyHeroEnergyUnlockView_Layer1_fairyNew_Game",
							UUID = "e0e45161_1063_4d1e_8d01_99065ae82b50",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							classname = "MELabel",
							compPath = "luacomponents.common.MEIconLabel",
							dstBlendFunc = "771",
							FontColor = "#FFFFFFFF",
							fontName = "font/fangzheng_zhunyuan.ttf",
							fontShadow = 
							{
								IsShadow = false,
								ShadowColor = "#FFFFFFFF",
								ShadowAlpha = 255,
								OffsetX = 0,
								OffsetY = 0,
							},
							fontSize = "24",
							fontStroke = 
							{
								IsStroke = false,
								StrokeColor = "#FFE6E6E6",
								StrokeSize = 1,
							},
							height = "27",
							ignoreSize = "True",
							name = "Label_tips",
							nTextAlign = "1",
							nTextHAlign = "1",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "770",
							text = "任意处关闭",
							touchAble = "False",
							touchScaleEnable = "False",
							UILayoutViewModel = 
							{
								PositionX = 568,
								PositionY = 107,
								IsPercent = true,
								PercentX = 50,
								PercentY = 16.72,
							},
							width = "123",
							ZOrder = "1",
						},
						{
							controlID = "ScrollView_hero_Panel_base_Panel-fairyHeroEnergyUnlockView_Layer1_fairyNew_Game",
							UUID = "7d24031e_9b26_4c0d_aa4e_ff1e3b13489f",
							anchorPoint = "False",
							anchorPointX = "0",
							anchorPointY = "0",
							backGroundScale9Enable = "False",
							bgColorOpacity = "50",
							bIsOpenClipping = "True",
							bounceEnable = "True",
							classname = "MEScrollView",
							colorType = "0;SingleColor:#FFE6E6E6;GraduallyChangingColorStart:#FFFFFFFF;GraduallyChangingColorEnd:#FFFFFFFF;vectorX:0;vectorY:0",
							direction = "2",
							dstBlendFunc = "771",
							height = "200",
							ignoreSize = "False",
							innerHeight = "200",
							innerWidth = "1020",
							name = "ScrollView_hero",
							showScrollbar = "False",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							touchAble = "True",
							UILayoutViewModel = 
							{
								PositionX = 50,
								PositionY = 220,
							},
							uipanelviewmodel = 
							{
								Layout="Absolute",
								nType = "0"
							},
							width = "1020",
							ZOrder = "1",
						},
						{
							controlID = "Image_tips_bg_Panel_base_Panel-fairyHeroEnergyUnlockView_Layer1_fairyNew_Game",
							UUID = "4087b2aa_8c4e_454e_ad20_c5436f5c276b",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							backGroundScale9Enable = "True;capInsetsX:0;capInsetsY:0;capInsetsWidth:0;capInsetsHeight:0",
							classname = "MEImage",
							dstBlendFunc = "771",
							height = "40",
							ignoreSize = "False",
							name = "Image_tips_bg",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							texturePath = "ui/fairy/new_ui/energy/ui_004.png",
							touchAble = "False",
							UILayoutViewModel = 
							{
								PositionX = 584,
								PositionY = 436,
							},
							width = "340",
							ZOrder = "1",
						},
						{
							controlID = "label_title_Panel_base_Panel-fairyHeroEnergyUnlockView_Layer1_fairyNew_Game",
							UUID = "4e73971e_ca88_4528_9f6f_d16192f8c236",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							classname = "MELabel",
							compPath = "luacomponents.common.MEIconLabel",
							dstBlendFunc = "771",
							FontColor = "#FFFFFFFF",
							fontName = "font/fangzheng_zhunyuan.ttf",
							fontShadow = 
							{
								IsShadow = false,
								ShadowColor = "#FFFFFFFF",
								ShadowAlpha = 255,
								OffsetX = 0,
								OffsetY = 0,
							},
							fontSize = "22",
							fontStroke = 
							{
								IsStroke = false,
								StrokeColor = "#FFE6E6E6",
								StrokeSize = 1,
							},
							height = "25",
							ignoreSize = "True",
							name = "label_title",
							nTextAlign = "1",
							nTextHAlign = "1",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "770",
							text = "以下精灵灵力聚合已解锁",
							touchAble = "False",
							touchScaleEnable = "False",
							UILayoutViewModel = 
							{
								PositionX = 583,
								PositionY = 435,
							},
							width = "245",
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
			"ui/fairy_up/bg.png",
			"ui/fairy/new_ui/energy/ui_004.png",
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

