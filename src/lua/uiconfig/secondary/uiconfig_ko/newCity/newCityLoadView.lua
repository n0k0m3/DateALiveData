local t = 
{
	version = 1,
	components = 
	{
		
		{
			controlID = "Panel-newCityLoadView_Layer1_newCity_Game",
			UUID = "f58d5959_83cb_4be1_acd5_8b844ca12cd2",
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
					controlID = "Panel_base_Panel-newCityLoadView_Layer1_newCity_Game",
					UUID = "7a559df7_b2df_42e7_bada_9729442a2bc3",
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
					panelTexturePath = "scene/bg/bg_load.png",
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
							controlID = "Image_bg_bottom_Panel_base_Panel-newCityLoadView_Layer1_newCity_Game",
							UUID = "ddadf157_1013_4e53_b23b_fa79a0c6c0fd",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0",
							backGroundScale9Enable = "False",
							classname = "MEImage",
							dstBlendFunc = "771",
							height = "92",
							ignoreSize = "False",
							name = "Image_bg_bottom",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							texturePath = "ui/battle/load/001.png",
							touchAble = "False",
							UILayoutViewModel = 
							{
								PositionX = 568,
								LeftPositon = -125,
								TopPosition = 548,
								relativeToName = "Panel",
							},
							width = "1386",
							ZOrder = "1",
							components = 
							{
								
								{
									controlID = "Image_bg_left_Image_bg_bottom_Panel_base_Panel-newCityLoadView_Layer1_newCity_Game",
									UUID = "f51cc8da_3833_41da_b96a_bbec36a6cf79",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "60",
									ignoreSize = "True",
									name = "Image_bg_left",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/battle/load/003.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = -383,
									},
									visible = "False",
									width = "368",
									ZOrder = "1",
								},
								{
									controlID = "Image_xts_Image_bg_bottom_Panel_base_Panel-newCityLoadView_Layer1_newCity_Game",
									UUID = "906a81ea_70dc_460a_a5a3_36872e034e43",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "44",
									ignoreSize = "True",
									name = "Image_xts",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/battle/load/002.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = -497,
										PositionY = 30,
									},
									width = "110",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "Label_xts_Image_xts_Image_bg_bottom_Panel_base_Panel-newCityLoadView_Layer1_newCity_Game",
											UUID = "d83a03e2_8d83_4b47_bfb8_eeeea2c838df",
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
											fontSize = "20",
											fontStroke = 
											{
												IsStroke = false,
												StrokeColor = "#FFE6E6E6",
												StrokeSize = 1,
											},
											height = "23",
											ignoreSize = "True",
											name = "Label_xts",
											nTextAlign = "1",
											nTextHAlign = "1",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "770",
											text = "Tips",
											touchAble = "False",
											touchScaleEnable = "False",
											UILayoutViewModel = 
											{
												PositionX = -17,
											},
											width = "43",
											ZOrder = "1",
										},
									},
								},
							},
						},
						{
							controlID = "Panel_load_Panel_base_Panel-newCityLoadView_Layer1_newCity_Game",
							UUID = "c10023cc_8253_4adb_871c_709d66ae1c8e",
							anchorPoint = "False",
							anchorPointX = "0",
							anchorPointY = "0",
							backGroundScale9Enable = "True;capInsetsX:20;capInsetsY:0;capInsetsWidth:10;capInsetsHeight:8",
							bgColorOpacity = "50",
							bIsOpenClipping = "False",
							classname = "MEPanel",
							colorType = "0;SingleColor:#FFE6E6E6;GraduallyChangingColorStart:#FFFFFFFF;GraduallyChangingColorEnd:#FFFFFFFF;vectorX:0;vectorY:0",
							DesignHeight = "640",
							DesignType = "0",
							DesignWidth = "960",
							dstBlendFunc = "771",
							height = "8",
							ignoreSize = "False",
							name = "Panel_load",
							panelTexturePath = "ui/load_bg.png",
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
									controlID = "LoadingBar_Panel_load_Panel_base_Panel-newCityLoadView_Layer1_newCity_Game",
									UUID = "0628bce9_7113_4e22_8575_777badd56ecf",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "True;capInsetsX:20;capInsetsY:0;capInsetsWidth:20;capInsetsHeight:9",
									classname = "MELoadingBar",
									direction = "0",
									dstBlendFunc = "771",
									height = "8",
									ignoreSize = "False",
									name = "LoadingBar",
									percent = "100",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texture = "ui/load.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = 568,
										PositionY = 4,
										IsPercent = true,
										PercentX = 50,
										PercentY = 50,
										relativeToName = "Panel",
									},
									width = "1136",
									ZOrder = "1",
								},
							},
						},
						{
							controlID = "Label_tip_Panel_base_Panel-newCityLoadView_Layer1_newCity_Game",
							UUID = "a07da598_9c9f_4886_9cb4_218871a51088",
							anchorPoint = "False",
							anchorPointX = "0",
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
							height = "0",
							ignoreSize = "False",
							name = "Label_tip",
							nTextAlign = "0",
							nTextHAlign = "0",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "770",
							text = "작전 Tips 작전 Tips 작전 Tips",
							touchAble = "False",
							touchScaleEnable = "False",
							UILayoutViewModel = 
							{
								PositionX = 132,
								PositionY = 33,
							},
							width = "1000",
							ZOrder = "1",
						},
						{
							controlID = "Label_percent_Panel_base_Panel-newCityLoadView_Layer1_newCity_Game",
							UUID = "f5e3bc7e_dda2_4280_a2b3_e5882dce73e8",
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
							fontSize = "20",
							fontStroke = 
							{
								IsStroke = false,
								StrokeColor = "#FFE6E6E6",
								StrokeSize = 1,
							},
							height = "23",
							ignoreSize = "True",
							name = "Label_percent",
							nTextAlign = "1",
							nTextHAlign = "1",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "770",
							text = "load10%",
							touchAble = "False",
							touchScaleEnable = "False",
							UILayoutViewModel = 
							{
								PositionX = 568,
								PositionY = 203,
								IsPercent = true,
								PercentX = 50,
								PercentY = 31.75,
							},
							width = "72",
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
			"scene/bg/bg_load.png",
			"ui/battle/load/001.png",
			"ui/battle/load/003.png",
			"ui/battle/load/002.png",
			"ui/load_bg.png",
			"ui/load.png",
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

