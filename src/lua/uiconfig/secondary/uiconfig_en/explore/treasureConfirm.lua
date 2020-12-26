local t = 
{
	version = 1,
	components = 
	{
		
		{
			controlID = "Panel-treasureConfirm_Layer1_explore_Game",
			UUID = "46116cff_a71f_4cfd_8541_0b00c7a5d827",
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
					controlID = "Panel_root_Panel-treasureConfirm_Layer1_explore_Game",
					UUID = "ce08447f_f029_4512_88c3_b22dad0020d9",
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
						PositionY = 34,
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
							controlID = "Image_bg_Panel_root_Panel-treasureConfirm_Layer1_explore_Game",
							UUID = "c4cc866a_6e31_44f4_b43d_030f853e0a44",
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
									controlID = "Image_inner_Image_bg_Panel_root_Panel-treasureConfirm_Layer1_explore_Game",
									UUID = "966040d1_c360_49d0_8d33_f5be2120bdf2",
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
									controlID = "Label_title_Image_bg_Panel_root_Panel-treasureConfirm_Layer1_explore_Game",
									UUID = "a59ae518_839b_4ba1_850b_e91e7a148841",
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
									text = "Choose treasure",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionX = -350,
										PositionY = 181,
									},
									width = "116",
									ZOrder = "1",
								},
								{
									controlID = "ScrollView_treasure_Image_bg_Panel_root_Panel-treasureConfirm_Layer1_explore_Game",
									UUID = "d24cae49_3fb8_4f5f_99a1_afc684aa96fc",
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
									innerWidth = "710",
									name = "ScrollView_treasure",
									showScrollbar = "False",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "True",
									UILayoutViewModel = 
									{
										PositionX = -359,
										PositionY = -196,
									},
									uipanelviewmodel = 
									{
										Layout="Absolute",
										nType = "0"
									},
									width = "710",
									ZOrder = "1",
								},
								{
									controlID = "Image_item_bg_Image_bg_Panel_root_Panel-treasureConfirm_Layer1_explore_Game",
									UUID = "e9f40825_5345_4580_9f22_55d43dcffc02",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "114",
									ignoreSize = "True",
									name = "Image_item_bg",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/explore/pop/nei.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = -182,
										PositionY = -630,
									},
									width = "347",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "icon_Image_item_bg_Image_bg_Panel_root_Panel-treasureConfirm_Layer1_explore_Game",
											UUID = "f3ea4e5b_d555_432f_bbe2_e69e10db3862",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											classname = "MEImage",
											dstBlendFunc = "771",
											height = "110",
											ignoreSize = "True",
											name = "icon",
											scaleX = "0.7",
											scaleY = "0.7",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											texturePath = "ui/common/frame_green.png",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = -123,
												PositionY = -5,
											},
											width = "110",
											ZOrder = "1",
										},
										{
											controlID = "Image_not_fit_Image_item_bg_Image_bg_Panel_root_Panel-treasureConfirm_Layer1_explore_Game",
											UUID = "dfed79a2_a3fe_4735_aa8a_3f95a97164e3",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											classname = "MEImage",
											dstBlendFunc = "771",
											height = "29",
											ignoreSize = "True",
											name = "Image_not_fit",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											texturePath = "ui/explore/pop/not1.png",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 105,
												PositionY = 36,
											},
											visible = "False",
											width = "124",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "Label_fit_Image_not_fit_Image_item_bg_Image_bg_Panel_root_Panel-treasureConfirm_Layer1_explore_Game",
													UUID = "3c6aa055_a3ba_418d_b8be_10c9face73d4",
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
													name = "Label_fit",
													nTextAlign = "1",
													nTextHAlign = "1",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "770",
													text = "Conditions do not match",
													touchAble = "False",
													touchScaleEnable = "False",
													UILayoutViewModel = 
													{
														PositionX = 10,
													},
													width = "83",
													ZOrder = "1",
												},
												{
													controlID = "Image_fit_Image_not_fit_Image_item_bg_Image_bg_Panel_root_Panel-treasureConfirm_Layer1_explore_Game",
													UUID = "274d1c5d_f118_444b_b736_0f058519ff0e",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0.5",
													backGroundScale9Enable = "False",
													classname = "MEImage",
													dstBlendFunc = "771",
													height = "7",
													ignoreSize = "True",
													name = "Image_fit",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "1",
													texturePath = "ui/explore/pop/noy2.png",
													touchAble = "False",
													UILayoutViewModel = 
													{
														PositionX = -228,
														PositionY = 13,
													},
													width = "71",
													ZOrder = "1",
												},
											},
										},
										{
											controlID = "Image_fit_Image_item_bg_Image_bg_Panel_root_Panel-treasureConfirm_Layer1_explore_Game",
											UUID = "cc1739f3_5305_4a8e_b392_bf066a7a5a87",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											classname = "MEImage",
											dstBlendFunc = "771",
											height = "29",
											ignoreSize = "True",
											name = "Image_fit",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											texturePath = "ui/explore/pop/show1.png",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 105,
												PositionY = 35,
											},
											width = "124",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "Label_fit_Image_fit_Image_item_bg_Image_bg_Panel_root_Panel-treasureConfirm_Layer1_explore_Game",
													UUID = "caf8026b_5aa0_41b4_b166_7fd66041815c",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0.5",
													classname = "MELabel",
													compPath = "luacomponents.common.MEIconLabel",
													dstBlendFunc = "771",
													FontColor = "#FF5168BC",
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
													name = "Label_fit",
													nTextAlign = "1",
													nTextHAlign = "1",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "770",
													text = "Displayable",
													touchAble = "False",
													touchScaleEnable = "False",
													UILayoutViewModel = 
													{
														PositionX = 10,
													},
													width = "63",
													ZOrder = "1",
												},
												{
													controlID = "Image_fit_Image_fit_Image_item_bg_Image_bg_Panel_root_Panel-treasureConfirm_Layer1_explore_Game",
													UUID = "bf555722_580a_4d7f_847f_bc2602cdc4b9",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0.5",
													backGroundScale9Enable = "False",
													classname = "MEImage",
													dstBlendFunc = "771",
													height = "7",
													ignoreSize = "True",
													name = "Image_fit",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "1",
													texturePath = "ui/explore/pop/show2.png",
													touchAble = "False",
													UILayoutViewModel = 
													{
														PositionX = -228,
														PositionY = 13,
													},
													width = "69",
													ZOrder = "1",
												},
											},
										},
										{
											controlID = "Label_name_Image_item_bg_Image_bg_Panel_root_Panel-treasureConfirm_Layer1_explore_Game",
											UUID = "aa7844b0_8631_4eae_bd48_f34311aa0c9d",
											anchorPoint = "False",
											anchorPointX = "0",
											anchorPointY = "0.5",
											classname = "MELabel",
											compPath = "luacomponents.common.MEIconLabel",
											dstBlendFunc = "771",
											FontColor = "#FF4B508F",
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
											name = "Label_name",
											nTextAlign = "1",
											nTextHAlign = "1",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "770",
											text = "Displayable",
											touchAble = "False",
											touchScaleEnable = "False",
											UILayoutViewModel = 
											{
												PositionX = -81,
												PositionY = 8,
											},
											width = "63",
											ZOrder = "1",
										},
									},
								},
								{
									controlID = "Button_close_Image_bg_Panel_root_Panel-treasureConfirm_Layer1_explore_Game",
									UUID = "7b19e70d_415d_4f56_a9d6_b1b8dfdb68bf",
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
										PositionX = 336,
										PositionY = 183,
									},
									UItype = "Button",
									width = "60",
									ZOrder = "1",
								},
								{
									controlID = "Label_treasure_tip_Image_bg_Panel_root_Panel-treasureConfirm_Layer1_explore_Game",
									UUID = "1bb0eb54_ffde_41a1_9c76_779298382cc6",
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
									fontSize = "28",
									fontStroke = 
									{
										IsStroke = false,
										StrokeColor = "#FFE6E6E6",
										StrokeSize = 1,
									},
									height = "35",
									ignoreSize = "True",
									name = "Label_treasure_tip",
									nTextAlign = "1",
									nTextHAlign = "1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "No treasure yet",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										
									},
									width = "224",
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
			"ui/explore/pop/inner.png",
			"ui/explore/pop/nei.png",
			"ui/common/frame_green.png",
			"ui/explore/pop/not1.png",
			"ui/explore/pop/noy2.png",
			"ui/explore/pop/show1.png",
			"ui/explore/pop/show2.png",
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

