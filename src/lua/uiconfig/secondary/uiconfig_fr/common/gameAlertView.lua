local t = 
{
	version = 1,
	components = 
	{
		
		{
			controlID = "Panel-gameAlertView_Layer1_common_Game",
			UUID = "245ee603_d2ef_4e04_bcdf_587a0903d3ca",
			anchorPoint = "False",
			anchorPointX = "0",
			anchorPointY = "0",
			backGroundScale9Enable = "False",
			bgColorOpacity = "150",
			bIsOpenClipping = "False",
			classname = "MEPanel",
			colorType = "0;SingleColor:#FF000000;GraduallyChangingColorStart:#FFFFFFFF;GraduallyChangingColorEnd:#FFFFFFFF;vectorX:0;vectorY:0",
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
					controlID = "Panel_root_Panel-gameAlertView_Layer1_common_Game",
					UUID = "be8e919c_3b23_4f2b_99bf_943cabd878aa",
					anchorPoint = "False",
					anchorPointX = "0.5",
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
					touchAble = "True",
					UILayoutViewModel = 
					{
						PositionX = 568,
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
					width = "1400",
					ZOrder = "1",
					components = 
					{
						
						{
							controlID = "Panel_page_Panel_root_Panel-gameAlertView_Layer1_common_Game",
							UUID = "91dbb41a_4589_4a53_a377_d7022b29ac33",
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
							height = "300",
							ignoreSize = "False",
							name = "Panel_page",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							touchAble = "True",
							UILayoutViewModel = 
							{
								PositionY = 320,
								IsPercent = true,
								PercentY = 50,
								LeftPositon = 288,
								TopPosition = 170,
							},
							uipanelviewmodel = 
							{
								Layout="Absolute",
								nType = "0"
							},
							width = "560",
							ZOrder = "1",
							components = 
							{
								
								{
									controlID = "Image_big_bg_Panel_page_Panel_root_Panel-gameAlertView_Layer1_common_Game",
									UUID = "79effdef_3d17_4b2d_a759_2e8f14fd30f6",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "330",
									ignoreSize = "False",
									name = "Image_big_bg",
									sizepercentx = "7",
									sizepercenty = "12",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/common/pop_ui/pop_bg_01.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										IsPercent = true,
									},
									width = "560",
									ZOrder = "1",
								},
								{
									controlID = "Image_top_bg_Panel_page_Panel_root_Panel-gameAlertView_Layer1_common_Game",
									UUID = "d0a3dad2_d7b9_4e6a_b2fb_d241fa661eb5",
									anchorPoint = "False",
									anchorPointX = "0",
									anchorPointY = "1",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "180",
									ignoreSize = "False",
									name = "Image_top_bg",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/common/pop_ui/pop_bg_02.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = -263,
										PositionY = 103,
									},
									width = "526",
									ZOrder = "1",
								},
								{
									controlID = "Button_close_Panel_page_Panel_root_Panel-gameAlertView_Layer1_common_Game",
									UUID = "8c5f7a7d_47c7_4969_864d_df3e9b1ba68a",
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
									HitType = 
									{
										nHitType = 1,
										nXpos = -9,
										nYpos = -9,
										nHitWidth = 50,
										nHitHeight = 50
									},
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
										PositionX = 240,
										PositionY = 135,
									},
									UItype = "Button",
									width = "60",
									ZOrder = "1",
								},
								{
									controlID = "Label_pad_title_Panel_page_Panel_root_Panel-gameAlertView_Layer1_common_Game",
									UUID = "a7728fe4_e5e7_4681_b59b_9e9c7e2b8ab8",
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
									name = "Label_pad_title",
									nTextAlign = "1",
									nTextHAlign = "1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "Ressusciter",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionX = -262,
										PositionY = 131,
									},
									width = "157",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "Panel_title_sign_Label_pad_title_Panel_page_Panel_root_Panel-gameAlertView_Layer1_common_Game",
											UUID = "31ea9722_ae4b_4f8e_b654_947b7a647d12",
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
											height = "0",
											ignoreSize = "False",
											name = "Panel_title_sign",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 157,
												IsPercent = true,
												PercentX = 100,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											visible = "False",
											width = "0",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "Image_line_Panel_title_sign_Label_pad_title_Panel_page_Panel_root_Panel-gameAlertView_Layer1_common_Game",
													UUID = "21b08a47_e726_48dc_be2e_f2bea398507d",
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
														
													},
													visible = "False",
													width = "2",
													ZOrder = "1",
												},
												{
													controlID = "Image_red_Panel_title_sign_Label_pad_title_Panel_page_Panel_root_Panel-gameAlertView_Layer1_common_Game",
													UUID = "1bc62c4f_9341_4466_8bec_386193170a7b",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0.5",
													backGroundScale9Enable = "False",
													classname = "MEImage",
													dstBlendFunc = "771",
													height = "14",
													ignoreSize = "True",
													name = "Image_red",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "1",
													texturePath = "ui/common/pop_ui/pop_ui_01.png",
													touchAble = "False",
													UILayoutViewModel = 
													{
														PositionX = 82,
														PositionY = -7,
													},
													visible = "False",
													width = "14",
													ZOrder = "1",
												},
												{
													controlID = "Label_english_Panel_title_sign_Label_pad_title_Panel_page_Panel_root_Panel-gameAlertView_Layer1_common_Game",
													UUID = "4eb733fb_6d7c_40b0_9d0a_dbada723e403",
													anchorPoint = "False",
													anchorPointX = "0",
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
													fontSize = "14",
													fontStroke = 
													{
														IsStroke = false,
														StrokeColor = "#FFE6E6E6",
														StrokeSize = 1,
													},
													height = "16",
													ignoreSize = "True",
													name = "Label_english",
													nTextAlign = "1",
													nTextHAlign = "1",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "770",
													text = "Créer informations",
													touchAble = "False",
													touchScaleEnable = "False",
													UILayoutViewModel = 
													{
														PositionY = -7,
													},
													visible = "False",
													width = "114",
													ZOrder = "1",
												},
											},
										},
									},
								},
								{
									controlID = "Image_stash_Panel_page_Panel_root_Panel-gameAlertView_Layer1_common_Game",
									UUID = "0d9bb759_6d57_431a_be0c_ccb7fae501fc",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "12",
									ignoreSize = "True",
									name = "Image_stash",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "wzui/y034.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionY = -120,
									},
									visible = "False",
									width = "150",
									ZOrder = "1",
								},
								{
									controlID = "TextArea_alert_info_Panel_page_Panel_root_Panel-gameAlertView_Layer1_common_Game",
									UUID = "9ebd64f3_c6d2_4d27_8cda_8d4930e3081c",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									classname = "METextArea",
									dstBlendFunc = "771",
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
									hAlignment = "0",
									height = "160",
									ignoreSize = "False",
									name = "TextArea_alert_info",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "Zone de texte",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionY = 13,
									},
									vAlignment = "1",
									width = "480",
									ZOrder = "1",
								},
								{
									controlID = "Button_confirm_Panel_page_Panel_root_Panel-gameAlertView_Layer1_common_Game",
									UUID = "69c12788_6273_476d_aa2f_e96b8710426c",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEButton",
									ClickHighLightEnabled = "True",
									dstBlendFunc = "771",
									flipX = "False",
									flipY = "False",
									height = "58",
									ignoreSize = "True",
									name = "Button_confirm",
									normal = "ui/common/button_big_n.png",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "True",
									UILayoutViewModel = 
									{
										PositionX = 100,
										PositionY = -115,
									},
									UItype = "Button",
									width = "134",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "Label_title_Button_confirm_Panel_page_Panel_root_Panel-gameAlertView_Layer1_common_Game",
											UUID = "65444425_73ac_41c8_bd8d_1143d0dcd730",
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
												
											},
											width = "86",
											ZOrder = "1",
										},
									},
								},
								{
									controlID = "Button_cancel_Panel_page_Panel_root_Panel-gameAlertView_Layer1_common_Game",
									UUID = "63d2dd8d_8c15_45e5_9bee_ba10db2efe69",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEButton",
									ClickHighLightEnabled = "True",
									dstBlendFunc = "771",
									flipX = "False",
									flipY = "False",
									height = "58",
									ignoreSize = "True",
									name = "Button_cancel",
									normal = "ui/common/button_big_s.png",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "True",
									UILayoutViewModel = 
									{
										PositionX = -100,
										PositionY = -115,
									},
									UItype = "Button",
									width = "134",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "Label_title_Button_cancel_Panel_page_Panel_root_Panel-gameAlertView_Layer1_common_Game",
											UUID = "ad410083_3b65_4b15_a490_6018e34aedbc",
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
												StrokeColor = "#24101117",
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
											text = "Annuler",
											touchAble = "False",
											touchScaleEnable = "False",
											UILayoutViewModel = 
											{
												
											},
											width = "70",
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
			"ui/common/pop_ui/pop_bg_01.png",
			"ui/common/pop_ui/pop_bg_02.png",
			"ui/common/pop_ui/pop_btn_02.png",
			"ui/common/pop_ui/pop_ui_02.png",
			"ui/common/pop_ui/pop_ui_01.png",
			"wzui/y034.png",
			"ui/common/button_big_n.png",
			"ui/common/button_big_s.png",
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

