local t = 
{
	version = 1,
	components = 
	{
		
		{
			controlID = "Panel-DefaultMainLayer_Layer1_MainScene_Game",
			UUID = "a1ab46ac_aff5_4250_8b7e_38b05296fa94",
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
					controlID = "Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
					UUID = "8ad3d20a_f4a1_4ddd_b0a8_2a22129d0fdd",
					anchorPoint = "False",
					anchorPointX = "0",
					anchorPointY = "0",
					backGroundScale9Enable = "False",
					bgColorOpacity = "50",
					bIsOpenClipping = "False",
					classname = "MEPanel",
					colorType = "0;SingleColor:#FFFF0000;GraduallyChangingColorStart:#FFFFFFFF;GraduallyChangingColorEnd:#FFFFFFFF;vectorX:0;vectorY:0",
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
						PositionX = 125,
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
							controlID = "background_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
							UUID = "f2d6c46b_79d2_430e_a96e_11248afe989b",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							backGroundScale9Enable = "False",
							classname = "MEImage",
							dstBlendFunc = "771",
							height = "640",
							ignoreSize = "True",
							name = "background",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							texturePath = "ui/mainLayer/new_ui/bg_nightfall.png",
							touchAble = "True",
							UILayoutViewModel = 
							{
								PositionX = 568,
								PositionY = 320,
								relativeToName = "Panel",
							},
							width = "1386",
							ZOrder = "1",
							components = 
							{
								
								{
									controlID = "Spine_effectHB_background_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
									UUID = "9911f3e8_bc3d_4d25_834e_42b96db43cc1",
									classname = "MESpine",
									dstBlendFunc = "771",
									name = "Spine_effectHB",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									spineModel = 
									{
										SpinePath = "effect/dating/ui_superKanban_10507/effect_main_10507",
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
										
									},
								},
							},
						},
						{
							controlID = "Image_role_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
							UUID = "c26142c1_e0e5_4b55_8b11_ab79acf3099b",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							backGroundScale9Enable = "False",
							classname = "MEImage",
							dstBlendFunc = "771",
							height = "2",
							ignoreSize = "True",
							name = "Image_role",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							texturePath = "dating/icon/banshenxiang_shixiang.png",
							touchAble = "False",
							UILayoutViewModel = 
							{
								
							},
							width = "2",
							ZOrder = "1",
							components = 
							{
								
								{
									controlID = "Spine_effectH_Image_role_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
									UUID = "98603395_7cdd_484c_9e0a_fa01a6059e58",
									classname = "MESpine",
									dstBlendFunc = "771",
									name = "Spine_effectH",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									spineModel = 
									{
										SpinePath = "effect/dating/ui_superKanban_10507/effect_main_10507",
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
										PositionX = 567,
										PositionY = 318,
									},
									ZOrder = "5",
								},
							},
						},
						{
							controlID = "frontPanel_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
							UUID = "28d74122_98a7_4e58_a18c_7e87f73d17cd",
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
							height = "400",
							ignoreSize = "False",
							name = "frontPanel",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							touchAble = "False",
							UILayoutViewModel = 
							{
								PositionX = 134,
								PositionY = 11,
							},
							uipanelviewmodel = 
							{
								Layout="Absolute",
								nType = "0"
							},
							visible = "False",
							width = "400",
							ZOrder = "1",
						},
						{
							controlID = "Button_showUI_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
							UUID = "d845b4c4_2690_4a19_b396_dde55c65d782",
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
							name = "Button_showUI",
							normal = "ui/mainLayer/new_ui_1/camera_logo.png",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							touchAble = "True",
							UILayoutViewModel = 
							{
								PositionX = 1034,
								PositionY = 614,
							},
							UItype = "Button",
							width = "60",
							ZOrder = "1",
							components = 
							{
								
								{
									controlID = "Image_huigu_Button_showUI_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
									UUID = "82b037d0_4e70_488e_80ea_5556aa779315",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "60",
									ignoreSize = "True",
									name = "Image_huigu",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/mainLayer/new_ui_1/camera_logo.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										
									},
									width = "60",
									ZOrder = "1",
								},
							},
						},
						{
							controlID = "Panel_top_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
							UUID = "62d5259e_1bab_40ed_bd1b_d24dcacc7994",
							anchorPoint = "False",
							anchorPointX = "0",
							anchorPointY = "1",
							backGroundScale9Enable = "False",
							bgColorOpacity = "50",
							bIsOpenClipping = "False",
							classname = "MEPanel",
							colorType = "0;SingleColor:#FFE6E6E6;GraduallyChangingColorStart:#FFFFFFFF;GraduallyChangingColorEnd:#FFFFFFFF;vectorX:0;vectorY:0",
							DesignHeight = "640",
							DesignType = "0",
							DesignWidth = "960",
							dstBlendFunc = "771",
							height = "80",
							ignoreSize = "False",
							name = "Panel_top",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							touchAble = "False",
							UILayoutViewModel = 
							{
								PositionY = 640,
								IsPercent = true,
								PercentY = 100,
								LeftPositon = 1,
								TopPosition = 2,
								relativeToName = "Panel",
							},
							uipanelviewmodel = 
							{
								Layout="Absolute",
								nType = "0"
							},
							width = "1136",
							ZOrder = "999",
							components = 
							{
								
								{
									controlID = "Image_top_bar_bg_Panel_top_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
									UUID = "582172e0_1800_460f_a3c1_eac86eb13801",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "1",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "50",
									ignoreSize = "True",
									name = "Image_top_bar_bg",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/mainLayer/new_ui_1/top_bar_bg.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = 1022,
									},
									width = "446",
									ZOrder = "1",
								},
								{
									controlID = "Panel_player_info_Panel_top_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
									UUID = "cafe116f_1d7b_4f85_aa2c_e13f04e74047",
									anchorPoint = "False",
									anchorPointX = "0",
									anchorPointY = "1",
									backGroundScale9Enable = "False",
									bgColorOpacity = "50",
									bIsOpenClipping = "False",
									classname = "MEPanel",
									colorType = "0;SingleColor:#FFE6E6E6;GraduallyChangingColorStart:#FFFFFFFF;GraduallyChangingColorEnd:#FFFFFFFF;vectorX:0;vectorY:0",
									DesignHeight = "640",
									DesignType = "0",
									DesignWidth = "960",
									dstBlendFunc = "771",
									height = "62",
									ignoreSize = "False",
									name = "Panel_player_info",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = 7,
										PositionY = -4,
									},
									uipanelviewmodel = 
									{
										Layout="Absolute",
										nType = "0"
									},
									width = "300",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "info_di_Panel_player_info_Panel_top_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
											UUID = "2475e93e_c5b9_4a31_9081_856cba38f559",
											anchorPoint = "False",
											anchorPointX = "0",
											anchorPointY = "1",
											backGroundScale9Enable = "False",
											classname = "MEImage",
											dstBlendFunc = "771",
											height = "72",
											ignoreSize = "True",
											name = "info_di",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											texturePath = "ui/mainLayer/new_ui_1/ui_008.png",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = -135,
												PositionY = 4,
											},
											width = "440",
											ZOrder = "1",
										},
										{
											controlID = "Image_player_icon_bg_Panel_player_info_Panel_top_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
											UUID = "2f5757e4_2d6e_4e8d_a162_033da856d54f",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											classname = "MEImage",
											dstBlendFunc = "771",
											height = "104",
											ignoreSize = "True",
											name = "Image_player_icon_bg",
											scaleX = "0.5",
											scaleY = "0.5",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											texturePath = "ui/playerInfo/avatar/TXBK_moren_0.png",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 31,
												PositionY = -31,
											},
											width = "104",
											ZOrder = "1",
										},
										{
											controlID = "Image_player_icon_Panel_player_info_Panel_top_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
											UUID = "b3e62e03_10d2_4772_87c5_bad0904e6ffd",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											classname = "MEImage",
											dstBlendFunc = "771",
											height = "98",
											ignoreSize = "True",
											name = "Image_player_icon",
											scaleX = "0.5",
											scaleY = "0.5",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											texturePath = "icon/hero/name/1101011.png",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 31,
												PositionY = -31,
											},
											width = "98",
											ZOrder = "1",
										},
										{
											controlID = "Image_icon_frame_Panel_player_info_Panel_top_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
											UUID = "c78232fb_4d9e_4a1d_9aa5_ae95005ca335",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											classname = "MEImage",
											dstBlendFunc = "771",
											height = "104",
											ignoreSize = "True",
											name = "Image_icon_frame",
											scaleX = "0.5",
											scaleY = "0.5",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											texturePath = "ui/playerInfo/avatar/TXBK_moren_1.png",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 31,
												PositionY = -31,
											},
											width = "104",
											ZOrder = "1",
										},
										{
											controlID = "Image_icon_cover_frame_Panel_player_info_Panel_top_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
											UUID = "37a3a928_0e45_435e_adcf_c68e83c543a2",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											classname = "MEImage",
											dstBlendFunc = "771",
											height = "140",
											ignoreSize = "True",
											name = "Image_icon_cover_frame",
											scaleX = "0.5",
											scaleY = "0.5",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											texturePath = "ui/playerInfo/avatar/TXBK_1.png",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 31,
												PositionY = -31,
											},
											width = "140",
											ZOrder = "1",
										},
										{
											controlID = "TextArea_name_Panel_player_info_Panel_top_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
											UUID = "572cbaf5_f530_4a4d_8230_5a1e078e5c3f",
											anchorPoint = "False",
											anchorPointX = "0",
											anchorPointY = "0.5",
											classname = "METextArea",
											dstBlendFunc = "771",
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
												IsStroke = true,
												StrokeColor = "#FF808080",
												StrokeSize = 1,
											},
											hAlignment = "0",
											height = "23",
											ignoreSize = "True",
											name = "TextArea_name",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "770",
											text = "Player Name Max 16 Chars",
											touchAble = "False",
											touchScaleEnable = "False",
											UILayoutViewModel = 
											{
												PositionX = 66,
												PositionY = -16,
											},
											vAlignment = "0",
											width = "252",
											ZOrder = "1",
										},
										{
											controlID = "Association_TextArea_name_Panel_player_info_Panel_top_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
											UUID = "3d3eb0b4_e8f3_4f43_94a3_e632e13293d3",
											anchorPoint = "False",
											anchorPointX = "0",
											anchorPointY = "0.5",
											classname = "METextArea",
											ColorMixing = "#FFFFF04B",
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
											fontSize = "18",
											fontStroke = 
											{
												IsStroke = true,
												StrokeColor = "#FF808080",
												StrokeSize = 1,
											},
											hAlignment = "0",
											height = "23",
											ignoreSize = "True",
											name = "Association_TextArea_name",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "770",
											text = "Club Name 16 Chars",
											touchAble = "False",
											touchScaleEnable = "False",
											UILayoutViewModel = 
											{
												PositionX = 66,
												PositionY = -38,
											},
											vAlignment = "0",
											width = "160",
											ZOrder = "1",
										},
										{
											controlID = "Panel_player_level_Panel_player_info_Panel_top_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
											UUID = "145dadb2_d289_4985_8990_58fabb2d46d8",
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
											height = "60",
											ignoreSize = "False",
											name = "Panel_player_level",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 272,
												PositionY = -26,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "60",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "Image_Exp_bg-Copy1_Panel_player_level_Panel_player_info_Panel_top_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
													UUID = "c03fab33_50b2_49ca_a7af_f7464a3ee75b",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0.5",
													backGroundScale9Enable = "False",
													classname = "MEImage",
													dstBlendFunc = "771",
													height = "58",
													ignoreSize = "True",
													name = "Image_Exp_bg-Copy1",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "1",
													texturePath = "ui/mainLayer/new_ui_1/lvbg.png",
													touchAble = "False",
													UILayoutViewModel = 
													{
														
													},
													width = "58",
													ZOrder = "1",
												},
												{
													controlID = "Label_Player_level_Panel_player_level_Panel_player_info_Panel_top_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
													UUID = "137cfb0c_2d56_481b_8a63_280e6d684520",
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
													fontSize = "30",
													fontStroke = 
													{
														IsStroke = true,
														StrokeColor = "#FF000000",
														StrokeSize = 1,
													},
													height = "36",
													ignoreSize = "True",
													name = "Label_Player_level",
													nTextAlign = "1",
													nTextHAlign = "1",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "770",
													text = "9",
													touchAble = "False",
													touchScaleEnable = "False",
													UILayoutViewModel = 
													{
														PositionY = -1,
													},
													width = "18",
													ZOrder = "1",
												},
												{
													controlID = "Image_Exp_bg_Panel_player_level_Panel_player_info_Panel_top_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
													UUID = "e2e50cbf_3f55_49b2_aa5b_71b09afd0529",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0.5",
													backGroundScale9Enable = "False",
													classname = "MEImage",
													dstBlendFunc = "771",
													height = "8",
													ignoreSize = "True",
													name = "Image_Exp_bg",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "1",
													texturePath = "ui/mainLayer/new_ui_1/ui_007.png",
													touchAble = "False",
													UILayoutViewModel = 
													{
														PositionX = -111,
														PositionY = -27,
													},
													width = "196",
													ZOrder = "1",
													components = 
													{
														
														{
															controlID = "LoadingBar_Exp_Image_Exp_bg_Panel_player_level_Panel_player_info_Panel_top_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
															UUID = "542c52e7_9608_4e42_88f7_00ffd9b4a60f",
															anchorPoint = "False",
															anchorPointX = "0.5",
															anchorPointY = "0.5",
															backGroundScale9Enable = "False",
															classname = "MELoadingBar",
															direction = "0",
															dstBlendFunc = "771",
															height = "8",
															ignoreSize = "True",
															name = "LoadingBar_Exp",
															percent = "51",
															sizepercentx = "0",
															sizepercenty = "0",
															sizeType = "0",
															srcBlendFunc = "1",
															texture = "ui/mainLayer/new_ui_1/ui_006.png",
															touchAble = "False",
															UILayoutViewModel = 
															{
																
															},
															width = "196",
															ZOrder = "1",
														},
													},
												},
											},
										},
										{
											controlID = "ClippingNode_Panel_player_info_Panel_top_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
											UUID = "1c4b6c2b_6a56_4dc4_9713_7d6ee8fe6f5a",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											classname = "MEClippingNode",
											clipNodeX = "0",
											clipNodeY = "0",
											dstBlendFunc = "771",
											height = "50",
											ignoreSize = "False",
											name = "ClippingNode",
											scaleX = "0.78",
											scaleY = "0.78",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											stencilPath = "ui/mainLayer/new_ui/ui_009.png",
											touchAble = "False",
											UILayoutViewModel = 
											{
												
											},
											visible = "False",
											width = "50",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "Image_head_ClippingNode_Panel_player_info_Panel_top_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
													UUID = "440034bc_0545_40b6_9eae_83fa24a2bfd4",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0.5",
													backGroundScale9Enable = "False",
													classname = "MEImage",
													dstBlendFunc = "771",
													height = "92",
													ignoreSize = "True",
													name = "Image_head",
													scaleX = "0.93",
													scaleY = "0.93",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "1",
													texturePath = "icon/hero/face/1101011.png",
													touchAble = "False",
													UILayoutViewModel = 
													{
														PositionX = -15,
													},
													width = "156",
													ZOrder = "1",
												},
											},
										},
										{
											controlID = "Image_player_redTip_Panel_player_info_Panel_top_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
											UUID = "ef71e81c_9161_431a_8bdc_8c28ed5d445a",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											classname = "MEImage",
											dstBlendFunc = "771",
											height = "30",
											ignoreSize = "True",
											name = "Image_player_redTip",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											texturePath = "ui/common/news_small.png",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 55,
												PositionY = -8,
											},
											width = "30",
											ZOrder = "1",
										},
									},
								},
								{
									controlID = "Panel_system_Panel_top_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
									UUID = "7ea06cd0_5e09_48b6_9f1b_784623712181",
									anchorPoint = "False",
									anchorPointX = "0",
									anchorPointY = "0",
									backGroundScale9Enable = "False",
									bgColorOpacity = "50",
									bIsOpenClipping = "True",
									classname = "MEPanel",
									colorType = "0;SingleColor:#FFE6E6E6;GraduallyChangingColorStart:#FFFFFFFF;GraduallyChangingColorEnd:#FFFFFFFF;vectorX:0;vectorY:0",
									DesignHeight = "640",
									DesignType = "0",
									DesignWidth = "960",
									dstBlendFunc = "771",
									height = "30",
									ignoreSize = "False",
									name = "Panel_system",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = 65,
										PositionY = -111,
									},
									uipanelviewmodel = 
									{
										Layout="Absolute",
										nType = "0"
									},
									width = "480",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "Image_system_bg_Panel_system_Panel_top_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
											UUID = "8873b40e_a97b_4189_85e5_2fb837d8c049",
											anchorPoint = "False",
											anchorPointX = "0",
											anchorPointY = "0.5",
											backGroundScale9Enable = "True;capInsetsX:0;capInsetsY:0;capInsetsWidth:0;capInsetsHeight:0",
											classname = "MEImage",
											dstBlendFunc = "771",
											height = "32",
											ignoreSize = "False",
											name = "Image_system_bg",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											texturePath = "ui/mainLayer/new_ui/ui_002.png",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionY = 14,
											},
											width = "480",
											ZOrder = "1",
										},
										{
											controlID = "TextArea_system_Panel_system_Panel_top_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
											UUID = "e28a5d4b_86fe_4b74_b0fe_f8110499364d",
											anchorPoint = "False",
											anchorPointX = "0",
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
											height = "23",
											ignoreSize = "True",
											name = "TextArea_system",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "770",
											text = "System Notice",
											touchAble = "False",
											touchScaleEnable = "False",
											UILayoutViewModel = 
											{
												PositionX = 332,
												PositionY = 13,
											},
											vAlignment = "0",
											width = "115",
											ZOrder = "1",
										},
									},
								},
								{
									controlID = "Image_camera_Panel_top_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
									UUID = "51c9f0b0_b790_40fa_bb88_91d040727268",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "36",
									ignoreSize = "True",
									name = "Image_camera",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/003.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = 1034,
										PositionY = -26,
									},
									visible = "False",
									width = "46",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "Button_camera_Image_camera_Panel_top_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
											UUID = "6fe94455_e54a_44f5_9271_96e80fe3cc49",
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
											name = "Button_camera",
											normal = "ui/mainLayer/new_ui_1/camera_logo.png",
											pressed = "ui/mainLayer/new_ui_1/camera_logo.png",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "True",
											UILayoutViewModel = 
											{
												
											},
											UItype = "Button",
											width = "60",
											ZOrder = "1",
										},
									},
								},
								{
									controlID = "Button_setting_Panel_top_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
									UUID = "2a78527f_e665_4891_bdc9_84f81808ecc8",
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
									name = "Button_setting",
									normal = "ui/mainLayer/new_ui_1/btn_setting.png",
									pressed = "ui/mainLayer/new_ui_1/btn_setting.png",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "True",
									UILayoutViewModel = 
									{
										PositionX = 1103,
										PositionY = -28,
									},
									UItype = "Button",
									width = "60",
									ZOrder = "3",
									components = 
									{
										
										{
											controlID = "Label_MainLayer_1_Button_setting_Panel_top_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
											UUID = "b91b959a_0569_4df8_90db_816873e39fe7",
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
											name = "Label_MainLayer_1",
											nTextAlign = "1",
											nTextHAlign = "1",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "770",
											text = "Settings",
											touchAble = "False",
											touchScaleEnable = "False",
											UILayoutViewModel = 
											{
												PositionX = 22,
												PositionY = -2,
											},
											visible = "False",
											width = "64",
											ZOrder = "1",
										},
									},
								},
								{
									controlID = "Button_hideUI_Panel_top_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
									UUID = "fcfba501_fc10_4968_818f_ac56ac88b43e",
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
									name = "Button_hideUI",
									normal = "ui/mainLayer/new_ui_1/camera_logo.png",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "True",
									UILayoutViewModel = 
									{
										PositionX = 1034,
										PositionY = -26,
									},
									UItype = "Button",
									width = "60",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "Image_huigu_Button_hideUI_Panel_top_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
											UUID = "9feb5b6b_dcfc_4baa_bcb7_61cdb51d7329",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											classname = "MEImage",
											dstBlendFunc = "771",
											height = "60",
											ignoreSize = "True",
											name = "Image_huigu",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											texturePath = "ui/mainLayer/new_ui_1/camera_logo.png",
											touchAble = "False",
											UILayoutViewModel = 
											{
												
											},
											width = "60",
											ZOrder = "1",
										},
									},
								},
							},
						},
						{
							controlID = "Panel_right_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
							UUID = "97ccbe3e_1dee_4cc4_8f1c_4345479cf24f",
							anchorPoint = "False",
							anchorPointX = "0",
							anchorPointY = "0",
							backGroundScale9Enable = "False",
							bgColorOpacity = "255",
							bIsOpenClipping = "False",
							classname = "MEPanel",
							colorType = "0;SingleColor:#FF008000;GraduallyChangingColorStart:#FFFFFFFF;GraduallyChangingColorEnd:#FFFFFFFF;vectorX:0;vectorY:0",
							DesignHeight = "640",
							DesignType = "0",
							DesignWidth = "960",
							dstBlendFunc = "771",
							height = "458",
							ignoreSize = "False",
							name = "Panel_right",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							touchAble = "False",
							UILayoutViewModel = 
							{
								PositionX = 458,
								PositionY = 101,
								LeftPositon = 462,
								TopPosition = 48,
								relativeToName = "Panel",
							},
							uipanelviewmodel = 
							{
								Layout="Absolute",
								nType = "0"
							},
							width = "820",
							ZOrder = "5",
							components = 
							{
								
								{
									controlID = "Panel_feelling_info__Panel_right_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
									UUID = "7b2aed1d_fcb6_458e_ad3c_2cbae1debcaf",
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
									height = "106",
									ignoreSize = "False",
									name = "Panel_feelling_info_",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = -50,
										PositionY = 254,
									},
									uipanelviewmodel = 
									{
										Layout="Absolute",
										nType = "0"
									},
									visible = "False",
									width = "278",
									ZOrder = "2",
									components = 
									{
										
										{
											controlID = "Image_feelling_bg_Panel_feelling_info__Panel_right_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
											UUID = "ad023456_1a00_4214_9aae_287a7e6fe225",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											classname = "MEImage",
											dstBlendFunc = "771",
											height = "106",
											ignoreSize = "False",
											name = "Image_feelling_bg",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											texturePath = "ui/mainLayer/new_ui/ui_004.png",
											touchAble = "True",
											UILayoutViewModel = 
											{
												PositionX = 145,
												PositionY = 53,
											},
											width = "290",
											ZOrder = "1",
										},
										{
											controlID = "Image_feelling_icon_Panel_feelling_info__Panel_right_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
											UUID = "9b5dc7be_8877_4974_b6a6_7f476776feb1",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											classname = "MEImage",
											dstBlendFunc = "771",
											height = "30",
											ignoreSize = "True",
											name = "Image_feelling_icon",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											texturePath = "ui/newCity/build/9.png",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 29,
												PositionY = 76,
											},
											width = "30",
											ZOrder = "1",
										},
										{
											controlID = "Label_feelling_name_Panel_feelling_info__Panel_right_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
											UUID = "2e571551_be4f_4ebd_93e4_29b59dd21478",
											anchorPoint = "False",
											anchorPointX = "0",
											anchorPointY = "0.5",
											classname = "MELabel",
											compPath = "luacomponents.common.MEIconLabel",
											dstBlendFunc = "771",
											FontColor = "#FF70718D",
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
												IsStroke = false,
												StrokeColor = "#FFE6E6E6",
												StrokeSize = 1,
											},
											height = "28",
											ignoreSize = "True",
											name = "Label_feelling_name",
											nTextAlign = "1",
											nTextHAlign = "1",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "770",
											text = "Favor Level",
											touchAble = "False",
											touchScaleEnable = "False",
											UILayoutViewModel = 
											{
												PositionX = 44,
												PositionY = 75,
											},
											width = "148",
											ZOrder = "1",
										},
										{
											controlID = "Label_feelling_level_Panel_feelling_info__Panel_right_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
											UUID = "52285617_750f_4fcb_8593_4f7923dabe5a",
											anchorPoint = "False",
											anchorPointX = "0",
											anchorPointY = "0.5",
											classname = "MELabel",
											compPath = "luacomponents.common.MEIconLabel",
											dstBlendFunc = "771",
											FontColor = "#FF70718D",
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
											name = "Label_feelling_level",
											nTextAlign = "1",
											nTextHAlign = "1",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "770",
											text = "6",
											touchAble = "False",
											touchScaleEnable = "False",
											UILayoutViewModel = 
											{
												PositionX = 200,
												PositionY = 76,
											},
											width = "15",
											ZOrder = "1",
										},
										{
											controlID = "Label_feelling_reach_max_Panel_feelling_info__Panel_right_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
											UUID = "d2ffba14_1e07_4579_a797_8d2b45b20fb6",
											anchorPoint = "False",
											anchorPointX = "0",
											anchorPointY = "0.5",
											classname = "MELabel",
											compPath = "luacomponents.common.MEIconLabel",
											dstBlendFunc = "771",
											FontColor = "#FF70718D",
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
											name = "Label_feelling_reach_max",
											nTextAlign = "1",
											nTextHAlign = "1",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "770",
											text = "You can't get more Favor today.",
											touchAble = "False",
											touchScaleEnable = "False",
											UILayoutViewModel = 
											{
												PositionX = 11,
												PositionY = 23,
											},
											width = "249",
											ZOrder = "1",
										},
										{
											controlID = "Image_progress_bg_Panel_feelling_info__Panel_right_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
											UUID = "6de08058_8b39_49be_92fd_14ee90f51f06",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "True;capInsetsX:0;capInsetsY:0;capInsetsWidth:0;capInsetsHeight:0",
											classname = "MEImage",
											dstBlendFunc = "771",
											height = "12",
											ignoreSize = "False",
											name = "Image_progress_bg",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											texturePath = "ui/mainLayer/new_ui/progress_01.png",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 120,
												PositionY = 50,
											},
											width = "210",
											ZOrder = "1",
										},
										{
											controlID = "LoadingBar_feelling_bar_Panel_feelling_info__Panel_right_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
											UUID = "b0c5835a_69ae_40ad_8bd0_2e864d9c17fe",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "True;capInsetsX:0;capInsetsY:0;capInsetsWidth:0;capInsetsHeight:0",
											classname = "MELoadingBar",
											direction = "0",
											dstBlendFunc = "771",
											height = "12",
											ignoreSize = "False",
											name = "LoadingBar_feelling_bar",
											percent = "100",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											texture = "ui/mainLayer/new_ui/progress_02.png",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 120,
												PositionY = 50,
											},
											width = "210",
											ZOrder = "1",
										},
										{
											controlID = "Label_feelling_percent_Panel_feelling_info__Panel_right_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
											UUID = "1654de31_5e33_453b_b1b7_1b31e074a5d6",
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
											name = "Label_feelling_percent",
											nTextAlign = "1",
											nTextHAlign = "1",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "770",
											text = "20 30",
											touchAble = "False",
											touchScaleEnable = "False",
											UILayoutViewModel = 
											{
												PositionX = 120,
												PositionY = 50,
											},
											width = "47",
											ZOrder = "1",
										},
										{
											controlID = "Button_feellint_edit_Panel_feelling_info__Panel_right_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
											UUID = "4cbcc8ad_8df3_4d37_b90b_6aa15f676027",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "True;capInsetsX:0;capInsetsY:0;capInsetsWidth:0;capInsetsHeight:0",
											classname = "MEButton",
											ClickHighLightEnabled = "True",
											dstBlendFunc = "771",
											flipX = "False",
											flipY = "False",
											height = "88",
											ignoreSize = "False",
											name = "Button_feellint_edit",
											normal = "ui/common/button09.png",
											pressed = "ui/common/button09.png",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "True",
											UILayoutViewModel = 
											{
												PositionX = 253,
												PositionY = 53,
											},
											UItype = "Button",
											width = "45",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "Label_MainLayer_1_Button_feellint_edit_Panel_feelling_info__Panel_right_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
													UUID = "4cf134cb_b505_4ff4_9dda_7324a45029ad",
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
													height = "90",
													ignoreSize = "False",
													name = "Label_MainLayer_1",
													nTextAlign = "1",
													nTextHAlign = "1",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "770",
													text = "Edit",
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
									},
								},
								{
									controlID = "Panel_clip_Panel_right_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
									UUID = "fbcd0958_ecd4_4a8e_8a77_403ccf153831",
									anchorPoint = "False",
									anchorPointX = "0",
									anchorPointY = "0",
									backGroundScale9Enable = "False",
									bgColorOpacity = "100",
									bIsOpenClipping = "False",
									classname = "MEPanel",
									colorType = "0;SingleColor:#FFE6E6E6;GraduallyChangingColorStart:#FFFFFFFF;GraduallyChangingColorEnd:#FFFFFFFF;vectorX:0;vectorY:0",
									DesignHeight = "640",
									DesignType = "0",
									DesignWidth = "960",
									dstBlendFunc = "771",
									height = "458",
									ignoreSize = "False",
									name = "Panel_clip",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = -20,
										PositionY = -23,
									},
									uipanelviewmodel = 
									{
										Layout="Absolute",
										nType = "0"
									},
									width = "820",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "Image_bottom_Panel_clip_Panel_right_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
											UUID = "57c3462a_cdad_4787_83f2_3c74bc806ab2",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											classname = "MEImage",
											dstBlendFunc = "771",
											height = "300",
											ignoreSize = "False",
											name = "Image_bottom",
											opacity = "51",
											rotation = "-45",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											texturePath = "ui/065.png",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 394,
												PositionY = 166,
											},
											visible = "False",
											width = "700",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "Image_activity_bottom_Image_bottom_Panel_clip_Panel_right_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
													UUID = "c4631a98_72e5_4532_99b0_c520b6eea57b",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0.5",
													backGroundScale9Enable = "False",
													classname = "MEImage",
													dstBlendFunc = "771",
													height = "204",
													ignoreSize = "False",
													name = "Image_activity_bottom",
													rotation = "-45",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "1",
													texturePath = "ui/020.png",
													touchAble = "False",
													UILayoutViewModel = 
													{
														PositionX = 241,
														PositionY = 140,
													},
													visible = "False",
													width = "472",
													ZOrder = "1",
												},
											},
										},
										{
											controlID = "Image_z_y_bottom_Panel_clip_Panel_right_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
											UUID = "1c964377_5216_4ab3_9043_4797dc066e63",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											classname = "MEImage",
											dstBlendFunc = "771",
											height = "248",
											ignoreSize = "False",
											name = "Image_z_y_bottom",
											rotation = "-45",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											texturePath = "ui/020.png",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 512,
												PositionY = 161,
											},
											visible = "False",
											width = "700",
											ZOrder = "1",
										},
										{
											controlID = "Button_zuozhan_Panel_clip_Panel_right_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
											UUID = "3786a3f5_f67d_473d_8377_b03b52868957",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											classname = "MEButton",
											ClickHighLightEnabled = "True",
											dstBlendFunc = "771",
											flipX = "False",
											flipY = "False",
											height = "240",
											HitType = 
											{
												nHitType = 3,
											},
											ignoreSize = "True",
											name = "Button_zuozhan",
											normal = "ui/mainLayer/new_ui_1/btn_battle.png",
											pressed = "ui/mainLayer/new_ui_1/btn_battle.png",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "True",
											UILayoutViewModel = 
											{
												PositionX = 581,
												PositionY = 130,
											},
											UItype = "Button",
											width = "240",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "Image_zuozhan_Button_zuozhan_Panel_clip_Panel_right_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
													UUID = "2591b4e3_1a53_4871_8359_563d5ea908bd",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0.5",
													backGroundScale9Enable = "False",
													classname = "MEImage",
													dstBlendFunc = "771",
													height = "242",
													ignoreSize = "True",
													name = "Image_zuozhan",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "1",
													texturePath = "ui/028.png",
													touchAble = "False",
													UILayoutViewModel = 
													{
														PositionX = -21,
														PositionY = 2,
													},
													visible = "False",
													width = "382",
													ZOrder = "1",
												},
											},
										},
										{
											controlID = "Image_text_Panel_clip_Panel_right_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
											UUID = "41252da8_d021_4497_8eef_c06a7e9253e4",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											classname = "MEImage",
											dstBlendFunc = "771",
											height = "38",
											ignoreSize = "True",
											name = "Image_text",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											texturePath = "ui/mainLayer/new_ui/battle_text.png",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 579,
												PositionY = 44,
											},
											visible = "False",
											width = "82",
											ZOrder = "1",
										},
										{
											controlID = "Image_MainLayer_1(2)_Panel_clip_Panel_right_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
											UUID = "b4265133_6004_47f5_a5fe_533901d203e3",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											classname = "MEImage",
											dstBlendFunc = "771",
											height = "236",
											ignoreSize = "True",
											name = "Image_MainLayer_1(2)",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											texturePath = "ui/mainLayer/new_ui/bai1.png",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 584,
												PositionY = 142,
											},
											visible = "False",
											width = "166",
											ZOrder = "1",
										},
										{
											controlID = "Panelzuozhan_Panel_clip_Panel_right_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
											UUID = "7fbb4e84_7b50_4351_9c44_e7925a3965f3",
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
											height = "200",
											ignoreSize = "False",
											name = "Panelzuozhan",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 549,
												PositionY = 171,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "200",
											ZOrder = "1",
										},
										{
											controlID = "button_yuehui_Panel_clip_Panel_right_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
											UUID = "bed4f3c5_ffc1_4949_a3ef_5543c94f0911",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											classname = "MEButton",
											ClickHighLightEnabled = "True",
											dstBlendFunc = "771",
											flipX = "False",
											flipY = "False",
											height = "240",
											HitType = 
											{
												nHitType = 3,
											},
											ignoreSize = "True",
											name = "button_yuehui",
											normal = "ui/mainLayer/new_ui_1/btn_dating.png",
											pressed = "ui/mainLayer/new_ui_1/btn_dating.png",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "True",
											UILayoutViewModel = 
											{
												PositionX = 393,
												PositionY = 130,
											},
											UItype = "Button",
											width = "240",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "Image_yuehui_button_yuehui_Panel_clip_Panel_right_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
													UUID = "f976ca2e_d8d3_4058_809b_dc7ef261ba84",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0.5",
													backGroundScale9Enable = "False",
													classname = "MEImage",
													dstBlendFunc = "771",
													height = "242",
													ignoreSize = "True",
													name = "Image_yuehui",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "1",
													texturePath = "ui/027.png",
													touchAble = "False",
													UILayoutViewModel = 
													{
														PositionX = 2,
													},
													visible = "False",
													width = "434",
													ZOrder = "1",
												},
												{
													controlID = "Image_startIcon1_button_yuehui_Panel_clip_Panel_right_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
													UUID = "6df1077a_0b23_4305_aeaf_817bd47f1a5b",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0.5",
													backGroundScale9Enable = "False",
													classname = "MEImage",
													dstBlendFunc = "771",
													height = "40",
													ignoreSize = "True",
													name = "Image_startIcon1",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "1",
													texturePath = "ui/mainui/arrow_r.png",
													touchAble = "False",
													UILayoutViewModel = 
													{
														PositionX = -130,
														PositionY = 50,
													},
													visible = "False",
													width = "56",
													ZOrder = "1",
												},
												{
													controlID = "Image_yuehuiRedTips_button_yuehui_Panel_clip_Panel_right_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
													UUID = "6d8e89ed_db25_4ba7_9bd0_626daa70bf3b",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0.5",
													backGroundScale9Enable = "False",
													classname = "MEImage",
													dstBlendFunc = "771",
													height = "18",
													ignoreSize = "True",
													name = "Image_yuehuiRedTips",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "1",
													texturePath = "ui/920.png",
													touchAble = "False",
													UILayoutViewModel = 
													{
														PositionX = 30,
														PositionY = 70,
													},
													visible = "False",
													width = "48",
													ZOrder = "1",
												},
											},
										},
										{
											controlID = "Image_MainLayer_1(4)_Panel_clip_Panel_right_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
											UUID = "f793d085_aed7_486c_b206_f4722e23a622",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											classname = "MEImage",
											dstBlendFunc = "771",
											height = "38",
											ignoreSize = "True",
											name = "Image_MainLayer_1(4)",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											texturePath = "ui/mainLayer/new_ui/dating_text.png",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 395,
												PositionY = 46,
											},
											visible = "False",
											width = "82",
											ZOrder = "1",
										},
										{
											controlID = "Image_MainLayer_1_Panel_clip_Panel_right_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
											UUID = "47e5629f_91fa_4132_8a7e_87699a63f88a",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											classname = "MEImage",
											dstBlendFunc = "771",
											height = "236",
											ignoreSize = "True",
											name = "Image_MainLayer_1",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											texturePath = "ui/mainLayer/new_ui/bai1.png",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 389,
												PositionY = 141,
											},
											visible = "False",
											width = "166",
											ZOrder = "1",
										},
										{
											controlID = "Panelyuehui_Panel_clip_Panel_right_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
											UUID = "3f95dd1c_6ba4_499b_813d_7881509c034d",
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
											height = "177",
											ignoreSize = "False",
											name = "Panelyuehui",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 342,
												PositionY = 5,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "183",
											ZOrder = "1",
										},
										{
											controlID = "Panel_task_Panel_clip_Panel_right_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
											UUID = "48bfec67_a1ac_4967_9dca_21d2c1a110f1",
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
											height = "70",
											ignoreSize = "False",
											name = "Panel_task",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 278,
												PositionY = 168,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "70",
											ZOrder = "1",
										},
										{
											controlID = "Button_dispatch_Panel_clip_Panel_right_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
											UUID = "7426adee_468e_448e_8816_c92c45db6978",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											classname = "MEButton",
											ClickHighLightEnabled = "True",
											dstBlendFunc = "771",
											flipX = "False",
											flipY = "False",
											height = "100",
											ignoreSize = "True",
											name = "Button_dispatch",
											normal = "ui/mainLayer/new_ui_1/a3.png",
											pressed = "ui/mainLayer/new_ui_1/a3.png",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "True",
											UILayoutViewModel = 
											{
												PositionX = 649,
												PositionY = 297,
											},
											UItype = "Button",
											width = "100",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "Image_dispatchTips_Button_dispatch_Panel_clip_Panel_right_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
													UUID = "6031a1fe_79c7_491d_8eaa_687ecf801f17",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0.5",
													backGroundScale9Enable = "False",
													classname = "MEImage",
													dstBlendFunc = "771",
													height = "100",
													ignoreSize = "True",
													name = "Image_dispatchTips",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "1",
													texturePath = "ui/mainLayer/new_ui_1/a3new.png",
													touchAble = "False",
													UILayoutViewModel = 
													{
														PositionX = -2,
														PositionY = -2,
													},
													width = "100",
													ZOrder = "1",
													components = 
													{
														
														{
															controlID = "Image_updateTip_Image_dispatchTips_Button_dispatch_Panel_clip_Panel_right_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
															UUID = "bb89ef72_d5fb_481a_b42c_72b2ef65aa49",
															anchorPoint = "False",
															anchorPointX = "0.5",
															anchorPointY = "0.5",
															backGroundScale9Enable = "False",
															classname = "MEImage",
															dstBlendFunc = "771",
															height = "30",
															ignoreSize = "True",
															name = "Image_updateTip",
															sizepercentx = "0",
															sizepercenty = "0",
															sizeType = "0",
															srcBlendFunc = "1",
															texturePath = "ui/common/news_small.png",
															touchAble = "False",
															UILayoutViewModel = 
															{
																PositionX = 18,
																PositionY = 11,
															},
															width = "30",
															ZOrder = "1",
														},
													},
												},
												{
													controlID = "Label_title_Button_dispatch_Panel_clip_Panel_right_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
													UUID = "c6a92638_82db_48f6_a711_b87314499c99",
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
														IsStroke = true,
														StrokeColor = "#FF49557F",
														StrokeSize = 1,
													},
													hAlignment = "1",
													height = "25",
													ignoreSize = "True",
													name = "Label_title",
													rotation = "-30",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "770",
													text = "Command",
													touchAble = "False",
													touchScaleEnable = "False",
													UILayoutViewModel = 
													{
														PositionY = -24,
													},
													vAlignment = "1",
													width = "86",
													ZOrder = "1",
												},
											},
										},
										{
											controlID = "Button_task_Panel_clip_Panel_right_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
											UUID = "198415ad_a219_4d07_8473_46f9bb273b0a",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											classname = "MEButton",
											ClickHighLightEnabled = "True",
											dstBlendFunc = "771",
											flipX = "False",
											flipY = "False",
											height = "100",
											ignoreSize = "True",
											name = "Button_task",
											normal = "ui/mainLayer/new_ui_1/btn_order.png",
											pressed = "ui/mainLayer/new_ui_1/btn_order.png",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "True",
											UILayoutViewModel = 
											{
												PositionX = 573,
												PositionY = 319,
											},
											UItype = "Button",
											width = "100",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "Image_taskTips_Button_task_Panel_clip_Panel_right_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
													UUID = "38b270cf_3283_42b7_92e8_528b461c3532",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0.5",
													backGroundScale9Enable = "False",
													classname = "MEImage",
													dstBlendFunc = "771",
													height = "100",
													ignoreSize = "True",
													name = "Image_taskTips",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "1",
													texturePath = "ui/mainLayer/new_ui_1/btn_ordernew.png",
													touchAble = "False",
													UILayoutViewModel = 
													{
														
													},
													width = "100",
													ZOrder = "1",
													components = 
													{
														
														{
															controlID = "Image_updateTip_Image_taskTips_Button_task_Panel_clip_Panel_right_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
															UUID = "ea403db7_c1e7_4d52_8b1f_3fd66bbfc443",
															anchorPoint = "False",
															anchorPointX = "0.5",
															anchorPointY = "0.5",
															backGroundScale9Enable = "False",
															classname = "MEImage",
															dstBlendFunc = "771",
															height = "30",
															ignoreSize = "True",
															name = "Image_updateTip",
															sizepercentx = "0",
															sizepercenty = "0",
															sizeType = "0",
															srcBlendFunc = "1",
															texturePath = "ui/common/news_small.png",
															touchAble = "False",
															UILayoutViewModel = 
															{
																PositionX = 18,
																PositionY = 11,
															},
															width = "30",
															ZOrder = "1",
														},
													},
												},
												{
													controlID = "Label_title_Button_task_Panel_clip_Panel_right_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
													UUID = "e26e7de0_8378_4303_822a_34ac05ece248",
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
														IsStroke = true,
														StrokeColor = "#FF49557F",
														StrokeSize = 1,
													},
													hAlignment = "1",
													height = "25",
													ignoreSize = "True",
													name = "Label_title",
													rotation = "-30",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "770",
													text = "Order",
													touchAble = "False",
													touchScaleEnable = "False",
													UILayoutViewModel = 
													{
														PositionY = -26,
													},
													vAlignment = "1",
													width = "52",
													ZOrder = "1",
												},
											},
										},
										{
											controlID = "Button_pokedex_Panel_clip_Panel_right_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
											UUID = "5cbd5673_c8a9_478d_bf05_916a717eb4ba",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											classname = "MEButton",
											ClickHighLightEnabled = "True",
											dstBlendFunc = "771",
											flipX = "False",
											flipY = "False",
											height = "100",
											ignoreSize = "True",
											name = "Button_pokedex",
											normal = "ui/mainLayer/new_ui_1/btn_tujian.png",
											pressed = "ui/mainLayer/new_ui_1/btn_tujian.png",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "True",
											UILayoutViewModel = 
											{
												PositionX = 494,
												PositionY = 302,
											},
											UItype = "Button",
											width = "100",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "Image_poker_tip_Button_pokedex_Panel_clip_Panel_right_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
													UUID = "346ac5a8_4435_412b_b604_4cb2169fe7d4",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0.5",
													backGroundScale9Enable = "False",
													classname = "MEImage",
													dstBlendFunc = "771",
													height = "100",
													ignoreSize = "True",
													name = "Image_poker_tip",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "1",
													texturePath = "ui/mainLayer/new_ui_1/btn_tujiannew.png",
													touchAble = "False",
													UILayoutViewModel = 
													{
														
													},
													width = "100",
													ZOrder = "1",
													components = 
													{
														
														{
															controlID = "Image_updateTip_Image_poker_tip_Button_pokedex_Panel_clip_Panel_right_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
															UUID = "151a566a_6046_4a54_99fd_1c2cfd634b9c",
															anchorPoint = "False",
															anchorPointX = "0.5",
															anchorPointY = "0.5",
															backGroundScale9Enable = "False",
															classname = "MEImage",
															dstBlendFunc = "771",
															height = "30",
															ignoreSize = "True",
															name = "Image_updateTip",
															sizepercentx = "0",
															sizepercenty = "0",
															sizeType = "0",
															srcBlendFunc = "1",
															texturePath = "ui/common/news_small.png",
															touchAble = "False",
															UILayoutViewModel = 
															{
																PositionX = 18,
																PositionY = 11,
															},
															width = "30",
															ZOrder = "1",
														},
													},
												},
												{
													controlID = "Label_title_Button_pokedex_Panel_clip_Panel_right_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
													UUID = "c5764d3e_91f2_43bf_b10f_ee5d99e5558d",
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
														IsStroke = true,
														StrokeColor = "#FF49557F",
														StrokeSize = 1,
													},
													hAlignment = "1",
													height = "25",
													ignoreSize = "True",
													name = "Label_title",
													rotation = "-30",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "770",
													text = "Gallery",
													touchAble = "False",
													touchScaleEnable = "False",
													UILayoutViewModel = 
													{
														PositionY = -26,
													},
													vAlignment = "1",
													width = "62",
													ZOrder = "1",
												},
											},
										},
										{
											controlID = "btn_infoStation_Panel_clip_Panel_right_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
											UUID = "102cb09e_4d56_45b7_acf5_920f8c218d84",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											classname = "MEButton",
											ClickHighLightEnabled = "True",
											dstBlendFunc = "771",
											flipX = "False",
											flipY = "False",
											height = "109",
											ignoreSize = "True",
											name = "btn_infoStation",
											normal = "ui/mainui/main_infoStation.png",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "True",
											UILayoutViewModel = 
											{
												PositionX = 648,
												PositionY = 274,
												relativeToName = "Panel",
											},
											UItype = "Button",
											visible = "False",
											width = "88",
											ZOrder = "1",
										},
										{
											controlID = "Button_sxsr_Panel_clip_Panel_right_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
											UUID = "1fd87b89_9826_4ccc_9587_49dd66ac07dd",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											classname = "MEButton",
											ClickHighLightEnabled = "True",
											dstBlendFunc = "771",
											flipX = "False",
											flipY = "False",
											height = "109",
											ignoreSize = "False",
											name = "Button_sxsr",
											normal = "ui/mainLayer/sxsr.png",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "True",
											UILayoutViewModel = 
											{
												PositionX = 648,
												PositionY = 274,
												LeftPositon = 26,
												TopPosition = 87,
												relativeToName = "Panel",
											},
											UItype = "Button",
											visible = "False",
											width = "109",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "Image_sxsrTip_Button_sxsr_Panel_clip_Panel_right_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
													UUID = "9d397104_c9b2_4a38_9233_48a0ca278388",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0.5",
													backGroundScale9Enable = "False",
													classname = "MEImage",
													dstBlendFunc = "771",
													height = "30",
													ignoreSize = "True",
													name = "Image_sxsrTip",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "1",
													texturePath = "ui/common/news_small.png",
													touchAble = "False",
													UILayoutViewModel = 
													{
														PositionX = 18,
														PositionY = 11,
													},
													width = "30",
													ZOrder = "1",
												},
											},
										},
										{
											controlID = "Image_MainLayer_1(5)_Panel_clip_Panel_right_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
											UUID = "307d062f_7813_40cd_8658_0781982a65b8",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											classname = "MEImage",
											dstBlendFunc = "771",
											height = "106",
											ignoreSize = "True",
											name = "Image_MainLayer_1(5)",
											opacity = "0",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											texturePath = "ui/mainui/main_mask.png",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 644,
												PositionY = 276,
												relativeToName = "Panel",
											},
											visible = "False",
											width = "92",
											ZOrder = "1",
										},
										{
											controlID = "Image_MainLayer_1(3)(3)_Panel_clip_Panel_right_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
											UUID = "6fc71fd6_d8a9_4cb7_90cb_03a4bafc7a35",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											classname = "MEImage",
											dstBlendFunc = "771",
											height = "78",
											ignoreSize = "True",
											name = "Image_MainLayer_1(3)(3)",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											texturePath = "ui/mainLayer/new_ui/bai2.png",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 573,
												PositionY = 311,
											},
											visible = "False",
											width = "68",
											ZOrder = "1",
										},
										{
											controlID = "Image_MainLayer_1(3)(2)_Panel_clip_Panel_right_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
											UUID = "bf8148c4_8364_42b2_a2eb_2471908bea96",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											classname = "MEImage",
											dstBlendFunc = "771",
											height = "78",
											ignoreSize = "True",
											name = "Image_MainLayer_1(3)(2)",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											texturePath = "ui/mainLayer/new_ui/bai2.png",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 471,
												PositionY = 295,
											},
											visible = "False",
											width = "68",
											ZOrder = "1",
										},
										{
											controlID = "Image_MainLayer_1(3)_Panel_clip_Panel_right_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
											UUID = "bdb44d86_381d_4d5a_b710_389ff32f81ce",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											classname = "MEImage",
											dstBlendFunc = "771",
											height = "78",
											ignoreSize = "True",
											name = "Image_MainLayer_1(3)",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											texturePath = "ui/mainLayer/new_ui/bai2.png",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 496,
												PositionY = 295,
											},
											visible = "False",
											width = "68",
											ZOrder = "1",
										},
										{
											controlID = "Image_MainLayer_1(3)-Copy1_Panel_clip_Panel_right_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
											UUID = "1373e365_bd3f_4544_9c87_7f7654b0d13a",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											classname = "MEImage",
											dstBlendFunc = "771",
											height = "78",
											ignoreSize = "True",
											name = "Image_MainLayer_1(3)-Copy1",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											texturePath = "ui/mainLayer/new_ui/bai2.png",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 664,
												PositionY = 287,
											},
											visible = "False",
											width = "68",
											ZOrder = "1",
										},
										{
											controlID = "Panel_activity_Panel_clip_Panel_right_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
											UUID = "0f5f3dd4_a87a_49f0_a2ae_111e19daf9a3",
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
											height = "140",
											ignoreSize = "False",
											name = "Panel_activity",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 457,
												PositionY = 408,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "470",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "activity_1_Panel_activity_Panel_clip_Panel_right_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
													UUID = "b64986be_3499_478f_b3e1_769e42b81f76",
													anchorPoint = "False",
													anchorPointX = "0",
													anchorPointY = "0",
													backGroundScale9Enable = "False",
													classname = "MEImage",
													dstBlendFunc = "771",
													height = "100",
													ignoreSize = "True",
													name = "activity_1",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "1",
													texturePath = "ui/mainLayer/new_ui/btn_guoqing.png",
													touchAble = "False",
													UILayoutViewModel = 
													{
														PositionY = -1,
													},
													visible = "False",
													width = "440",
													ZOrder = "1",
												},
												{
													controlID = "Label_activity_time_Panel_activity_Panel_clip_Panel_right_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
													UUID = "a174e094_e4e0_428f_b238_dabb43e91d1b",
													anchorPoint = "False",
													anchorPointX = "0",
													anchorPointY = "1",
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
														StrokeColor = "#FF000000",
														StrokeSize = 2,
													},
													height = "31",
													ignoreSize = "True",
													name = "Label_activity_time",
													nTextAlign = "1",
													nTextHAlign = "1",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "770",
													text = "Jan 20th - Jan 28th",
													touchAble = "False",
													touchScaleEnable = "False",
													UILayoutViewModel = 
													{
														PositionX = -235,
														PositionY = 70,
														IsPercent = true,
														PercentX = -50,
														PercentY = 50,
													},
													visible = "False",
													width = "186",
													ZOrder = "1",
												},
												{
													controlID = "Image_dot1_Panel_activity_Panel_clip_Panel_right_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
													UUID = "fd7e3892_87ba_473b_b0e2_b31e379cf7cf",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0.5",
													backGroundScale9Enable = "False",
													classname = "MEImage",
													dstBlendFunc = "771",
													height = "18",
													ignoreSize = "True",
													name = "Image_dot1",
													scaleX = "0.7",
													scaleY = "0.7",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "1",
													texturePath = "ui/mainLayer/new_ui/activity_tab_01.png",
													touchAble = "False",
													UILayoutViewModel = 
													{
														PositionX = 232,
														PositionY = 39,
													},
													width = "9",
													ZOrder = "1",
												},
												{
													controlID = "Image_dot2_Panel_activity_Panel_clip_Panel_right_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
													UUID = "1fdd5b6c_a4cd_4553_917c_25b9abb4ef6e",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0.5",
													backGroundScale9Enable = "False",
													classname = "MEImage",
													dstBlendFunc = "771",
													height = "18",
													ignoreSize = "True",
													name = "Image_dot2",
													scaleX = "0.7",
													scaleY = "0.7",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "1",
													texturePath = "ui/mainLayer/new_ui/activity_tab_02.png",
													touchAble = "False",
													UILayoutViewModel = 
													{
														PositionX = 232,
														PositionY = 25,
													},
													width = "9",
													ZOrder = "1",
												},
												{
													controlID = "Image_dot3_Panel_activity_Panel_clip_Panel_right_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
													UUID = "1fbc2276_6ba6_45a7_b30e_8a8f26d30733",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0.5",
													backGroundScale9Enable = "False",
													classname = "MEImage",
													dstBlendFunc = "771",
													height = "18",
													ignoreSize = "True",
													name = "Image_dot3",
													scaleX = "0.7",
													scaleY = "0.7",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "1",
													texturePath = "ui/mainLayer/new_ui/activity_tab_02.png",
													touchAble = "False",
													UILayoutViewModel = 
													{
														PositionX = 232,
														PositionY = 11,
													},
													width = "9",
													ZOrder = "1",
												},
												{
													controlID = "Image_dot4_Panel_activity_Panel_clip_Panel_right_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
													UUID = "4ad83b80_8b0e_445c_8dd5_e80d65eb3eef",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0.5",
													backGroundScale9Enable = "False",
													classname = "MEImage",
													dstBlendFunc = "771",
													height = "18",
													ignoreSize = "True",
													name = "Image_dot4",
													scaleX = "0.7",
													scaleY = "0.7",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "1",
													texturePath = "ui/mainLayer/new_ui/activity_tab_02.png",
													touchAble = "False",
													UILayoutViewModel = 
													{
														PositionX = 232,
														PositionY = -3,
													},
													width = "9",
													ZOrder = "1",
												},
												{
													controlID = "PageView_Activity_Panel_activity_Panel_clip_Panel_right_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
													UUID = "6e12f137_283a_4e2c_8c60_3ac3c2647c81",
													anchorPoint = "False",
													anchorPointX = "0",
													anchorPointY = "0",
													backGroundScale9Enable = "False",
													bgColorOpacity = "50",
													bIsOpenClipping = "True",
													bounceEnable = "False",
													classname = "MEPageView",
													colorType = "0;SingleColor:#FF800080;GraduallyChangingColorStart:#FFFFFFFF;GraduallyChangingColorEnd:#FFFFFFFF;vectorX:0;vectorY:0",
													DesignHeight = "640",
													DesignType = "0",
													DesignWidth = "960",
													dstBlendFunc = "771",
													height = "100",
													ignoreSize = "False",
													name = "PageView_Activity",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "1",
													touchAble = "True",
													UILayoutViewModel = 
													{
														PositionX = -216,
														PositionY = -48,
													},
													uipanelviewmodel = 
													{
														Layout="Absolute",
														nType = "0"
													},
													width = "440",
													ZOrder = "1",
												},
												{
													controlID = "Image_dot5_Panel_activity_Panel_clip_Panel_right_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
													UUID = "e4145774_4b2c_4ff9_af93_93ca84a96eb1",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0.5",
													backGroundScale9Enable = "False",
													classname = "MEImage",
													dstBlendFunc = "771",
													height = "18",
													ignoreSize = "True",
													name = "Image_dot5",
													scaleX = "0.7",
													scaleY = "0.7",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "1",
													texturePath = "ui/mainLayer/new_ui/activity_tab_02.png",
													touchAble = "False",
													UILayoutViewModel = 
													{
														PositionX = 232,
														PositionY = -17,
													},
													width = "9",
													ZOrder = "1",
												},
												{
													controlID = "Image_dot6_Panel_activity_Panel_clip_Panel_right_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
													UUID = "f847e1d3_e23d_4c5d_8564_20fe4bacf12f",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0.5",
													backGroundScale9Enable = "False",
													classname = "MEImage",
													dstBlendFunc = "771",
													height = "18",
													ignoreSize = "True",
													name = "Image_dot6",
													scaleX = "0.7",
													scaleY = "0.7",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "1",
													texturePath = "ui/mainLayer/new_ui/activity_tab_02.png",
													touchAble = "False",
													UILayoutViewModel = 
													{
														PositionX = 232,
														PositionY = -31,
													},
													width = "9",
													ZOrder = "1",
												},
												{
													controlID = "Image_dot7_Panel_activity_Panel_clip_Panel_right_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
													UUID = "dd0e3f35_cdd1_4107_9e9f_c0361092d6ae",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0.5",
													backGroundScale9Enable = "False",
													classname = "MEImage",
													dstBlendFunc = "771",
													height = "18",
													ignoreSize = "True",
													name = "Image_dot7",
													scaleX = "0.7",
													scaleY = "0.7",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "1",
													texturePath = "ui/mainLayer/new_ui/activity_tab_02.png",
													touchAble = "False",
													UILayoutViewModel = 
													{
														PositionX = 232,
														PositionY = -45,
													},
													width = "9",
													ZOrder = "1",
												},
												{
													controlID = "Image_dot8_Panel_activity_Panel_clip_Panel_right_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
													UUID = "e3618d80_1e9f_4801_aeaf_824d7f3d1ae8",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0.5",
													backGroundScale9Enable = "False",
													classname = "MEImage",
													dstBlendFunc = "771",
													height = "18",
													ignoreSize = "True",
													name = "Image_dot8",
													scaleX = "0.7",
													scaleY = "0.7",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "1",
													texturePath = "ui/mainLayer/new_ui/activity_tab_02.png",
													touchAble = "False",
													UILayoutViewModel = 
													{
														PositionX = 232,
														PositionY = -59,
													},
													width = "9",
													ZOrder = "1",
												},
												{
													controlID = "Image_dot9_Panel_activity_Panel_clip_Panel_right_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
													UUID = "267ef802_b5c6_43bc_8375_edd7bcc3d09c",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0.5",
													backGroundScale9Enable = "False",
													classname = "MEImage",
													dstBlendFunc = "771",
													height = "18",
													ignoreSize = "True",
													name = "Image_dot9",
													scaleX = "0.7",
													scaleY = "0.7",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "1",
													texturePath = "ui/mainLayer/new_ui/activity_tab_02.png",
													touchAble = "False",
													UILayoutViewModel = 
													{
														PositionX = 232,
														PositionY = -73,
													},
													width = "9",
													ZOrder = "1",
												},
												{
													controlID = "btn_ad_Panel_activity_Panel_clip_Panel_right_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
													UUID = "42c4ff00_3e9c_4e16_bd70_735f1dff2f37",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0.5",
													backGroundScale9Enable = "False",
													classname = "MEButton",
													ClickHighLightEnabled = "True",
													dstBlendFunc = "771",
													flipX = "False",
													flipY = "False",
													height = "84",
													ignoreSize = "True",
													name = "btn_ad",
													normal = "ui/mainLayer/ad_btn.png",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "1",
													touchAble = "True",
													UILayoutViewModel = 
													{
														PositionX = -112,
														PositionY = 6,
													},
													UItype = "Button",
													width = "64",
													ZOrder = "1",
												},
											},
										},
										{
											controlID = "Button_Activity2_Panel_clip_Panel_right_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
											UUID = "ca605d69_dc56_4df7_889c_455722f66b3c",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											classname = "MEButton",
											ClickHighLightEnabled = "True",
											dstBlendFunc = "771",
											flipX = "False",
											flipY = "False",
											height = "140",
											ignoreSize = "True",
											name = "Button_Activity2",
											normal = "ui/mainLayer/new_ui/a2.png",
											pressed = "ui/mainLayer/new_ui/a2.png",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "True",
											UILayoutViewModel = 
											{
												PositionX = 477,
												PositionY = 61,
											},
											UItype = "Button",
											width = "140",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "Spine_MainLayer_1_Button_Activity2_Panel_clip_Panel_right_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
													UUID = "59fc6e8f_d0a3_424d_b9d5_1300eb1c7d2a",
													classname = "MESpine",
													dstBlendFunc = "771",
													name = "Spine_MainLayer_1",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													spineModel = 
													{
														SpinePath = "effect/effect_fanzhezijiemian/effect_emojianglin",
														animationName = "effect_emojianglin_dpwn",
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
														
													},
													visible = "False",
													ZOrder = "-100",
												},
												{
													controlID = "Image_activityTip_Button_Activity2_Panel_clip_Panel_right_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
													UUID = "0dae3e83_fef0_4bed_aeaf_12f6fe890530",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0.5",
													backGroundScale9Enable = "False",
													classname = "MEImage",
													dstBlendFunc = "771",
													height = "30",
													ignoreSize = "True",
													name = "Image_activityTip",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "1",
													texturePath = "ui/common/news_small.png",
													touchAble = "False",
													UILayoutViewModel = 
													{
														PositionX = 40,
														PositionY = 31,
													},
													width = "30",
													ZOrder = "1",
												},
												{
													controlID = "Spine_MainLayer_2_Button_Activity2_Panel_clip_Panel_right_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
													UUID = "73a72691_932d_43df_b80b_fa5bcd7500ee",
													classname = "MESpine",
													dstBlendFunc = "771",
													name = "Spine_MainLayer_2",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													spineModel = 
													{
														SpinePath = "effect/effect_fanzhezijiemian/effect_emojianglin",
														animationName = "effect_emojianglin_up",
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
														
													},
													visible = "False",
													ZOrder = "1",
												},
											},
										},
										{
											controlID = "Button_mail_Panel_clip_Panel_right_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
											UUID = "b7223969_9055_4398_a4e8_4f7c732522cf",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											classname = "MEButton",
											ClickHighLightEnabled = "True",
											dstBlendFunc = "771",
											flipX = "False",
											flipY = "False",
											height = "100",
											ignoreSize = "True",
											name = "Button_mail",
											normal = "ui/mainLayer/new_ui_1/btn_mail.png",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "True",
											UILayoutViewModel = 
											{
												PositionX = 344,
												PositionY = 301,
												LeftPositon = 26,
												TopPosition = 87,
												relativeToName = "Panel",
											},
											UItype = "Button",
											width = "100",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "Image_mail_Button_mail_Panel_clip_Panel_right_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
													UUID = "1458743e_1c5e_41b5_90e7_98f055e79186",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0.5",
													backGroundScale9Enable = "False",
													classname = "MEImage",
													dstBlendFunc = "771",
													height = "30",
													ignoreSize = "True",
													name = "Image_mail",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "1",
													texturePath = "ui/mainui/mail_logo.png",
													touchAble = "False",
													UILayoutViewModel = 
													{
														PositionY = 10,
													},
													visible = "False",
													width = "30",
													ZOrder = "1",
												},
												{
													controlID = "Image_mailTip_Button_mail_Panel_clip_Panel_right_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
													UUID = "8f65256c_4a9d_4c30_b224_291c75ff341a",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0.5",
													backGroundScale9Enable = "False",
													classname = "MEImage",
													dstBlendFunc = "771",
													height = "100",
													ignoreSize = "True",
													name = "Image_mailTip",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "1",
													texturePath = "ui/mainLayer/new_ui_1/btn_mailnew.png",
													touchAble = "False",
													UILayoutViewModel = 
													{
														
													},
													width = "100",
													ZOrder = "1",
													components = 
													{
														
														{
															controlID = "Image_updateTip_Image_mailTip_Button_mail_Panel_clip_Panel_right_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
															UUID = "818433bf_6470_40e1_ac01_d601cd41cb70",
															anchorPoint = "False",
															anchorPointX = "0.5",
															anchorPointY = "0.5",
															backGroundScale9Enable = "False",
															classname = "MEImage",
															dstBlendFunc = "771",
															height = "30",
															ignoreSize = "True",
															name = "Image_updateTip",
															sizepercentx = "0",
															sizepercenty = "0",
															sizeType = "0",
															srcBlendFunc = "1",
															texturePath = "ui/common/news_small.png",
															touchAble = "False",
															UILayoutViewModel = 
															{
																PositionX = 18,
																PositionY = 11,
															},
															width = "30",
															ZOrder = "1",
														},
													},
												},
												{
													controlID = "Label_title_Button_mail_Panel_clip_Panel_right_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
													UUID = "ef90d868_59b4_4252_8892_e1272f1ac31b",
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
														StrokeColor = "#FF000000",
														StrokeSize = 1,
													},
													height = "25",
													ignoreSize = "True",
													name = "Label_title",
													nTextAlign = "1",
													nTextHAlign = "1",
													rotation = "-30",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "770",
													text = "Mail",
													touchAble = "False",
													touchScaleEnable = "False",
													UILayoutViewModel = 
													{
														PositionX = 6,
														PositionY = -29,
													},
													width = "41",
													ZOrder = "1",
												},
												{
													controlID = "img_bubble_Button_mail_Panel_clip_Panel_right_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
													UUID = "c2f9db80_d46c_4620_89a1_f43d572115c8",
													anchorPoint = "False",
													anchorPointX = "1",
													anchorPointY = "0",
													backGroundScale9Enable = "False",
													classname = "MEImage",
													dstBlendFunc = "771",
													height = "68",
													ignoreSize = "True",
													name = "img_bubble",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "1",
													texturePath = "ui/mail/special_mail/img_bubble.png",
													touchAble = "False",
													UILayoutViewModel = 
													{
														PositionX = -17,
														PositionY = 15,
													},
													width = "60",
													ZOrder = "1",
												},
											},
										},
										{
											controlID = "button_Caociyuan_Panel_clip_Panel_right_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
											UUID = "6ffa683f_e163_4bc1_9b3c_f742919eaa78",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											classname = "MEButton",
											ClickHighLightEnabled = "True",
											dstBlendFunc = "771",
											flipX = "False",
											flipY = "False",
											height = "107",
											ignoreSize = "True",
											name = "button_Caociyuan",
											normal = "ui/mainLayer3/c12.png",
											pressed = "ui/mainLayer3/c12.png",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "True",
											UILayoutViewModel = 
											{
												PositionX = 301,
												PositionY = 63,
											},
											UItype = "Button",
											width = "176",
											ZOrder = "1",
										},
										{
											controlID = "button_OneYear_Panel_clip_Panel_right_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
											UUID = "5800eef1_b802_4484_a755_125f9f790ccc",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											classname = "MEButton",
											ClickHighLightEnabled = "True",
											dstBlendFunc = "771",
											flipX = "False",
											flipY = "False",
											height = "114",
											ignoreSize = "True",
											name = "button_OneYear",
											normal = "ui/mainLayer3/c13.png",
											pressed = "ui/mainLayer3/c13.png",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "True",
											UILayoutViewModel = 
											{
												PositionX = 485,
												PositionY = 53,
											},
											UItype = "Button",
											width = "184",
											ZOrder = "1",
										},
										{
											controlID = "Image_OneYearClip_Panel_clip_Panel_right_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
											UUID = "e246ca66_5ae9_46f4_9e5a_8d32b3beab54",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											classname = "MEImage",
											dstBlendFunc = "771",
											height = "110",
											ignoreSize = "True",
											name = "Image_OneYearClip",
											opacity = "150",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											texturePath = "ui/mainLayer3/35.png",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 442,
												PositionY = 51,
											},
											width = "231",
											ZOrder = "1",
										},
										{
											controlID = "Button_Activity5_Panel_clip_Panel_right_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
											UUID = "45d0abc2_15da_4d81_b0d6_3deb8da73e3d",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											classname = "MEButton",
											ClickHighLightEnabled = "True",
											dstBlendFunc = "771",
											flipX = "False",
											flipY = "False",
											height = "128",
											ignoreSize = "True",
											name = "Button_Activity5",
											normal = "ui/mainLayer/new_ui/a4.png",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "True",
											UILayoutViewModel = 
											{
												PositionX = 488,
												PositionY = 62,
												LeftPositon = 26,
												TopPosition = 87,
												relativeToName = "Panel",
											},
											UItype = "Button",
											width = "226",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "Image_update_Button_Activity5_Panel_clip_Panel_right_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
													UUID = "a66cdcc0_da2d_495b_89e6_62b29d536f13",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0.5",
													backGroundScale9Enable = "False",
													classname = "MEImage",
													dstBlendFunc = "771",
													height = "50",
													ignoreSize = "True",
													name = "Image_update",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "1",
													texturePath = "ui/mainLayer/new_ui/btn_ativity.png",
													touchAble = "False",
													UILayoutViewModel = 
													{
														PositionY = 10,
													},
													visible = "False",
													width = "50",
													ZOrder = "1",
												},
												{
													controlID = "Image_activity_red5_Button_Activity5_Panel_clip_Panel_right_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
													UUID = "623e3516_f8e7_411b_874f_7291c670399d",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0.5",
													backGroundScale9Enable = "False",
													classname = "MEImage",
													dstBlendFunc = "771",
													height = "30",
													ignoreSize = "True",
													name = "Image_activity_red5",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "1",
													texturePath = "ui/common/news_small.png",
													touchAble = "False",
													UILayoutViewModel = 
													{
														PositionX = 49,
														PositionY = -2,
													},
													width = "30",
													ZOrder = "1",
												},
											},
										},
										{
											controlID = "Image_CaociyuanClip_Panel_clip_Panel_right_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
											UUID = "ceec4ae3_3c82_453f_99b6_029b0f1e7ca7",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											classname = "MEImage",
											dstBlendFunc = "771",
											height = "98",
											ignoreSize = "True",
											name = "Image_CaociyuanClip",
											opacity = "150",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											texturePath = "ui/mainLayer3/36.png",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 301,
												PositionY = 68,
											},
											width = "217",
											ZOrder = "1",
										},
										{
											controlID = "Button_friend_Panel_clip_Panel_right_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
											UUID = "73ec5476_fc77_43f3_92d0_41e1482dd965",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											classname = "MEButton",
											ClickHighLightEnabled = "True",
											dstBlendFunc = "771",
											flipX = "False",
											flipY = "False",
											height = "100",
											ignoreSize = "True",
											name = "Button_friend",
											normal = "ui/mainLayer/new_ui_1/btn_contact.png",
											pressed = "ui/mainLayer/new_ui_1/btn_contact.png",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "True",
											UILayoutViewModel = 
											{
												PositionX = 422,
												PositionY = 319,
												LeftPositon = 26,
												TopPosition = 87,
												relativeToName = "Panel",
											},
											UItype = "Button",
											width = "100",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "Image_friendTip_Button_friend_Panel_clip_Panel_right_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
													UUID = "3cb3ff17_33bd_485f_a28c_7d381f7aaff9",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0.5",
													backGroundScale9Enable = "False",
													classname = "MEImage",
													dstBlendFunc = "771",
													height = "100",
													ignoreSize = "True",
													name = "Image_friendTip",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "1",
													texturePath = "ui/mainLayer/new_ui_1/btn_contactnew.png",
													touchAble = "False",
													UILayoutViewModel = 
													{
														
													},
													width = "100",
													ZOrder = "1",
													components = 
													{
														
														{
															controlID = "Image_updateTip_Image_friendTip_Button_friend_Panel_clip_Panel_right_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
															UUID = "437e98f7_dc17_429c_bb7e_31a052bec3d8",
															anchorPoint = "False",
															anchorPointX = "0.5",
															anchorPointY = "0.5",
															backGroundScale9Enable = "False",
															classname = "MEImage",
															dstBlendFunc = "771",
															height = "30",
															ignoreSize = "True",
															name = "Image_updateTip",
															sizepercentx = "0",
															sizepercenty = "0",
															sizeType = "0",
															srcBlendFunc = "1",
															texturePath = "ui/common/news_small.png",
															touchAble = "False",
															UILayoutViewModel = 
															{
																PositionX = 18,
																PositionY = 11,
															},
															width = "30",
															ZOrder = "1",
														},
													},
												},
												{
													controlID = "Label_title_Button_friend_Panel_clip_Panel_right_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
													UUID = "487a51f9_0078_43af_8a11_fa3f2463278f",
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
														StrokeColor = "#FF000000",
														StrokeSize = 1,
													},
													height = "25",
													ignoreSize = "True",
													name = "Label_title",
													nTextAlign = "1",
													nTextHAlign = "1",
													rotation = "-30",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "770",
													text = "Social",
													touchAble = "False",
													touchScaleEnable = "False",
													UILayoutViewModel = 
													{
														PositionY = -26,
													},
													width = "51",
													ZOrder = "1",
												},
											},
										},
										{
											controlID = "Button_Activity6_Panel_clip_Panel_right_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
											UUID = "a8f00ea7_c4cf_4895_ab04_5dcbfced92ba",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											classname = "MEButton",
											ClickHighLightEnabled = "True",
											dstBlendFunc = "771",
											flipX = "False",
											flipY = "False",
											height = "114",
											ignoreSize = "True",
											name = "Button_Activity6",
											normal = "ui/mainLayer/new_ui/a5.png",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "True",
											UILayoutViewModel = 
											{
												PositionX = 488,
												PositionY = 62,
												LeftPositon = 26,
												TopPosition = 87,
												relativeToName = "Panel",
											},
											UItype = "Button",
											width = "260",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "Image_update_Button_Activity6_Panel_clip_Panel_right_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
													UUID = "2016b838_d122_4477_9570_169711653388",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0.5",
													backGroundScale9Enable = "False",
													classname = "MEImage",
													dstBlendFunc = "771",
													height = "50",
													ignoreSize = "True",
													name = "Image_update",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "1",
													texturePath = "ui/mainLayer/new_ui/btn_ativity.png",
													touchAble = "False",
													UILayoutViewModel = 
													{
														PositionY = 10,
													},
													visible = "False",
													width = "50",
													ZOrder = "1",
												},
												{
													controlID = "Image_activity_red6_Button_Activity6_Panel_clip_Panel_right_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
													UUID = "6dd03e32_a733_40bb_9dc1_4d862375846a",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0.5",
													backGroundScale9Enable = "False",
													classname = "MEImage",
													dstBlendFunc = "771",
													height = "30",
													ignoreSize = "True",
													name = "Image_activity_red6",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "1",
													texturePath = "ui/common/news_small.png",
													touchAble = "False",
													UILayoutViewModel = 
													{
														PositionX = 98,
														PositionY = 46,
													},
													width = "30",
													ZOrder = "1",
												},
											},
										},
										{
											controlID = "Button_Activity7_Panel_clip_Panel_right_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
											UUID = "360dcf25_81f2_487d_9770_e4c52bde4881",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											classname = "MEButton",
											ClickHighLightEnabled = "True",
											dstBlendFunc = "771",
											flipX = "False",
											flipY = "False",
											height = "124",
											ignoreSize = "True",
											name = "Button_Activity7",
											normal = "ui/mainLayer/new_ui/a6.png",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "True",
											UILayoutViewModel = 
											{
												PositionX = 488,
												PositionY = 62,
												LeftPositon = 26,
												TopPosition = 87,
												relativeToName = "Panel",
											},
											UItype = "Button",
											width = "193",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "Image_update_Button_Activity7_Panel_clip_Panel_right_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
													UUID = "ee1eb124_4023_4976_96e0_099c0e5c7b9e",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0.5",
													backGroundScale9Enable = "False",
													classname = "MEImage",
													dstBlendFunc = "771",
													height = "50",
													ignoreSize = "True",
													name = "Image_update",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "1",
													texturePath = "ui/mainLayer/new_ui/btn_ativity.png",
													touchAble = "False",
													UILayoutViewModel = 
													{
														PositionY = 10,
													},
													visible = "False",
													width = "50",
													ZOrder = "1",
												},
												{
													controlID = "Image_activity_red7_Button_Activity7_Panel_clip_Panel_right_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
													UUID = "2c18fbbe_ee01_409b_b2a4_9b2a4c016bd1",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0.5",
													backGroundScale9Enable = "False",
													classname = "MEImage",
													dstBlendFunc = "771",
													height = "30",
													ignoreSize = "True",
													name = "Image_activity_red7",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "1",
													texturePath = "ui/common/news_small.png",
													touchAble = "False",
													UILayoutViewModel = 
													{
														PositionX = 49,
														PositionY = -2,
													},
													width = "30",
													ZOrder = "1",
												},
											},
										},
										{
											controlID = "activityPos_left_Panel_clip_Panel_right_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
											UUID = "d2fbeb5e_c188_4926_a3fe_93439e8dfde3",
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
											name = "activityPos_left",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 431,
												PositionY = 51,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											visible = "False",
											width = "50",
											ZOrder = "1",
										},
										{
											controlID = "activityPos_mid_Panel_clip_Panel_right_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
											UUID = "3c84d144_5dd1_4402_8422_8109298b5457",
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
											name = "activityPos_mid",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 488,
												PositionY = 63,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											visible = "False",
											width = "50",
											ZOrder = "1",
										},
										{
											controlID = "activityPos_right_Panel_clip_Panel_right_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
											UUID = "aa326fe0_4cb2_47d2_9fcb_89b6e9285cc5",
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
											name = "activityPos_right",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 557,
												PositionY = 51,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											visible = "False",
											width = "50",
											ZOrder = "1",
										},
										{
											controlID = "Button_Activity90_Panel_clip_Panel_right_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
											UUID = "75999765_4b3d_4298_843f_9a47ec901859",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											classname = "MEButton",
											ClickHighLightEnabled = "True",
											dstBlendFunc = "771",
											flipX = "False",
											flipY = "False",
											height = "94",
											ignoreSize = "True",
											name = "Button_Activity90",
											normal = "ui/mainLayer/new_ui_4/rukou.png",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "True",
											UILayoutViewModel = 
											{
												PositionX = 488,
												PositionY = 62,
												LeftPositon = 26,
												TopPosition = 87,
												relativeToName = "Panel",
											},
											UItype = "Button",
											width = "200",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "Image_update_Button_Activity90_Panel_clip_Panel_right_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
													UUID = "b096559a_d150_4101_b082_03128f2a1e43",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0.5",
													backGroundScale9Enable = "False",
													classname = "MEImage",
													dstBlendFunc = "771",
													height = "50",
													ignoreSize = "True",
													name = "Image_update",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "1",
													texturePath = "ui/mainLayer/new_ui/btn_ativity.png",
													touchAble = "False",
													UILayoutViewModel = 
													{
														PositionY = 10,
													},
													visible = "False",
													width = "50",
													ZOrder = "1",
												},
												{
													controlID = "Image_activity_red90_Button_Activity90_Panel_clip_Panel_right_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
													UUID = "d7986dd4_f508_480b_b19d_92f11d9baf35",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0.5",
													backGroundScale9Enable = "False",
													classname = "MEImage",
													dstBlendFunc = "771",
													height = "30",
													ignoreSize = "True",
													name = "Image_activity_red90",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "1",
													texturePath = "ui/common/news_small.png",
													touchAble = "False",
													UILayoutViewModel = 
													{
														PositionX = 81,
														PositionY = 27,
													},
													width = "30",
													ZOrder = "1",
												},
											},
										},
										{
											controlID = "Button_Activity91_Panel_clip_Panel_right_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
											UUID = "59f4b8cf_17b6_46e0_8909_43021424a0b5",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											classname = "MEButton",
											ClickHighLightEnabled = "True",
											dstBlendFunc = "771",
											flipX = "False",
											flipY = "False",
											height = "123",
											ignoreSize = "True",
											name = "Button_Activity91",
											normal = "ui/activity/activityMain91/main_rukou.png",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "True",
											UILayoutViewModel = 
											{
												PositionX = 488,
												PositionY = 62,
												LeftPositon = 26,
												TopPosition = 87,
												relativeToName = "Panel",
											},
											UItype = "Button",
											width = "259",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "Image_update_Button_Activity91_Panel_clip_Panel_right_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
													UUID = "d09060b8_3486_436b_b315_e1b5c65e9053",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0.5",
													backGroundScale9Enable = "False",
													classname = "MEImage",
													dstBlendFunc = "771",
													height = "50",
													ignoreSize = "True",
													name = "Image_update",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "1",
													texturePath = "ui/mainLayer/new_ui/btn_ativity.png",
													touchAble = "False",
													UILayoutViewModel = 
													{
														PositionY = 10,
													},
													visible = "False",
													width = "50",
													ZOrder = "1",
												},
												{
													controlID = "Image_activity_red91_Button_Activity91_Panel_clip_Panel_right_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
													UUID = "4a669086_f9d3_4ade_b2ae_ee931ada99fa",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0.5",
													backGroundScale9Enable = "False",
													classname = "MEImage",
													dstBlendFunc = "771",
													height = "30",
													ignoreSize = "True",
													name = "Image_activity_red91",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "1",
													texturePath = "ui/common/news_small.png",
													touchAble = "False",
													UILayoutViewModel = 
													{
														PositionX = 53,
														PositionY = 9,
													},
													width = "30",
													ZOrder = "1",
												},
											},
										},
									},
								},
								{
									controlID = "Panel_feelling_info_Panel_right_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
									UUID = "351c32c9_99b1_4ec9_aa1c_ffa2b2fbbb08",
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
									height = "210",
									ignoreSize = "False",
									name = "Panel_feelling_info",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = 106,
										PositionY = 277,
									},
									uipanelviewmodel = 
									{
										Layout="Absolute",
										nType = "0"
									},
									width = "210",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "Image_feelling_bg_Panel_feelling_info_Panel_right_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
											UUID = "26dffa52_e668_4ffd_8eb2_11e2366802f1",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											classname = "MEImage",
											dstBlendFunc = "771",
											height = "206",
											ignoreSize = "True",
											name = "Image_feelling_bg",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											texturePath = "ui/mainLayer/c2.png",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 1,
											},
											width = "206",
											ZOrder = "1",
										},
										{
											controlID = "Btn_aiChat_Panel_feelling_info_Panel_right_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
											UUID = "ce8b7176_7e64_42d5_8b6f_66dfa5baa8ac",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											classname = "MEButton",
											ClickHighLightEnabled = "True",
											dstBlendFunc = "771",
											flipX = "False",
											flipY = "True",
											height = "128",
											HitType = 
											{
												nHitType = 3,
											},
											ignoreSize = "True",
											name = "Btn_aiChat",
											normal = "ui/mainLayer/L1.png",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "True",
											UILayoutViewModel = 
											{
												PositionX = -42,
												PositionY = 1,
											},
											UItype = "Button",
											width = "90",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "img_redNew_Btn_aiChat_Panel_feelling_info_Panel_right_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
													UUID = "4afc2d99_677e_4b78_88a0_cea16d11af62",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0.5",
													backGroundScale9Enable = "False",
													classname = "MEImage",
													dstBlendFunc = "771",
													height = "30",
													ignoreSize = "True",
													name = "img_redNew",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "1",
													texturePath = "ui/common/news_small.png",
													touchAble = "False",
													UILayoutViewModel = 
													{
														PositionX = 8,
														PositionY = 13,
													},
													width = "30",
													ZOrder = "1",
												},
											},
										},
										{
											controlID = "img_lockAiChat_Panel_feelling_info_Panel_right_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
											UUID = "8c01279c_ca96_4f9a_bc33_549406b9b43e",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											classname = "MEImage",
											dstBlendFunc = "771",
											height = "128",
											ignoreSize = "True",
											name = "img_lockAiChat",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											texturePath = "ui/mainLayer/L3.png",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = -42,
												PositionY = 1,
											},
											width = "90",
											ZOrder = "1",
										},
										{
											controlID = "Button_feellint_edit_Panel_feelling_info_Panel_right_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
											UUID = "657763fb_ada0_4bf7_853b_4073641f9a1e",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											classname = "MEButton",
											ClickHighLightEnabled = "True",
											dstBlendFunc = "771",
											flipX = "False",
											flipY = "False",
											height = "128",
											HitType = 
											{
												nHitType = 3,
											},
											ignoreSize = "True",
											name = "Button_feellint_edit",
											normal = "ui/mainLayer/L2.png",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "True",
											UILayoutViewModel = 
											{
												PositionX = 44,
											},
											UItype = "Button",
											width = "90",
											ZOrder = "1",
										},
										{
											controlID = "img_heart_Panel_feelling_info_Panel_right_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
											UUID = "be6ba457_3bb0_4732_9525_426b3eadfd2f",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											classname = "MEImage",
											dstBlendFunc = "771",
											height = "46",
											ignoreSize = "True",
											name = "img_heart",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											texturePath = "ui/mainLayer/c3.png",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 1,
											},
											width = "46",
											ZOrder = "1",
										},
										{
											controlID = "LoadingBar_feelling_bar_Panel_feelling_info_Panel_right_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
											UUID = "1f6354c5_951c_42bc_8f3d_5c577b7ad967",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											classname = "MELoadingBar",
											direction = "4",
											dstBlendFunc = "771",
											height = "206",
											ignoreSize = "True",
											name = "LoadingBar_feelling_bar",
											percent = "76",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											texture = "ui/mainLayer/c1.png",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 1,
											},
											width = "206",
											ZOrder = "1",
										},
										{
											controlID = "Label_MainLayer_1_Panel_feelling_info_Panel_right_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
											UUID = "00b0de17_eafa_42f3_a297_ae50872c16d0",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											classname = "MELabel",
											compPath = "luacomponents.common.MEIconLabel",
											dstBlendFunc = "771",
											FontColor = "#FFFFDDE3",
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
												IsStroke = true,
												StrokeColor = "#FFB53C79",
												StrokeSize = 1,
											},
											height = "22",
											ignoreSize = "True",
											name = "Label_MainLayer_1",
											nTextAlign = "1",
											nTextHAlign = "1",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "770",
											text = "Favor",
											touchAble = "False",
											touchScaleEnable = "False",
											UILayoutViewModel = 
											{
												PositionY = -42,
											},
											width = "45",
											ZOrder = "1",
										},
										{
											controlID = "Label_feelling_percent_Panel_feelling_info_Panel_right_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
											UUID = "1c239392_ca36_4ca5_a4a5_b6a59b6d3804",
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
												IsStroke = true,
												StrokeColor = "#FFB53C79",
												StrokeSize = 1,
											},
											height = "18",
											ignoreSize = "True",
											name = "Label_feelling_percent",
											nTextAlign = "1",
											nTextHAlign = "1",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "770",
											text = "20 30",
											touchAble = "False",
											touchScaleEnable = "False",
											UILayoutViewModel = 
											{
												PositionX = 1,
												PositionY = -65,
											},
											width = "38",
											ZOrder = "1",
										},
										{
											controlID = "Label_feelling_level_Panel_feelling_info_Panel_right_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
											UUID = "12223eb6_ef11_4719_b3b0_03e8900695c5",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											classname = "MELabel",
											compPath = "luacomponents.common.MEIconLabel",
											dstBlendFunc = "771",
											FontColor = "#FFFFDDE3",
											fontName = "phanta.ttf",
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
												StrokeColor = "#FFB53C79",
												StrokeSize = 1,
											},
											height = "25",
											ignoreSize = "True",
											name = "Label_feelling_level",
											nTextAlign = "1",
											nTextHAlign = "1",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "770",
											text = "LV 66",
											touchAble = "False",
											touchScaleEnable = "False",
											UILayoutViewModel = 
											{
												PositionX = 2,
												PositionY = 47,
											},
											width = "49",
											ZOrder = "1",
										},
									},
								},
							},
						},
						{
							controlID = "Panel_bottom_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
							UUID = "49986894_a7d1_430c_a41c_7e76ef52348d",
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
							height = "100",
							ignoreSize = "False",
							name = "Panel_bottom",
							panelTexturePath = "ui/mainLayer/new_ui_1/bottombg.png",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							touchAble = "False",
							UILayoutViewModel = 
							{
								PositionX = 502,
								PositionY = -13,
								LeftPositon = 495,
								TopPosition = 515,
								relativeToName = "Panel",
							},
							uipanelviewmodel = 
							{
								Layout="Absolute",
								nType = "0"
							},
							width = "660",
							ZOrder = "5",
							components = 
							{
								
								{
									controlID = "Image_fairyMain_1_Panel_bottom_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
									UUID = "384cc13b_023f_4d76_89b2_2d26336637f0",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "20",
									ignoreSize = "True",
									name = "Image_fairyMain_1",
									opacity = "50",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/mainLayer/new_ui_1/ui_001.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = 157,
										PositionY = 21,
									},
									width = "2",
									ZOrder = "1",
								},
								{
									controlID = "Image_DefaultMainLayer_1_Panel_bottom_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
									UUID = "a405e26a_e342_4b7a_a705_41b51e91fa36",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "60",
									ignoreSize = "True",
									name = "Image_DefaultMainLayer_1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/mainLayer/new_ui_1/iconbg.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = -49,
										PositionY = 45,
									},
									width = "60",
									ZOrder = "1",
								},
								{
									controlID = "Image_DefaultMainLayer_1-Copy1_Panel_bottom_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
									UUID = "eb1ac999_f5c7_4657_8a3a_3be65415c452",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "60",
									ignoreSize = "True",
									name = "Image_DefaultMainLayer_1-Copy1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/mainLayer/new_ui_1/iconbg.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = 53,
										PositionY = 45,
									},
									width = "60",
									ZOrder = "1",
								},
								{
									controlID = "Image_DefaultMainLayer_1-Copy2_Panel_bottom_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
									UUID = "d613b083_9459_4575_b5f3_e2634bfb9179",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "60",
									ignoreSize = "True",
									name = "Image_DefaultMainLayer_1-Copy2",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/mainLayer/new_ui_1/iconbg.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = 160,
										PositionY = 48,
									},
									width = "60",
									ZOrder = "1",
								},
								{
									controlID = "Image_DefaultMainLayer_1-Copy3_Panel_bottom_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
									UUID = "863edf41_7791_4b85_86a7_ce5408aa9e0d",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "60",
									ignoreSize = "True",
									name = "Image_DefaultMainLayer_1-Copy3",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/mainLayer/new_ui_1/iconbg.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = 252,
										PositionY = 45,
									},
									width = "60",
									ZOrder = "1",
								},
								{
									controlID = "Image_DefaultMainLayer_1-Copy4_Panel_bottom_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
									UUID = "a23732c6_0ba3_484a_9e74_5f1a325ee5d3",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "60",
									ignoreSize = "True",
									name = "Image_DefaultMainLayer_1-Copy4",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/mainLayer/new_ui_1/iconbg.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = 371,
										PositionY = 45,
									},
									width = "60",
									ZOrder = "1",
								},
								{
									controlID = "Image_DefaultMainLayer_1-Copy5_Panel_bottom_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
									UUID = "aeb13291_4e1f_426a_9d24_c1ff87528680",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "60",
									ignoreSize = "True",
									name = "Image_DefaultMainLayer_1-Copy5",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/mainLayer/new_ui_1/iconbg.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = 472,
										PositionY = 45,
									},
									width = "60",
									ZOrder = "1",
								},
								{
									controlID = "Button_fairy_Panel_bottom_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
									UUID = "be862c3a_fc8b_4ef0_836f_ccc4d0f5adf6",
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
										nXpos = 10,
										nYpos = 6,
										nHitWidth = 80,
										nHitHeight = 50
									},
									ignoreSize = "True",
									name = "Button_fairy",
									normal = "ui/mainLayer/new_ui_1/btn_sprite.png",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "True",
									UILayoutViewModel = 
									{
										PositionX = -69,
										PositionY = 46,
									},
									UItype = "Button",
									width = "60",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "RedTips_Button_fairy_Panel_bottom_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
											UUID = "79fe8ac1_0012_4f88_8728_b5d5ad8e23f2",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											classname = "MEImage",
											dstBlendFunc = "771",
											height = "2",
											ignoreSize = "True",
											name = "RedTips",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											texturePath = "ui/common/redPoint.png",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 27,
												PositionY = 26,
											},
											width = "2",
											ZOrder = "1",
										},
										{
											controlID = "Image_unlock_Button_fairy_Panel_bottom_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
											UUID = "ee3bb26d_1833_43e3_ac82_95955e783a3b",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											classname = "MEImage",
											dstBlendFunc = "771",
											height = "55",
											ignoreSize = "True",
											name = "Image_unlock",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											texturePath = "ui/fairy/new_ui/unlcok2.png",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionY = 45,
											},
											width = "103",
											ZOrder = "1",
										},
										{
											controlID = "Image_roleup_Button_fairy_Panel_bottom_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
											UUID = "c7d710c1_5552_4fe2_a5e7_4e223fd2fb53",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											classname = "MEImage",
											dstBlendFunc = "771",
											height = "60",
											ignoreSize = "True",
											name = "Image_roleup",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											texturePath = "ui/mainLayer/new_ui_1/btn_spritenew.png",
											touchAble = "False",
											UILayoutViewModel = 
											{
												
											},
											width = "60",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "Image_updateTip_Image_roleup_Button_fairy_Panel_bottom_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
													UUID = "08231b58_06d7_485b_978e_0b11098313c9",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0.5",
													backGroundScale9Enable = "False",
													classname = "MEImage",
													dstBlendFunc = "771",
													height = "30",
													ignoreSize = "True",
													name = "Image_updateTip",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "1",
													texturePath = "ui/common/news_small.png",
													touchAble = "False",
													UILayoutViewModel = 
													{
														PositionX = 18,
														PositionY = 25,
													},
													width = "30",
													ZOrder = "1",
												},
											},
										},
										{
											controlID = "Label_Game_1_Button_fairy_Panel_bottom_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
											UUID = "e15be4a7_a553_4abf_8d1e_4ce6182ec686",
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
												StrokeColor = "#FF000000",
												StrokeSize = 1,
											},
											height = "25",
											ignoreSize = "True",
											name = "Label_Game_1",
											nTextAlign = "1",
											nTextHAlign = "1",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "770",
											text = " Spirit",
											touchAble = "False",
											touchScaleEnable = "False",
											UILayoutViewModel = 
											{
												PositionX = 45,
											},
											width = "54",
											ZOrder = "1",
										},
									},
								},
								{
									controlID = "Image_fairyMain_1(2)_Panel_bottom_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
									UUID = "1ae7dd5b_c3b3_4158_b128_a39e1bfb6710",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "20",
									ignoreSize = "True",
									name = "Image_fairyMain_1(2)",
									opacity = "50",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/mainLayer/new_ui_1/ui_001.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = 24,
										PositionY = 48,
									},
									width = "2",
									ZOrder = "1",
								},
								{
									controlID = "Button_bag_Panel_bottom_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
									UUID = "472ea6f4_ff34_42cc_9855_1c05f9b992bf",
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
										nXpos = 10,
										nYpos = 6,
										nHitWidth = 80,
										nHitHeight = 50
									},
									ignoreSize = "True",
									name = "Button_bag",
									normal = "ui/mainLayer/new_ui_1/btn_bag.png",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "True",
									UILayoutViewModel = 
									{
										PositionX = 35,
										PositionY = 47,
									},
									UItype = "Button",
									width = "60",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "Label_Game_1-Copy1_Button_bag_Panel_bottom_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
											UUID = "af4e44ae_f41a_4dd9_aa9e_d7d64919be51",
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
												StrokeColor = "#FF000000",
												StrokeSize = 1,
											},
											height = "25",
											ignoreSize = "True",
											name = "Label_Game_1-Copy1",
											nTextAlign = "1",
											nTextHAlign = "1",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "770",
											text = "Bag",
											touchAble = "False",
											touchScaleEnable = "False",
											UILayoutViewModel = 
											{
												PositionX = 39,
											},
											width = "34",
											ZOrder = "1",
										},
									},
								},
								{
									controlID = "Image_fairyMain_1(3)_Panel_bottom_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
									UUID = "452af667_7eac_4ac3_b88b_f6893e8fa647",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "20",
									ignoreSize = "True",
									name = "Image_fairyMain_1(3)",
									opacity = "50",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/mainLayer/new_ui_1/ui_001.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = 130,
										PositionY = 46,
									},
									width = "2",
									ZOrder = "1",
								},
								{
									controlID = "Button_shetuan_Panel_bottom_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
									UUID = "f812733a_4f64_42a9_934b_a663e8dd962b",
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
									name = "Button_shetuan",
									normal = "ui/mainLayer/new_ui_1/btn_league.png",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "True",
									UILayoutViewModel = 
									{
										PositionX = 158,
										PositionY = 44,
									},
									UItype = "Button",
									visible = "False",
									width = "60",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "Image_Game_3_Button_shetuan_Panel_bottom_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
											UUID = "607a09ea_9996_4cdf_913c_6a39fb23385f",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											classname = "MEImage",
											dstBlendFunc = "771",
											height = "60",
											ignoreSize = "True",
											name = "Image_Game_3",
											scaleX = "0.44",
											scaleY = "0.44",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											texturePath = "ui/mainLayer/new_ui_1/btn_leaguenew.png",
											touchAble = "False",
											UILayoutViewModel = 
											{
												
											},
											width = "60",
											ZOrder = "1",
										},
										{
											controlID = "Label_Game_1-Copy2_Button_shetuan_Panel_bottom_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
											UUID = "3af076a2_fbcd_4a1e_b558_82a7cd6551e7",
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
											name = "Label_Game_1-Copy2",
											nTextAlign = "1",
											nTextHAlign = "1",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "770",
											text = "Club",
											touchAble = "False",
											touchScaleEnable = "False",
											UILayoutViewModel = 
											{
												PositionX = 39,
												PositionY = 1,
											},
											width = "40",
											ZOrder = "1",
										},
									},
								},
								{
									controlID = "Button_zhaohuan_Panel_bottom_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
									UUID = "cf842cd3_0421_469a_8f36_90aeefab7284",
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
										nXpos = 10,
										nYpos = 6,
										nHitWidth = 80,
										nHitHeight = 50
									},
									ignoreSize = "True",
									name = "Button_zhaohuan",
									normal = "ui/mainLayer/new_ui_1/btn_summon.png",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "True",
									UILayoutViewModel = 
									{
										PositionX = 231,
										PositionY = 47,
									},
									UItype = "Button",
									width = "60",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "Image_summon_tip_Button_zhaohuan_Panel_bottom_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
											UUID = "0e4c21ad_1b7d_4aad_8072_a5f55048c3f8",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											classname = "MEImage",
											dstBlendFunc = "771",
											height = "60",
											ignoreSize = "True",
											name = "Image_summon_tip",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											texturePath = "ui/mainLayer/new_ui_1/btn_summonnew.png",
											touchAble = "False",
											UILayoutViewModel = 
											{
												
											},
											width = "60",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "Image_updateTip_Image_summon_tip_Button_zhaohuan_Panel_bottom_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
													UUID = "09ea7c95_047f_4cf8_bbb5_bd4ff6752f18",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0.5",
													backGroundScale9Enable = "False",
													classname = "MEImage",
													dstBlendFunc = "771",
													height = "30",
													ignoreSize = "True",
													name = "Image_updateTip",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "1",
													texturePath = "ui/common/news_small.png",
													touchAble = "False",
													UILayoutViewModel = 
													{
														PositionX = 18,
														PositionY = 20,
													},
													width = "30",
													ZOrder = "1",
												},
											},
										},
										{
											controlID = "Image_upTips_Button_zhaohuan_Panel_bottom_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
											UUID = "a3b07cd9_f7b5_4b91_8c75_d4361e9a3277",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											classname = "MEImage",
											dstBlendFunc = "771",
											height = "46",
											ignoreSize = "True",
											name = "Image_upTips",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											texturePath = "ui/summon/024.png",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = -8,
												PositionY = 42,
											},
											width = "168",
											ZOrder = "1",
										},
										{
											controlID = "Label_Game_1-Copy3_Button_zhaohuan_Panel_bottom_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
											UUID = "ba4b926b_ac62_43aa_89e4_cea0528e07c4",
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
												StrokeColor = "#FF000000",
												StrokeSize = 1,
											},
											height = "25",
											ignoreSize = "True",
											name = "Label_Game_1-Copy3",
											nTextAlign = "1",
											nTextHAlign = "1",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "770",
											text = "Summon",
											touchAble = "False",
											touchScaleEnable = "False",
											UILayoutViewModel = 
											{
												PositionX = 53,
											},
											width = "75",
											ZOrder = "1",
										},
										{
											controlID = "panel_contractSummon_Button_zhaohuan_Panel_bottom_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
											UUID = "58a51765_1fff_4ed9_95c2_87b4b8e96e0a",
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
											height = "400",
											ignoreSize = "False",
											name = "panel_contractSummon",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionY = 25,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											visible = "False",
											width = "400",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "Image_MainLayer_1_panel_contractSummon_Button_zhaohuan_Panel_bottom_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
													UUID = "c18f3c17_ace5_42f7_8012_14854ba3a0bc",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0.5",
													backGroundScale9Enable = "False",
													classname = "MEImage",
													dstBlendFunc = "771",
													height = "34",
													ignoreSize = "True",
													name = "Image_MainLayer_1",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "1",
													texturePath = "ui/summon/elf_contract/033.png",
													touchAble = "False",
													UILayoutViewModel = 
													{
														PositionY = 30,
													},
													width = "122",
													ZOrder = "1",
												},
												{
													controlID = "Image_MainLayer_2_panel_contractSummon_Button_zhaohuan_Panel_bottom_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
													UUID = "de3b32c1_51ca_4479_a0c9_19d9818ac6f3",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0.5",
													backGroundScale9Enable = "False",
													classname = "MEImage",
													dstBlendFunc = "771",
													height = "48",
													ignoreSize = "True",
													name = "Image_MainLayer_2",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "1",
													texturePath = "ui/summon/elf_contract/034.png",
													touchAble = "False",
													UILayoutViewModel = 
													{
														
													},
													width = "126",
													ZOrder = "1",
												},
												{
													controlID = "label_contract_timing_panel_contractSummon_Button_zhaohuan_Panel_bottom_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
													UUID = "ff29ade4_119b_4b41_845f_b25d4e02473c",
													anchorPoint = "False",
													anchorPointX = "0.5",
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
													name = "label_contract_timing",
													nTextAlign = "1",
													nTextHAlign = "1",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "770",
													text = "12:16:30",
													touchAble = "False",
													touchScaleEnable = "False",
													UILayoutViewModel = 
													{
														PositionY = 2,
													},
													width = "76",
													ZOrder = "1",
												},
											},
										},
									},
								},
								{
									controlID = "Button_explore_Panel_bottom_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
									UUID = "b938d316_1d51_48f4_9341_85c2c4b07e2a",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEButton",
									ClickHighLightEnabled = "True",
									dstBlendFunc = "771",
									flipX = "False",
									flipY = "False",
									height = "10",
									HitType = 
									{
										nHitType = 1,
										nXpos = -38,
										nYpos = -25,
										nHitWidth = 80,
										nHitHeight = 80
									},
									ignoreSize = "False",
									name = "Button_explore",
									normal = "ui/001.png",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "True",
									UILayoutViewModel = 
									{
										PositionX = 595,
										PositionY = 57,
									},
									UItype = "Button",
									width = "10",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "Spine_phone_Button_explore_Panel_bottom_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
											UUID = "c7d871bd_e1f4_4ca5_bfa2_526ae387cf1f",
											classname = "MESpine",
											dstBlendFunc = "771",
											name = "Spine_phone",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											spineModel = 
											{
												SpinePath = "effect/TS_texiao/TS_zhuyerukou",
												animationName = "TS_zhuyerukou_all",
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
												PositionX = -2,
												PositionY = 8,
											},
											ZOrder = "1",
										},
									},
								},
								{
									controlID = "Button_phone_Panel_bottom_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
									UUID = "636998c0_59f2_4614_823a_e68b784aadaf",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEButton",
									ClickHighLightEnabled = "True",
									dstBlendFunc = "771",
									flipX = "False",
									flipY = "False",
									height = "80",
									ignoreSize = "True",
									name = "Button_phone",
									normal = "ui/mainLayer/new_ui_1/btn_phone.png",
									rotation = "16",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "True",
									UILayoutViewModel = 
									{
										PositionX = 579,
										PositionY = 57,
									},
									UItype = "Button",
									visible = "False",
									width = "60",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "Spine_phone_Button_phone_Panel_bottom_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
											UUID = "3ecdcaa3_c7a1_4114_88eb_0950cd41fbf9",
											classname = "MESpine",
											dstBlendFunc = "771",
											name = "Spine_phone",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											spineModel = 
											{
												SpinePath = "effect/action_main_ui1/action_main_ui1",
												animationName = "animation2",
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
												PositionX = -2,
												PositionY = -62,
											},
											visible = "False",
											ZOrder = "1",
										},
										{
											controlID = "Image_newtip_Button_phone_Panel_bottom_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
											UUID = "9073f70b_4783_45d2_9734_c2ab8a6ef215",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											classname = "MEImage",
											dstBlendFunc = "771",
											height = "64",
											ignoreSize = "True",
											name = "Image_newtip",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											texturePath = "ui/mainLayer/new_ui_1/btn_phonenew.png",
											touchAble = "False",
											UILayoutViewModel = 
											{
												
											},
											width = "68",
											ZOrder = "1",
										},
										{
											controlID = "Label_Game_1-Copy4_Button_phone_Panel_bottom_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
											UUID = "6b60c094_3861_483c_a4f6_d4e4157863b4",
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
											name = "Label_Game_1-Copy4",
											nTextAlign = "1",
											nTextHAlign = "1",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "770",
											text = "City",
											touchAble = "False",
											touchScaleEnable = "False",
											UILayoutViewModel = 
											{
												PositionX = 25,
											},
											visible = "False",
											width = "44",
											ZOrder = "1",
										},
									},
								},
								{
									controlID = "Button_shop_Panel_bottom_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
									UUID = "9d01844b_d6c5_41ab_aaee_066b6aaefc19",
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
										nXpos = 10,
										nYpos = 6,
										nHitWidth = 80,
										nHitHeight = 50
									},
									ignoreSize = "True",
									name = "Button_shop",
									normal = "ui/mainLayer/new_ui_1/btn_store.png",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "True",
									UILayoutViewModel = 
									{
										PositionX = 351,
										PositionY = 48,
									},
									UItype = "Button",
									width = "60",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "TextArea_Game_2_Button_shop_Panel_bottom_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
											UUID = "8fd33681_81b2_421b_a133_2125de5a86d9",
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
												IsStroke = true,
												StrokeColor = "#FF000000",
												StrokeSize = 1,
											},
											hAlignment = "1",
											height = "25",
											ignoreSize = "True",
											name = "TextArea_Game_2",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "770",
											text = "Store",
											touchAble = "False",
											touchScaleEnable = "False",
											UILayoutViewModel = 
											{
												PositionX = 43,
												PositionY = -3,
											},
											vAlignment = "1",
											width = "47",
											ZOrder = "1",
										},
									},
								},
								{
									controlID = "Image_split_line_Panel_bottom_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
									UUID = "6f5d2e2e_ac2e_42cc_afc1_c231c23d5132",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "20",
									ignoreSize = "True",
									name = "Image_split_line",
									opacity = "50",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/mainLayer/new_ui_1/ui_001.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = 435,
										PositionY = 46,
									},
									width = "2",
									ZOrder = "1",
								},
								{
									controlID = "Button_recharge_Panel_bottom_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
									UUID = "420feecc_d12d_4c9a_8ebc_ebedeecaed73",
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
										nXpos = 10,
										nYpos = 6,
										nHitWidth = 80,
										nHitHeight = 50
									},
									ignoreSize = "True",
									name = "Button_recharge",
									normal = "ui/mainLayer/new_ui_1/btn_recharge.png",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "True",
									UILayoutViewModel = 
									{
										PositionX = 457,
										PositionY = 48,
									},
									UItype = "Button",
									width = "60",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "TextArea_Game_2_Button_recharge_Panel_bottom_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
											UUID = "83248fec_e1dd_43d9_8e1d_06ac4e5e8d99",
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
												IsStroke = true,
												StrokeColor = "#FF000000",
												StrokeSize = 1,
											},
											hAlignment = "1",
											height = "25",
											ignoreSize = "True",
											name = "TextArea_Game_2",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "770",
											text = "Top Up",
											touchAble = "False",
											touchScaleEnable = "False",
											UILayoutViewModel = 
											{
												PositionX = 48,
												PositionY = -2,
											},
											vAlignment = "1",
											width = "65",
											ZOrder = "1",
										},
										{
											controlID = "Image_MainLayer_new_Button_recharge_Panel_bottom_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
											UUID = "76807f4a_140d_48d9_bfa9_bd0a998414fc",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											classname = "MEImage",
											dstBlendFunc = "771",
											height = "41",
											ignoreSize = "True",
											name = "Image_MainLayer_new",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											texturePath = "ui/recharge/new.png",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 30,
												PositionY = 26,
											},
											width = "85",
											ZOrder = "1",
										},
									},
								},
								{
									controlID = "Button_league_Panel_bottom_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
									UUID = "afadb1e5_1912_48fa_b10c_09a811686eb4",
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
										nXpos = 10,
										nYpos = 6,
										nHitWidth = 80,
										nHitHeight = 50
									},
									ignoreSize = "True",
									name = "Button_league",
									normal = "ui/mainLayer/new_ui_1/btn_league.png",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "True",
									UILayoutViewModel = 
									{
										PositionX = 140,
										PositionY = 47,
									},
									UItype = "Button",
									width = "60",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "RedTips_Button_league_Panel_bottom_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
											UUID = "39ec9810_26b8_4d13_ae56_f357b1619179",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											classname = "MEImage",
											dstBlendFunc = "771",
											height = "60",
											ignoreSize = "True",
											name = "RedTips",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											texturePath = "ui/mainLayer/new_ui_1/btn_leaguenew.png",
											touchAble = "False",
											UILayoutViewModel = 
											{
												
											},
											visible = "False",
											width = "60",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "Image_updateTip_RedTips_Button_league_Panel_bottom_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
													UUID = "8c1debe2_e14f_43ae_8ba1_9976b1cb015d",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0.5",
													backGroundScale9Enable = "False",
													classname = "MEImage",
													dstBlendFunc = "771",
													height = "30",
													ignoreSize = "True",
													name = "Image_updateTip",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "1",
													texturePath = "ui/common/news_small.png",
													touchAble = "False",
													UILayoutViewModel = 
													{
														PositionX = 18,
														PositionY = 20,
													},
													width = "30",
													ZOrder = "1",
												},
											},
										},
										{
											controlID = "Label_league_Button_league_Panel_bottom_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
											UUID = "1e8515c8_713b_4ee2_b927_bee41cf687ca",
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
												StrokeColor = "#FF000000",
												StrokeSize = 1,
											},
											height = "25",
											ignoreSize = "True",
											name = "Label_league",
											nTextAlign = "1",
											nTextHAlign = "1",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "770",
											text = "Club",
											touchAble = "False",
											touchScaleEnable = "False",
											UILayoutViewModel = 
											{
												PositionX = 39,
											},
											width = "41",
											ZOrder = "1",
										},
									},
								},
								{
									controlID = "Image_split_line-Copy1_Panel_bottom_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
									UUID = "71bf51af_8b40_4b57_b787_2b68aeed53b7",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "20",
									ignoreSize = "True",
									name = "Image_split_line-Copy1",
									opacity = "50",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/mainLayer/new_ui_1/ui_001.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = 435,
										PositionY = 46,
									},
									width = "2",
									ZOrder = "1",
								},
								{
									controlID = "Button_ARCamera_Panel_bottom_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
									UUID = "3083237e_d8e9_4b15_be5b_c330709fd256",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEButton",
									ClickHighLightEnabled = "True",
									dstBlendFunc = "771",
									flipX = "False",
									flipY = "False",
									height = "116",
									ignoreSize = "True",
									name = "Button_ARCamera",
									normal = "ui/ar/ar_acamer_26.png",
									scaleX = "0.5",
									scaleY = "0.5",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "True",
									UILayoutViewModel = 
									{
										PositionX = 576,
										PositionY = 49,
									},
									UItype = "Button",
									width = "116",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "Image_newtip_Button_ARCamera_Panel_bottom_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
											UUID = "559d7b8c_b6a3_4495_99ca_7db29d94c826",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											classname = "MEImage",
											dstBlendFunc = "771",
											height = "64",
											ignoreSize = "True",
											name = "Image_newtip",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											texturePath = "ui/mainLayer/new_ui_1/btn_phonenew.png",
											touchAble = "False",
											UILayoutViewModel = 
											{
												
											},
											visible = "False",
											width = "68",
											ZOrder = "1",
										},
										{
											controlID = "Label_Game_1_Button_ARCamera_Panel_bottom_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
											UUID = "2307a294_1ae0_49b8_bc87_e681c389ff1c",
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
											name = "Label_Game_1",
											nTextAlign = "1",
											nTextHAlign = "1",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "770",
											text = "City",
											touchAble = "False",
											touchScaleEnable = "False",
											UILayoutViewModel = 
											{
												PositionX = 25,
											},
											visible = "False",
											width = "44",
											ZOrder = "1",
										},
									},
								},
							},
						},
						{
							controlID = "Panel_chat_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
							UUID = "427a8967_279e_4b83_917e_fa900ed2c825",
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
							height = "80",
							ignoreSize = "False",
							name = "Panel_chat",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							touchAble = "False",
							UILayoutViewModel = 
							{
								PositionX = 1,
								PositionY = 21,
								TopPosition = 530,
								relativeToName = "Panel",
							},
							uipanelviewmodel = 
							{
								Layout="Absolute",
								nType = "0"
							},
							width = "455",
							ZOrder = "5",
							components = 
							{
								
								{
									controlID = "Image_chat_bg_Panel_chat_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
									UUID = "188a437d_9810_40e1_8ca7_aaf68a33c13c",
									anchorPoint = "False",
									anchorPointX = "0",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "38",
									ignoreSize = "True",
									name = "Image_chat_bg",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/mainLayer/new_ui_1/chat_bg.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = 19,
										PositionY = -2,
									},
									width = "268",
									ZOrder = "1",
								},
								{
									controlID = "Panel_chat_di_Panel_chat_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
									UUID = "5e44f20f_dc2f_4247_b026_5aa652f9716f",
									anchorPoint = "False",
									anchorPointX = "0",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									bgColorOpacity = "50",
									bIsOpenClipping = "True",
									classname = "MEPanel",
									colorType = "0;SingleColor:#FFE6E6E6;GraduallyChangingColorStart:#FFFFFFFF;GraduallyChangingColorEnd:#FFFFFFFF;vectorX:0;vectorY:0",
									DesignHeight = "640",
									DesignType = "0",
									DesignWidth = "960",
									dstBlendFunc = "771",
									height = "52",
									ignoreSize = "False",
									name = "Panel_chat_di",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "True",
									UILayoutViewModel = 
									{
										PositionX = 61,
										PositionY = 3,
									},
									uipanelviewmodel = 
									{
										Layout="Absolute",
										nType = "0"
									},
									width = "288",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "Label_message_Panel_chat_di_Panel_chat_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
											UUID = "070c4447_680e_4cdd_a2fd_cf6908c1c4bc",
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
											height = "0",
											ignoreSize = "True",
											name = "Label_message",
											nTextAlign = "1",
											nTextHAlign = "0",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "770",
											touchAble = "False",
											touchScaleEnable = "False",
											UILayoutViewModel = 
											{
												PositionY = -2,
											},
											width = "0",
											ZOrder = "1",
										},
									},
								},
								{
									controlID = "Image_chat_Panel_chat_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
									UUID = "8258757f_db95_4dfe_a6b0_ee16db8c82d2",
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
									name = "Image_chat",
									normal = "ui/mainLayer/new_ui_1/btn_chat.png",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "True",
									UILayoutViewModel = 
									{
										PositionX = 39,
										PositionY = 25,
									},
									UItype = "Button",
									width = "60",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "Image_redPack_tips_Image_chat_Panel_chat_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
											UUID = "699e2b3a_1c26_4251_8842_f58d61994269",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "True;capInsetsX:0;capInsetsY:0;capInsetsWidth:0;capInsetsHeight:0",
											classname = "MEImage",
											dstBlendFunc = "771",
											height = "85",
											ignoreSize = "False",
											name = "Image_redPack_tips",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											texturePath = "ui/mainLayer/new_ui/redpack_tips_bg.png",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 58,
												PositionY = 60,
											},
											width = "109",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "Image_red_icon_Image_redPack_tips_Image_chat_Panel_chat_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
													UUID = "0728ff5a_f214_46a8_a325_ab12371b90be",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0.5",
													backGroundScale9Enable = "False",
													classname = "MEImage",
													dstBlendFunc = "771",
													height = "45",
													ignoreSize = "True",
													name = "Image_red_icon",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "1",
													texturePath = "ui/league/ui_10.png",
													touchAble = "False",
													UILayoutViewModel = 
													{
														PositionY = 11,
													},
													width = "35",
													ZOrder = "1",
												},
												{
													controlID = "Label_redpack_get_Image_redPack_tips_Image_chat_Panel_chat_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
													UUID = "45e25162_8b8a_47ca_adf0_9390f00b0c02",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0.5",
													classname = "MELabel",
													compPath = "luacomponents.common.MEIconLabel",
													dstBlendFunc = "771",
													FontColor = "#FF3E4474",
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
													name = "Label_redpack_get",
													nTextAlign = "1",
													nTextHAlign = "1",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "770",
													text = "Claimable",
													touchAble = "False",
													touchScaleEnable = "False",
													UILayoutViewModel = 
													{
														PositionY = -23,
													},
													width = "80",
													ZOrder = "1",
												},
											},
										},
										{
											controlID = "Image_redPoint_Image_chat_Panel_chat_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
											UUID = "67c457d6_930d_471f_8bea_4ae49299f102",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											classname = "MEImage",
											dstBlendFunc = "771",
											height = "30",
											ignoreSize = "True",
											name = "Image_redPoint",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											texturePath = "ui/common/news_small.png",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 23,
												PositionY = 21,
											},
											width = "30",
											ZOrder = "1",
										},
										{
											controlID = "Image_red_packet_Image_chat_Panel_chat_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
											UUID = "5aeb5bae_5272_4661_b4f1_646ebdf71e8c",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											classname = "MEImage",
											dstBlendFunc = "771",
											height = "45",
											ignoreSize = "True",
											name = "Image_red_packet",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											texturePath = "ui/league/ui_10.png",
											touchAble = "False",
											UILayoutViewModel = 
											{
												
											},
											width = "35",
											ZOrder = "1",
										},
										{
											controlID = "Image_aiAdvice_tips_Image_chat_Panel_chat_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
											UUID = "0eae0377_21db_41ee_9167_c75746cf3d74",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											classname = "MEImage",
											dstBlendFunc = "771",
											height = "85",
											ignoreSize = "True",
											name = "Image_aiAdvice_tips",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											texturePath = "ui/mainLayer/new_ui/redpack_tips_bg.png",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 58,
												PositionY = 60,
											},
											width = "89",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "Image_aiIcon_Image_aiAdvice_tips_Image_chat_Panel_chat_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
													UUID = "a7b8807d_56c1_4f81_9b99_3b34c07bda09",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0.5",
													backGroundScale9Enable = "False",
													classname = "MEImage",
													dstBlendFunc = "771",
													height = "80",
													ignoreSize = "True",
													name = "Image_aiIcon",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "1",
													texturePath = "ui/mainLayer/a004.png",
													touchAble = "False",
													UILayoutViewModel = 
													{
														PositionY = -4,
													},
													width = "80",
													ZOrder = "1",
												},
												{
													controlID = "Image_aiTimeBar_Image_aiAdvice_tips_Image_chat_Panel_chat_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
													UUID = "87c1be3e_dae7_4f11_8593_761b97d408cf",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0.5",
													backGroundScale9Enable = "False",
													classname = "MEImage",
													dstBlendFunc = "771",
													height = "4",
													ignoreSize = "True",
													name = "Image_aiTimeBar",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "1",
													texturePath = "ui/mainLayer/a002.png",
													touchAble = "False",
													UILayoutViewModel = 
													{
														PositionY = -28,
													},
													width = "72",
													ZOrder = "1",
													components = 
													{
														
														{
															controlID = "LoadingBar_aiTime_Image_aiTimeBar_Image_aiAdvice_tips_Image_chat_Panel_chat_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
															UUID = "ab1ec72d_974d_484c_adf5_d2086093d409",
															anchorPoint = "False",
															anchorPointX = "0.5",
															anchorPointY = "0.5",
															backGroundScale9Enable = "False",
															classname = "MELoadingBar",
															direction = "0",
															dstBlendFunc = "771",
															height = "4",
															ignoreSize = "True",
															name = "LoadingBar_aiTime",
															percent = "100",
															sizepercentx = "0",
															sizepercenty = "0",
															sizeType = "0",
															srcBlendFunc = "1",
															texture = "ui/mainLayer/a001.png",
															touchAble = "False",
															UILayoutViewModel = 
															{
																
															},
															width = "72",
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
						{
							controlID = "Image_camera2_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
							UUID = "99300316_92e8_4e3e_a837_4fe4a96e2799",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							backGroundScale9Enable = "False",
							classname = "MEImage",
							dstBlendFunc = "771",
							height = "36",
							ignoreSize = "True",
							name = "Image_camera2",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							texturePath = "ui/003.png",
							touchAble = "False",
							UILayoutViewModel = 
							{
								PositionX = 1025,
								PositionY = 615,
								LeftPositon = 1007,
								TopPosition = 11,
								relativeToName = "Panel",
							},
							visible = "False",
							width = "46",
							ZOrder = "999",
							components = 
							{
								
								{
									controlID = "Button_camera2_Image_camera2_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
									UUID = "846d1179_e021_4114_ae0d_5fc31a94ee27",
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
									name = "Button_camera2",
									normal = "ui/mainui/camera_logo.png",
									pressed = "ui/mainui/camera_logo.png",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "True",
									UILayoutViewModel = 
									{
										
									},
									UItype = "Button",
									width = "66",
									ZOrder = "1",
								},
							},
						},
						{
							controlID = "Panel_player_info_touch_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
							UUID = "45daba43_1fc3_4f96_b539_defdb8b2275b",
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
							height = "60",
							ignoreSize = "False",
							name = "Panel_player_info_touch",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							touchAble = "True",
							UILayoutViewModel = 
							{
								PositionX = 1,
								PositionY = 574,
								TopPosition = 2,
								relativeToName = "Panel",
							},
							uipanelviewmodel = 
							{
								Layout="Absolute",
								nType = "0"
							},
							width = "260",
							ZOrder = "999",
						},
						{
							controlID = "top_part2_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
							UUID = "03405ea7_31ff_49ec_baa4_be0db80cd485",
							anchorPoint = "False",
							anchorPointX = "0",
							anchorPointY = "1",
							backGroundScale9Enable = "False",
							bgColorOpacity = "255",
							bIsOpenClipping = "False",
							classname = "MEPanel",
							colorType = "0;SingleColor:#FFFF0000;GraduallyChangingColorStart:#FFFFFFFF;GraduallyChangingColorEnd:#FFFFFFFF;vectorX:0;vectorY:0",
							DesignHeight = "640",
							DesignType = "0",
							DesignWidth = "960",
							dstBlendFunc = "771",
							height = "80",
							ignoreSize = "False",
							name = "top_part2",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							touchAble = "False",
							UILayoutViewModel = 
							{
								PositionX = -57,
								PositionY = 640,
								IsPercent = true,
								PercentX = -5.09,
								PercentY = 100,
								relativeToName = "Panel",
							},
							uipanelviewmodel = 
							{
								Layout="Absolute",
								nType = "0"
							},
							width = "1136",
							ZOrder = "999",
							components = 
							{
								
								{
									controlID = "Image_tili_bg_top_part2_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
									UUID = "6fd17c13_68dc_4f86_a65c_873c8a9a41cb",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "36",
									ignoreSize = "False",
									name = "Image_tili_bg",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/mainLayer/new_ui_1/res_bg.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = 634,
										PositionY = -30,
									},
									width = "110",
									ZOrder = "1",
								},
								{
									controlID = "Image_tili_top_part2_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
									UUID = "62160d11_4be3_4b98_a18c_6329c715e969",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "100",
									ignoreSize = "True",
									name = "Image_tili",
									scaleX = "0.5",
									scaleY = "0.5",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "icon/system/001.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = 580,
										PositionY = -30,
									},
									width = "100",
									ZOrder = "1",
								},
								{
									controlID = "Label_tili_count_top_part2_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
									UUID = "79b7fe51_d820_4c66_811f_46f0f3915253",
									anchorPoint = "False",
									anchorPointX = "1",
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
										IsStroke = true,
										StrokeColor = "#FF20354A",
										StrokeSize = 1,
									},
									height = "23",
									ignoreSize = "False",
									name = "Label_tili_count",
									nTextAlign = "1",
									nTextHAlign = "2",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "350 120",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionX = 664,
										PositionY = -30,
									},
									width = "80",
									ZOrder = "1",
								},
								{
									controlID = "Button_add_tili_top_part2_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
									UUID = "351ec880_9c4c_4e59_9499_468e1463cad6",
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
										nHitType = 2,
										nRadius = 50,
									},
									ignoreSize = "True",
									name = "Button_add_tili",
									normal = "ui/mainLayer/new_ui_1/jiahao.png",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "True",
									UILayoutViewModel = 
									{
										PositionX = 683,
										PositionY = -29,
									},
									UItype = "Button",
									width = "60",
									ZOrder = "1",
								},
								{
									controlID = "Image_coin_bg_top_part2_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
									UUID = "b02600b9_d719_48af_b262_cf413189a801",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "36",
									ignoreSize = "False",
									name = "Image_coin_bg",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/mainLayer/new_ui_1/res_bg.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = 784,
										PositionY = -31,
									},
									width = "110",
									ZOrder = "1",
								},
								{
									controlID = "Image_coin_top_part2_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
									UUID = "2a140349_a63d_4681_ac19_ac12243f9548",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "100",
									ignoreSize = "True",
									name = "Image_coin",
									scaleX = "0.5",
									scaleY = "0.5",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "icon/system/003.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = 730,
										PositionY = -30,
									},
									width = "100",
									ZOrder = "1",
								},
								{
									controlID = "Label_coin_count_top_part2_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
									UUID = "85faaa63_c6c4_4c56_83dd_c3d12f0363c2",
									anchorPoint = "False",
									anchorPointX = "1",
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
										IsStroke = true,
										StrokeColor = "#FF30354A",
										StrokeSize = 1,
									},
									height = "23",
									ignoreSize = "False",
									name = "Label_coin_count",
									nTextAlign = "1",
									nTextHAlign = "2",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "999999",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionX = 810,
										PositionY = -30,
									},
									width = "80",
									ZOrder = "1",
								},
								{
									controlID = "Button_add_coin_top_part2_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
									UUID = "b2114010_4622_46ef_966c_35668ba5a5a8",
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
										nHitType = 2,
										nRadius = 50,
									},
									ignoreSize = "True",
									name = "Button_add_coin",
									normal = "ui/mainLayer/new_ui_1/jiahao.png",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "True",
									UILayoutViewModel = 
									{
										PositionX = 827,
										PositionY = -28,
									},
									UItype = "Button",
									width = "60",
									ZOrder = "1",
								},
								{
									controlID = "Image_zuan_bg_top_part2_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
									UUID = "17087955_a9ed_4495_9abd_80afbf206925",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "36",
									ignoreSize = "False",
									name = "Image_zuan_bg",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/mainLayer/new_ui_1/res_bg.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = 924,
										PositionY = -30,
									},
									width = "110",
									ZOrder = "1",
								},
								{
									controlID = "Image_zuan_top_part2_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
									UUID = "183a069c_6931_4c7a_a2ed_202d6f0692d0",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "100",
									ignoreSize = "True",
									name = "Image_zuan",
									scaleX = "0.5",
									scaleY = "0.5",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "icon/system/005.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = 875,
										PositionY = -33,
									},
									width = "100",
									ZOrder = "1",
								},
								{
									controlID = "Label_zuan_count_top_part2_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
									UUID = "9ed8d75d_9b86_48ab_9ffa_bd04d0c56378",
									anchorPoint = "False",
									anchorPointX = "1",
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
										IsStroke = true,
										StrokeColor = "#FF30354A",
										StrokeSize = 1,
									},
									height = "23",
									ignoreSize = "False",
									name = "Label_zuan_count",
									nTextAlign = "1",
									nTextHAlign = "2",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "999999",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionX = 954,
										PositionY = -29,
									},
									width = "80",
									ZOrder = "1",
								},
								{
									controlID = "Button_add_zuan_top_part2_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
									UUID = "d8e4c266_b0d6_4724_ac6a_0c33e1f9764e",
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
										nXpos = -43,
										nYpos = -13,
										nHitWidth = 90,
										nHitHeight = 65
									},
									ignoreSize = "True",
									name = "Button_add_zuan",
									normal = "ui/mainLayer/new_ui_1/jiahao.png",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "True",
									UILayoutViewModel = 
									{
										PositionX = 969,
										PositionY = -29,
									},
									UItype = "Button",
									width = "60",
									ZOrder = "1",
								},
							},
						},
						{
							controlID = "Panel_left_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
							UUID = "054abb3f_ea19_4334_8b78_6ca4948511ce",
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
							height = "480",
							ignoreSize = "False",
							name = "Panel_left",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							touchAble = "False",
							UILayoutViewModel = 
							{
								PositionY = 100,
							},
							uipanelviewmodel = 
							{
								Layout="Absolute",
								nType = "0"
							},
							width = "100",
							ZOrder = "5",
							components = 
							{
								
								{
									controlID = "Button_elf_contract_Panel_left_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
									UUID = "64ed65b0_5f57_429d_890f_51e8b50fb2e6",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEButton",
									ClickHighLightEnabled = "True",
									dstBlendFunc = "771",
									flipX = "False",
									flipY = "False",
									height = "90",
									ignoreSize = "True",
									name = "Button_elf_contract",
									normal = "ui/mainLayer/new_ui/a1.png",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "True",
									UILayoutViewModel = 
									{
										PositionX = 345,
										PositionY = 500,
									},
									UItype = "Button",
									width = "90",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "Spine_MainLayer_1_Button_elf_contract_Panel_left_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
											UUID = "da82a911_da18_4eff_b800_d02c33e51e46",
											classname = "MESpine",
											dstBlendFunc = "771",
											name = "Spine_MainLayer_1",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											spineModel = 
											{
												SpinePath = "effect/effect_fanzhezijiemian/effect_qiyue",
												animationName = "effect_qiyue_down",
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
												
											},
											ZOrder = "-100",
										},
										{
											controlID = "image_new_Button_elf_contract_Panel_left_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
											UUID = "cabd9bcd_8189_4f6f_b619_907676159dc2",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											classname = "MEImage",
											dstBlendFunc = "771",
											height = "41",
											ignoreSize = "True",
											name = "image_new",
											scaleX = "0.7",
											scaleY = "0.7",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											texturePath = "ui/recharge/new.png",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 22,
												PositionY = 24,
											},
											width = "85",
											ZOrder = "1",
										},
										{
											controlID = "Image_redTips_Button_elf_contract_Panel_left_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
											UUID = "c6f5ee38_1021_46c9_ac5b_0830f19af7d5",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											classname = "MEImage",
											dstBlendFunc = "771",
											height = "30",
											ignoreSize = "True",
											name = "Image_redTips",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											texturePath = "ui/common/news_small.png",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 21,
												PositionY = 23,
											},
											width = "30",
											ZOrder = "1",
										},
										{
											controlID = "Spine_MainLayer_2_Button_elf_contract_Panel_left_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
											UUID = "966c7143_f30c_4535_b530_d0f3f13b6164",
											classname = "MESpine",
											dstBlendFunc = "771",
											name = "Spine_MainLayer_2",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											spineModel = 
											{
												SpinePath = "effect/effect_fanzhezijiemian/effect_qiyue",
												animationName = "effect_qiyue_up",
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
												
											},
											visible = "False",
											ZOrder = "1",
										},
										{
											controlID = "Label_left_time_Button_elf_contract_Panel_left_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
											UUID = "b7eb4b7b_1db3_4061_bed9_571f62077d9d",
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
												StrokeColor = "#FF000000",
												StrokeSize = 1,
											},
											height = "25",
											ignoreSize = "True",
											name = "Label_left_time",
											nTextAlign = "1",
											nTextHAlign = "1",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "770",
											text = "20h 58m",
											touchAble = "False",
											touchScaleEnable = "False",
											UILayoutViewModel = 
											{
												PositionY = -48,
											},
											visible = "False",
											width = "79",
											ZOrder = "1",
										},
									},
								},
								{
									controlID = "Panel_btList_Panel_left_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
									UUID = "6cd3fc2a_239f_436a_b5e6_3a11c7a239e4",
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
									height = "480",
									ignoreSize = "False",
									name = "Panel_btList",
									sizepercentx = "100",
									sizepercenty = "100",
									sizeType = "1",
									srcBlendFunc = "1",
									touchAble = "False",
									UILayoutViewModel = 
									{
										
									},
									uipanelviewmodel = 
									{
										Layout="Absolute",
										nType = "0"
									},
									width = "100",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "Button_notice_Panel_btList_Panel_left_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
											UUID = "e1f54370_91e7_4d8d_ac9b_4659be3d833b",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											classname = "MEButton",
											ClickHighLightEnabled = "True",
											dstBlendFunc = "771",
											flipX = "False",
											flipY = "False",
											height = "80",
											ignoreSize = "True",
											name = "Button_notice",
											normal = "ui/mainLayer/new_ui_1/btn_notice.png",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "True",
											UILayoutViewModel = 
											{
												PositionX = 42,
												PositionY = 424,
												LeftPositon = 26,
												TopPosition = 87,
												relativeToName = "Panel",
											},
											UItype = "Button",
											width = "80",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "Label_title_Button_notice_Panel_btList_Panel_left_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
													UUID = "71cfb03b_df7b_4795_9803_bc372b773246",
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
														StrokeColor = "#FF000000",
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
													text = "Announcement",
													touchAble = "False",
													touchScaleEnable = "False",
													UILayoutViewModel = 
													{
														PositionY = -37,
													},
													visible = "False",
													width = "122",
													ZOrder = "1",
												},
												{
													controlID = "Image_notice_Button_notice_Panel_btList_Panel_left_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
													UUID = "1436be1b_a4ec_4c4b_9436_79d9cc1bbca7",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0.5",
													backGroundScale9Enable = "False",
													classname = "MEImage",
													dstBlendFunc = "771",
													height = "30",
													ignoreSize = "True",
													name = "Image_notice",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "1",
													texturePath = "ui/mainui/notice_logo.png",
													touchAble = "False",
													UILayoutViewModel = 
													{
														PositionY = 10,
													},
													visible = "False",
													width = "30",
													ZOrder = "1",
												},
												{
													controlID = "Image_noticeTip_Button_notice_Panel_btList_Panel_left_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
													UUID = "90ef86d4_462b_4dcb_bf0d_95694837e538",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0.5",
													backGroundScale9Enable = "False",
													classname = "MEImage",
													dstBlendFunc = "771",
													height = "80",
													ignoreSize = "True",
													name = "Image_noticeTip",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "1",
													texturePath = "ui/mainLayer/new_ui_1/btn_noticenew.png",
													touchAble = "False",
													UILayoutViewModel = 
													{
														
													},
													width = "80",
													ZOrder = "1",
													components = 
													{
														
														{
															controlID = "Image_updateTip_Image_noticeTip_Button_notice_Panel_btList_Panel_left_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
															UUID = "0126ed8e_07e2_412b_948a_979498aba46e",
															anchorPoint = "False",
															anchorPointX = "0.5",
															anchorPointY = "0.5",
															backGroundScale9Enable = "False",
															classname = "MEImage",
															dstBlendFunc = "771",
															height = "30",
															ignoreSize = "True",
															name = "Image_updateTip",
															sizepercentx = "0",
															sizepercenty = "0",
															sizeType = "0",
															srcBlendFunc = "1",
															texturePath = "ui/common/news_small.png",
															touchAble = "False",
															UILayoutViewModel = 
															{
																PositionX = 18,
																PositionY = 11,
															},
															width = "30",
															ZOrder = "1",
														},
													},
												},
											},
										},
										{
											controlID = "Button_welfare_Panel_btList_Panel_left_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
											UUID = "98c3e9fc_9f21_42d4_a0d3_adacaaa02d09",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											classname = "MEButton",
											ClickHighLightEnabled = "True",
											dstBlendFunc = "771",
											flipX = "False",
											flipY = "False",
											height = "80",
											ignoreSize = "True",
											name = "Button_welfare",
											normal = "ui/mainLayer/new_ui_1/btn_welfare.png",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "True",
											UILayoutViewModel = 
											{
												PositionX = 59,
												PositionY = 361,
												LeftPositon = 26,
												TopPosition = 87,
												relativeToName = "Panel",
											},
											UItype = "Button",
											width = "80",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "Label_welfare_Button_welfare_Panel_btList_Panel_left_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
													UUID = "4066710b_069d_4684_a4eb_1bb8772d0abc",
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
														StrokeColor = "#FF000000",
														StrokeSize = 1,
													},
													height = "25",
													ignoreSize = "True",
													name = "Label_welfare",
													nTextAlign = "1",
													nTextHAlign = "1",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "770",
													text = "Benefits",
													touchAble = "False",
													touchScaleEnable = "False",
													UILayoutViewModel = 
													{
														PositionY = -37,
													},
													visible = "False",
													width = "66",
													ZOrder = "1",
												},
												{
													controlID = "Image_welfare_Button_welfare_Panel_btList_Panel_left_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
													UUID = "024208de_5988_412d_9a81_c3b4e36e80fb",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0.5",
													backGroundScale9Enable = "False",
													classname = "MEImage",
													dstBlendFunc = "771",
													height = "30",
													ignoreSize = "True",
													name = "Image_welfare",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "1",
													texturePath = "ui/mainui/gift_logo.png",
													touchAble = "False",
													UILayoutViewModel = 
													{
														PositionY = 10,
													},
													visible = "False",
													width = "30",
													ZOrder = "1",
												},
												{
													controlID = "Image_welfareTip_Button_welfare_Panel_btList_Panel_left_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
													UUID = "6ddd9eb5_cc02_4b0f_8bd4_743b9a77f0da",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0.5",
													backGroundScale9Enable = "False",
													classname = "MEImage",
													dstBlendFunc = "771",
													height = "80",
													ignoreSize = "True",
													name = "Image_welfareTip",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "1",
													texturePath = "ui/mainLayer/new_ui_1/btn_welfarenew.png",
													touchAble = "False",
													UILayoutViewModel = 
													{
														
													},
													width = "80",
													ZOrder = "1",
													components = 
													{
														
														{
															controlID = "Image_updateTip_Image_welfareTip_Button_welfare_Panel_btList_Panel_left_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
															UUID = "41c6b110_2d68_4926_a403_f453bab2796f",
															anchorPoint = "False",
															anchorPointX = "0.5",
															anchorPointY = "0.5",
															backGroundScale9Enable = "False",
															classname = "MEImage",
															dstBlendFunc = "771",
															height = "30",
															ignoreSize = "True",
															name = "Image_updateTip",
															sizepercentx = "0",
															sizepercenty = "0",
															sizeType = "0",
															srcBlendFunc = "1",
															texturePath = "ui/common/news_small.png",
															touchAble = "False",
															UILayoutViewModel = 
															{
																PositionX = 18,
																PositionY = 11,
															},
															width = "30",
															ZOrder = "1",
														},
													},
												},
											},
										},
										{
											controlID = "Button_activity_Panel_btList_Panel_left_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
											UUID = "cad99359_17cb_4bac_997d_ed7bcdfeb3f3",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											classname = "MEButton",
											ClickHighLightEnabled = "True",
											dstBlendFunc = "771",
											flipX = "False",
											flipY = "False",
											height = "80",
											ignoreSize = "True",
											name = "Button_activity",
											normal = "ui/mainLayer/new_ui_1/btn_ativity.png",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "True",
											UILayoutViewModel = 
											{
												PositionX = 42,
												PositionY = 289,
												LeftPositon = 26,
												TopPosition = 87,
												relativeToName = "Panel",
											},
											UItype = "Button",
											width = "80",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "Image_activity_Button_activity_Panel_btList_Panel_left_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
													UUID = "59354a8a_aecf_460f_aed7_7b1b26046e8c",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0.5",
													backGroundScale9Enable = "False",
													classname = "MEImage",
													dstBlendFunc = "771",
													height = "50",
													ignoreSize = "True",
													name = "Image_activity",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "1",
													texturePath = "ui/mainLayer/new_ui/btn_ativity.png",
													touchAble = "False",
													UILayoutViewModel = 
													{
														PositionY = 10,
													},
													visible = "False",
													width = "50",
													ZOrder = "1",
												},
												{
													controlID = "Image_activityTip_Button_activity_Panel_btList_Panel_left_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
													UUID = "565fc2f8_296f_47fd_887c_6cec6f094e66",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0.5",
													backGroundScale9Enable = "False",
													classname = "MEImage",
													dstBlendFunc = "771",
													height = "80",
													ignoreSize = "True",
													name = "Image_activityTip",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "1",
													texturePath = "ui/mainLayer/new_ui_1/btn_ativitynew.png",
													touchAble = "False",
													UILayoutViewModel = 
													{
														
													},
													width = "80",
													ZOrder = "1",
													components = 
													{
														
														{
															controlID = "Image_updateTip_Image_activityTip_Button_activity_Panel_btList_Panel_left_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
															UUID = "aed75f02_d275_4862_8f18_0a681b7915ed",
															anchorPoint = "False",
															anchorPointX = "0.5",
															anchorPointY = "0.5",
															backGroundScale9Enable = "False",
															classname = "MEImage",
															dstBlendFunc = "771",
															height = "30",
															ignoreSize = "True",
															name = "Image_updateTip",
															sizepercentx = "0",
															sizepercenty = "0",
															sizeType = "0",
															srcBlendFunc = "1",
															texturePath = "ui/common/news_small.png",
															touchAble = "False",
															UILayoutViewModel = 
															{
																PositionX = 18,
																PositionY = 11,
															},
															width = "30",
															ZOrder = "1",
														},
													},
												},
												{
													controlID = "Label_activity_Button_activity_Panel_btList_Panel_left_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
													UUID = "8eebd96d_1350_4996_beb1_14104096b470",
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
														StrokeColor = "#FF000000",
														StrokeSize = 1,
													},
													height = "25",
													ignoreSize = "True",
													name = "Label_activity",
													nTextAlign = "1",
													nTextHAlign = "1",
													rotation = "-30",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "770",
													text = "Event",
													touchAble = "False",
													touchScaleEnable = "False",
													UILayoutViewModel = 
													{
														PositionX = 7,
														PositionY = -35,
													},
													visible = "False",
													width = "49",
													ZOrder = "1",
												},
											},
										},
										{
											controlID = "Button_focus_Panel_btList_Panel_left_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
											UUID = "f591019a_4e4d_4288_85a4_d7c4267c964c",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											classname = "MEButton",
											ClickHighLightEnabled = "True",
											dstBlendFunc = "771",
											flipX = "False",
											flipY = "False",
											height = "80",
											ignoreSize = "True",
											name = "Button_focus",
											normal = "ui/mainLayer/new_ui_1/btn_focus.png",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "True",
											UILayoutViewModel = 
											{
												PositionX = 59,
												PositionY = 216,
												LeftPositon = 26,
												TopPosition = 87,
												relativeToName = "Panel",
											},
											UItype = "Button",
											width = "80",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "Label_focus_Button_focus_Panel_btList_Panel_left_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
													UUID = "a78a9253_ba00_4d4b_ba46_dfd6c498e92a",
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
														StrokeColor = "#FF000000",
														StrokeSize = 1,
													},
													height = "25",
													ignoreSize = "True",
													name = "Label_focus",
													nTextAlign = "1",
													nTextHAlign = "1",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "770",
													text = "Follow",
													touchAble = "False",
													touchScaleEnable = "False",
													UILayoutViewModel = 
													{
														PositionY = -37,
													},
													visible = "False",
													width = "59",
													ZOrder = "1",
												},
												{
													controlID = "Image_focus_Button_focus_Panel_btList_Panel_left_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
													UUID = "3bad97b2_ba63_4523_ada5_25683d4c6319",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0.5",
													backGroundScale9Enable = "False",
													classname = "MEImage",
													dstBlendFunc = "771",
													height = "50",
													ignoreSize = "True",
													name = "Image_focus",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "1",
													texturePath = "ui/mainLayer/new_ui/btn_ativity.png",
													touchAble = "False",
													UILayoutViewModel = 
													{
														PositionY = 10,
													},
													visible = "False",
													width = "50",
													ZOrder = "1",
												},
												{
													controlID = "Image_focusTip_Button_focus_Panel_btList_Panel_left_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
													UUID = "39183796_e015_439f_a8fd_c290bb0ef981",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0.5",
													backGroundScale9Enable = "False",
													classname = "MEImage",
													dstBlendFunc = "771",
													height = "80",
													ignoreSize = "True",
													name = "Image_focusTip",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "1",
													texturePath = "ui/mainLayer/new_ui_1/btn_focusnew.png",
													touchAble = "False",
													UILayoutViewModel = 
													{
														
													},
													width = "80",
													ZOrder = "1",
													components = 
													{
														
														{
															controlID = "Image_updateTip_Image_focusTip_Button_focus_Panel_btList_Panel_left_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
															UUID = "03e16849_1248_43b1_9fcf_c6aecd504d31",
															anchorPoint = "False",
															anchorPointX = "0.5",
															anchorPointY = "0.5",
															backGroundScale9Enable = "False",
															classname = "MEImage",
															dstBlendFunc = "771",
															height = "30",
															ignoreSize = "True",
															name = "Image_updateTip",
															sizepercentx = "0",
															sizepercenty = "0",
															sizeType = "0",
															srcBlendFunc = "1",
															texturePath = "ui/common/news_small.png",
															touchAble = "False",
															UILayoutViewModel = 
															{
																PositionX = 18,
																PositionY = 11,
															},
															width = "30",
															ZOrder = "1",
														},
													},
												},
											},
										},
										{
											controlID = "Button_RoleTeach_Panel_btList_Panel_left_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
											UUID = "ebb81593_773b_42d8_bc9b_ed636d055828",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											classname = "MEButton",
											ClickHighLightEnabled = "True",
											dstBlendFunc = "771",
											flipX = "False",
											flipY = "False",
											height = "80",
											ignoreSize = "True",
											name = "Button_RoleTeach",
											normal = "ui/mainLayer/new_ui_1/044.png",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "True",
											UILayoutViewModel = 
											{
												PositionX = 42,
												PositionY = 162,
												LeftPositon = 26,
												TopPosition = 87,
												relativeToName = "Panel",
											},
											UItype = "Button",
											width = "80",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "Label_RoleTeach_Button_RoleTeach_Panel_btList_Panel_left_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
													UUID = "ce9f57d1_d236_47a9_a885_3ac6f799287d",
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
														StrokeColor = "#FF000000",
														StrokeSize = 1,
													},
													height = "25",
													ignoreSize = "True",
													name = "Label_RoleTeach",
													nTextAlign = "1",
													nTextHAlign = "1",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "770",
													text = "Follow",
													touchAble = "False",
													touchScaleEnable = "False",
													UILayoutViewModel = 
													{
														PositionY = -37,
													},
													visible = "False",
													width = "59",
													ZOrder = "1",
												},
												{
													controlID = "Image_RoleTeach_Button_RoleTeach_Panel_btList_Panel_left_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
													UUID = "a5576696_50b5_4dde_bb4a_f96fffcf0c9d",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0.5",
													backGroundScale9Enable = "False",
													classname = "MEImage",
													dstBlendFunc = "771",
													height = "50",
													ignoreSize = "True",
													name = "Image_RoleTeach",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "1",
													texturePath = "ui/mainLayer/new_ui/btn_ativity.png",
													touchAble = "False",
													UILayoutViewModel = 
													{
														PositionY = 10,
													},
													visible = "False",
													width = "50",
													ZOrder = "1",
												},
												{
													controlID = "Image_focusTip_Button_RoleTeach_Panel_btList_Panel_left_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
													UUID = "6701e28d_5ed5_4694_a050_afe2ab047e29",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0.5",
													backGroundScale9Enable = "False",
													classname = "MEImage",
													dstBlendFunc = "771",
													height = "80",
													ignoreSize = "True",
													name = "Image_focusTip",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "1",
													texturePath = "ui/mainLayer/new_ui_1/049.png",
													touchAble = "False",
													UILayoutViewModel = 
													{
														
													},
													visible = "False",
													width = "80",
													ZOrder = "1",
													components = 
													{
														
														{
															controlID = "Image_updateTip_Image_focusTip_Button_RoleTeach_Panel_btList_Panel_left_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
															UUID = "9cdb2738_5596_485b_8772_3e3cdc3ded28",
															anchorPoint = "False",
															anchorPointX = "0.5",
															anchorPointY = "0.5",
															backGroundScale9Enable = "False",
															classname = "MEImage",
															dstBlendFunc = "771",
															height = "30",
															ignoreSize = "True",
															name = "Image_updateTip",
															sizepercentx = "0",
															sizepercenty = "0",
															sizeType = "0",
															srcBlendFunc = "1",
															texturePath = "ui/common/news_small.png",
															touchAble = "False",
															UILayoutViewModel = 
															{
																PositionX = 18,
																PositionY = 11,
															},
															width = "30",
															ZOrder = "1",
														},
													},
												},
											},
										},
										{
											controlID = "btn_zhibo_Panel_btList_Panel_left_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
											UUID = "27d43347_6e0d_401e_8476_797d076c4d00",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											classname = "MEButton",
											ClickHighLightEnabled = "True",
											dstBlendFunc = "771",
											flipX = "False",
											flipY = "False",
											height = "80",
											ignoreSize = "True",
											name = "btn_zhibo",
											normal = "ui/mainLayer/new_ui_1/btn_zhibo.png",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "True",
											UILayoutViewModel = 
											{
												PositionX = 42,
												PositionY = 162,
												LeftPositon = 26,
												TopPosition = 87,
												relativeToName = "Panel",
											},
											UItype = "Button",
											width = "80",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "img_zhibo_btn_zhibo_Panel_btList_Panel_left_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
													UUID = "056678f4_c6df_4c4f_83fd_da2761bf00ac",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0.5",
													backGroundScale9Enable = "False",
													classname = "MEImage",
													dstBlendFunc = "771",
													height = "80",
													ignoreSize = "True",
													name = "img_zhibo",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "1",
													texturePath = "ui/mainLayer/new_ui_1/btn_zhibo_s.png",
													touchAble = "False",
													UILayoutViewModel = 
													{
														
													},
													width = "80",
													ZOrder = "1",
													components = 
													{
														
														{
															controlID = "img_zhiboTip_img_zhibo_btn_zhibo_Panel_btList_Panel_left_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
															UUID = "bb42beaa_4609_4b50_80be_fd3b8e864c4a",
															anchorPoint = "False",
															anchorPointX = "0.5",
															anchorPointY = "0.5",
															backGroundScale9Enable = "False",
															classname = "MEImage",
															dstBlendFunc = "771",
															height = "30",
															ignoreSize = "True",
															name = "img_zhiboTip",
															sizepercentx = "0",
															sizepercenty = "0",
															sizeType = "0",
															srcBlendFunc = "1",
															texturePath = "ui/common/news_small.png",
															touchAble = "False",
															UILayoutViewModel = 
															{
																PositionX = 18,
																PositionY = 11,
															},
															width = "30",
															ZOrder = "1",
														},
													},
												},
											},
										},
										{
											controlID = "Button_serverGiftActivity_Panel_btList_Panel_left_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
											UUID = "33294c92_630b_4f8d_8dce_1a02d75d3b29",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											classname = "MEButton",
											ClickHighLightEnabled = "True",
											dstBlendFunc = "771",
											flipX = "False",
											flipY = "False",
											height = "80",
											ignoreSize = "True",
											name = "Button_serverGiftActivity",
											normal = "ui/mainLayer/new_ui_1/a4.png",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "True",
											UILayoutViewModel = 
											{
												PositionX = 62,
												PositionY = 106,
												LeftPositon = 26,
												TopPosition = 87,
												relativeToName = "Panel",
											},
											UItype = "Button",
											width = "80",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "Label_serverGiftActivity_Button_serverGiftActivity_Panel_btList_Panel_left_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
													UUID = "684a154c_ec53_4b9f_b592_1788d3970a96",
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
														StrokeColor = "#FF000000",
														StrokeSize = 1,
													},
													height = "25",
													ignoreSize = "True",
													name = "Label_serverGiftActivity",
													nTextAlign = "1",
													nTextHAlign = "1",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "770",
													text = "Follow",
													touchAble = "False",
													touchScaleEnable = "False",
													UILayoutViewModel = 
													{
														PositionY = -37,
													},
													visible = "False",
													width = "59",
													ZOrder = "1",
												},
												{
													controlID = "Image_serverGiftActivity_Button_serverGiftActivity_Panel_btList_Panel_left_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
													UUID = "f2a7f474_1e54_47c6_b4cd_7e2b48c7619e",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0.5",
													backGroundScale9Enable = "False",
													classname = "MEImage",
													dstBlendFunc = "771",
													height = "50",
													ignoreSize = "True",
													name = "Image_serverGiftActivity",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "1",
													texturePath = "ui/mainLayer/new_ui/btn_ativity.png",
													touchAble = "False",
													UILayoutViewModel = 
													{
														PositionY = 10,
													},
													visible = "False",
													width = "50",
													ZOrder = "1",
												},
												{
													controlID = "Image_serverGiftTip_Button_serverGiftActivity_Panel_btList_Panel_left_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
													UUID = "76eddb92_89ce_4bb6_8f58_6e3e71b04737",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0.5",
													backGroundScale9Enable = "False",
													classname = "MEImage",
													dstBlendFunc = "771",
													height = "80",
													ignoreSize = "True",
													name = "Image_serverGiftTip",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "1",
													texturePath = "ui/mainLayer/new_ui_1/a4new.png",
													touchAble = "False",
													UILayoutViewModel = 
													{
														
													},
													width = "80",
													ZOrder = "1",
													components = 
													{
														
														{
															controlID = "Image_updateTip_Image_serverGiftTip_Button_serverGiftActivity_Panel_btList_Panel_left_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
															UUID = "0bb6c8ff_e6d0_415c_81fc_ecaff3916624",
															anchorPoint = "False",
															anchorPointX = "0.5",
															anchorPointY = "0.5",
															backGroundScale9Enable = "False",
															classname = "MEImage",
															dstBlendFunc = "771",
															height = "30",
															ignoreSize = "True",
															name = "Image_updateTip",
															sizepercentx = "0",
															sizepercenty = "0",
															sizeType = "0",
															srcBlendFunc = "1",
															texturePath = "ui/common/news_small.png",
															touchAble = "False",
															UILayoutViewModel = 
															{
																PositionX = 18,
																PositionY = 11,
															},
															width = "30",
															ZOrder = "1",
														},
													},
												},
											},
										},
										{
											controlID = "Button_assist_Panel_btList_Panel_left_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
											UUID = "c9e17974_c640_4d97_9ddd_61d0714040a5",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											classname = "MEButton",
											ClickHighLightEnabled = "True",
											dstBlendFunc = "771",
											flipX = "False",
											flipY = "False",
											height = "50",
											ignoreSize = "True",
											name = "Button_assist",
											normal = "ui/mainLayer/new_ui/btn_assist.png",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "True",
											UILayoutViewModel = 
											{
												PositionX = 97,
												PositionY = 295,
												LeftPositon = 26,
												TopPosition = 87,
												relativeToName = "Panel",
											},
											UItype = "Button",
											width = "50",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "Label_title_Button_assist_Panel_btList_Panel_left_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
													UUID = "a6eee63c_6bab_493f_9ef0_796f8b7d56e3",
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
														StrokeColor = "#FF000000",
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
													text = "Support",
													touchAble = "False",
													touchScaleEnable = "False",
													UILayoutViewModel = 
													{
														PositionY = -37,
													},
													width = "69",
													ZOrder = "1",
												},
												{
													controlID = "Image_survey_Button_assist_Panel_btList_Panel_left_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
													UUID = "52c71669_e998_48b2_a0f2_c5c4da586d04",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0.5",
													backGroundScale9Enable = "False",
													classname = "MEImage",
													dstBlendFunc = "771",
													height = "50",
													ignoreSize = "True",
													name = "Image_survey",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "1",
													texturePath = "ui/mainLayer/new_ui/btn_ativity.png",
													touchAble = "False",
													UILayoutViewModel = 
													{
														PositionY = 10,
													},
													visible = "False",
													width = "50",
													ZOrder = "1",
												},
												{
													controlID = "Image_assist_Tip_Button_assist_Panel_btList_Panel_left_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
													UUID = "60a9bb61_d91b_442c_bbeb_80ec3304a53e",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0.5",
													backGroundScale9Enable = "False",
													classname = "MEImage",
													dstBlendFunc = "771",
													height = "30",
													ignoreSize = "True",
													name = "Image_assist_Tip",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "1",
													texturePath = "ui/common/news_small.png",
													touchAble = "False",
													UILayoutViewModel = 
													{
														PositionX = 18,
														PositionY = 11,
													},
													width = "30",
													ZOrder = "1",
												},
											},
										},
										{
											controlID = "Button_newYear_Panel_btList_Panel_left_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
											UUID = "978b38f8_c950_4c0a_a73b_4438323cdde3",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											classname = "MEButton",
											ClickHighLightEnabled = "True",
											dstBlendFunc = "771",
											flipX = "False",
											flipY = "False",
											height = "50",
											ignoreSize = "True",
											name = "Button_newYear",
											normal = "ui/mainLayer/new_ui/btn_back.png",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "True",
											UILayoutViewModel = 
											{
												PositionX = 97,
												PositionY = 136,
												LeftPositon = 26,
												TopPosition = 87,
												relativeToName = "Panel",
											},
											UItype = "Button",
											width = "50",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "Label_backPlayer_Button_newYear_Panel_btList_Panel_left_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
													UUID = "a2543d39_cb97_40c1_be4b_99ced9f651b9",
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
														StrokeColor = "#FF000000",
														StrokeSize = 1,
													},
													height = "25",
													ignoreSize = "True",
													name = "Label_backPlayer",
													nTextAlign = "1",
													nTextHAlign = "1",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "770",
													text = "Lantern Fest",
													touchAble = "False",
													touchScaleEnable = "False",
													UILayoutViewModel = 
													{
														PositionY = -37,
													},
													width = "102",
													ZOrder = "1",
												},
												{
													controlID = "Image_newYearTip_Button_newYear_Panel_btList_Panel_left_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
													UUID = "7929a25b_d075_4b5d_9ca5_51a51e7c675d",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0.5",
													backGroundScale9Enable = "False",
													classname = "MEImage",
													dstBlendFunc = "771",
													height = "30",
													ignoreSize = "True",
													name = "Image_newYearTip",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "1",
													texturePath = "ui/common/news_small.png",
													touchAble = "False",
													UILayoutViewModel = 
													{
														PositionX = 18,
														PositionY = 11,
													},
													width = "30",
													ZOrder = "1",
												},
											},
										},
										{
											controlID = "Button_monthCard_Panel_btList_Panel_left_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
											UUID = "bf06b725_61bc_41db_ac38_507d3131db19",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											classname = "MEButton",
											ClickHighLightEnabled = "True",
											dstBlendFunc = "771",
											flipX = "False",
											flipY = "False",
											height = "50",
											ignoreSize = "True",
											name = "Button_monthCard",
											normal = "ui/mainLayer/new_ui/btn_monthcard.png",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "True",
											UILayoutViewModel = 
											{
												PositionX = 120,
												PositionY = 424,
												LeftPositon = 26,
												TopPosition = 87,
												relativeToName = "Panel",
											},
											UItype = "Button",
											width = "50",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "Label_monthCard_Button_monthCard_Panel_btList_Panel_left_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
													UUID = "fff815e5_00c9_45a8_ba7e_77654c9a4f47",
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
														StrokeColor = "#FF000000",
														StrokeSize = 1,
													},
													height = "25",
													ignoreSize = "True",
													name = "Label_monthCard",
													nTextAlign = "1",
													nTextHAlign = "1",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "770",
													text = "New Year",
													touchAble = "False",
													touchScaleEnable = "False",
													UILayoutViewModel = 
													{
														PositionY = -37,
													},
													width = "81",
													ZOrder = "1",
												},
												{
													controlID = "Image_monthCardTip_Button_monthCard_Panel_btList_Panel_left_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
													UUID = "7d9e7ca3_8468_4e9e_84de_00ffb2a9bc68",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0.5",
													backGroundScale9Enable = "False",
													classname = "MEImage",
													dstBlendFunc = "771",
													height = "30",
													ignoreSize = "True",
													name = "Image_monthCardTip",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "1",
													texturePath = "ui/common/news_small.png",
													touchAble = "False",
													UILayoutViewModel = 
													{
														PositionX = 18,
														PositionY = 11,
													},
													width = "30",
													ZOrder = "1",
												},
											},
										},
										{
											controlID = "Button_ScoreReward_Panel_btList_Panel_left_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
											UUID = "5241822a_0c0d_48cf_8544_5a7227fa1531",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											classname = "MEButton",
											ClickHighLightEnabled = "True",
											dstBlendFunc = "771",
											flipX = "False",
											flipY = "False",
											height = "80",
											ignoreSize = "True",
											name = "Button_ScoreReward",
											normal = "ui/mainLayer/new_ui_1/btn_tzr.png",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "True",
											UILayoutViewModel = 
											{
												PositionX = 59,
												PositionY = 216,
												LeftPositon = 26,
												TopPosition = 87,
												relativeToName = "Panel",
											},
											UItype = "Button",
											width = "80",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "Label_monthCard_Button_ScoreReward_Panel_btList_Panel_left_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
													UUID = "6281b735_4d5c_4545_8413_bdab9299ca79",
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
														StrokeColor = "#FF000000",
														StrokeSize = 1,
													},
													height = "25",
													ignoreSize = "True",
													name = "Label_monthCard",
													nTextAlign = "1",
													nTextHAlign = "1",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "770",
													text = "New Year",
													touchAble = "False",
													touchScaleEnable = "False",
													UILayoutViewModel = 
													{
														PositionY = -37,
													},
													visible = "False",
													width = "81",
													ZOrder = "1",
												},
												{
													controlID = "Image_ScoreRewardTip_Button_ScoreReward_Panel_btList_Panel_left_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
													UUID = "c2c32f5e_1456_40d4_b746_243a1b0b396d",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0.5",
													backGroundScale9Enable = "False",
													classname = "MEImage",
													dstBlendFunc = "771",
													height = "80",
													ignoreSize = "True",
													name = "Image_ScoreRewardTip",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "1",
													texturePath = "ui/mainLayer/new_ui_1/btn_tzrnew.png",
													touchAble = "False",
													UILayoutViewModel = 
													{
														
													},
													width = "80",
													ZOrder = "1",
													components = 
													{
														
														{
															controlID = "Image_updateTip_Image_ScoreRewardTip_Button_ScoreReward_Panel_btList_Panel_left_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
															UUID = "a6cbd258_df93_4df5_af21_b551649df8bd",
															anchorPoint = "False",
															anchorPointX = "0.5",
															anchorPointY = "0.5",
															backGroundScale9Enable = "False",
															classname = "MEImage",
															dstBlendFunc = "771",
															height = "30",
															ignoreSize = "True",
															name = "Image_updateTip",
															sizepercentx = "0",
															sizepercenty = "0",
															sizeType = "0",
															srcBlendFunc = "1",
															texturePath = "ui/common/news_small.png",
															touchAble = "False",
															UILayoutViewModel = 
															{
																PositionX = 18,
																PositionY = 11,
															},
															width = "30",
															ZOrder = "1",
														},
													},
												},
											},
										},
										{
											controlID = "Button_sxsr_Panel_btList_Panel_left_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
											UUID = "a24fcc15_accd_4378_843c_67bdac12c261",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											classname = "MEButton",
											ClickHighLightEnabled = "True",
											dstBlendFunc = "771",
											flipX = "False",
											flipY = "False",
											height = "90",
											ignoreSize = "False",
											name = "Button_sxsr",
											normal = "ui/mainLayer/sxsr.png",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "True",
											UILayoutViewModel = 
											{
												PositionX = 142,
												PositionY = 160,
												LeftPositon = 26,
												TopPosition = 87,
												relativeToName = "Panel",
											},
											UItype = "Button",
											width = "90",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "Image_sxsrTip_Button_sxsr_Panel_btList_Panel_left_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
													UUID = "817eb5f3_f882_46b5_a58b_88bbbf1ca466",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0.5",
													backGroundScale9Enable = "False",
													classname = "MEImage",
													dstBlendFunc = "771",
													height = "30",
													ignoreSize = "True",
													name = "Image_sxsrTip",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "1",
													texturePath = "ui/common/news_small.png",
													touchAble = "False",
													UILayoutViewModel = 
													{
														PositionX = 18,
														PositionY = 11,
													},
													width = "30",
													ZOrder = "1",
												},
												{
													controlID = "Label_sxsr_Button_sxsr_Panel_btList_Panel_left_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
													UUID = "f4625b21_e04f_4f30_9519_39bd01da0707",
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
														StrokeColor = "#FF5C5995",
														StrokeSize = 1,
													},
													height = "25",
													ignoreSize = "True",
													name = "Label_sxsr",
													nTextAlign = "1",
													nTextHAlign = "1",
													rotation = "30",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "770",
													text = "Forum",
													touchAble = "False",
													touchScaleEnable = "False",
													UILayoutViewModel = 
													{
														PositionX = -14,
														PositionY = -29,
													},
													width = "58",
													ZOrder = "1",
												},
											},
										},
										{
											controlID = "Button_rankNotice_Panel_btList_Panel_left_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
											UUID = "071599b8_0145_4b8d_8158_a67ceaca873f",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											classname = "MEButton",
											ClickHighLightEnabled = "True",
											dstBlendFunc = "771",
											flipX = "False",
											flipY = "False",
											height = "70",
											ignoreSize = "True",
											name = "Button_rankNotice",
											normal = "ui/mainLayer3/c1005.png",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "True",
											UILayoutViewModel = 
											{
												PositionX = 113,
												PositionY = 426,
												LeftPositon = 26,
												TopPosition = 87,
												relativeToName = "Panel",
											},
											UItype = "Button",
											width = "70",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "Label_title_Button_rankNotice_Panel_btList_Panel_left_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
													UUID = "e179f0a0_b45b_40be_99d5_c0e465fb3f5c",
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
														StrokeColor = "#FF000000",
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
													text = "Support",
													touchAble = "False",
													touchScaleEnable = "False",
													UILayoutViewModel = 
													{
														PositionY = -37,
													},
													visible = "False",
													width = "69",
													ZOrder = "1",
												},
												{
													controlID = "Image_survey_Button_rankNotice_Panel_btList_Panel_left_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
													UUID = "6a92c497_b36c_40d3_a26b_b25ee8472106",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0.5",
													backGroundScale9Enable = "False",
													classname = "MEImage",
													dstBlendFunc = "771",
													height = "50",
													ignoreSize = "True",
													name = "Image_survey",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "1",
													texturePath = "ui/mainLayer/new_ui/btn_ativity.png",
													touchAble = "False",
													UILayoutViewModel = 
													{
														PositionY = 10,
													},
													visible = "False",
													width = "50",
													ZOrder = "1",
												},
												{
													controlID = "Image_assist_Tip_Button_rankNotice_Panel_btList_Panel_left_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
													UUID = "4840737e_e28f_4f38_b2bc_45e411b68de6",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0.5",
													backGroundScale9Enable = "False",
													classname = "MEImage",
													dstBlendFunc = "771",
													height = "30",
													ignoreSize = "True",
													name = "Image_assist_Tip",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "1",
													texturePath = "ui/common/news_small.png",
													touchAble = "False",
													UILayoutViewModel = 
													{
														PositionX = 18,
														PositionY = 11,
													},
													visible = "False",
													width = "30",
													ZOrder = "1",
												},
											},
										},
									},
								},
								{
									controlID = "Button_newPlayer_Panel_left_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
									UUID = "0d87baac_16f4_476f_b415_7d3aab3643f8",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEButton",
									ClickHighLightEnabled = "True",
									dstBlendFunc = "771",
									flipX = "False",
									flipY = "False",
									height = "70",
									ignoreSize = "True",
									name = "Button_newPlayer",
									normal = "ui/mainLayer/new_ui/btn_newPlayer.png",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "True",
									UILayoutViewModel = 
									{
										PositionX = 210,
										PositionY = 360,
										LeftPositon = 26,
										TopPosition = 87,
										relativeToName = "Panel",
									},
									UItype = "Button",
									width = "80",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "Image_update_Button_newPlayer_Panel_left_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
											UUID = "ce7f8a8d_980a_4ef8_a4ae_fc5e7a1b164b",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											classname = "MEImage",
											dstBlendFunc = "771",
											height = "50",
											ignoreSize = "True",
											name = "Image_update",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											texturePath = "ui/mainLayer/new_ui/btn_ativity.png",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionY = 10,
											},
											visible = "False",
											width = "50",
											ZOrder = "1",
										},
										{
											controlID = "Image_newPlayerTip_Button_newPlayer_Panel_left_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
											UUID = "bc272e1e_f1c0_4652_a4f5_03421390782e",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											classname = "MEImage",
											dstBlendFunc = "771",
											height = "30",
											ignoreSize = "True",
											name = "Image_newPlayerTip",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											texturePath = "ui/common/news_small.png",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 22,
												PositionY = 25,
											},
											width = "30",
											ZOrder = "1",
										},
									},
								},
								{
									controlID = "Button_newPlayerBook_Panel_left_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
									UUID = "ed8014cb_88f6_45b9_a630_b299825a869a",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEButton",
									ClickHighLightEnabled = "True",
									dstBlendFunc = "771",
									flipX = "False",
									flipY = "False",
									height = "70",
									ignoreSize = "True",
									name = "Button_newPlayerBook",
									normal = "ui/mainLayer/new_ui/btn_newPlayer.png",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "True",
									UILayoutViewModel = 
									{
										PositionX = 207,
										PositionY = 285,
										LeftPositon = 26,
										TopPosition = 87,
										relativeToName = "Panel",
									},
									UItype = "Button",
									width = "80",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "Image_newPlayerTip_Button_newPlayerBook_Panel_left_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
											UUID = "882001ef_8696_47a6_b4bf_f4f776073459",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											classname = "MEImage",
											dstBlendFunc = "771",
											height = "30",
											ignoreSize = "True",
											name = "Image_newPlayerTip",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											texturePath = "ui/common/news_small.png",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 22,
												PositionY = 25,
											},
											width = "30",
											ZOrder = "1",
										},
									},
								},
								{
									controlID = "Button_gongzhu_Panel_left_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
									UUID = "62e598ae_fe22_455e_b7a2_4ee7b4ab2392",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEButton",
									ClickHighLightEnabled = "True",
									dstBlendFunc = "771",
									flipX = "False",
									flipY = "False",
									height = "90",
									ignoreSize = "True",
									name = "Button_gongzhu",
									normal = "ui/task/01/4.png",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "True",
									UILayoutViewModel = 
									{
										PositionX = 430,
										PositionY = 500,
									},
									UItype = "Button",
									width = "90",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "Spine_gongzhu_Button_gongzhu_Panel_left_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
											UUID = "ea525fc2_8050_4099_9e48_33fb013935ea",
											classname = "MESpine",
											dstBlendFunc = "771",
											name = "Spine_gongzhu",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											spineModel = 
											{
												SpinePath = "effect/effect_gongzhuzhixin/effect_gongzhuzhixin",
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
												
											},
											ZOrder = "1",
										},
										{
											controlID = "Image_redTips_Button_gongzhu_Panel_left_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
											UUID = "257c69b7_a9ca_41fd_8b9b_c6cde1f91507",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											classname = "MEImage",
											dstBlendFunc = "771",
											height = "30",
											ignoreSize = "True",
											name = "Image_redTips",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											texturePath = "ui/common/news_small.png",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 21,
												PositionY = 23,
											},
											width = "30",
											ZOrder = "1",
										},
									},
								},
								{
									controlID = "Button_btnListEx_Panel_left_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
									UUID = "7c932307_55e9_4a43_ad0f_050b141d751e",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEButton",
									ClickHighLightEnabled = "True",
									dstBlendFunc = "771",
									flipX = "False",
									flipY = "False",
									height = "80",
									ignoreSize = "True",
									name = "Button_btnListEx",
									normal = "ui/mainLayer/new_ui_1/003.png",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "True",
									UILayoutViewModel = 
									{
										PositionX = 43,
										PositionY = 65,
										LeftPositon = 26,
										TopPosition = 87,
										relativeToName = "Panel",
									},
									UItype = "Button",
									width = "80",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "Label_focus_Button_btnListEx_Panel_left_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
											UUID = "5bac5edd_bc5a_428a_a846_fff7f70d2f1c",
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
												StrokeColor = "#FF000000",
												StrokeSize = 1,
											},
											height = "25",
											ignoreSize = "True",
											name = "Label_focus",
											nTextAlign = "1",
											nTextHAlign = "1",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "770",
											text = "Follow",
											touchAble = "False",
											touchScaleEnable = "False",
											UILayoutViewModel = 
											{
												PositionY = -37,
											},
											visible = "False",
											width = "59",
											ZOrder = "1",
										},
										{
											controlID = "Image_focus_Button_btnListEx_Panel_left_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
											UUID = "d6b3e84f_7d65_4bea_9cfd_8a0cba96c81c",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											classname = "MEImage",
											dstBlendFunc = "771",
											height = "50",
											ignoreSize = "True",
											name = "Image_focus",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											texturePath = "ui/mainLayer/new_ui/btn_ativity.png",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionY = 10,
											},
											visible = "False",
											width = "50",
											ZOrder = "1",
										},
										{
											controlID = "Image_focusTip_Button_btnListEx_Panel_left_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
											UUID = "519ce381_c09f_44b5_8e1d_9e84571715b5",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											classname = "MEImage",
											dstBlendFunc = "771",
											height = "80",
											ignoreSize = "True",
											name = "Image_focusTip",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											texturePath = "ui/mainLayer/new_ui_1/049.png",
											touchAble = "False",
											UILayoutViewModel = 
											{
												
											},
											visible = "False",
											width = "80",
											ZOrder = "1",
										},
										{
											controlID = "Panel_btListEx_Button_btnListEx_Panel_left_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
											UUID = "f56c1d0d_16f6_4eb9_b17f_95d37b7af381",
											anchorPoint = "False",
											anchorPointX = "0",
											anchorPointY = "0",
											backGroundScale9Enable = "True;capInsetsX:0;capInsetsY:0;capInsetsWidth:0;capInsetsHeight:0",
											bgColorOpacity = "50",
											bIsOpenClipping = "False",
											classname = "MEPanel",
											colorType = "0;SingleColor:#FFE6E6E6;GraduallyChangingColorStart:#FFFFFFFF;GraduallyChangingColorEnd:#FFFFFFFF;vectorX:0;vectorY:0",
											DesignHeight = "640",
											DesignType = "0",
											DesignWidth = "960",
											dstBlendFunc = "771",
											height = "140",
											ignoreSize = "False",
											name = "Panel_btListEx",
											panelTexturePath = "ui/mainLayer/new_ui_1/004.png",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 29,
												PositionY = -103,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "425",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "Button_preview_Panel_btListEx_Button_btnListEx_Panel_left_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
													UUID = "15cde9ff_36e7_4f92_8f17_7c46a6bb6888",
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
													name = "Button_preview",
													normal = "ui/preview/main_btn.png",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "1",
													touchAble = "True",
													UILayoutViewModel = 
													{
														PositionX = 54,
														PositionY = 43,
														LeftPositon = 26,
														TopPosition = 87,
														relativeToName = "Panel",
													},
													UItype = "Button",
													width = "60",
													ZOrder = "1",
													components = 
													{
														
														{
															controlID = "Label_update_Button_preview_Panel_btListEx_Button_btnListEx_Panel_left_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
															UUID = "f67394a6_e60a_4275_a51e_72a01cd9ff72",
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
																StrokeColor = "#FF000000",
																StrokeSize = 1,
															},
															height = "25",
															ignoreSize = "True",
															name = "Label_update",
															nTextAlign = "1",
															nTextHAlign = "1",
															sizepercentx = "0",
															sizepercenty = "0",
															sizeType = "0",
															srcBlendFunc = "770",
															text = "Forecast",
															touchAble = "False",
															touchScaleEnable = "False",
															UILayoutViewModel = 
															{
																PositionX = 36,
																PositionY = -9,
															},
															width = "70",
															ZOrder = "1",
														},
														{
															controlID = "Image_update_Button_preview_Panel_btListEx_Button_btnListEx_Panel_left_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
															UUID = "72452bdb_cfe0_4fb8_ad91_504e3f2bb0de",
															anchorPoint = "False",
															anchorPointX = "0.5",
															anchorPointY = "0.5",
															backGroundScale9Enable = "False",
															classname = "MEImage",
															dstBlendFunc = "771",
															height = "50",
															ignoreSize = "True",
															name = "Image_update",
															sizepercentx = "0",
															sizepercenty = "0",
															sizeType = "0",
															srcBlendFunc = "1",
															texturePath = "ui/mainLayer/new_ui/btn_ativity.png",
															touchAble = "False",
															UILayoutViewModel = 
															{
																PositionY = 10,
															},
															visible = "False",
															width = "50",
															ZOrder = "1",
														},
														{
															controlID = "Image_previewTip_Button_preview_Panel_btListEx_Button_btnListEx_Panel_left_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
															UUID = "42d4a6a3_444f_41f1_a3bd_9a1a059cf3ec",
															anchorPoint = "False",
															anchorPointX = "0.5",
															anchorPointY = "0.5",
															backGroundScale9Enable = "False",
															classname = "MEImage",
															dstBlendFunc = "771",
															height = "30",
															ignoreSize = "True",
															name = "Image_previewTip",
															sizepercentx = "0",
															sizepercenty = "0",
															sizeType = "0",
															srcBlendFunc = "1",
															texturePath = "ui/common/news_small.png",
															touchAble = "False",
															UILayoutViewModel = 
															{
																PositionX = 18,
																PositionY = 11,
															},
															width = "30",
															ZOrder = "1",
														},
													},
												},
												{
													controlID = "Button_backPlayer_Panel_btListEx_Button_btnListEx_Panel_left_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
													UUID = "e8089581_0586_4b5a_b6ff_45428989f9c3",
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
													name = "Button_backPlayer",
													normal = "ui/mainLayer/new_ui_1/btn_back.png",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "1",
													touchAble = "True",
													UILayoutViewModel = 
													{
														PositionX = 165,
														PositionY = 104,
														LeftPositon = 26,
														TopPosition = 87,
														relativeToName = "Panel",
													},
													UItype = "Button",
													width = "60",
													ZOrder = "1",
													components = 
													{
														
														{
															controlID = "Label_backPlayer_Button_backPlayer_Panel_btListEx_Button_btnListEx_Panel_left_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
															UUID = "05548c54_71ac_4d9b_a91e_79887a4b3373",
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
																StrokeColor = "#FF000000",
																StrokeSize = 1,
															},
															height = "25",
															ignoreSize = "True",
															name = "Label_backPlayer",
															nTextAlign = "1",
															nTextHAlign = "1",
															sizepercentx = "0",
															sizepercenty = "0",
															sizeType = "0",
															srcBlendFunc = "770",
															text = "Returner",
															touchAble = "False",
															touchScaleEnable = "False",
															UILayoutViewModel = 
															{
																PositionY = -27,
															},
															width = "73",
															ZOrder = "1",
														},
														{
															controlID = "Image_update_Button_backPlayer_Panel_btListEx_Button_btnListEx_Panel_left_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
															UUID = "2b77c497_8521_45a0_9c05_2a6a26f5d08c",
															anchorPoint = "False",
															anchorPointX = "0.5",
															anchorPointY = "0.5",
															backGroundScale9Enable = "False",
															classname = "MEImage",
															dstBlendFunc = "771",
															height = "50",
															ignoreSize = "True",
															name = "Image_update",
															sizepercentx = "0",
															sizepercenty = "0",
															sizeType = "0",
															srcBlendFunc = "1",
															texturePath = "ui/mainLayer/new_ui/btn_ativity.png",
															touchAble = "False",
															UILayoutViewModel = 
															{
																PositionY = 10,
															},
															visible = "False",
															width = "50",
															ZOrder = "1",
														},
														{
															controlID = "Image_backPlayerTip_Button_backPlayer_Panel_btListEx_Button_btnListEx_Panel_left_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
															UUID = "2b7c4114_3410_4f10_86c9_409a49b00d88",
															anchorPoint = "False",
															anchorPointX = "0.5",
															anchorPointY = "0.5",
															backGroundScale9Enable = "False",
															classname = "MEImage",
															dstBlendFunc = "771",
															height = "30",
															ignoreSize = "True",
															name = "Image_backPlayerTip",
															sizepercentx = "0",
															sizepercenty = "0",
															sizeType = "0",
															srcBlendFunc = "1",
															texturePath = "ui/common/news_small.png",
															touchAble = "False",
															UILayoutViewModel = 
															{
																PositionX = 18,
																PositionY = 11,
															},
															width = "30",
															ZOrder = "1",
														},
													},
												},
												{
													controlID = "Button_update_Panel_btListEx_Button_btnListEx_Panel_left_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
													UUID = "192b12a1_8b70_4d97_ae5c_573b4d4ded02",
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
													name = "Button_update",
													normal = "ui/mainLayer/new_ui_1/btn_update.png",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "1",
													touchAble = "True",
													UILayoutViewModel = 
													{
														PositionX = 52,
														PositionY = 101,
														LeftPositon = 26,
														TopPosition = 87,
														relativeToName = "Panel",
													},
													UItype = "Button",
													width = "60",
													ZOrder = "1",
													components = 
													{
														
														{
															controlID = "Label_update_Button_update_Panel_btListEx_Button_btnListEx_Panel_left_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
															UUID = "8b735af0_a3fb_4552_ab56_c31d0eaa8a2c",
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
																StrokeColor = "#FF000000",
																StrokeSize = 1,
															},
															height = "25",
															ignoreSize = "True",
															name = "Label_update",
															nTextAlign = "1",
															nTextHAlign = "1",
															sizepercentx = "0",
															sizepercenty = "0",
															sizeType = "0",
															srcBlendFunc = "770",
															text = "Update",
															touchAble = "False",
															touchScaleEnable = "False",
															UILayoutViewModel = 
															{
																PositionX = 36,
																PositionY = -9,
															},
															width = "61",
															ZOrder = "1",
														},
														{
															controlID = "Image_update_Button_update_Panel_btListEx_Button_btnListEx_Panel_left_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
															UUID = "1bd2ee93_3009_45d7_88f8_6f8462e50784",
															anchorPoint = "False",
															anchorPointX = "0.5",
															anchorPointY = "0.5",
															backGroundScale9Enable = "False",
															classname = "MEImage",
															dstBlendFunc = "771",
															height = "50",
															ignoreSize = "True",
															name = "Image_update",
															sizepercentx = "0",
															sizepercenty = "0",
															sizeType = "0",
															srcBlendFunc = "1",
															texturePath = "ui/mainLayer/new_ui/btn_ativity.png",
															touchAble = "False",
															UILayoutViewModel = 
															{
																PositionY = 10,
															},
															visible = "False",
															width = "50",
															ZOrder = "1",
														},
														{
															controlID = "Image_updateTip_Button_update_Panel_btListEx_Button_btnListEx_Panel_left_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
															UUID = "cb78bb30_661e_4a3e_9962_1fc84cf4aca2",
															anchorPoint = "False",
															anchorPointX = "0.5",
															anchorPointY = "0.5",
															backGroundScale9Enable = "False",
															classname = "MEImage",
															dstBlendFunc = "771",
															height = "30",
															ignoreSize = "True",
															name = "Image_updateTip",
															sizepercentx = "0",
															sizepercenty = "0",
															sizeType = "0",
															srcBlendFunc = "1",
															texturePath = "ui/common/news_small.png",
															touchAble = "False",
															UILayoutViewModel = 
															{
																PositionX = 18,
																PositionY = 11,
															},
															width = "30",
															ZOrder = "1",
														},
													},
												},
												{
													controlID = "Button_wj_Panel_btListEx_Button_btnListEx_Panel_left_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
													UUID = "5dfc0eed_0b66_43cc_a6a7_fab2d0b2aec5",
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
													name = "Button_wj",
													normal = "ui/mainLayer/new_ui_1/btn_survey.png",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "1",
													touchAble = "True",
													UILayoutViewModel = 
													{
														PositionX = 265,
														PositionY = 104,
														LeftPositon = 26,
														TopPosition = 87,
														relativeToName = "Panel",
													},
													UItype = "Button",
													width = "60",
													ZOrder = "1",
													components = 
													{
														
														{
															controlID = "Label_title_Button_wj_Panel_btListEx_Button_btnListEx_Panel_left_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
															UUID = "c4bcdabd_989a_43b9_b969_7ed62d0d8ee5",
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
																StrokeColor = "#FF000000",
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
															text = "Questionnaire",
															touchAble = "False",
															touchScaleEnable = "False",
															UILayoutViewModel = 
															{
																PositionX = 36,
																PositionY = -9,
															},
															width = "115",
															ZOrder = "1",
														},
														{
															controlID = "Image_survey_Button_wj_Panel_btListEx_Button_btnListEx_Panel_left_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
															UUID = "46959f2c_ec76_4637_b3cb_35d86cad8325",
															anchorPoint = "False",
															anchorPointX = "0.5",
															anchorPointY = "0.5",
															backGroundScale9Enable = "False",
															classname = "MEImage",
															dstBlendFunc = "771",
															height = "50",
															ignoreSize = "True",
															name = "Image_survey",
															sizepercentx = "0",
															sizepercenty = "0",
															sizeType = "0",
															srcBlendFunc = "1",
															texturePath = "ui/mainLayer/new_ui/btn_ativity.png",
															touchAble = "False",
															UILayoutViewModel = 
															{
																PositionY = 10,
															},
															visible = "False",
															width = "50",
															ZOrder = "1",
														},
														{
															controlID = "Image_wjTip_Button_wj_Panel_btListEx_Button_btnListEx_Panel_left_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
															UUID = "cc6e1ec5_514d_468e_a775_695019bc5d54",
															anchorPoint = "False",
															anchorPointX = "0.5",
															anchorPointY = "0.5",
															backGroundScale9Enable = "False",
															classname = "MEImage",
															dstBlendFunc = "771",
															height = "30",
															ignoreSize = "True",
															name = "Image_wjTip",
															sizepercentx = "0",
															sizepercenty = "0",
															sizeType = "0",
															srcBlendFunc = "1",
															texturePath = "ui/common/news_small.png",
															touchAble = "False",
															UILayoutViewModel = 
															{
																PositionX = 18,
																PositionY = 11,
															},
															width = "30",
															ZOrder = "1",
														},
													},
												},
												{
													controlID = "Button_OneYearShare_Panel_btListEx_Button_btnListEx_Panel_left_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
													UUID = "5feb75c7_ca18_423c_9f95_87648ee3d394",
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
													name = "Button_OneYearShare",
													normal = "ui/mainLayer/new_ui_1/9small.png",
													pressed = "ui/mainLayer/new_ui_1/9small.png",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "1",
													touchAble = "True",
													UILayoutViewModel = 
													{
														PositionX = 165,
														PositionY = 43,
													},
													UItype = "Button",
													width = "60",
													ZOrder = "1",
													components = 
													{
														
														{
															controlID = "Image_lvli_Button_OneYearShare_Panel_btListEx_Button_btnListEx_Panel_left_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
															UUID = "553a3f72_2b0a_405a_aa60_9ffa4b794bc3",
															anchorPoint = "False",
															anchorPointX = "0.5",
															anchorPointY = "0.5",
															backGroundScale9Enable = "False",
															classname = "MEImage",
															dstBlendFunc = "771",
															height = "30",
															ignoreSize = "True",
															name = "Image_lvli",
															sizepercentx = "0",
															sizepercenty = "0",
															sizeType = "0",
															srcBlendFunc = "1",
															texturePath = "ui/common/news_small.png",
															touchAble = "False",
															UILayoutViewModel = 
															{
																PositionX = 20,
																PositionY = 19,
															},
															width = "30",
															ZOrder = "1",
														},
														{
															controlID = "Label_title_Button_OneYearShare_Panel_btListEx_Button_btnListEx_Panel_left_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
															UUID = "7ab06489_98ab_4eaa_91d3_37356c9622b4",
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
																StrokeColor = "#FF000000",
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
															text = "Resume",
															touchAble = "False",
															touchScaleEnable = "False",
															UILayoutViewModel = 
															{
																PositionX = 36,
																PositionY = -9,
															},
															width = "65",
															ZOrder = "1",
														},
													},
												},
												{
													controlID = "btn_zhuifan_Panel_btListEx_Button_btnListEx_Panel_left_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
													UUID = "f38df6ed_9920_47c6_b248_f0d9c0b335b4",
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
													name = "btn_zhuifan",
													normal = "ui/mainLayer/new_ui_1/btn_zhuifan.png",
													pressed = "ui/mainLayer/new_ui_1/btn_zhuifan.png",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "1",
													touchAble = "True",
													UILayoutViewModel = 
													{
														PositionX = 265,
														PositionY = 43,
													},
													UItype = "Button",
													width = "60",
													ZOrder = "1",
													components = 
													{
														
														{
															controlID = "Label_title_btn_zhuifan_Panel_btListEx_Button_btnListEx_Panel_left_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
															UUID = "e0eee95e_29f0_44ad_b47b_7ac6830917d6",
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
																StrokeColor = "#FF000000",
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
															text = "Watch Anime",
															touchAble = "False",
															touchScaleEnable = "False",
															UILayoutViewModel = 
															{
																PositionX = 43,
															},
															width = "110",
															ZOrder = "1",
														},
														{
															controlID = "Image_zhuifan_btn_zhuifan_Panel_btListEx_Button_btnListEx_Panel_left_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
															UUID = "42c654ae_891f_43ac_901d_ee069624c9a2",
															anchorPoint = "False",
															anchorPointX = "0.5",
															anchorPointY = "0.5",
															backGroundScale9Enable = "False",
															classname = "MEImage",
															dstBlendFunc = "771",
															height = "30",
															ignoreSize = "True",
															name = "Image_zhuifan",
															sizepercentx = "0",
															sizepercenty = "0",
															sizeType = "0",
															srcBlendFunc = "1",
															texturePath = "ui/common/news_small.png",
															touchAble = "False",
															UILayoutViewModel = 
															{
																PositionX = 18,
																PositionY = 11,
															},
															width = "30",
															ZOrder = "1",
														},
													},
												},
												{
													controlID = "btn_phone_Panel_btListEx_Button_btnListEx_Panel_left_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
													UUID = "1a750b1b_2956_47e1_bf0f_367a7b3af8a6",
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
													name = "btn_phone",
													normal = "ui/mainLayer/new_ui_1/btn_phone_small.png",
													pressed = "ui/mainLayer/new_ui_1/btn_phone_small.png",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "1",
													touchAble = "True",
													UILayoutViewModel = 
													{
														PositionX = 355,
														PositionY = 43,
													},
													UItype = "Button",
													width = "60",
													ZOrder = "1",
													components = 
													{
														
														{
															controlID = "Label_title_btn_phone_Panel_btListEx_Button_btnListEx_Panel_left_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
															UUID = "18a52a48_844b_4efa_97a7_e8afef3ddaa2",
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
																StrokeColor = "#FF000000",
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
															text = "Contacts",
															touchAble = "False",
															touchScaleEnable = "False",
															UILayoutViewModel = 
															{
																PositionX = 36,
																PositionY = -9,
															},
															width = "72",
															ZOrder = "1",
														},
														{
															controlID = "Image_zhuifan_btn_phone_Panel_btListEx_Button_btnListEx_Panel_left_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
															UUID = "1fdcf900_ceb8_446d_9fef_411417336bec",
															anchorPoint = "False",
															anchorPointX = "0.5",
															anchorPointY = "0.5",
															backGroundScale9Enable = "False",
															classname = "MEImage",
															dstBlendFunc = "771",
															height = "30",
															ignoreSize = "True",
															name = "Image_zhuifan",
															sizepercentx = "0",
															sizepercenty = "0",
															sizeType = "0",
															srcBlendFunc = "1",
															texturePath = "ui/common/news_small.png",
															touchAble = "False",
															UILayoutViewModel = 
															{
																PositionX = 18,
																PositionY = 11,
															},
															width = "30",
															ZOrder = "1",
														},
													},
												},
											},
										},
									},
								},
								{
									controlID = "Button_assistance_Panel_left_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
									UUID = "52589860_9528_47b5_bce8_ed3be9885614",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEButton",
									ClickHighLightEnabled = "True",
									dstBlendFunc = "771",
									flipX = "False",
									flipY = "False",
									height = "2",
									ignoreSize = "True",
									name = "Button_assistance",
									normal = "ui/mainLayer/new_ui/btn_friendHelp.png",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "True",
									UILayoutViewModel = 
									{
										PositionX = 180,
										PositionY = 433,
										LeftPositon = 26,
										TopPosition = 87,
										relativeToName = "Panel",
									},
									UItype = "Button",
									width = "2",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "Label_title_Button_assistance_Panel_left_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
											UUID = "e571cfa4_798d_4a31_9709_a5e0913a3460",
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
												StrokeColor = "#FF000000",
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
											text = "친구의 도움",
											touchAble = "False",
											touchScaleEnable = "False",
											UILayoutViewModel = 
											{
												PositionY = -37,
											},
											visible = "False",
											width = "97",
											ZOrder = "1",
										},
										{
											controlID = "Image_assistance_Button_assistance_Panel_left_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
											UUID = "1bf23590_a4e1_4962_a11f_eaa605eb9a4f",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											classname = "MEImage",
											dstBlendFunc = "771",
											height = "30",
											ignoreSize = "True",
											name = "Image_assistance",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											texturePath = "ui/mainui/mail_logo.png",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionY = 10,
											},
											visible = "False",
											width = "30",
											ZOrder = "1",
										},
										{
											controlID = "Image_assistanceTip_Button_assistance_Panel_left_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
											UUID = "e57fa071_8fcb_48dd_81d0_c4d8cb21bfac",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											classname = "MEImage",
											dstBlendFunc = "771",
											height = "30",
											ignoreSize = "True",
											name = "Image_assistanceTip",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											texturePath = "ui/common/news_small.png",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 18,
												PositionY = 11,
											},
											visible = "False",
											width = "30",
											ZOrder = "1",
										},
										{
											controlID = "spine_status_Button_assistance_Panel_left_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
											UUID = "6083233c_7015_481b_8208_a22d418d3ad9",
											classname = "MESpine",
											dstBlendFunc = "771",
											name = "spine_status",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											spineModel = 
											{
												SpinePath = "effect/HFhaoyouzhulianniu/HFhaoyouzhulianniu",
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
												
											},
											ZOrder = "1",
										},
									},
								},
							},
						},
						{
							controlID = "Panel_middle_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
							UUID = "fe6d6ecf_0058_45f0_ab09_ffb0905b8dc0",
							anchorPoint = "False",
							anchorPointX = "0",
							anchorPointY = "0",
							backGroundScale9Enable = "False",
							bgColorOpacity = "100",
							bIsOpenClipping = "False",
							classname = "MEPanel",
							colorType = "0;SingleColor:#FFFF0000;GraduallyChangingColorStart:#FFFFFFFF;GraduallyChangingColorEnd:#FFFFFFFF;vectorX:0;vectorY:0",
							DesignHeight = "640",
							DesignType = "0",
							DesignWidth = "960",
							dstBlendFunc = "771",
							height = "640",
							ignoreSize = "False",
							name = "Panel_middle",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							touchAble = "False",
							UILayoutViewModel = 
							{
								PositionX = 1,
								PositionY = 1,
								relativeToName = "Panel",
							},
							uipanelviewmodel = 
							{
								Layout="Absolute",
								nType = "0"
							},
							visible = "False",
							width = "1136",
							ZOrder = "10",
							components = 
							{
								
								{
									controlID = "Panel_camera_Panel_middle_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
									UUID = "6fd9d7a3_6748_450f_bf23_e8a6b60579fc",
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
									name = "Panel_camera",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "True",
									UILayoutViewModel = 
									{
										PositionX = 67,
										PositionY = -46,
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
						{
							controlID = "Panel_ai_chat_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
							UUID = "cfd368e1_5626_4e85_a610_7afb6cf35d5c",
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
							height = "134",
							ignoreSize = "False",
							name = "Panel_ai_chat",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							touchAble = "True",
							UILayoutViewModel = 
							{
								PositionX = 568,
								PositionY = 392,
							},
							uipanelviewmodel = 
							{
								Layout="Absolute",
								nType = "0"
							},
							visible = "False",
							width = "872",
							ZOrder = "11",
							components = 
							{
								
								{
									controlID = "Image_ai_chat_Panel_ai_chat_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
									UUID = "9a5f3748_b956_4f15_8eda_179872cdfda6",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "134",
									ignoreSize = "True",
									name = "Image_ai_chat",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/mainLayer/new_ui/ai_tip/001.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										
									},
									width = "872",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "Image_ai_icon_Image_ai_chat_Panel_ai_chat_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
											UUID = "b3420637_2c2a_4b22_b7ce_262c84e4fbec",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											classname = "MEImage",
											dstBlendFunc = "771",
											height = "32",
											ignoreSize = "True",
											name = "Image_ai_icon",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											texturePath = "ui/mainLayer/new_ui/ai_tip/002.png",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = -394,
												PositionY = 41,
											},
											width = "32",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "Label_ai_tip1_Image_ai_icon_Image_ai_chat_Panel_ai_chat_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
													UUID = "165def6f_4e24_45a2_8c52_d7cce940dd71",
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
													fontSize = "22",
													fontStroke = 
													{
														IsStroke = false,
														StrokeColor = "#FFE6E6E6",
														StrokeSize = 1,
													},
													height = "25",
													ignoreSize = "True",
													name = "Label_ai_tip1",
													nTextAlign = "1",
													nTextHAlign = "1",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "770",
													text = "Message",
													touchAble = "False",
													touchScaleEnable = "False",
													UILayoutViewModel = 
													{
														PositionX = 25,
													},
													width = "76",
													ZOrder = "1",
												},
												{
													controlID = "Label_ai_tip2_Image_ai_icon_Image_ai_chat_Panel_ai_chat_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
													UUID = "08c5a5ce_ef66_4b7d_a5ff_3a7260479e4a",
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
													fontSize = "22",
													fontStroke = 
													{
														IsStroke = false,
														StrokeColor = "#FFE6E6E6",
														StrokeSize = 1,
													},
													height = "25",
													ignoreSize = "True",
													name = "Label_ai_tip2",
													nTextAlign = "1",
													nTextHAlign = "1",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "770",
													text = "And now,",
													touchAble = "False",
													touchScaleEnable = "False",
													UILayoutViewModel = 
													{
														PositionX = 817,
													},
													width = "85",
													ZOrder = "1",
												},
											},
										},
									},
								},
								{
									controlID = "Image_head_bord_Panel_ai_chat_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
									UUID = "59af08e2_b3fa_4983_89dd_96ff4b952a36",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "68",
									ignoreSize = "True",
									name = "Image_head_bord",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/mainLayer/new_ui/ai_tip/003.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = -373,
										PositionY = -20,
									},
									width = "68",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "ClippingNode_player_Image_head_bord_Panel_ai_chat_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
											UUID = "be3961ac_d166_42f8_8e67_4b41635a0afa",
											alphaThreshold = "0.65",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											classname = "MEClippingNode",
											clipNodeX = "0",
											clipNodeY = "0",
											dstBlendFunc = "771",
											height = "0",
											ignoreSize = "False",
											name = "ClippingNode_player",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											stencilPath = "ui/mainLayer/new_ui/ai_tip/004.png",
											touchAble = "False",
											UILayoutViewModel = 
											{
												
											},
											width = "0",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "Image_head_ClippingNode_player_Image_head_bord_Panel_ai_chat_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
													UUID = "ad10bfba_7648_43a1_9211_d386bcd8d9af",
													anchorPoint = "False",
													anchorPointX = "1",
													anchorPointY = "0.5",
													backGroundScale9Enable = "False",
													classname = "MEImage",
													dstBlendFunc = "771",
													height = "92",
													ignoreSize = "True",
													name = "Image_head",
													scaleX = "0.7",
													scaleY = "0.7",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "1",
													texturePath = "icon/hero/face/1108011.png",
													touchAble = "False",
													UILayoutViewModel = 
													{
														PositionX = 31,
													},
													width = "156",
													ZOrder = "1",
												},
											},
										},
									},
								},
								{
									controlID = "Label_hero_name_Panel_ai_chat_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
									UUID = "8c795aff_6ab0_4ca5_bc8f_331371da3352",
									anchorPoint = "False",
									anchorPointX = "0",
									anchorPointY = "0.5",
									classname = "MELabel",
									compPath = "luacomponents.common.MEIconLabel",
									dstBlendFunc = "771",
									FontColor = "#FF49557F",
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
									height = "0",
									ignoreSize = "False",
									name = "Label_hero_name",
									nTextAlign = "1",
									nTextHAlign = "0",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "Tohka",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionX = -326,
										PositionY = -3,
									},
									width = "749",
									ZOrder = "1",
								},
								{
									controlID = "Panel_ai_mask_Panel_ai_chat_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
									UUID = "027f1049_be97_4864_ab48_c6f70e792431",
									anchorPoint = "False",
									anchorPointX = "0",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									bgColorOpacity = "50",
									bIsOpenClipping = "True",
									classname = "MEPanel",
									colorType = "0;SingleColor:#FFFF0000;GraduallyChangingColorStart:#FFFFFFFF;GraduallyChangingColorEnd:#FFFFFFFF;vectorX:0;vectorY:0",
									DesignHeight = "640",
									DesignType = "0",
									DesignWidth = "960",
									dstBlendFunc = "771",
									height = "30",
									ignoreSize = "False",
									name = "Panel_ai_mask",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = -324,
										PositionY = -36,
									},
									uipanelviewmodel = 
									{
										Layout="Absolute",
										nType = "0"
									},
									width = "700",
									ZOrder = "1",
								},
								{
									controlID = "Label_ai_message_Panel_ai_chat_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
									UUID = "555b9cc5_257f_4e15_95b3_b2a722a0ec16",
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
									fontSize = "24",
									fontStroke = 
									{
										IsStroke = false,
										StrokeColor = "#FFE6E6E6",
										StrokeSize = 1,
									},
									height = "27",
									ignoreSize = "True",
									name = "Label_ai_message",
									nTextAlign = "1",
									nTextHAlign = "1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "TextLable",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionX = 424,
										PositionY = -43,
									},
									width = "97",
									ZOrder = "1",
								},
							},
						},
						{
							controlID = "Image_switch_role_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
							UUID = "cb3002e3_dd91_4ee4_adc5_bd1e0cfe4f52",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							backGroundScale9Enable = "False",
							classname = "MEImage",
							dstBlendFunc = "771",
							height = "64",
							ignoreSize = "True",
							name = "Image_switch_role",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							touchAble = "False",
							UILayoutViewModel = 
							{
								PositionX = -16,
								PositionY = -91,
							},
							width = "64",
							ZOrder = "1",
						},
						{
							controlID = "Panel_black_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
							UUID = "37887c64_543c_4dd5_a103_7c4f1d69beb2",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							backGroundScale9Enable = "False",
							bgColorOpacity = "255",
							bIsOpenClipping = "False",
							classname = "MEPanel",
							colorType = "1;SingleColor:#FF000000;GraduallyChangingColorStart:#FFFFFFFF;GraduallyChangingColorEnd:#FFFFFFFF;vectorX:0;vectorY:0",
							DesignHeight = "640",
							DesignType = "0",
							DesignWidth = "960",
							dstBlendFunc = "771",
							height = "400",
							ignoreSize = "False",
							name = "Panel_black",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							touchAble = "False",
							UILayoutViewModel = 
							{
								PositionX = 568,
								PositionY = 320,
								IsPercent = true,
								PercentX = 50,
								PercentY = 50,
							},
							uipanelviewmodel = 
							{
								Layout="Absolute",
								nType = "0"
							},
							width = "400",
							ZOrder = "4",
						},
						{
							controlID = "Spine_changeEffect_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
							UUID = "6057c415_9b3b_40c7_8889_f40578926c03",
							classname = "MESpine",
							dstBlendFunc = "771",
							name = "Spine_changeEffect",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							spineModel = 
							{
								SpinePath = "effect/effect_WK_zhuanchang/effect_WK_zhuanchang",
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
								PositionX = 568,
								PositionY = 320,
								IsPercent = true,
								PercentX = 50,
								PercentY = 50,
							},
							visible = "False",
							ZOrder = "12",
						},
						{
							controlID = "PrefabGift_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
							UUID = "46e948c3_9568_4d05_968b_41df94a2ecbf",
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
							height = "80",
							ignoreSize = "False",
							name = "PrefabGift",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							touchAble = "False",
							UILayoutViewModel = 
							{
								PositionX = -55,
								PositionY = -338,
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
									controlID = "Button_Gift_PrefabGift_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
									UUID = "fb0c60ed_ac7f_4d6f_aa76_57802c068179",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEButton",
									ClickHighLightEnabled = "True",
									dstBlendFunc = "771",
									flipX = "False",
									flipY = "False",
									height = "80",
									ignoreSize = "True",
									name = "Button_Gift",
									normal = "ui/recharge/gifts/giftIcon/regression.png",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "True",
									UILayoutViewModel = 
									{
										PositionX = -2,
										PositionY = 5,
									},
									UItype = "Button",
									width = "73",
									ZOrder = "1",
								},
								{
									controlID = "Name_PrefabGift_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
									UUID = "4ce54b29_31be_497f_961d_56a1b5887943",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									classname = "MELabel",
									compPath = "luacomponents.common.MEIconLabel",
									dstBlendFunc = "771",
									FontColor = "#FFCCF1FA",
									fontName = "font/MFLiHei_Noncommercial.ttf",
									fontShadow = 
									{
										IsShadow = false,
										ShadowColor = "#FFFFFFFF",
										ShadowAlpha = 255,
										OffsetX = 0,
										OffsetY = 0,
									},
									fontSize = "16",
									fontStroke = 
									{
										IsStroke = true,
										StrokeColor = "#FF49557F",
										StrokeSize = 1,
									},
									height = "20",
									ignoreSize = "True",
									name = "Name",
									nTextAlign = "1",
									nTextHAlign = "1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "Christmas Pack",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionX = -2,
										PositionY = -31,
										relativeToName = "Panel",
									},
									width = "132",
									ZOrder = "1",
								},
								{
									controlID = "TimeCount_PrefabGift_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
									UUID = "d95b8f67_36b7_4f4c_be3c_a4e3163c8262",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									classname = "MELabel",
									compPath = "luacomponents.common.MEIconLabel",
									dstBlendFunc = "771",
									FontColor = "#FFFFE21F",
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
										IsStroke = true,
										StrokeColor = "#FF875635",
										StrokeSize = 1,
									},
									height = "18",
									ignoreSize = "True",
									name = "TimeCount",
									nTextAlign = "1",
									nTextHAlign = "1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "55:20:10",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionX = -1,
										PositionY = -13,
									},
									width = "54",
									ZOrder = "1",
								},
							},
						},
						{
							controlID = "GiftRoot_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
							UUID = "0133b6dc_953b_4d39_be0d_ed1c348fd11f",
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
							name = "GiftRoot",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							touchAble = "False",
							UILayoutViewModel = 
							{
								PositionX = 176,
								PositionY = 535,
							},
							uipanelviewmodel = 
							{
								Layout="Absolute",
								nType = "0"
							},
							width = "50",
							ZOrder = "1",
						},
					},
				},
				{
					controlID = "panel_touch_Panel-DefaultMainLayer_Layer1_MainScene_Game",
					UUID = "558e95e3_5ce3_4e58_b73e_2bbe3c900c56",
					anchorPoint = "False",
					anchorPointX = "0",
					anchorPointY = "0",
					backGroundScale9Enable = "False",
					bgColorOpacity = "100",
					bIsOpenClipping = "False",
					classname = "MEPanel",
					colorType = "1;SingleColor:#FF000000;GraduallyChangingColorStart:#FFFFFFFF;GraduallyChangingColorEnd:#FFFFFFFF;vectorX:0;vectorY:0",
					DesignHeight = "640",
					DesignType = "0",
					DesignWidth = "960",
					dstBlendFunc = "771",
					height = "640",
					ignoreSize = "False",
					name = "panel_touch",
					sizepercentx = "100",
					sizepercenty = "100",
					sizeType = "1",
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
					visible = "False",
					width = "1386",
					ZOrder = "1",
					components = 
					{
						
						{
							controlID = "img_menu_bg_panel_touch_Panel-DefaultMainLayer_Layer1_MainScene_Game",
							UUID = "1db1974f_b5df_47da_b177_acd0ba9c2126",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0",
							backGroundScale9Enable = "False",
							classname = "MEImage",
							dstBlendFunc = "771",
							height = "2",
							ignoreSize = "True",
							name = "img_menu_bg",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							texturePath = "ui/mainLayer/new_ui/img_sub_bg.png",
							touchAble = "False",
							UILayoutViewModel = 
							{
								PositionX = 884,
								PositionY = 81,
							},
							width = "2",
							ZOrder = "1",
							components = 
							{
								
								{
									controlID = "panel_zhaohuan_img_menu_bg_panel_touch_Panel-DefaultMainLayer_Layer1_MainScene_Game",
									UUID = "d23860df_2919_4a91_b9b8_8e579997f903",
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
									height = "108",
									ignoreSize = "False",
									name = "panel_zhaohuan",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionY = 12,
									},
									uipanelviewmodel = 
									{
										Layout="Absolute",
										nType = "0"
									},
									width = "258",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "btn_jl_panel_zhaohuan_img_menu_bg_panel_touch_Panel-DefaultMainLayer_Layer1_MainScene_Game",
											UUID = "349f779d_80c7_42a4_b699_037fa2714c93",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											classname = "MEButton",
											ClickHighLightEnabled = "True",
											dstBlendFunc = "771",
											flipX = "False",
											flipY = "False",
											height = "2",
											ignoreSize = "True",
											name = "btn_jl",
											normal = "ui/mainLayer/new_ui/img_zh_a.png",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "True",
											UILayoutViewModel = 
											{
												PositionX = -68,
												PositionY = 53,
											},
											UItype = "Button",
											width = "2",
											ZOrder = "1",
										},
										{
											controlID = "btn_zd_panel_zhaohuan_img_menu_bg_panel_touch_Panel-DefaultMainLayer_Layer1_MainScene_Game",
											UUID = "ec4f9601_b2eb_4dc0_b4b1_2cc407155e5f",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											classname = "MEButton",
											ClickHighLightEnabled = "True",
											dstBlendFunc = "771",
											flipX = "False",
											flipY = "False",
											height = "2",
											ignoreSize = "True",
											name = "btn_zd",
											normal = "ui/mainLayer/new_ui/img_zh_b.png",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "True",
											UILayoutViewModel = 
											{
												PositionX = 68,
												PositionY = 56,
											},
											UItype = "Button",
											width = "2",
											ZOrder = "1",
										},
									},
								},
								{
									controlID = "panel_shop_img_menu_bg_panel_touch_Panel-DefaultMainLayer_Layer1_MainScene_Game",
									UUID = "87771783_2b8c_43a0_9956_d2bfb4144738",
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
									height = "108",
									ignoreSize = "False",
									name = "panel_shop",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionY = 12,
									},
									uipanelviewmodel = 
									{
										Layout="Absolute",
										nType = "0"
									},
									width = "258",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "btn_shop_a_panel_shop_img_menu_bg_panel_touch_Panel-DefaultMainLayer_Layer1_MainScene_Game",
											UUID = "1b6eb496_76ff_47f8_80f5_0560e1d2f370",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											classname = "MEButton",
											ClickHighLightEnabled = "True",
											dstBlendFunc = "771",
											flipX = "False",
											flipY = "False",
											height = "2",
											ignoreSize = "True",
											name = "btn_shop_a",
											normal = "ui/mainLayer/new_ui/btn_shop_a.png",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "True",
											UILayoutViewModel = 
											{
												PositionX = -68,
												PositionY = 53,
											},
											UItype = "Button",
											width = "2",
											ZOrder = "1",
										},
										{
											controlID = "btn_shop_b_panel_shop_img_menu_bg_panel_touch_Panel-DefaultMainLayer_Layer1_MainScene_Game",
											UUID = "bc55853f_4a47_4e79_863e_e14faf60e446",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											classname = "MEButton",
											ClickHighLightEnabled = "True",
											dstBlendFunc = "771",
											flipX = "False",
											flipY = "False",
											height = "2",
											ignoreSize = "True",
											name = "btn_shop_b",
											normal = "ui/mainLayer/new_ui/btn_shop_b.png",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "True",
											UILayoutViewModel = 
											{
												PositionX = 68,
												PositionY = 53,
											},
											UItype = "Button",
											width = "2",
											ZOrder = "1",
										},
									},
								},
								{
									controlID = "panel_recharge_img_menu_bg_panel_touch_Panel-DefaultMainLayer_Layer1_MainScene_Game",
									UUID = "995a4e9e_4ba1_471e_b178_91de83d7a1e3",
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
									height = "108",
									ignoreSize = "False",
									name = "panel_recharge",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionY = 12,
									},
									uipanelviewmodel = 
									{
										Layout="Absolute",
										nType = "0"
									},
									visible = "False",
									width = "258",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "btn_recharge_a_panel_recharge_img_menu_bg_panel_touch_Panel-DefaultMainLayer_Layer1_MainScene_Game",
											UUID = "7b4909b2_983f_4bd9_ba6f_828c61972132",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											classname = "MEButton",
											ClickHighLightEnabled = "True",
											dstBlendFunc = "771",
											flipX = "False",
											flipY = "False",
											height = "2",
											ignoreSize = "True",
											name = "btn_recharge_a",
											normal = "ui/mainLayer/new_ui/btn_recharge_a.png",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "True",
											UILayoutViewModel = 
											{
												PositionX = -82,
												PositionY = 53,
											},
											UItype = "Button",
											width = "2",
											ZOrder = "1",
										},
										{
											controlID = "btn_recharge_b_panel_recharge_img_menu_bg_panel_touch_Panel-DefaultMainLayer_Layer1_MainScene_Game",
											UUID = "be0f00b8_ee80_4a62_9522_cfb6b5c2aa7b",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											classname = "MEButton",
											ClickHighLightEnabled = "True",
											dstBlendFunc = "771",
											flipX = "False",
											flipY = "False",
											height = "2",
											ignoreSize = "True",
											name = "btn_recharge_b",
											normal = "ui/mainLayer/new_ui/btn_recharge_b.png",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "True",
											UILayoutViewModel = 
											{
												PositionY = 53,
											},
											UItype = "Button",
											width = "2",
											ZOrder = "1",
										},
										{
											controlID = "btn_recharge_c_panel_recharge_img_menu_bg_panel_touch_Panel-DefaultMainLayer_Layer1_MainScene_Game",
											UUID = "c96c5678_3e11_4f04_a2ea_d25b3542389b",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											classname = "MEButton",
											ClickHighLightEnabled = "True",
											dstBlendFunc = "771",
											flipX = "False",
											flipY = "False",
											height = "2",
											ignoreSize = "True",
											name = "btn_recharge_c",
											normal = "ui/mainLayer/new_ui/btn_recharge_c.png",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "True",
											UILayoutViewModel = 
											{
												PositionX = 82,
												PositionY = 53,
											},
											UItype = "Button",
											width = "2",
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
		Action0 = 
		{
			name = "Action0",
			FPS = 30,
			duration = 0.7,
			looptimes = 1,
			autoplay = false,
			{
				id = "Image_top_bar_bg_Panel_top_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
				name = "Panel.Panel_base.Panel_top.Image_top_bar_bg",
				frames = 
				{
					
					{
						alpha = 0,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 0,
						percentenable = false,
						perposition = 
						{
							x=0,
							y=0,
						},
						position = 
						{
							x=568,
							y=-25,
						},
						rotate = 0,
						scale = 
						{
							x=1,
							y=1,
						},
						srcBlendFunc = 1,
						tweenToNext = true,
						visible = true,
					},
					{
						alpha = 255,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 5,
						percentenable = false,
						perposition = 
						{
							x=89.52,
							y=-40,
						},
						position = 
						{
							x=1016,
							y=-32,
						},
						rotate = 0,
						scale = 
						{
							x=1,
							y=1,
						},
						srcBlendFunc = 1,
						tweenToNext = true,
						visible = true,
					},
				},
			},
			{
				id = "Image_camera_Panel_top_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
				name = "Panel.Panel_base.Panel_top.Image_camera",
				frames = 
				{
					
					{
						alpha = 0,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 0,
						percentenable = false,
						perposition = 
						{
							x=0,
							y=0,
						},
						position = 
						{
							x=344,
							y=-12,
						},
						rotate = 0,
						scale = 
						{
							x=1,
							y=1,
						},
						srcBlendFunc = 1,
						tweenToNext = true,
						visible = true,
					},
					{
						alpha = 0,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 4,
						percentenable = false,
						perposition = 
						{
							x=0,
							y=0,
						},
						position = 
						{
							x=344,
							y=-12,
						},
						rotate = 0,
						scale = 
						{
							x=1,
							y=1,
						},
						srcBlendFunc = 1,
						tweenToNext = true,
						visible = true,
					},
					{
						alpha = 255,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 8,
						percentenable = false,
						perposition = 
						{
							x=90.23,
							y=-36.25,
						},
						position = 
						{
							x=1025,
							y=-28,
						},
						rotate = 0,
						scale = 
						{
							x=1,
							y=1,
						},
						srcBlendFunc = 1,
						tweenToNext = true,
						visible = true,
					},
				},
			},
			{
				id = "Image_tili_bg_top_part2_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
				name = "Panel.Panel_base.top_part2.Image_tili_bg",
				frames = 
				{
					
					{
						alpha = 0,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 0,
						percentenable = false,
						perposition = 
						{
							x=0,
							y=0,
						},
						position = 
						{
							x=579,
							y=-15,
						},
						rotate = 0,
						scale = 
						{
							x=1,
							y=1,
						},
						srcBlendFunc = 1,
						tweenToNext = true,
						visible = true,
					},
					{
						alpha = 0,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 5,
						percentenable = false,
						perposition = 
						{
							x=0,
							y=0,
						},
						position = 
						{
							x=579,
							y=-15,
						},
						rotate = 0,
						scale = 
						{
							x=1,
							y=1,
						},
						srcBlendFunc = 1,
						tweenToNext = true,
						visible = true,
					},
					{
						alpha = 255,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 9,
						percentenable = false,
						perposition = 
						{
							x=0,
							y=0,
						},
						position = 
						{
							x=579,
							y=-35,
						},
						rotate = 0,
						scale = 
						{
							x=1,
							y=1,
						},
						srcBlendFunc = 1,
						tweenToNext = true,
						visible = true,
					},
				},
			},
			{
				id = "Image_tili_top_part2_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
				name = "Panel.Panel_base.top_part2.Image_tili",
				frames = 
				{
					
					{
						alpha = 0,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 0,
						percentenable = false,
						perposition = 
						{
							x=0,
							y=0,
						},
						position = 
						{
							x=523,
							y=-17,
						},
						rotate = 0,
						scale = 
						{
							x=1,
							y=1,
						},
						srcBlendFunc = 1,
						tweenToNext = true,
						visible = true,
					},
					{
						alpha = 0,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 5,
						percentenable = false,
						perposition = 
						{
							x=0,
							y=0,
						},
						position = 
						{
							x=523,
							y=-17,
						},
						rotate = 0,
						scale = 
						{
							x=1,
							y=1,
						},
						srcBlendFunc = 1,
						tweenToNext = true,
						visible = true,
					},
					{
						alpha = 255,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 9,
						percentenable = false,
						perposition = 
						{
							x=0,
							y=0,
						},
						position = 
						{
							x=523,
							y=-37,
						},
						rotate = 0,
						scale = 
						{
							x=1,
							y=1,
						},
						srcBlendFunc = 1,
						tweenToNext = true,
						visible = true,
					},
				},
			},
			{
				id = "Label_tili_count_top_part2_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
				name = "Panel.Panel_base.top_part2.Label_tili_count",
				frames = 
				{
					
					{
						alpha = 0,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 0,
						percentenable = false,
						perposition = 
						{
							x=54.93,
							y=-47.5,
						},
						position = 
						{
							x=624,
							y=-18,
						},
						rotate = 0,
						scale = 
						{
							x=1,
							y=1,
						},
						srcBlendFunc = 770,
						tweenToNext = true,
						visible = true,
					},
					{
						alpha = 0,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 5,
						percentenable = false,
						perposition = 
						{
							x=54.93,
							y=-47.5,
						},
						position = 
						{
							x=624,
							y=-18,
						},
						rotate = 0,
						scale = 
						{
							x=1,
							y=1,
						},
						srcBlendFunc = 770,
						tweenToNext = true,
						visible = true,
					},
					{
						alpha = 255,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 9,
						percentenable = false,
						perposition = 
						{
							x=54.93,
							y=-47.5,
						},
						position = 
						{
							x=624,
							y=-38,
						},
						rotate = 0,
						scale = 
						{
							x=1,
							y=1,
						},
						srcBlendFunc = 770,
						tweenToNext = true,
						visible = true,
					},
				},
			},
			{
				id = "Button_add_tili_top_part2_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
				name = "Panel.Panel_base.top_part2.Button_add_tili",
				frames = 
				{
					
					{
						alpha = 0,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 0,
						percentenable = false,
						perposition = 
						{
							x=57.31,
							y=-43.75,
						},
						position = 
						{
							x=651,
							y=-15,
						},
						rotate = 0,
						scale = 
						{
							x=1,
							y=1,
						},
						srcBlendFunc = 1,
						tweenToNext = true,
						visible = true,
					},
					{
						alpha = 0,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 5,
						percentenable = false,
						perposition = 
						{
							x=57.31,
							y=-43.75,
						},
						position = 
						{
							x=651,
							y=-15,
						},
						rotate = 0,
						scale = 
						{
							x=1,
							y=1,
						},
						srcBlendFunc = 1,
						tweenToNext = true,
						visible = true,
					},
					{
						alpha = 255,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 9,
						percentenable = false,
						perposition = 
						{
							x=57.31,
							y=-43.75,
						},
						position = 
						{
							x=651,
							y=-35,
						},
						rotate = 0,
						scale = 
						{
							x=1,
							y=1,
						},
						srcBlendFunc = 1,
						tweenToNext = true,
						visible = true,
					},
				},
			},
			{
				id = "Image_coin_bg_top_part2_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
				name = "Panel.Panel_base.top_part2.Image_coin_bg",
				frames = 
				{
					
					{
						alpha = 0,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 0,
						percentenable = false,
						perposition = 
						{
							x=0,
							y=0,
						},
						position = 
						{
							x=777,
							y=-15,
						},
						rotate = 0,
						scale = 
						{
							x=1,
							y=1,
						},
						srcBlendFunc = 1,
						tweenToNext = true,
						visible = true,
					},
					{
						alpha = 0,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 6,
						percentenable = false,
						perposition = 
						{
							x=0,
							y=0,
						},
						position = 
						{
							x=777,
							y=-15,
						},
						rotate = 0,
						scale = 
						{
							x=1,
							y=1,
						},
						srcBlendFunc = 1,
						tweenToNext = true,
						visible = true,
					},
					{
						alpha = 255,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 10,
						percentenable = false,
						perposition = 
						{
							x=0,
							y=0,
						},
						position = 
						{
							x=777,
							y=-35,
						},
						rotate = 0,
						scale = 
						{
							x=1,
							y=1,
						},
						srcBlendFunc = 1,
						tweenToNext = true,
						visible = true,
					},
				},
			},
			{
				id = "Image_coin_top_part2_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
				name = "Panel.Panel_base.top_part2.Image_coin",
				frames = 
				{
					
					{
						alpha = 0,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 0,
						percentenable = false,
						perposition = 
						{
							x=0,
							y=0,
						},
						position = 
						{
							x=718,
							y=-16,
						},
						rotate = 0,
						scale = 
						{
							x=1,
							y=1,
						},
						srcBlendFunc = 1,
						tweenToNext = true,
						visible = true,
					},
					{
						alpha = 0,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 6,
						percentenable = false,
						perposition = 
						{
							x=0,
							y=0,
						},
						position = 
						{
							x=718,
							y=-16,
						},
						rotate = 0,
						scale = 
						{
							x=1,
							y=1,
						},
						srcBlendFunc = 1,
						tweenToNext = true,
						visible = true,
					},
					{
						alpha = 255,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 10,
						percentenable = false,
						perposition = 
						{
							x=0,
							y=0,
						},
						position = 
						{
							x=718,
							y=-36,
						},
						rotate = 0,
						scale = 
						{
							x=1,
							y=1,
						},
						srcBlendFunc = 1,
						tweenToNext = true,
						visible = true,
					},
				},
			},
			{
				id = "Label_coin_count_top_part2_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
				name = "Panel.Panel_base.top_part2.Label_coin_count",
				frames = 
				{
					
					{
						alpha = 0,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 0,
						percentenable = false,
						perposition = 
						{
							x=72.36,
							y=-46.25,
						},
						position = 
						{
							x=822,
							y=-17,
						},
						rotate = 0,
						scale = 
						{
							x=1,
							y=1,
						},
						srcBlendFunc = 770,
						tweenToNext = true,
						visible = true,
					},
					{
						alpha = 0,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 6,
						percentenable = false,
						perposition = 
						{
							x=72.36,
							y=-46.25,
						},
						position = 
						{
							x=822,
							y=-17,
						},
						rotate = 0,
						scale = 
						{
							x=1,
							y=1,
						},
						srcBlendFunc = 770,
						tweenToNext = true,
						visible = true,
					},
					{
						alpha = 255,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 10,
						percentenable = false,
						perposition = 
						{
							x=72.36,
							y=-46.25,
						},
						position = 
						{
							x=822,
							y=-37,
						},
						rotate = 0,
						scale = 
						{
							x=1,
							y=1,
						},
						srcBlendFunc = 770,
						tweenToNext = true,
						visible = true,
					},
				},
			},
			{
				id = "Button_add_coin_top_part2_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
				name = "Panel.Panel_base.top_part2.Button_add_coin",
				frames = 
				{
					
					{
						alpha = 0,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 0,
						percentenable = false,
						perposition = 
						{
							x=74.65,
							y=-43.75,
						},
						position = 
						{
							x=848,
							y=-15,
						},
						rotate = 0,
						scale = 
						{
							x=1,
							y=1,
						},
						srcBlendFunc = 1,
						tweenToNext = true,
						visible = true,
					},
					{
						alpha = 0,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 6,
						percentenable = false,
						perposition = 
						{
							x=74.65,
							y=-43.75,
						},
						position = 
						{
							x=848,
							y=-15,
						},
						rotate = 0,
						scale = 
						{
							x=1,
							y=1,
						},
						srcBlendFunc = 1,
						tweenToNext = true,
						visible = true,
					},
					{
						alpha = 255,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 10,
						percentenable = false,
						perposition = 
						{
							x=74.65,
							y=-43.75,
						},
						position = 
						{
							x=848,
							y=-35,
						},
						rotate = 0,
						scale = 
						{
							x=1,
							y=1,
						},
						srcBlendFunc = 1,
						tweenToNext = true,
						visible = true,
					},
				},
			},
			{
				id = "Image_zuan_bg_top_part2_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
				name = "Panel.Panel_base.top_part2.Image_zuan_bg",
				frames = 
				{
					
					{
						alpha = 0,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 0,
						percentenable = false,
						perposition = 
						{
							x=0,
							y=0,
						},
						position = 
						{
							x=970,
							y=-15,
						},
						rotate = 0,
						scale = 
						{
							x=1,
							y=1,
						},
						srcBlendFunc = 1,
						tweenToNext = true,
						visible = true,
					},
					{
						alpha = 0,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 7,
						percentenable = false,
						perposition = 
						{
							x=0,
							y=0,
						},
						position = 
						{
							x=970,
							y=-15,
						},
						rotate = 0,
						scale = 
						{
							x=1,
							y=1,
						},
						srcBlendFunc = 1,
						tweenToNext = true,
						visible = true,
					},
					{
						alpha = 255,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 11,
						percentenable = false,
						perposition = 
						{
							x=0,
							y=0,
						},
						position = 
						{
							x=970,
							y=-35,
						},
						rotate = 0,
						scale = 
						{
							x=1,
							y=1,
						},
						srcBlendFunc = 1,
						tweenToNext = true,
						visible = true,
					},
				},
			},
			{
				id = "Image_zuan_top_part2_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
				name = "Panel.Panel_base.top_part2.Image_zuan",
				frames = 
				{
					
					{
						alpha = 0,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 0,
						percentenable = false,
						perposition = 
						{
							x=0,
							y=0,
						},
						position = 
						{
							x=914,
							y=-17,
						},
						rotate = 0,
						scale = 
						{
							x=1,
							y=1,
						},
						srcBlendFunc = 1,
						tweenToNext = true,
						visible = true,
					},
					{
						alpha = 0,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 7,
						percentenable = false,
						perposition = 
						{
							x=0,
							y=0,
						},
						position = 
						{
							x=914,
							y=-17,
						},
						rotate = 0,
						scale = 
						{
							x=1,
							y=1,
						},
						srcBlendFunc = 1,
						tweenToNext = true,
						visible = true,
					},
					{
						alpha = 255,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 11,
						percentenable = false,
						perposition = 
						{
							x=0,
							y=0,
						},
						position = 
						{
							x=914,
							y=-37,
						},
						rotate = 0,
						scale = 
						{
							x=1,
							y=1,
						},
						srcBlendFunc = 1,
						tweenToNext = true,
						visible = true,
					},
				},
			},
			{
				id = "Label_zuan_count_top_part2_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
				name = "Panel.Panel_base.top_part2.Label_zuan_count",
				frames = 
				{
					
					{
						alpha = 0,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 0,
						percentenable = false,
						perposition = 
						{
							x=89.52,
							y=-46.25,
						},
						position = 
						{
							x=1017,
							y=-17,
						},
						rotate = 0,
						scale = 
						{
							x=1,
							y=1,
						},
						srcBlendFunc = 770,
						tweenToNext = true,
						visible = true,
					},
					{
						alpha = 0,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 7,
						percentenable = false,
						perposition = 
						{
							x=89.52,
							y=-46.25,
						},
						position = 
						{
							x=1017,
							y=-17,
						},
						rotate = 0,
						scale = 
						{
							x=1,
							y=1,
						},
						srcBlendFunc = 770,
						tweenToNext = true,
						visible = true,
					},
					{
						alpha = 255,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 11,
						percentenable = false,
						perposition = 
						{
							x=89.52,
							y=-46.25,
						},
						position = 
						{
							x=1017,
							y=-37,
						},
						rotate = 0,
						scale = 
						{
							x=1,
							y=1,
						},
						srcBlendFunc = 770,
						tweenToNext = true,
						visible = true,
					},
				},
			},
			{
				id = "Button_add_zuan_top_part2_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
				name = "Panel.Panel_base.top_part2.Button_add_zuan",
				frames = 
				{
					
					{
						alpha = 0,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 0,
						percentenable = false,
						perposition = 
						{
							x=91.64,
							y=-43.75,
						},
						position = 
						{
							x=1041,
							y=-15,
						},
						rotate = 0,
						scale = 
						{
							x=1,
							y=1,
						},
						srcBlendFunc = 1,
						tweenToNext = true,
						visible = true,
					},
					{
						alpha = 0,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 7,
						percentenable = false,
						perposition = 
						{
							x=91.64,
							y=-43.75,
						},
						position = 
						{
							x=1041,
							y=-15,
						},
						rotate = 0,
						scale = 
						{
							x=1,
							y=1,
						},
						srcBlendFunc = 1,
						tweenToNext = true,
						visible = true,
					},
					{
						alpha = 255,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 11,
						percentenable = false,
						perposition = 
						{
							x=91.64,
							y=-43.75,
						},
						position = 
						{
							x=1041,
							y=-35,
						},
						rotate = 0,
						scale = 
						{
							x=1,
							y=1,
						},
						srcBlendFunc = 1,
						tweenToNext = true,
						visible = true,
					},
				},
			},
			{
				id = "Button_setting_Panel_top_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
				name = "Panel.Panel_base.Panel_top.Button_setting",
				frames = 
				{
					
					{
						alpha = 0,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 0,
						percentenable = false,
						perposition = 
						{
							x=96.3,
							y=-42.5,
						},
						position = 
						{
							x=1094,
							y=-14,
						},
						rotate = 0,
						scale = 
						{
							x=1,
							y=1,
						},
						srcBlendFunc = 1,
						tweenToNext = true,
						visible = true,
					},
					{
						alpha = 0,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 8,
						percentenable = false,
						perposition = 
						{
							x=96.3,
							y=-42.5,
						},
						position = 
						{
							x=1094,
							y=-14,
						},
						rotate = 0,
						scale = 
						{
							x=1,
							y=1,
						},
						srcBlendFunc = 1,
						tweenToNext = true,
						visible = true,
					},
					{
						alpha = 255,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 12,
						percentenable = false,
						perposition = 
						{
							x=96.3,
							y=-42.5,
						},
						position = 
						{
							x=1094,
							y=-34,
						},
						rotate = 0,
						scale = 
						{
							x=1,
							y=1,
						},
						srcBlendFunc = 1,
						tweenToNext = true,
						visible = true,
					},
				},
			},
			{
				id = "Image_MainLayer_1_Panel_clip_Panel_right_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
				name = "Panel.Panel_base.Panel_right.Panel_clip.Image_MainLayer_1",
				frames = 
				{
					
					{
						alpha = 0,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 0,
						percentenable = false,
						perposition = 
						{
							x=0,
							y=0,
						},
						position = 
						{
							x=366,
							y=161,
						},
						rotate = 0,
						scale = 
						{
							x=1.3,
							y=1.3,
						},
						srcBlendFunc = 1,
						tweenToNext = true,
						visible = true,
					},
					{
						alpha = 0,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 5,
						percentenable = false,
						perposition = 
						{
							x=0,
							y=0,
						},
						position = 
						{
							x=366,
							y=161,
						},
						rotate = 0,
						scale = 
						{
							x=1.3,
							y=1.3,
						},
						srcBlendFunc = 1,
						tweenToNext = true,
						visible = true,
					},
					{
						alpha = 150,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 8,
						percentenable = false,
						perposition = 
						{
							x=0,
							y=0,
						},
						position = 
						{
							x=366,
							y=148,
						},
						rotate = 0,
						scale = 
						{
							x=1,
							y=1,
						},
						srcBlendFunc = 1,
						tweenToNext = true,
						visible = true,
					},
					{
						alpha = 0,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 12,
						percentenable = false,
						perposition = 
						{
							x=0,
							y=0,
						},
						position = 
						{
							x=366,
							y=148,
						},
						rotate = 0,
						scale = 
						{
							x=1,
							y=1,
						},
						srcBlendFunc = 1,
						tweenToNext = true,
						visible = true,
					},
				},
			},
			{
				id = "button_yuehui_Panel_clip_Panel_right_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
				name = "Panel.Panel_base.Panel_right.Panel_clip.button_yuehui",
				frames = 
				{
					
					{
						alpha = 0,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 0,
						percentenable = false,
						perposition = 
						{
							x=44.63,
							y=31.22,
						},
						position = 
						{
							x=366,
							y=148,
						},
						rotate = 0,
						scale = 
						{
							x=1,
							y=1,
						},
						srcBlendFunc = 1,
						tweenToNext = true,
						visible = true,
					},
					{
						alpha = 0,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 8,
						percentenable = false,
						perposition = 
						{
							x=44.63,
							y=31.22,
						},
						position = 
						{
							x=366,
							y=148,
						},
						rotate = 0,
						scale = 
						{
							x=1,
							y=1,
						},
						srcBlendFunc = 1,
						tweenToNext = true,
						visible = true,
					},
					{
						alpha = 255,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 12,
						percentenable = false,
						perposition = 
						{
							x=44.63,
							y=31.22,
						},
						position = 
						{
							x=366,
							y=130,
						},
						rotate = 0,
						scale = 
						{
							x=1,
							y=1,
						},
						srcBlendFunc = 1,
						tweenToNext = true,
						visible = true,
					},
				},
			},
			{
				id = "Image_MainLayer_1(2)_Panel_clip_Panel_right_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
				name = "Panel.Panel_base.Panel_right.Panel_clip.Image_MainLayer_1(2)",
				frames = 
				{
					
					{
						alpha = 0,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 0,
						percentenable = false,
						perposition = 
						{
							x=0,
							y=0,
						},
						position = 
						{
							x=578,
							y=162,
						},
						rotate = 0,
						scale = 
						{
							x=1.3,
							y=1.3,
						},
						srcBlendFunc = 1,
						tweenToNext = true,
						visible = true,
					},
					{
						alpha = 0,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 7,
						percentenable = false,
						perposition = 
						{
							x=0,
							y=0,
						},
						position = 
						{
							x=578,
							y=162,
						},
						rotate = 0,
						scale = 
						{
							x=1.3,
							y=1.3,
						},
						srcBlendFunc = 1,
						tweenToNext = true,
						visible = true,
					},
					{
						alpha = 150,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 10,
						percentenable = false,
						perposition = 
						{
							x=0,
							y=0,
						},
						position = 
						{
							x=578,
							y=148,
						},
						rotate = 0,
						scale = 
						{
							x=1,
							y=1,
						},
						srcBlendFunc = 1,
						tweenToNext = true,
						visible = true,
					},
					{
						alpha = 0,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 14,
						percentenable = false,
						perposition = 
						{
							x=0,
							y=0,
						},
						position = 
						{
							x=578,
							y=148,
						},
						rotate = 0,
						scale = 
						{
							x=1,
							y=1,
						},
						srcBlendFunc = 1,
						tweenToNext = true,
						visible = true,
					},
				},
			},
			{
				id = "Button_zuozhan_Panel_clip_Panel_right_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
				name = "Panel.Panel_base.Panel_right.Panel_clip.Button_zuozhan",
				frames = 
				{
					
					{
						alpha = 0,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 0,
						percentenable = false,
						perposition = 
						{
							x=70.37,
							y=31.22,
						},
						position = 
						{
							x=577,
							y=148,
						},
						rotate = 0,
						scale = 
						{
							x=1,
							y=1,
						},
						srcBlendFunc = 1,
						tweenToNext = true,
						visible = true,
					},
					{
						alpha = 0,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 10,
						percentenable = false,
						perposition = 
						{
							x=70.37,
							y=31.22,
						},
						position = 
						{
							x=577,
							y=148,
						},
						rotate = 0,
						scale = 
						{
							x=1,
							y=1,
						},
						srcBlendFunc = 1,
						tweenToNext = true,
						visible = true,
					},
					{
						alpha = 255,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 14,
						percentenable = false,
						perposition = 
						{
							x=70.37,
							y=31.22,
						},
						position = 
						{
							x=577,
							y=130,
						},
						rotate = 0,
						scale = 
						{
							x=1,
							y=1,
						},
						srcBlendFunc = 1,
						tweenToNext = true,
						visible = true,
					},
				},
			},
			{
				id = "Image_MainLayer_1(4)_Panel_clip_Panel_right_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
				name = "Panel.Panel_base.Panel_right.Panel_clip.Image_MainLayer_1(4)",
				frames = 
				{
					
					{
						alpha = 0,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 0,
						percentenable = false,
						perposition = 
						{
							x=0,
							y=0,
						},
						position = 
						{
							x=365,
							y=36,
						},
						rotate = 0,
						scale = 
						{
							x=1,
							y=1,
						},
						srcBlendFunc = 1,
						tweenToNext = true,
						visible = true,
					},
					{
						alpha = 0,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 10,
						percentenable = false,
						perposition = 
						{
							x=0,
							y=0,
						},
						position = 
						{
							x=365,
							y=36,
						},
						rotate = 0,
						scale = 
						{
							x=1,
							y=1,
						},
						srcBlendFunc = 1,
						tweenToNext = true,
						visible = true,
					},
					{
						alpha = 255,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 17,
						percentenable = false,
						perposition = 
						{
							x=0,
							y=0,
						},
						position = 
						{
							x=365,
							y=46,
						},
						rotate = 0,
						scale = 
						{
							x=1,
							y=1,
						},
						srcBlendFunc = 1,
						tweenToNext = true,
						visible = true,
					},
				},
			},
			{
				id = "Image_text_Panel_clip_Panel_right_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
				name = "Panel.Panel_base.Panel_right.Panel_clip.Image_text",
				frames = 
				{
					
					{
						alpha = 0,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 0,
						percentenable = false,
						perposition = 
						{
							x=0,
							y=0,
						},
						position = 
						{
							x=579,
							y=34,
						},
						rotate = 0,
						scale = 
						{
							x=1,
							y=1,
						},
						srcBlendFunc = 1,
						tweenToNext = true,
						visible = true,
					},
					{
						alpha = 0,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 12,
						percentenable = false,
						perposition = 
						{
							x=0,
							y=0,
						},
						position = 
						{
							x=579,
							y=34,
						},
						rotate = 0,
						scale = 
						{
							x=1,
							y=1,
						},
						srcBlendFunc = 1,
						tweenToNext = true,
						visible = true,
					},
					{
						alpha = 255,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 19,
						percentenable = false,
						perposition = 
						{
							x=0,
							y=0,
						},
						position = 
						{
							x=579,
							y=44,
						},
						rotate = 0,
						scale = 
						{
							x=1,
							y=1,
						},
						srcBlendFunc = 1,
						tweenToNext = true,
						visible = true,
					},
				},
			},
			{
				id = "Image_MainLayer_1(3)_Panel_clip_Panel_right_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
				name = "Panel.Panel_base.Panel_right.Panel_clip.Image_MainLayer_1(3)",
				frames = 
				{
					
					{
						alpha = 0,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 0,
						percentenable = false,
						perposition = 
						{
							x=0,
							y=0,
						},
						position = 
						{
							x=367,
							y=313,
						},
						rotate = 0,
						scale = 
						{
							x=0.9,
							y=0.9,
						},
						srcBlendFunc = 1,
						tweenToNext = true,
						visible = true,
					},
					{
						alpha = 0,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 11,
						percentenable = false,
						perposition = 
						{
							x=0,
							y=0,
						},
						position = 
						{
							x=367,
							y=313,
						},
						rotate = 0,
						scale = 
						{
							x=0.9,
							y=0.9,
						},
						srcBlendFunc = 1,
						tweenToNext = true,
						visible = true,
					},
					{
						alpha = 255,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 14,
						percentenable = false,
						perposition = 
						{
							x=0,
							y=0,
						},
						position = 
						{
							x=367,
							y=313,
						},
						rotate = 0,
						scale = 
						{
							x=0.9,
							y=0.9,
						},
						srcBlendFunc = 1,
						tweenToNext = true,
						visible = true,
					},
					{
						alpha = 0,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 18,
						percentenable = false,
						perposition = 
						{
							x=0,
							y=0,
						},
						position = 
						{
							x=367,
							y=313,
						},
						rotate = 0,
						scale = 
						{
							x=1.1,
							y=1.1,
						},
						srcBlendFunc = 1,
						tweenToNext = true,
						visible = true,
					},
				},
			},
			{
				id = "Image_MainLayer_1(3)(2)_Panel_clip_Panel_right_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
				name = "Panel.Panel_base.Panel_right.Panel_clip.Image_MainLayer_1(3)(2)",
				frames = 
				{
					
					{
						alpha = 0,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 0,
						percentenable = false,
						perposition = 
						{
							x=0,
							y=0,
						},
						position = 
						{
							x=471,
							y=295,
						},
						rotate = 0,
						scale = 
						{
							x=0.9,
							y=0.9,
						},
						srcBlendFunc = 1,
						tweenToNext = true,
						visible = true,
					},
					{
						alpha = 0,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 12,
						percentenable = false,
						perposition = 
						{
							x=0,
							y=0,
						},
						position = 
						{
							x=471,
							y=295,
						},
						rotate = 0,
						scale = 
						{
							x=0.9,
							y=0.9,
						},
						srcBlendFunc = 1,
						tweenToNext = true,
						visible = true,
					},
					{
						alpha = 255,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 15,
						percentenable = false,
						perposition = 
						{
							x=0,
							y=0,
						},
						position = 
						{
							x=471,
							y=295,
						},
						rotate = 0,
						scale = 
						{
							x=0.9,
							y=0.9,
						},
						srcBlendFunc = 1,
						tweenToNext = true,
						visible = true,
					},
					{
						alpha = 0,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 19,
						percentenable = false,
						perposition = 
						{
							x=0,
							y=0,
						},
						position = 
						{
							x=471,
							y=295,
						},
						rotate = 0,
						scale = 
						{
							x=1.1,
							y=1.1,
						},
						srcBlendFunc = 1,
						tweenToNext = true,
						visible = true,
					},
				},
			},
			{
				id = "Image_MainLayer_1(3)(3)_Panel_clip_Panel_right_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
				name = "Panel.Panel_base.Panel_right.Panel_clip.Image_MainLayer_1(3)(3)",
				frames = 
				{
					
					{
						alpha = 0,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 0,
						percentenable = false,
						perposition = 
						{
							x=0,
							y=0,
						},
						position = 
						{
							x=573,
							y=311,
						},
						rotate = 0,
						scale = 
						{
							x=0.9,
							y=0.9,
						},
						srcBlendFunc = 1,
						tweenToNext = true,
						visible = true,
					},
					{
						alpha = 0,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 13,
						percentenable = false,
						perposition = 
						{
							x=0,
							y=0,
						},
						position = 
						{
							x=573,
							y=311,
						},
						rotate = 0,
						scale = 
						{
							x=0.9,
							y=0.9,
						},
						srcBlendFunc = 1,
						tweenToNext = true,
						visible = true,
					},
					{
						alpha = 255,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 16,
						percentenable = false,
						perposition = 
						{
							x=0,
							y=0,
						},
						position = 
						{
							x=573,
							y=311,
						},
						rotate = 0,
						scale = 
						{
							x=0.9,
							y=0.9,
						},
						srcBlendFunc = 1,
						tweenToNext = true,
						visible = true,
					},
					{
						alpha = 0,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 20,
						percentenable = false,
						perposition = 
						{
							x=0,
							y=0,
						},
						position = 
						{
							x=573,
							y=311,
						},
						rotate = 0,
						scale = 
						{
							x=1.1,
							y=1.1,
						},
						srcBlendFunc = 1,
						tweenToNext = true,
						visible = true,
					},
				},
			},
			{
				id = "Button_pokedex_Panel_clip_Panel_right_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
				name = "Panel.Panel_base.Panel_right.Panel_clip.Button_pokedex",
				frames = 
				{
					
					{
						alpha = 0,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 0,
						percentenable = false,
						perposition = 
						{
							x=62.66,
							y=66.38,
						},
						position = 
						{
							x=513,
							y=304,
						},
						rotate = 0,
						scale = 
						{
							x=1,
							y=1,
						},
						srcBlendFunc = 1,
						tweenToNext = true,
						visible = true,
					},
					{
						alpha = 0,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 14,
						percentenable = false,
						perposition = 
						{
							x=44.63,
							y=68.34,
						},
						position = 
						{
							x=366,
							y=313,
						},
						rotate = 0,
						scale = 
						{
							x=1,
							y=1,
						},
						srcBlendFunc = 1,
						tweenToNext = true,
						visible = true,
					},
					{
						alpha = 255,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 18,
						percentenable = false,
						perposition = 
						{
							x=61.41,
							y=64.47,
						},
						position = 
						{
							x=503,
							y=295,
						},
						rotate = 0,
						scale = 
						{
							x=1,
							y=1,
						},
						srcBlendFunc = 1,
						tweenToNext = true,
						visible = true,
					},
				},
			},
			{
				id = "Button_friend_Panel_clip_Panel_right_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
				name = "Panel.Panel_base.Panel_right.Panel_clip.Button_friend",
				frames = 
				{
					
					{
						alpha = 0,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 0,
						percentenable = false,
						perposition = 
						{
							x=276.77,
							y=53.16,
						},
						position = 
						{
							x=276,
							y=255,
						},
						rotate = 0,
						scale = 
						{
							x=1,
							y=1,
						},
						srcBlendFunc = 1,
						tweenToNext = true,
						visible = true,
					},
					{
						alpha = 0,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 15,
						percentenable = false,
						perposition = 
						{
							x=57.56,
							y=64.19,
						},
						position = 
						{
							x=472,
							y=294,
						},
						rotate = 0,
						scale = 
						{
							x=1,
							y=1,
						},
						srcBlendFunc = 1,
						tweenToNext = true,
						visible = true,
					},
					{
						alpha = 255,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 19,
						percentenable = false,
						perposition = 
						{
							x=33.98,
							y=58.54,
						},
						position = 
						{
							x=33,
							y=281,
						},
						rotate = 0,
						scale = 
						{
							x=1,
							y=1,
						},
						srcBlendFunc = 1,
						tweenToNext = true,
						visible = true,
					},
				},
			},
			{
				id = "Button_task_Panel_clip_Panel_right_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
				name = "Panel.Panel_base.Panel_right.Panel_clip.Button_task",
				frames = 
				{
					
					{
						alpha = 0,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 0,
						percentenable = false,
						perposition = 
						{
							x=70,
							y=68.34,
						},
						position = 
						{
							x=574,
							y=313,
						},
						rotate = 0,
						scale = 
						{
							x=1,
							y=1,
						},
						srcBlendFunc = 1,
						tweenToNext = true,
						visible = true,
					},
					{
						alpha = 0,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 16,
						percentenable = false,
						perposition = 
						{
							x=70,
							y=68.34,
						},
						position = 
						{
							x=574,
							y=313,
						},
						rotate = 0,
						scale = 
						{
							x=1,
							y=1,
						},
						srcBlendFunc = 1,
						tweenToNext = true,
						visible = true,
					},
					{
						alpha = 255,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 20,
						percentenable = false,
						perposition = 
						{
							x=70,
							y=68.34,
						},
						position = 
						{
							x=574,
							y=313,
						},
						rotate = 0,
						scale = 
						{
							x=1,
							y=1,
						},
						srcBlendFunc = 1,
						tweenToNext = true,
						visible = true,
					},
				},
			},
			{
				id = "Panel_activity_Panel_clip_Panel_right_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
				name = "Panel.Panel_base.Panel_right.Panel_clip.Panel_activity",
				frames = 
				{
					
					{
						alpha = 0,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 0,
						percentenable = false,
						perposition = 
						{
							x=58.17,
							y=88.86,
						},
						position = 
						{
							x=467,
							y=407,
						},
						rotate = 0,
						scale = 
						{
							x=0.98,
							y=0.98,
						},
						srcBlendFunc = 1,
						tweenToNext = true,
						visible = true,
					},
					{
						alpha = 0,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 10,
						percentenable = false,
						perposition = 
						{
							x=58.17,
							y=88.86,
						},
						position = 
						{
							x=467,
							y=407,
						},
						rotate = 0,
						scale = 
						{
							x=0.98,
							y=0.98,
						},
						srcBlendFunc = 1,
						tweenToNext = true,
						visible = true,
					},
					{
						alpha = 255,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 19,
						percentenable = false,
						perposition = 
						{
							x=58.17,
							y=88.86,
						},
						position = 
						{
							x=467,
							y=407,
						},
						rotate = 0,
						scale = 
						{
							x=1,
							y=1,
						},
						srcBlendFunc = 1,
						tweenToNext = true,
						visible = true,
					},
				},
			},
			{
				id = "Image_fairyMain_1_Panel_bottom_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
				name = "Panel.Panel_base.Panel_bottom.Image_fairyMain_1",
				frames = 
				{
					
					{
						alpha = 0,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 0,
						percentenable = false,
						perposition = 
						{
							x=0,
							y=0,
						},
						position = 
						{
							x=157,
							y=10,
						},
						rotate = 0,
						scale = 
						{
							x=1,
							y=1,
						},
						srcBlendFunc = 1,
						tweenToNext = true,
						visible = true,
					},
					{
						alpha = 0,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 10,
						percentenable = false,
						perposition = 
						{
							x=0,
							y=0,
						},
						position = 
						{
							x=157,
							y=10,
						},
						rotate = 0,
						scale = 
						{
							x=1,
							y=1,
						},
						srcBlendFunc = 1,
						tweenToNext = true,
						visible = true,
					},
					{
						alpha = 50,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 14,
						percentenable = false,
						perposition = 
						{
							x=0,
							y=0,
						},
						position = 
						{
							x=157,
							y=20,
						},
						rotate = 0,
						scale = 
						{
							x=1,
							y=1,
						},
						srcBlendFunc = 1,
						tweenToNext = true,
						visible = true,
					},
				},
			},
			{
				id = "Image_fairyMain_1(2)_Panel_bottom_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
				name = "Panel.Panel_base.Panel_bottom.Image_fairyMain_1(2)",
				frames = 
				{
					
					{
						alpha = 0,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 0,
						percentenable = false,
						perposition = 
						{
							x=0,
							y=0,
						},
						position = 
						{
							x=256,
							y=10,
						},
						rotate = 0,
						scale = 
						{
							x=1,
							y=1,
						},
						srcBlendFunc = 1,
						tweenToNext = true,
						visible = true,
					},
					{
						alpha = 0,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 10,
						percentenable = false,
						perposition = 
						{
							x=0,
							y=0,
						},
						position = 
						{
							x=256,
							y=10,
						},
						rotate = 0,
						scale = 
						{
							x=1,
							y=1,
						},
						srcBlendFunc = 1,
						tweenToNext = true,
						visible = true,
					},
					{
						alpha = 50,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 14,
						percentenable = false,
						perposition = 
						{
							x=0,
							y=0,
						},
						position = 
						{
							x=256,
							y=20,
						},
						rotate = 0,
						scale = 
						{
							x=1,
							y=1,
						},
						srcBlendFunc = 1,
						tweenToNext = true,
						visible = true,
					},
				},
			},
			{
				id = "Image_fairyMain_1(3)_Panel_bottom_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
				name = "Panel.Panel_base.Panel_bottom.Image_fairyMain_1(3)",
				frames = 
				{
					
					{
						alpha = 0,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 0,
						percentenable = false,
						perposition = 
						{
							x=0,
							y=0,
						},
						position = 
						{
							x=356,
							y=10,
						},
						rotate = 0,
						scale = 
						{
							x=1,
							y=1,
						},
						srcBlendFunc = 1,
						tweenToNext = true,
						visible = true,
					},
					{
						alpha = 0,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 10,
						percentenable = false,
						perposition = 
						{
							x=0,
							y=0,
						},
						position = 
						{
							x=356,
							y=10,
						},
						rotate = 0,
						scale = 
						{
							x=1,
							y=1,
						},
						srcBlendFunc = 1,
						tweenToNext = true,
						visible = true,
					},
					{
						alpha = 50,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 14,
						percentenable = false,
						perposition = 
						{
							x=0,
							y=0,
						},
						position = 
						{
							x=356,
							y=20,
						},
						rotate = 0,
						scale = 
						{
							x=1,
							y=1,
						},
						srcBlendFunc = 1,
						tweenToNext = true,
						visible = true,
					},
				},
			},
			{
				id = "Button_fairy_Panel_bottom_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
				name = "Panel.Panel_base.Panel_bottom.Button_fairy",
				frames = 
				{
					
					{
						alpha = 0,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 0,
						percentenable = false,
						perposition = 
						{
							x=27.88,
							y=58,
						},
						position = 
						{
							x=6,
							y=38,
						},
						rotate = 0,
						scale = 
						{
							x=1,
							y=1,
						},
						srcBlendFunc = 1,
						tweenToNext = true,
						visible = true,
					},
					{
						alpha = 0,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 3,
						percentenable = false,
						perposition = 
						{
							x=27.88,
							y=58,
						},
						position = 
						{
							x=6,
							y=38,
						},
						rotate = 0,
						scale = 
						{
							x=1,
							y=1,
						},
						srcBlendFunc = 1,
						tweenToNext = true,
						visible = true,
					},
					{
						alpha = 255,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 9,
						percentenable = false,
						perposition = 
						{
							x=-7.6,
							y=43,
						},
						position = 
						{
							x=-50,
							y=43,
						},
						rotate = 0,
						scale = 
						{
							x=1,
							y=1,
						},
						srcBlendFunc = 1,
						tweenToNext = true,
						visible = true,
					},
				},
			},
			{
				id = "Button_bag_Panel_bottom_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
				name = "Panel.Panel_base.Panel_bottom.Button_bag",
				frames = 
				{
					
					{
						alpha = 0,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 0,
						percentenable = false,
						perposition = 
						{
							x=43.03,
							y=61,
						},
						position = 
						{
							x=106,
							y=41,
						},
						rotate = 0,
						scale = 
						{
							x=1,
							y=1,
						},
						srcBlendFunc = 1,
						tweenToNext = true,
						visible = true,
					},
					{
						alpha = 0,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 4,
						percentenable = false,
						perposition = 
						{
							x=43.03,
							y=61,
						},
						position = 
						{
							x=106,
							y=41,
						},
						rotate = 0,
						scale = 
						{
							x=1,
							y=1,
						},
						srcBlendFunc = 1,
						tweenToNext = true,
						visible = true,
					},
					{
						alpha = 255,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 10,
						percentenable = false,
						perposition = 
						{
							x=8.26,
							y=46,
						},
						position = 
						{
							x=54,
							y=46,
						},
						rotate = 0,
						scale = 
						{
							x=1,
							y=1,
						},
						srcBlendFunc = 1,
						tweenToNext = true,
						visible = true,
					},
				},
			},
			{
				id = "Button_zhaohuan_Panel_bottom_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
				name = "Panel.Panel_base.Panel_bottom.Button_zhaohuan",
				frames = 
				{
					
					{
						alpha = 0,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 0,
						percentenable = false,
						perposition = 
						{
							x=58.48,
							y=61,
						},
						position = 
						{
							x=308,
							y=41,
						},
						rotate = 0,
						scale = 
						{
							x=1,
							y=1,
						},
						srcBlendFunc = 1,
						tweenToNext = true,
						visible = true,
					},
					{
						alpha = 0,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 5,
						percentenable = false,
						perposition = 
						{
							x=58.48,
							y=61,
						},
						position = 
						{
							x=308,
							y=41,
						},
						rotate = 0,
						scale = 
						{
							x=1,
							y=1,
						},
						srcBlendFunc = 1,
						tweenToNext = true,
						visible = true,
					},
					{
						alpha = 255,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 11,
						percentenable = false,
						perposition = 
						{
							x=40.33,
							y=46,
						},
						position = 
						{
							x=266,
							y=46,
						},
						rotate = 0,
						scale = 
						{
							x=1,
							y=1,
						},
						srcBlendFunc = 1,
						tweenToNext = true,
						visible = true,
					},
				},
			},
			{
				id = "Button_shop_Panel_bottom_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
				name = "Panel.Panel_base.Panel_bottom.Button_shop",
				frames = 
				{
					
					{
						alpha = 0,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 0,
						percentenable = false,
						perposition = 
						{
							x=72.42,
							y=60,
						},
						position = 
						{
							x=400,
							y=40,
						},
						rotate = 0,
						scale = 
						{
							x=1,
							y=1,
						},
						srcBlendFunc = 1,
						tweenToNext = true,
						visible = true,
					},
					{
						alpha = 0,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 6,
						percentenable = false,
						perposition = 
						{
							x=72.42,
							y=60,
						},
						position = 
						{
							x=400,
							y=40,
						},
						rotate = 0,
						scale = 
						{
							x=1,
							y=1,
						},
						srcBlendFunc = 1,
						tweenToNext = true,
						visible = true,
					},
					{
						alpha = 255,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 12,
						percentenable = false,
						perposition = 
						{
							x=55.4,
							y=46.69,
						},
						position = 
						{
							x=365,
							y=46,
						},
						rotate = 0,
						scale = 
						{
							x=1,
							y=1,
						},
						srcBlendFunc = 1,
						tweenToNext = true,
						visible = true,
					},
				},
			},
			{
				id = "Button_phone_Panel_bottom_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
				name = "Panel.Panel_base.Panel_bottom.Button_phone",
				frames = 
				{
					
					{
						alpha = 0,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 0,
						percentenable = false,
						perposition = 
						{
							x=89.09,
							y=55,
						},
						position = 
						{
							x=570,
							y=35,
						},
						rotate = 0,
						scale = 
						{
							x=1,
							y=1,
						},
						srcBlendFunc = 1,
						tweenToNext = true,
						visible = true,
					},
					{
						alpha = 255,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 8,
						percentenable = false,
						perposition = 
						{
							x=86.36,
							y=41.22,
						},
						position = 
						{
							x=570,
							y=35,
						},
						rotate = 0,
						scale = 
						{
							x=1,
							y=1,
						},
						srcBlendFunc = 1,
						tweenToNext = true,
						visible = true,
					},
					{
						alpha = 255,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 18,
						percentenable = false,
						perposition = 
						{
							x=89.09,
							y=67,
						},
						position = 
						{
							x=570,
							y=49,
						},
						rotate = 0,
						scale = 
						{
							x=1,
							y=1,
						},
						srcBlendFunc = 1,
						tweenToNext = true,
						visible = true,
					},
				},
			},
			{
				id = "Image_chat_bg_Panel_chat_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
				name = "Panel.Panel_base.Panel_chat.Image_chat_bg",
				frames = 
				{
					
					{
						alpha = 0,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 0,
						percentenable = false,
						perposition = 
						{
							x=0,
							y=0,
						},
						position = 
						{
							x=32,
							y=14,
						},
						rotate = 0,
						scale = 
						{
							x=1,
							y=1,
						},
						srcBlendFunc = 1,
						tweenToNext = true,
						visible = true,
					},
					{
						alpha = 0,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 6,
						percentenable = false,
						perposition = 
						{
							x=0,
							y=0,
						},
						position = 
						{
							x=32,
							y=14,
						},
						rotate = 0,
						scale = 
						{
							x=1,
							y=1,
						},
						srcBlendFunc = 1,
						tweenToNext = true,
						visible = true,
					},
					{
						alpha = 255,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 11,
						percentenable = false,
						perposition = 
						{
							x=0,
							y=0,
						},
						position = 
						{
							x=42,
							y=14,
						},
						rotate = 0,
						scale = 
						{
							x=1,
							y=1,
						},
						srcBlendFunc = 1,
						tweenToNext = true,
						visible = true,
					},
				},
			},
			{
				id = "Panel_chat_di_Panel_chat_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
				name = "Panel.Panel_base.Panel_chat.Panel_chat_di",
				frames = 
				{
					
					{
						alpha = 0,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 0,
						percentenable = false,
						perposition = 
						{
							x=15.16,
							y=22.5,
						},
						position = 
						{
							x=52,
							y=16,
						},
						rotate = 0,
						scale = 
						{
							x=1,
							y=1,
						},
						srcBlendFunc = 1,
						tweenToNext = true,
						visible = true,
					},
					{
						alpha = 0,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 6,
						percentenable = false,
						perposition = 
						{
							x=15.16,
							y=22.5,
						},
						position = 
						{
							x=52,
							y=16,
						},
						rotate = 0,
						scale = 
						{
							x=1,
							y=1,
						},
						srcBlendFunc = 1,
						tweenToNext = true,
						visible = true,
					},
					{
						alpha = 255,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 11,
						percentenable = false,
						perposition = 
						{
							x=15.16,
							y=22.5,
						},
						position = 
						{
							x=62,
							y=16,
						},
						rotate = 0,
						scale = 
						{
							x=1,
							y=1,
						},
						srcBlendFunc = 1,
						tweenToNext = true,
						visible = true,
					},
				},
			},
			{
				id = "Image_chat_Panel_chat_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
				name = "Panel.Panel_base.Panel_chat.Image_chat",
				frames = 
				{
					
					{
						alpha = 0,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 0,
						percentenable = false,
						perposition = 
						{
							x=7.47,
							y=20,
						},
						position = 
						{
							x=24,
							y=16,
						},
						rotate = 0,
						scale = 
						{
							x=1,
							y=1,
						},
						srcBlendFunc = 1,
						tweenToNext = true,
						visible = true,
					},
					{
						alpha = 0,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 5,
						percentenable = false,
						perposition = 
						{
							x=7.47,
							y=20,
						},
						position = 
						{
							x=24,
							y=16,
						},
						rotate = 0,
						scale = 
						{
							x=1,
							y=1,
						},
						srcBlendFunc = 1,
						tweenToNext = true,
						visible = true,
					},
					{
						alpha = 255,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 10,
						percentenable = false,
						perposition = 
						{
							x=7.47,
							y=20,
						},
						position = 
						{
							x=34,
							y=16,
						},
						rotate = 0,
						scale = 
						{
							x=1,
							y=1,
						},
						srcBlendFunc = 1,
						tweenToNext = true,
						visible = true,
					},
				},
			},
			{
				id = "Panel_player_info_Panel_top_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
				name = "Panel.Panel_base.Panel_top.Panel_player_info",
				frames = 
				{
					
					{
						alpha = 0,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 0,
						percentenable = false,
						perposition = 
						{
							x=0.62,
							y=-5,
						},
						position = 
						{
							x=-2,
							y=-4,
						},
						rotate = 0,
						scale = 
						{
							x=1,
							y=1,
						},
						srcBlendFunc = 1,
						tweenToNext = true,
						visible = true,
					},
					{
						alpha = 0,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 4,
						percentenable = false,
						perposition = 
						{
							x=0.62,
							y=-5,
						},
						position = 
						{
							x=-2,
							y=-4,
						},
						rotate = 0,
						scale = 
						{
							x=1,
							y=1,
						},
						srcBlendFunc = 1,
						tweenToNext = true,
						visible = true,
					},
					{
						alpha = 255,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 7,
						percentenable = false,
						perposition = 
						{
							x=0.62,
							y=-5,
						},
						position = 
						{
							x=7,
							y=-4,
						},
						rotate = 0,
						scale = 
						{
							x=1,
							y=1,
						},
						srcBlendFunc = 1,
						tweenToNext = true,
						visible = true,
					},
				},
			},
			{
				id = "Image_split_line_Panel_bottom_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
				name = "Panel.Panel_base.Panel_bottom.Image_split_line",
				frames = 
				{
					
					{
						alpha = 50,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 0,
						percentenable = false,
						perposition = 
						{
							x=0,
							y=0,
						},
						position = 
						{
							x=440,
							y=10,
						},
						rotate = 0,
						scale = 
						{
							x=1,
							y=1,
						},
						srcBlendFunc = 1,
						tweenToNext = true,
						visible = true,
					},
					{
						alpha = 50,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 10,
						percentenable = false,
						perposition = 
						{
							x=0,
							y=0,
						},
						position = 
						{
							x=440,
							y=10,
						},
						rotate = 0,
						scale = 
						{
							x=1,
							y=1,
						},
						srcBlendFunc = 1,
						tweenToNext = true,
						visible = true,
					},
					{
						alpha = 50,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 14,
						percentenable = false,
						perposition = 
						{
							x=0,
							y=0,
						},
						position = 
						{
							x=440,
							y=21,
						},
						rotate = 0,
						scale = 
						{
							x=1,
							y=1,
						},
						srcBlendFunc = 1,
						tweenToNext = true,
						visible = true,
					},
				},
			},
			{
				id = "Button_recharge_Panel_bottom_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
				name = "Panel.Panel_base.Panel_bottom.Button_recharge",
				frames = 
				{
					
					{
						alpha = 0,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 0,
						percentenable = false,
						perposition = 
						{
							x=72.42,
							y=62,
						},
						position = 
						{
							x=478,
							y=40,
						},
						rotate = 0,
						scale = 
						{
							x=1,
							y=1,
						},
						srcBlendFunc = 1,
						tweenToNext = true,
						visible = true,
					},
					{
						alpha = 0,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 7,
						percentenable = false,
						perposition = 
						{
							x=72.42,
							y=62,
						},
						position = 
						{
							x=478,
							y=40,
						},
						rotate = 0,
						scale = 
						{
							x=1,
							y=1,
						},
						srcBlendFunc = 1,
						tweenToNext = true,
						visible = true,
					},
					{
						alpha = 255,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 13,
						percentenable = false,
						perposition = 
						{
							x=71.75,
							y=43.36,
						},
						position = 
						{
							x=473,
							y=43,
						},
						rotate = 0,
						scale = 
						{
							x=1,
							y=1,
						},
						srcBlendFunc = 1,
						tweenToNext = true,
						visible = true,
					},
				},
			},
			{
				id = "btn_infoStation_Panel_clip_Panel_right_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
				name = "Panel.Panel_base.Panel_right.Panel_clip.btn_infoStation",
				frames = 
				{
					
					{
						alpha = 0,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 0,
						percentenable = false,
						perposition = 
						{
							x=79.02,
							y=59.83,
						},
						position = 
						{
							x=648,
							y=274,
						},
						rotate = 0,
						scale = 
						{
							x=1,
							y=1,
						},
						srcBlendFunc = 1,
						tweenToNext = true,
						visible = true,
					},
					{
						alpha = 0,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 17,
						percentenable = false,
						perposition = 
						{
							x=79.02,
							y=59.83,
						},
						position = 
						{
							x=648,
							y=274,
						},
						rotate = 0,
						scale = 
						{
							x=1,
							y=1,
						},
						srcBlendFunc = 1,
						tweenToNext = true,
						visible = true,
					},
					{
						alpha = 255,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 21,
						percentenable = false,
						perposition = 
						{
							x=79.02,
							y=59.83,
						},
						position = 
						{
							x=648,
							y=274,
						},
						rotate = 0,
						scale = 
						{
							x=1,
							y=1,
						},
						srcBlendFunc = 1,
						tweenToNext = true,
						visible = true,
					},
				},
			},
			{
				id = "Image_MainLayer_1(5)_Panel_clip_Panel_right_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
				name = "Panel.Panel_base.Panel_right.Panel_clip.Image_MainLayer_1(5)",
				frames = 
				{
					
					{
						alpha = 0,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 0,
						percentenable = false,
						perposition = 
						{
							x=0,
							y=0,
						},
						position = 
						{
							x=644,
							y=276,
						},
						rotate = 0,
						scale = 
						{
							x=0.9,
							y=0.9,
						},
						srcBlendFunc = 1,
						tweenToNext = true,
						visible = true,
					},
					{
						alpha = 0,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 14,
						percentenable = false,
						perposition = 
						{
							x=0,
							y=0,
						},
						position = 
						{
							x=644,
							y=276,
						},
						rotate = 0,
						scale = 
						{
							x=0.9,
							y=0.9,
						},
						srcBlendFunc = 1,
						tweenToNext = true,
						visible = true,
					},
					{
						alpha = 0,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 21,
						percentenable = false,
						perposition = 
						{
							x=0,
							y=0,
						},
						position = 
						{
							x=644,
							y=276,
						},
						rotate = 0,
						scale = 
						{
							x=1.1,
							y=1.1,
						},
						srcBlendFunc = 1,
						tweenToNext = true,
						visible = true,
					},
				},
			},
			{
				id = "Button_league_Panel_bottom_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
				name = "Panel.Panel_base.Panel_bottom.Button_league",
				frames = 
				{
					
					{
						alpha = 0,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 0,
						percentenable = false,
						perposition = 
						{
							x=31.21,
							y=62,
						},
						position = 
						{
							x=206,
							y=0,
						},
						rotate = 0,
						scale = 
						{
							x=1,
							y=1,
						},
						srcBlendFunc = 1,
						tweenToNext = true,
						visible = true,
					},
					{
						alpha = 0,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 3,
						percentenable = false,
						perposition = 
						{
							x=31.21,
							y=62,
						},
						position = 
						{
							x=206,
							y=0,
						},
						rotate = 0,
						scale = 
						{
							x=1,
							y=1,
						},
						srcBlendFunc = 1,
						tweenToNext = true,
						visible = true,
					},
					{
						alpha = 255,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 10,
						percentenable = false,
						perposition = 
						{
							x=24.43,
							y=45,
						},
						position = 
						{
							x=161,
							y=45,
						},
						rotate = 0,
						scale = 
						{
							x=1,
							y=1,
						},
						srcBlendFunc = 1,
						tweenToNext = true,
						visible = true,
					},
				},
			},
			{
				id = "Image_MainLayer_1(3)-Copy1_Panel_clip_Panel_right_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
				name = "Panel.Panel_base.Panel_right.Panel_clip.Image_MainLayer_1(3)-Copy1",
				frames = 
				{
					
					{
						alpha = 0,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 0,
						percentenable = false,
						perposition = 
						{
							x=0,
							y=0,
						},
						position = 
						{
							x=659,
							y=287,
						},
						rotate = 0,
						scale = 
						{
							x=1,
							y=1,
						},
						srcBlendFunc = 1,
						tweenToNext = true,
						visible = true,
					},
					{
						alpha = 0,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 14,
						percentenable = false,
						perposition = 
						{
							x=0,
							y=0,
						},
						position = 
						{
							x=652,
							y=292,
						},
						rotate = 0,
						scale = 
						{
							x=1,
							y=1,
						},
						srcBlendFunc = 1,
						tweenToNext = true,
						visible = true,
					},
					{
						alpha = 255,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 17,
						percentenable = false,
						perposition = 
						{
							x=0,
							y=0,
						},
						position = 
						{
							x=659,
							y=287,
						},
						rotate = 0,
						scale = 
						{
							x=1,
							y=1,
						},
						srcBlendFunc = 1,
						tweenToNext = true,
						visible = true,
					},
					{
						alpha = 0,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 21,
						percentenable = false,
						perposition = 
						{
							x=0,
							y=0,
						},
						position = 
						{
							x=659,
							y=287,
						},
						rotate = 0,
						scale = 
						{
							x=1,
							y=1,
						},
						srcBlendFunc = 1,
						tweenToNext = true,
						visible = true,
					},
				},
			},
			{
				id = "Button_dispatch_Panel_clip_Panel_right_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
				name = "Panel.Panel_base.Panel_right.Panel_clip.Button_dispatch",
				frames = 
				{
					
					{
						alpha = 255,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 0,
						percentenable = false,
						perposition = 
						{
							x=79.88,
							y=64.19,
						},
						position = 
						{
							x=664,
							y=294,
						},
						rotate = 0,
						scale = 
						{
							x=1,
							y=1,
						},
						srcBlendFunc = 1,
						tweenToNext = true,
						visible = true,
					},
					{
						alpha = 0,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 17,
						percentenable = false,
						perposition = 
						{
							x=79.88,
							y=64.19,
						},
						position = 
						{
							x=664,
							y=294,
						},
						rotate = 0,
						scale = 
						{
							x=1,
							y=1,
						},
						srcBlendFunc = 1,
						tweenToNext = true,
						visible = true,
					},
					{
						alpha = 255,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 21,
						percentenable = false,
						perposition = 
						{
							x=79.88,
							y=64.19,
						},
						position = 
						{
							x=664,
							y=294,
						},
						rotate = 0,
						scale = 
						{
							x=1,
							y=1,
						},
						srcBlendFunc = 1,
						tweenToNext = true,
						visible = true,
					},
				},
			},
		},
		Action1 = 
		{
			name = "Action1",
			FPS = 30,
			duration = 0.33,
			looptimes = 1,
			autoplay = false,
			{
				id = "Panel_system_Panel_top_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
				name = "Panel.Panel_base.Panel_top.Panel_system",
				frames = 
				{
					
					{
						alpha = 0,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 0,
						percentenable = false,
						perposition = 
						{
							x=5.72,
							y=-138.75,
						},
						position = 
						{
							x=65,
							y=-100,
						},
						rotate = 0,
						scale = 
						{
							x=1,
							y=1,
						},
						srcBlendFunc = 1,
						tweenToNext = true,
						visible = true,
					},
					{
						alpha = 255,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 10,
						percentenable = false,
						perposition = 
						{
							x=5.72,
							y=-138.75,
						},
						position = 
						{
							x=65,
							y=-111,
						},
						rotate = 0,
						scale = 
						{
							x=1,
							y=1,
						},
						srcBlendFunc = 1,
						tweenToNext = true,
						visible = true,
					},
				},
			},
		},
		Action2 = 
		{
			name = "Action2",
			FPS = 30,
			duration = 0.2,
			looptimes = 1,
			autoplay = false,
			{
				id = "Panel_feelling_info__Panel_right_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
				name = "Panel.Panel_base.Panel_right.Panel_feelling_info_",
				frames = 
				{
					
					{
						alpha = 0,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 0,
						percentenable = false,
						perposition = 
						{
							x=0.61,
							y=55.46,
						},
						position = 
						{
							x=5,
							y=254,
						},
						rotate = 0,
						scale = 
						{
							x=0.98,
							y=0.98,
						},
						srcBlendFunc = 1,
						tweenToNext = true,
						visible = true,
					},
					{
						alpha = 255,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 4,
						percentenable = false,
						perposition = 
						{
							x=0.61,
							y=55.46,
						},
						position = 
						{
							x=5,
							y=254,
						},
						rotate = 0,
						scale = 
						{
							x=1.02,
							y=1.02,
						},
						srcBlendFunc = 1,
						tweenToNext = true,
						visible = true,
					},
					{
						alpha = 255,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 6,
						percentenable = false,
						perposition = 
						{
							x=0.61,
							y=55.46,
						},
						position = 
						{
							x=5,
							y=254,
						},
						rotate = 0,
						scale = 
						{
							x=1,
							y=1,
						},
						srcBlendFunc = 1,
						tweenToNext = true,
						visible = true,
					},
				},
			},
		},
		Action3 = 
		{
			name = "Action3",
			FPS = 60,
			duration = 0.12,
			looptimes = 1,
			autoplay = false,
			{
				id = "Panel_feelling_info__Panel_right_Panel_base_Panel-DefaultMainLayer_Layer1_MainScene_Game",
				name = "Panel.Panel_base.Panel_right.Panel_feelling_info_",
				frames = 
				{
					
					{
						alpha = 255,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 0,
						percentenable = false,
						perposition = 
						{
							x=0.61,
							y=55.46,
						},
						position = 
						{
							x=5,
							y=254,
						},
						rotate = 0,
						scale = 
						{
							x=1,
							y=1,
						},
						srcBlendFunc = 1,
						tweenToNext = true,
						visible = true,
					},
					{
						alpha = 255,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 4,
						percentenable = false,
						perposition = 
						{
							x=0.61,
							y=55.46,
						},
						position = 
						{
							x=5,
							y=254,
						},
						rotate = 0,
						scale = 
						{
							x=1.02,
							y=1.02,
						},
						srcBlendFunc = 1,
						tweenToNext = true,
						visible = true,
					},
					{
						alpha = 0,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 7,
						percentenable = false,
						perposition = 
						{
							x=0.61,
							y=55.46,
						},
						position = 
						{
							x=5,
							y=254,
						},
						rotate = 0,
						scale = 
						{
							x=0.98,
							y=0.98,
						},
						srcBlendFunc = 1,
						tweenToNext = true,
						visible = true,
					},
				},
			},
		},
	},
	respaths = 
	{
		textures = 
		{
			"ui/mainLayer/new_ui/bg_nightfall.png",
			"dating/icon/banshenxiang_shixiang.png",
			"ui/mainLayer/new_ui_1/camera_logo.png",
			"ui/mainLayer/new_ui_1/top_bar_bg.png",
			"ui/mainLayer/new_ui_1/ui_008.png",
			"ui/playerInfo/avatar/TXBK_moren_0.png",
			"icon/hero/name/1101011.png",
			"ui/playerInfo/avatar/TXBK_moren_1.png",
			"ui/playerInfo/avatar/TXBK_1.png",
			"ui/mainLayer/new_ui_1/lvbg.png",
			"ui/mainLayer/new_ui_1/ui_007.png",
			"ui/mainLayer/new_ui_1/ui_006.png",
			"icon/hero/face/1101011.png",
			"ui/common/news_small.png",
			"ui/mainLayer/new_ui/ui_002.png",
			"ui/003.png",
			"ui/mainLayer/new_ui_1/btn_setting.png",
			"ui/mainLayer/new_ui/ui_004.png",
			"ui/newCity/build/9.png",
			"ui/mainLayer/new_ui/progress_01.png",
			"ui/mainLayer/new_ui/progress_02.png",
			"ui/common/button09.png",
			"ui/065.png",
			"ui/020.png",
			"ui/mainLayer/new_ui_1/btn_battle.png",
			"ui/028.png",
			"ui/mainLayer/new_ui/battle_text.png",
			"ui/mainLayer/new_ui/bai1.png",
			"ui/mainLayer/new_ui_1/btn_dating.png",
			"ui/027.png",
			"ui/mainui/arrow_r.png",
			"ui/920.png",
			"ui/mainLayer/new_ui/dating_text.png",
			"ui/mainLayer/new_ui_1/a3.png",
			"ui/mainLayer/new_ui_1/a3new.png",
			"ui/mainLayer/new_ui_1/btn_order.png",
			"ui/mainLayer/new_ui_1/btn_ordernew.png",
			"ui/mainLayer/new_ui_1/btn_tujian.png",
			"ui/mainLayer/new_ui_1/btn_tujiannew.png",
			"ui/mainui/main_infoStation.png",
			"ui/mainLayer/sxsr.png",
			"ui/mainui/main_mask.png",
			"ui/mainLayer/new_ui/bai2.png",
			"ui/mainLayer/new_ui/btn_guoqing.png",
			"ui/mainLayer/new_ui/activity_tab_01.png",
			"ui/mainLayer/new_ui/activity_tab_02.png",
			"ui/mainLayer/ad_btn.png",
			"ui/mainLayer/new_ui/a2.png",
			"ui/mainLayer/new_ui_1/btn_mail.png",
			"ui/mainui/mail_logo.png",
			"ui/mainLayer/new_ui_1/btn_mailnew.png",
			"ui/mail/special_mail/img_bubble.png",
			"ui/mainLayer3/c12.png",
			"ui/mainLayer3/c13.png",
			"ui/mainLayer3/35.png",
			"ui/mainLayer/new_ui/a4.png",
			"ui/mainLayer/new_ui/btn_ativity.png",
			"ui/mainLayer3/36.png",
			"ui/mainLayer/new_ui_1/btn_contact.png",
			"ui/mainLayer/new_ui_1/btn_contactnew.png",
			"ui/mainLayer/new_ui/a5.png",
			"ui/mainLayer/new_ui/a6.png",
			"ui/mainLayer/new_ui_4/rukou.png",
			"ui/activity/activityMain91/main_rukou.png",
			"ui/mainLayer/c2.png",
			"ui/mainLayer/L1.png",
			"ui/mainLayer/L3.png",
			"ui/mainLayer/L2.png",
			"ui/mainLayer/c3.png",
			"ui/mainLayer/c1.png",
			"ui/mainLayer/new_ui_1/bottombg.png",
			"ui/mainLayer/new_ui_1/ui_001.png",
			"ui/mainLayer/new_ui_1/iconbg.png",
			"ui/mainLayer/new_ui_1/btn_sprite.png",
			"ui/common/redPoint.png",
			"ui/fairy/new_ui/unlcok2.png",
			"ui/mainLayer/new_ui_1/btn_spritenew.png",
			"ui/mainLayer/new_ui_1/btn_bag.png",
			"ui/mainLayer/new_ui_1/btn_league.png",
			"ui/mainLayer/new_ui_1/btn_leaguenew.png",
			"ui/mainLayer/new_ui_1/btn_summon.png",
			"ui/mainLayer/new_ui_1/btn_summonnew.png",
			"ui/summon/024.png",
			"ui/summon/elf_contract/033.png",
			"ui/summon/elf_contract/034.png",
			"ui/001.png",
			"ui/mainLayer/new_ui_1/btn_phone.png",
			"ui/mainLayer/new_ui_1/btn_phonenew.png",
			"ui/mainLayer/new_ui_1/btn_store.png",
			"ui/mainLayer/new_ui_1/btn_recharge.png",
			"ui/recharge/new.png",
			"ui/ar/ar_acamer_26.png",
			"ui/mainLayer/new_ui_1/chat_bg.png",
			"ui/mainLayer/new_ui_1/btn_chat.png",
			"ui/mainLayer/new_ui/redpack_tips_bg.png",
			"ui/league/ui_10.png",
			"ui/mainLayer/a004.png",
			"ui/mainLayer/a002.png",
			"ui/mainLayer/a001.png",
			"ui/mainui/camera_logo.png",
			"ui/mainLayer/new_ui_1/res_bg.png",
			"icon/system/001.png",
			"ui/mainLayer/new_ui_1/jiahao.png",
			"icon/system/003.png",
			"icon/system/005.png",
			"ui/mainLayer/new_ui/a1.png",
			"ui/mainLayer/new_ui_1/btn_notice.png",
			"ui/mainui/notice_logo.png",
			"ui/mainLayer/new_ui_1/btn_noticenew.png",
			"ui/mainLayer/new_ui_1/btn_welfare.png",
			"ui/mainui/gift_logo.png",
			"ui/mainLayer/new_ui_1/btn_welfarenew.png",
			"ui/mainLayer/new_ui_1/btn_ativity.png",
			"ui/mainLayer/new_ui_1/btn_ativitynew.png",
			"ui/mainLayer/new_ui_1/btn_focus.png",
			"ui/mainLayer/new_ui_1/btn_focusnew.png",
			"ui/mainLayer/new_ui_1/044.png",
			"ui/mainLayer/new_ui_1/049.png",
			"ui/mainLayer/new_ui_1/btn_zhibo.png",
			"ui/mainLayer/new_ui_1/btn_zhibo_s.png",
			"ui/mainLayer/new_ui_1/a4.png",
			"ui/mainLayer/new_ui_1/a4new.png",
			"ui/mainLayer/new_ui/btn_assist.png",
			"ui/mainLayer/new_ui/btn_back.png",
			"ui/mainLayer/new_ui/btn_monthcard.png",
			"ui/mainLayer/new_ui_1/btn_tzr.png",
			"ui/mainLayer/new_ui_1/btn_tzrnew.png",
			"ui/mainLayer3/c1005.png",
			"ui/mainLayer/new_ui/btn_newPlayer.png",
			"ui/task/01/4.png",
			"ui/mainLayer/new_ui_1/003.png",
			"ui/mainLayer/new_ui_1/004.png",
			"ui/preview/main_btn.png",
			"ui/mainLayer/new_ui_1/btn_back.png",
			"ui/mainLayer/new_ui_1/btn_update.png",
			"ui/mainLayer/new_ui_1/btn_survey.png",
			"ui/mainLayer/new_ui_1/9small.png",
			"ui/mainLayer/new_ui_1/btn_zhuifan.png",
			"ui/mainLayer/new_ui_1/btn_phone_small.png",
			"ui/mainLayer/new_ui/btn_friendHelp.png",
			"ui/mainLayer/new_ui/ai_tip/001.png",
			"ui/mainLayer/new_ui/ai_tip/002.png",
			"ui/mainLayer/new_ui/ai_tip/003.png",
			"icon/hero/face/1108011.png",
			"ui/recharge/gifts/giftIcon/regression.png",
			"ui/mainLayer/new_ui/img_sub_bg.png",
			"ui/mainLayer/new_ui/img_zh_a.png",
			"ui/mainLayer/new_ui/img_zh_b.png",
			"ui/mainLayer/new_ui/btn_shop_a.png",
			"ui/mainLayer/new_ui/btn_shop_b.png",
			"ui/mainLayer/new_ui/btn_recharge_a.png",
			"ui/mainLayer/new_ui/btn_recharge_b.png",
			"ui/mainLayer/new_ui/btn_recharge_c.png",
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

