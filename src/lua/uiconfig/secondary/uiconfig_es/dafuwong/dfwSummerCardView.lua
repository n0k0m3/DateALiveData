local t = 
{
	version = 1,
	components = 
	{
		
		{
			controlID = "Panel-dfwSummerCardView_Layer2_dafuwong_Game",
			UUID = "a043d8e3_febd_43d9_a48e_d6eb2766bf7b",
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
					controlID = "Panel_root_Panel-dfwSummerCardView_Layer2_dafuwong_Game",
					UUID = "72ca78c5_7cc1_463d_8aa5_b21c7881a26b",
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
							controlID = "Panel_card_1_Panel_root_Panel-dfwSummerCardView_Layer2_dafuwong_Game",
							UUID = "8efd1682_3c4b_4b68_bec1_adabafed832a",
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
							height = "397",
							ignoreSize = "False",
							name = "Panel_card_1",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							touchAble = "False",
							UILayoutViewModel = 
							{
								PositionX = -352,
								PositionY = 67,
							},
							uipanelviewmodel = 
							{
								Layout="Absolute",
								nType = "0"
							},
							width = "276",
							ZOrder = "1",
							components = 
							{
								
								{
									controlID = "Spine_down_Panel_card_1_Panel_root_Panel-dfwSummerCardView_Layer2_dafuwong_Game",
									UUID = "9ac4f95d_83f0_48f4_bfe8_28b21382344a",
									classname = "MESpine",
									dstBlendFunc = "771",
									name = "Spine_down",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									spineModel = 
									{
										SpinePath = "effect/ui_effect_cardGround/ui_effect_cardGround",
										animationName = "BUFF_down",
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
										PositionX = 11,
										PositionY = -24,
										relativeToName = "Panel",
									},
									ZOrder = "1",
								},
								{
									controlID = "Button_card_Panel_card_1_Panel_root_Panel-dfwSummerCardView_Layer2_dafuwong_Game",
									UUID = "e9bbe292_e7d4_4ee1_a0c5_f99503c53ac7",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEButton",
									ClickHighLightEnabled = "True",
									dstBlendFunc = "771",
									flipX = "False",
									flipY = "False",
									height = "388",
									ignoreSize = "True",
									name = "Button_card",
									normal = "ui/dfwsummer/card/004.png",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "True",
									UILayoutViewModel = 
									{
										
									},
									UItype = "Button",
									width = "282",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "Label_title_Button_card_Panel_card_1_Panel_root_Panel-dfwSummerCardView_Layer2_dafuwong_Game",
											UUID = "2c3c3abe_5238_4ec9_8cfd_12dd07cdf608",
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
											fontSize = "18",
											fontStroke = 
											{
												IsStroke = false,
												StrokeColor = "#FFE6E6E6",
												StrokeSize = 1,
											},
											height = "0",
											ignoreSize = "False",
											name = "Label_title",
											nTextAlign = "1",
											nTextHAlign = "1",
											rotation = "81",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "770",
											text = "Title Title",
											touchAble = "False",
											touchScaleEnable = "False",
											UILayoutViewModel = 
											{
												PositionX = 105,
												PositionY = 86,
											},
											width = "146",
											ZOrder = "1",
										},
									},
								},
								{
									controlID = "Spine_select_Panel_card_1_Panel_root_Panel-dfwSummerCardView_Layer2_dafuwong_Game",
									UUID = "674a8573_a091_4145_a711_644c6cbb8dca",
									classname = "MESpine",
									dstBlendFunc = "771",
									name = "Spine_select",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									spineModel = 
									{
										SpinePath = "effect/ui_effect_cardGround/ui_effect_cardGround",
										animationName = "BUFF_up",
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
										PositionX = 11,
										PositionY = -24,
									},
									ZOrder = "1",
								},
								{
									controlID = "Label_desc_Panel_card_1_Panel_root_Panel-dfwSummerCardView_Layer2_dafuwong_Game",
									UUID = "fd3feb8f_1e09_455e_8b48_052012f4cf6e",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									classname = "MELabel",
									compPath = "luacomponents.common.MEIconLabel",
									dstBlendFunc = "771",
									FontColor = "#FF345EAF",
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
									name = "Label_desc",
									nTextAlign = "0",
									nTextHAlign = "0",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "Next Dice Roll +3",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionX = -9,
										PositionY = -121,
									},
									width = "234",
									ZOrder = "1",
								},
								{
									controlID = "Button_use_Panel_card_1_Panel_root_Panel-dfwSummerCardView_Layer2_dafuwong_Game",
									UUID = "e9625c79_2054_46f8_8fc4_d02ea90cd14d",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEButton",
									ClickHighLightEnabled = "True",
									dstBlendFunc = "771",
									flipX = "False",
									flipY = "False",
									height = "54",
									ignoreSize = "True",
									name = "Button_use",
									normal = "ui/common/button_small_blue.png",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "True",
									UILayoutViewModel = 
									{
										PositionX = -17,
										PositionY = -283,
									},
									UItype = "Button",
									width = "124",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "Label_use_Button_use_Panel_card_1_Panel_root_Panel-dfwSummerCardView_Layer2_dafuwong_Game",
											UUID = "82468fe7_1e9b_46ab_ac0f_350c02741f4f",
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
												IsStroke = false,
												StrokeColor = "#FFE6E6E6",
												StrokeSize = 1,
											},
											height = "30",
											ignoreSize = "True",
											name = "Label_use",
											nTextAlign = "1",
											nTextHAlign = "1",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "770",
											text = "Use",
											touchAble = "False",
											touchScaleEnable = "False",
											UILayoutViewModel = 
											{
												PositionY = -3,
											},
											width = "40",
											ZOrder = "1",
										},
									},
								},
								{
									controlID = "Image_effect_Panel_card_1_Panel_root_Panel-dfwSummerCardView_Layer2_dafuwong_Game",
									UUID = "4e738d24_4ebc_4f6c_bff5_18b5a6a1ebe4",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "80",
									ignoreSize = "True",
									name = "Image_effect",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/dfwsummer/card/005.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = -17,
										PositionY = -344,
									},
									width = "278",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "Label_effect_Image_effect_Panel_card_1_Panel_root_Panel-dfwSummerCardView_Layer2_dafuwong_Game",
											UUID = "76d3cfdb_97e0_4138_bcef_d9d4c55237f5",
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
												IsStroke = true,
												StrokeColor = "#FF345EAF",
												StrokeSize = 1,
											},
											height = "0",
											ignoreSize = "False",
											name = "Label_effect",
											nTextAlign = "1",
											nTextHAlign = "1",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "770",
											text = "You are enjoying this buff",
											touchAble = "False",
											touchScaleEnable = "False",
											UILayoutViewModel = 
											{
												
											},
											width = "196",
											ZOrder = "1",
										},
									},
								},
								{
									controlID = "Image_num_bg_Panel_card_1_Panel_root_Panel-dfwSummerCardView_Layer2_dafuwong_Game",
									UUID = "c02a5498_a51b_4c16_9bc2_772cf5fb4308",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "28",
									ignoreSize = "True",
									name = "Image_num_bg",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/dfwsummer/card/001.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = -12,
										PositionY = -212,
									},
									width = "198",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "Label_num_Image_num_bg_Panel_card_1_Panel_root_Panel-dfwSummerCardView_Layer2_dafuwong_Game",
											UUID = "f704d47f_71fb_4362_a7b7_ee62ba7ab396",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											classname = "MELabel",
											compPath = "luacomponents.common.MEIconLabel",
											dstBlendFunc = "771",
											FontColor = "#FF345EAF",
											fontName = "font/MFLiHei_Noncommercial.ttf",
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
											name = "Label_num",
											nTextAlign = "1",
											nTextHAlign = "1",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "770",
											text = "5-6",
											touchAble = "False",
											touchScaleEnable = "False",
											UILayoutViewModel = 
											{
												PositionY = -3,
											},
											width = "35",
											ZOrder = "1",
										},
									},
								},
							},
						},
						{
							controlID = "Panel_card_2_Panel_root_Panel-dfwSummerCardView_Layer2_dafuwong_Game",
							UUID = "e51a484a_1fd7_4388_a70a_703587ae94ff",
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
							height = "397",
							ignoreSize = "False",
							name = "Panel_card_2",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							touchAble = "False",
							UILayoutViewModel = 
							{
								PositionX = -18,
								PositionY = 67,
							},
							uipanelviewmodel = 
							{
								Layout="Absolute",
								nType = "0"
							},
							width = "276",
							ZOrder = "1",
							components = 
							{
								
								{
									controlID = "Spine_down_Panel_card_2_Panel_root_Panel-dfwSummerCardView_Layer2_dafuwong_Game",
									UUID = "d2aa3bba_5635_486e_b6ce_e55c1e7ca5f3",
									classname = "MESpine",
									dstBlendFunc = "771",
									name = "Spine_down",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									spineModel = 
									{
										SpinePath = "effect/ui_effect_cardGround/ui_effect_cardGround",
										animationName = "BUFF_down",
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
										PositionX = 11,
										PositionY = -24,
										relativeToName = "Panel",
									},
									ZOrder = "1",
								},
								{
									controlID = "Button_card_Panel_card_2_Panel_root_Panel-dfwSummerCardView_Layer2_dafuwong_Game",
									UUID = "6632d5da_1ffb_4260_9028_3385017dcf30",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEButton",
									ClickHighLightEnabled = "True",
									dstBlendFunc = "771",
									flipX = "False",
									flipY = "False",
									height = "388",
									ignoreSize = "True",
									name = "Button_card",
									normal = "ui/dfwsummer/card/002.png",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "True",
									UILayoutViewModel = 
									{
										
									},
									UItype = "Button",
									width = "282",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "Label_title_Button_card_Panel_card_2_Panel_root_Panel-dfwSummerCardView_Layer2_dafuwong_Game",
											UUID = "fbeeed9c_d87c_4fcb_b85c_5efffc652c0c",
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
											fontSize = "18",
											fontStroke = 
											{
												IsStroke = false,
												StrokeColor = "#FFE6E6E6",
												StrokeSize = 1,
											},
											height = "0",
											ignoreSize = "False",
											name = "Label_title",
											nTextAlign = "1",
											nTextHAlign = "1",
											rotation = "81",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "770",
											text = "Title Title",
											touchAble = "False",
											touchScaleEnable = "False",
											UILayoutViewModel = 
											{
												PositionX = 105,
												PositionY = 86,
											},
											width = "146",
											ZOrder = "1",
										},
									},
								},
								{
									controlID = "Spine_select_Panel_card_2_Panel_root_Panel-dfwSummerCardView_Layer2_dafuwong_Game",
									UUID = "ee12cbac_f19e_4ebd_9e8f_d52f0dd9c15a",
									classname = "MESpine",
									dstBlendFunc = "771",
									name = "Spine_select",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									spineModel = 
									{
										SpinePath = "effect/ui_effect_cardGround/ui_effect_cardGround",
										animationName = "BUFF_up",
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
										PositionX = 11,
										PositionY = -24,
									},
									ZOrder = "1",
								},
								{
									controlID = "Label_desc_Panel_card_2_Panel_root_Panel-dfwSummerCardView_Layer2_dafuwong_Game",
									UUID = "fa53049b_8296_4f6d_88bb_fa746c058ae5",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									classname = "MELabel",
									compPath = "luacomponents.common.MEIconLabel",
									dstBlendFunc = "771",
									FontColor = "#FF345EAF",
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
									name = "Label_desc",
									nTextAlign = "0",
									nTextHAlign = "0",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "Next Dice Roll +3",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionX = -9,
										PositionY = -121,
									},
									width = "234",
									ZOrder = "1",
								},
								{
									controlID = "Button_use_Panel_card_2_Panel_root_Panel-dfwSummerCardView_Layer2_dafuwong_Game",
									UUID = "742a9e5e_9dc2_4aaa_92cb_19731234dafa",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEButton",
									ClickHighLightEnabled = "True",
									dstBlendFunc = "771",
									flipX = "False",
									flipY = "False",
									height = "54",
									ignoreSize = "True",
									name = "Button_use",
									normal = "ui/common/button_small_blue.png",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "True",
									UILayoutViewModel = 
									{
										PositionX = -17,
										PositionY = -283,
									},
									UItype = "Button",
									width = "124",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "Label_use_Button_use_Panel_card_2_Panel_root_Panel-dfwSummerCardView_Layer2_dafuwong_Game",
											UUID = "001e54a3_32b6_4dca_80c8_15a3c2696904",
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
												IsStroke = false,
												StrokeColor = "#FFE6E6E6",
												StrokeSize = 1,
											},
											height = "30",
											ignoreSize = "True",
											name = "Label_use",
											nTextAlign = "1",
											nTextHAlign = "1",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "770",
											text = "Use",
											touchAble = "False",
											touchScaleEnable = "False",
											UILayoutViewModel = 
											{
												PositionY = -3,
											},
											width = "40",
											ZOrder = "1",
										},
									},
								},
								{
									controlID = "Image_effect_Panel_card_2_Panel_root_Panel-dfwSummerCardView_Layer2_dafuwong_Game",
									UUID = "3763f27a_59be_41f2_bce3_b94aea3ca391",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "80",
									ignoreSize = "True",
									name = "Image_effect",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/dfwsummer/card/005.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = -17,
										PositionY = -344,
									},
									width = "278",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "Label_effect_Image_effect_Panel_card_2_Panel_root_Panel-dfwSummerCardView_Layer2_dafuwong_Game",
											UUID = "c6baa44a_3035_40e8_89c6_66215363fc9f",
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
												IsStroke = true,
												StrokeColor = "#FF345EAF",
												StrokeSize = 1,
											},
											height = "0",
											ignoreSize = "False",
											name = "Label_effect",
											nTextAlign = "1",
											nTextHAlign = "1",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "770",
											text = "You are enjoying this buff",
											touchAble = "False",
											touchScaleEnable = "False",
											UILayoutViewModel = 
											{
												
											},
											width = "196",
											ZOrder = "1",
										},
									},
								},
								{
									controlID = "Image_num_bg_Panel_card_2_Panel_root_Panel-dfwSummerCardView_Layer2_dafuwong_Game",
									UUID = "51bd4d19_fb2a_4eb8_8d76_3e2dc331fed7",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "28",
									ignoreSize = "True",
									name = "Image_num_bg",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/dfwsummer/card/001.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = -13,
										PositionY = -213,
									},
									width = "198",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "Label_num_Image_num_bg_Panel_card_2_Panel_root_Panel-dfwSummerCardView_Layer2_dafuwong_Game",
											UUID = "09eb6c17_8120_4e6e_b9d1_c80afe509b3b",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											classname = "MELabel",
											compPath = "luacomponents.common.MEIconLabel",
											dstBlendFunc = "771",
											FontColor = "#FF345EAF",
											fontName = "font/MFLiHei_Noncommercial.ttf",
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
											name = "Label_num",
											nTextAlign = "1",
											nTextHAlign = "1",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "770",
											text = "5-6",
											touchAble = "False",
											touchScaleEnable = "False",
											UILayoutViewModel = 
											{
												PositionY = -3,
											},
											width = "35",
											ZOrder = "1",
										},
									},
								},
							},
						},
						{
							controlID = "Panel_card_3_Panel_root_Panel-dfwSummerCardView_Layer2_dafuwong_Game",
							UUID = "3474693c_3153_4c72_840a_4d4a4138d3fb",
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
							height = "397",
							ignoreSize = "False",
							name = "Panel_card_3",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							touchAble = "False",
							UILayoutViewModel = 
							{
								PositionX = 315,
								PositionY = 67,
							},
							uipanelviewmodel = 
							{
								Layout="Absolute",
								nType = "0"
							},
							width = "276",
							ZOrder = "1",
							components = 
							{
								
								{
									controlID = "Spine_down_Panel_card_3_Panel_root_Panel-dfwSummerCardView_Layer2_dafuwong_Game",
									UUID = "e421b2ec_891c_4ae1_86ef_995ec129852d",
									classname = "MESpine",
									dstBlendFunc = "771",
									name = "Spine_down",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									spineModel = 
									{
										SpinePath = "effect/ui_effect_cardGround/ui_effect_cardGround",
										animationName = "BUFF_down",
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
										PositionX = 11,
										PositionY = -24,
										relativeToName = "Panel",
									},
									ZOrder = "1",
								},
								{
									controlID = "Button_card_Panel_card_3_Panel_root_Panel-dfwSummerCardView_Layer2_dafuwong_Game",
									UUID = "c2874770_fb0a_4d42_b9b1_277d9bf1f6de",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEButton",
									ClickHighLightEnabled = "True",
									dstBlendFunc = "771",
									flipX = "False",
									flipY = "False",
									height = "388",
									ignoreSize = "True",
									name = "Button_card",
									normal = "ui/dfwsummer/card/003.png",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "True",
									UILayoutViewModel = 
									{
										
									},
									UItype = "Button",
									width = "282",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "Label_title_Button_card_Panel_card_3_Panel_root_Panel-dfwSummerCardView_Layer2_dafuwong_Game",
											UUID = "e178b078_62d1_489d_ac17_ffd07a527ed6",
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
											fontSize = "18",
											fontStroke = 
											{
												IsStroke = false,
												StrokeColor = "#FFE6E6E6",
												StrokeSize = 1,
											},
											height = "0",
											ignoreSize = "False",
											name = "Label_title",
											nTextAlign = "1",
											nTextHAlign = "1",
											rotation = "81",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "770",
											text = "Title Title",
											touchAble = "False",
											touchScaleEnable = "False",
											UILayoutViewModel = 
											{
												PositionX = 105,
												PositionY = 86,
											},
											width = "146",
											ZOrder = "1",
										},
									},
								},
								{
									controlID = "Spine_select_Panel_card_3_Panel_root_Panel-dfwSummerCardView_Layer2_dafuwong_Game",
									UUID = "d7b7d90b_34be_471a_bcc4_010fa47a0369",
									classname = "MESpine",
									dstBlendFunc = "771",
									name = "Spine_select",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									spineModel = 
									{
										SpinePath = "effect/ui_effect_cardGround/ui_effect_cardGround",
										animationName = "BUFF_up",
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
										PositionX = 11,
										PositionY = -24,
									},
									ZOrder = "1",
								},
								{
									controlID = "Label_desc_Panel_card_3_Panel_root_Panel-dfwSummerCardView_Layer2_dafuwong_Game",
									UUID = "649430be_6319_43a4_a590_d1aab63464f8",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									classname = "MELabel",
									compPath = "luacomponents.common.MEIconLabel",
									dstBlendFunc = "771",
									FontColor = "#FF345EAF",
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
									name = "Label_desc",
									nTextAlign = "0",
									nTextHAlign = "0",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "Next Dice Roll +3",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionX = -9,
										PositionY = -121,
									},
									width = "234",
									ZOrder = "1",
								},
								{
									controlID = "Button_use_Panel_card_3_Panel_root_Panel-dfwSummerCardView_Layer2_dafuwong_Game",
									UUID = "640fb4cc_773a_492a_bd1e_a4733b730ea5",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEButton",
									ClickHighLightEnabled = "True",
									dstBlendFunc = "771",
									flipX = "False",
									flipY = "False",
									height = "54",
									ignoreSize = "True",
									name = "Button_use",
									normal = "ui/common/button_small_blue.png",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "True",
									UILayoutViewModel = 
									{
										PositionX = -17,
										PositionY = -283,
									},
									UItype = "Button",
									width = "124",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "Label_use_Button_use_Panel_card_3_Panel_root_Panel-dfwSummerCardView_Layer2_dafuwong_Game",
											UUID = "0ae570ff_1830_4539_be80_6a8f3a640267",
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
												IsStroke = false,
												StrokeColor = "#FFE6E6E6",
												StrokeSize = 1,
											},
											height = "30",
											ignoreSize = "True",
											name = "Label_use",
											nTextAlign = "1",
											nTextHAlign = "1",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "770",
											text = "Use",
											touchAble = "False",
											touchScaleEnable = "False",
											UILayoutViewModel = 
											{
												PositionY = -3,
											},
											width = "40",
											ZOrder = "1",
										},
									},
								},
								{
									controlID = "Image_effect_Panel_card_3_Panel_root_Panel-dfwSummerCardView_Layer2_dafuwong_Game",
									UUID = "9cd8ff8f_d39d_4a7a_b407_c1c7d025f210",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "80",
									ignoreSize = "True",
									name = "Image_effect",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/dfwsummer/card/005.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = -17,
										PositionY = -344,
									},
									width = "278",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "Label_effect_Image_effect_Panel_card_3_Panel_root_Panel-dfwSummerCardView_Layer2_dafuwong_Game",
											UUID = "27c393b6_633e_460b_b28c_d15966e266d2",
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
												IsStroke = true,
												StrokeColor = "#FF345EAF",
												StrokeSize = 1,
											},
											height = "0",
											ignoreSize = "False",
											name = "Label_effect",
											nTextAlign = "1",
											nTextHAlign = "1",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "770",
											text = "You are enjoying this buff",
											touchAble = "False",
											touchScaleEnable = "False",
											UILayoutViewModel = 
											{
												
											},
											width = "196",
											ZOrder = "1",
										},
									},
								},
								{
									controlID = "Image_num_bg_Panel_card_3_Panel_root_Panel-dfwSummerCardView_Layer2_dafuwong_Game",
									UUID = "e093cf22_0e87_4bd3_ac51_f41a89b09e4e",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "28",
									ignoreSize = "True",
									name = "Image_num_bg",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/dfwsummer/card/001.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = -13,
										PositionY = -213,
									},
									width = "198",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "Label_num_Image_num_bg_Panel_card_3_Panel_root_Panel-dfwSummerCardView_Layer2_dafuwong_Game",
											UUID = "19554a2b_550e_484c_980e_e2a26d5c778e",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											classname = "MELabel",
											compPath = "luacomponents.common.MEIconLabel",
											dstBlendFunc = "771",
											FontColor = "#FF345EAF",
											fontName = "font/MFLiHei_Noncommercial.ttf",
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
											name = "Label_num",
											nTextAlign = "1",
											nTextHAlign = "1",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "770",
											text = "5-6",
											touchAble = "False",
											touchScaleEnable = "False",
											UILayoutViewModel = 
											{
												PositionY = -3,
											},
											width = "35",
											ZOrder = "1",
										},
									},
								},
							},
						},
					},
				},
				{
					controlID = "Panel_prefab_Panel-dfwSummerCardView_Layer2_dafuwong_Game",
					UUID = "520aa55c_14b3_4df9_ae94_4e20d0e898c0",
					anchorPoint = "False",
					anchorPointX = "0.5",
					anchorPointY = "0.5",
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
						PositionX = 692,
						PositionY = -585,
						LeftPositon = 124,
						TopPosition = 905,
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
			"ui/dfwsummer/card/004.png",
			"ui/common/button_small_blue.png",
			"ui/dfwsummer/card/005.png",
			"ui/dfwsummer/card/001.png",
			"ui/dfwsummer/card/002.png",
			"ui/dfwsummer/card/003.png",
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

