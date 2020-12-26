local t = 
{
	version = 1,
	components = 
	{
		
		{
			controlID = "Panel-exploreAwardView_Layer1_explore_Game",
			UUID = "d0a9b0da_76f6_4ecc_984b_9bd44479ed57",
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
					controlID = "Panel_root_Panel-exploreAwardView_Layer1_explore_Game",
					UUID = "965f7a2f_8957_4132_8a2e_a4a235cf1e58",
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
					touchAble = "False",
					UILayoutViewModel = 
					{
						PositionX = -58,
						PositionY = 39,
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
							controlID = "Image_bg_Panel_root_Panel-exploreAwardView_Layer1_explore_Game",
							UUID = "dc094cc9_513b_4d96_9d53_a10ea33345da",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							backGroundScale9Enable = "False",
							classname = "MEImage",
							dstBlendFunc = "771",
							height = "428",
							ignoreSize = "True",
							name = "Image_bg",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							texturePath = "ui/explore/pop/bg2.png",
							touchAble = "False",
							UILayoutViewModel = 
							{
								PositionX = 568,
								PositionY = 320,
							},
							width = "739",
							ZOrder = "1",
							components = 
							{
								
								{
									controlID = "Image_time_bg_Image_bg_Panel_root_Panel-exploreAwardView_Layer1_explore_Game",
									UUID = "31bf37f0_c357_4b4e_a9d2_baf34cce42fb",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "50",
									ignoreSize = "True",
									name = "Image_time_bg",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/explore/pop/time.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = 2,
										PositionY = 136,
									},
									width = "720",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "Label_time_tip_Image_time_bg_Image_bg_Panel_root_Panel-exploreAwardView_Layer1_explore_Game",
											UUID = "66bd5a51_d679_4168_b5f4_109ec45402ec",
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
											fontSize = "20",
											fontStroke = 
											{
												IsStroke = false,
												StrokeColor = "#FFE6E6E6",
												StrokeSize = 1,
											},
											height = "23",
											ignoreSize = "True",
											name = "Label_time_tip",
											nTextAlign = "1",
											nTextHAlign = "1",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "770",
											text = "当前累积收益次数：",
											touchAble = "False",
											touchScaleEnable = "False",
											UILayoutViewModel = 
											{
												PositionX = -352,
											},
											width = "170",
											ZOrder = "1",
										},
										{
											controlID = "Label_explore_time_Image_time_bg_Image_bg_Panel_root_Panel-exploreAwardView_Layer1_explore_Game",
											UUID = "a862093a_1a57_462a_993f_17a39d126c49",
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
											fontSize = "20",
											fontStroke = 
											{
												IsStroke = false,
												StrokeColor = "#FFE6E6E6",
												StrokeSize = 1,
											},
											height = "23",
											ignoreSize = "True",
											name = "Label_explore_time",
											nTextAlign = "1",
											nTextHAlign = "1",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "770",
											text = "探索时长",
											touchAble = "False",
											touchScaleEnable = "False",
											UILayoutViewModel = 
											{
												PositionX = -180,
											},
											width = "83",
											ZOrder = "1",
										},
										{
											controlID = "Label_speed_tip_Image_time_bg_Image_bg_Panel_root_Panel-exploreAwardView_Layer1_explore_Game",
											UUID = "bcc647e7_096c_4511_9d27_1bbc7452cd02",
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
											fontSize = "20",
											fontStroke = 
											{
												IsStroke = false,
												StrokeColor = "#FFE6E6E6",
												StrokeSize = 1,
											},
											height = "23",
											ignoreSize = "True",
											name = "Label_speed_tip",
											nTextAlign = "1",
											nTextHAlign = "1",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "770",
											text = "单次收益获得频率：",
											touchAble = "False",
											touchScaleEnable = "False",
											UILayoutViewModel = 
											{
												PositionX = 8,
											},
											width = "170",
											ZOrder = "1",
										},
										{
											controlID = "Label_speed_Image_time_bg_Image_bg_Panel_root_Panel-exploreAwardView_Layer1_explore_Game",
											UUID = "5a399800_2ff2_46e0_bc85_78a0b7ec11d9",
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
											fontSize = "20",
											fontStroke = 
											{
												IsStroke = false,
												StrokeColor = "#FFE6E6E6",
												StrokeSize = 1,
											},
											height = "23",
											ignoreSize = "True",
											name = "Label_speed",
											nTextAlign = "1",
											nTextHAlign = "1",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "770",
											text = "220",
											touchAble = "False",
											touchScaleEnable = "False",
											UILayoutViewModel = 
											{
												PositionX = 180,
											},
											width = "36",
											ZOrder = "1",
										},
									},
								},
								{
									controlID = "Label_title_Image_bg_Panel_root_Panel-exploreAwardView_Layer1_explore_Game",
									UUID = "aefb3e8d_1e4c_492b_8fd4_2a71d1a1aaa7",
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
									name = "Label_title",
									nTextAlign = "1",
									nTextHAlign = "1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "探索掉落",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionX = -304,
										PositionY = 177,
									},
									width = "107",
									ZOrder = "1",
								},
								{
									controlID = "ScrollView_drop_Image_bg_Panel_root_Panel-exploreAwardView_Layer1_explore_Game",
									UUID = "11f696db_598f_4510_a925_efdf77fd83dd",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									bgColorOpacity = "50",
									bIsOpenClipping = "True",
									bounceEnable = "False",
									classname = "MEScrollView",
									colorType = "0;SingleColor:#FF000000;GraduallyChangingColorStart:#FFFFFFFF;GraduallyChangingColorEnd:#FFFFFFFF;vectorX:0;vectorY:0",
									direction = "1",
									dstBlendFunc = "771",
									height = "210",
									ignoreSize = "False",
									innerHeight = "210",
									innerWidth = "705",
									name = "ScrollView_drop",
									showScrollbar = "False",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "True",
									UILayoutViewModel = 
									{
										PositionX = 2,
										PositionY = -33,
									},
									uipanelviewmodel = 
									{
										Layout="Absolute",
										nType = "0"
									},
									width = "705",
									ZOrder = "1",
								},
								{
									controlID = "Button_close_Image_bg_Panel_root_Panel-exploreAwardView_Layer1_explore_Game",
									UUID = "02f51417_ea44_4ed9_9e8e_a80fc2278063",
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
										PositionX = 338,
										PositionY = 184,
									},
									UItype = "Button",
									width = "60",
									ZOrder = "1",
								},
								{
									controlID = "Image_split_Image_bg_Panel_root_Panel-exploreAwardView_Layer1_explore_Game",
									UUID = "44eb2407_bedb_4e59_a1a9_8c56b429ad6a",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "26",
									ignoreSize = "True",
									name = "Image_split",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									texturePath = "ui/explore/pop/split.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = -244,
										PositionY = 179,
									},
									width = "2",
									ZOrder = "1",
								},
								{
									controlID = "Label_title_en_Image_bg_Panel_root_Panel-exploreAwardView_Layer1_explore_Game",
									UUID = "33e81f32_4380_4548_9cfb_6a367313a31d",
									anchorPoint = "False",
									anchorPointX = "0.5",
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
									height = "23",
									ignoreSize = "True",
									name = "Label_title_en",
									nTextAlign = "1",
									nTextHAlign = "1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "Drop",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionX = -215,
										PositionY = 177,
									},
									width = "44",
									ZOrder = "1",
								},
								{
									controlID = "Image_infobg_Image_bg_Panel_root_Panel-exploreAwardView_Layer1_explore_Game",
									UUID = "638b0f11_400c_49a0_8a84_1b4286f241fa",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "35",
									ignoreSize = "True",
									name = "Image_infobg",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/explore/pop/title1.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = -115,
										PositionY = 92,
									},
									width = "490",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "Label_tip_Image_infobg_Image_bg_Panel_root_Panel-exploreAwardView_Layer1_explore_Game",
											UUID = "ab879f36_6b29_4c47_b83a_44f70025898b",
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
											height = "25",
											ignoreSize = "True",
											name = "Label_tip",
											nTextAlign = "1",
											nTextHAlign = "1",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "770",
											text = "获得收益",
											touchAble = "False",
											touchScaleEnable = "False",
											UILayoutViewModel = 
											{
												PositionX = -220,
											},
											width = "91",
											ZOrder = "1",
										},
									},
								},
								{
									controlID = "Button_get_Image_bg_Panel_root_Panel-exploreAwardView_Layer1_explore_Game",
									UUID = "8ff54ac8_838f_4b06_a3d0_d2591cb3932c",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEButton",
									ClickHighLightEnabled = "True",
									dstBlendFunc = "771",
									flipX = "False",
									flipY = "False",
									height = "50",
									ignoreSize = "False",
									name = "Button_get",
									normal = "ui/common/button_big_n.png",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "True",
									UILayoutViewModel = 
									{
										PositionX = 290,
										PositionY = -171,
									},
									UItype = "Button",
									width = "120",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "Label_btn_Button_get_Image_bg_Panel_root_Panel-exploreAwardView_Layer1_explore_Game",
											UUID = "c89b47d8_e929_4356_a382_422587f19d22",
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
											name = "Label_btn",
											nTextAlign = "1",
											nTextHAlign = "1",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "770",
											text = "領取",
											touchAble = "False",
											touchScaleEnable = "False",
											UILayoutViewModel = 
											{
												
											},
											width = "43",
											ZOrder = "1",
										},
									},
								},
								{
									controlID = "Label_fulltip_Image_bg_Panel_root_Panel-exploreAwardView_Layer1_explore_Game",
									UUID = "9f53a0b3_8bf6_488e_8a99_422f11516472",
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
									fontSize = "28",
									fontStroke = 
									{
										IsStroke = false,
										StrokeColor = "#FFE6E6E6",
										StrokeSize = 1,
									},
									height = "32",
									ignoreSize = "True",
									name = "Label_fulltip",
									nTextAlign = "1",
									nTextHAlign = "1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "当前没有获得收益",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionX = 2,
										PositionY = -14,
									},
									width = "227",
									ZOrder = "1",
								},
								{
									controlID = "Panel_item_Image_bg_Panel_root_Panel-exploreAwardView_Layer1_explore_Game",
									UUID = "83cda493_d6da_48e4_970a_5ac257bbbcca",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									bgColorOpacity = "50",
									bIsOpenClipping = "False",
									classname = "MEPanel",
									colorType = "0;SingleColor:#FFFF0000;GraduallyChangingColorStart:#FFFFFFFF;GraduallyChangingColorEnd:#FFFFFFFF;vectorX:0;vectorY:0",
									DesignHeight = "640",
									DesignType = "0",
									DesignWidth = "960",
									dstBlendFunc = "771",
									height = "88",
									ignoreSize = "False",
									name = "Panel_item",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = -154,
										PositionY = -281,
									},
									uipanelviewmodel = 
									{
										Layout="Absolute",
										nType = "0"
									},
									width = "88",
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
			"ui/explore/pop/bg2.png",
			"ui/explore/pop/time.png",
			"ui/common/pop_ui/pop_btn_02.png",
			"ui/explore/pop/split.png",
			"ui/explore/pop/title1.png",
			"ui/common/button_big_n.png",
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

