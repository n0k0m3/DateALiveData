local t = 
{
	version = 1,
	components = 
	{
		
		{
			controlID = "Panel-assistRankingView_Layer1_activity_Game",
			UUID = "0b14df68_88c2_4758_9cf6_cf200057dc5c",
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
					controlID = "Panel_base_Panel-assistRankingView_Layer1_activity_Game",
					UUID = "052679a5_4db7_479f_a467_54608557c9ee",
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
							controlID = "Image_bg_Panel_base_Panel-assistRankingView_Layer1_activity_Game",
							UUID = "5a8bdf3e_9fe8_4648_8efc_fbe789f31ead",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							backGroundScale9Enable = "True;capInsetsX:0;capInsetsY:0;capInsetsWidth:0;capInsetsHeight:0",
							classname = "MEImage",
							dstBlendFunc = "771",
							height = "427",
							ignoreSize = "False",
							name = "Image_bg",
							sizepercentx = "100",
							sizepercenty = "100",
							sizeType = "0",
							srcBlendFunc = "1",
							texturePath = "ui/common/pop_ui/pop_bg_01.png",
							touchAble = "True",
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
							width = "743",
							ZOrder = "1",
							components = 
							{
								
								{
									controlID = "Image_assistRankingView_1_Image_bg_Panel_base_Panel-assistRankingView_Layer1_activity_Game",
									UUID = "bc89bd8f_0c80_460f_b436_14346f0bbbcf",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "2",
									ignoreSize = "True",
									name = "Image_assistRankingView_1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									texturePath = "ui/activity/assist/应援活动弹框.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										
									},
									visible = "False",
									width = "2",
									ZOrder = "1",
								},
								{
									controlID = "Label_tittle_Image_bg_Panel_base_Panel-assistRankingView_Layer1_activity_Game",
									UUID = "ac0240c5_66f9_403c_9211_a31e13ed1b8d",
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
									text = "Tabla de liderazgo de reunión de apoyo",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionX = -357,
										PositionY = 183,
									},
									width = "532",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "Image_line_Label_tittle_Image_bg_Panel_base_Panel-assistRankingView_Layer1_activity_Game",
											UUID = "08adb725_2a05_4dfe_86e5_7e48ce9a392b",
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
												PositionX = 559,
												IsPercent = true,
												PercentX = 105,
											},
											visible = "False",
											width = "2",
											ZOrder = "1",
										},
										{
											controlID = "Label_tip_Label_tittle_Image_bg_Panel_base_Panel-assistRankingView_Layer1_activity_Game",
											UUID = "98048e00_5bcc_4d5b_8220_74fece8c4fa5",
											anchorPoint = "False",
											anchorPointX = "0",
											anchorPointY = "0.5",
											classname = "MELabel",
											compPath = "luacomponents.common.MEIconLabel",
											dstBlendFunc = "771",
											FontColor = "#FF101117",
											fontName = "font/MFLiHei_Noncommercial.ttf",
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
											name = "Label_tip",
											nTextAlign = "1",
											nTextHAlign = "1",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "770",
											text = "Clasificación",
											touchAble = "False",
											touchScaleEnable = "False",
											UILayoutViewModel = 
											{
												PositionX = 575,
												PositionY = -5,
												IsPercent = true,
												PercentX = 108,
												PercentY = -15,
											},
											visible = "False",
											width = "92",
											ZOrder = "1",
										},
									},
								},
								{
									controlID = "Button_close_Image_bg_Panel_base_Panel-assistRankingView_Layer1_activity_Game",
									UUID = "1f484dac_dbd7_4cec_82fe_c3decd967a6f",
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
										PositionX = 341,
										PositionY = 185,
									},
									UItype = "Button",
									width = "60",
									ZOrder = "1",
								},
								{
									controlID = "Image_infoBg_Image_bg_Panel_base_Panel-assistRankingView_Layer1_activity_Game",
									UUID = "510063e1_16a0_409d_8017_b3166442ebc5",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "335",
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
										PositionY = -3,
									},
									width = "716",
									ZOrder = "1",
								},
								{
									controlID = "Image_assistRankingView_3_Image_bg_Panel_base_Panel-assistRankingView_Layer1_activity_Game",
									UUID = "f42e2c3e_3429_4f94_80fe_b1d2934fec50",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "30",
									ignoreSize = "False",
									name = "Image_assistRankingView_3",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/activity/assist/053.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionY = 148,
									},
									width = "710",
									ZOrder = "1",
								},
								{
									controlID = "Label_rank_Image_bg_Panel_base_Panel-assistRankingView_Layer1_activity_Game",
									UUID = "c0519731_62a5_493e_a50b_27c650ad9e7a",
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
									name = "Label_rank",
									nTextAlign = "1",
									nTextHAlign = "1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "Clasificación",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionX = -257,
										PositionY = 148,
									},
									width = "98",
									ZOrder = "1",
								},
								{
									controlID = "Label_player_Image_bg_Panel_base_Panel-assistRankingView_Layer1_activity_Game",
									UUID = "80579f5d_6e01_44da_8e20_81a1b4dfdc6b",
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
									name = "Label_player",
									nTextAlign = "1",
									nTextHAlign = "1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "Jugador",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionY = 148,
									},
									width = "66",
									ZOrder = "1",
								},
								{
									controlID = "Label_assist_Image_bg_Panel_base_Panel-assistRankingView_Layer1_activity_Game",
									UUID = "29844380_40f4_42c8_b562_3dc9c1046da8",
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
									name = "Label_assist",
									nTextAlign = "1",
									nTextHAlign = "1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "Donar puntos de respaldo",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionX = 250,
										PositionY = 148,
									},
									width = "204",
									ZOrder = "1",
								},
								{
									controlID = "ScrollView_ranking_Image_bg_Panel_base_Panel-assistRankingView_Layer1_activity_Game",
									UUID = "fbe57796_a4ee_4253_b7f6_f417eb369e15",
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
									height = "216",
									ignoreSize = "False",
									innerHeight = "216",
									innerWidth = "708",
									name = "ScrollView_ranking",
									showScrollbar = "False",
									sizepercentx = "98",
									sizepercenty = "100",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "True",
									UILayoutViewModel = 
									{
										PositionX = -3,
										PositionY = 27,
										LeftPositon = 13,
										TopPosition = 7,
										relativeToName = "Panel_bagInfo",
									},
									uipanelviewmodel = 
									{
										Layout="Absolute",
										nType = "0"
									},
									width = "708",
									ZOrder = "1",
								},
								{
									controlID = "Image_self_bg_Image_bg_Panel_base_Panel-assistRankingView_Layer1_activity_Game",
									UUID = "518dae88_3359_4a04_91f0_531ef98eadeb",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "66",
									ignoreSize = "True",
									name = "Image_self_bg",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/activity/assist/042.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionY = -137,
									},
									width = "720",
									ZOrder = "1",
								},
								{
									controlID = "Image_rank_Image_bg_Panel_base_Panel-assistRankingView_Layer1_activity_Game",
									UUID = "94da2ebb_627a_493c_ac10_fa1f12992dc6",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "38",
									ignoreSize = "True",
									name = "Image_rank",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/activity/assist/038.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = -254,
										PositionY = -139,
									},
									width = "52",
									ZOrder = "1",
								},
								{
									controlID = "Label_my_rank_Image_bg_Panel_base_Panel-assistRankingView_Layer1_activity_Game",
									UUID = "112e2fa8_1e40_4faf_8a0b_5c1b8aedfcca",
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
									fontSize = "24",
									fontStroke = 
									{
										IsStroke = true,
										StrokeColor = "#FF30354A",
										StrokeSize = 1,
									},
									height = "30",
									ignoreSize = "True",
									name = "Label_my_rank",
									nTextAlign = "1",
									nTextHAlign = "1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "NO.45",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionX = -254,
										PositionY = -139,
									},
									width = "75",
									ZOrder = "5",
								},
								{
									controlID = "Label_my_name_Image_bg_Panel_base_Panel-assistRankingView_Layer1_activity_Game",
									UUID = "367baf4e_7407_4417_aa43_7551cb5b3f40",
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
									fontSize = "24",
									fontStroke = 
									{
										IsStroke = true,
										StrokeColor = "#FF30354A",
										StrokeSize = 1,
									},
									height = "29",
									ignoreSize = "True",
									name = "Label_my_name",
									nTextAlign = "1",
									nTextHAlign = "1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "Mi nombre",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionY = -139,
									},
									width = "114",
									ZOrder = "5",
								},
								{
									controlID = "Label_my_value_Image_bg_Panel_base_Panel-assistRankingView_Layer1_activity_Game",
									UUID = "2c72083e_b4ec_417f_8ba9_9274e9d22e22",
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
									fontSize = "24",
									fontStroke = 
									{
										IsStroke = true,
										StrokeColor = "#FF30354A",
										StrokeSize = 1,
									},
									height = "30",
									ignoreSize = "True",
									name = "Label_my_value",
									nTextAlign = "1",
									nTextHAlign = "1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "8887",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionX = 255,
										PositionY = -139,
									},
									width = "55",
									ZOrder = "5",
								},
								{
									controlID = "Image_scrollBarModel_Image_bg_Panel_base_Panel-assistRankingView_Layer1_activity_Game",
									UUID = "32fcb8ef_62a8_4dd3_ab3b_50a955fdfe44",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0",
									backGroundScale9Enable = "True;capInsetsX:0;capInsetsY:0;capInsetsWidth:0;capInsetsHeight:0",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "220",
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
										PositionX = 356,
										PositionY = -84,
									},
									width = "6",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "Image_scrollBarInner_Image_scrollBarModel_Image_bg_Panel_base_Panel-assistRankingView_Layer1_activity_Game",
											UUID = "3a8db810_bf35_4917_876c_6c0c7eff6578",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "True;capInsetsX:0;capInsetsY:0;capInsetsWidth:0;capInsetsHeight:0",
											classname = "MEImage",
											dstBlendFunc = "771",
											height = "220",
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
												PositionY = 110,
											},
											width = "6",
											ZOrder = "1",
										},
									},
								},
								{
									controlID = "Label_tips1_Image_bg_Panel_base_Panel-assistRankingView_Layer1_activity_Game",
									UUID = "85457a1d_66f7_418d_b01e_319915947f94",
									anchorPoint = "False",
									anchorPointX = "0",
									anchorPointY = "0.5",
									classname = "MELabel",
									compPath = "luacomponents.common.MEIconLabel",
									dstBlendFunc = "771",
									FontColor = "#FF49557F",
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
									name = "Label_tips1",
									nTextAlign = "1",
									nTextHAlign = "1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "La tabal de liderazgo se renueva en tiempo real",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionX = -356,
										PositionY = -187,
									},
									width = "398",
									ZOrder = "1",
								},
								{
									controlID = "Label_tips2_Image_bg_Panel_base_Panel-assistRankingView_Layer1_activity_Game",
									UUID = "0e132e8d_1c01_4401_b443_a7770ea46773",
									anchorPoint = "False",
									anchorPointX = "1",
									anchorPointY = "0.5",
									classname = "MELabel",
									compPath = "luacomponents.common.MEIconLabel",
									dstBlendFunc = "771",
									FontColor = "#FF49557F",
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
									name = "Label_tips2",
									nTextAlign = "1",
									nTextHAlign = "1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "La tabla de liderazgo se establece en",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionX = 351,
										PositionY = -187,
									},
									width = "310",
									ZOrder = "1",
								},
								{
									controlID = "Image_assistRankingView_2_Image_bg_Panel_base_Panel-assistRankingView_Layer1_activity_Game",
									UUID = "d18781f7_36c3_471e_94b6_f999ddb265f2",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "10",
									ignoreSize = "True",
									name = "Image_assistRankingView_2",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/activity/assist/050.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionY = -98,
									},
									width = "699",
									ZOrder = "1",
								},
								{
									controlID = "Label_tips_Image_bg_Panel_base_Panel-assistRankingView_Layer1_activity_Game",
									UUID = "b69c7cac_7b32_4059_926e_f10be2c5ebab",
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
									name = "Label_tips",
									nTextAlign = "1",
									nTextHAlign = "1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "Tu clasificación",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionY = -96,
									},
									width = "118",
									ZOrder = "5",
								},
							},
						},
						{
							controlID = "Panel_rank_item_Panel_base_Panel-assistRankingView_Layer1_activity_Game",
							UUID = "133783a2_080b_4d0d_ac18_5582ed59888c",
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
							height = "58",
							ignoreSize = "False",
							name = "Panel_rank_item",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							touchAble = "False",
							UILayoutViewModel = 
							{
								PositionX = 269,
								PositionY = -105,
							},
							uipanelviewmodel = 
							{
								Layout="Absolute",
								nType = "0"
							},
							width = "708",
							ZOrder = "1",
							components = 
							{
								
								{
									controlID = "Image_bg_Panel_rank_item_Panel_base_Panel-assistRankingView_Layer1_activity_Game",
									UUID = "4467a2f5_15d5_4f74_91ac_8350e60fb963",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "58",
									ignoreSize = "True",
									name = "Image_bg",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/activity/assist/043.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = 354,
										PositionY = 29,
									},
									width = "708",
									ZOrder = "1",
								},
								{
									controlID = "Image_rank_Panel_rank_item_Panel_base_Panel-assistRankingView_Layer1_activity_Game",
									UUID = "9fdae3de_6baa_4a30_ab5d_a52fd9036e2b",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "38",
									ignoreSize = "True",
									name = "Image_rank",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/activity/assist/038.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = 103,
										PositionY = 29,
									},
									width = "52",
									ZOrder = "1",
								},
								{
									controlID = "Label_rank_Panel_rank_item_Panel_base_Panel-assistRankingView_Layer1_activity_Game",
									UUID = "a8a5784e_cb80_4e89_9e3b_0e0204b4f6e9",
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
										IsStroke = true,
										StrokeColor = "#FF30354A",
										StrokeSize = 1,
									},
									height = "25",
									ignoreSize = "True",
									name = "Label_rank",
									nTextAlign = "1",
									nTextHAlign = "1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "4",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionX = 103,
										PositionY = 29,
									},
									width = "15",
									ZOrder = "1",
								},
								{
									controlID = "Panel_info_Panel_rank_item_Panel_base_Panel-assistRankingView_Layer1_activity_Game",
									UUID = "33c77eba_90c0_4a16_bcff_c1525f9db8a9",
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
									height = "50",
									ignoreSize = "False",
									name = "Panel_info",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = 280,
										PositionY = 29,
									},
									uipanelviewmodel = 
									{
										Layout="Absolute",
										nType = "0"
									},
									width = "50",
									ZOrder = "1",
								},
								{
									controlID = "Image_search_Panel_rank_item_Panel_base_Panel-assistRankingView_Layer1_activity_Game",
									UUID = "c41adeee_c38a_4fdf_912b_3ce9a89b0d35",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "22",
									ignoreSize = "True",
									name = "Image_search",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/activity/assist/041.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = 280,
										PositionY = 29,
									},
									width = "20",
									ZOrder = "1",
								},
								{
									controlID = "Label_player_name_Panel_rank_item_Panel_base_Panel-assistRankingView_Layer1_activity_Game",
									UUID = "ca5723f4_0c4b_4269_82eb_42ed83a1d424",
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
										IsStroke = true,
										StrokeColor = "#FF30354A",
										StrokeSize = 1,
									},
									height = "29",
									ignoreSize = "True",
									name = "Label_player_name",
									nTextAlign = "1",
									nTextHAlign = "1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "Nombre del jugador",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionX = 296,
										PositionY = 29,
									},
									width = "206",
									ZOrder = "1",
								},
								{
									controlID = "Label_value_Panel_rank_item_Panel_base_Panel-assistRankingView_Layer1_activity_Game",
									UUID = "7a081a77_3d75_4063_82be_df164be84ace",
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
									fontSize = "24",
									fontStroke = 
									{
										IsStroke = true,
										StrokeColor = "#FF30354A",
										StrokeSize = 1,
									},
									height = "30",
									ignoreSize = "True",
									name = "Label_value",
									nTextAlign = "1",
									nTextHAlign = "1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "9999",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionX = 609,
										PositionY = 29,
									},
									width = "56",
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
			"ui/common/pop_ui/pop_bg_01.png",
			"ui/activity/assist/应援活动弹框.png",
			"ui/common/pop_ui/pop_ui_02.png",
			"ui/common/pop_ui/pop_btn_02.png",
			"ui/common/pop_ui/pop_bg_02.png",
			"ui/activity/assist/053.png",
			"ui/activity/assist/042.png",
			"ui/activity/assist/038.png",
			"ui/common/scroll_bar_01.png",
			"ui/common/scroll_bar_02.png",
			"ui/activity/assist/050.png",
			"ui/activity/assist/043.png",
			"ui/activity/assist/041.png",
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

