local t = 
{
	version = 1,
	components = 
	{
		
		{
			controlID = "Panel-knowledgeConfirm_Layer1_explore_Game",
			UUID = "04cfcfed_1416_4fed_a729_f60c56bba4bf",
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
					controlID = "Panel_root_Panel-knowledgeConfirm_Layer1_explore_Game",
					UUID = "a199d819_2c35_4b40_a63d_234cd291dd3f",
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
							controlID = "Image_bg_Panel_root_Panel-knowledgeConfirm_Layer1_explore_Game",
							UUID = "5fe93bec_2ed9_4015_8bbe_f3e4ecbef7b4",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							backGroundScale9Enable = "False",
							classname = "MEImage",
							dstBlendFunc = "771",
							height = "400",
							ignoreSize = "False",
							name = "Image_bg",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							texturePath = "ui/common/mini_pop/9.png",
							touchAble = "False",
							UILayoutViewModel = 
							{
								PositionX = 568,
								PositionY = 320,
								IsPercent = true,
								PercentX = 50,
								PercentY = 50,
							},
							width = "600",
							ZOrder = "1",
							components = 
							{
								
								{
									controlID = "Label_title_Image_bg_Panel_root_Panel-knowledgeConfirm_Layer1_explore_Game",
									UUID = "fd4a1399_be53_4280_ae7a_f3769c3f0476",
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
									text = "Confirmer",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionX = -278,
										PositionY = 160,
									},
									width = "107",
									ZOrder = "1",
								},
								{
									controlID = "Image_Bosstipbg_Image_bg_Panel_root_Panel-knowledgeConfirm_Layer1_explore_Game",
									UUID = "e2af2a6a_6391_426f_9b13_2cccf5c10b91",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "True;capInsetsX:0;capInsetsY:0;capInsetsWidth:0;capInsetsHeight:0",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "80",
									ignoreSize = "False",
									name = "Image_Bosstipbg",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/common/pop_ui/pop_ui_04.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionY = 16,
									},
									visible = "False",
									width = "380",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "Label_tip_Image_Bosstipbg_Image_bg_Panel_root_Panel-knowledgeConfirm_Layer1_explore_Game",
											UUID = "e604dbe8_147d_4cdf_8885_23822e912fa9",
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
											height = "70",
											ignoreSize = "False",
											name = "Label_tip",
											nTextAlign = "1",
											nTextHAlign = "0",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "770",
											text = "TextLable",
											touchAble = "False",
											touchScaleEnable = "False",
											UILayoutViewModel = 
											{
												
											},
											width = "330",
											ZOrder = "1",
										},
									},
								},
								{
									controlID = "Button_ok_Image_bg_Panel_root_Panel-knowledgeConfirm_Layer1_explore_Game",
									UUID = "908f5fc6_a09f_46c1_ae5d_d392f7025080",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "True;capInsetsX:0;capInsetsY:0;capInsetsWidth:0;capInsetsHeight:0",
									classname = "MEButton",
									ClickHighLightEnabled = "True",
									dstBlendFunc = "771",
									flipX = "False",
									flipY = "False",
									height = "50",
									ignoreSize = "False",
									name = "Button_ok",
									normal = "ui/common/button09.png",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "True",
									UILayoutViewModel = 
									{
										PositionX = 221,
										PositionY = -154,
									},
									UItype = "Button",
									width = "120",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "Label_btn_Button_ok_Image_bg_Panel_root_Panel-knowledgeConfirm_Layer1_explore_Game",
											UUID = "074283e7_bdca_46d0_914e_b05a2cff46d4",
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
											fontSize = "26",
											fontStroke = 
											{
												IsStroke = true,
												StrokeColor = "#1BB2475D",
												StrokeSize = 0.3,
											},
											height = "30",
											ignoreSize = "True",
											name = "Label_btn",
											nTextAlign = "1",
											nTextHAlign = "1",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "770",
											text = "学习",
											touchAble = "False",
											touchScaleEnable = "False",
											UILayoutViewModel = 
											{
												
											},
											width = "53",
											ZOrder = "1",
										},
									},
								},
								{
									controlID = "Label_name_Image_bg_Panel_root_Panel-knowledgeConfirm_Layer1_explore_Game",
									UUID = "99a54e49_de47_48f4_8dc5_18997f03e1fe",
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
									name = "Label_name",
									nTextAlign = "1",
									nTextHAlign = "1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "boss名字",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionX = -232,
										PositionY = 112,
									},
									width = "83",
									ZOrder = "1",
								},
								{
									controlID = "Label_desc_Image_bg_Panel_root_Panel-knowledgeConfirm_Layer1_explore_Game",
									UUID = "06502e23_c432_4238_8287_e711b2de9891",
									anchorPoint = "False",
									anchorPointX = "0",
									anchorPointY = "1",
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
									height = "60",
									ignoreSize = "False",
									name = "Label_desc",
									nTextAlign = "0",
									nTextHAlign = "0",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "作战掉落",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionX = -272,
										PositionY = 91,
									},
									width = "400",
									ZOrder = "1",
								},
								{
									controlID = "Label_tip_Image_bg_Panel_root_Panel-knowledgeConfirm_Layer1_explore_Game",
									UUID = "6795b5db_43e4_49f0_a20b_9799ada253f9",
									anchorPoint = "False",
									anchorPointX = "0",
									anchorPointY = "1",
									classname = "MELabel",
									compPath = "luacomponents.common.MEIconLabel",
									dstBlendFunc = "771",
									FontColor = "#FF00BFFF",
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
									name = "Label_tip",
									nTextAlign = "0",
									nTextHAlign = "0",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "知识效果",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionX = -270,
										PositionY = 25,
									},
									width = "83",
									ZOrder = "1",
								},
								{
									controlID = "Label_effect_Image_bg_Panel_root_Panel-knowledgeConfirm_Layer1_explore_Game",
									UUID = "4c57f316_e640_486f_afe6_2ed7b5609737",
									anchorPoint = "False",
									anchorPointX = "0",
									anchorPointY = "1",
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
									name = "Label_effect",
									nTextAlign = "0",
									nTextHAlign = "0",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "提升3阶品质奖励权重200",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionX = -270,
										PositionY = -4,
									},
									width = "227",
									ZOrder = "1",
								},
								{
									controlID = "Panel_next_Image_bg_Panel_root_Panel-knowledgeConfirm_Layer1_explore_Game",
									UUID = "146c7877_50fb_47bf_b9fd_c1c58f4b3634",
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
									height = "80",
									ignoreSize = "False",
									name = "Panel_next",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = -146,
										PositionY = -82,
									},
									uipanelviewmodel = 
									{
										Layout="Absolute",
										nType = "0"
									},
									visible = "False",
									width = "250",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "Label_tip_Panel_next_Image_bg_Panel_root_Panel-knowledgeConfirm_Layer1_explore_Game",
											UUID = "a56080d8_b776_4ae0_a75b_2dd2fa277345",
											anchorPoint = "False",
											anchorPointX = "0",
											anchorPointY = "1",
											classname = "MELabel",
											compPath = "luacomponents.common.MEIconLabel",
											dstBlendFunc = "771",
											FontColor = "#FF00BFFF",
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
											name = "Label_tip",
											nTextAlign = "0",
											nTextHAlign = "0",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "770",
											text = "下一级",
											touchAble = "False",
											touchScaleEnable = "False",
											UILayoutViewModel = 
											{
												PositionX = -123,
												PositionY = 30,
											},
											width = "63",
											ZOrder = "1",
										},
										{
											controlID = "Label_next_effect_Panel_next_Image_bg_Panel_root_Panel-knowledgeConfirm_Layer1_explore_Game",
											UUID = "f749714e_03df_4a3f_b1b2_00454b6e8c1d",
											anchorPoint = "False",
											anchorPointX = "0",
											anchorPointY = "1",
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
											name = "Label_next_effect",
											nTextAlign = "0",
											nTextHAlign = "0",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "770",
											text = "提升3阶品质奖励权重200",
											touchAble = "False",
											touchScaleEnable = "False",
											UILayoutViewModel = 
											{
												PositionX = -123,
												PositionY = -4,
											},
											width = "227",
											ZOrder = "1",
										},
									},
								},
								{
									controlID = "Panel_lock_Image_bg_Panel_root_Panel-knowledgeConfirm_Layer1_explore_Game",
									UUID = "6ce192f7_0a75_4453_b77e_74961dd30b23",
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
									height = "80",
									ignoreSize = "False",
									name = "Panel_lock",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = -145,
										PositionY = -81,
									},
									uipanelviewmodel = 
									{
										Layout="Absolute",
										nType = "0"
									},
									width = "250",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "Label_tip_Panel_lock_Image_bg_Panel_root_Panel-knowledgeConfirm_Layer1_explore_Game",
											UUID = "09f331bf_d328_4c7b_aa95_c31594673b18",
											anchorPoint = "False",
											anchorPointX = "0",
											anchorPointY = "1",
											classname = "MELabel",
											compPath = "luacomponents.common.MEIconLabel",
											dstBlendFunc = "771",
											FontColor = "#FFFF0000",
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
											name = "Label_tip",
											nTextAlign = "0",
											nTextHAlign = "0",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "770",
											text = "Conditions pour débloquer",
											touchAble = "False",
											touchScaleEnable = "False",
											UILayoutViewModel = 
											{
												PositionX = -124,
												PositionY = 30,
											},
											width = "83",
											ZOrder = "1",
										},
										{
											controlID = "ScrollView_condition_Panel_lock_Image_bg_Panel_root_Panel-knowledgeConfirm_Layer1_explore_Game",
											UUID = "13c93dd5_e681_447c_8ea7_1a67e7a9db15",
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
											height = "77",
											ignoreSize = "False",
											innerHeight = "77",
											innerWidth = "250",
											name = "ScrollView_condition",
											showScrollbar = "False",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "True",
											UILayoutViewModel = 
											{
												PositionX = -123,
												PositionY = -82,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "250",
											ZOrder = "1",
										},
										{
											controlID = "Label_condition_Panel_lock_Image_bg_Panel_root_Panel-knowledgeConfirm_Layer1_explore_Game",
											UUID = "a673d6cb_a9ec_488b_8fdf_ce1d5764b7bc",
											anchorPoint = "False",
											anchorPointX = "0",
											anchorPointY = "1",
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
											name = "Label_condition",
											nTextAlign = "0",
											nTextHAlign = "0",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "770",
											text = "提升3阶品质奖励权重200",
											touchAble = "False",
											touchScaleEnable = "False",
											UILayoutViewModel = 
											{
												PositionX = -123,
												PositionY = -4,
											},
											width = "227",
											ZOrder = "1",
										},
									},
								},
								{
									controlID = "Panel_cost_Image_bg_Panel_root_Panel-knowledgeConfirm_Layer1_explore_Game",
									UUID = "1b8e1bba_b630_4ce2_8a78_afb116181f9d",
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
									height = "50",
									ignoreSize = "False",
									name = "Panel_cost",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = 10,
										PositionY = -181,
									},
									uipanelviewmodel = 
									{
										Layout="Absolute",
										nType = "0"
									},
									width = "150",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "Image_cost_Panel_cost_Image_bg_Panel_root_Panel-knowledgeConfirm_Layer1_explore_Game",
											UUID = "378a4fa4_ac4c_476b_bdf7_6753845ca1f8",
											anchorPoint = "False",
											anchorPointX = "1",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											classname = "MEImage",
											dstBlendFunc = "771",
											height = "100",
											ignoreSize = "True",
											name = "Image_cost",
											scaleX = "0.4",
											scaleY = "0.4",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											texturePath = "icon/item/goods/500066.png",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 66,
												PositionY = 23,
											},
											width = "100",
											ZOrder = "1",
										},
										{
											controlID = "Label_cost_Panel_cost_Image_bg_Panel_root_Panel-knowledgeConfirm_Layer1_explore_Game",
											UUID = "79a41717_e1b6_45ac_a049_7c555e00fb0d",
											anchorPoint = "False",
											anchorPointX = "1",
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
											fontSize = "22",
											fontStroke = 
											{
												IsStroke = false,
												StrokeColor = "#FFE6E6E6",
												StrokeSize = 1,
											},
											height = "25",
											ignoreSize = "True",
											name = "Label_cost",
											nTextAlign = "1",
											nTextHAlign = "1",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "770",
											text = "18843-10",
											touchAble = "False",
											touchScaleEnable = "False",
											UILayoutViewModel = 
											{
												PositionX = 148,
												PositionY = 24,
											},
											width = "92",
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
			"ui/common/mini_pop/9.png",
			"ui/common/pop_ui/pop_ui_04.png",
			"ui/common/button09.png",
			"icon/item/goods/500066.png",
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

