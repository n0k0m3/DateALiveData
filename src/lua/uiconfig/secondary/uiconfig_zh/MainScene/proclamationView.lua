local t = 
{
	version = 1,
	components = 
	{
		
		{
			controlID = "Panel-proclamationView_Layer1_MainScene_Game",
			UUID = "83e669a6_1578_472f_a604_a2d5b70114d2",
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
					controlID = "Panel_root_Panel-proclamationView_Layer1_MainScene_Game",
					UUID = "6cbf1e04_ce7a_404e_be41_7d08c02d1f87",
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
							controlID = "Image_bg_Panel_root_Panel-proclamationView_Layer1_MainScene_Game",
							UUID = "99ea759a_a7df_4ecd_a378_927806daf8a4",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							backGroundScale9Enable = "True;capInsetsX:0;capInsetsY:0;capInsetsWidth:0;capInsetsHeight:0",
							classname = "MEImage",
							dstBlendFunc = "771",
							height = "512",
							ignoreSize = "False",
							name = "Image_bg",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							texturePath = "ui/769.png",
							touchAble = "False",
							UILayoutViewModel = 
							{
								
							},
							width = "1000",
							ZOrder = "1",
							components = 
							{
								
								{
									controlID = "Image_proclamationView_1_Image_bg_Panel_root_Panel-proclamationView_Layer1_MainScene_Game",
									UUID = "df6317f4_b1b2_4030_b437_bc532b3cac80",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "170",
									ignoreSize = "True",
									name = "Image_proclamationView_1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "icon/activity/010.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionY = 170,
									},
									width = "996",
									ZOrder = "1",
								},
								{
									controlID = "Image_title_Image_bg_Panel_root_Panel-proclamationView_Layer1_MainScene_Game",
									UUID = "3c03d49c_c6e1_440e_bd91_699a9f5769e2",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "34",
									ignoreSize = "True",
									name = "Image_title",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/770.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = -367,
										PositionY = 238,
									},
									width = "266",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "Label_title_Image_title_Image_bg_Panel_root_Panel-proclamationView_Layer1_MainScene_Game",
											UUID = "8ded72a8_983d_471f_8abe_2503cba33547",
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
											name = "Label_title",
											nTextAlign = "1",
											nTextHAlign = "1",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "770",
											text = "遊戲公告",
											touchAble = "False",
											touchScaleEnable = "False",
											UILayoutViewModel = 
											{
												PositionX = -99,
												PositionY = 2,
											},
											width = "83",
											ZOrder = "1",
										},
										{
											controlID = "Image_proclamationView_1_Image_title_Image_bg_Panel_root_Panel-proclamationView_Layer1_MainScene_Game",
											UUID = "ea799117_8c44_4d2d_91b6_cd3db1d74924",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											classname = "MEImage",
											dstBlendFunc = "771",
											height = "20",
											ignoreSize = "True",
											name = "Image_proclamationView_1",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											texturePath = "ui/186.png",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = -109,
											},
											width = "4",
											ZOrder = "1",
										},
									},
								},
								{
									controlID = "Panel_close_Image_bg_Panel_root_Panel-proclamationView_Layer1_MainScene_Game",
									UUID = "63eca34b_8625_40f8_9f40_29da9a341ef2",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									bgColorOpacity = "50",
									bIsOpenClipping = "False",
									classname = "MEPanel",
									colorType = "0;SingleColor:#FFFF4500;GraduallyChangingColorStart:#FFFFFFFF;GraduallyChangingColorEnd:#FFFFFFFF;vectorX:0;vectorY:0",
									DesignHeight = "640",
									DesignType = "0",
									DesignWidth = "960",
									dstBlendFunc = "771",
									height = "30",
									ignoreSize = "False",
									name = "Panel_close",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = 443,
										PositionY = 225,
									},
									uipanelviewmodel = 
									{
										Layout="Absolute",
										nType = "0"
									},
									width = "80",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "Label_close_Panel_close_Image_bg_Panel_root_Panel-proclamationView_Layer1_MainScene_Game",
											UUID = "54b5861a_a9ad_4c24_87b1_0f95e1f52836",
											anchorPoint = "False",
											anchorPointX = "1",
											anchorPointY = "0.5",
											classname = "MELabel",
											compPath = "luacomponents.common.MEIconLabel",
											dstBlendFunc = "771",
											FontColor = "#FF000000",
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
												IsStroke = true,
												StrokeColor = "#FFFFFFFF",
												StrokeSize = 2,
											},
											height = "27",
											ignoreSize = "True",
											name = "Label_close",
											nTextAlign = "1",
											nTextHAlign = "1",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "770",
											text = "關閉",
											touchAble = "False",
											touchScaleEnable = "False",
											UILayoutViewModel = 
											{
												PositionX = 7,
												PositionY = 2,
											},
											width = "44",
											ZOrder = "1",
										},
										{
											controlID = "Image_proclamationView_1_Panel_close_Image_bg_Panel_root_Panel-proclamationView_Layer1_MainScene_Game",
											UUID = "fdf95cc6_21d2_486c_9d2d_af794cd2dbda",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											classname = "MEImage",
											dstBlendFunc = "771",
											height = "24",
											ignoreSize = "True",
											name = "Image_proclamationView_1",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											texturePath = "ui/766.png",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 23,
											},
											width = "24",
											ZOrder = "1",
										},
									},
								},
								{
									controlID = "Image_name_Image_bg_Panel_root_Panel-proclamationView_Layer1_MainScene_Game",
									UUID = "13854871_8966_480c_b201_0854764464e4",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "28",
									ignoreSize = "True",
									name = "Image_name",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/768.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionY = 42,
									},
									width = "872",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "Label_name_Image_name_Image_bg_Panel_root_Panel-proclamationView_Layer1_MainScene_Game",
											UUID = "6ed299a7_69e6_4f87_a5ff_f1bed0a9151b",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											classname = "MELabel",
											compPath = "luacomponents.common.MEIconLabel",
											dstBlendFunc = "771",
											FontColor = "#FF000000",
											fontName = "font/fangzheng_zhunyuan.ttf",
											fontShadow = 
											{
												IsShadow = false,
												ShadowColor = "#FFFFFFFF",
												ShadowAlpha = 255,
												OffsetX = 0,
												OffsetY = 0,
											},
											fontSize = "32",
											fontStroke = 
											{
												IsStroke = false,
												StrokeColor = "#FFE6E6E6",
												StrokeSize = 1,
											},
											height = "37",
											ignoreSize = "True",
											name = "Label_name",
											nTextAlign = "1",
											nTextHAlign = "1",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "770",
											text = "公告名字",
											touchAble = "False",
											touchScaleEnable = "False",
											UILayoutViewModel = 
											{
												
											},
											width = "131",
											ZOrder = "1",
										},
									},
								},
								{
									controlID = "ScrollView_desc_Image_bg_Panel_root_Panel-proclamationView_Layer1_MainScene_Game",
									UUID = "2af63f93_34f8_4292_bcf1_94da3b4b9030",
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
									height = "244",
									ignoreSize = "False",
									innerHeight = "244",
									innerWidth = "870",
									name = "ScrollView_desc",
									showScrollbar = "False",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "True",
									UILayoutViewModel = 
									{
										PositionY = -116,
									},
									uipanelviewmodel = 
									{
										Layout="Absolute",
										nType = "0"
									},
									width = "870",
									ZOrder = "1",
								},
							},
						},
					},
				},
				{
					controlID = "Panel_prefab_Panel-proclamationView_Layer1_MainScene_Game",
					UUID = "19269207_7528_4b42_9850_1da3e8097c27",
					anchorPoint = "False",
					anchorPointX = "0",
					anchorPointY = "0",
					backGroundScale9Enable = "False",
					bgColorOpacity = "50",
					bIsOpenClipping = "False",
					classname = "MEPanel",
					colorType = "1;SingleColor:#FFE6E6E6;GraduallyChangingColorStart:#FFFFFFFF;GraduallyChangingColorEnd:#FFFFFFFF;vectorX:0;vectorY:0",
					DesignHeight = "640",
					DesignType = "0",
					DesignWidth = "960",
					dstBlendFunc = "771",
					height = "640",
					ignoreSize = "False",
					name = "Panel_prefab",
					sizepercentx = "0",
					sizepercenty = "0",
					sizeType = "0",
					srcBlendFunc = "1",
					touchAble = "False",
					UILayoutViewModel = 
					{
						PositionX = -22,
						PositionY = -716,
						LeftPositon = -22,
						TopPosition = 716,
						relativeToName = "Panel",
						nType = 3,
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
							controlID = "Label_content_Panel_prefab_Panel-proclamationView_Layer1_MainScene_Game",
							UUID = "025aba32_aae9_4818_9dd0_0526407eac1f",
							anchorPoint = "False",
							anchorPointX = "0",
							anchorPointY = "0.5",
							classname = "MELabel",
							compPath = "luacomponents.common.MEIconLabel",
							dstBlendFunc = "771",
							FontColor = "#FF000000",
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
							name = "Label_content",
							nTextAlign = "0",
							nTextHAlign = "0",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "770",
							text = "確認洗練將消耗洗練材料，並返還90%材料",
							touchAble = "False",
							touchScaleEnable = "False",
							UILayoutViewModel = 
							{
								PositionX = 153,
								PositionY = 489,
							},
							width = "80",
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
			"ui/769.png",
			"icon/activity/010.png",
			"ui/770.png",
			"ui/186.png",
			"ui/766.png",
			"ui/768.png",
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

