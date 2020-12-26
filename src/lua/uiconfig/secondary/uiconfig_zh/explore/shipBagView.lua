local t = 
{
	version = 1,
	components = 
	{
		
		{
			controlID = "Panel-shipBagView_flyShipGrowUp_explore_Game",
			UUID = "981666ea_f991_4ac2_bd2c_1ae62df3d903",
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
					controlID = "Panel_root_Panel-shipBagView_flyShipGrowUp_explore_Game",
					UUID = "963b273d_aca8_4223_b670_ab0ada639baf",
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
						PositionX = -88,
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
							controlID = "Image_bg_Panel_root_Panel-shipBagView_flyShipGrowUp_explore_Game",
							UUID = "1af2df74_9e3c_4526_ba01_67f41cee353c",
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
							touchAble = "True",
							UILayoutViewModel = 
							{
								PositionX = 568,
								PositionY = 320,
								IsPercent = true,
								PercentX = 50,
								PercentY = 50,
							},
							width = "739",
							ZOrder = "1",
							components = 
							{
								
								{
									controlID = "Image_inner_Image_bg_Panel_root_Panel-shipBagView_flyShipGrowUp_explore_Game",
									UUID = "02ccd918_784c_4813_ad3a_e4fb91b1e380",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "352",
									ignoreSize = "True",
									name = "Image_inner",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									texturePath = "ui/explore/pop/inner.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionY = -17,
									},
									width = "721",
									ZOrder = "1",
								},
								{
									controlID = "Label_title_Image_bg_Panel_root_Panel-shipBagView_flyShipGrowUp_explore_Game",
									UUID = "99dc24f0_954a_416e_8a06_d0b8f8b02a9b",
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
									name = "Label_title",
									nTextAlign = "1",
									nTextHAlign = "1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "飞舰背包",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionX = -351,
										PositionY = 182,
									},
									width = "114",
									ZOrder = "1",
								},
								{
									controlID = "ScrollView_item_Image_bg_Panel_root_Panel-shipBagView_flyShipGrowUp_explore_Game",
									UUID = "74880739_07d7_4442_9da9_0f86f41da4c2",
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
									height = "350",
									ignoreSize = "False",
									innerHeight = "350",
									innerWidth = "510",
									name = "ScrollView_item",
									showScrollbar = "False",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "True",
									UILayoutViewModel = 
									{
										PositionX = -360,
										PositionY = -193,
									},
									uipanelviewmodel = 
									{
										Layout="Absolute",
										nType = "0"
									},
									width = "510",
									ZOrder = "1",
								},
								{
									controlID = "Image_left_Image_bg_Panel_root_Panel-shipBagView_flyShipGrowUp_explore_Game",
									UUID = "8bf55073_faeb_48f2_b21f_d5c3ea55a030",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "True;capInsetsX:0;capInsetsY:0;capInsetsWidth:0;capInsetsHeight:0",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "350",
									ignoreSize = "False",
									name = "Image_left",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/explore/pop/5.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = 255,
										PositionY = -16,
									},
									width = "205",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "Image_info_Image_left_Image_bg_Panel_root_Panel-shipBagView_flyShipGrowUp_explore_Game",
											UUID = "8ab64994_e405_4208_b38e_2c795553785e",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											classname = "MEImage",
											dstBlendFunc = "771",
											height = "34",
											ignoreSize = "True",
											name = "Image_info",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											texturePath = "ui/explore/pop/title2.png",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 16,
												PositionY = 157,
											},
											width = "235",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "Label_Name_Image_info_Image_left_Image_bg_Panel_root_Panel-shipBagView_flyShipGrowUp_explore_Game",
													UUID = "2923da9e_21c3_4191_bc04_b7c7f13acf8f",
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
													height = "0",
													ignoreSize = "True",
													name = "Label_Name",
													nTextAlign = "1",
													nTextHAlign = "1",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "770",
													text = "23",
													touchAble = "False",
													touchScaleEnable = "False",
													UILayoutViewModel = 
													{
														PositionX = -92,
														PositionY = -1,
													},
													width = "0",
													ZOrder = "1",
												},
											},
										},
										{
											controlID = "Label_desc_Image_left_Image_bg_Panel_root_Panel-shipBagView_flyShipGrowUp_explore_Game",
											UUID = "a1e09a70_5b66_4f0f_9038_9c1c6de77f85",
											anchorPoint = "False",
											anchorPointX = "0",
											anchorPointY = "1",
											classname = "MELabel",
											compPath = "luacomponents.common.MEIconLabel",
											dstBlendFunc = "771",
											FontColor = "#FF4B4E86",
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
											ignoreSize = "False",
											name = "Label_desc",
											nTextAlign = "0",
											nTextHAlign = "0",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "770",
											text = "23",
											touchAble = "False",
											touchScaleEnable = "False",
											UILayoutViewModel = 
											{
												PositionX = -93,
												PositionY = 133,
											},
											width = "190",
											ZOrder = "1",
										},
									},
								},
								{
									controlID = "Panel_item_Image_bg_Panel_root_Panel-shipBagView_flyShipGrowUp_explore_Game",
									UUID = "1914fc1c_2b9d_4160_94b1_ef17fdfd27f2",
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
									height = "85",
									ignoreSize = "False",
									name = "Panel_item",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "True",
									UILayoutViewModel = 
									{
										PositionX = -420,
										PositionY = -453,
									},
									uipanelviewmodel = 
									{
										Layout="Absolute",
										nType = "0"
									},
									width = "85",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "Image_icon_Panel_item_Image_bg_Panel_root_Panel-shipBagView_flyShipGrowUp_explore_Game",
											UUID = "6482766b_627c_4a30_a2cc_27533fb1ef86",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											classname = "MEImage",
											dstBlendFunc = "771",
											height = "77",
											ignoreSize = "False",
											name = "Image_icon",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											texturePath = "ui/common/frame_yellow.png",
											touchAble = "False",
											UILayoutViewModel = 
											{
												
											},
											width = "77",
											ZOrder = "1",
										},
										{
											controlID = "Image_select_Panel_item_Image_bg_Panel_root_Panel-shipBagView_flyShipGrowUp_explore_Game",
											UUID = "e126efb3_afeb_4fe0_bf93_20b7cb073076",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											classname = "MEImage",
											dstBlendFunc = "771",
											height = "132",
											ignoreSize = "True",
											name = "Image_select",
											scaleX = "0.7",
											scaleY = "0.7",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											texturePath = "ui/common/select.png",
											touchAble = "False",
											UILayoutViewModel = 
											{
												
											},
											width = "132",
											ZOrder = "1",
										},
									},
								},
							},
						},
						{
							controlID = "Button_close_Panel_root_Panel-shipBagView_flyShipGrowUp_explore_Game",
							UUID = "b257befe_6a74_4eac_af31_cdf10fd039df",
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
								PositionX = 909,
								PositionY = 502,
							},
							UItype = "Button",
							width = "60",
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
			"ui/explore/pop/bg2.png",
			"ui/explore/pop/inner.png",
			"ui/explore/pop/5.png",
			"ui/explore/pop/title2.png",
			"ui/common/frame_yellow.png",
			"ui/common/select.png",
			"ui/common/pop_ui/pop_btn_02.png",
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

