local t = 
{
	version = 1,
	components = 
	{
		
		{
			controlID = "Panel-kuangsanAssistRewardView_kuangsanAssist_activity_Game",
			UUID = "3527595e_0461_4003_99b6_5bc897ab5a42",
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
					controlID = "Panel_base_Panel-kuangsanAssistRewardView_kuangsanAssist_activity_Game",
					UUID = "581a38cb_c8da_41be_b0ef_a12326c75e31",
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
							controlID = "Image_bg_Panel_base_Panel-kuangsanAssistRewardView_kuangsanAssist_activity_Game",
							UUID = "1a6f32ce_332c_468a_b64f_122814f1cfeb",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							backGroundScale9Enable = "False",
							classname = "MEImage",
							dstBlendFunc = "771",
							height = "561",
							ignoreSize = "True",
							name = "Image_bg",
							sizepercentx = "100",
							sizepercenty = "100",
							sizeType = "0",
							srcBlendFunc = "1",
							texturePath = "ui/activity/assist/kuangsan/tip_bg.png",
							touchAble = "True",
							UILayoutViewModel = 
							{
								PositionX = 533,
								PositionY = 359,
								IsPercent = true,
								PercentX = 46.92,
								PercentY = 56.09,
								LeftPositon = 118,
								TopPosition = 70,
							},
							width = "1061",
							ZOrder = "1",
							components = 
							{
								
								{
									controlID = "Label_tittle_Image_bg_Panel_base_Panel-kuangsanAssistRewardView_kuangsanAssist_activity_Game",
									UUID = "985a87f6_9c8a_432c_85b3_4a68001d76b9",
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
									fontSize = "28",
									fontStroke = 
									{
										IsStroke = false,
										StrokeColor = "#FFE6E6E6",
										StrokeSize = 1,
									},
									height = "35",
									ignoreSize = "True",
									name = "Label_tittle",
									nTextAlign = "1",
									nTextHAlign = "1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "Vista previa de recompensas",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionX = -220,
										PositionY = 151,
									},
									width = "115",
									ZOrder = "1",
								},
								{
									controlID = "Button_close_Image_bg_Panel_base_Panel-kuangsanAssistRewardView_kuangsanAssist_activity_Game",
									UUID = "b278c2a8_4e54_44ed_992b_6da0c4f8bf2d",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEButton",
									ClickHighLightEnabled = "True",
									dstBlendFunc = "771",
									flipX = "False",
									flipY = "False",
									height = "30",
									ignoreSize = "True",
									name = "Button_close",
									normal = "ui/activity/assist/kuangsan/guanbi.png",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "True",
									UILayoutViewModel = 
									{
										PositionX = 472,
										PositionY = 150,
									},
									UItype = "Button",
									width = "30",
									ZOrder = "1",
								},
								{
									controlID = "Image_infoBg_Image_bg_Panel_base_Panel-kuangsanAssistRewardView_kuangsanAssist_activity_Game",
									UUID = "05244c39_6a8b_4813_9a76_5a8e7dbe4969",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "428",
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
										PositionX = 68,
										PositionY = -79,
									},
									visible = "False",
									width = "975",
									ZOrder = "1",
								},
								{
									controlID = "Button_rank_Image_bg_Panel_base_Panel-kuangsanAssistRewardView_kuangsanAssist_activity_Game",
									UUID = "40b908da_1452_4a57_885d_e359d78501f4",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEButton",
									ClickHighLightEnabled = "True",
									dstBlendFunc = "771",
									flipX = "False",
									flipY = "False",
									height = "200",
									ignoreSize = "True",
									name = "Button_rank",
									normal = "ui/activity/assist/kuangsan/tip_002.png",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "True",
									UILayoutViewModel = 
									{
										PositionX = -201,
										PositionY = 38,
									},
									UItype = "Button",
									width = "64",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "Label_rank_name_Button_rank_Image_bg_Panel_base_Panel-kuangsanAssistRewardView_kuangsanAssist_activity_Game",
											UUID = "f6287e1b_0994_4422_bd1d_c98f1fcf6011",
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
											height = "120",
											ignoreSize = "False",
											name = "Label_rank_name",
											nTextAlign = "1",
											nTextHAlign = "1",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "770",
											text = "Recompensa de clasificación",
											touchAble = "False",
											touchScaleEnable = "False",
											UILayoutViewModel = 
											{
												
											},
											width = "30",
											ZOrder = "1",
										},
									},
								},
								{
									controlID = "Button_pic_Image_bg_Panel_base_Panel-kuangsanAssistRewardView_kuangsanAssist_activity_Game",
									UUID = "0a0586bc_f1f0_48b3_aa26_5d180f911f1b",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEButton",
									ClickHighLightEnabled = "True",
									dstBlendFunc = "771",
									flipX = "False",
									flipY = "False",
									height = "200",
									ignoreSize = "True",
									name = "Button_pic",
									normal = "ui/activity/assist/kuangsan/tip_001.png",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "True",
									UILayoutViewModel = 
									{
										PositionX = -201,
										PositionY = -146,
									},
									UItype = "Button",
									width = "64",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "Label_pic_name_Button_pic_Image_bg_Panel_base_Panel-kuangsanAssistRewardView_kuangsanAssist_activity_Game",
											UUID = "c6d326e0_15c4_4911_9e8d_ae873395bbcf",
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
											height = "120",
											ignoreSize = "False",
											name = "Label_pic_name",
											nTextAlign = "1",
											nTextHAlign = "1",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "770",
											text = "Recompensa de rompecabezas",
											touchAble = "False",
											touchScaleEnable = "False",
											UILayoutViewModel = 
											{
												
											},
											width = "30",
											ZOrder = "1",
										},
									},
								},
								{
									controlID = "Image_top_bg_Image_bg_Panel_base_Panel-kuangsanAssistRewardView_kuangsanAssist_activity_Game",
									UUID = "74fd767a_5c3c_4492_a124_6436def70e4c",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "32",
									ignoreSize = "True",
									name = "Image_top_bg",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/activity/assist/kuangsan/tip_004.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = 160,
										PositionY = 114,
									},
									width = "664",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "Label_title1_Image_top_bg_Image_bg_Panel_base_Panel-kuangsanAssistRewardView_kuangsanAssist_activity_Game",
											UUID = "16bfff47_5632_462e_8451_121c59568b46",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											classname = "MELabel",
											compPath = "luacomponents.common.MEIconLabel",
											dstBlendFunc = "771",
											FontColor = "#FFFFFFFF",
											fontName = "phanta.ttf",
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
											height = "20",
											ignoreSize = "True",
											name = "Label_title1",
											nTextAlign = "1",
											nTextHAlign = "1",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "770",
											text = "Introducción",
											touchAble = "False",
											touchScaleEnable = "False",
											UILayoutViewModel = 
											{
												PositionX = -203,
											},
											width = "39",
											ZOrder = "1",
										},
										{
											controlID = "Button_line_Image_top_bg_Image_bg_Panel_base_Panel-kuangsanAssistRewardView_kuangsanAssist_activity_Game",
											UUID = "89a132f5_a0a4_4a9e_a850_0cb15ab3af45",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											classname = "MEButton",
											ClickHighLightEnabled = "True",
											dstBlendFunc = "771",
											flipX = "False",
											flipY = "False",
											height = "20",
											ignoreSize = "True",
											name = "Button_line",
											normal = "ui/activity/assist/kuangsan/tip_005.png",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "True",
											UILayoutViewModel = 
											{
												PositionX = -60,
											},
											UItype = "Button",
											width = "2",
											ZOrder = "1",
										},
										{
											controlID = "Label_title2_Image_top_bg_Image_bg_Panel_base_Panel-kuangsanAssistRewardView_kuangsanAssist_activity_Game",
											UUID = "e0ed9887_22ed_4cb7_9586_4faa2d3f164e",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											classname = "MELabel",
											compPath = "luacomponents.common.MEIconLabel",
											dstBlendFunc = "771",
											FontColor = "#FFFFFFFF",
											fontName = "phanta.ttf",
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
											height = "20",
											ignoreSize = "True",
											name = "Label_title2",
											nTextAlign = "1",
											nTextHAlign = "1",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "770",
											text = "Recompensa",
											touchAble = "False",
											touchScaleEnable = "False",
											UILayoutViewModel = 
											{
												PositionX = 170,
											},
											width = "39",
											ZOrder = "1",
										},
									},
								},
								{
									controlID = "ScrollView_rank_Image_bg_Panel_base_Panel-kuangsanAssistRewardView_kuangsanAssist_activity_Game",
									UUID = "bad22693_ffe1_4ccd_9f1d_30bfa91ab528",
									anchorPoint = "False",
									anchorPointX = "0",
									anchorPointY = "0",
									backGroundScale9Enable = "False",
									bgColorOpacity = "50",
									bIsOpenClipping = "True",
									bounceEnable = "True",
									classname = "MEScrollView",
									colorType = "0;SingleColor:#FFE6E6E6;GraduallyChangingColorStart:#FFFFFFFF;GraduallyChangingColorEnd:#FFFFFFFF;vectorX:0;vectorY:0",
									direction = "1",
									dstBlendFunc = "771",
									height = "333",
									ignoreSize = "False",
									innerHeight = "333",
									innerWidth = "666",
									name = "ScrollView_rank",
									showScrollbar = "False",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "True",
									UILayoutViewModel = 
									{
										PositionX = -174,
										PositionY = -234,
									},
									uipanelviewmodel = 
									{
										Layout="Absolute",
										nType = "0"
									},
									width = "666",
									ZOrder = "1",
								},
								{
									controlID = "ScrollView_pic_Image_bg_Panel_base_Panel-kuangsanAssistRewardView_kuangsanAssist_activity_Game",
									UUID = "43a10623_bd2b_45d6_8d25_019a762ae65b",
									anchorPoint = "False",
									anchorPointX = "0",
									anchorPointY = "0",
									backGroundScale9Enable = "False",
									bgColorOpacity = "50",
									bIsOpenClipping = "True",
									bounceEnable = "True",
									classname = "MEScrollView",
									colorType = "0;SingleColor:#FFE6E6E6;GraduallyChangingColorStart:#FFFFFFFF;GraduallyChangingColorEnd:#FFFFFFFF;vectorX:0;vectorY:0",
									direction = "1",
									dstBlendFunc = "771",
									height = "333",
									ignoreSize = "False",
									innerHeight = "333",
									innerWidth = "666",
									name = "ScrollView_pic",
									showScrollbar = "False",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "True",
									UILayoutViewModel = 
									{
										PositionX = -174,
										PositionY = -234,
									},
									uipanelviewmodel = 
									{
										Layout="Absolute",
										nType = "0"
									},
									width = "666",
									ZOrder = "1",
								},
							},
						},
						{
							controlID = "Panel_reward_item_Panel_base_Panel-kuangsanAssistRewardView_kuangsanAssist_activity_Game",
							UUID = "eccc769c_b87d_4e27_a9e3_e188edcb3ee7",
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
							height = "84",
							ignoreSize = "False",
							name = "Panel_reward_item",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							touchAble = "False",
							UILayoutViewModel = 
							{
								PositionX = 329,
								PositionY = -300,
							},
							uipanelviewmodel = 
							{
								Layout="Absolute",
								nType = "0"
							},
							width = "664",
							ZOrder = "1",
							components = 
							{
								
								{
									controlID = "Image_bg_Panel_reward_item_Panel_base_Panel-kuangsanAssistRewardView_kuangsanAssist_activity_Game",
									UUID = "2587c759_ea3c_42d8_8e96_43f116f1d1ac",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "84",
									ignoreSize = "True",
									name = "Image_bg",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/activity/assist/kuangsan/tip_007.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = 332,
										PositionY = 42,
									},
									width = "664",
									ZOrder = "1",
								},
								{
									controlID = "Label_desc_Panel_reward_item_Panel_base_Panel-kuangsanAssistRewardView_kuangsanAssist_activity_Game",
									UUID = "7df1038f_b061_4c36_8da2_4aa89777e88b",
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
									fontSize = "20",
									fontStroke = 
									{
										IsStroke = false,
										StrokeColor = "#FFE6E6E6",
										StrokeSize = 1,
									},
									height = "25",
									ignoreSize = "True",
									name = "Label_desc",
									nTextAlign = "1",
									nTextHAlign = "1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "Desbloquea la primera pieza del rompecabezas",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionX = 55,
										PositionY = 42,
									},
									width = "145",
									ZOrder = "5",
								},
								{
									controlID = "Image_fenge_Panel_reward_item_Panel_base_Panel-kuangsanAssistRewardView_kuangsanAssist_activity_Game",
									UUID = "65a8dfcd_a3fb_4f3d_9e0b_87b0187c8cc5",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "54",
									ignoreSize = "True",
									name = "Image_fenge",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/activity/assist/kuangsan/tip_009.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = 270,
										PositionY = 42,
									},
									width = "8",
									ZOrder = "1",
								},
								{
									controlID = "Image_item_bg_Panel_reward_item_Panel_base_Panel-kuangsanAssistRewardView_kuangsanAssist_activity_Game",
									UUID = "1c339692_4ecf_44af_a9d8_ba7e904047d9",
									anchorPoint = "False",
									anchorPointX = "0",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "62",
									ignoreSize = "True",
									name = "Image_item_bg",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/activity/assist/kuangsan/tip_006.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = 380,
										PositionY = 44,
									},
									width = "274",
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
			"ui/activity/assist/kuangsan/tip_bg.png",
			"ui/activity/assist/kuangsan/guanbi.png",
			"ui/common/pop_ui/pop_bg_02.png",
			"ui/activity/assist/kuangsan/tip_002.png",
			"ui/activity/assist/kuangsan/tip_001.png",
			"ui/activity/assist/kuangsan/tip_004.png",
			"ui/activity/assist/kuangsan/tip_005.png",
			"ui/activity/assist/kuangsan/tip_007.png",
			"ui/activity/assist/kuangsan/tip_009.png",
			"ui/activity/assist/kuangsan/tip_006.png",
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

