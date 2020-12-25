local t = 
{
	version = 1,
	components = 
	{
		
		{
			controlID = "Panel-newCityBagView_Layer1_newCity_Game",
			UUID = "20e8b2a7_1404_4819_accb_b9a8492a40c0",
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
					controlID = "Panel_base_Panel-newCityBagView_Layer1_newCity_Game",
					UUID = "c97c177c_a0d7_48f9_ba9c_69030e51e652",
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
							controlID = "Image_bg_Panel_base_Panel-newCityBagView_Layer1_newCity_Game",
							UUID = "9b1a8901_dfdb_4efa_8486_2ac12dfc6829",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							backGroundScale9Enable = "True;capInsetsX:0;capInsetsY:0;capInsetsWidth:0;capInsetsHeight:0",
							classname = "MEImage",
							dstBlendFunc = "771",
							height = "360",
							ignoreSize = "False",
							name = "Image_bg",
							sizepercentx = "100",
							sizepercenty = "100",
							sizeType = "0",
							srcBlendFunc = "1",
							texturePath = "ui/common/pop_ui/pop_bg_01.png",
							touchAble = "False",
							UILayoutViewModel = 
							{
								PositionX = 568,
								PositionY = 320,
								IsPercent = true,
								PercentX = 50,
								PercentY = 50,
								LeftPositon = 118,
								TopPosition = 70,
							},
							width = "660",
							ZOrder = "1",
							components = 
							{
								
								{
									controlID = "Label_tittle_Image_bg_Panel_base_Panel-newCityBagView_Layer1_newCity_Game",
									UUID = "94ea208a_f9db_44a6_a3f0_2ac86664367e",
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
									height = "32",
									ignoreSize = "True",
									name = "Label_tittle",
									nTextAlign = "1",
									nTextHAlign = "1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "กระเป๋าของฉัน",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionX = -317,
										PositionY = 148,
									},
									width = "138",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "Image_line_Label_tittle_Image_bg_Panel_base_Panel-newCityBagView_Layer1_newCity_Game",
											UUID = "faff87cc_2f57_4a40_9a4a_a8807050d29d",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											classname = "MEImage",
											dstBlendFunc = "771",
											height = "26",
											ignoreSize = "True",
											name = "Image_line",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											texturePath = "ui/common/pop_ui/pop_ui_02.png",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 145,
												IsPercent = true,
												PercentX = 105,
											},
											visible = "False",
											width = "2",
											ZOrder = "1",
										},
										{
											controlID = "Label_tip_Label_tittle_Image_bg_Panel_base_Panel-newCityBagView_Layer1_newCity_Game",
											UUID = "3558e0a2_43f1_451c_9e30_50304209a704",
											anchorPoint = "False",
											anchorPointX = "0",
											anchorPointY = "0.5",
											classname = "MELabel",
											compPath = "luacomponents.common.MEIconLabel",
											dstBlendFunc = "771",
											FontColor = "#FF101117",
											fontName = "font/fangzheng_zhunyuan.ttf",
											fontShadow = 
											{
												IsShadow = false,
												ShadowColor = "#FFFFFFFF",
												ShadowAlpha = 255,
												OffsetX = 0,
												OffsetY = 0,
											},
											fontSize = "14",
											fontStroke = 
											{
												IsStroke = false,
												StrokeColor = "#FFE6E6E6",
												StrokeSize = 1,
											},
											height = "16",
											ignoreSize = "True",
											name = "Label_tip",
											nTextAlign = "1",
											nTextHAlign = "1",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "770",
											text = "กระเป๋าเป้ของฉัน",
											touchAble = "False",
											touchScaleEnable = "False",
											UILayoutViewModel = 
											{
												PositionX = 149,
												PositionY = -5,
												IsPercent = true,
												PercentX = 108,
												PercentY = -15,
											},
											visible = "False",
											width = "86",
											ZOrder = "1",
										},
									},
								},
								{
									controlID = "Button_close_Image_bg_Panel_base_Panel-newCityBagView_Layer1_newCity_Game",
									UUID = "ae969b88_885a_49ec_88e8_ecb6e722538b",
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
										PositionX = 303,
										PositionY = 150,
									},
									UItype = "Button",
									width = "60",
									ZOrder = "1",
								},
								{
									controlID = "Image_infoBg_Image_bg_Panel_base_Panel-newCityBagView_Layer1_newCity_Game",
									UUID = "0a044d96_ece0_4d48_87a1_c3a520986fb9",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "290",
									ignoreSize = "False",
									name = "Image_infoBg",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/common/pop_ui/pop_bg_02.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionY = -14,
									},
									width = "638",
									ZOrder = "1",
								},
								{
									controlID = "Panel_bag_Image_bg_Panel_base_Panel-newCityBagView_Layer1_newCity_Game",
									UUID = "1b7c2756_1816_44b7_a44e_cb56738c64ee",
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
									height = "286",
									ignoreSize = "False",
									name = "Panel_bag",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionY = -14,
									},
									uipanelviewmodel = 
									{
										Layout="Absolute",
										nType = "0"
									},
									width = "640",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "ScrollView_bagInfo_Panel_bag_Image_bg_Panel_base_Panel-newCityBagView_Layer1_newCity_Game",
											UUID = "c9c92fec_7f40_4a17_9264_7f619b45f47c",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											bgColorOpacity = "50",
											bIsOpenClipping = "True",
											bounceEnable = "True",
											classname = "MEScrollView",
											colorType = "0;SingleColor:#FFE6E6E6;GraduallyChangingColorStart:#FFFFFFFF;GraduallyChangingColorEnd:#FFFFFFFF;vectorX:0;vectorY:0",
											direction = "1",
											dstBlendFunc = "771",
											height = "286",
											ignoreSize = "False",
											innerHeight = "286",
											innerWidth = "640",
											name = "ScrollView_bagInfo",
											showScrollbar = "False",
											sizepercentx = "98",
											sizepercenty = "100",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "True",
											UILayoutViewModel = 
											{
												LeftPositon = 13,
												TopPosition = 7,
												relativeToName = "Panel_bagInfo",
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											visible = "False",
											width = "640",
											ZOrder = "1",
										},
									},
								},
								{
									controlID = "Label_none_Image_bg_Panel_base_Panel-newCityBagView_Layer1_newCity_Game",
									UUID = "195c78ac_00c3_4eab_baa0_3e2d3e18352c",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									classname = "MELabel",
									compPath = "luacomponents.common.MEIconLabel",
									dstBlendFunc = "771",
									FontColor = "#FFA2A4C8",
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
									name = "Label_none",
									nTextAlign = "1",
									nTextHAlign = "1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "ป้ายข้อความ",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										
									},
									width = "88",
									ZOrder = "1",
								},
								{
									controlID = "Button_liwu_Image_bg_Panel_base_Panel-newCityBagView_Layer1_newCity_Game",
									UUID = "da00adc3_9669_45cd_a521_5792f6e03445",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEButton",
									ClickHighLightEnabled = "True",
									dstBlendFunc = "771",
									flipX = "False",
									flipY = "False",
									height = "90",
									ignoreSize = "True",
									name = "Button_liwu",
									normal = "ui/common/edge_normal.png",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "True",
									UILayoutViewModel = 
									{
										PositionX = 350,
										PositionY = 70,
									},
									UItype = "Button",
									width = "50",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "Label_tittle_Button_liwu_Image_bg_Panel_base_Panel-newCityBagView_Layer1_newCity_Game",
											UUID = "5c12ee10_30e1_4f20_9240_3dfe440e5c9b",
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
											name = "Label_tittle",
											nTextAlign = "1",
											nTextHAlign = "1",
											rotation = "90",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "770",
											text = "ของขวัญ",
											touchAble = "False",
											touchScaleEnable = "False",
											UILayoutViewModel = 
											{
												
											},
											width = "70",
											ZOrder = "1",
										},
									},
								},
								{
									controlID = "Button_cailiao_Image_bg_Panel_base_Panel-newCityBagView_Layer1_newCity_Game",
									UUID = "3fa6ecc5_9300_4191_986a_a340cd1904a5",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEButton",
									ClickHighLightEnabled = "True",
									dstBlendFunc = "771",
									flipX = "False",
									flipY = "False",
									height = "90",
									ignoreSize = "True",
									name = "Button_cailiao",
									normal = "ui/common/edge_normal.png",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "True",
									UILayoutViewModel = 
									{
										PositionX = 350,
										PositionY = -32,
									},
									UItype = "Button",
									width = "50",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "Label_tittle_Button_cailiao_Image_bg_Panel_base_Panel-newCityBagView_Layer1_newCity_Game",
											UUID = "e4c6dbe7_d2a6_4e8a_b1ee_730ab53267eb",
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
											name = "Label_tittle",
											nTextAlign = "1",
											nTextHAlign = "1",
											rotation = "90",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "770",
											text = "วัสดุ",
											touchAble = "False",
											touchScaleEnable = "False",
											UILayoutViewModel = 
											{
												
											},
											width = "34",
											ZOrder = "1",
										},
									},
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
			"ui/common/pop_ui/pop_bg_01.png",
			"ui/common/pop_ui/pop_ui_02.png",
			"ui/common/pop_ui/pop_btn_02.png",
			"ui/common/pop_ui/pop_bg_02.png",
			"ui/common/edge_normal.png",
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

