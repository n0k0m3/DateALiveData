local t = 
{
	version = 1,
	components = 
	{
		
		{
			controlID = "Panel-gongmingLvUpView_Layer1_fairyNew_Game",
			UUID = "fe4ddfbc_498e_47ec_ba7a_fd23c0fe2e56",
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
					controlID = "Panel_base_Panel-gongmingLvUpView_Layer1_fairyNew_Game",
					UUID = "a79e6420_3acc_4981_accb_dabdc0fc834b",
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
						PositionX = -58,
						PositionY = 35,
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
							controlID = "background_Panel_base_Panel-gongmingLvUpView_Layer1_fairyNew_Game",
							UUID = "fc77262e_dd1f_4568_902e_bd4074b976c0",
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
								PositionY = 320,
								IsPercent = true,
								PercentX = 50,
								PercentY = 50,
								LeftPositon = -181,
								TopPosition = 140,
								relativeToName = "Panel",
							},
							width = "1082",
							ZOrder = "1",
						},
						{
							controlID = "Panel_back_Panel_base_Panel-gongmingLvUpView_Layer1_fairyNew_Game",
							UUID = "c3820d8f_1b55_4bc0_a51a_fa49dfd22757",
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
									controlID = "Label_title_Panel_back_Panel_base_Panel-gongmingLvUpView_Layer1_fairyNew_Game",
									UUID = "22e3be7b_943a_4a16_b1a4_d35e532484cc",
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
									text = "灵力聚合等级上限增加",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionX = 568,
										PositionY = 430,
									},
									visible = "False",
									width = "222",
									ZOrder = "1",
								},
								{
									controlID = "old_lv_Panel_back_Panel_base_Panel-gongmingLvUpView_Layer1_fairyNew_Game",
									UUID = "ee1e5fa9_5809_4cd4_bd46_0b532c90328f",
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
									text = "LV 25",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionX = 406,
										PositionY = 368,
									},
									width = "150",
									ZOrder = "1",
								},
								{
									controlID = "cur_lv_Panel_back_Panel_base_Panel-gongmingLvUpView_Layer1_fairyNew_Game",
									UUID = "9b2f339b_962a_45f0_8b25_7c84608d5dd8",
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
									text = "Lv 30",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionX = 713,
										PositionY = 368,
									},
									width = "149",
									ZOrder = "1",
								},
								{
									controlID = "Image_to_Panel_back_Panel_base_Panel-gongmingLvUpView_Layer1_fairyNew_Game",
									UUID = "263ea807_593b_4d2c_afcd_bd1ffebd6645",
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
										PositionY = 374,
									},
									width = "40",
									ZOrder = "1",
								},
								{
									controlID = "Spine_break_up_Panel_back_Panel_base_Panel-gongmingLvUpView_Layer1_fairyNew_Game",
									UUID = "65e2536f_4dae_4f00_b199_f02700bcff1b",
									classname = "MESpine",
									dstBlendFunc = "771",
									name = "Spine_break_up",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									spineModel = 
									{
										SpinePath = "effect/effect_heroGrow_ui2/effect_heroGrow_ui2",
										animationName = "ALL",
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
										PositionY = 519,
									},
									ZOrder = "1",
								},
								{
									controlID = "Image_to2_Panel_back_Panel_base_Panel-gongmingLvUpView_Layer1_fairyNew_Game",
									UUID = "4f23a2c3_d9c7_47bc_9f07_34f6bf60fde5",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "24",
									ignoreSize = "True",
									name = "Image_to2",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/fairy_up/row.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = 568,
										PositionY = 268,
									},
									width = "40",
									ZOrder = "1",
								},
								{
									controlID = "old_desc_Panel_back_Panel_base_Panel-gongmingLvUpView_Layer1_fairyNew_Game",
									UUID = "8b039318_306c_4ea4_b50c_cc5a426f9853",
									anchorPoint = "False",
									anchorPointX = "0",
									anchorPointY = "1",
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
									height = "130",
									ignoreSize = "False",
									name = "old_desc",
									nTextAlign = "0",
									nTextHAlign = "0",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "对火属性伤害免伤提高20%。对冰属性伤害免伤提高20%。对暴风属性伤害免伤提高20%。对雷电属性伤害免伤提高20%",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionX = 271,
										PositionY = 316,
									},
									width = "270",
									ZOrder = "1",
								},
								{
									controlID = "cur_desc_Panel_back_Panel_base_Panel-gongmingLvUpView_Layer1_fairyNew_Game",
									UUID = "4d127f24_5120_4b62_add8_0e1d4ffb5fab",
									anchorPoint = "False",
									anchorPointX = "0",
									anchorPointY = "1",
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
									height = "130",
									ignoreSize = "False",
									name = "cur_desc",
									nTextAlign = "0",
									nTextHAlign = "0",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "对火属性伤害免伤提高20%。对冰属性伤害免伤提高20%。对暴风属性伤害免伤提高20%。对雷电属性伤害免伤提高20%",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionX = 642,
										PositionY = 316,
									},
									width = "270",
									ZOrder = "1",
								},
							},
						},
						{
							controlID = "Label_tips_Panel_base_Panel-gongmingLvUpView_Layer1_fairyNew_Game",
							UUID = "81936707_03f3_4f46_9709_fe350f1397f8",
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

