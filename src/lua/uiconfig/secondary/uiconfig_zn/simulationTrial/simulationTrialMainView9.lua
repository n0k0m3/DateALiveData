local t = 
{
	version = 1,
	components = 
	{
		
		{
			controlID = "Panel-simulationTrialMainView9_style4_simulationTrial_Game",
			UUID = "d68a9175_3283_42b3_a719_53360722b885",
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
					controlID = "Panel_root_Panel-simulationTrialMainView9_style4_simulationTrial_Game",
					UUID = "609587c3_7b41_4d3c_8a3a_272a21663177",
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
						PositionX = 480,
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
							controlID = "Image_background_Panel_root_Panel-simulationTrialMainView9_style4_simulationTrial_Game",
							UUID = "92c518a2_00bf_4e6b_9c9e_4481d5ad62ab",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							backGroundScale9Enable = "False",
							classname = "MEImage",
							dstBlendFunc = "771",
							height = "640",
							ignoreSize = "True",
							name = "Image_background",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							texturePath = "ui/simulation_trial9/bg2.png",
							touchAble = "False",
							UILayoutViewModel = 
							{
								LeftPositon = 1571,
								TopPosition = -386,
								relativeToName = "Panel",
							},
							width = "1386",
							ZOrder = "1",
						},
						{
							controlID = "Spine_effect_title_Panel_root_Panel-simulationTrialMainView9_style4_simulationTrial_Game",
							UUID = "d6008fc0_93b9_4517_be9a_109073ef61a0",
							classname = "MESpine",
							dstBlendFunc = "771",
							name = "Spine_effect_title",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							spineModel = 
							{
								SpinePath = "effect/eff_MNSL_rukou/eff_MNSL_rukou",
								animationName = "animation",
								IsLoop = true,
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
								PositionX = 1,
								PositionY = 1,
							},
							visible = "False",
							ZOrder = "1",
						},
						{
							controlID = "Image_role_Panel_root_Panel-simulationTrialMainView9_style4_simulationTrial_Game",
							UUID = "f56821f7_c416_4cd1_bedc_ef10bf1b86d9",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0",
							backGroundScale9Enable = "False",
							classname = "MEImage",
							dstBlendFunc = "771",
							height = "64",
							ignoreSize = "True",
							name = "Image_role",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							touchAble = "False",
							UILayoutViewModel = 
							{
								PositionX = -192,
								PositionY = -33,
							},
							width = "64",
							ZOrder = "2",
						},
						{
							controlID = "Image_font1_Panel_root_Panel-simulationTrialMainView9_style4_simulationTrial_Game",
							UUID = "0d930993_77c4_4d6e_9c83_c02968089c5d",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							backGroundScale9Enable = "False",
							classname = "MEImage",
							dstBlendFunc = "771",
							height = "88",
							ignoreSize = "True",
							name = "Image_font1",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							texturePath = "ui/simulation_trial9/002.png",
							touchAble = "False",
							UILayoutViewModel = 
							{
								PositionX = 319,
								PositionY = 182,
							},
							width = "292",
							ZOrder = "1",
							components = 
							{
								
								{
									controlID = "Label_time_Image_font1_Panel_root_Panel-simulationTrialMainView9_style4_simulationTrial_Game",
									UUID = "7c92e6ed_abcd_4338_be3a_0f085365e8c5",
									anchorPoint = "False",
									anchorPointX = "0",
									anchorPointY = "0.5",
									classname = "MELabel",
									compPath = "luacomponents.common.MEIconLabel",
									dstBlendFunc = "771",
									FontColor = "#FFADD8E6",
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
									name = "Label_time",
									nTextAlign = "1",
									nTextHAlign = "1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "3月26日-4月12日",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionX = 75,
										PositionY = -17,
									},
									width = "184",
									ZOrder = "1",
								},
							},
						},
						{
							controlID = "Image_front1_Panel_root_Panel-simulationTrialMainView9_style4_simulationTrial_Game",
							UUID = "a5b6475c_c10c_40d2_95f2_ea1799034cbb",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "1",
							backGroundScale9Enable = "False",
							classname = "MEImage",
							dstBlendFunc = "771",
							height = "117",
							ignoreSize = "True",
							name = "Image_front1",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							texturePath = "ui/simulation_trial2/bg2.png",
							touchAble = "False",
							UILayoutViewModel = 
							{
								PositionY = 320,
							},
							width = "1386",
							ZOrder = "1",
						},
						{
							controlID = "Image_front2_Panel_root_Panel-simulationTrialMainView9_style4_simulationTrial_Game",
							UUID = "c95ef4f4_4df3_45ad_96bf_230f7555b751",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							backGroundScale9Enable = "False",
							classname = "MEImage",
							dstBlendFunc = "771",
							height = "50",
							ignoreSize = "True",
							name = "Image_front2",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							texturePath = "ui/simulation_trial6/touming.png",
							touchAble = "False",
							UILayoutViewModel = 
							{
								PositionX = 240,
								PositionY = -46,
							},
							visible = "False",
							width = "50",
							ZOrder = "1",
						},
						{
							controlID = "Image_font2_Panel_root_Panel-simulationTrialMainView9_style4_simulationTrial_Game",
							UUID = "c6d08def_c7c4_4905_9017_2121f4e48177",
							anchorPoint = "False",
							anchorPointX = "0",
							anchorPointY = "0.5",
							backGroundScale9Enable = "False",
							classname = "MEImage",
							dstBlendFunc = "771",
							height = "58",
							ignoreSize = "True",
							name = "Image_font2",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							texturePath = "ui/simulation_trial9/003.png",
							touchAble = "False",
							UILayoutViewModel = 
							{
								PositionX = -553,
								PositionY = -280,
							},
							width = "254",
							ZOrder = "1",
						},
						{
							controlID = "Label_title_Panel_root_Panel-simulationTrialMainView9_style4_simulationTrial_Game",
							UUID = "a2b1766a_f6dd_4429_ad69_dbb6e673a932",
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
							fontSize = "30",
							fontStroke = 
							{
								IsStroke = false,
								StrokeColor = "#FFE6E6E6",
								StrokeSize = 1,
							},
							height = "37",
							ignoreSize = "True",
							name = "Label_title",
							nTextAlign = "1",
							nTextHAlign = "1",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "770",
							text = "精灵猎手",
							touchAble = "False",
							touchScaleEnable = "False",
							UILayoutViewModel = 
							{
								PositionX = 300,
								PositionY = 204,
							},
							visible = "False",
							width = "124",
							ZOrder = "1",
						},
						{
							controlID = "Label_desc_Panel_root_Panel-simulationTrialMainView9_style4_simulationTrial_Game",
							UUID = "dfe9903a_cbca_4521_9f7c_da3c1f6dd544",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							classname = "MELabel",
							compPath = "luacomponents.common.MEIconLabel",
							dstBlendFunc = "771",
							FontColor = "#FFADD8E6",
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
								IsStroke = true,
								StrokeColor = "#FF252942",
								StrokeSize = 1,
							},
							height = "140",
							ignoreSize = "False",
							name = "Label_desc",
							nTextAlign = "0",
							nTextHAlign = "0",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "770",
							text = "--章节描述",
							touchAble = "False",
							touchScaleEnable = "False",
							UILayoutViewModel = 
							{
								PositionX = 359,
								PositionY = 56,
							},
							width = "311",
							ZOrder = "1",
						},
						{
							controlID = "Button_strategy_Panel_root_Panel-simulationTrialMainView9_style4_simulationTrial_Game",
							UUID = "9e1b7a58_9151_4a7f_b551_56637d618bf9",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							backGroundScale9Enable = "False",
							classname = "MEButton",
							ClickHighLightEnabled = "True",
							dstBlendFunc = "771",
							flipX = "False",
							flipY = "False",
							height = "59",
							ignoreSize = "True",
							name = "Button_strategy",
							normal = "ui/simulation_trial/icon4.png",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							touchAble = "True",
							UILayoutViewModel = 
							{
								PositionX = -531,
								PositionY = -125,
							},
							UItype = "Button",
							width = "39",
							ZOrder = "2",
							components = 
							{
								
								{
									controlID = "Image_redpoint_Button_strategy_Panel_root_Panel-simulationTrialMainView9_style4_simulationTrial_Game",
									UUID = "252f09af_b3f4_460f_a67f_bb5a09c1fd84",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "30",
									ignoreSize = "True",
									name = "Image_redpoint",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/common/news_small.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = 14,
										PositionY = 16,
									},
									width = "30",
									ZOrder = "1",
								},
							},
						},
						{
							controlID = "Button_view_role_Panel_root_Panel-simulationTrialMainView9_style4_simulationTrial_Game",
							UUID = "b7092655_7545_4725_b877_4f34f5fd4216",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							backGroundScale9Enable = "False",
							classname = "MEButton",
							ClickHighLightEnabled = "True",
							dstBlendFunc = "771",
							flipX = "False",
							flipY = "False",
							height = "104",
							ignoreSize = "True",
							name = "Button_view_role",
							normal = "ui/simulation_trial9/005.png",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							touchAble = "True",
							UILayoutViewModel = 
							{
								PositionX = 476,
								PositionY = -95,
							},
							UItype = "Button",
							width = "104",
							ZOrder = "2",
							components = 
							{
								
								{
									controlID = "Label_name_Button_view_role_Panel_root_Panel-simulationTrialMainView9_style4_simulationTrial_Game",
									UUID = "e65a594a_0342_4da7_a57d_094031cc3455",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									classname = "MELabel",
									compPath = "luacomponents.common.MEIconLabel",
									dstBlendFunc = "771",
									FontColor = "#FF34566A",
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
									name = "Label_name",
									nTextAlign = "1",
									nTextHAlign = "1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "成长",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionX = 41,
										PositionY = -45,
									},
									width = "55",
									ZOrder = "1",
								},
								{
									controlID = "Label_name_en_Button_view_role_Panel_root_Panel-simulationTrialMainView9_style4_simulationTrial_Game",
									UUID = "c047216b_3c70_447c_aa82_64e65e03beb1",
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
									fontSize = "14",
									fontStroke = 
									{
										IsStroke = false,
										StrokeColor = "#FFE6E6E6",
										StrokeSize = 1,
									},
									height = "16",
									ignoreSize = "True",
									name = "Label_name_en",
									nTextAlign = "1",
									nTextHAlign = "1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "G r o w t h",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionX = 45,
										PositionY = -66,
									},
									width = "65",
									ZOrder = "1",
								},
								{
									controlID = "Image_redpoint_Button_view_role_Panel_root_Panel-simulationTrialMainView9_style4_simulationTrial_Game",
									UUID = "40510915_8e16_4a3d_85d7_12314f5e80df",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "30",
									ignoreSize = "True",
									name = "Image_redpoint",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/common/news_small.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = 67,
										PositionY = -27,
									},
									width = "30",
									ZOrder = "1",
								},
							},
						},
						{
							controlID = "Button_enter_funben_Panel_root_Panel-simulationTrialMainView9_style4_simulationTrial_Game",
							UUID = "596bc24b_09b9_46af_9f3d_e1f054f81f1e",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							backGroundScale9Enable = "False",
							classname = "MEButton",
							ClickHighLightEnabled = "True",
							dstBlendFunc = "771",
							flipX = "False",
							flipY = "False",
							height = "104",
							ignoreSize = "True",
							name = "Button_enter_funben",
							normal = "ui/simulation_trial9/004.png",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							touchAble = "True",
							UILayoutViewModel = 
							{
								PositionX = 351,
								PositionY = -220,
							},
							UItype = "Button",
							width = "104",
							ZOrder = "2",
							components = 
							{
								
								{
									controlID = "Label_name_Button_enter_funben_Panel_root_Panel-simulationTrialMainView9_style4_simulationTrial_Game",
									UUID = "83d6033a_2d28_4c46_8cb6_2ccfe8aded31",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									classname = "MELabel",
									compPath = "luacomponents.common.MEIconLabel",
									dstBlendFunc = "771",
									FontColor = "#FF34566A",
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
									name = "Label_name",
									nTextAlign = "1",
									nTextHAlign = "1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "章节",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionX = 52,
										PositionY = -37,
									},
									width = "55",
									ZOrder = "1",
								},
								{
									controlID = "Label_name_en_Button_enter_funben_Panel_root_Panel-simulationTrialMainView9_style4_simulationTrial_Game",
									UUID = "482a63d5_d721_41ed_971c_cbbd2a46485e",
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
									fontSize = "14",
									fontStroke = 
									{
										IsStroke = false,
										StrokeColor = "#FFE6E6E6",
										StrokeSize = 1,
									},
									height = "16",
									ignoreSize = "True",
									name = "Label_name_en",
									nTextAlign = "1",
									nTextHAlign = "1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "C h a p t e r",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionX = 32,
										PositionY = -58,
									},
									width = "75",
									ZOrder = "1",
								},
								{
									controlID = "Image_redpoint_Button_enter_funben_Panel_root_Panel-simulationTrialMainView9_style4_simulationTrial_Game",
									UUID = "524102c2_1477_4a5a_bd95_e10ad0b88243",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "30",
									ignoreSize = "True",
									name = "Image_redpoint",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/common/news_small.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = 80,
										PositionY = -18,
									},
									width = "30",
									ZOrder = "1",
								},
							},
						},
						{
							controlID = "Button_call_Panel_root_Panel-simulationTrialMainView9_style4_simulationTrial_Game",
							UUID = "e12f1395_75c9_4a44_a086_1c62aa044b59",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							backGroundScale9Enable = "False",
							classname = "MEButton",
							ClickHighLightEnabled = "True",
							dstBlendFunc = "771",
							flipX = "False",
							flipY = "False",
							height = "63",
							ignoreSize = "True",
							name = "Button_call",
							normal = "ui/simulation_trial/icon3.png",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							touchAble = "True",
							UILayoutViewModel = 
							{
								PositionX = -532,
								PositionY = -200,
							},
							UItype = "Button",
							width = "41",
							ZOrder = "1",
							components = 
							{
								
								{
									controlID = "Image_redpoint_Button_call_Panel_root_Panel-simulationTrialMainView9_style4_simulationTrial_Game",
									UUID = "17da6603_d907_4d27_8b8a_568d659a2739",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "30",
									ignoreSize = "True",
									name = "Image_redpoint",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/common/news_small.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = 14,
										PositionY = 16,
									},
									width = "30",
									ZOrder = "1",
								},
							},
						},
						{
							controlID = "Image_simulationTrialMainView6_1_Panel_root_Panel-simulationTrialMainView9_style4_simulationTrial_Game",
							UUID = "5395ec98_090c_4a95_af1d_726f43913b12",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							backGroundScale9Enable = "False",
							classname = "MEImage",
							dstBlendFunc = "771",
							height = "250",
							ignoreSize = "True",
							name = "Image_simulationTrialMainView6_1",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							texturePath = "ui/simulation_trial9/006.png",
							touchAble = "False",
							UILayoutViewModel = 
							{
								PositionX = 414,
								PositionY = -157,
								LeftPositon = 931,
								TopPosition = 331,
								relativeToName = "Panel",
							},
							width = "250",
							ZOrder = "1",
						},
						{
							controlID = "Image_describe_Panel_root_Panel-simulationTrialMainView9_style4_simulationTrial_Game",
							UUID = "6aa4493c_a1ae_451f_9feb_cfdd96d3408d",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							backGroundScale9Enable = "False",
							classname = "MEImage",
							dstBlendFunc = "771",
							height = "26",
							ignoreSize = "True",
							name = "Image_describe",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							texturePath = "ui/simulation_trial9/001.png",
							touchAble = "False",
							UILayoutViewModel = 
							{
								PositionX = 191,
								PositionY = -45,
							},
							width = "312",
							ZOrder = "3",
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
			"ui/simulation_trial9/bg2.png",
			"ui/simulation_trial9/002.png",
			"ui/simulation_trial2/bg2.png",
			"ui/simulation_trial6/touming.png",
			"ui/simulation_trial9/003.png",
			"ui/simulation_trial/icon4.png",
			"ui/common/news_small.png",
			"ui/simulation_trial9/005.png",
			"ui/simulation_trial9/004.png",
			"ui/simulation_trial/icon3.png",
			"ui/simulation_trial9/006.png",
			"ui/simulation_trial9/001.png",
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

