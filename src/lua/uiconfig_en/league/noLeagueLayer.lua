local t = 
{
	version = 1,
	components = 
	{
		
		{
			controlID = "Panel-noLeagueLayer_Layer1_league_Game",
			UUID = "ee919efe_3d0f_4b73_b0d0_848e8d6373ec",
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
					controlID = "Panel_root_Panel-noLeagueLayer_Layer1_league_Game",
					UUID = "49391f34_8ca4_4827_b4ef_4ab2e293caed",
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
					height = "640",
					ignoreSize = "False",
					name = "Panel_root",
					sizepercentx = "0",
					sizepercenty = "0",
					sizeType = "0",
					srcBlendFunc = "1",
					touchAble = "False",
					UILayoutViewModel = 
					{
						PositionX = 568,
						PositionY = 320,
						IsPercent = true,
						PercentX = 50,
						PercentY = 50,
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
							controlID = "Image_bg_01_Panel_root_Panel-noLeagueLayer_Layer1_league_Game",
							UUID = "a475c5a7_0b09_4891_97d2_e478f64b807a",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							backGroundScale9Enable = "False",
							classname = "MEImage",
							dstBlendFunc = "771",
							height = "640",
							ignoreSize = "True",
							name = "Image_bg_01",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "770",
							texturePath = "ui/league/bg.jpg",
							touchAble = "False",
							UILayoutViewModel = 
							{
								relativeToName = "Panel_back",
								nGravity = 6,
								nAlign = 5
							},
							width = "1386",
							ZOrder = "1",
						},
						{
							controlID = "Button_create_league_Panel_root_Panel-noLeagueLayer_Layer1_league_Game",
							UUID = "47163e62_9ce6_42df_850c_b1e689e1c82e",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							backGroundScale9Enable = "False",
							classname = "MEButton",
							ClickHighLightEnabled = "True",
							dstBlendFunc = "771",
							flipX = "False",
							flipY = "False",
							height = "533",
							HitType = 
							{
								nHitType = 1,
								nXpos = 22,
								nYpos = 11,
								nHitWidth = 437,
								nHitHeight = 430
							},
							ignoreSize = "True",
							name = "Button_create_league",
							normal = "ui/league/ui_38.png",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							touchAble = "True",
							UILayoutViewModel = 
							{
								PositionX = -290,
								PositionY = 38,
								relativeToName = "Panel_root",
							},
							UItype = "Button",
							width = "477",
							ZOrder = "1",
							components = 
							{
								
								{
									controlID = "Image_noLeagueLayer_1_Button_create_league_Panel_root_Panel-noLeagueLayer_Layer1_league_Game",
									UUID = "7565e3d8_294d_404e_af8d_b00dd006e235",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "57",
									ignoreSize = "True",
									name = "Image_noLeagueLayer_1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/league/ui_40.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = 2,
										PositionY = -292,
									},
									width = "203",
									ZOrder = "1",
								},
								{
									controlID = "Label_create_league_Button_create_league_Panel_root_Panel-noLeagueLayer_Layer1_league_Game",
									UUID = "db4f613b_19f5_42b4_8ef1_c95262924584",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									classname = "MELabel",
									compPath = "luacomponents.common.MEIconLabel",
									dstBlendFunc = "771",
									FontColor = "#FF30354A",
									fontName = "font/MFLiHei_Noncommercial.ttf",
									fontShadow = 
									{
										IsShadow = false,
										ShadowColor = "#FFFFFFFF",
										ShadowAlpha = 255,
										OffsetX = 0,
										OffsetY = 0,
									},
									fontSize = "26",
									fontStroke = 
									{
										IsStroke = false,
										StrokeColor = "#FFE6E6E6",
										StrokeSize = 1,
									},
									height = "32",
									ignoreSize = "True",
									name = "Label_create_league",
									nTextAlign = "1",
									nTextHAlign = "1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "Create Club",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionY = -296,
									},
									width = "106",
									ZOrder = "1",
								},
							},
						},
						{
							controlID = "Button_join_league_Panel_root_Panel-noLeagueLayer_Layer1_league_Game",
							UUID = "4590c474_38a9_4940_aaad_0cf24404c62d",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							backGroundScale9Enable = "False",
							classname = "MEButton",
							ClickHighLightEnabled = "True",
							dstBlendFunc = "771",
							flipX = "False",
							flipY = "False",
							height = "533",
							HitType = 
							{
								nHitType = 1,
								nXpos = 21,
								nYpos = 7,
								nHitWidth = 441,
								nHitHeight = 449
							},
							ignoreSize = "True",
							name = "Button_join_league",
							normal = "ui/league/ui_39.png",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							touchAble = "True",
							UILayoutViewModel = 
							{
								PositionX = 286,
								PositionY = 38,
								relativeToName = "Panel_root",
							},
							UItype = "Button",
							width = "477",
							ZOrder = "1",
							components = 
							{
								
								{
									controlID = "Image_noLeagueLayer_1(2)_Button_join_league_Panel_root_Panel-noLeagueLayer_Layer1_league_Game",
									UUID = "01a9d23a_d215_474f_a1b7_4f962f911198",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "57",
									ignoreSize = "True",
									name = "Image_noLeagueLayer_1(2)",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/league/ui_40.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = 25,
										PositionY = -292,
									},
									width = "203",
									ZOrder = "1",
								},
								{
									controlID = "Label_join_league_Button_join_league_Panel_root_Panel-noLeagueLayer_Layer1_league_Game",
									UUID = "375d04f9_99fe_4295_9be7_b4e39449a4c0",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									classname = "MELabel",
									compPath = "luacomponents.common.MEIconLabel",
									dstBlendFunc = "771",
									FontColor = "#FF30354A",
									fontName = "font/MFLiHei_Noncommercial.ttf",
									fontShadow = 
									{
										IsShadow = false,
										ShadowColor = "#FFFFFFFF",
										ShadowAlpha = 255,
										OffsetX = 0,
										OffsetY = 0,
									},
									fontSize = "26",
									fontStroke = 
									{
										IsStroke = false,
										StrokeColor = "#FFE6E6E6",
										StrokeSize = 1,
									},
									height = "32",
									ignoreSize = "True",
									name = "Label_join_league",
									nTextAlign = "1",
									nTextHAlign = "1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "Join Club",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionX = 27,
										PositionY = -295,
									},
									width = "106",
									ZOrder = "1",
								},
							},
						},
					},
				},
				{
					controlID = "Panel_prefab_Panel-noLeagueLayer_Layer1_league_Game",
					UUID = "b6535f41_cbd8_4331_957b_a2bfe9fe4173",
					anchorPoint = "False",
					anchorPointX = "0",
					anchorPointY = "0",
					backGroundScale9Enable = "False",
					bgColorOpacity = "50",
					bIsOpenClipping = "False",
					classname = "MEPanel",
					colorType = "1;SingleColor:#FFDDA0DD;GraduallyChangingColorStart:#FFFFFFFF;GraduallyChangingColorEnd:#FFFFFFFF;vectorX:0;vectorY:0",
					DesignHeight = "640",
					DesignType = "0",
					DesignWidth = "960",
					dstBlendFunc = "771",
					height = "726",
					ignoreSize = "False",
					name = "Panel_prefab",
					sizepercentx = "100",
					sizepercenty = "100",
					sizeType = "1",
					srcBlendFunc = "1",
					touchAble = "False",
					UILayoutViewModel = 
					{
						PositionX = -32,
						PositionY = -805,
						LeftPositon = -32,
						TopPosition = 805,
						relativeToName = "Panel",
						nType = 3,
					},
					uipanelviewmodel = 
					{
						Layout="Absolute",
						nType = "0"
					},
					width = "1036",
					ZOrder = "1",
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
			"ui/league/bg.jpg",
			"ui/league/ui_38.png",
			"ui/league/ui_40.png",
			"ui/league/ui_39.png",
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

