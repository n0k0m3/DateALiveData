local t = 
{
	version = 1,
	components = 
	{
		
		{
			controlID = "Panel-treasureHuntingView_Layer1_activity_Game",
			UUID = "48a4593c_ad7b_44f7_8e06_7d5d3b9f0c6a",
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
			sizepercentx = "100",
			sizepercenty = "100",
			sizeType = "1",
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
					controlID = "Panel_root_Panel-treasureHuntingView_Layer1_activity_Game",
					UUID = "7c980e3e_1268_4087_9591_d01b2f5936fa",
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
						relativeToName = "Panel",
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
							controlID = "Image_bg_0_Panel_root_Panel-treasureHuntingView_Layer1_activity_Game",
							UUID = "0e0bb260_9198_4b5f_91dc_08df8aaa9275",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							backGroundScale9Enable = "False",
							classname = "MEImage",
							dstBlendFunc = "771",
							height = "546",
							ignoreSize = "True",
							name = "Image_bg_0",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							texturePath = "ui/activity/baowuhunter/003.png",
							touchAble = "False",
							UILayoutViewModel = 
							{
								
							},
							width = "890",
							ZOrder = "1",
						},
						{
							controlID = "act_time_Panel_root_Panel-treasureHuntingView_Layer1_activity_Game",
							UUID = "239beb57_efcb_4ff2_b922_63202b8846d0",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							classname = "MELabel",
							compPath = "luacomponents.common.MEIconLabel",
							dstBlendFunc = "771",
							FontColor = "#FFF6CBDA",
							fontName = "font/MFLiHei_Noncommercial.ttf",
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
							height = "0",
							ignoreSize = "True",
							name = "act_time",
							nTextAlign = "1",
							nTextHAlign = "1",
							rotation = "-11",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "770",
							touchAble = "False",
							touchScaleEnable = "False",
							UILayoutViewModel = 
							{
								PositionX = -357,
								PositionY = 244,
							},
							width = "0",
							ZOrder = "1",
							components = 
							{
								
								{
									controlID = "act_timeStart_act_time_Panel_root_Panel-treasureHuntingView_Layer1_activity_Game",
									UUID = "b130432d_9fb0_4d87_8f4f_a69e13ff626b",
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
									fontSize = "18",
									fontStroke = 
									{
										IsStroke = false,
										StrokeColor = "#FFE6E6E6",
										StrokeSize = 1,
									},
									height = "21",
									ignoreSize = "True",
									name = "act_timeStart",
									nTextAlign = "1",
									nTextHAlign = "1",
									rotation = "-2",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "20200416",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionX = -66,
										PositionY = -24,
									},
									width = "83",
									ZOrder = "1",
								},
								{
									controlID = "act_timeEnd_act_time_Panel_root_Panel-treasureHuntingView_Layer1_activity_Game",
									UUID = "9ad32450_3c44_4230_a4de_732e27fd644a",
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
									fontSize = "18",
									fontStroke = 
									{
										IsStroke = false,
										StrokeColor = "#FFE6E6E6",
										StrokeSize = 1,
									},
									height = "21",
									ignoreSize = "True",
									name = "act_timeEnd",
									nTextAlign = "1",
									nTextHAlign = "1",
									rotation = "-2",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "20200416",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionX = -81,
										PositionY = -45,
									},
									width = "83",
									ZOrder = "1",
								},
							},
						},
						{
							controlID = "Button_go_Panel_root_Panel-treasureHuntingView_Layer1_activity_Game",
							UUID = "d400bfa3_8787_4569_aebc_47e5a0d3489e",
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
							name = "Button_go",
							normal = "ui/activity/baowuhunter/002.png",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							touchAble = "True",
							UILayoutViewModel = 
							{
								PositionX = 334,
								PositionY = -212,
							},
							UItype = "Button",
							width = "144",
							ZOrder = "1",
							components = 
							{
								
								{
									controlID = "Label_treasureHuntingView_1_Button_go_Panel_root_Panel-treasureHuntingView_Layer1_activity_Game",
									UUID = "5e01c205_811c_45b9_aaa9_f32f5561c0c5",
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
										IsStroke = false,
										StrokeColor = "#FFE6E6E6",
										StrokeSize = 1,
									},
									height = "28",
									ignoreSize = "True",
									name = "Label_treasureHuntingView_1",
									nTextAlign = "1",
									nTextHAlign = "1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "前 往",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionY = -2,
									},
									width = "57",
									ZOrder = "1",
								},
							},
						},
						{
							controlID = "Button_shop_Panel_root_Panel-treasureHuntingView_Layer1_activity_Game",
							UUID = "e5bd3bc1_5972_4b75_bd74_e0b9a2a9a1e8",
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
							name = "Button_shop",
							normal = "ui/activity/baowuhunter/002.png",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							touchAble = "True",
							UILayoutViewModel = 
							{
								PositionX = 180,
								PositionY = -212,
							},
							UItype = "Button",
							width = "144",
							ZOrder = "1",
							components = 
							{
								
								{
									controlID = "Label_treasureHuntingView_1_Button_shop_Panel_root_Panel-treasureHuntingView_Layer1_activity_Game",
									UUID = "cc6b2c92_1017_4671_a89d_cbc1ffe6c3dc",
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
										IsStroke = false,
										StrokeColor = "#FFE6E6E6",
										StrokeSize = 1,
									},
									height = "28",
									ignoreSize = "True",
									name = "Label_treasureHuntingView_1",
									nTextAlign = "1",
									nTextHAlign = "1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "商 店",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionY = -2,
									},
									width = "57",
									ZOrder = "1",
								},
							},
						},
						{
							controlID = "panel_scroll_Panel_root_Panel-treasureHuntingView_Layer1_activity_Game",
							UUID = "833bcd86_6145_4319_b49a_aee64eac7a28",
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
							height = "175",
							ignoreSize = "False",
							name = "panel_scroll",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							touchAble = "False",
							UILayoutViewModel = 
							{
								PositionX = 34,
								PositionY = -196,
							},
							uipanelviewmodel = 
							{
								Layout="Absolute",
								nType = "0"
							},
							width = "394",
							ZOrder = "1",
							components = 
							{
								
								{
									controlID = "ScrollView_des_panel_scroll_Panel_root_Panel-treasureHuntingView_Layer1_activity_Game",
									UUID = "ec830b35_d0f9_4676_8dae_0f8bec329600",
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
									height = "150",
									ignoreSize = "False",
									innerHeight = "150",
									innerWidth = "394",
									name = "ScrollView_des",
									showScrollbar = "False",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "True",
									UILayoutViewModel = 
									{
										PositionX = -27,
										PositionY = 25,
									},
									uipanelviewmodel = 
									{
										Layout="Absolute",
										nType = "0"
									},
									width = "394",
									ZOrder = "1",
								},
							},
						},
						{
							controlID = "Panel_des_Panel_root_Panel-treasureHuntingView_Layer1_activity_Game",
							UUID = "b0712c02_e02d_432b_a3e3_d2e6bc91d796",
							anchorPoint = "False",
							anchorPointX = "0",
							anchorPointY = "1",
							backGroundScale9Enable = "False",
							bgColorOpacity = "50",
							bIsOpenClipping = "False",
							classname = "MEPanel",
							colorType = "0;SingleColor:#FFE6E6E6;GraduallyChangingColorStart:#FFFFFFFF;GraduallyChangingColorEnd:#FFFFFFFF;vectorX:0;vectorY:0",
							DesignHeight = "640",
							DesignType = "0",
							DesignWidth = "960",
							dstBlendFunc = "771",
							height = "116",
							ignoreSize = "False",
							name = "Panel_des",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							touchAble = "False",
							UILayoutViewModel = 
							{
								PositionX = 212,
								PositionY = -819,
							},
							uipanelviewmodel = 
							{
								Layout="Absolute",
								nType = "0"
							},
							width = "394",
							ZOrder = "1",
							components = 
							{
								
								{
									controlID = "Label_title_Panel_des_Panel_root_Panel-treasureHuntingView_Layer1_activity_Game",
									UUID = "c06849ea_ec65_4f35_931a_b562ce6ae60f",
									anchorPoint = "False",
									anchorPointX = "0",
									anchorPointY = "1",
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
									fontSize = "20",
									fontStroke = 
									{
										IsStroke = false,
										StrokeColor = "#FFE6E6E6",
										StrokeSize = 1,
									},
									height = "0",
									ignoreSize = "False",
									name = "Label_title",
									nTextAlign = "0",
									nTextHAlign = "0",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "Remaining",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										
									},
									width = "394",
									ZOrder = "1",
								},
							},
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
			"ui/activity/baowuhunter/003.png",
			"ui/activity/baowuhunter/002.png",
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

