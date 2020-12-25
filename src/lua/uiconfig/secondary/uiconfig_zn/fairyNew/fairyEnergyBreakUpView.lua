local t = 
{
	version = 1,
	components = 
	{
		
		{
			controlID = "Panel-fairyEnergyBreakUpView_Layer1_fairyNew_Game",
			UUID = "fe4d105d_3296_4bb2_90af_01620ab7dd37",
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
					controlID = "Panel_base_Panel-fairyEnergyBreakUpView_Layer1_fairyNew_Game",
					UUID = "ccd7ad48_3f8b_4e69_b32e_2cc19dc38a9f",
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
							controlID = "background_Panel_base_Panel-fairyEnergyBreakUpView_Layer1_fairyNew_Game",
							UUID = "0d213ed7_c2de_4058_b93e_f8fd6a3a3190",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							backGroundScale9Enable = "False",
							classname = "MEImage",
							dstBlendFunc = "771",
							height = "310",
							ignoreSize = "True",
							name = "background",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							texturePath = "ui/fairy_up/bg.png",
							touchAble = "True",
							UILayoutViewModel = 
							{
								PositionX = 568,
								PositionY = 321,
								IsPercent = true,
								PercentX = 50,
								PercentY = 50.16,
								LeftPositon = -181,
								TopPosition = 140,
								relativeToName = "Panel",
							},
							width = "1082",
							ZOrder = "1",
						},
						{
							controlID = "Panel_back_Panel_base_Panel-fairyEnergyBreakUpView_Layer1_fairyNew_Game",
							UUID = "32d63e5d_c187_4097_bfab_146cea87de9c",
							anchorPoint = "False",
							anchorPointX = "0",
							anchorPointY = "0",
							backGroundScale9Enable = "False",
							bgColorOpacity = "50",
							bIsOpenClipping = "False",
							classname = "MEPanel",
							colorType = "0;SingleColor:#FF000000;GraduallyChangingColorStart:#FFFFFFFF;GraduallyChangingColorEnd:#FFFFFFFF;vectorX:0;vectorY:0",
							DesignHeight = "640",
							DesignType = "0",
							DesignWidth = "960",
							dstBlendFunc = "771",
							height = "640",
							ignoreSize = "False",
							name = "Panel_back",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							touchAble = "False",
							UILayoutViewModel = 
							{
								PositionX = -2,
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
									controlID = "Label_title_Panel_back_Panel_base_Panel-fairyEnergyBreakUpView_Layer1_fairyNew_Game",
									UUID = "bfe5a959_7970_4754_91eb_9c603abf1b96",
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
									name = "Label_title",
									nTextAlign = "1",
									nTextHAlign = "1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "灵力聚合等级上限增加",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionX = 568,
										PositionY = 430,
									},
									width = "222",
									ZOrder = "1",
								},
								{
									controlID = "old_lv_Panel_back_Panel_base_Panel-fairyEnergyBreakUpView_Layer1_fairyNew_Game",
									UUID = "e28d27d9_fe93_4398_a02f_3cb3ef5c5dd3",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									classname = "MELabel",
									compPath = "luacomponents.common.MEIconLabel",
									dstBlendFunc = "771",
									FontColor = "#FFF9DB47",
									fontName = "font/MFLiHei_Noncommercial.ttf",
									fontShadow = 
									{
										IsShadow = false,
										ShadowColor = "#FFFFFFFF",
										ShadowAlpha = 255,
										OffsetX = 0,
										OffsetY = 0,
									},
									fontSize = "44",
									fontStroke = 
									{
										IsStroke = false,
										StrokeColor = "#FFE6E6E6",
										StrokeSize = 1,
									},
									height = "55",
									ignoreSize = "True",
									name = "old_lv",
									nTextAlign = "1",
									nTextHAlign = "1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "LV 25",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionX = 406,
										PositionY = 368,
									},
									width = "150",
									ZOrder = "1",
								},
								{
									controlID = "cur_lv_Panel_back_Panel_base_Panel-fairyEnergyBreakUpView_Layer1_fairyNew_Game",
									UUID = "a06c5f34_9807_420d_9c1b_b812e02700a1",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									classname = "MELabel",
									compPath = "luacomponents.common.MEIconLabel",
									dstBlendFunc = "771",
									FontColor = "#FFF9DB47",
									fontName = "font/MFLiHei_Noncommercial.ttf",
									fontShadow = 
									{
										IsShadow = false,
										ShadowColor = "#FFFFFFFF",
										ShadowAlpha = 255,
										OffsetX = 0,
										OffsetY = 0,
									},
									fontSize = "44",
									fontStroke = 
									{
										IsStroke = false,
										StrokeColor = "#FFE6E6E6",
										StrokeSize = 1,
									},
									height = "55",
									ignoreSize = "True",
									name = "cur_lv",
									nTextAlign = "1",
									nTextHAlign = "1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "Lv 30",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionX = 713,
										PositionY = 368,
									},
									width = "149",
									ZOrder = "1",
								},
								{
									controlID = "Image_to_Panel_back_Panel_base_Panel-fairyEnergyBreakUpView_Layer1_fairyNew_Game",
									UUID = "317930e5_d762_44c0_9e9a_326606c7c7eb",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "24",
									ignoreSize = "True",
									name = "Image_to",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/fairy_up/row.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = 568,
										PositionY = 374,
									},
									width = "40",
									ZOrder = "1",
								},
								{
									controlID = "Image_res_bg_Panel_back_Panel_base_Panel-fairyEnergyBreakUpView_Layer1_fairyNew_Game",
									UUID = "35801bbe_d051_4144_8b6e_48fa42e45550",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "72",
									ignoreSize = "True",
									name = "Image_res_bg",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/fairy/new_ui/energy/ui_032.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = 568,
										PositionY = 265,
										IsPercent = true,
										PercentX = 50,
										PercentY = 41.34,
									},
									width = "374",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "Label_title1_Image_res_bg_Panel_back_Panel_base_Panel-fairyEnergyBreakUpView_Layer1_fairyNew_Game",
											UUID = "652b9686_770b_4aba_ac30_001d7c2b63aa",
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
											name = "Label_title1",
											nTextAlign = "1",
											nTextHAlign = "1",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "770",
											text = "突破奖励",
											touchAble = "False",
											touchScaleEnable = "False",
											UILayoutViewModel = 
											{
												PositionY = 21,
											},
											width = "90",
											ZOrder = "1",
										},
										{
											controlID = "Image_res_icon_Image_res_bg_Panel_back_Panel_base_Panel-fairyEnergyBreakUpView_Layer1_fairyNew_Game",
											UUID = "f6ec5109_7e33_480f_be7c_5f976b29f0a3",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											classname = "MEImage",
											dstBlendFunc = "771",
											height = "100",
											ignoreSize = "True",
											name = "Image_res_icon",
											scaleX = "0.45",
											scaleY = "0.45",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											texturePath = "icon/system/078.png",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = -45,
												PositionY = -14,
											},
											width = "100",
											ZOrder = "1",
										},
										{
											controlID = "label_get_num_Image_res_bg_Panel_back_Panel_base_Panel-fairyEnergyBreakUpView_Layer1_fairyNew_Game",
											UUID = "33f90ab6_d968_403a_9789_a2cc6ea0e9a9",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											classname = "MELabel",
											compPath = "luacomponents.common.MEIconLabel",
											dstBlendFunc = "771",
											FontColor = "#FFF9DB47",
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
											name = "label_get_num",
											nTextAlign = "1",
											nTextHAlign = "1",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "770",
											text = "x34",
											touchAble = "False",
											touchScaleEnable = "False",
											UILayoutViewModel = 
											{
												PositionX = 7,
												PositionY = -17,
											},
											width = "54",
											ZOrder = "1",
										},
									},
								},
								{
									controlID = "Spine_break_up_Panel_back_Panel_base_Panel-fairyEnergyBreakUpView_Layer1_fairyNew_Game",
									UUID = "d0a1e395_b0db_407d_a3d4_7d0e4878a2b4",
									classname = "MESpine",
									dstBlendFunc = "771",
									name = "Spine_break_up",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									spineModel = 
									{
										SpinePath = "effect/effect_heroGrow_ui4/effect_heroGrow_ui4",
										animationName = "xunhuan",
										IsLoop = false,
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
										PositionX = 568,
										PositionY = 519,
									},
									ZOrder = "1",
								},
							},
						},
						{
							controlID = "Label_tips_Panel_base_Panel-fairyEnergyBreakUpView_Layer1_fairyNew_Game",
							UUID = "cbec6943_9bd5_4188_b9d3_4a7646a334e1",
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
							name = "Label_tips",
							nTextAlign = "1",
							nTextHAlign = "1",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "770",
							text = "任意处关闭",
							touchAble = "False",
							touchScaleEnable = "False",
							UILayoutViewModel = 
							{
								PositionX = 568,
								PositionY = 107,
								IsPercent = true,
								PercentX = 50,
								PercentY = 16.72,
							},
							width = "123",
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
			"ui/fairy_up/bg.png",
			"ui/fairy_up/row.png",
			"ui/fairy/new_ui/energy/ui_032.png",
			"icon/system/078.png",
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

