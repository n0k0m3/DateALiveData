local t = 
{
	version = 1,
	components = 
	{
		
		{
			controlID = "Panel-leagueHunterHonorView_Layer1_league_Game",
			UUID = "875b2717_af1b_42ec_b806_a2deb047a6d5",
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
					controlID = "Panel_Item_Panel-leagueHunterHonorView_Layer1_league_Game",
					UUID = "d5960f59_be7f_4c0e_a599_7fae1275b198",
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
					height = "98",
					ignoreSize = "False",
					name = "Panel_Item",
					panelTexturePath = "ui/league/zljh/honr_bg.png",
					sizepercentx = "0",
					sizepercenty = "0",
					sizeType = "0",
					srcBlendFunc = "1",
					touchAble = "False",
					UILayoutViewModel = 
					{
						PositionX = 621,
						PositionY = -384,
						LeftPositon = 263,
						TopPosition = 975,
						relativeToName = "Panel",
						nType = 3,
					},
					uipanelviewmodel = 
					{
						Layout="Absolute",
						nType = "0"
					},
					width = "716",
					ZOrder = "1",
					components = 
					{
						
						{
							controlID = "image_rank_Panel_Item_Panel-leagueHunterHonorView_Layer1_league_Game",
							UUID = "d49fb815_ce4a_40d4_8eba_1940ef1afdb4",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							backGroundScale9Enable = "False",
							classname = "MEImage",
							dstBlendFunc = "771",
							height = "64",
							ignoreSize = "True",
							name = "image_rank",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							touchAble = "False",
							UILayoutViewModel = 
							{
								PositionY = -9,
							},
							width = "64",
							ZOrder = "1",
						},
						{
							controlID = "label_rank_Panel_Item_Panel-leagueHunterHonorView_Layer1_league_Game",
							UUID = "b83dad68_c528_4e77_9005_591ec463c1fc",
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
							name = "label_rank",
							nTextAlign = "1",
							nTextHAlign = "1",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "770",
							text = "1",
							touchAble = "False",
							touchScaleEnable = "False",
							UILayoutViewModel = 
							{
								PositionY = -9,
							},
							width = "13",
							ZOrder = "1",
						},
						{
							controlID = "label_name_Panel_Item_Panel-leagueHunterHonorView_Layer1_league_Game",
							UUID = "217c8be4_5ebe_4967_bc0d_585e03971665",
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
							fontSize = "18",
							fontStroke = 
							{
								IsStroke = false,
								StrokeColor = "#FFE6E6E6",
								StrokeSize = 1,
							},
							height = "21",
							ignoreSize = "True",
							name = "label_name",
							nTextAlign = "1",
							nTextHAlign = "1",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "770",
							text = "Avatar-Rahmen Name",
							touchAble = "False",
							touchScaleEnable = "False",
							UILayoutViewModel = 
							{
								PositionX = -349,
								PositionY = 35,
							},
							width = "164",
							ZOrder = "1",
						},
						{
							controlID = "label_score_Panel_Item_Panel-leagueHunterHonorView_Layer1_league_Game",
							UUID = "902f476a_6143_4e88_b312_876bbcb8abe0",
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
							fontSize = "24",
							fontStroke = 
							{
								IsStroke = false,
								StrokeColor = "#FFE6E6E6",
								StrokeSize = 1,
							},
							height = "27",
							ignoreSize = "True",
							name = "label_score",
							nTextAlign = "1",
							nTextHAlign = "1",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "770",
							text = "> 100",
							touchAble = "False",
							touchScaleEnable = "False",
							UILayoutViewModel = 
							{
								PositionX = 229,
								PositionY = -1,
							},
							width = "59",
							ZOrder = "1",
						},
						{
							controlID = "image_head_Panel_Item_Panel-leagueHunterHonorView_Layer1_league_Game",
							UUID = "d554eea5_3e7a_4c56_8ce7_3c096d9fbc98",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							backGroundScale9Enable = "False",
							classname = "MEImage",
							dstBlendFunc = "771",
							height = "64",
							ignoreSize = "True",
							name = "image_head",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							touchAble = "False",
							UILayoutViewModel = 
							{
								PositionX = -208,
								PositionY = -11,
							},
							width = "64",
							ZOrder = "1",
						},
					},
				},
				{
					controlID = "Panel_root_Panel-leagueHunterHonorView_Layer1_league_Game",
					UUID = "b66ce662_519d_4469_9b91_014c57047780",
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
							controlID = "Image_bg_Panel_root_Panel-leagueHunterHonorView_Layer1_league_Game",
							UUID = "0d0b0cae_13ad_4108_80bd_4121305826c5",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							backGroundScale9Enable = "True;capInsetsX:0;capInsetsY:0;capInsetsWidth:0;capInsetsHeight:0",
							classname = "MEImage",
							dstBlendFunc = "771",
							height = "427",
							ignoreSize = "False",
							name = "Image_bg",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							texturePath = "ui/common/pop_ui/pop_bg_01.png",
							touchAble = "True",
							UILayoutViewModel = 
							{
								
							},
							width = "743",
							ZOrder = "1",
							components = 
							{
								
								{
									controlID = "Image_bg1_Image_bg_Panel_root_Panel-leagueHunterHonorView_Layer1_league_Game",
									UUID = "fff5f7e1_f8e7_4567_968e_4ec2b6d58772",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "1",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "327",
									ignoreSize = "False",
									name = "Image_bg1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/common/pop_ui/pop_bg_02.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionY = 164,
									},
									width = "725",
									ZOrder = "1",
								},
								{
									controlID = "Label_name_Image_bg_Panel_root_Panel-leagueHunterHonorView_Layer1_league_Game",
									UUID = "40cbe86b_0447_40cd_98d1_b1a43b33fd23",
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
									name = "Label_name",
									nTextAlign = "1",
									nTextHAlign = "1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "Club-Ehre",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionX = -356,
										PositionY = 182,
									},
									width = "151",
									ZOrder = "1",
								},
								{
									controlID = "Image_line_Image_bg_Panel_root_Panel-leagueHunterHonorView_Layer1_league_Game",
									UUID = "52fa12d9_3216_427c_91bd_079768eb924c",
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
										PositionX = -236,
										PositionY = 184,
									},
									visible = "False",
									width = "2",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "Label_name_en_Image_line_Image_bg_Panel_root_Panel-leagueHunterHonorView_Layer1_league_Game",
											UUID = "c6b11074_73c6_4ec8_b0ee_089aef5fc3c9",
											anchorPoint = "False",
											anchorPointX = "0",
											anchorPointY = "0",
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
											name = "Label_name_en",
											nTextAlign = "1",
											nTextHAlign = "1",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "770",
											text = "Chapter",
											touchAble = "False",
											touchScaleEnable = "False",
											UILayoutViewModel = 
											{
												PositionX = 4,
												PositionY = -15,
											},
											width = "52",
											ZOrder = "1",
										},
									},
								},
								{
									controlID = "Panel_top_Image_bg_Panel_root_Panel-leagueHunterHonorView_Layer1_league_Game",
									UUID = "74bd21fa_d837_4ebd_84b5_affb01cd74d2",
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
									height = "36",
									ignoreSize = "False",
									name = "Panel_top",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = -362,
										PositionY = 126,
									},
									uipanelviewmodel = 
									{
										Layout="Absolute",
										nType = "0"
									},
									width = "723",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "image_line1_Panel_top_Image_bg_Panel_root_Panel-leagueHunterHonorView_Layer1_league_Game",
											UUID = "f3ebefb3_02b3_4749_8353_eedac2774ba4",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											classname = "MEImage",
											dstBlendFunc = "771",
											height = "20",
											ignoreSize = "True",
											name = "image_line1",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "770",
											texturePath = "ui/common/image_line.png",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 212,
												PositionY = 18,
											},
											width = "2",
											ZOrder = "1",
										},
										{
											controlID = "image_line2_Panel_top_Image_bg_Panel_root_Panel-leagueHunterHonorView_Layer1_league_Game",
											UUID = "c3e7997f_7868_4dc3_8909_6f70dfe24ddd",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											classname = "MEImage",
											dstBlendFunc = "771",
											height = "20",
											ignoreSize = "True",
											name = "image_line2",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "770",
											texturePath = "ui/common/image_line.png",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 509,
												PositionY = 18,
											},
											width = "2",
											ZOrder = "1",
										},
										{
											controlID = "Label_title1_Panel_top_Image_bg_Panel_root_Panel-leagueHunterHonorView_Layer1_league_Game",
											UUID = "098513dc_46cf_4b78_9651_8cea18c20268",
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
											fontSize = "18",
											fontStroke = 
											{
												IsStroke = false,
												StrokeColor = "#FFE6E6E6",
												StrokeSize = 1,
											},
											height = "21",
											ignoreSize = "True",
											name = "Label_title1",
											nTextAlign = "1",
											nTextHAlign = "1",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "770",
											text = "Avatar-Rahmen",
											touchAble = "False",
											touchScaleEnable = "False",
											UILayoutViewModel = 
											{
												PositionX = 104,
												PositionY = 18,
												IsPercent = true,
												PercentX = 14.36,
												PercentY = 50,
											},
											width = "117",
											ZOrder = "1",
										},
										{
											controlID = "Label_title2_Panel_top_Image_bg_Panel_root_Panel-leagueHunterHonorView_Layer1_league_Game",
											UUID = "da87f89e_a4d7_4064_ba68_96c71757f50d",
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
											fontSize = "18",
											fontStroke = 
											{
												IsStroke = false,
												StrokeColor = "#FFE6E6E6",
												StrokeSize = 1,
											},
											height = "21",
											ignoreSize = "True",
											name = "Label_title2",
											nTextAlign = "1",
											nTextHAlign = "1",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "770",
											text = "Club-HP-Rangliste",
											touchAble = "False",
											touchScaleEnable = "False",
											UILayoutViewModel = 
											{
												PositionX = 362,
												PositionY = 18,
												IsPercent = true,
												PercentX = 50,
												PercentY = 50,
											},
											width = "139",
											ZOrder = "1",
										},
										{
											controlID = "Label_title3_Panel_top_Image_bg_Panel_root_Panel-leagueHunterHonorView_Layer1_league_Game",
											UUID = "6f788220_a2ca_451e_ab9e_417fd0836d81",
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
											fontSize = "18",
											fontStroke = 
											{
												IsStroke = false,
												StrokeColor = "#FFE6E6E6",
												StrokeSize = 1,
											},
											height = "21",
											ignoreSize = "True",
											name = "Label_title3",
											nTextAlign = "1",
											nTextHAlign = "1",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "770",
											text = "Individuelle HP Pkt.",
											touchAble = "False",
											touchScaleEnable = "False",
											UILayoutViewModel = 
											{
												PositionX = 619,
												PositionY = 18,
												IsPercent = true,
												PercentX = 85.64,
												PercentY = 50,
											},
											width = "149",
											ZOrder = "1",
										},
									},
								},
								{
									controlID = "panel_ScrollView_Image_bg_Panel_root_Panel-leagueHunterHonorView_Layer1_league_Game",
									UUID = "942b331a_0711_4d77_979b_188cfd05a8a7",
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
									height = "283",
									ignoreSize = "False",
									innerHeight = "283",
									innerWidth = "720",
									name = "panel_ScrollView",
									showScrollbar = "False",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "True",
									UILayoutViewModel = 
									{
										PositionX = -360,
										PositionY = -159,
									},
									uipanelviewmodel = 
									{
										Layout="Absolute",
										nType = "0"
									},
									width = "720",
									ZOrder = "1",
								},
								{
									controlID = "Button_close_Image_bg_Panel_root_Panel-leagueHunterHonorView_Layer1_league_Game",
									UUID = "cd989e4a_8cb4_4b35_bb6e_97407738a5de",
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
										PositionX = 339,
										PositionY = 183,
									},
									UItype = "Button",
									width = "60",
									ZOrder = "1",
								},
								{
									controlID = "Label_tips_Image_bg_Panel_root_Panel-leagueHunterHonorView_Layer1_league_Game",
									UUID = "db454b56_2473_4901_9a2d_ca6489a879c4",
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
									height = "0",
									ignoreSize = "False",
									name = "Label_tips",
									nTextAlign = "1",
									nTextHAlign = "1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "Ranglistendaten",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionY = -184,
									},
									width = "700",
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
			"ui/league/zljh/honr_bg.png",
			"ui/common/pop_ui/pop_bg_01.png",
			"ui/common/pop_ui/pop_bg_02.png",
			"ui/common/pop_ui/pop_ui_02.png",
			"ui/common/image_line.png",
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

