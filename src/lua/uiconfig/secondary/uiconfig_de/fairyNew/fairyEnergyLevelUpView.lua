local t = 
{
	version = 1,
	components = 
	{
		
		{
			controlID = "Panel-fairyEnergyLevelUpView_Layer1_fairyNew_Game",
			UUID = "57b02e7a_7d6d_4d2e_ba98_48ccecfffdfc",
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
					controlID = "Panel_base_Panel-fairyEnergyLevelUpView_Layer1_fairyNew_Game",
					UUID = "a42744ce_5204_45a1_8a9f_7a85d0056a1c",
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
							controlID = "background_Panel_base_Panel-fairyEnergyLevelUpView_Layer1_fairyNew_Game",
							UUID = "46eafb1a_366e_4c79_a911_7e123ab44fd2",
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
							controlID = "Panel_back_Panel_base_Panel-fairyEnergyLevelUpView_Layer1_fairyNew_Game",
							UUID = "31ab5921_079a_4e6e_a521_0a975e91e15c",
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
							components = 
							{
								
								{
									controlID = "old_lv_Panel_back_Panel_base_Panel-fairyEnergyLevelUpView_Layer1_fairyNew_Game",
									UUID = "98923492_aec1_44eb_be35_e700951a5cf3",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									classname = "MELabel",
									compPath = "luacomponents.common.MEIconLabel",
									dstBlendFunc = "771",
									FontColor = "#FFF9DB47",
									fontName = "font/MFLiHei_Noncommercial.ttf",
									fontShadow = 
									{
										IsShadow = false,
										ShadowColor = "#FFFFFFFF",
										ShadowAlpha = 255,
										OffsetX = 0,
										OffsetY = 0,
									},
									fontSize = "44",
									fontStroke = 
									{
										IsStroke = false,
										StrokeColor = "#FFE6E6E6",
										StrokeSize = 1,
									},
									height = "55",
									ignoreSize = "True",
									name = "old_lv",
									nTextAlign = "1",
									nTextHAlign = "1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "16",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionX = 406,
										PositionY = 400,
									},
									width = "60",
									ZOrder = "1",
								},
								{
									controlID = "cur_lv_Panel_back_Panel_base_Panel-fairyEnergyLevelUpView_Layer1_fairyNew_Game",
									UUID = "0a18f9c2_6e2e_45f9_bd15_38547e45ee43",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									classname = "MELabel",
									compPath = "luacomponents.common.MEIconLabel",
									dstBlendFunc = "771",
									FontColor = "#FFF9DB47",
									fontName = "font/MFLiHei_Noncommercial.ttf",
									fontShadow = 
									{
										IsShadow = false,
										ShadowColor = "#FFFFFFFF",
										ShadowAlpha = 255,
										OffsetX = 0,
										OffsetY = 0,
									},
									fontSize = "44",
									fontStroke = 
									{
										IsStroke = false,
										StrokeColor = "#FFE6E6E6",
										StrokeSize = 1,
									},
									height = "55",
									ignoreSize = "True",
									name = "cur_lv",
									nTextAlign = "1",
									nTextHAlign = "1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "16",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionX = 713,
										PositionY = 400,
									},
									width = "60",
									ZOrder = "1",
								},
								{
									controlID = "Image_to_Panel_back_Panel_base_Panel-fairyEnergyLevelUpView_Layer1_fairyNew_Game",
									UUID = "b41304ba_7f7e_47d8_b495_cc6b2baa15be",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "24",
									ignoreSize = "True",
									name = "Image_to",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/fairy_up/row.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = 568,
										PositionY = 406,
									},
									width = "40",
									ZOrder = "1",
								},
								{
									controlID = "Image_res_bg_Panel_back_Panel_base_Panel-fairyEnergyLevelUpView_Layer1_fairyNew_Game",
									UUID = "d0274f86_3a8a_44a4_869b_dc111e51dd20",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "72",
									ignoreSize = "True",
									name = "Image_res_bg",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/fairy/new_ui/energy/ui_032.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = 568,
										PositionY = 265,
										IsPercent = true,
										PercentX = 50,
										PercentY = 41.34,
									},
									width = "374",
									ZOrder = "1",
								},
								{
									controlID = "Label_title_Panel_back_Panel_base_Panel-fairyEnergyLevelUpView_Layer1_fairyNew_Game",
									UUID = "4677ed23_bf10_4d11_b335_f31ee31842be",
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
									name = "Label_title",
									nTextAlign = "1",
									nTextHAlign = "1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "Erhalte Mana",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionX = 568,
										PositionY = 286,
									},
									width = "90",
									ZOrder = "1",
								},
								{
									controlID = "Image_res_icon_Panel_back_Panel_base_Panel-fairyEnergyLevelUpView_Layer1_fairyNew_Game",
									UUID = "49723f9e_f060_40d7_8696_7bb5a9907d70",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "100",
									ignoreSize = "True",
									name = "Image_res_icon",
									scaleX = "0.45",
									scaleY = "0.45",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/fairy/new_ui/energy/ICON_linglidian.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = 525,
										PositionY = 250,
									},
									width = "100",
									ZOrder = "1",
								},
								{
									controlID = "label_get_num_Panel_back_Panel_base_Panel-fairyEnergyLevelUpView_Layer1_fairyNew_Game",
									UUID = "a59340bc_6151_4c2f_b7f9_ede7b3668e95",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									classname = "MELabel",
									compPath = "luacomponents.common.MEIconLabel",
									dstBlendFunc = "771",
									FontColor = "#FFF9DB47",
									fontName = "font/MFLiHei_Noncommercial.ttf",
									fontShadow = 
									{
										IsShadow = false,
										ShadowColor = "#FFFFFFFF",
										ShadowAlpha = 255,
										OffsetX = 0,
										OffsetY = 0,
									},
									fontSize = "20",
									fontStroke = 
									{
										IsStroke = false,
										StrokeColor = "#FFE6E6E6",
										StrokeSize = 1,
									},
									height = "25",
									ignoreSize = "True",
									name = "label_get_num",
									nTextAlign = "1",
									nTextHAlign = "1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "x34",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionX = 576,
										PositionY = 247,
									},
									width = "54",
									ZOrder = "1",
								},
								{
									controlID = "Spine_level_up_Panel_back_Panel_base_Panel-fairyEnergyLevelUpView_Layer1_fairyNew_Game",
									UUID = "d0c99793_54cb_4480_9239_6b3c2a32e0c7",
									classname = "MESpine",
									dstBlendFunc = "771",
									name = "Spine_level_up",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									spineModel = 
									{
										SpinePath = "effect/effect_heroGrow_ui2/effect_heroGrow_ui2",
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
							},
						},
						{
							controlID = "Label_tips_Panel_base_Panel-fairyEnergyLevelUpView_Layer1_fairyNew_Game",
							UUID = "5fa2eb9d_1c77_45fe_82de_e40cd87ca3f3",
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
							text = "Zum Schließen tippen",
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
			"ui/fairy_up/row.png",
			"ui/fairy/new_ui/energy/ui_032.png",
			"ui/fairy/new_ui/energy/ICON_linglidian.png",
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

