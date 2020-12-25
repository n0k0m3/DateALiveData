local t = 
{
	version = 1,
	components = 
	{
		
		{
			controlID = "Panel-loginNotice_Layer1_loginScene_Game",
			UUID = "9b5871bc_ddef_4d78_8606_d96f43f3e12d",
			anchorPoint = "False",
			anchorPointX = "0",
			anchorPointY = "0",
			backGroundScale9Enable = "False",
			bgColorOpacity = "255",
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
					controlID = "Panel_root_Panel-loginNotice_Layer1_loginScene_Game",
					UUID = "61ec1315_9760_46a8_bddc_53e70f46d303",
					anchorPoint = "False",
					anchorPointX = "0",
					anchorPointY = "0",
					backGroundScale9Enable = "False",
					bgColorOpacity = "255",
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
						Layout="Relative",
						nType = "3"
					},
					width = "1136",
					ZOrder = "1",
					components = 
					{
						
						{
							controlID = "noctice_bg_Panel_root_Panel-loginNotice_Layer1_loginScene_Game",
							UUID = "743c1597_39e7_4557_a354_416831ff4f88",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							backGroundScale9Enable = "False",
							classname = "MEImage",
							dstBlendFunc = "771",
							height = "460",
							ignoreSize = "False",
							name = "noctice_bg",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							texturePath = "ui/login/1.png",
							touchAble = "False",
							UILayoutViewModel = 
							{
								PositionX = 568,
								PositionY = 320,
								IsPercent = true,
								PercentX = 50,
								PercentY = 50,
								relativeToName = "Panel_root",
								nType = 3,
								nGravity = 6,
								nAlign = 5
							},
							width = "842",
							ZOrder = "1",
							components = 
							{
								
								{
									controlID = "Image_textbg_noctice_bg_Panel_root_Panel-loginNotice_Layer1_loginScene_Game",
									UUID = "639d4b72_8183_40ea_8e05_8053dca8a1d5",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "14",
									ignoreSize = "True",
									name = "Image_textbg",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/common/pop_ui/pop_ui_01.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = -330,
										PositionY = 197,
									},
									width = "14",
									ZOrder = "1",
								},
								{
									controlID = "Label_englishName_noctice_bg_Panel_root_Panel-loginNotice_Layer1_loginScene_Game",
									UUID = "e154dcb3_0ecb_4139_a3b2_9648fcf56f4e",
									anchorPoint = "False",
									anchorPointX = "0",
									anchorPointY = "0.5",
									classname = "MELabel",
									compPath = "luacomponents.common.MEIconLabel",
									dstBlendFunc = "771",
									FontColor = "#FF30354A",
									fontName = "font/fangzheng_zhunyuan.ttf",
									fontShadow = 
									{
										IsShadow = false,
										ShadowColor = "#FFFFFFFF",
										ShadowAlpha = 255,
										OffsetX = 0,
										OffsetY = 0,
									},
									fontSize = "15",
									fontStroke = 
									{
										IsStroke = false,
										StrokeColor = "#FFE6E6E6",
										StrokeSize = 1,
									},
									height = "17",
									ignoreSize = "True",
									name = "Label_englishName",
									nTextAlign = "1",
									nTextHAlign = "1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "Hinweis",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionX = -339,
										PositionY = 197,
									},
									width = "43",
									ZOrder = "1",
								},
								{
									controlID = "Button_ok_noctice_bg_Panel_root_Panel-loginNotice_Layer1_loginScene_Game",
									UUID = "c2090fb4_d4a3_4af2_ab5c_dc0b699ccf30",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "True;capInsetsX:0;capInsetsY:0;capInsetsWidth:0;capInsetsHeight:0",
									classname = "MEButton",
									ClickHighLightEnabled = "True",
									dstBlendFunc = "771",
									flipX = "False",
									flipY = "False",
									height = "50",
									ignoreSize = "False",
									name = "Button_ok",
									normal = "ui/common/button09.png",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "True",
									UILayoutViewModel = 
									{
										PositionY = -120,
										IsPercent = true,
										PercentY = -35,
									},
									UItype = "Button",
									width = "120",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "Label_loginLayer_1_Button_ok_noctice_bg_Panel_root_Panel-loginNotice_Layer1_loginScene_Game",
											UUID = "b45feee8_353e_473f_bd0c_06926999229e",
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
											name = "Label_loginLayer_1",
											nTextAlign = "1",
											nTextHAlign = "1",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "770",
											text = "Bestätigen",
											touchAble = "False",
											touchScaleEnable = "False",
											UILayoutViewModel = 
											{
												
											},
											width = "63",
											ZOrder = "1",
										},
									},
								},
								{
									controlID = "Label_name_noctice_bg_Panel_root_Panel-loginNotice_Layer1_loginScene_Game",
									UUID = "8398e10a_6d94_47ec_8b6f_bd33d2d9edaf",
									anchorPoint = "False",
									anchorPointX = "0",
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
									fontSize = "28",
									fontStroke = 
									{
										IsStroke = false,
										StrokeColor = "#FFE6E6E6",
										StrokeSize = 1,
									},
									height = "35",
									ignoreSize = "True",
									name = "Label_name",
									nTextAlign = "1",
									nTextHAlign = "1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "Ankündigung",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionX = -408,
										PositionY = 201,
									},
									width = "59",
									ZOrder = "1",
								},
								{
									controlID = "Image_fubenReadyView_1_noctice_bg_Panel_root_Panel-loginNotice_Layer1_loginScene_Game",
									UUID = "784788be_8cc9_469c_9b47_08b26fe98998",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "26",
									ignoreSize = "True",
									name = "Image_fubenReadyView_1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/common/pop_ui/pop_ui_02.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = -344,
										PositionY = 204,
									},
									width = "2",
									ZOrder = "1",
								},
								{
									controlID = "Button_close_noctice_bg_Panel_root_Panel-loginNotice_Layer1_loginScene_Game",
									UUID = "5e905013_c9cf_4116_a124_2d1821459398",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEButton",
									ClickHighLightEnabled = "True",
									dstBlendFunc = "771",
									flipX = "False",
									flipY = "False",
									height = "60",
									ignoreSize = "True",
									name = "Button_close",
									normal = "ui/common/pop_ui/pop_btn_02.png",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "True",
									UILayoutViewModel = 
									{
										PositionX = 396,
										PositionY = 205,
									},
									UItype = "Button",
									width = "60",
									ZOrder = "1",
								},
								{
									controlID = "ScrollView_desc_noctice_bg_Panel_root_Panel-loginNotice_Layer1_loginScene_Game",
									UUID = "3465647b_50c3_4b5e_b52e_c7c075a1871d",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									bgColorOpacity = "50",
									bIsOpenClipping = "True",
									bounceEnable = "True",
									classname = "MEScrollView",
									colorType = "0;SingleColor:#FFFF0000;GraduallyChangingColorStart:#FFFFFFFF;GraduallyChangingColorEnd:#FFFFFFFF;vectorX:0;vectorY:0",
									direction = "1",
									dstBlendFunc = "771",
									height = "270",
									ignoreSize = "False",
									innerHeight = "270",
									innerWidth = "730",
									name = "ScrollView_desc",
									showScrollbar = "True",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "True",
									UILayoutViewModel = 
									{
										PositionY = 19,
									},
									uipanelviewmodel = 
									{
										Layout="Absolute",
										nType = "0"
									},
									width = "730",
									ZOrder = "1",
								},
								{
									controlID = "Image_scrollBarModel_noctice_bg_Panel_root_Panel-loginNotice_Layer1_loginScene_Game",
									UUID = "7c0b92af_dda1_4ed5_8c8c_073f108a3d12",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "True;capInsetsX:0;capInsetsY:0;capInsetsWidth:0;capInsetsHeight:0",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "270",
									ignoreSize = "False",
									name = "Image_scrollBarModel",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/common/scroll_bar_01.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = 360,
										PositionY = 18,
									},
									width = "6",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "Image_scrollBarInner_Image_scrollBarModel_noctice_bg_Panel_root_Panel-loginNotice_Layer1_loginScene_Game",
											UUID = "4cdc9005_1d98_48c0_a952_524bfee0e4e6",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "True;capInsetsX:0;capInsetsY:0;capInsetsWidth:0;capInsetsHeight:0",
											classname = "MEImage",
											dstBlendFunc = "771",
											height = "270",
											ignoreSize = "False",
											name = "Image_scrollBarInner",
											sizepercentx = "100",
											sizepercenty = "100",
											sizeType = "0",
											srcBlendFunc = "1",
											texturePath = "ui/common/scroll_bar_02.png",
											touchAble = "False",
											UILayoutViewModel = 
											{
												
											},
											width = "6",
											ZOrder = "1",
										},
									},
								},
							},
						},
						{
							controlID = "Label_contentCloneObj_Panel_root_Panel-loginNotice_Layer1_loginScene_Game",
							UUID = "2b6ee06e_1c9f_486b_9d1e_87d12c22de60",
							anchorPoint = "False",
							anchorPointX = "0",
							anchorPointY = "0.5",
							classname = "MELabel",
							compPath = "luacomponents.common.MEIconLabel",
							dstBlendFunc = "771",
							FontColor = "#FF30354A",
							fontName = "font/fangzheng_zhunyuan.ttf",
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
							ignoreSize = "True",
							name = "Label_contentCloneObj",
							nTextAlign = "0",
							nTextHAlign = "0",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "770",
							touchAble = "False",
							touchScaleEnable = "False",
							UILayoutViewModel = 
							{
								PositionY = 640,
								relativeToName = "Panel_root",
								nType = 3,
							},
							width = "0",
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
			"ui/login/1.png",
			"ui/common/pop_ui/pop_ui_01.png",
			"ui/common/button09.png",
			"ui/common/pop_ui/pop_ui_02.png",
			"ui/common/pop_ui/pop_btn_02.png",
			"ui/common/scroll_bar_01.png",
			"ui/common/scroll_bar_02.png",
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

