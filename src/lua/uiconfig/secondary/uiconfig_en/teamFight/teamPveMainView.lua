local t = 
{
	version = 1,
	components = 
	{
		
		{
			controlID = "Panel-teamPveMainView_Layer1_teamFight_Game",
			UUID = "2ad2ebf0_6714_4953_b58d_24299f348d76",
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
					controlID = "Panel_root_Panel-teamPveMainView_Layer1_teamFight_Game",
					UUID = "51a2dabe_c2e9_487e_ae37_2a38a338e17a",
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
					name = "Panel_root",
					sizepercentx = "0",
					sizepercenty = "0",
					sizeType = "0",
					srcBlendFunc = "1",
					touchAble = "True",
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
							controlID = "Spine_door_Panel_root_Panel-teamPveMainView_Layer1_teamFight_Game",
							UUID = "867553d7_74bb_4252_b7da_9fbf3081a1ca",
							classname = "MESpine",
							dstBlendFunc = "771",
							name = "Spine_door",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							spineModel = 
							{
								SpinePath = "effect/effect_train_001/effect_train_001",
								animationName = "down",
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
								PositionX = 564,
								PositionY = 317,
								LeftPositon = 682,
								TopPosition = 289,
								relativeToName = "Panel",
							},
							ZOrder = "1",
						},
						{
							controlID = "Image_bg_Panel_root_Panel-teamPveMainView_Layer1_teamFight_Game",
							UUID = "d4c56c63_16f2_4a68_921b_41c058a8feed",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							backGroundScale9Enable = "False",
							classname = "MEImage",
							dstBlendFunc = "771",
							height = "640",
							ignoreSize = "True",
							name = "Image_bg",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							texturePath = "ui/teampve/main/bg.png",
							touchAble = "False",
							UILayoutViewModel = 
							{
								PositionX = 568,
								PositionY = 320,
								IsPercent = true,
								PercentX = 50,
								PercentY = 50,
							},
							width = "1386",
							ZOrder = "1",
						},
						{
							controlID = "Spine_light_Panel_root_Panel-teamPveMainView_Layer1_teamFight_Game",
							UUID = "4fa5e91d_afe1_4fc4_9738_b39b2a3f1511",
							classname = "MESpine",
							dstBlendFunc = "771",
							name = "Spine_light",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							spineModel = 
							{
								SpinePath = "effect/effect_train_001/effect_train_001",
								animationName = "up",
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
								PositionX = 566,
								PositionY = 321,
								relativeToName = "Panel",
							},
							ZOrder = "1",
						},
						{
							controlID = "Button_store_Panel_root_Panel-teamPveMainView_Layer1_teamFight_Game",
							UUID = "9f20b3ce_4a11_4abf_9a20_da1fb1f95b74",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							backGroundScale9Enable = "False",
							classname = "MEButton",
							ClickHighLightEnabled = "True",
							dstBlendFunc = "771",
							flipX = "False",
							flipY = "False",
							height = "74",
							ignoreSize = "True",
							name = "Button_store",
							normal = "ui/teampve/main/001.png",
							pressed = "ui/teampve/main/001.png",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							touchAble = "True",
							UILayoutViewModel = 
							{
								PositionX = 49,
								PositionY = 525,
							},
							UItype = "Button",
							width = "74",
							ZOrder = "1",
							components = 
							{
								
								{
									controlID = "Label_store_Button_store_Panel_root_Panel-teamPveMainView_Layer1_teamFight_Game",
									UUID = "610f3f3b_02c5_4ffb_896e_ca92cc7815cb",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									classname = "MELabel",
									compPath = "luacomponents.common.MEIconLabel",
									dstBlendFunc = "771",
									FontColor = "#FFFFFFFF",
									fontName = "font/MFLiHei_Noncommercial.ttf",
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
										IsStroke = true,
										StrokeColor = "#FF1B3860",
										StrokeSize = 1,
									},
									height = "32",
									ignoreSize = "True",
									name = "Label_store",
									nTextAlign = "1",
									nTextHAlign = "1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "Store",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionY = -51,
									},
									width = "93",
									ZOrder = "1",
								},
							},
						},
						{
							controlID = "ScrollView_Dungeon_Panel_root_Panel-teamPveMainView_Layer1_teamFight_Game",
							UUID = "d2e561cb_d0fe_4e8b_9581_0ded6766a8e1",
							anchorPoint = "False",
							anchorPointX = "0",
							anchorPointY = "0",
							backGroundScale9Enable = "False",
							bgColorOpacity = "50",
							bIsOpenClipping = "True",
							bounceEnable = "False",
							classname = "MEScrollView",
							colorType = "0;SingleColor:#FFE6E6E6;GraduallyChangingColorStart:#FFFFFFFF;GraduallyChangingColorEnd:#FFFFFFFF;vectorX:0;vectorY:0",
							direction = "1",
							dstBlendFunc = "771",
							height = "560",
							ignoreSize = "False",
							innerHeight = "560",
							innerWidth = "476",
							name = "ScrollView_Dungeon",
							showScrollbar = "False",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							touchAble = "True",
							UILayoutViewModel = 
							{
								PositionX = 640,
								PositionY = 1,
							},
							uipanelviewmodel = 
							{
								Layout="Absolute",
								nType = "0"
							},
							width = "476",
							ZOrder = "1",
						},
						{
							controlID = "Panel_levelClone_Panel_root_Panel-teamPveMainView_Layer1_teamFight_Game",
							UUID = "f2a901cf_55ee_48b2_b159_414dd8018795",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							backGroundScale9Enable = "False",
							bgColorOpacity = "50",
							bIsOpenClipping = "False",
							classname = "MEPanel",
							colorType = "0;SingleColor:#FFE6E6E6;GraduallyChangingColorStart:#FFFFFFFF;GraduallyChangingColorEnd:#FFFFFFFF;vectorX:0;vectorY:0",
							DesignHeight = "640",
							DesignType = "0",
							DesignWidth = "960",
							dstBlendFunc = "771",
							height = "184",
							ignoreSize = "False",
							name = "Panel_levelClone",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							touchAble = "False",
							UILayoutViewModel = 
							{
								PositionX = 683,
								PositionY = 197,
							},
							uipanelviewmodel = 
							{
								Layout="Absolute",
								nType = "0"
							},
							visible = "False",
							width = "476",
							ZOrder = "1",
							components = 
							{
								
								{
									controlID = "Button_level_Panel_levelClone_Panel_root_Panel-teamPveMainView_Layer1_teamFight_Game",
									UUID = "b51c3f5c_6f36_44a9_8db3_21ed45017aa1",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEButton",
									ClickHighLightEnabled = "True",
									dstBlendFunc = "771",
									flipX = "False",
									flipY = "False",
									height = "184",
									ignoreSize = "True",
									name = "Button_level",
									normal = "ui/teampve/main/009.png",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "True",
									UILayoutViewModel = 
									{
										relativeToName = "Panel",
									},
									UItype = "Button",
									width = "476",
									ZOrder = "1",
								},
								{
									controlID = "Image_line_Panel_levelClone_Panel_root_Panel-teamPveMainView_Layer1_teamFight_Game",
									UUID = "597eddf5_6b4f_433f_b1e8_6ee3474135b9",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "136",
									ignoreSize = "True",
									name = "Image_line",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/teampve/main/003.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = -208,
										PositionY = -3,
									},
									width = "6",
									ZOrder = "1",
								},
								{
									controlID = "Label_name_Panel_levelClone_Panel_root_Panel-teamPveMainView_Layer1_teamFight_Game",
									UUID = "65267efd_5e38_4777_9792_a258935e5cb0",
									anchorPoint = "False",
									anchorPointX = "0",
									anchorPointY = "0.5",
									classname = "MELabel",
									compPath = "luacomponents.common.MEIconLabel",
									dstBlendFunc = "771",
									FontColor = "#FFFFFFFF",
									fontName = "font/MFLiHei_Noncommercial.ttf",
									fontShadow = 
									{
										IsShadow = false,
										ShadowColor = "#FFFFFFFF",
										ShadowAlpha = 255,
										OffsetX = 0,
										OffsetY = 0,
									},
									fontSize = "36",
									fontStroke = 
									{
										IsStroke = true,
										StrokeColor = "#FF1D3860",
										StrokeSize = 2,
									},
									height = "49",
									ignoreSize = "True",
									name = "Label_name",
									nTextAlign = "1",
									nTextHAlign = "1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "Break into DEM Base",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionX = -183,
										PositionY = 38,
									},
									width = "492",
									ZOrder = "1",
								},
								{
									controlID = "Label_time_Panel_levelClone_Panel_root_Panel-teamPveMainView_Layer1_teamFight_Game",
									UUID = "2324aefd_cdb2_430f_92b7_87ac52592710",
									anchorPoint = "False",
									anchorPointX = "0",
									anchorPointY = "0.5",
									classname = "MELabel",
									compPath = "luacomponents.common.MEIconLabel",
									dstBlendFunc = "771",
									FontColor = "#FF1D3860",
									fontName = "font/MFLiHei_Noncommercial.ttf",
									fontShadow = 
									{
										IsShadow = false,
										ShadowColor = "#FFFFFFFF",
										ShadowAlpha = 255,
										OffsetX = 0,
										OffsetY = 0,
									},
									fontSize = "19",
									fontStroke = 
									{
										IsStroke = true,
										StrokeColor = "#FFFFFFFF",
										StrokeSize = 1,
									},
									height = "26",
									ignoreSize = "True",
									name = "Label_time",
									nTextAlign = "1",
									nTextHAlign = "1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "TextLable",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionX = -183,
										PositionY = -3,
									},
									width = "130",
									ZOrder = "1",
								},
								{
									controlID = "Image_lock_Panel_levelClone_Panel_root_Panel-teamPveMainView_Layer1_teamFight_Game",
									UUID = "ab151745_b086_4c8b_97e8_1f6e01656606",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "154",
									ignoreSize = "True",
									name = "Image_lock",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/teampve/main/008.png",
									touchAble = "True",
									UILayoutViewModel = 
									{
										PositionX = -2,
										PositionY = -3,
									},
									width = "444",
									ZOrder = "1",
								},
							},
						},
						{
							controlID = "Node_role_Panel_root_Panel-teamPveMainView_Layer1_teamFight_Game",
							UUID = "0066864e_a50f_4801_8058_84ff12c3e5ad",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							backGroundScale9Enable = "False",
							bgColorOpacity = "255",
							bIsOpenClipping = "False",
							classname = "MEPanel",
							colorType = "0;SingleColor:#FF000000;GraduallyChangingColorStart:#FFFFFFFF;GraduallyChangingColorEnd:#FFFFFFFF;vectorX:0;vectorY:0",
							DesignHeight = "640",
							DesignType = "0",
							DesignWidth = "960",
							dstBlendFunc = "771",
							height = "50",
							ignoreSize = "False",
							name = "Node_role",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							touchAble = "False",
							UILayoutViewModel = 
							{
								PositionX = 366,
								PositionY = -41,
							},
							uipanelviewmodel = 
							{
								Layout="Absolute",
								nType = "0"
							},
							width = "50",
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
			"ui/teampve/main/bg.png",
			"ui/teampve/main/001.png",
			"ui/teampve/main/009.png",
			"ui/teampve/main/003.png",
			"ui/teampve/main/008.png",
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

