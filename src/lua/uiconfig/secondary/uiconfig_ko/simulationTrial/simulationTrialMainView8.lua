local t = 
{
	version = 1,
	components = 
	{
		
		{
			controlID = "Panel-simulationTrialMainView8_style3_simulationTrial_Game",
			UUID = "c15832bb_eb18_4680_bcb9_bca73eaa85a1",
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
					controlID = "Panel_root_Panel-simulationTrialMainView8_style3_simulationTrial_Game",
					UUID = "1129e41c_4eba_479f_aad7_af595ec6aa82",
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
							controlID = "Image_background_Panel_root_Panel-simulationTrialMainView8_style3_simulationTrial_Game",
							UUID = "b86f38f7_4f5c_4edc_a4c3_e4ceb49d7fa8",
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
							texturePath = "ui/simulation_trial8/bg2.png",
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
							controlID = "Spine_effect_title_Panel_root_Panel-simulationTrialMainView8_style3_simulationTrial_Game",
							UUID = "c5e6bffb_817f_4698_8ca0_63b7bc9eebd4",
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
							controlID = "Image_role_Panel_root_Panel-simulationTrialMainView8_style3_simulationTrial_Game",
							UUID = "36da6499_ed6e_4516_a6de_7a26385da853",
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
								PositionX = -185,
								PositionY = -39,
							},
							width = "64",
							ZOrder = "2",
						},
						{
							controlID = "Image_font1_Panel_root_Panel-simulationTrialMainView8_style3_simulationTrial_Game",
							UUID = "b2a38b9a_5095_497b_8a28_212389bd654f",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							backGroundScale9Enable = "False",
							classname = "MEImage",
							dstBlendFunc = "771",
							height = "90",
							ignoreSize = "True",
							name = "Image_font1",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							texturePath = "ui/simulation_trial8/002.png",
							touchAble = "False",
							UILayoutViewModel = 
							{
								PositionX = 319,
								PositionY = 182,
							},
							width = "276",
							ZOrder = "3",
							components = 
							{
								
								{
									controlID = "Label_time_Image_font1_Panel_root_Panel-simulationTrialMainView8_style3_simulationTrial_Game",
									UUID = "2a3cbea0_f4f1_4158_8828_1b25e55c7282",
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
							controlID = "Image_front1_Panel_root_Panel-simulationTrialMainView8_style3_simulationTrial_Game",
							UUID = "0ffd9abe_8c95_4180_8304_734a209a46fc",
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
							controlID = "Image_front2_Panel_root_Panel-simulationTrialMainView8_style3_simulationTrial_Game",
							UUID = "68d23c26_8f54_4017_b766_a2e09cb5dacb",
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
							controlID = "Image_font2_Panel_root_Panel-simulationTrialMainView8_style3_simulationTrial_Game",
							UUID = "77e5ac94_d7c0_4277_9909_d25486e8a0bf",
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
							texturePath = "ui/simulation_trial8/003.png",
							touchAble = "False",
							UILayoutViewModel = 
							{
								PositionX = -553,
								PositionY = -280,
							},
							width = "248",
							ZOrder = "1",
						},
						{
							controlID = "Label_title_Panel_root_Panel-simulationTrialMainView8_style3_simulationTrial_Game",
							UUID = "b442767e_0c96_466e_8dc2_e3b7d890df58",
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
							text = "정령 사냥꾼",
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
							controlID = "Label_desc_Panel_root_Panel-simulationTrialMainView8_style3_simulationTrial_Game",
							UUID = "ce150cb9_8057_47b6_afb8_99ea14d78247",
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
							text = "챕터 설명",
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
							controlID = "Button_strategy_Panel_root_Panel-simulationTrialMainView8_style3_simulationTrial_Game",
							UUID = "b692e0f7_cf46_483c_90df_1f9eba4c46d7",
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
									controlID = "Image_redpoint_Button_strategy_Panel_root_Panel-simulationTrialMainView8_style3_simulationTrial_Game",
									UUID = "48137059_3197_4623_aede_7fcfbdd61f30",
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
							controlID = "Button_view_role_Panel_root_Panel-simulationTrialMainView8_style3_simulationTrial_Game",
							UUID = "a47d387c_363c_4dd1_bdfc_c3d9961ad804",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							backGroundScale9Enable = "False",
							classname = "MEButton",
							ClickHighLightEnabled = "True",
							dstBlendFunc = "771",
							flipX = "False",
							flipY = "False",
							height = "150",
							ignoreSize = "True",
							name = "Button_view_role",
							normal = "ui/simulation_trial8/005.png",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							touchAble = "True",
							UILayoutViewModel = 
							{
								PositionX = 472,
								PositionY = -95,
							},
							UItype = "Button",
							width = "150",
							ZOrder = "2",
							components = 
							{
								
								{
									controlID = "Label_name_Button_view_role_Panel_root_Panel-simulationTrialMainView8_style3_simulationTrial_Game",
									UUID = "29d4cb5d_a4bc_4508_980b_d8751aa0db10",
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
									fontSize = "26",
									fontStroke = 
									{
										IsStroke = true,
										StrokeColor = "#FF295CD7",
										StrokeSize = 1,
									},
									height = "34",
									ignoreSize = "True",
									name = "Label_name",
									nTextAlign = "1",
									nTextHAlign = "1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "성장",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionX = 41,
										PositionY = -45,
									},
									width = "56",
									ZOrder = "1",
								},
								{
									controlID = "Label_name_en_Button_view_role_Panel_root_Panel-simulationTrialMainView8_style3_simulationTrial_Game",
									UUID = "e64f5744_fb52_4c62_95dd_f85c62273746",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									classname = "MELabel",
									compPath = "luacomponents.common.MEIconLabel",
									dstBlendFunc = "771",
									FontColor = "#FF40468D",
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
									controlID = "Image_redpoint_Button_view_role_Panel_root_Panel-simulationTrialMainView8_style3_simulationTrial_Game",
									UUID = "aa2a0430_de4e_4d5d_92f2_f54ecac75725",
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
							controlID = "Button_enter_funben_Panel_root_Panel-simulationTrialMainView8_style3_simulationTrial_Game",
							UUID = "ea496a48_6c9e_44b1_b31a_8d0ce168edf6",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							backGroundScale9Enable = "False",
							classname = "MEButton",
							ClickHighLightEnabled = "True",
							dstBlendFunc = "771",
							flipX = "False",
							flipY = "False",
							height = "134",
							ignoreSize = "True",
							name = "Button_enter_funben",
							normal = "ui/simulation_trial8/004.png",
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
							width = "134",
							ZOrder = "2",
							components = 
							{
								
								{
									controlID = "Label_name_Button_enter_funben_Panel_root_Panel-simulationTrialMainView8_style3_simulationTrial_Game",
									UUID = "7f686222_4e71_411e_8bf3_78eba8d2790b",
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
									fontSize = "26",
									fontStroke = 
									{
										IsStroke = true,
										StrokeColor = "#FF2957CD",
										StrokeSize = 1,
									},
									height = "34",
									ignoreSize = "True",
									name = "Label_name",
									nTextAlign = "1",
									nTextHAlign = "1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "챕터",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionX = 52,
										PositionY = -37,
									},
									width = "56",
									ZOrder = "1",
								},
								{
									controlID = "Label_name_en_Button_enter_funben_Panel_root_Panel-simulationTrialMainView8_style3_simulationTrial_Game",
									UUID = "470b7d37_17b9_4fea_9757_0d9e071f0cac",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									classname = "MELabel",
									compPath = "luacomponents.common.MEIconLabel",
									dstBlendFunc = "771",
									FontColor = "#FF40468D",
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
									controlID = "Image_redpoint_Button_enter_funben_Panel_root_Panel-simulationTrialMainView8_style3_simulationTrial_Game",
									UUID = "1b180bab_f737_4bf1_ad14_f81eacb70a53",
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
							controlID = "Button_call_Panel_root_Panel-simulationTrialMainView8_style3_simulationTrial_Game",
							UUID = "b6593884_c388_48e5_a44d_7ad27678f6e3",
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
									controlID = "Image_redpoint_Button_call_Panel_root_Panel-simulationTrialMainView8_style3_simulationTrial_Game",
									UUID = "96af2b37_85ad_4fce_900f_fd755953863f",
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
							controlID = "Image_simulationTrialMainView6_1_Panel_root_Panel-simulationTrialMainView8_style3_simulationTrial_Game",
							UUID = "0e4d4cd3_bbca_4761_89c7_0689174ebaa5",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							backGroundScale9Enable = "False",
							classname = "MEImage",
							dstBlendFunc = "771",
							height = "254",
							ignoreSize = "True",
							name = "Image_simulationTrialMainView6_1",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							texturePath = "ui/simulation_trial8/006.png",
							touchAble = "False",
							UILayoutViewModel = 
							{
								PositionX = 417,
								PositionY = -153,
								LeftPositon = 931,
								TopPosition = 331,
								relativeToName = "Panel",
							},
							width = "248",
							ZOrder = "1",
						},
						{
							controlID = "Image_describe_Panel_root_Panel-simulationTrialMainView8_style3_simulationTrial_Game",
							UUID = "c71a01b3_03b6_48cf_830b_71e2f32faa67",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							backGroundScale9Enable = "False",
							classname = "MEImage",
							dstBlendFunc = "771",
							height = "28",
							ignoreSize = "True",
							name = "Image_describe",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							texturePath = "ui/simulation_trial8/001.png",
							touchAble = "False",
							UILayoutViewModel = 
							{
								PositionX = 191,
								PositionY = -45,
							},
							width = "306",
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
			"ui/simulation_trial8/bg2.png",
			"ui/simulation_trial8/002.png",
			"ui/simulation_trial2/bg2.png",
			"ui/simulation_trial6/touming.png",
			"ui/simulation_trial8/003.png",
			"ui/simulation_trial/icon4.png",
			"ui/common/news_small.png",
			"ui/simulation_trial8/005.png",
			"ui/simulation_trial8/004.png",
			"ui/simulation_trial/icon3.png",
			"ui/simulation_trial8/006.png",
			"ui/simulation_trial8/001.png",
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

