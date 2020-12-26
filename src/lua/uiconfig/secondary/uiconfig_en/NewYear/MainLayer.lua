local t = 
{
	version = 1,
	components = 
	{
		
		{
			controlID = "Panel-MainLayer_Layer1_NewYear_Game",
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
					controlID = "Panel_base_Panel-MainLayer_Layer1_NewYear_Game",
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
							controlID = "background_Panel_base_Panel-MainLayer_Layer1_NewYear_Game",
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
							srcBlendFunc = "770",
							texturePath = "ui/newyear/bg_newyear.png",
							touchAble = "False",
							UILayoutViewModel = 
							{
								PositionX = 568,
								PositionY = 318,
								relativeToName = "Panel",
							},
							width = "1386",
							ZOrder = "1",
							components = 
							{
								
								{
									controlID = "Spine_effectHB_background_Panel_base_Panel-MainLayer_Layer1_NewYear_Game",
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
										PositionX = 1,
									},
									ZOrder = "3",
								},
							},
						},
						{
							controlID = "Image_role_Panel_base_Panel-MainLayer_Layer1_NewYear_Game",
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
								PositionX = 329,
								PositionY = 195,
							},
							width = "2",
							ZOrder = "2",
						},
						{
							controlID = "Spine_effectH_Panel_base_Panel-MainLayer_Layer1_NewYear_Game",
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
								PositionX = 568,
								PositionY = 320,
							},
							visible = "False",
							ZOrder = "3",
						},
						{
							controlID = "Panel_top_Panel_base_Panel-MainLayer_Layer1_NewYear_Game",
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
									controlID = "Image_top_bar_bg_Panel_top_Panel_base_Panel-MainLayer_Layer1_NewYear_Game",
									UUID = "582172e0_1800_460f_a3c1_eac86eb13801",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "True;capInsetsX:0;capInsetsY:0;capInsetsWidth:0;capInsetsHeight:0",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "70",
									ignoreSize = "False",
									name = "Image_top_bar_bg",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/newyear/1.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = 568,
										PositionY = -35,
									},
									width = "1380",
									ZOrder = "1",
								},
								{
									controlID = "Panel_player_info_Panel_top_Panel_base_Panel-MainLayer_Layer1_NewYear_Game",
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
											controlID = "info_di_Panel_player_info_Panel_top_Panel_base_Panel-MainLayer_Layer1_NewYear_Game",
											UUID = "2475e93e_c5b9_4a31_9081_856cba38f559",
											anchorPoint = "False",
											anchorPointX = "0",
											anchorPointY = "1",
											backGroundScale9Enable = "True;capInsetsX:0;capInsetsY:0;capInsetsWidth:0;capInsetsHeight:0",
											classname = "MEImage",
											dstBlendFunc = "771",
											height = "62",
											ignoreSize = "False",
											name = "info_di",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											texturePath = "ui/mainLayer/new_ui/ui_008.png",
											touchAble = "False",
											UILayoutViewModel = 
											{
												
											},
											width = "270",
											ZOrder = "1",
										},
										{
											controlID = "Image_player_icon_bg_Panel_player_info_Panel_top_Panel_base_Panel-MainLayer_Layer1_NewYear_Game",
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
											controlID = "Image_player_icon_Panel_player_info_Panel_top_Panel_base_Panel-MainLayer_Layer1_NewYear_Game",
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
											controlID = "Image_icon_frame_Panel_player_info_Panel_top_Panel_base_Panel-MainLayer_Layer1_NewYear_Game",
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
											controlID = "Image_icon_cover_frame_Panel_player_info_Panel_top_Panel_base_Panel-MainLayer_Layer1_NewYear_Game",
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
											visible = "False",
											width = "140",
											ZOrder = "1",
										},
										{
											controlID = "Image_icon_cover_frame_newyear_Panel_player_info_Panel_top_Panel_base_Panel-MainLayer_Layer1_NewYear_Game",
											UUID = "2c754d29_c569_480c_a78f_fe338adf24f9",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											classname = "MEImage",
											dstBlendFunc = "771",
											height = "88",
											ignoreSize = "True",
											name = "Image_icon_cover_frame_newyear",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											texturePath = "ui/newyear/2.png",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 31,
												PositionY = -41,
											},
											width = "66",
											ZOrder = "1",
										},
										{
											controlID = "TextArea_name_Panel_player_info_Panel_top_Panel_base_Panel-MainLayer_Layer1_NewYear_Game",
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
											height = "24",
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
												PositionY = -32,
											},
											vAlignment = "0",
											width = "148",
											ZOrder = "1",
										},
										{
											controlID = "Panel_player_level_Panel_player_info_Panel_top_Panel_base_Panel-MainLayer_Layer1_NewYear_Game",
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
												PositionX = 239,
												PositionY = -30,
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
													controlID = "Label_Player_level_Panel_player_level_Panel_player_info_Panel_top_Panel_base_Panel-MainLayer_Layer1_NewYear_Game",
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
													width = "19",
													ZOrder = "1",
												},
												{
													controlID = "Image_Exp_bg_Panel_player_level_Panel_player_info_Panel_top_Panel_base_Panel-MainLayer_Layer1_NewYear_Game",
													UUID = "e2e50cbf_3f55_49b2_aa5b_71b09afd0529",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0.5",
													backGroundScale9Enable = "False",
													classname = "MEImage",
													dstBlendFunc = "771",
													height = "42",
													ignoreSize = "True",
													name = "Image_Exp_bg",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "1",
													texturePath = "ui/mainLayer/new_ui/ui_007.png",
													touchAble = "False",
													UILayoutViewModel = 
													{
														
													},
													width = "42",
													ZOrder = "1",
												},
												{
													controlID = "LoadingBar_Exp_Panel_player_level_Panel_player_info_Panel_top_Panel_base_Panel-MainLayer_Layer1_NewYear_Game",
													UUID = "542c52e7_9608_4e42_88f7_00ffd9b4a60f",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0.5",
													backGroundScale9Enable = "False",
													classname = "MELoadingBar",
													direction = "4",
													dstBlendFunc = "771",
													height = "42",
													ignoreSize = "True",
													name = "LoadingBar_Exp",
													percent = "100",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "1",
													texture = "ui/mainLayer/new_ui/ui_006.png",
													touchAble = "False",
													UILayoutViewModel = 
													{
														
													},
													width = "42",
													ZOrder = "1",
												},
											},
										},
										{
											controlID = "ClippingNode_Panel_player_info_Panel_top_Panel_base_Panel-MainLayer_Layer1_NewYear_Game",
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
													controlID = "Image_head_ClippingNode_Panel_player_info_Panel_top_Panel_base_Panel-MainLayer_Layer1_NewYear_Game",
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
									},
								},
								{
									controlID = "Panel_system_Panel_top_Panel_base_Panel-MainLayer_Layer1_NewYear_Game",
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
											controlID = "Image_system_bg_Panel_system_Panel_top_Panel_base_Panel-MainLayer_Layer1_NewYear_Game",
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
											controlID = "TextArea_system_Panel_system_Panel_top_Panel_base_Panel-MainLayer_Layer1_NewYear_Game",
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
											width = "583",
											ZOrder = "1",
										},
									},
								},
								{
									controlID = "Image_camera_Panel_top_Panel_base_Panel-MainLayer_Layer1_NewYear_Game",
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
										PositionX = 344,
										PositionY = -32,
									},
									width = "46",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "Button_camera_Image_camera_Panel_top_Panel_base_Panel-MainLayer_Layer1_NewYear_Game",
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
											height = "54",
											ignoreSize = "True",
											name = "Button_camera",
											normal = "ui/mainui/camera_logo.png",
											pressed = "ui/mainui/camera_logo.png",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "True",
											UILayoutViewModel = 
											{
												PositionY = -2,
											},
											UItype = "Button",
											width = "66",
											ZOrder = "1",
										},
									},
								},
								{
									controlID = "Button_setting_Panel_top_Panel_base_Panel-MainLayer_Layer1_NewYear_Game",
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
									height = "52",
									ignoreSize = "True",
									name = "Button_setting",
									normal = "ui/mainLayer/new_ui/btn_setting.png",
									pressed = "ui/mainLayer/new_ui/btn_setting.png",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "True",
									UILayoutViewModel = 
									{
										PositionX = 1094,
										PositionY = -34,
									},
									UItype = "Button",
									width = "62",
									ZOrder = "3",
									components = 
									{
										
										{
											controlID = "Label_MainLayer_1_Button_setting_Panel_top_Panel_base_Panel-MainLayer_Layer1_NewYear_Game",
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
											width = "43",
											ZOrder = "1",
										},
									},
								},
							},
						},
						{
							controlID = "Panel_right_Panel_base_Panel-MainLayer_Layer1_NewYear_Game",
							UUID = "97ccbe3e_1dee_4cc4_8f1c_4345479cf24f",
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
								PositionX = 433,
								PositionY = 100,
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
									controlID = "Panel_feelling_info_Panel_right_Panel_base_Panel-MainLayer_Layer1_NewYear_Game",
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
									name = "Panel_feelling_info",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = 5,
										PositionY = 254,
									},
									uipanelviewmodel = 
									{
										Layout="Absolute",
										nType = "0"
									},
									width = "290",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "Image_feelling_bg_Panel_feelling_info_Panel_right_Panel_base_Panel-MainLayer_Layer1_NewYear_Game",
											UUID = "ad023456_1a00_4214_9aae_287a7e6fe225",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											classname = "MEImage",
											dstBlendFunc = "771",
											height = "106",
											ignoreSize = "True",
											name = "Image_feelling_bg",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											texturePath = "ui/mainLayer/new_ui/ui_004.png",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 145,
												PositionY = 53,
											},
											width = "290",
											ZOrder = "1",
										},
										{
											controlID = "Image_feelling_icon_Panel_feelling_info_Panel_right_Panel_base_Panel-MainLayer_Layer1_NewYear_Game",
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
											controlID = "Label_feelling_name_Panel_feelling_info_Panel_right_Panel_base_Panel-MainLayer_Layer1_NewYear_Game",
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
											height = "30",
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
											width = "123",
											ZOrder = "1",
										},
										{
											controlID = "Label_feelling_level_Panel_feelling_info_Panel_right_Panel_base_Panel-MainLayer_Layer1_NewYear_Game",
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
											width = "16",
											ZOrder = "1",
										},
										{
											controlID = "Label_feelling_reach_max_Panel_feelling_info_Panel_right_Panel_base_Panel-MainLayer_Layer1_NewYear_Game",
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
											width = "219",
											ZOrder = "1",
										},
										{
											controlID = "Image_progress_bg_Panel_feelling_info_Panel_right_Panel_base_Panel-MainLayer_Layer1_NewYear_Game",
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
											controlID = "LoadingBar_feelling_bar_Panel_feelling_info_Panel_right_Panel_base_Panel-MainLayer_Layer1_NewYear_Game",
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
											controlID = "Label_feelling_percent_Panel_feelling_info_Panel_right_Panel_base_Panel-MainLayer_Layer1_NewYear_Game",
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
											width = "48",
											ZOrder = "1",
										},
										{
											controlID = "Button_feellint_edit_Panel_feelling_info_Panel_right_Panel_base_Panel-MainLayer_Layer1_NewYear_Game",
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
												PositionX = 258,
												PositionY = 53,
											},
											UItype = "Button",
											width = "45",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "Label_MainLayer_1_Button_feellint_edit_Panel_feelling_info_Panel_right_Panel_base_Panel-MainLayer_Layer1_NewYear_Game",
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
									controlID = "Panel_clip_Panel_right_Panel_base_Panel-MainLayer_Layer1_NewYear_Game",
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
										PositionX = -18,
										PositionY = -2,
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
											controlID = "Image_bottom_Panel_clip_Panel_right_Panel_base_Panel-MainLayer_Layer1_NewYear_Game",
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
													controlID = "Image_activity_bottom_Image_bottom_Panel_clip_Panel_right_Panel_base_Panel-MainLayer_Layer1_NewYear_Game",
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
											controlID = "Image_z_y_bottom_Panel_clip_Panel_right_Panel_base_Panel-MainLayer_Layer1_NewYear_Game",
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
											controlID = "Button_zuozhan_Panel_clip_Panel_right_Panel_base_Panel-MainLayer_Layer1_NewYear_Game",
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
											normal = "ui/newyear/22.png",
											pressed = "ui/newyear/22.png",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "True",
											UILayoutViewModel = 
											{
												PositionX = 577,
												PositionY = 143,
											},
											UItype = "Button",
											width = "240",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "Image_zuozhan_Button_zuozhan_Panel_clip_Panel_right_Panel_base_Panel-MainLayer_Layer1_NewYear_Game",
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
											controlID = "Image_text_Panel_clip_Panel_right_Panel_base_Panel-MainLayer_Layer1_NewYear_Game",
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
											texturePath = "ui/newyear/23.png",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 579,
												PositionY = 44,
											},
											width = "82",
											ZOrder = "1",
										},
										{
											controlID = "Image_MainLayer_1(2)_Panel_clip_Panel_right_Panel_base_Panel-MainLayer_Layer1_NewYear_Game",
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
												PositionX = 578,
												PositionY = 142,
											},
											width = "166",
											ZOrder = "1",
										},
										{
											controlID = "Panelzuozhan_Panel_clip_Panel_right_Panel_base_Panel-MainLayer_Layer1_NewYear_Game",
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
											visible = "False",
											width = "200",
											ZOrder = "1",
										},
										{
											controlID = "button_yuehui_Panel_clip_Panel_right_Panel_base_Panel-MainLayer_Layer1_NewYear_Game",
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
											normal = "ui/newyear/20.png",
											pressed = "ui/newyear/20.png",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "True",
											UILayoutViewModel = 
											{
												PositionX = 366,
												PositionY = 143,
											},
											UItype = "Button",
											width = "240",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "Image_yuehui_button_yuehui_Panel_clip_Panel_right_Panel_base_Panel-MainLayer_Layer1_NewYear_Game",
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
													controlID = "Image_startIcon1_button_yuehui_Panel_clip_Panel_right_Panel_base_Panel-MainLayer_Layer1_NewYear_Game",
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
													controlID = "Image_yuehuiRedTips_button_yuehui_Panel_clip_Panel_right_Panel_base_Panel-MainLayer_Layer1_NewYear_Game",
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
											controlID = "Image_MainLayer_1(4)_Panel_clip_Panel_right_Panel_base_Panel-MainLayer_Layer1_NewYear_Game",
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
											texturePath = "ui/newyear/21.png",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 365,
												PositionY = 46,
											},
											width = "82",
											ZOrder = "1",
										},
										{
											controlID = "Image_MainLayer_1_Panel_clip_Panel_right_Panel_base_Panel-MainLayer_Layer1_NewYear_Game",
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
												PositionX = 366,
												PositionY = 141,
											},
											width = "166",
											ZOrder = "1",
										},
										{
											controlID = "Panelyuehui_Panel_clip_Panel_right_Panel_base_Panel-MainLayer_Layer1_NewYear_Game",
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
											visible = "False",
											width = "183",
											ZOrder = "1",
										},
										{
											controlID = "Panel_task_Panel_clip_Panel_right_Panel_base_Panel-MainLayer_Layer1_NewYear_Game",
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
											controlID = "Button_task_Panel_clip_Panel_right_Panel_base_Panel-MainLayer_Layer1_NewYear_Game",
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
											height = "80",
											ignoreSize = "True",
											name = "Button_task",
											normal = "ui/newyear/25.png",
											pressed = "ui/newyear/25.png",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "True",
											UILayoutViewModel = 
											{
												PositionX = 574,
												PositionY = 313,
											},
											UItype = "Button",
											width = "80",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "TextArea_Game_2_Button_task_Panel_clip_Panel_right_Panel_base_Panel-MainLayer_Layer1_NewYear_Game",
													UUID = "e26e7de0_8378_4303_822a_34ac05ece248",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0.5",
													classname = "METextArea",
													ColorMixing = "#FFECDDB4",
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
													fontSize = "22",
													fontStroke = 
													{
														IsStroke = true,
														StrokeColor = "#FF2F0B0B",
														StrokeSize = 1,
													},
													hAlignment = "1",
													height = "29",
													ignoreSize = "True",
													name = "TextArea_Game_2",
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
													width = "48",
													ZOrder = "1",
												},
												{
													controlID = "Image_taskTips_Button_task_Panel_clip_Panel_right_Panel_base_Panel-MainLayer_Layer1_NewYear_Game",
													UUID = "38b270cf_3283_42b7_92e8_528b461c3532",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0.5",
													backGroundScale9Enable = "False",
													classname = "MEImage",
													dstBlendFunc = "771",
													height = "30",
													ignoreSize = "True",
													name = "Image_taskTips",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "1",
													texturePath = "ui/common/news_small.png",
													touchAble = "False",
													UILayoutViewModel = 
													{
														PositionX = 30,
														PositionY = 20,
													},
													width = "30",
													ZOrder = "1",
												},
											},
										},
										{
											controlID = "Button_friend_Panel_clip_Panel_right_Panel_base_Panel-MainLayer_Layer1_NewYear_Game",
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
											height = "80",
											ignoreSize = "True",
											name = "Button_friend",
											normal = "ui/newyear/11.png",
											pressed = "ui/newyear/11.png",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "True",
											UILayoutViewModel = 
											{
												PositionX = 472,
												PositionY = 294,
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
													controlID = "Label_title_Button_friend_Panel_clip_Panel_right_Panel_base_Panel-MainLayer_Layer1_NewYear_Game",
													UUID = "487a51f9_0078_43af_8a11_fa3f2463278f",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0.5",
													classname = "MELabel",
													compPath = "luacomponents.common.MEIconLabel",
													dstBlendFunc = "771",
													FontColor = "#FFECDDB4",
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
														IsStroke = true,
														StrokeColor = "#FF2F0B0B",
														StrokeSize = 1,
													},
													height = "29",
													ignoreSize = "True",
													name = "Label_title",
													nTextAlign = "1",
													nTextHAlign = "1",
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
													width = "48",
													ZOrder = "1",
												},
												{
													controlID = "Image_friendTip_Button_friend_Panel_clip_Panel_right_Panel_base_Panel-MainLayer_Layer1_NewYear_Game",
													UUID = "3cb3ff17_33bd_485f_a28c_7d381f7aaff9",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0.5",
													backGroundScale9Enable = "False",
													classname = "MEImage",
													dstBlendFunc = "771",
													height = "30",
													ignoreSize = "True",
													name = "Image_friendTip",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "1",
													texturePath = "ui/common/news_small.png",
													touchAble = "False",
													UILayoutViewModel = 
													{
														PositionX = 30,
														PositionY = 20,
													},
													width = "30",
													ZOrder = "1",
												},
											},
										},
										{
											controlID = "Button_pokedex_Panel_clip_Panel_right_Panel_base_Panel-MainLayer_Layer1_NewYear_Game",
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
											height = "80",
											ignoreSize = "True",
											name = "Button_pokedex",
											normal = "ui/newyear/17.png",
											pressed = "ui/newyear/17.png",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "True",
											UILayoutViewModel = 
											{
												PositionX = 366,
												PositionY = 313,
											},
											UItype = "Button",
											width = "80",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "TextArea_Game_2_Button_pokedex_Panel_clip_Panel_right_Panel_base_Panel-MainLayer_Layer1_NewYear_Game",
													UUID = "c5764d3e_91f2_43bf_b10f_ee5d99e5558d",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0.5",
													classname = "METextArea",
													ColorMixing = "#FFECDDB4",
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
													fontSize = "22",
													fontStroke = 
													{
														IsStroke = true,
														StrokeColor = "#FF2F0B0C",
														StrokeSize = 1,
													},
													hAlignment = "1",
													height = "29",
													ignoreSize = "True",
													name = "TextArea_Game_2",
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
													width = "48",
													ZOrder = "1",
												},
												{
													controlID = "Image_poker_tip_Button_pokedex_Panel_clip_Panel_right_Panel_base_Panel-MainLayer_Layer1_NewYear_Game",
													UUID = "346ac5a8_4435_412b_b604_4cb2169fe7d4",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0.5",
													backGroundScale9Enable = "False",
													classname = "MEImage",
													dstBlendFunc = "771",
													height = "30",
													ignoreSize = "True",
													name = "Image_poker_tip",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "1",
													texturePath = "ui/common/news_small.png",
													touchAble = "False",
													UILayoutViewModel = 
													{
														PositionX = 33,
														PositionY = 27,
													},
													width = "30",
													ZOrder = "1",
												},
											},
										},
										{
											controlID = "btn_infoStation_Panel_clip_Panel_right_Panel_base_Panel-MainLayer_Layer1_NewYear_Game",
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
											width = "88",
											ZOrder = "1",
										},
										{
											controlID = "Image_MainLayer_1(5)_Panel_clip_Panel_right_Panel_base_Panel-MainLayer_Layer1_NewYear_Game",
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
											width = "92",
											ZOrder = "1",
										},
										{
											controlID = "Image_MainLayer_1(3)(3)_Panel_clip_Panel_right_Panel_base_Panel-MainLayer_Layer1_NewYear_Game",
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
											width = "68",
											ZOrder = "1",
										},
										{
											controlID = "Image_MainLayer_1(3)(2)_Panel_clip_Panel_right_Panel_base_Panel-MainLayer_Layer1_NewYear_Game",
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
											width = "68",
											ZOrder = "1",
										},
										{
											controlID = "Image_MainLayer_1(3)_Panel_clip_Panel_right_Panel_base_Panel-MainLayer_Layer1_NewYear_Game",
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
												PositionX = 367,
												PositionY = 313,
											},
											width = "68",
											ZOrder = "1",
										},
										{
											controlID = "Panel_activity_Panel_clip_Panel_right_Panel_base_Panel-MainLayer_Layer1_NewYear_Game",
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
												PositionX = 477,
												PositionY = 407,
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
													controlID = "activity_1_Panel_activity_Panel_clip_Panel_right_Panel_base_Panel-MainLayer_Layer1_NewYear_Game",
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
													controlID = "Label_activity_time_Panel_activity_Panel_clip_Panel_right_Panel_base_Panel-MainLayer_Layer1_NewYear_Game",
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
													width = "193",
													ZOrder = "1",
												},
												{
													controlID = "Image_dot1_Panel_activity_Panel_clip_Panel_right_Panel_base_Panel-MainLayer_Layer1_NewYear_Game",
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
													controlID = "Image_dot2_Panel_activity_Panel_clip_Panel_right_Panel_base_Panel-MainLayer_Layer1_NewYear_Game",
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
													controlID = "Image_dot3_Panel_activity_Panel_clip_Panel_right_Panel_base_Panel-MainLayer_Layer1_NewYear_Game",
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
													controlID = "Image_dot4_Panel_activity_Panel_clip_Panel_right_Panel_base_Panel-MainLayer_Layer1_NewYear_Game",
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
													controlID = "PageView_Activity_Panel_activity_Panel_clip_Panel_right_Panel_base_Panel-MainLayer_Layer1_NewYear_Game",
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
														PositionX = -218,
														PositionY = -47,
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
													controlID = "Image_dot5_Panel_activity_Panel_clip_Panel_right_Panel_base_Panel-MainLayer_Layer1_NewYear_Game",
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
													controlID = "Image_dot6_Panel_activity_Panel_clip_Panel_right_Panel_base_Panel-MainLayer_Layer1_NewYear_Game",
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
													controlID = "Image_dot7_Panel_activity_Panel_clip_Panel_right_Panel_base_Panel-MainLayer_Layer1_NewYear_Game",
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
													controlID = "Image_dot8_Panel_activity_Panel_clip_Panel_right_Panel_base_Panel-MainLayer_Layer1_NewYear_Game",
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
													controlID = "Image_dot9_Panel_activity_Panel_clip_Panel_right_Panel_base_Panel-MainLayer_Layer1_NewYear_Game",
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
											},
										},
									},
								},
							},
						},
						{
							controlID = "Panel_bottom_Panel_base_Panel-MainLayer_Layer1_NewYear_Game",
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
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							touchAble = "False",
							UILayoutViewModel = 
							{
								PositionX = 500,
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
									controlID = "Image_fairyMain_1_Panel_bottom_Panel_base_Panel-MainLayer_Layer1_NewYear_Game",
									UUID = "384cc13b_023f_4d76_89b2_2d26336637f0",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "17",
									ignoreSize = "True",
									name = "Image_fairyMain_1",
									opacity = "50",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/mainLayer/new_ui/ui_001.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = 117,
										PositionY = 21,
									},
									width = "2",
									ZOrder = "1",
								},
								{
									controlID = "Button_fairy_Panel_bottom_Panel_base_Panel-MainLayer_Layer1_NewYear_Game",
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
									height = "100",
									ignoreSize = "True",
									name = "Button_fairy",
									normal = "ui/newyear/31.png",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "True",
									UILayoutViewModel = 
									{
										PositionX = -37,
										PositionY = 48,
									},
									UItype = "Button",
									width = "100",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "Label_Game_1_Button_fairy_Panel_bottom_Panel_base_Panel-MainLayer_Layer1_NewYear_Game",
											UUID = "e15be4a7_a553_4abf_8d1e_4ce6182ec686",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											classname = "MELabel",
											compPath = "luacomponents.common.MEIconLabel",
											dstBlendFunc = "771",
											FontColor = "#FFECDDB4",
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
												StrokeColor = "#FF2F0B0C",
												StrokeSize = 1,
											},
											height = "32",
											ignoreSize = "True",
											name = "Label_Game_1",
											nTextAlign = "1",
											nTextHAlign = "1",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "770",
											text = "Spirit",
											touchAble = "False",
											touchScaleEnable = "False",
											UILayoutViewModel = 
											{
												PositionY = -34,
											},
											width = "52",
											ZOrder = "1",
										},
										{
											controlID = "Image_fairy_Button_fairy_Panel_bottom_Panel_base_Panel-MainLayer_Layer1_NewYear_Game",
											UUID = "7a265898_a1df_45cd_b019_b543196bf4a9",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											classname = "MEImage",
											dstBlendFunc = "771",
											height = "70",
											ignoreSize = "True",
											name = "Image_fairy",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											texturePath = "ui/newyear/10.png",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionY = 8,
											},
											width = "70",
											ZOrder = "1",
										},
										{
											controlID = "RedTips_Button_fairy_Panel_bottom_Panel_base_Panel-MainLayer_Layer1_NewYear_Game",
											UUID = "ae2ce35a_2a8b_4c16_99b9_01734dd7781b",
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
									},
								},
								{
									controlID = "Image_fairyMain_1(2)_Panel_bottom_Panel_base_Panel-MainLayer_Layer1_NewYear_Game",
									UUID = "1ae7dd5b_c3b3_4158_b128_a39e1bfb6710",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "17",
									ignoreSize = "True",
									name = "Image_fairyMain_1(2)",
									opacity = "50",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/mainLayer/new_ui/ui_001.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = 220,
										PositionY = 21,
									},
									width = "2",
									ZOrder = "1",
								},
								{
									controlID = "Button_bag_Panel_bottom_Panel_base_Panel-MainLayer_Layer1_NewYear_Game",
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
									height = "100",
									ignoreSize = "True",
									name = "Button_bag",
									normal = "ui/newyear/31.png",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "True",
									UILayoutViewModel = 
									{
										PositionX = 66,
										PositionY = 48,
									},
									UItype = "Button",
									width = "100",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "Image_bag_Button_bag_Panel_bottom_Panel_base_Panel-MainLayer_Layer1_NewYear_Game",
											UUID = "1d64651c_c60a_41f1_8ec8_825cf71a12cf",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											classname = "MEImage",
											dstBlendFunc = "771",
											height = "52",
											ignoreSize = "True",
											name = "Image_bag",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											texturePath = "ui/newyear/28.png",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionY = 8,
											},
											width = "39",
											ZOrder = "1",
										},
										{
											controlID = "Label_Game_1-Copy1_Button_bag_Panel_bottom_Panel_base_Panel-MainLayer_Layer1_NewYear_Game",
											UUID = "af4e44ae_f41a_4dd9_aa9e_d7d64919be51",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											classname = "MELabel",
											compPath = "luacomponents.common.MEIconLabel",
											dstBlendFunc = "771",
											FontColor = "#FFECDDB4",
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
												StrokeColor = "#FF2F0B0C",
												StrokeSize = 1,
											},
											height = "32",
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
												PositionY = -34,
											},
											width = "51",
											ZOrder = "1",
										},
									},
								},
								{
									controlID = "Image_fairyMain_1(3)_Panel_bottom_Panel_base_Panel-MainLayer_Layer1_NewYear_Game",
									UUID = "452af667_7eac_4ac3_b88b_f6893e8fa647",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "17",
									ignoreSize = "True",
									name = "Image_fairyMain_1(3)",
									opacity = "50",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/mainLayer/new_ui/ui_001.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = 323,
										PositionY = 21,
									},
									width = "2",
									ZOrder = "1",
								},
								{
									controlID = "Button_league_Panel_bottom_Panel_base_Panel-MainLayer_Layer1_NewYear_Game",
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
									height = "100",
									ignoreSize = "True",
									name = "Button_league",
									normal = "ui/newyear/31.png",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "True",
									UILayoutViewModel = 
									{
										PositionX = 169,
										PositionY = 48,
									},
									UItype = "Button",
									width = "100",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "Label_Game_1-Copy2_Button_league_Panel_bottom_Panel_base_Panel-MainLayer_Layer1_NewYear_Game",
											UUID = "3af076a2_fbcd_4a1e_b558_82a7cd6551e7",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											classname = "MELabel",
											compPath = "luacomponents.common.MEIconLabel",
											dstBlendFunc = "771",
											FontColor = "#FFECDDB4",
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
												StrokeColor = "#FF2F0B0C",
												StrokeSize = 1,
											},
											height = "32",
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
												PositionY = -34,
											},
											width = "51",
											ZOrder = "1",
										},
										{
											controlID = "Image_shetuan_Button_league_Panel_bottom_Panel_base_Panel-MainLayer_Layer1_NewYear_Game",
											UUID = "eac8aa48_d1b6_4610_b5ca_f85a16c8f383",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											classname = "MEImage",
											dstBlendFunc = "771",
											height = "70",
											ignoreSize = "True",
											name = "Image_shetuan",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											texturePath = "ui/newyear/32.png",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionY = 8,
											},
											width = "70",
											ZOrder = "1",
										},
										{
											controlID = "RedTips_Button_league_Panel_bottom_Panel_base_Panel-MainLayer_Layer1_NewYear_Game",
											UUID = "4868402a_9204_4e7f_974b_3a7bb6e63831",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											classname = "MEImage",
											dstBlendFunc = "771",
											height = "30",
											ignoreSize = "True",
											name = "RedTips",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											texturePath = "ui/common/news_small.png",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 23,
												PositionY = 34,
											},
											visible = "False",
											width = "30",
											ZOrder = "5",
										},
									},
								},
								{
									controlID = "Button_zhaohuan_Panel_bottom_Panel_base_Panel-MainLayer_Layer1_NewYear_Game",
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
									height = "100",
									ignoreSize = "True",
									name = "Button_zhaohuan",
									normal = "ui/newyear/31.png",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "True",
									UILayoutViewModel = 
									{
										PositionX = 272,
										PositionY = 48,
									},
									UItype = "Button",
									width = "100",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "Label_Game_1-Copy3_Button_zhaohuan_Panel_bottom_Panel_base_Panel-MainLayer_Layer1_NewYear_Game",
											UUID = "ba4b926b_ac62_43aa_89e4_cea0528e07c4",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											classname = "MELabel",
											compPath = "luacomponents.common.MEIconLabel",
											dstBlendFunc = "771",
											FontColor = "#FFECDDB4",
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
												StrokeColor = "#FF2F0B0C",
												StrokeSize = 1,
											},
											height = "32",
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
												PositionY = -34,
											},
											width = "52",
											ZOrder = "1",
										},
										{
											controlID = "Image_zhaohuan_Button_zhaohuan_Panel_bottom_Panel_base_Panel-MainLayer_Layer1_NewYear_Game",
											UUID = "3c1f3af1_ad6c_4cd6_81e4_936b368c5d05",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											classname = "MEImage",
											dstBlendFunc = "771",
											height = "70",
											ignoreSize = "True",
											name = "Image_zhaohuan",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											texturePath = "ui/newyear/24.png",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionY = 8,
											},
											width = "70",
											ZOrder = "1",
										},
										{
											controlID = "Image_summon_tip_Button_zhaohuan_Panel_bottom_Panel_base_Panel-MainLayer_Layer1_NewYear_Game",
											UUID = "0e4c21ad_1b7d_4aad_8072_a5f55048c3f8",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											classname = "MEImage",
											dstBlendFunc = "771",
											height = "30",
											ignoreSize = "True",
											name = "Image_summon_tip",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											texturePath = "ui/common/news_small.png",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 24,
												PositionY = 33,
											},
											width = "30",
											ZOrder = "1",
										},
									},
								},
								{
									controlID = "Button_phone_Panel_bottom_Panel_base_Panel-MainLayer_Layer1_NewYear_Game",
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
									height = "166",
									ignoreSize = "True",
									name = "Button_phone",
									normal = "ui/newyear/15.png",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "True",
									UILayoutViewModel = 
									{
										PositionX = 574,
										PositionY = 65,
									},
									UItype = "Button",
									width = "166",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "Label_Game_1-Copy4_Button_phone_Panel_bottom_Panel_base_Panel-MainLayer_Layer1_NewYear_Game",
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
											width = "51",
											ZOrder = "1",
										},
										{
											controlID = "Spine_phone_Button_phone_Panel_bottom_Panel_base_Panel-MainLayer_Layer1_NewYear_Game",
											UUID = "3ecdcaa3_c7a1_4114_88eb_0950cd41fbf9",
											classname = "MESpine",
											dstBlendFunc = "771",
											name = "Spine_phone",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											spineModel = 
											{
												SpinePath = "effect/effect_dating_phone/effect_dating_phone",
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
												PositionX = -2,
												PositionY = -62,
											},
											ZOrder = "1",
										},
										{
											controlID = "Image_newtip_Button_phone_Panel_bottom_Panel_base_Panel-MainLayer_Layer1_NewYear_Game",
											UUID = "9073f70b_4783_45d2_9734_c2ab8a6ef215",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											classname = "MEImage",
											dstBlendFunc = "771",
											height = "30",
											ignoreSize = "True",
											name = "Image_newtip",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											texturePath = "ui/common/news_small.png",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 33,
												PositionY = 27,
											},
											width = "30",
											ZOrder = "1",
										},
										{
											controlID = "Image_phonebg_Button_phone_Panel_bottom_Panel_base_Panel-MainLayer_Layer1_NewYear_Game",
											UUID = "a2c32294_8b41_414c_a3c7_9bde377cac23",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											classname = "MEImage",
											dstBlendFunc = "771",
											height = "78",
											ignoreSize = "True",
											name = "Image_phonebg",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											texturePath = "ui/newyear/16.png",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 54,
												PositionY = -29,
											},
											width = "249",
											ZOrder = "-10",
										},
									},
								},
								{
									controlID = "Button_shop_Panel_bottom_Panel_base_Panel-MainLayer_Layer1_NewYear_Game",
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
									height = "100",
									ignoreSize = "True",
									name = "Button_shop",
									normal = "ui/newyear/31.png",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "True",
									UILayoutViewModel = 
									{
										PositionX = 375,
										PositionY = 48,
									},
									UItype = "Button",
									width = "100",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "TextArea_Game_2_Button_shop_Panel_bottom_Panel_base_Panel-MainLayer_Layer1_NewYear_Game",
											UUID = "8fd33681_81b2_421b_a133_2125de5a86d9",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											classname = "METextArea",
											ColorMixing = "#FFECDDB4",
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
											fontSize = "24",
											fontStroke = 
											{
												IsStroke = true,
												StrokeColor = "#FF2F0B0C",
												StrokeSize = 1,
											},
											hAlignment = "1",
											height = "32",
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
												PositionY = -34,
											},
											vAlignment = "1",
											width = "51",
											ZOrder = "1",
										},
										{
											controlID = "Image_shop_Button_shop_Panel_bottom_Panel_base_Panel-MainLayer_Layer1_NewYear_Game",
											UUID = "7c15974d_dc18_4c40_91e5_7d14c154c8c0",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											classname = "MEImage",
											dstBlendFunc = "771",
											height = "70",
											ignoreSize = "True",
											name = "Image_shop",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											texturePath = "ui/newyear/14.png",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionY = 8,
											},
											width = "70",
											ZOrder = "1",
										},
									},
								},
								{
									controlID = "Image_split_line_Panel_bottom_Panel_base_Panel-MainLayer_Layer1_NewYear_Game",
									UUID = "6f5d2e2e_ac2e_42cc_afc1_c231c23d5132",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "17",
									ignoreSize = "True",
									name = "Image_split_line",
									opacity = "50",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/mainLayer/new_ui/ui_001.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = 426,
										PositionY = 21,
									},
									width = "2",
									ZOrder = "1",
								},
								{
									controlID = "Button_recharge_Panel_bottom_Panel_base_Panel-MainLayer_Layer1_NewYear_Game",
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
									height = "100",
									ignoreSize = "True",
									name = "Button_recharge",
									normal = "ui/newyear/31.png",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "True",
									UILayoutViewModel = 
									{
										PositionX = 478,
										PositionY = 48,
									},
									UItype = "Button",
									width = "100",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "TextArea_Game_2_Button_recharge_Panel_bottom_Panel_base_Panel-MainLayer_Layer1_NewYear_Game",
											UUID = "83248fec_e1dd_43d9_8e1d_06ac4e5e8d99",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											classname = "METextArea",
											ColorMixing = "#FFECDDB4",
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
											fontSize = "24",
											fontStroke = 
											{
												IsStroke = true,
												StrokeColor = "#FF2F0B0C",
												StrokeSize = 1,
											},
											hAlignment = "1",
											height = "32",
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
												PositionY = -34,
											},
											vAlignment = "1",
											width = "53",
											ZOrder = "1",
										},
										{
											controlID = "Image_recharge_Button_recharge_Panel_bottom_Panel_base_Panel-MainLayer_Layer1_NewYear_Game",
											UUID = "e5ecdb9a_efd4_4d2c_b908_45a338d7ef99",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											classname = "MEImage",
											dstBlendFunc = "771",
											height = "57",
											ignoreSize = "True",
											name = "Image_recharge",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											texturePath = "ui/newyear/29.png",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionY = 8,
											},
											width = "55",
											ZOrder = "1",
										},
										{
											controlID = "Image_MainLayer_new_Button_recharge_Panel_bottom_Panel_base_Panel-MainLayer_Layer1_NewYear_Game",
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
												PositionX = 29,
												PositionY = 44,
											},
											width = "85",
											ZOrder = "1",
										},
									},
								},
								{
									controlID = "Image_fairyMain_1-Copy1_Panel_bottom_Panel_base_Panel-MainLayer_Layer1_NewYear_Game",
									UUID = "396995e1_7f7e_41d0_9b96_e506f176ae0f",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "17",
									ignoreSize = "True",
									name = "Image_fairyMain_1-Copy1",
									opacity = "50",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/mainLayer/new_ui/ui_001.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = 14,
										PositionY = 21,
									},
									width = "2",
									ZOrder = "1",
								},
							},
						},
						{
							controlID = "Panel_chat_Panel_base_Panel-MainLayer_Layer1_NewYear_Game",
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
								PositionY = 14,
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
									controlID = "Image_chat_bg_Panel_chat_Panel_base_Panel-MainLayer_Layer1_NewYear_Game",
									UUID = "188a437d_9810_40e1_8ca7_aaf68a33c13c",
									anchorPoint = "False",
									anchorPointX = "0",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "52",
									ignoreSize = "True",
									name = "Image_chat_bg",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/newyear/13.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = 42,
										PositionY = 14,
									},
									width = "310",
									ZOrder = "1",
								},
								{
									controlID = "Panel_chat_di_Panel_chat_Panel_base_Panel-MainLayer_Layer1_NewYear_Game",
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
										PositionY = 15,
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
											controlID = "Label_message_Panel_chat_di_Panel_chat_Panel_base_Panel-MainLayer_Layer1_NewYear_Game",
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
									controlID = "Image_chat_Panel_chat_Panel_base_Panel-MainLayer_Layer1_NewYear_Game",
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
									height = "54",
									ignoreSize = "True",
									name = "Image_chat",
									normal = "ui/newyear/12.png",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "True",
									UILayoutViewModel = 
									{
										PositionX = 34,
										PositionY = 16,
									},
									UItype = "Button",
									width = "54",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "Image_redPack_tips_Image_chat_Panel_chat_Panel_base_Panel-MainLayer_Layer1_NewYear_Game",
											UUID = "176a761b_1d6d_4c3a_8e07_753cc5e78455",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											classname = "MEImage",
											dstBlendFunc = "771",
											height = "85",
											ignoreSize = "True",
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
											width = "89",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "Image_red_icon_Image_redPack_tips_Image_chat_Panel_chat_Panel_base_Panel-MainLayer_Layer1_NewYear_Game",
													UUID = "57bc91f8_86a8_4f41_8f4a_4b6d9812fc32",
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
													controlID = "Label_redpack_get_Image_redPack_tips_Image_chat_Panel_chat_Panel_base_Panel-MainLayer_Layer1_NewYear_Game",
													UUID = "2762dd94_ef83_4de2_aa47_2bbaf2f239c5",
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
													width = "63",
													ZOrder = "1",
												},
											},
										},
										{
											controlID = "Image_redPoint_Image_chat_Panel_chat_Panel_base_Panel-MainLayer_Layer1_NewYear_Game",
											UUID = "0ffb561c_0fce_401d_bad9_2d55fb55dc96",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											classname = "MEImage",
											dstBlendFunc = "771",
											height = "2",
											ignoreSize = "True",
											name = "Image_redPoint",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											texturePath = "ui/common/redPoint.png",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 23,
												PositionY = 21,
											},
											width = "2",
											ZOrder = "1",
										},
										{
											controlID = "Image_red_packet_Image_chat_Panel_chat_Panel_base_Panel-MainLayer_Layer1_NewYear_Game",
											UUID = "558134cb_1827_45c9_8c3f_85f54600da34",
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
									},
								},
								{
									controlID = "Image_fenge_Panel_chat_Panel_base_Panel-MainLayer_Layer1_NewYear_Game",
									UUID = "21bc182e_0437_4e32_a501_b39f0eaec221",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "24",
									ignoreSize = "True",
									name = "Image_fenge",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/005.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = 400,
										PositionY = 15,
									},
									visible = "False",
									width = "2",
									ZOrder = "1",
								},
							},
						},
						{
							controlID = "Image_camera2_Panel_base_Panel-MainLayer_Layer1_NewYear_Game",
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
									controlID = "Button_camera2_Image_camera2_Panel_base_Panel-MainLayer_Layer1_NewYear_Game",
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
							controlID = "Panel_player_info_touch_Panel_base_Panel-MainLayer_Layer1_NewYear_Game",
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
							controlID = "top_part2_Panel_base_Panel-MainLayer_Layer1_NewYear_Game",
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
								PositionY = 640,
								IsPercent = true,
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
									controlID = "Image_tili_bg_top_part2_Panel_base_Panel-MainLayer_Layer1_NewYear_Game",
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
									texturePath = "ui/newyear/27.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = 579,
										PositionY = -35,
									},
									width = "110",
									ZOrder = "1",
								},
								{
									controlID = "Image_tili_top_part2_Panel_base_Panel-MainLayer_Layer1_NewYear_Game",
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
										PositionX = 523,
										PositionY = -37,
									},
									width = "100",
									ZOrder = "1",
								},
								{
									controlID = "Label_tili_count_top_part2_Panel_base_Panel-MainLayer_Layer1_NewYear_Game",
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
									fontSize = "22",
									fontStroke = 
									{
										IsStroke = false,
										StrokeColor = "#FFE6E6E6",
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
									text = "35 120",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionX = 624,
										PositionY = -38,
									},
									width = "80",
									ZOrder = "1",
								},
								{
									controlID = "Button_add_tili_top_part2_Panel_base_Panel-MainLayer_Layer1_NewYear_Game",
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
									height = "38",
									HitType = 
									{
										nHitType = 2,
										nRadius = 50,
									},
									ignoreSize = "True",
									name = "Button_add_tili",
									normal = "ui/common/jiahao.png",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "True",
									UILayoutViewModel = 
									{
										PositionX = 651,
										PositionY = -35,
									},
									UItype = "Button",
									width = "38",
									ZOrder = "1",
								},
								{
									controlID = "Image_coin_bg_top_part2_Panel_base_Panel-MainLayer_Layer1_NewYear_Game",
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
									texturePath = "ui/newyear/27.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = 777,
										PositionY = -35,
									},
									width = "110",
									ZOrder = "1",
								},
								{
									controlID = "Image_coin_top_part2_Panel_base_Panel-MainLayer_Layer1_NewYear_Game",
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
										PositionX = 718,
										PositionY = -36,
									},
									width = "100",
									ZOrder = "1",
								},
								{
									controlID = "Label_coin_count_top_part2_Panel_base_Panel-MainLayer_Layer1_NewYear_Game",
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
									fontSize = "22",
									fontStroke = 
									{
										IsStroke = false,
										StrokeColor = "#FFE6E6E6",
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
										PositionX = 822,
										PositionY = -37,
									},
									width = "80",
									ZOrder = "1",
								},
								{
									controlID = "Button_add_coin_top_part2_Panel_base_Panel-MainLayer_Layer1_NewYear_Game",
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
									height = "38",
									HitType = 
									{
										nHitType = 2,
										nRadius = 50,
									},
									ignoreSize = "True",
									name = "Button_add_coin",
									normal = "ui/common/jiahao.png",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "True",
									UILayoutViewModel = 
									{
										PositionX = 848,
										PositionY = -35,
									},
									UItype = "Button",
									width = "38",
									ZOrder = "1",
								},
								{
									controlID = "Image_zuan_bg_top_part2_Panel_base_Panel-MainLayer_Layer1_NewYear_Game",
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
									texturePath = "ui/newyear/27.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = 970,
										PositionY = -35,
									},
									width = "110",
									ZOrder = "1",
								},
								{
									controlID = "Image_zuan_top_part2_Panel_base_Panel-MainLayer_Layer1_NewYear_Game",
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
										PositionX = 914,
										PositionY = -37,
									},
									width = "100",
									ZOrder = "1",
								},
								{
									controlID = "Label_zuan_count_top_part2_Panel_base_Panel-MainLayer_Layer1_NewYear_Game",
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
									fontSize = "22",
									fontStroke = 
									{
										IsStroke = false,
										StrokeColor = "#FFE6E6E6",
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
										PositionX = 1017,
										PositionY = -37,
									},
									width = "80",
									ZOrder = "1",
								},
								{
									controlID = "Button_add_zuan_top_part2_Panel_base_Panel-MainLayer_Layer1_NewYear_Game",
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
									height = "38",
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
									normal = "ui/common/jiahao.png",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "True",
									UILayoutViewModel = 
									{
										PositionX = 1041,
										PositionY = -35,
									},
									UItype = "Button",
									width = "38",
									ZOrder = "1",
								},
							},
						},
						{
							controlID = "Panel_left_Panel_base_Panel-MainLayer_Layer1_NewYear_Game",
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
									controlID = "Panel_btList_Panel_left_Panel_base_Panel-MainLayer_Layer1_NewYear_Game",
									UUID = "4e336266_7942_4938_ab80_e7122368bdf5",
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
											controlID = "Button_notice_Panel_btList_Panel_left_Panel_base_Panel-MainLayer_Layer1_NewYear_Game",
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
											height = "83",
											ignoreSize = "True",
											name = "Button_notice",
											normal = "ui/newyear/30.png",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "True",
											UILayoutViewModel = 
											{
												PositionX = 39,
												PositionY = 430,
												LeftPositon = 26,
												TopPosition = 87,
												relativeToName = "Panel",
											},
											UItype = "Button",
											width = "82",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "Label_title_Button_notice_Panel_btList_Panel_left_Panel_base_Panel-MainLayer_Layer1_NewYear_Game",
													UUID = "71cfb03b_df7b_4795_9803_bc372b773246",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0.5",
													classname = "MELabel",
													compPath = "luacomponents.common.MEIconLabel",
													dstBlendFunc = "771",
													FontColor = "#FFE6D39F",
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
														PositionY = -20,
													},
													width = "44",
													ZOrder = "1",
												},
												{
													controlID = "Image_notice_Button_notice_Panel_btList_Panel_left_Panel_base_Panel-MainLayer_Layer1_NewYear_Game",
													UUID = "1436be1b_a4ec_4c4b_9436_79d9cc1bbca7",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0.5",
													backGroundScale9Enable = "False",
													classname = "MEImage",
													dstBlendFunc = "771",
													height = "50",
													ignoreSize = "True",
													name = "Image_notice",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "1",
													texturePath = "ui/newyear/6.png",
													touchAble = "False",
													UILayoutViewModel = 
													{
														PositionY = 8,
													},
													width = "50",
													ZOrder = "1",
												},
												{
													controlID = "Image_noticeTip_Button_notice_Panel_btList_Panel_left_Panel_base_Panel-MainLayer_Layer1_NewYear_Game",
													UUID = "90ef86d4_462b_4dcb_bf0d_95694837e538",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0.5",
													backGroundScale9Enable = "False",
													classname = "MEImage",
													dstBlendFunc = "771",
													height = "30",
													ignoreSize = "True",
													name = "Image_noticeTip",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "1",
													texturePath = "ui/common/news_small.png",
													touchAble = "False",
													UILayoutViewModel = 
													{
														PositionX = 18,
														PositionY = 30,
													},
													width = "30",
													ZOrder = "1",
												},
											},
										},
										{
											controlID = "Button_mail_Panel_btList_Panel_left_Panel_base_Panel-MainLayer_Layer1_NewYear_Game",
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
											height = "83",
											ignoreSize = "True",
											name = "Button_mail",
											normal = "ui/newyear/30.png",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "True",
											UILayoutViewModel = 
											{
												PositionX = 39,
												PositionY = 354,
												LeftPositon = 26,
												TopPosition = 87,
												relativeToName = "Panel",
											},
											UItype = "Button",
											width = "82",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "Label_title_Button_mail_Panel_btList_Panel_left_Panel_base_Panel-MainLayer_Layer1_NewYear_Game",
													UUID = "ef90d868_59b4_4252_8892_e1272f1ac31b",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0.5",
													classname = "MELabel",
													compPath = "luacomponents.common.MEIconLabel",
													dstBlendFunc = "771",
													FontColor = "#FFE6D39F",
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
													text = "Mail",
													touchAble = "False",
													touchScaleEnable = "False",
													UILayoutViewModel = 
													{
														PositionY = -20,
													},
													width = "44",
													ZOrder = "1",
												},
												{
													controlID = "Image_mail_Button_mail_Panel_btList_Panel_left_Panel_base_Panel-MainLayer_Layer1_NewYear_Game",
													UUID = "1458743e_1c5e_41b5_90e7_98f055e79186",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0.5",
													backGroundScale9Enable = "False",
													classname = "MEImage",
													dstBlendFunc = "771",
													height = "50",
													ignoreSize = "True",
													name = "Image_mail",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "1",
													texturePath = "ui/newyear/19.png",
													touchAble = "False",
													UILayoutViewModel = 
													{
														PositionY = 8,
													},
													width = "50",
													ZOrder = "1",
												},
												{
													controlID = "Image_mailTip_Button_mail_Panel_btList_Panel_left_Panel_base_Panel-MainLayer_Layer1_NewYear_Game",
													UUID = "8f65256c_4a9d_4c30_b224_291c75ff341a",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0.5",
													backGroundScale9Enable = "False",
													classname = "MEImage",
													dstBlendFunc = "771",
													height = "30",
													ignoreSize = "True",
													name = "Image_mailTip",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "1",
													texturePath = "ui/common/news_small.png",
													touchAble = "False",
													UILayoutViewModel = 
													{
														PositionX = 18,
														PositionY = 30,
													},
													width = "30",
													ZOrder = "1",
												},
											},
										},
										{
											controlID = "Button_welfare_Panel_btList_Panel_left_Panel_base_Panel-MainLayer_Layer1_NewYear_Game",
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
											height = "83",
											ignoreSize = "True",
											name = "Button_welfare",
											normal = "ui/newyear/30.png",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "True",
											UILayoutViewModel = 
											{
												PositionX = 39,
												PositionY = 278,
												LeftPositon = 26,
												TopPosition = 87,
												relativeToName = "Panel",
											},
											UItype = "Button",
											width = "82",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "Label_welfare_Button_welfare_Panel_btList_Panel_left_Panel_base_Panel-MainLayer_Layer1_NewYear_Game",
													UUID = "4066710b_069d_4684_a4eb_1bb8772d0abc",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0.5",
													classname = "MELabel",
													compPath = "luacomponents.common.MEIconLabel",
													dstBlendFunc = "771",
													FontColor = "#FFE6D39F",
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
														PositionY = -20,
													},
													width = "43",
													ZOrder = "1",
												},
												{
													controlID = "Image_welfare_Button_welfare_Panel_btList_Panel_left_Panel_base_Panel-MainLayer_Layer1_NewYear_Game",
													UUID = "024208de_5988_412d_9a81_c3b4e36e80fb",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0.5",
													backGroundScale9Enable = "False",
													classname = "MEImage",
													dstBlendFunc = "771",
													height = "50",
													ignoreSize = "True",
													name = "Image_welfare",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "1",
													texturePath = "ui/newyear/4.png",
													touchAble = "False",
													UILayoutViewModel = 
													{
														PositionY = 10,
													},
													width = "50",
													ZOrder = "1",
												},
												{
													controlID = "Image_welfareTip_Button_welfare_Panel_btList_Panel_left_Panel_base_Panel-MainLayer_Layer1_NewYear_Game",
													UUID = "6ddd9eb5_cc02_4b0f_8bd4_743b9a77f0da",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0.5",
													backGroundScale9Enable = "False",
													classname = "MEImage",
													dstBlendFunc = "771",
													height = "30",
													ignoreSize = "True",
													name = "Image_welfareTip",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "1",
													texturePath = "ui/common/news_small.png",
													touchAble = "False",
													UILayoutViewModel = 
													{
														PositionX = 18,
														PositionY = 30,
													},
													width = "30",
													ZOrder = "1",
												},
											},
										},
										{
											controlID = "Button_activity_Panel_btList_Panel_left_Panel_base_Panel-MainLayer_Layer1_NewYear_Game",
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
											height = "83",
											ignoreSize = "True",
											name = "Button_activity",
											normal = "ui/newyear/30.png",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "True",
											UILayoutViewModel = 
											{
												PositionX = 39,
												PositionY = 202,
												LeftPositon = 26,
												TopPosition = 87,
												relativeToName = "Panel",
											},
											UItype = "Button",
											width = "82",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "Label_activity_Button_activity_Panel_btList_Panel_left_Panel_base_Panel-MainLayer_Layer1_NewYear_Game",
													UUID = "8eebd96d_1350_4996_beb1_14104096b470",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0.5",
													classname = "MELabel",
													compPath = "luacomponents.common.MEIconLabel",
													dstBlendFunc = "771",
													FontColor = "#FFE6D39F",
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
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "770",
													text = "Event",
													touchAble = "False",
													touchScaleEnable = "False",
													UILayoutViewModel = 
													{
														PositionY = -20,
													},
													width = "43",
													ZOrder = "1",
												},
												{
													controlID = "Image_activity_Button_activity_Panel_btList_Panel_left_Panel_base_Panel-MainLayer_Layer1_NewYear_Game",
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
													texturePath = "ui/newyear/9.png",
													touchAble = "False",
													UILayoutViewModel = 
													{
														PositionY = 10,
													},
													width = "50",
													ZOrder = "1",
												},
												{
													controlID = "Image_activityTip_Button_activity_Panel_btList_Panel_left_Panel_base_Panel-MainLayer_Layer1_NewYear_Game",
													UUID = "565fc2f8_296f_47fd_887c_6cec6f094e66",
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
														PositionX = 18,
														PositionY = 30,
													},
													width = "30",
													ZOrder = "1",
												},
											},
										},
										{
											controlID = "Button_focus_Panel_btList_Panel_left_Panel_base_Panel-MainLayer_Layer1_NewYear_Game",
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
											height = "83",
											ignoreSize = "True",
											name = "Button_focus",
											normal = "ui/newyear/30.png",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "True",
											UILayoutViewModel = 
											{
												PositionX = 39,
												PositionY = 126,
												LeftPositon = 26,
												TopPosition = 87,
												relativeToName = "Panel",
											},
											UItype = "Button",
											width = "82",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "Label_focus_Button_focus_Panel_btList_Panel_left_Panel_base_Panel-MainLayer_Layer1_NewYear_Game",
													UUID = "a78a9253_ba00_4d4b_ba46_dfd6c498e92a",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0.5",
													classname = "MELabel",
													compPath = "luacomponents.common.MEIconLabel",
													dstBlendFunc = "771",
													FontColor = "#FFE6D39F",
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
														PositionY = -20,
													},
													width = "44",
													ZOrder = "1",
												},
												{
													controlID = "Image_focus_Button_focus_Panel_btList_Panel_left_Panel_base_Panel-MainLayer_Layer1_NewYear_Game",
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
													texturePath = "ui/newyear/7.png",
													touchAble = "False",
													UILayoutViewModel = 
													{
														PositionY = 10,
													},
													width = "50",
													ZOrder = "1",
												},
												{
													controlID = "Image_focusTip_Button_focus_Panel_btList_Panel_left_Panel_base_Panel-MainLayer_Layer1_NewYear_Game",
													UUID = "39183796_e015_439f_a8fd_c290bb0ef981",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0.5",
													backGroundScale9Enable = "False",
													classname = "MEImage",
													dstBlendFunc = "771",
													height = "30",
													ignoreSize = "True",
													name = "Image_focusTip",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "1",
													texturePath = "ui/common/news_small.png",
													touchAble = "False",
													UILayoutViewModel = 
													{
														PositionX = 18,
														PositionY = 30,
													},
													width = "30",
													ZOrder = "1",
												},
											},
										},
										{
											controlID = "Button_wj_Panel_btList_Panel_left_Panel_base_Panel-MainLayer_Layer1_NewYear_Game",
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
											height = "83",
											ignoreSize = "True",
											name = "Button_wj",
											normal = "ui/newyear/30.png",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "True",
											UILayoutViewModel = 
											{
												PositionX = 39,
												PositionY = 49,
												LeftPositon = 26,
												TopPosition = 87,
												relativeToName = "Panel",
											},
											UItype = "Button",
											width = "82",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "Label_title_Button_wj_Panel_btList_Panel_left_Panel_base_Panel-MainLayer_Layer1_NewYear_Game",
													UUID = "c4bcdabd_989a_43b9_b969_7ed62d0d8ee5",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0.5",
													classname = "MELabel",
													compPath = "luacomponents.common.MEIconLabel",
													dstBlendFunc = "771",
													FontColor = "#FFE6D39F",
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
														PositionY = -20,
													},
													width = "44",
													ZOrder = "1",
												},
												{
													controlID = "Image_survey_Button_wj_Panel_btList_Panel_left_Panel_base_Panel-MainLayer_Layer1_NewYear_Game",
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
													texturePath = "ui/newyear/18.png",
													touchAble = "False",
													UILayoutViewModel = 
													{
														PositionY = 10,
													},
													width = "50",
													ZOrder = "1",
												},
												{
													controlID = "Image_wjTip_Button_wj_Panel_btList_Panel_left_Panel_base_Panel-MainLayer_Layer1_NewYear_Game",
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
														PositionY = 30,
													},
													width = "30",
													ZOrder = "1",
												},
											},
										},
										{
											controlID = "Button_update_Panel_btList_Panel_left_Panel_base_Panel-MainLayer_Layer1_NewYear_Game",
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
											height = "83",
											ignoreSize = "True",
											name = "Button_update",
											normal = "ui/newyear/30.png",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "True",
											UILayoutViewModel = 
											{
												PositionX = 104,
												PositionY = 315,
												LeftPositon = 26,
												TopPosition = 87,
												relativeToName = "Panel",
											},
											UItype = "Button",
											width = "82",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "Label_update_Button_update_Panel_btList_Panel_left_Panel_base_Panel-MainLayer_Layer1_NewYear_Game",
													UUID = "8b735af0_a3fb_4552_ab56_c31d0eaa8a2c",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0.5",
													classname = "MELabel",
													compPath = "luacomponents.common.MEIconLabel",
													dstBlendFunc = "771",
													FontColor = "#FFE6D39F",
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
														PositionY = -20,
													},
													width = "44",
													ZOrder = "1",
												},
												{
													controlID = "Image_update_Button_update_Panel_btList_Panel_left_Panel_base_Panel-MainLayer_Layer1_NewYear_Game",
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
													texturePath = "ui/newyear/5.png",
													touchAble = "False",
													UILayoutViewModel = 
													{
														PositionY = 10,
													},
													width = "50",
													ZOrder = "1",
												},
												{
													controlID = "Image_updateTip_Button_update_Panel_btList_Panel_left_Panel_base_Panel-MainLayer_Layer1_NewYear_Game",
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
														PositionY = 30,
													},
													width = "30",
													ZOrder = "1",
												},
											},
										},
										{
											controlID = "Button_assist_Panel_btList_Panel_left_Panel_base_Panel-MainLayer_Layer1_NewYear_Game",
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
											height = "83",
											ignoreSize = "True",
											name = "Button_assist",
											normal = "ui/newyear/30.png",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "True",
											UILayoutViewModel = 
											{
												PositionX = 104,
												PositionY = 238,
												LeftPositon = 26,
												TopPosition = 87,
												relativeToName = "Panel",
											},
											UItype = "Button",
											width = "82",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "Label_title_Button_assist_Panel_btList_Panel_left_Panel_base_Panel-MainLayer_Layer1_NewYear_Game",
													UUID = "a6eee63c_6bab_493f_9ef0_796f8b7d56e3",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0.5",
													classname = "MELabel",
													compPath = "luacomponents.common.MEIconLabel",
													dstBlendFunc = "771",
													FontColor = "#FFE6D39F",
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
														PositionY = -20,
													},
													width = "44",
													ZOrder = "1",
												},
												{
													controlID = "Image_survey_Button_assist_Panel_btList_Panel_left_Panel_base_Panel-MainLayer_Layer1_NewYear_Game",
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
													width = "50",
													ZOrder = "1",
												},
												{
													controlID = "Image_assist_Tip_Button_assist_Panel_btList_Panel_left_Panel_base_Panel-MainLayer_Layer1_NewYear_Game",
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
														PositionY = 30,
													},
													width = "30",
													ZOrder = "1",
												},
											},
										},
										{
											controlID = "Button_backPlayer_Panel_btList_Panel_left_Panel_base_Panel-MainLayer_Layer1_NewYear_Game",
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
											height = "83",
											ignoreSize = "True",
											name = "Button_backPlayer",
											normal = "ui/newyear/30.png",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "True",
											UILayoutViewModel = 
											{
												PositionX = 104,
												PositionY = 163,
												LeftPositon = 26,
												TopPosition = 87,
												relativeToName = "Panel",
											},
											UItype = "Button",
											width = "82",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "Label_backPlayer_Button_backPlayer_Panel_btList_Panel_left_Panel_base_Panel-MainLayer_Layer1_NewYear_Game",
													UUID = "05548c54_71ac_4d9b_a91e_79887a4b3373",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0.5",
													classname = "MELabel",
													compPath = "luacomponents.common.MEIconLabel",
													dstBlendFunc = "771",
													FontColor = "#FFE6D39F",
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
														PositionY = -20,
													},
													width = "44",
													ZOrder = "1",
												},
												{
													controlID = "Image_update_Button_backPlayer_Panel_btList_Panel_left_Panel_base_Panel-MainLayer_Layer1_NewYear_Game",
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
													texturePath = "ui/newyear/8.png",
													touchAble = "False",
													UILayoutViewModel = 
													{
														PositionY = 10,
													},
													width = "50",
													ZOrder = "1",
												},
												{
													controlID = "Image_backPlayerTip_Button_backPlayer_Panel_btList_Panel_left_Panel_base_Panel-MainLayer_Layer1_NewYear_Game",
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
														PositionY = 30,
													},
													width = "30",
													ZOrder = "1",
												},
											},
										},
										{
											controlID = "Button_newYear_Panel_btList_Panel_left_Panel_base_Panel-MainLayer_Layer1_NewYear_Game",
											UUID = "70f48659_a744_4e98_b611_28a64dd1f395",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											classname = "MEButton",
											ClickHighLightEnabled = "True",
											dstBlendFunc = "771",
											flipX = "False",
											flipY = "False",
											height = "83",
											ignoreSize = "True",
											name = "Button_newYear",
											normal = "ui/newyear/30.png",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "True",
											UILayoutViewModel = 
											{
												PositionX = 104,
												PositionY = 84,
												LeftPositon = 26,
												TopPosition = 87,
												relativeToName = "Panel",
											},
											UItype = "Button",
											width = "82",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "Label_backPlayer_Button_newYear_Panel_btList_Panel_left_Panel_base_Panel-MainLayer_Layer1_NewYear_Game",
													UUID = "56c0cd9b_9d5a_460b_85a7_018905ea7272",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0.5",
													classname = "MELabel",
													compPath = "luacomponents.common.MEIconLabel",
													dstBlendFunc = "771",
													FontColor = "#FFE6D39F",
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
														PositionY = -20,
													},
													width = "44",
													ZOrder = "1",
												},
												{
													controlID = "Image_update_Button_newYear_Panel_btList_Panel_left_Panel_base_Panel-MainLayer_Layer1_NewYear_Game",
													UUID = "4d7c8b65_0913_484a_898f_0eb866049f83",
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
													texturePath = "ui/newyear/8.png",
													touchAble = "False",
													UILayoutViewModel = 
													{
														PositionY = 10,
													},
													width = "50",
													ZOrder = "1",
												},
												{
													controlID = "Image_newYearTip_Button_newYear_Panel_btList_Panel_left_Panel_base_Panel-MainLayer_Layer1_NewYear_Game",
													UUID = "793e9234_ca39_4c00_8d7d_4272bed3d0f8",
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
														PositionY = 30,
													},
													width = "30",
													ZOrder = "1",
												},
											},
										},
										{
											controlID = "Button_monthCard_Panel_btList_Panel_left_Panel_base_Panel-MainLayer_Layer1_NewYear_Game",
											UUID = "2bf6178f_4169_490f_9340_ef582bb30fb5",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											classname = "MEButton",
											ClickHighLightEnabled = "True",
											dstBlendFunc = "771",
											flipX = "False",
											flipY = "False",
											height = "83",
											ignoreSize = "True",
											name = "Button_monthCard",
											normal = "ui/newyear/30.png",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "True",
											UILayoutViewModel = 
											{
												PositionX = 104,
												PositionY = 4,
												LeftPositon = 26,
												TopPosition = 87,
												relativeToName = "Panel",
											},
											UItype = "Button",
											width = "82",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "Label_monthCard_Button_monthCard_Panel_btList_Panel_left_Panel_base_Panel-MainLayer_Layer1_NewYear_Game",
													UUID = "ba8abb02_6bae_42f1_84f7_2777cd72cf14",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0.5",
													classname = "MELabel",
													compPath = "luacomponents.common.MEIconLabel",
													dstBlendFunc = "771",
													FontColor = "#FFE6D39F",
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
													text = "Month Card",
													touchAble = "False",
													touchScaleEnable = "False",
													UILayoutViewModel = 
													{
														PositionY = -20,
													},
													width = "43",
													ZOrder = "1",
												},
												{
													controlID = "Image_update_Button_monthCard_Panel_btList_Panel_left_Panel_base_Panel-MainLayer_Layer1_NewYear_Game",
													UUID = "259a7e1c_f6f2_46ac_aec2_778f1e8e51df",
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
													texturePath = "ui/newyear/33.png",
													touchAble = "False",
													UILayoutViewModel = 
													{
														PositionY = 10,
													},
													width = "50",
													ZOrder = "1",
												},
												{
													controlID = "Image_monthCardTip_Button_monthCard_Panel_btList_Panel_left_Panel_base_Panel-MainLayer_Layer1_NewYear_Game",
													UUID = "ad71d884_005b_4f0e_bb90_032aef257625",
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
														PositionY = 30,
													},
													width = "30",
													ZOrder = "1",
												},
											},
										},
										{
											controlID = "Panel_newyaer_Panel_btList_Panel_left_Panel_base_Panel-MainLayer_Layer1_NewYear_Game",
											UUID = "724551c0_47e5_45da_8094_85a0934e1093",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											bgColorOpacity = "50",
											bIsOpenClipping = "False",
											classname = "MEPanel",
											colorType = "0;SingleColor:#FF0000FF;GraduallyChangingColorStart:#FFFFFFFF;GraduallyChangingColorEnd:#FFFFFFFF;vectorX:0;vectorY:0",
											DesignHeight = "640",
											DesignType = "0",
											DesignWidth = "960",
											dstBlendFunc = "771",
											height = "83",
											ignoreSize = "False",
											name = "Panel_newyaer",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 39,
												PositionY = -16,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "82",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "Image_newyear_Panel_newyaer_Panel_btList_Panel_left_Panel_base_Panel-MainLayer_Layer1_NewYear_Game",
													UUID = "d634cf65_0717_429b_8366_fa7f60ae24f7",
													anchorPoint = "False",
													anchorPointX = "0.7",
													anchorPointY = "0.5",
													backGroundScale9Enable = "False",
													classname = "MEImage",
													dstBlendFunc = "771",
													height = "61",
													ignoreSize = "True",
													name = "Image_newyear",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "1",
													texturePath = "ui/newyear/3.png",
													touchAble = "False",
													UILayoutViewModel = 
													{
														PositionX = -1,
														PositionY = 12,
													},
													width = "41",
													ZOrder = "1",
												},
											},
										},
									},
								},
								{
									controlID = "Button_newPlayer_Panel_left_Panel_base_Panel-MainLayer_Layer1_NewYear_Game",
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
										PositionX = 159,
										PositionY = 392,
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
											controlID = "Image_update_Button_newPlayer_Panel_left_Panel_base_Panel-MainLayer_Layer1_NewYear_Game",
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
											controlID = "Image_newPlayerTip_Button_newPlayer_Panel_left_Panel_base_Panel-MainLayer_Layer1_NewYear_Game",
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
							},
						},
						{
							controlID = "Panel_middle_Panel_base_Panel-MainLayer_Layer1_NewYear_Game",
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
									controlID = "Panel_camera_Panel_middle_Panel_base_Panel-MainLayer_Layer1_NewYear_Game",
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
				id = "Image_top_bar_bg_Panel_top_Panel_base_Panel-MainLayer_Layer1_NewYear_Game",
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
							x=0,
							y=0,
						},
						position = 
						{
							x=568,
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
				id = "Image_camera_Panel_top_Panel_base_Panel-MainLayer_Layer1_NewYear_Game",
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
							x=0,
							y=0,
						},
						position = 
						{
							x=344,
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
				id = "Image_tili_bg_top_part2_Panel_base_Panel-MainLayer_Layer1_NewYear_Game",
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
				id = "Image_tili_top_part2_Panel_base_Panel-MainLayer_Layer1_NewYear_Game",
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
				id = "Label_tili_count_top_part2_Panel_base_Panel-MainLayer_Layer1_NewYear_Game",
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
				id = "Button_add_tili_top_part2_Panel_base_Panel-MainLayer_Layer1_NewYear_Game",
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
				id = "Image_coin_bg_top_part2_Panel_base_Panel-MainLayer_Layer1_NewYear_Game",
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
				id = "Image_coin_top_part2_Panel_base_Panel-MainLayer_Layer1_NewYear_Game",
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
				id = "Label_coin_count_top_part2_Panel_base_Panel-MainLayer_Layer1_NewYear_Game",
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
				id = "Button_add_coin_top_part2_Panel_base_Panel-MainLayer_Layer1_NewYear_Game",
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
				id = "Image_zuan_bg_top_part2_Panel_base_Panel-MainLayer_Layer1_NewYear_Game",
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
				id = "Image_zuan_top_part2_Panel_base_Panel-MainLayer_Layer1_NewYear_Game",
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
				id = "Label_zuan_count_top_part2_Panel_base_Panel-MainLayer_Layer1_NewYear_Game",
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
				id = "Button_add_zuan_top_part2_Panel_base_Panel-MainLayer_Layer1_NewYear_Game",
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
				id = "Button_setting_Panel_top_Panel_base_Panel-MainLayer_Layer1_NewYear_Game",
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
				id = "Image_MainLayer_1_Panel_clip_Panel_right_Panel_base_Panel-MainLayer_Layer1_NewYear_Game",
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
				id = "button_yuehui_Panel_clip_Panel_right_Panel_base_Panel-MainLayer_Layer1_NewYear_Game",
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
							y=143,
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
				id = "Image_MainLayer_1(2)_Panel_clip_Panel_right_Panel_base_Panel-MainLayer_Layer1_NewYear_Game",
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
				id = "Button_zuozhan_Panel_clip_Panel_right_Panel_base_Panel-MainLayer_Layer1_NewYear_Game",
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
							y=143,
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
				id = "Image_MainLayer_1(4)_Panel_clip_Panel_right_Panel_base_Panel-MainLayer_Layer1_NewYear_Game",
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
				id = "Image_text_Panel_clip_Panel_right_Panel_base_Panel-MainLayer_Layer1_NewYear_Game",
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
				id = "Image_MainLayer_1(3)_Panel_clip_Panel_right_Panel_base_Panel-MainLayer_Layer1_NewYear_Game",
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
				id = "Image_MainLayer_1(3)(2)_Panel_clip_Panel_right_Panel_base_Panel-MainLayer_Layer1_NewYear_Game",
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
				id = "Image_MainLayer_1(3)(3)_Panel_clip_Panel_right_Panel_base_Panel-MainLayer_Layer1_NewYear_Game",
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
				id = "Button_pokedex_Panel_clip_Panel_right_Panel_base_Panel-MainLayer_Layer1_NewYear_Game",
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
				},
			},
			{
				id = "Button_friend_Panel_clip_Panel_right_Panel_base_Panel-MainLayer_Layer1_NewYear_Game",
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
				},
			},
			{
				id = "Button_task_Panel_clip_Panel_right_Panel_base_Panel-MainLayer_Layer1_NewYear_Game",
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
				id = "Panel_activity_Panel_clip_Panel_right_Panel_base_Panel-MainLayer_Layer1_NewYear_Game",
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
							x=477,
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
							x=477,
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
							x=477,
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
				id = "Image_fairyMain_1_Panel_bottom_Panel_base_Panel-MainLayer_Layer1_NewYear_Game",
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
							x=117,
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
							x=117,
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
							x=117,
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
				id = "Image_fairyMain_1(2)_Panel_bottom_Panel_base_Panel-MainLayer_Layer1_NewYear_Game",
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
							x=220,
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
							x=220,
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
							x=220,
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
				id = "Image_fairyMain_1(3)_Panel_bottom_Panel_base_Panel-MainLayer_Layer1_NewYear_Game",
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
							x=323,
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
							x=323,
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
							x=323,
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
				id = "Button_fairy_Panel_bottom_Panel_base_Panel-MainLayer_Layer1_NewYear_Game",
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
							x=-37,
							y=32,
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
							x=-37,
							y=32,
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
							x=27.88,
							y=58,
						},
						position = 
						{
							x=-37,
							y=48,
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
				id = "Button_bag_Panel_bottom_Panel_base_Panel-MainLayer_Layer1_NewYear_Game",
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
							x=66,
							y=32,
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
							x=66,
							y=32,
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
							x=43.03,
							y=61,
						},
						position = 
						{
							x=66,
							y=48,
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
				id = "Button_zhaohuan_Panel_bottom_Panel_base_Panel-MainLayer_Layer1_NewYear_Game",
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
							x=272,
							y=32,
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
							x=272,
							y=32,
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
							x=58.48,
							y=61,
						},
						position = 
						{
							x=272,
							y=48,
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
				id = "Button_shop_Panel_bottom_Panel_base_Panel-MainLayer_Layer1_NewYear_Game",
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
							x=375,
							y=32,
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
							x=375,
							y=32,
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
							x=72.42,
							y=60,
						},
						position = 
						{
							x=375,
							y=48,
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
				id = "Button_phone_Panel_bottom_Panel_base_Panel-MainLayer_Layer1_NewYear_Game",
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
				id = "Image_chat_bg_Panel_chat_Panel_base_Panel-MainLayer_Layer1_NewYear_Game",
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
				id = "Panel_chat_di_Panel_chat_Panel_base_Panel-MainLayer_Layer1_NewYear_Game",
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
				id = "Image_chat_Panel_chat_Panel_base_Panel-MainLayer_Layer1_NewYear_Game",
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
				id = "Panel_player_info_Panel_top_Panel_base_Panel-MainLayer_Layer1_NewYear_Game",
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
				id = "Image_split_line_Panel_bottom_Panel_base_Panel-MainLayer_Layer1_NewYear_Game",
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
							x=426,
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
							x=426,
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
							x=426,
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
				id = "Button_recharge_Panel_bottom_Panel_base_Panel-MainLayer_Layer1_NewYear_Game",
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
							y=32,
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
							y=32,
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
							x=72.42,
							y=40,
						},
						position = 
						{
							x=478,
							y=48,
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
				id = "btn_infoStation_Panel_clip_Panel_right_Panel_base_Panel-MainLayer_Layer1_NewYear_Game",
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
				id = "Image_MainLayer_1(5)_Panel_clip_Panel_right_Panel_base_Panel-MainLayer_Layer1_NewYear_Game",
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
				id = "Button_league_Panel_bottom_Panel_base_Panel-MainLayer_Layer1_NewYear_Game",
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
							x=-5.61,
							y=48,
						},
						position = 
						{
							x=169,
							y=32,
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
							x=-5.61,
							y=40,
						},
						position = 
						{
							x=169,
							y=32,
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
							x=-5.61,
							y=40,
						},
						position = 
						{
							x=169,
							y=48,
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
				id = "Image_fairyMain_1-Copy1_Panel_bottom_Panel_base_Panel-MainLayer_Layer1_NewYear_Game",
				name = "Panel.Panel_base.Panel_bottom.Image_fairyMain_1-Copy1",
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
							x=14,
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
							x=14,
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
							x=14,
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
		},
		Action1 = 
		{
			name = "Action1",
			FPS = 30,
			duration = 0.33,
			looptimes = 1,
			autoplay = false,
			{
				id = "Panel_system_Panel_top_Panel_base_Panel-MainLayer_Layer1_NewYear_Game",
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
				id = "Panel_feelling_info_Panel_right_Panel_base_Panel-MainLayer_Layer1_NewYear_Game",
				name = "Panel.Panel_base.Panel_right.Panel_feelling_info",
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
				id = "Panel_feelling_info_Panel_right_Panel_base_Panel-MainLayer_Layer1_NewYear_Game",
				name = "Panel.Panel_base.Panel_right.Panel_feelling_info",
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
			"ui/newyear/bg_newyear.png",
			"dating/icon/banshenxiang_shixiang.png",
			"ui/newyear/1.png",
			"ui/mainLayer/new_ui/ui_008.png",
			"ui/playerInfo/avatar/TXBK_moren_0.png",
			"icon/hero/name/1101011.png",
			"ui/playerInfo/avatar/TXBK_moren_1.png",
			"ui/playerInfo/avatar/TXBK_1.png",
			"ui/newyear/2.png",
			"ui/mainLayer/new_ui/ui_007.png",
			"ui/mainLayer/new_ui/ui_006.png",
			"icon/hero/face/1101011.png",
			"ui/mainLayer/new_ui/ui_002.png",
			"ui/003.png",
			"ui/mainui/camera_logo.png",
			"ui/mainLayer/new_ui/btn_setting.png",
			"ui/mainLayer/new_ui/ui_004.png",
			"ui/newCity/build/9.png",
			"ui/mainLayer/new_ui/progress_01.png",
			"ui/mainLayer/new_ui/progress_02.png",
			"ui/common/button09.png",
			"ui/065.png",
			"ui/020.png",
			"ui/newyear/22.png",
			"ui/028.png",
			"ui/newyear/23.png",
			"ui/mainLayer/new_ui/bai1.png",
			"ui/newyear/20.png",
			"ui/027.png",
			"ui/mainui/arrow_r.png",
			"ui/920.png",
			"ui/newyear/21.png",
			"ui/newyear/25.png",
			"ui/common/news_small.png",
			"ui/newyear/11.png",
			"ui/newyear/17.png",
			"ui/mainui/main_infoStation.png",
			"ui/mainui/main_mask.png",
			"ui/mainLayer/new_ui/bai2.png",
			"ui/mainLayer/new_ui/btn_guoqing.png",
			"ui/mainLayer/new_ui/activity_tab_01.png",
			"ui/mainLayer/new_ui/activity_tab_02.png",
			"ui/mainLayer/new_ui/ui_001.png",
			"ui/newyear/31.png",
			"ui/newyear/10.png",
			"ui/common/redPoint.png",
			"ui/newyear/28.png",
			"ui/newyear/32.png",
			"ui/newyear/24.png",
			"ui/newyear/15.png",
			"ui/newyear/16.png",
			"ui/newyear/14.png",
			"ui/newyear/29.png",
			"ui/recharge/new.png",
			"ui/newyear/13.png",
			"ui/newyear/12.png",
			"ui/mainLayer/new_ui/redpack_tips_bg.png",
			"ui/league/ui_10.png",
			"ui/005.png",
			"ui/newyear/27.png",
			"icon/system/001.png",
			"ui/common/jiahao.png",
			"icon/system/003.png",
			"icon/system/005.png",
			"ui/newyear/30.png",
			"ui/newyear/6.png",
			"ui/newyear/19.png",
			"ui/newyear/4.png",
			"ui/newyear/9.png",
			"ui/newyear/7.png",
			"ui/newyear/18.png",
			"ui/newyear/5.png",
			"ui/mainLayer/new_ui/btn_ativity.png",
			"ui/newyear/8.png",
			"ui/newyear/33.png",
			"ui/newyear/3.png",
			"ui/mainLayer/new_ui/btn_newPlayer.png",
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

