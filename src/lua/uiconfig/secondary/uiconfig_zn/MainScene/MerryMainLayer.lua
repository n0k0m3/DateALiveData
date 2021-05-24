local t = 
{
	version = 1,
	components = 
	{
		
		{
			controlID = "Panel-MerryMainLayer_Layer1_MainScene_Game",
			UUID = "e1d83fee_3ef9_489c_816e_4bd4b4f3a1b3",
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
					controlID = "Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
					UUID = "5aa8a890_51d1_4f96_b585_fa8a544bdf3f",
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
							controlID = "background_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
							UUID = "955f31b1_7fa6_4e01_8928_df00863ac17b",
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
									controlID = "Spine_effectHB_background_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
									UUID = "afb3f9cf_979a_46e6_91d9_18f95a242ec5",
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
							controlID = "Image_role_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
							UUID = "92ac716e_0f46_4fc3_bbc5_e10387da8f3c",
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
									controlID = "Spine_effectH_Image_role_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
									UUID = "d6eeeb3d_66ae_4fbb_b676_0ff6cec37b6a",
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
							controlID = "frontPanel_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
							UUID = "d4680a8c_5534_4ba1_bb4a_9f25f3e898b6",
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
							controlID = "Button_showUI_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
							UUID = "409aec74_5995_4804_a94d_df4494748020",
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
							normal = "ui/mainLayer/new_ui_5/camera_logo.png",
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
									controlID = "Image_huigu_Button_showUI_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
									UUID = "eb9e7912_4010_434f_bc8f_b16824e8ed31",
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
									texturePath = "ui/mainLayer/new_ui_5/camera_logo.png",
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
							controlID = "Panel_top_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
							UUID = "726eb760_ce96_4c43_b70f_8b7137e6c887",
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
									controlID = "Image_top_bar_bg_Panel_top_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
									UUID = "a71d8c41_ecf3_4aea_b338_23cd8e5d9aa5",
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
									texturePath = "ui/mainLayer/new_ui_5/top_bar_bg.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = 1022,
									},
									width = "446",
									ZOrder = "1",
								},
								{
									controlID = "Panel_player_info_Panel_top_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
									UUID = "c79a8056_80a5_446f_a1d6_9493319d5530",
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
											controlID = "info_di_Panel_player_info_Panel_top_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
											UUID = "47f6f3f4_0a42_4136_8032_cead73d452aa",
											anchorPoint = "False",
											anchorPointX = "0",
											anchorPointY = "1",
											backGroundScale9Enable = "False",
											classname = "MEImage",
											dstBlendFunc = "771",
											height = "71",
											ignoreSize = "True",
											name = "info_di",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											texturePath = "ui/mainLayer/new_ui_5/ui_008.png",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = -135,
												PositionY = 4,
											},
											width = "438",
											ZOrder = "1",
										},
										{
											controlID = "Image_player_icon_bg_Panel_player_info_Panel_top_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
											UUID = "e7fddead_2a10_4551_9411_425aff3a5c40",
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
											controlID = "Image_player_icon_Panel_player_info_Panel_top_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
											UUID = "5eb9e18b_8278_4848_9e30_4feb7ecfa892",
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
											controlID = "Image_icon_frame_Panel_player_info_Panel_top_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
											UUID = "52040df5_6238_4447_a872_0b18416a57af",
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
											controlID = "Image_icon_cover_frame_Panel_player_info_Panel_top_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
											UUID = "e5803c39_fd86_43ec_a4c0_321d9de39b8c",
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
											controlID = "TextArea_name_Panel_player_info_Panel_top_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
											UUID = "a83683cf_0f18_4af3_a20d_074343c9be84",
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
											text = "玩家名称最多八个",
											touchAble = "False",
											touchScaleEnable = "False",
											UILayoutViewModel = 
											{
												PositionX = 66,
												PositionY = -16,
											},
											vAlignment = "0",
											width = "148",
											ZOrder = "1",
										},
										{
											controlID = "Association_TextArea_name_Panel_player_info_Panel_top_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
											UUID = "d5c29bc2_aebc_48c4_8eb7_a9979a23dda8",
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
											text = "社团名称最多八个",
											touchAble = "False",
											touchScaleEnable = "False",
											UILayoutViewModel = 
											{
												PositionX = 66,
												PositionY = -38,
											},
											vAlignment = "0",
											width = "148",
											ZOrder = "1",
										},
										{
											controlID = "Panel_player_level_Panel_player_info_Panel_top_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
											UUID = "2f7ccb42_6d84_4d98_99f1_9d0d66744a99",
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
													controlID = "Image_Exp_bg-Copy1_Panel_player_level_Panel_player_info_Panel_top_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
													UUID = "79ab91cc_c542_488d_8839_119ef298d1a2",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0.5",
													backGroundScale9Enable = "False",
													classname = "MEImage",
													dstBlendFunc = "771",
													height = "65",
													ignoreSize = "True",
													name = "Image_Exp_bg-Copy1",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "1",
													texturePath = "ui/mainLayer/new_ui_5/lvbg.png",
													touchAble = "False",
													UILayoutViewModel = 
													{
														
													},
													width = "77",
													ZOrder = "1",
												},
												{
													controlID = "Label_Player_level_Panel_player_level_Panel_player_info_Panel_top_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
													UUID = "47abc748_8ab4_4f1c_a877_8d5aab2123bf",
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
														IsStroke = true,
														StrokeColor = "#FF237532",
														StrokeSize = 2,
													},
													height = "31",
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
													width = "17",
													ZOrder = "1",
												},
												{
													controlID = "Image_Exp_bg_Panel_player_level_Panel_player_info_Panel_top_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
													UUID = "2df83152_0234_4fdd_b8b9_1aacfe92d061",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0.5",
													backGroundScale9Enable = "False",
													classname = "MEImage",
													dstBlendFunc = "771",
													height = "7",
													ignoreSize = "True",
													name = "Image_Exp_bg",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "1",
													texturePath = "ui/mainLayer/new_ui_5/ui_007.png",
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
															controlID = "LoadingBar_Exp_Image_Exp_bg_Panel_player_level_Panel_player_info_Panel_top_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
															UUID = "de901254_7965_4ca9_b2a6_8135dfde3a90",
															anchorPoint = "False",
															anchorPointX = "0.5",
															anchorPointY = "0.5",
															backGroundScale9Enable = "False",
															classname = "MELoadingBar",
															direction = "0",
															dstBlendFunc = "771",
															height = "15",
															ignoreSize = "True",
															name = "LoadingBar_Exp",
															percent = "51",
															sizepercentx = "0",
															sizepercenty = "0",
															sizeType = "0",
															srcBlendFunc = "1",
															texture = "ui/mainLayer/new_ui_5/ui_006.png",
															touchAble = "False",
															UILayoutViewModel = 
															{
																
															},
															width = "204",
															ZOrder = "1",
														},
													},
												},
											},
										},
										{
											controlID = "ClippingNode_Panel_player_info_Panel_top_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
											UUID = "02ca3019_df99_4130_9d6b_dacba082ed0d",
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
													controlID = "Image_head_ClippingNode_Panel_player_info_Panel_top_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
													UUID = "11626e67_9483_42c3_b9fe_de7a53d4c20a",
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
											controlID = "Image_player_redTip_Panel_player_info_Panel_top_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
											UUID = "6b2950d8_b2dd_4c86_8c0d_0a0bf13804aa",
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
									controlID = "Panel_system_Panel_top_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
									UUID = "4b069b7a_6de3_4b2b_9644_fc1816e38cd5",
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
											controlID = "Image_system_bg_Panel_system_Panel_top_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
											UUID = "ea215a64_a65f_47c2_8a53_9a47f26f92fd",
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
											controlID = "TextArea_system_Panel_system_Panel_top_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
											UUID = "341f8898_c447_4a70_9028_758fab0efbe0",
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
											text = "系统公告：系统公告系统公告系统公告系统公告系统公告系统公告",
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
									controlID = "Image_camera_Panel_top_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
									UUID = "f6da540c_d9be_4695_ab60_0ba1089e5d0c",
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
											controlID = "Button_camera_Image_camera_Panel_top_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
											UUID = "8e5976e8_dd0d_498e_a3b0_4444c3c778c2",
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
											normal = "ui/mainLayer/new_ui_5/camera_logo.png",
											pressed = "ui/mainLayer/new_ui_5/camera_logo.png",
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
									controlID = "Button_setting_Panel_top_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
									UUID = "9368b577_e0c7_4092_8bca_ae9483f21665",
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
									normal = "ui/mainLayer/new_ui_5/btn_setting.png",
									pressed = "ui/mainLayer/new_ui_5/btn_setting.png",
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
											controlID = "Label_MainLayer_1_Button_setting_Panel_top_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
											UUID = "7fb753b8_23d2_4f82_8730_eb9701806f7d",
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
											text = "设置",
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
								{
									controlID = "Button_hideUI_Panel_top_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
									UUID = "6f023dfe_87a1_45a3_8426_01cb26feff40",
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
									normal = "ui/mainLayer/new_ui_5/camera_logo.png",
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
											controlID = "Image_huigu_Button_hideUI_Panel_top_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
											UUID = "69c42c8a_65f8_47c5_b26f_34a154fd4247",
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
											texturePath = "ui/mainLayer/new_ui_5/camera_logo.png",
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
							controlID = "Panel_right_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
							UUID = "e4ade47e_fe68_47be_8b97_8de6af6671e2",
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
									controlID = "Panel_feelling_info__Panel_right_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
									UUID = "7074f7cd_be76_43eb_91e2_2450f6a181f9",
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
											controlID = "Image_feelling_bg_Panel_feelling_info__Panel_right_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
											UUID = "406b8547_3f64_40d4_b449_19d02adbb93e",
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
											controlID = "Image_feelling_icon_Panel_feelling_info__Panel_right_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
											UUID = "9c553bbd_902a_4f01_9924_d54dd3e72354",
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
											controlID = "Label_feelling_name_Panel_feelling_info__Panel_right_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
											UUID = "1ca0e9ef_2c70_4496_95f4_ff4b88a73c0b",
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
											text = "好感度等级",
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
											controlID = "Label_feelling_level_Panel_feelling_info__Panel_right_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
											UUID = "ebf022c0_405c_46a3_a19a_156bff24945d",
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
											controlID = "Label_feelling_reach_max_Panel_feelling_info__Panel_right_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
											UUID = "a9e8cf67_4679_43c5_a289_010ec01f32a1",
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
											text = "今日好感度获取已达到上限",
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
											controlID = "Image_progress_bg_Panel_feelling_info__Panel_right_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
											UUID = "ff9e2aba_268f_4e45_8ac4_d3406d45cbc9",
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
											controlID = "LoadingBar_feelling_bar_Panel_feelling_info__Panel_right_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
											UUID = "68720c1b_ee12_49a4_9b87_bc9b90e2e7e0",
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
											controlID = "Label_feelling_percent_Panel_feelling_info__Panel_right_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
											UUID = "f7990f3e_8aa7_4b87_9911_027224b4e846",
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
											controlID = "Button_feellint_edit_Panel_feelling_info__Panel_right_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
											UUID = "3571a891_87a7_4141_8c38_9c80bfd4ad86",
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
													controlID = "Label_MainLayer_1_Button_feellint_edit_Panel_feelling_info__Panel_right_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
													UUID = "8a156a6a_a35e_4086_9765_67bd34160a29",
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
													text = "编辑",
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
									controlID = "Panel_clip_Panel_right_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
									UUID = "ce1a1b20_7b57_4e23_b2bd_2faa9b27850e",
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
											controlID = "Image_bottom_Panel_clip_Panel_right_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
											UUID = "18df13ee_7c36_45fa_b05c_b65c960df099",
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
													controlID = "Image_activity_bottom_Image_bottom_Panel_clip_Panel_right_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
													UUID = "b0867a2d_ff3a_4261_a0f1_8a0229193da9",
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
											controlID = "Image_z_y_bottom_Panel_clip_Panel_right_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
											UUID = "1d8816c1_adb7_41d7_b775_efe68c5e8380",
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
											controlID = "Button_zuozhan_Panel_clip_Panel_right_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
											UUID = "479abc1a_47e1_45d2_ac70_e6cf4272e011",
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
											normal = "ui/mainLayer/new_ui_5/btn_battle.png",
											pressed = "ui/mainLayer/new_ui_5/btn_battle.png",
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
													controlID = "Image_zuozhan_Button_zuozhan_Panel_clip_Panel_right_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
													UUID = "f7587f78_0ee8_4842_921c_ba064a112410",
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
											controlID = "Image_text_Panel_clip_Panel_right_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
											UUID = "f10421d5_7867_4188_9c27_9401594b0154",
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
											controlID = "Image_MainLayer_1(2)_Panel_clip_Panel_right_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
											UUID = "891b8f81_1e04_4fca_abdb_29360cb2a3e7",
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
											controlID = "Panelzuozhan_Panel_clip_Panel_right_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
											UUID = "c2f2d1a5_43fb_4a5d_991c_0267cb009c62",
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
											controlID = "button_yuehui_Panel_clip_Panel_right_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
											UUID = "9b057364_55af_41f5_af21_77469695842e",
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
											normal = "ui/mainLayer/new_ui_5/btn_dating.png",
											pressed = "ui/mainLayer/new_ui_5/btn_dating.png",
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
													controlID = "Image_yuehui_button_yuehui_Panel_clip_Panel_right_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
													UUID = "9941a333_9aad_49ed_9f6f_09acda5a4b45",
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
													controlID = "Image_startIcon1_button_yuehui_Panel_clip_Panel_right_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
													UUID = "5b4b0162_0f5e_45df_87ac_30cdafaf3b49",
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
													controlID = "Image_yuehuiRedTips_button_yuehui_Panel_clip_Panel_right_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
													UUID = "f0d0c776_defb_4cae_83cc_5775e0affeac",
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
											controlID = "Image_MainLayer_1(4)_Panel_clip_Panel_right_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
											UUID = "f006cfe4_7278_4855_aaf9_ac0858419d99",
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
											controlID = "Image_MainLayer_1_Panel_clip_Panel_right_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
											UUID = "6ea94c28_05ed_4e7a_9789_9b84c8b6f927",
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
											controlID = "Panelyuehui_Panel_clip_Panel_right_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
											UUID = "29f748fd_d8ec_42f0_a39e_b480b86ffa8d",
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
											controlID = "Panel_task_Panel_clip_Panel_right_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
											UUID = "a4d3c21c_0344_4cb0_bc32_ad2fe7526d5a",
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
											controlID = "Button_dispatch_Panel_clip_Panel_right_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
											UUID = "ec648748_cd39_49cc_a6e1_a8b1175cb73a",
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
											normal = "ui/mainLayer/new_ui_5/a3.png",
											pressed = "ui/mainLayer/new_ui_5/a3.png",
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
													controlID = "Image_dispatchTips_Button_dispatch_Panel_clip_Panel_right_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
													UUID = "f9505422_9263_4d05_a9e6_9b08e9e6a3cf",
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
													texturePath = "ui/mainLayer/new_ui_5/a3new.png",
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
															controlID = "Image_updateTip_Image_dispatchTips_Button_dispatch_Panel_clip_Panel_right_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
															UUID = "f3ae1a29_92d8_4808_84ba_9471f1b46645",
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
													controlID = "Label_title_Button_dispatch_Panel_clip_Panel_right_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
													UUID = "c054d140_8a57_4acc_87b3_4f115081ec00",
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
														StrokeColor = "#FF952A42",
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
													text = "指挥",
													touchAble = "False",
													touchScaleEnable = "False",
													UILayoutViewModel = 
													{
														PositionY = -24,
													},
													vAlignment = "1",
													width = "44",
													ZOrder = "1",
												},
											},
										},
										{
											controlID = "Button_task_Panel_clip_Panel_right_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
											UUID = "b0cfa69c_fa40_48a4_baee_88e722dcca11",
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
											normal = "ui/mainLayer/new_ui_5/btn_order.png",
											pressed = "ui/mainLayer/new_ui_5/btn_order.png",
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
													controlID = "Image_taskTips_Button_task_Panel_clip_Panel_right_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
													UUID = "85411ea2_7ba9_4ace_a680_539c5a785353",
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
													texturePath = "ui/mainLayer/new_ui_5/btn_ordernew.png",
													touchAble = "False",
													UILayoutViewModel = 
													{
														
													},
													width = "100",
													ZOrder = "1",
													components = 
													{
														
														{
															controlID = "Image_updateTip_Image_taskTips_Button_task_Panel_clip_Panel_right_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
															UUID = "79c14fb4_581b_4832_881d_b81690e0edb5",
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
													controlID = "Label_title_Button_task_Panel_clip_Panel_right_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
													UUID = "49b1ffa5_12bb_4730_a4d7_6bc02582a4cb",
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
														StrokeColor = "#FF952A42",
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
													text = "指令",
													touchAble = "False",
													touchScaleEnable = "False",
													UILayoutViewModel = 
													{
														PositionY = -26,
													},
													vAlignment = "1",
													width = "44",
													ZOrder = "1",
												},
											},
										},
										{
											controlID = "Button_pokedex_Panel_clip_Panel_right_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
											UUID = "3bdea1a2_bb2c_4f85_bd8c_28314516d4cd",
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
											normal = "ui/mainLayer/new_ui_5/btn_tujian.png",
											pressed = "ui/mainLayer/new_ui_5/btn_tujian.png",
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
													controlID = "Image_poker_tip_Button_pokedex_Panel_clip_Panel_right_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
													UUID = "386217ac_42b6_4495_b6c9_09c25db56a21",
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
													texturePath = "ui/mainLayer/new_ui_5/btn_tujiannew.png",
													touchAble = "False",
													UILayoutViewModel = 
													{
														
													},
													width = "100",
													ZOrder = "1",
													components = 
													{
														
														{
															controlID = "Image_updateTip_Image_poker_tip_Button_pokedex_Panel_clip_Panel_right_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
															UUID = "241dca8c_37e2_4a58_b5b0_e0e8ad7b1ff0",
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
													controlID = "Label_title_Button_pokedex_Panel_clip_Panel_right_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
													UUID = "d5a24bf4_7991_4b25_94ab_0e69524670e5",
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
														StrokeColor = "#FF952A42",
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
													text = "图鉴",
													touchAble = "False",
													touchScaleEnable = "False",
													UILayoutViewModel = 
													{
														PositionY = -26,
													},
													vAlignment = "1",
													width = "44",
													ZOrder = "1",
												},
											},
										},
										{
											controlID = "btn_infoStation_Panel_clip_Panel_right_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
											UUID = "496bf501_1e57_42e2_af2e_98a7fec91629",
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
											controlID = "Button_sxsr_Panel_clip_Panel_right_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
											UUID = "96b64a44_80fd_4f50_a6a0_2084d71555cd",
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
													controlID = "Image_sxsrTip_Button_sxsr_Panel_clip_Panel_right_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
													UUID = "78a2eb24_7a92_4a8b_8a51_209068ad6202",
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
											controlID = "Image_MainLayer_1(5)_Panel_clip_Panel_right_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
											UUID = "d9c8f9f4_7b6e_4b1a_bbd4_1613a6896fd3",
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
											controlID = "Image_MainLayer_1(3)(3)_Panel_clip_Panel_right_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
											UUID = "5a632d2c_de39_43f5_9f5e_b7deedcdff59",
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
											controlID = "Image_MainLayer_1(3)(2)_Panel_clip_Panel_right_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
											UUID = "504846e0_539f_4ea4_b853_cd5951b74c91",
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
											controlID = "Image_MainLayer_1(3)_Panel_clip_Panel_right_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
											UUID = "03be22fd_396b_42ac_87b9_5594db315141",
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
											controlID = "Image_MainLayer_1(3)-Copy1_Panel_clip_Panel_right_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
											UUID = "d0bdf685_fee7_4006_8548_6906bce5fcfd",
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
											controlID = "Panel_activity_Panel_clip_Panel_right_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
											UUID = "fe0772f1_0d0b_4cf4_94cf_c2ab22a594b9",
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
													controlID = "activity_1_Panel_activity_Panel_clip_Panel_right_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
													UUID = "521b5e5a_f3ca_4509_9c18_23387f15a311",
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
													controlID = "Label_activity_time_Panel_activity_Panel_clip_Panel_right_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
													UUID = "b79a63a5_5cc3_4920_824b_498dc8407e98",
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
													text = "1月20日 - 1月28日",
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
													controlID = "Image_dot1_Panel_activity_Panel_clip_Panel_right_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
													UUID = "49f0d2fc_42b5_4551_8321_5e32955f0fc0",
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
													controlID = "Image_dot2_Panel_activity_Panel_clip_Panel_right_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
													UUID = "4b259951_e71a_4f16_a4a4_db3012f2cc9c",
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
													controlID = "Image_dot3_Panel_activity_Panel_clip_Panel_right_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
													UUID = "32cbee57_a442_4737_bf5f_c700c86b4463",
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
													controlID = "Image_dot4_Panel_activity_Panel_clip_Panel_right_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
													UUID = "ee3a912b_2ce0_405b_9de1_c86350b89df5",
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
													controlID = "PageView_Activity_Panel_activity_Panel_clip_Panel_right_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
													UUID = "e45dcd59_99eb_4387_a671_c72d503b2496",
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
													scaleX = "0.835",
													scaleY = "0.835",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "1",
													touchAble = "True",
													UILayoutViewModel = 
													{
														PositionX = -140,
														PositionY = -34,
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
													controlID = "Image_dot5_Panel_activity_Panel_clip_Panel_right_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
													UUID = "59cfed26_8659_4d93_814f_656bfa7a55bb",
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
													controlID = "Image_dot6_Panel_activity_Panel_clip_Panel_right_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
													UUID = "d0faa467_4135_45c6_8e65_bc0247c9c0f5",
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
													controlID = "Image_dot7_Panel_activity_Panel_clip_Panel_right_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
													UUID = "7224aba8_a08d_47ea_8968_8498010fd6ef",
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
													controlID = "Image_dot8_Panel_activity_Panel_clip_Panel_right_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
													UUID = "c9be63e2_9683_4925_8347_0af96d924766",
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
													controlID = "Image_dot9_Panel_activity_Panel_clip_Panel_right_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
													UUID = "d6eeaf79_e071_43d4_8c23_bf031fb4904f",
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
													controlID = "btn_ad_Panel_activity_Panel_clip_Panel_right_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
													UUID = "e4caf62f_3289_4f3e_8470_303746c011ad",
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
											controlID = "Button_Activity2_Panel_clip_Panel_right_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
											UUID = "acc311b3_bd64_4b17_898a_018efc62a26f",
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
													controlID = "Spine_MainLayer_1_Button_Activity2_Panel_clip_Panel_right_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
													UUID = "9ce7e3f0_7f29_4baa_8dcb_b12971964193",
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
													controlID = "Image_activityTip_Button_Activity2_Panel_clip_Panel_right_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
													UUID = "cf59401b_b8b2_4003_969e_5a978abcd279",
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
													controlID = "Spine_MainLayer_2_Button_Activity2_Panel_clip_Panel_right_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
													UUID = "b6c57958_24d8_43a4_952b_33f8083f57a9",
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
											controlID = "Button_mail_Panel_clip_Panel_right_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
											UUID = "62d45bba_af62_4695_b685_9b0fc25837ef",
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
											normal = "ui/mainLayer/new_ui_5/btn_mail.png",
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
													controlID = "Image_mail_Button_mail_Panel_clip_Panel_right_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
													UUID = "dd77b953_754f_4625_acea_43f88b7880ab",
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
													controlID = "Image_mailTip_Button_mail_Panel_clip_Panel_right_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
													UUID = "75c5e9be_ae6d_4957_98cb_2c80953d264a",
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
													texturePath = "ui/mainLayer/new_ui_5/btn_mailnew.png",
													touchAble = "False",
													UILayoutViewModel = 
													{
														
													},
													width = "100",
													ZOrder = "1",
													components = 
													{
														
														{
															controlID = "Image_updateTip_Image_mailTip_Button_mail_Panel_clip_Panel_right_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
															UUID = "e2a237ed_fc4d_445d_a370_66f5b7f853e9",
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
													controlID = "Label_title_Button_mail_Panel_clip_Panel_right_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
													UUID = "f0f5c795_e09f_4c4c_a4c7_b56983900c7a",
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
														StrokeColor = "#FF952A42",
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
													text = "邮件",
													touchAble = "False",
													touchScaleEnable = "False",
													UILayoutViewModel = 
													{
														PositionX = 6,
														PositionY = -29,
													},
													width = "44",
													ZOrder = "1",
												},
												{
													controlID = "img_bubble_Button_mail_Panel_clip_Panel_right_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
													UUID = "8685c491_c571_49f9_a370_a134fbf4e5c9",
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
											controlID = "button_Caociyuan_Panel_clip_Panel_right_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
											UUID = "5270043a_d00a_46b5_9f38_44f1e158b2d4",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											classname = "MEButton",
											ClickHighLightEnabled = "True",
											dstBlendFunc = "771",
											flipX = "False",
											flipY = "False",
											height = "106",
											ignoreSize = "True",
											name = "button_Caociyuan",
											normal = "ui/activity/fanShi/08.png",
											pressed = "ui/activity/fanShi/08.png",
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
											width = "190",
											ZOrder = "1",
										},
										{
											controlID = "button_OneYear_Panel_clip_Panel_right_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
											UUID = "6ddf5133_ae5d_41ab_8fce_97f7baa955e7",
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
												PositionX = 301,
												PositionY = 68,
											},
											UItype = "Button",
											width = "184",
											ZOrder = "1",
										},
										{
											controlID = "Image_OneYearClip_Panel_clip_Panel_right_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
											UUID = "3a1f38f8_ff6a_431a_8140_b97e1e0fa787",
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
											controlID = "Button_Activity5_Panel_clip_Panel_right_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
											UUID = "71e92875_5f92_47a5_a8cd_a1428d45426a",
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
											normal = "ui/activity/bingKai/003.png",
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
													controlID = "Image_update_Button_Activity5_Panel_clip_Panel_right_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
													UUID = "0bcff947_811d_4e12_8fff_d9c3c63e6893",
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
													controlID = "Image_activity_red5_Button_Activity5_Panel_clip_Panel_right_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
													UUID = "6311ee33_0064_488b_9de6_e5473e170623",
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
														PositionX = 82,
													},
													width = "30",
													ZOrder = "1",
												},
											},
										},
										{
											controlID = "Image_CaociyuanClip_Panel_clip_Panel_right_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
											UUID = "ec367662_2fb5_4451_bbdf_7be674080038",
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
											controlID = "Button_friend_Panel_clip_Panel_right_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
											UUID = "c2a7366e_3929_473c_bc6a_93ba37b1417c",
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
											normal = "ui/mainLayer/new_ui_5/btn_contact.png",
											pressed = "ui/mainLayer/new_ui_5/btn_contact.png",
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
													controlID = "Image_friendTip_Button_friend_Panel_clip_Panel_right_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
													UUID = "d96f2ed8_93f9_41a9_8710_3bab4af8183b",
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
													texturePath = "ui/mainLayer/new_ui_5/btn_contactnew.png",
													touchAble = "False",
													UILayoutViewModel = 
													{
														
													},
													width = "100",
													ZOrder = "1",
													components = 
													{
														
														{
															controlID = "Image_updateTip_Image_friendTip_Button_friend_Panel_clip_Panel_right_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
															UUID = "fe1fb002_7b34_40eb_9359_487c55e923c1",
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
													controlID = "Label_title_Button_friend_Panel_clip_Panel_right_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
													UUID = "0eaf0a52_2ebb_490d_a75f_b470d8101576",
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
														StrokeColor = "#FF952A42",
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
													text = "联络",
													touchAble = "False",
													touchScaleEnable = "False",
													UILayoutViewModel = 
													{
														PositionY = -26,
													},
													width = "44",
													ZOrder = "1",
												},
											},
										},
										{
											controlID = "Button_Activity6_Panel_clip_Panel_right_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
											UUID = "021b08ef_0b53_4730_b79c_bac106a4a493",
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
											name = "Button_Activity6",
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
											visible = "False",
											width = "200",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "Image_update_Button_Activity6_Panel_clip_Panel_right_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
													UUID = "1cd04770_4f2a_445d_91c2_a34fe45a52cc",
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
													controlID = "Image_activity_red6_Button_Activity6_Panel_clip_Panel_right_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
													UUID = "6e7112af_208b_486f_936c_fcb7fbc59b80",
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
														PositionX = 81,
														PositionY = 27,
													},
													width = "30",
													ZOrder = "1",
												},
											},
										},
										{
											controlID = "Button_Activity7_Panel_clip_Panel_right_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
											UUID = "ce9de404_416e_4d85_96eb_98f9049c033d",
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
											visible = "False",
											width = "193",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "Image_update_Button_Activity7_Panel_clip_Panel_right_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
													UUID = "fcbdbc66_3275_4649_8d75_16504a9e51b2",
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
													controlID = "Image_activity_red7_Button_Activity7_Panel_clip_Panel_right_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
													UUID = "0f40b7a0_2670_4d8c_a2de_b94324c79689",
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
											controlID = "activityPos_left_Panel_clip_Panel_right_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
											UUID = "a5ff5e5f_9d51_4919_959f_3c2d647e8103",
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
											controlID = "activityPos_mid_Panel_clip_Panel_right_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
											UUID = "6fd7e6c2_48f9_4845_8509_f9755e80ac10",
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
											controlID = "activityPos_right_Panel_clip_Panel_right_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
											UUID = "d3f2be8e_1242_4c3c_80bd_3ad55382ca0e",
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
									},
								},
								{
									controlID = "Panel_feelling_info_Panel_right_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
									UUID = "fba276ef_0785_4f64_8f8f_14519bf1a37f",
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
											controlID = "Image_feelling_bg_Panel_feelling_info_Panel_right_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
											UUID = "157d51be_3165_47d1_920b_6016b72a90a1",
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
											controlID = "Btn_aiChat_Panel_feelling_info_Panel_right_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
											UUID = "b8cf18af_53c0_4001_b659_35a1ab71b772",
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
													controlID = "img_redNew_Btn_aiChat_Panel_feelling_info_Panel_right_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
													UUID = "09dd550c_a421_4e33_b4f6_ccf94472af13",
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
											controlID = "img_lockAiChat_Panel_feelling_info_Panel_right_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
											UUID = "69581d3d_b2cd_4f90_904d_3695a20c0b8f",
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
											controlID = "Button_feellint_edit_Panel_feelling_info_Panel_right_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
											UUID = "14308597_4743_4354_ba9d_d186b0954533",
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
											controlID = "img_heart_Panel_feelling_info_Panel_right_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
											UUID = "898a446b_d03c_49cc_b0ff_5a8d77d54efa",
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
											controlID = "LoadingBar_feelling_bar_Panel_feelling_info_Panel_right_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
											UUID = "26e0b44d_4b35_4111_bd63_ee6f7e5d1a79",
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
											controlID = "Label_MainLayer_1_Panel_feelling_info_Panel_right_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
											UUID = "b184d875_79f7_4be0_8cd0_269ed8c92b41",
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
											text = "好感度",
											touchAble = "False",
											touchScaleEnable = "False",
											UILayoutViewModel = 
											{
												PositionY = -42,
											},
											width = "58",
											ZOrder = "1",
										},
										{
											controlID = "Label_feelling_percent_Panel_feelling_info_Panel_right_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
											UUID = "45297eef_2898_4ea6_b7ed_d53d43d012ed",
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
											width = "40",
											ZOrder = "1",
										},
										{
											controlID = "Label_feelling_level_Panel_feelling_info_Panel_right_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
											UUID = "75477a42_580c_4759_99bd_684261da0290",
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
							controlID = "Panel_bottom_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
							UUID = "048a1fa3_0abc_408f_b0ff_46f3debec498",
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
							panelTexturePath = "ui/mainLayer/new_ui_5/bottombg.png",
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
									controlID = "Image_fairyMain_1_Panel_bottom_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
									UUID = "878ff5b6_bfaf_40eb_a2c9_df28390ca3a4",
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
									texturePath = "ui/mainLayer/new_ui_5/ui_001.png",
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
									controlID = "Image_DefaultMainLayer_1_Panel_bottom_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
									UUID = "c7dc4405_fae3_4400_bd30_1769fc08eb9f",
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
									texturePath = "ui/mainLayer/new_ui_5/iconbg.png",
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
									controlID = "Image_DefaultMainLayer_1-Copy1_Panel_bottom_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
									UUID = "c5df6c66_9324_4daf_9fad_c9e4b685604d",
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
									texturePath = "ui/mainLayer/new_ui_5/iconbg.png",
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
									controlID = "Image_DefaultMainLayer_1-Copy2_Panel_bottom_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
									UUID = "d1b2daa5_1e8e_4a2d_9fd2_d3f152a4ab8a",
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
									texturePath = "ui/mainLayer/new_ui_5/iconbg.png",
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
									controlID = "Image_DefaultMainLayer_1-Copy3_Panel_bottom_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
									UUID = "5d2305dc_648d_4977_805b_dbf8cf54fec9",
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
									texturePath = "ui/mainLayer/new_ui_5/iconbg.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = 264,
										PositionY = 45,
									},
									width = "60",
									ZOrder = "1",
								},
								{
									controlID = "Image_DefaultMainLayer_1-Copy4_Panel_bottom_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
									UUID = "02b3109d_b806_42e5_9582_e86bccf09090",
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
									texturePath = "ui/mainLayer/new_ui_5/iconbg.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = 366,
										PositionY = 45,
									},
									width = "60",
									ZOrder = "1",
								},
								{
									controlID = "Image_DefaultMainLayer_1-Copy5_Panel_bottom_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
									UUID = "e385a29c_1a11_4c98_b75d_d3e05baa6eb0",
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
									texturePath = "ui/mainLayer/new_ui_5/iconbg.png",
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
									controlID = "Button_fairy_Panel_bottom_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
									UUID = "0ec77b0c_cd66_4b34_8716_185befe95ef5",
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
									normal = "ui/mainLayer/new_ui_5/btn_sprite.png",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "True",
									UILayoutViewModel = 
									{
										PositionX = -49,
										PositionY = 46,
									},
									UItype = "Button",
									width = "60",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "RedTips_Button_fairy_Panel_bottom_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
											UUID = "13f10be9_cccb_4f38_b18c_68391c848058",
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
											controlID = "Image_unlock_Button_fairy_Panel_bottom_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
											UUID = "3ba6293e_2490_476f_82fe_ef6faf96574f",
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
											controlID = "Image_roleup_Button_fairy_Panel_bottom_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
											UUID = "99ed74e5_0668_422e_b635_1761958557bb",
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
											texturePath = "ui/mainLayer/new_ui_5/btn_spritenew.png",
											touchAble = "False",
											UILayoutViewModel = 
											{
												
											},
											width = "60",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "Image_updateTip_Image_roleup_Button_fairy_Panel_bottom_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
													UUID = "1cef00ad_e37f_4f39_8759_bbcee1d97a62",
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
											controlID = "Label_Game_1_Button_fairy_Panel_bottom_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
											UUID = "4da1496f_4923_461e_aa59_ec47a0665e09",
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
												StrokeColor = "#FF952A42",
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
											text = " 精灵",
											touchAble = "False",
											touchScaleEnable = "False",
											UILayoutViewModel = 
											{
												PositionX = 35,
											},
											width = "49",
											ZOrder = "1",
										},
									},
								},
								{
									controlID = "Image_fairyMain_1(2)_Panel_bottom_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
									UUID = "0adce9a0_9a4a_4cbf_9011_4d1dad890704",
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
									texturePath = "ui/mainLayer/new_ui_5/ui_001.png",
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
									controlID = "Button_bag_Panel_bottom_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
									UUID = "34b91156_39dc_421b_9e11_2316b9dfacfe",
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
									normal = "ui/mainLayer/new_ui_5/btn_bag.png",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "True",
									UILayoutViewModel = 
									{
										PositionX = 55,
										PositionY = 47,
									},
									UItype = "Button",
									width = "60",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "Label_Game_1-Copy1_Button_bag_Panel_bottom_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
											UUID = "dac5beda_5602_4b95_879d_60571946dfc3",
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
												StrokeColor = "#FF952A42",
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
											text = "背包",
											touchAble = "False",
											touchScaleEnable = "False",
											UILayoutViewModel = 
											{
												PositionX = 39,
											},
											width = "44",
											ZOrder = "1",
										},
									},
								},
								{
									controlID = "Image_fairyMain_1(3)_Panel_bottom_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
									UUID = "2254424a_1146_42ad_b825_d80d9f4d545d",
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
									texturePath = "ui/mainLayer/new_ui_5/ui_001.png",
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
									controlID = "Button_shetuan_Panel_bottom_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
									UUID = "60e96337_80d2_4c3d_abbc_578c1ed162b9",
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
									normal = "ui/mainLayer/new_ui_5/btn_league.png",
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
											controlID = "Image_Game_3_Button_shetuan_Panel_bottom_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
											UUID = "f147fe2e_7002_4fd6_9e91_4815fcc3390c",
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
											texturePath = "ui/mainLayer/new_ui_5/btn_leaguenew.png",
											touchAble = "False",
											UILayoutViewModel = 
											{
												
											},
											width = "60",
											ZOrder = "1",
										},
										{
											controlID = "Label_Game_1-Copy2_Button_shetuan_Panel_bottom_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
											UUID = "507ce2b4_cc3b_43a1_ab96_c95ee4866ddd",
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
											text = "社团",
											touchAble = "False",
											touchScaleEnable = "False",
											UILayoutViewModel = 
											{
												PositionX = 39,
												PositionY = 1,
											},
											width = "42",
											ZOrder = "1",
										},
									},
								},
								{
									controlID = "Button_zhaohuan_Panel_bottom_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
									UUID = "a18d8db5_58fe_4bfd_8b6e_a10db282a10b",
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
									normal = "ui/mainLayer/new_ui_5/btn_summon.png",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "True",
									UILayoutViewModel = 
									{
										PositionX = 263,
										PositionY = 47,
									},
									UItype = "Button",
									width = "60",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "Image_summon_tip_Button_zhaohuan_Panel_bottom_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
											UUID = "a3727eea_46f0_4072_afb4_7828a4103020",
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
											texturePath = "ui/mainLayer/new_ui_5/btn_summonnew.png",
											touchAble = "False",
											UILayoutViewModel = 
											{
												
											},
											width = "60",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "Image_updateTip_Image_summon_tip_Button_zhaohuan_Panel_bottom_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
													UUID = "b2455c6a_a8fb_4608_9226_8a9105164535",
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
											controlID = "Image_upTips_Button_zhaohuan_Panel_bottom_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
											UUID = "5268131e_2412_47f9_aa96_52b6edafec2f",
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
											controlID = "Label_Game_1-Copy3_Button_zhaohuan_Panel_bottom_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
											UUID = "f48f3e97_9d55_4662_bc7e_58c7ae7eb2f4",
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
												StrokeColor = "#FF952A42",
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
											text = "召唤",
											touchAble = "False",
											touchScaleEnable = "False",
											UILayoutViewModel = 
											{
												PositionX = 40,
											},
											width = "44",
											ZOrder = "1",
										},
										{
											controlID = "panel_contractSummon_Button_zhaohuan_Panel_bottom_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
											UUID = "5717bdbc_e068_4542_b365_45263dc67619",
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
													controlID = "Image_MainLayer_1_panel_contractSummon_Button_zhaohuan_Panel_bottom_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
													UUID = "7cc9d9f9_358d_42ab_9734_91873e6fcdf5",
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
													controlID = "Image_MainLayer_2_panel_contractSummon_Button_zhaohuan_Panel_bottom_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
													UUID = "8b9993eb_c2be_4716_b203_c8353437479d",
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
													controlID = "label_contract_timing_panel_contractSummon_Button_zhaohuan_Panel_bottom_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
													UUID = "5aa505fe_d0af_486d_8527_edf7572ad9c5",
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
													width = "71",
													ZOrder = "1",
												},
											},
										},
									},
								},
								{
									controlID = "Button_explore_Panel_bottom_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
									UUID = "8f69436c_3084_4433_b147_52f62f865ee1",
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
											controlID = "Spine_phone_Button_explore_Panel_bottom_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
											UUID = "b6c4c3d6_dc8a_4040_9178_2eb262c0ac53",
											classname = "MESpine",
											dstBlendFunc = "771",
											name = "Spine_phone",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											spineModel = 
											{
												SpinePath = "effect/TS_texiao/TS_zhuyerukou3",
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
									controlID = "Button_phone_Panel_bottom_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
									UUID = "4b0bac88_7d54_4342_a436_7d430d5c9f4c",
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
									normal = "ui/mainLayer/new_ui_5/btn_phone.png",
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
											controlID = "Spine_phone_Button_phone_Panel_bottom_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
											UUID = "8b9ebe24_7903_470c_8f99_7f634fbd7f3e",
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
											controlID = "Image_newtip_Button_phone_Panel_bottom_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
											UUID = "c64d0121_86e4_4b37_b8c6_eef6e5dee2c9",
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
											texturePath = "ui/mainLayer/new_ui_5/btn_phonenew.png",
											touchAble = "False",
											UILayoutViewModel = 
											{
												
											},
											width = "68",
											ZOrder = "1",
										},
										{
											controlID = "Label_Game_1-Copy4_Button_phone_Panel_bottom_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
											UUID = "864558c7_30c3_4adf_9137_16cadfaf2090",
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
											text = "城市",
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
									},
								},
								{
									controlID = "Button_shop_Panel_bottom_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
									UUID = "23fec542_9b25_4421_ab02_f6294e5bc1e0",
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
									normal = "ui/mainLayer/new_ui_5/btn_store.png",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "True",
									UILayoutViewModel = 
									{
										PositionX = 367,
										PositionY = 48,
									},
									UItype = "Button",
									width = "60",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "TextArea_Game_2_Button_shop_Panel_bottom_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
											UUID = "0d3be64d_8e7a_4449_8a15_33c10bd853c5",
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
												StrokeColor = "#FF952A42",
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
											text = "商店",
											touchAble = "False",
											touchScaleEnable = "False",
											UILayoutViewModel = 
											{
												PositionX = 43,
												PositionY = -3,
											},
											vAlignment = "1",
											width = "44",
											ZOrder = "1",
										},
									},
								},
								{
									controlID = "Image_split_line_Panel_bottom_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
									UUID = "f6ac84b7_48a3_4641_8c2e_7e1e5366d90b",
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
									texturePath = "ui/mainLayer/new_ui_5/ui_001.png",
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
									controlID = "Button_recharge_Panel_bottom_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
									UUID = "49f2bc7f_1268_4869_a60e_1aa9478b3fff",
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
									normal = "ui/mainLayer/new_ui_5/btn_recharge.png",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "True",
									UILayoutViewModel = 
									{
										PositionX = 473,
										PositionY = 48,
									},
									UItype = "Button",
									width = "60",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "TextArea_Game_2_Button_recharge_Panel_bottom_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
											UUID = "6306d70e_ac2e_4df1_9f16_300bc4081cf9",
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
												StrokeColor = "#FF952A42",
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
											text = "充值",
											touchAble = "False",
											touchScaleEnable = "False",
											UILayoutViewModel = 
											{
												PositionX = 38,
												PositionY = -2,
											},
											vAlignment = "1",
											width = "44",
											ZOrder = "1",
										},
										{
											controlID = "Image_MainLayer_new_Button_recharge_Panel_bottom_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
											UUID = "16931d7d_abb4_42e8_9397_35bafa3a9f62",
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
									controlID = "Button_league_Panel_bottom_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
									UUID = "f8563a69_39f2_49e2_a45b_3737fa9b0951",
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
									normal = "ui/mainLayer/new_ui_5/btn_league.png",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "True",
									UILayoutViewModel = 
									{
										PositionX = 160,
										PositionY = 47,
									},
									UItype = "Button",
									width = "60",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "RedTips_Button_league_Panel_bottom_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
											UUID = "2e10a2db_2e4b_48ea_b701_302b895f83c5",
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
											texturePath = "ui/mainLayer/new_ui_5/btn_leaguenew.png",
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
													controlID = "Image_updateTip_RedTips_Button_league_Panel_bottom_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
													UUID = "1cc0f5ef_d937_491c_a026_4b69c793902e",
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
											controlID = "Label_league_Button_league_Panel_bottom_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
											UUID = "30e9056e_6bde_45d6_ad67_eb77920bd671",
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
												StrokeColor = "#FF952A42",
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
											text = "社团",
											touchAble = "False",
											touchScaleEnable = "False",
											UILayoutViewModel = 
											{
												PositionX = 39,
											},
											width = "43",
											ZOrder = "1",
										},
									},
								},
							},
						},
						{
							controlID = "Panel_chat_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
							UUID = "68922543_9fef_43c0_a93b_602a4a815723",
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
									controlID = "Image_chat_bg_Panel_chat_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
									UUID = "b53fa719_7382_4849_a09e_c1cb5db94798",
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
									texturePath = "ui/mainLayer/new_ui_5/chat_bg.png",
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
									controlID = "Panel_chat_di_Panel_chat_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
									UUID = "6733d915_2aab_43a2_be4e_730150d47f19",
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
											controlID = "Label_message_Panel_chat_di_Panel_chat_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
											UUID = "9e8e8f80_2f83_4508_9917_ddb474c93352",
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
									controlID = "Image_chat_Panel_chat_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
									UUID = "cce1243a_38e2_4661_add0_53095f04ef2a",
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
									normal = "ui/mainLayer/new_ui_5/btn_chat.png",
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
											controlID = "Image_redPack_tips_Image_chat_Panel_chat_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
											UUID = "8aa6ff69_b84a_4c97_9d20_47711f32b4a5",
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
													controlID = "Image_red_icon_Image_redPack_tips_Image_chat_Panel_chat_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
													UUID = "2c42aaa7_ba80_4b1c_aa97_8d3906faab44",
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
													controlID = "Label_redpack_get_Image_redPack_tips_Image_chat_Panel_chat_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
													UUID = "d8619467_fd29_4fce_a014_0952fd70da2b",
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
													text = "可领取",
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
											controlID = "Image_redPoint_Image_chat_Panel_chat_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
											UUID = "c1f2156f_d097_459a_bf74_18d384cd887c",
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
											controlID = "Image_red_packet_Image_chat_Panel_chat_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
											UUID = "efb3239e_5010_46d9_8976_a6f6f9013edd",
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
											controlID = "Image_aiAdvice_tips_Image_chat_Panel_chat_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
											UUID = "266bbd9c_7b47_4b4d_b504_efc2f7321dbb",
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
													controlID = "Image_aiIcon_Image_aiAdvice_tips_Image_chat_Panel_chat_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
													UUID = "563c79c6_2235_4fa5_9ca2_9402282695cb",
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
													controlID = "Image_aiTimeBar_Image_aiAdvice_tips_Image_chat_Panel_chat_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
													UUID = "6b0e8211_c7a2_4dd7_bfd2_22167b42a823",
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
															controlID = "LoadingBar_aiTime_Image_aiTimeBar_Image_aiAdvice_tips_Image_chat_Panel_chat_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
															UUID = "73b6c565_1b26_47fd_a9e8_4b2b80dd0737",
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
							controlID = "Image_camera2_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
							UUID = "323393c5_2fc4_4ae0_ad91_887f6de83b01",
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
									controlID = "Button_camera2_Image_camera2_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
									UUID = "eee5b4c4_22e3_48bd_bf8e_49e5afe11f8d",
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
							controlID = "Panel_player_info_touch_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
							UUID = "42c5ab3f_8150_4f3b_84f9_6b15de23e8a4",
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
							controlID = "top_part2_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
							UUID = "9cc2ff5b_1ced_4388_bac6_a86faceed72d",
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
								PositionX = -58,
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
									controlID = "Image_tili_bg_top_part2_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
									UUID = "fee22314_8c9d_46b8_a9b3_78d2e2732f34",
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
									texturePath = "ui/mainLayer/new_ui_5/res_bg.png",
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
									controlID = "Image_tili_top_part2_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
									UUID = "63b94cf7_848c_413e_9d2e_d865f4fedf32",
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
									controlID = "Label_tili_count_top_part2_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
									UUID = "6fab20e6_ff18_482c_a81e_a5b490de30ca",
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
									controlID = "Button_add_tili_top_part2_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
									UUID = "0eaa3e6e_da31_4b5e_bcbe_1e3a252ad7d3",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEButton",
									ClickHighLightEnabled = "True",
									dstBlendFunc = "771",
									flipX = "False",
									flipY = "False",
									height = "42",
									HitType = 
									{
										nHitType = 2,
										nRadius = 50,
									},
									ignoreSize = "True",
									name = "Button_add_tili",
									normal = "ui/mainLayer/new_ui_5/jiahao.png",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "True",
									UILayoutViewModel = 
									{
										PositionX = 684,
										PositionY = -29,
									},
									UItype = "Button",
									width = "43",
									ZOrder = "1",
								},
								{
									controlID = "Image_coin_bg_top_part2_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
									UUID = "ed6e1ae2_6476_4197_9a1a_ae5b23948461",
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
									texturePath = "ui/mainLayer/new_ui_5/res_bg.png",
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
									controlID = "Image_coin_top_part2_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
									UUID = "2e85f65d_4c72_4554_b942_644f6890fe8b",
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
									controlID = "Label_coin_count_top_part2_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
									UUID = "f7206e44_97ac_41e0_b12f_d7ee6742c12c",
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
									controlID = "Button_add_coin_top_part2_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
									UUID = "69dbfbe8_27f8_462c_9054_dffa2a9f6ca9",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEButton",
									ClickHighLightEnabled = "True",
									dstBlendFunc = "771",
									flipX = "False",
									flipY = "False",
									height = "42",
									HitType = 
									{
										nHitType = 2,
										nRadius = 50,
									},
									ignoreSize = "True",
									name = "Button_add_coin",
									normal = "ui/mainLayer/new_ui_5/jiahao.png",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "True",
									UILayoutViewModel = 
									{
										PositionX = 828,
										PositionY = -28,
									},
									UItype = "Button",
									width = "43",
									ZOrder = "1",
								},
								{
									controlID = "Image_zuan_bg_top_part2_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
									UUID = "6a23c9a1_127e_42d7_b5fc_0a0d633ce817",
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
									texturePath = "ui/mainLayer/new_ui_5/res_bg.png",
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
									controlID = "Image_zuan_top_part2_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
									UUID = "96b5cc89_6c69_4a3f_b791_45413ba268ff",
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
									controlID = "Label_zuan_count_top_part2_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
									UUID = "3f85f698_2515_493d_b34b_ed20b3c6d1b4",
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
									controlID = "Button_add_zuan_top_part2_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
									UUID = "14092035_78d0_47f3_b929_68547cd7030e",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEButton",
									ClickHighLightEnabled = "True",
									dstBlendFunc = "771",
									flipX = "False",
									flipY = "False",
									height = "42",
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
									normal = "ui/mainLayer/new_ui_5/jiahao.png",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "True",
									UILayoutViewModel = 
									{
										PositionX = 972,
										PositionY = -29,
									},
									UItype = "Button",
									width = "43",
									ZOrder = "1",
								},
							},
						},
						{
							controlID = "Panel_left_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
							UUID = "b03699c2_d5bd_4da3_90d8_e04bc767a9d3",
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
									controlID = "Button_elf_contract_Panel_left_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
									UUID = "daa149cd_746c_4b63_bde3_2a075db9f665",
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
											controlID = "Spine_MainLayer_1_Button_elf_contract_Panel_left_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
											UUID = "4b9e5168_4cc4_4944_b249_8967099f6735",
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
											controlID = "image_new_Button_elf_contract_Panel_left_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
											UUID = "877f9284_a0a0_4f56_8aa5_88cc61944790",
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
											controlID = "Image_redTips_Button_elf_contract_Panel_left_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
											UUID = "60cd93e5_c7d1_4c49_b79d_8a28771d4a2e",
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
											controlID = "Spine_MainLayer_2_Button_elf_contract_Panel_left_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
											UUID = "be1d1355_9f95_40e2_82bb_45d1186fdac2",
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
											controlID = "Label_left_time_Button_elf_contract_Panel_left_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
											UUID = "2a552817_a8f2_4c08_b5b3_a4e25615bdab",
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
											text = "20小时58分",
											touchAble = "False",
											touchScaleEnable = "False",
											UILayoutViewModel = 
											{
												PositionY = -48,
											},
											visible = "False",
											width = "108",
											ZOrder = "1",
										},
									},
								},
								{
									controlID = "Panel_btList_Panel_left_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
									UUID = "2fd01e77_aeb8_49f3_8f07_1dfea85e3d86",
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
											controlID = "Button_notice_Panel_btList_Panel_left_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
											UUID = "2c74199e_dac6_4709_a294_b4c2b9be0d91",
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
											normal = "ui/mainLayer/new_ui_5/btn_notice.png",
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
													controlID = "Label_title_Button_notice_Panel_btList_Panel_left_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
													UUID = "ce57420b_7e1d_422b_a19b_6291086874d5",
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
													text = "公告",
													touchAble = "False",
													touchScaleEnable = "False",
													UILayoutViewModel = 
													{
														PositionY = -37,
													},
													visible = "False",
													width = "44",
													ZOrder = "1",
												},
												{
													controlID = "Image_notice_Button_notice_Panel_btList_Panel_left_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
													UUID = "a6388fb4_574f_4b8d_bbeb_a1f0a61534cf",
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
													controlID = "Image_noticeTip_Button_notice_Panel_btList_Panel_left_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
													UUID = "7ed5fa39_76c6_4f0b_8637_d3c8006d4ec8",
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
													texturePath = "ui/mainLayer/new_ui_5/btn_noticenew.png",
													touchAble = "False",
													UILayoutViewModel = 
													{
														
													},
													width = "80",
													ZOrder = "1",
													components = 
													{
														
														{
															controlID = "Image_updateTip_Image_noticeTip_Button_notice_Panel_btList_Panel_left_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
															UUID = "342fc6fe_5209_47a1_a67b_97aacb2b9c2b",
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
											controlID = "Button_welfare_Panel_btList_Panel_left_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
											UUID = "e4c0dd47_0666_4f62_9102_4d9391fae3c7",
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
											normal = "ui/mainLayer/new_ui_5/btn_welfare.png",
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
													controlID = "Label_welfare_Button_welfare_Panel_btList_Panel_left_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
													UUID = "040189d6_875c_4997_839c_ad564660d922",
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
													text = "福利",
													touchAble = "False",
													touchScaleEnable = "False",
													UILayoutViewModel = 
													{
														PositionY = -37,
													},
													visible = "False",
													width = "43",
													ZOrder = "1",
												},
												{
													controlID = "Image_welfare_Button_welfare_Panel_btList_Panel_left_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
													UUID = "710cb35d_80ec_49a0_ae3d_820f56a30007",
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
													controlID = "Image_welfareTip_Button_welfare_Panel_btList_Panel_left_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
													UUID = "df50d8fb_4424_45b4_a85d_ab85b3ec3267",
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
													texturePath = "ui/mainLayer/new_ui_5/btn_welfarenew.png",
													touchAble = "False",
													UILayoutViewModel = 
													{
														
													},
													width = "80",
													ZOrder = "1",
													components = 
													{
														
														{
															controlID = "Image_updateTip_Image_welfareTip_Button_welfare_Panel_btList_Panel_left_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
															UUID = "73c39d7a_817b_4ffc_a738_cb5ff3dbb196",
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
											controlID = "Button_activity_Panel_btList_Panel_left_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
											UUID = "b12d53d0_16da_4a21_890a_964da350bb95",
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
											normal = "ui/mainLayer/new_ui_5/btn_ativity.png",
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
													controlID = "Image_activity_Button_activity_Panel_btList_Panel_left_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
													UUID = "0bdfa968_2796_4b67_9c2d_499161472cad",
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
													controlID = "Image_activityTip_Button_activity_Panel_btList_Panel_left_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
													UUID = "2680b783_22e9_47c4_8f97_15fee03cc35c",
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
													texturePath = "ui/mainLayer/new_ui_5/btn_ativitynew.png",
													touchAble = "False",
													UILayoutViewModel = 
													{
														
													},
													width = "80",
													ZOrder = "1",
													components = 
													{
														
														{
															controlID = "Image_updateTip_Image_activityTip_Button_activity_Panel_btList_Panel_left_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
															UUID = "f1595f0f_a3c1_401a_98c0_c0901fc7a1af",
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
													controlID = "Label_activity_Button_activity_Panel_btList_Panel_left_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
													UUID = "5420e965_773d_4a66_8a0c_716cb78bdcf0",
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
													text = "活动",
													touchAble = "False",
													touchScaleEnable = "False",
													UILayoutViewModel = 
													{
														PositionX = 7,
														PositionY = -35,
													},
													visible = "False",
													width = "43",
													ZOrder = "1",
												},
											},
										},
										{
											controlID = "Button_focus_Panel_btList_Panel_left_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
											UUID = "39b001d8_9592_4804_9631_111e735c9a99",
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
											normal = "ui/mainLayer/new_ui_5/btn_focus.png",
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
													controlID = "Label_focus_Button_focus_Panel_btList_Panel_left_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
													UUID = "7f17c251_3261_4b69_8530_283fba685c70",
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
													text = "关注",
													touchAble = "False",
													touchScaleEnable = "False",
													UILayoutViewModel = 
													{
														PositionY = -37,
													},
													visible = "False",
													width = "44",
													ZOrder = "1",
												},
												{
													controlID = "Image_focus_Button_focus_Panel_btList_Panel_left_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
													UUID = "4c8cd25d_b216_42c3_884d_5c8bcb4b31e4",
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
													controlID = "Image_focusTip_Button_focus_Panel_btList_Panel_left_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
													UUID = "15637f08_6f97_4c68_8288_320b39162128",
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
													texturePath = "ui/mainLayer/new_ui_5/btn_focusnew.png",
													touchAble = "False",
													UILayoutViewModel = 
													{
														
													},
													width = "80",
													ZOrder = "1",
													components = 
													{
														
														{
															controlID = "Image_updateTip_Image_focusTip_Button_focus_Panel_btList_Panel_left_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
															UUID = "1a75f1ca_0fdd_4c71_9187_b4e108e143b6",
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
											controlID = "Button_RoleTeach_Panel_btList_Panel_left_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
											UUID = "4462a0aa_c7ba_488f_a1cc_068daed2c0d3",
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
											normal = "ui/mainLayer/new_ui_5/044.png",
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
													controlID = "Label_RoleTeach_Button_RoleTeach_Panel_btList_Panel_left_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
													UUID = "fac68236_b5d4_4b1d_8936_ecd106adea66",
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
													text = "关注",
													touchAble = "False",
													touchScaleEnable = "False",
													UILayoutViewModel = 
													{
														PositionY = -37,
													},
													visible = "False",
													width = "44",
													ZOrder = "1",
												},
												{
													controlID = "Image_RoleTeach_Button_RoleTeach_Panel_btList_Panel_left_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
													UUID = "1ee45ba9_348b_455d_8772_8249a6f51051",
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
													controlID = "Image_focusTip_Button_RoleTeach_Panel_btList_Panel_left_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
													UUID = "a60fe76d_a2f4_4a7d_bffc_a66d9d17f807",
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
													texturePath = "ui/mainLayer/new_ui_5/049.png",
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
															controlID = "Image_updateTip_Image_focusTip_Button_RoleTeach_Panel_btList_Panel_left_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
															UUID = "52620d33_0043_4049_8d5d_ce45109e96e7",
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
											controlID = "btn_zhibo_Panel_btList_Panel_left_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
											UUID = "19138fa2_8594_4ca7_9a54_f5fdc412cb38",
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
											normal = "ui/mainLayer/new_ui_5/btn_zhibo.png",
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
													controlID = "img_zhibo_btn_zhibo_Panel_btList_Panel_left_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
													UUID = "3a32e2d5_b6b6_43b5_bb7a_8fb8ce265a3c",
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
													texturePath = "ui/mainLayer/new_ui_5/btn_zhibo_s.png",
													touchAble = "False",
													UILayoutViewModel = 
													{
														
													},
													width = "80",
													ZOrder = "1",
													components = 
													{
														
														{
															controlID = "img_zhiboTip_img_zhibo_btn_zhibo_Panel_btList_Panel_left_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
															UUID = "ec9fe057_7152_43aa_a472_25cc3742b693",
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
											controlID = "Button_serverGiftActivity_Panel_btList_Panel_left_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
											UUID = "8eaf50d2_a59e_4c3d_b4f3_db5e4354bc32",
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
											normal = "ui/mainLayer/new_ui_5/a4.png",
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
													controlID = "Label_serverGiftActivity_Button_serverGiftActivity_Panel_btList_Panel_left_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
													UUID = "82565cab_ecdf_4b74_894f_ad2e19757cb9",
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
													text = "关注",
													touchAble = "False",
													touchScaleEnable = "False",
													UILayoutViewModel = 
													{
														PositionY = -37,
													},
													visible = "False",
													width = "44",
													ZOrder = "1",
												},
												{
													controlID = "Image_serverGiftActivity_Button_serverGiftActivity_Panel_btList_Panel_left_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
													UUID = "0898b5be_e25b_4dca_8d62_f14f74e813f2",
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
													controlID = "Image_serverGiftTip_Button_serverGiftActivity_Panel_btList_Panel_left_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
													UUID = "093c39dc_f507_434f_9cc1_219525a64400",
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
													texturePath = "ui/mainLayer/new_ui_5/a4new.png",
													touchAble = "False",
													UILayoutViewModel = 
													{
														
													},
													width = "80",
													ZOrder = "1",
													components = 
													{
														
														{
															controlID = "Image_updateTip_Image_serverGiftTip_Button_serverGiftActivity_Panel_btList_Panel_left_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
															UUID = "dc50daa5_543b_493e_82c5_59c1c21cf551",
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
											controlID = "Button_assist_Panel_btList_Panel_left_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
											UUID = "d96866ae_2339_46d1_9173_1b7b33590e19",
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
													controlID = "Label_title_Button_assist_Panel_btList_Panel_left_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
													UUID = "08a255f4_d005_407a_9f84_e0ee8b97d595",
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
													text = "应援",
													touchAble = "False",
													touchScaleEnable = "False",
													UILayoutViewModel = 
													{
														PositionY = -37,
													},
													width = "44",
													ZOrder = "1",
												},
												{
													controlID = "Image_survey_Button_assist_Panel_btList_Panel_left_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
													UUID = "d006345b_204a_4a26_a290_9e14ea3a4a72",
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
													controlID = "Image_assist_Tip_Button_assist_Panel_btList_Panel_left_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
													UUID = "c8a0b669_77fe_4357_b5b6_a8a3e184ebeb",
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
											controlID = "Button_newYear_Panel_btList_Panel_left_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
											UUID = "c682041a_94e7_4b47_9255_33d765c968d7",
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
													controlID = "Label_backPlayer_Button_newYear_Panel_btList_Panel_left_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
													UUID = "d3cb0bdd_b077_43c4_b7a3_4c3320d3ff07",
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
													text = "元宵",
													touchAble = "False",
													touchScaleEnable = "False",
													UILayoutViewModel = 
													{
														PositionY = -37,
													},
													width = "44",
													ZOrder = "1",
												},
												{
													controlID = "Image_newYearTip_Button_newYear_Panel_btList_Panel_left_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
													UUID = "93dac890_5f4d_4aff_ad70_5ea1b2feeb11",
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
											controlID = "Button_monthCard_Panel_btList_Panel_left_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
											UUID = "3689afff_30e2_469d_80ac_b638dfcbdef3",
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
												PositionX = 115,
												PositionY = 409,
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
													controlID = "Label_monthCard_Button_monthCard_Panel_btList_Panel_left_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
													UUID = "be63267c_8d9c_4907_9e7d_cf3cf06d2108",
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
													text = "新年",
													touchAble = "False",
													touchScaleEnable = "False",
													UILayoutViewModel = 
													{
														PositionY = -37,
													},
													width = "44",
													ZOrder = "1",
												},
												{
													controlID = "Image_monthCardTip_Button_monthCard_Panel_btList_Panel_left_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
													UUID = "842a0083_25b6_4b48_9a02_ddb42a07925a",
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
											controlID = "Button_ScoreReward_Panel_btList_Panel_left_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
											UUID = "f8febaf7_f077_44db_9203_2c56c829d6fa",
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
											normal = "ui/mainLayer/new_ui_5/btn_tzr.png",
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
													controlID = "Label_monthCard_Button_ScoreReward_Panel_btList_Panel_left_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
													UUID = "62f98683_7a27_4faa_af0a_a9aa78e22292",
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
													text = "新年",
													touchAble = "False",
													touchScaleEnable = "False",
													UILayoutViewModel = 
													{
														PositionY = -37,
													},
													visible = "False",
													width = "44",
													ZOrder = "1",
												},
												{
													controlID = "Image_ScoreRewardTip_Button_ScoreReward_Panel_btList_Panel_left_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
													UUID = "8e4513b2_745d_447b_ac41_0ad5d60d84dd",
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
													texturePath = "ui/mainLayer/new_ui_5/btn_tzrnew.png",
													touchAble = "False",
													UILayoutViewModel = 
													{
														
													},
													width = "80",
													ZOrder = "1",
													components = 
													{
														
														{
															controlID = "Image_updateTip_Image_ScoreRewardTip_Button_ScoreReward_Panel_btList_Panel_left_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
															UUID = "19e254e3_69bb_49ec_8111_43a9419d5497",
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
											controlID = "Button_sxsr_Panel_btList_Panel_left_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
											UUID = "9b264baa_92ea_4d7a_80a7_f9e89a30ea1d",
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
													controlID = "Image_sxsrTip_Button_sxsr_Panel_btList_Panel_left_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
													UUID = "8f1a47ad_9391_42db_8145_08eef0e77807",
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
													controlID = "Label_sxsr_Button_sxsr_Panel_btList_Panel_left_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
													UUID = "330c39ed_7315_48a7_9aa3_46f3dd9e7f31",
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
													text = "论坛",
													touchAble = "False",
													touchScaleEnable = "False",
													UILayoutViewModel = 
													{
														PositionX = -14,
														PositionY = -29,
													},
													width = "44",
													ZOrder = "1",
												},
											},
										},
									},
								},
								{
									controlID = "Button_newPlayer_Panel_left_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
									UUID = "d10abdd9_b1df_4c94_8907_5d2dc7e80f5a",
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
										PositionX = 177,
										PositionY = 362,
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
											controlID = "Image_update_Button_newPlayer_Panel_left_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
											UUID = "a3193dec_5d70_4b39_b842_b606f01a0495",
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
											controlID = "Image_newPlayerTip_Button_newPlayer_Panel_left_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
											UUID = "00749d33_ff50_406e_8b3b_a233b776039a",
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
									controlID = "Button_gongzhu_Panel_left_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
									UUID = "7a085e72_fd4b_4fea_a51f_1864857e6b13",
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
											controlID = "Spine_gongzhu_Button_gongzhu_Panel_left_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
											UUID = "698e0348_fd75_4ce4_aa42_62d3ae5bf928",
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
											controlID = "Image_redTips_Button_gongzhu_Panel_left_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
											UUID = "eb6ce78f_3010_4956_b0ab_55f8ece07e9d",
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
									controlID = "Button_btnListEx_Panel_left_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
									UUID = "561e4899_bba2_46ab_b275_4030320db5ca",
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
									normal = "ui/mainLayer/new_ui_5/003.png",
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
											controlID = "Label_focus_Button_btnListEx_Panel_left_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
											UUID = "82f22f36_1b24_4565_b4b6_f8734afe48ad",
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
											text = "关注",
											touchAble = "False",
											touchScaleEnable = "False",
											UILayoutViewModel = 
											{
												PositionY = -37,
											},
											visible = "False",
											width = "44",
											ZOrder = "1",
										},
										{
											controlID = "Image_focus_Button_btnListEx_Panel_left_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
											UUID = "4583d821_7d4e_4ab0_99d9_ed6995af8337",
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
											controlID = "Image_focusTip_Button_btnListEx_Panel_left_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
											UUID = "30f55407_5807_4a12_8a3c_66ae6af8b479",
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
											texturePath = "ui/mainLayer/new_ui_5/049.png",
											touchAble = "False",
											UILayoutViewModel = 
											{
												
											},
											visible = "False",
											width = "80",
											ZOrder = "1",
										},
										{
											controlID = "Panel_btListEx_Button_btnListEx_Panel_left_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
											UUID = "e8dd979c_1519_4dfa_8fa3_e665620ef834",
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
											panelTexturePath = "ui/mainLayer/new_ui_5/004.png",
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
													controlID = "Button_preview_Panel_btListEx_Button_btnListEx_Panel_left_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
													UUID = "be92a7e7_cf20_47a4_8765_1daaf6cc97ac",
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
															controlID = "Label_update_Button_preview_Panel_btListEx_Button_btnListEx_Panel_left_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
															UUID = "1690293b_83f4_4c5f_ad36_74be386a5156",
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
															text = "预告",
															touchAble = "False",
															touchScaleEnable = "False",
															UILayoutViewModel = 
															{
																PositionX = 46,
																PositionY = -2,
															},
															width = "44",
															ZOrder = "1",
														},
														{
															controlID = "Image_update_Button_preview_Panel_btListEx_Button_btnListEx_Panel_left_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
															UUID = "6af34135_c04d_412a_a621_c59306f98d3f",
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
															controlID = "Image_previewTip_Button_preview_Panel_btListEx_Button_btnListEx_Panel_left_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
															UUID = "6d1f0a16_60f6_46c6_9d8c_7f4dfb03142f",
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
													controlID = "Button_backPlayer_Panel_btListEx_Button_btnListEx_Panel_left_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
													UUID = "4c0ef5b3_c8e1_4960_8d0e_945f2904e6ef",
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
													normal = "ui/mainLayer/new_ui_5/btn_back.png",
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
															controlID = "Label_backPlayer_Button_backPlayer_Panel_btListEx_Button_btnListEx_Panel_left_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
															UUID = "e486b22d_0aae_4d2c_bc64_42a88af3d2f0",
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
															text = "回归",
															touchAble = "False",
															touchScaleEnable = "False",
															UILayoutViewModel = 
															{
																PositionX = 47,
																PositionY = 2,
															},
															width = "44",
															ZOrder = "1",
														},
														{
															controlID = "Image_update_Button_backPlayer_Panel_btListEx_Button_btnListEx_Panel_left_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
															UUID = "1cdb5eb2_84b8_4e6f_9b83_d96bfe7adede",
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
															controlID = "Image_backPlayerTip_Button_backPlayer_Panel_btListEx_Button_btnListEx_Panel_left_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
															UUID = "f345fb06_09e2_492f_a5e7_c0afde811b6a",
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
													controlID = "Button_update_Panel_btListEx_Button_btnListEx_Panel_left_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
													UUID = "3e0d9acd_11a1_48a9_b23e_2de3594c1cfb",
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
													normal = "ui/mainLayer/new_ui_5/btn_update.png",
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
															controlID = "Label_update_Button_update_Panel_btListEx_Button_btnListEx_Panel_left_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
															UUID = "238c2ffd_6879_45c9_9c39_7434aeaa0af8",
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
															text = "更新",
															touchAble = "False",
															touchScaleEnable = "False",
															UILayoutViewModel = 
															{
																PositionX = 44,
															},
															width = "44",
															ZOrder = "1",
														},
														{
															controlID = "Image_update_Button_update_Panel_btListEx_Button_btnListEx_Panel_left_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
															UUID = "f1d307ca_b3e5_4807_8ac7_b5b0ce4a06e3",
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
															controlID = "Image_updateTip_Button_update_Panel_btListEx_Button_btnListEx_Panel_left_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
															UUID = "9dd4ebe1_3182_4ddd_b80c_b15357d5f159",
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
													controlID = "Button_wj_Panel_btListEx_Button_btnListEx_Panel_left_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
													UUID = "136ebeed_8753_4362_8fd5_c9a21d3d262a",
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
													normal = "ui/mainLayer/new_ui_5/btn_survey.png",
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
															controlID = "Label_title_Button_wj_Panel_btListEx_Button_btnListEx_Panel_left_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
															UUID = "0ec9ab5c_a830_4b68_a0b2_1c5ed51e039a",
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
															text = "问卷",
															touchAble = "False",
															touchScaleEnable = "False",
															UILayoutViewModel = 
															{
																PositionX = 45,
																PositionY = 2,
															},
															width = "44",
															ZOrder = "1",
														},
														{
															controlID = "Image_survey_Button_wj_Panel_btListEx_Button_btnListEx_Panel_left_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
															UUID = "bca6e0cc_3aa9_4468_acbf_24292e5e47a8",
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
															controlID = "Image_wjTip_Button_wj_Panel_btListEx_Button_btnListEx_Panel_left_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
															UUID = "3b558fa8_eb01_42e9_8694_6f3a4d0afd14",
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
													controlID = "Button_OneYearShare_Panel_btListEx_Button_btnListEx_Panel_left_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
													UUID = "7d17efbc_f5b7_4e4c_bde1_d6307db5d7f4",
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
													normal = "ui/mainLayer/new_ui_5/9small.png",
													pressed = "ui/mainLayer/new_ui_5/9small.png",
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
															controlID = "Image_lvli_Button_OneYearShare_Panel_btListEx_Button_btnListEx_Panel_left_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
															UUID = "0ef549fd_d1b6_4e2e_b026_32df7f655d30",
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
															controlID = "Label_title_Button_OneYearShare_Panel_btListEx_Button_btnListEx_Panel_left_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
															UUID = "0b2dcbdb_e978_4753_a1df_29ad69060ebd",
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
															text = "履历",
															touchAble = "False",
															touchScaleEnable = "False",
															UILayoutViewModel = 
															{
																PositionX = 43,
															},
															width = "44",
															ZOrder = "1",
														},
													},
												},
												{
													controlID = "btn_zhuifan_Panel_btListEx_Button_btnListEx_Panel_left_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
													UUID = "38b6a970_2db0_4369_85c7_e684c1289822",
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
													normal = "ui/mainLayer/new_ui_5/btn_zhuifan.png",
													pressed = "ui/mainLayer/new_ui_5/btn_zhuifan.png",
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
															controlID = "Label_title_btn_zhuifan_Panel_btListEx_Button_btnListEx_Panel_left_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
															UUID = "297bf368_e3c0_4f8a_9ffa_b48ae946d4a6",
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
															text = "追番",
															touchAble = "False",
															touchScaleEnable = "False",
															UILayoutViewModel = 
															{
																PositionX = 43,
															},
															width = "44",
															ZOrder = "1",
														},
														{
															controlID = "Image_zhuifan_btn_zhuifan_Panel_btListEx_Button_btnListEx_Panel_left_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
															UUID = "7771c1c2_f36b_47b1_b970_8c366d214ccd",
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
													controlID = "btn_phone_Panel_btListEx_Button_btnListEx_Panel_left_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
													UUID = "d5179584_080f_416f_a5e7_2183c58f9b0b",
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
													normal = "ui/mainLayer/new_ui_5/btn_phone_small.png",
													pressed = "ui/mainLayer/new_ui_5/btn_phone_small.png",
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
															controlID = "Label_title_btn_phone_Panel_btListEx_Button_btnListEx_Panel_left_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
															UUID = "a173f2a7_117a_47cd_9e4e_54fc40b730be",
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
															text = "通讯",
															touchAble = "False",
															touchScaleEnable = "False",
															UILayoutViewModel = 
															{
																PositionX = 43,
															},
															width = "44",
															ZOrder = "1",
														},
														{
															controlID = "Image_zhuifan_btn_phone_Panel_btListEx_Button_btnListEx_Panel_left_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
															UUID = "def43bdc_8672_4241_a252_9b166bfc1515",
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
									controlID = "Button_newPlayerBook_Panel_left_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
									UUID = "af495784_9f8d_41ce_8aa5_57937f8961e4",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEButton",
									ClickHighLightEnabled = "True",
									dstBlendFunc = "771",
									flipX = "False",
									flipY = "False",
									height = "57",
									ignoreSize = "True",
									name = "Button_newPlayerBook",
									normal = "ui/fuli/activityNewPlayerPop/1.png",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "True",
									UILayoutViewModel = 
									{
										PositionX = 168,
										PositionY = 293,
										LeftPositon = 26,
										TopPosition = 87,
										relativeToName = "Panel",
									},
									UItype = "Button",
									width = "74",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "Image_newPlayerTip_Button_newPlayerBook_Panel_left_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
											UUID = "38ec8b60_fc42_401c_9834_7df8a95efc75",
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
							controlID = "Panel_middle_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
							UUID = "1cb2f831_7ed5_4967_ac17_cfc4124d1d21",
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
									controlID = "Panel_camera_Panel_middle_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
									UUID = "9ebc3691_b598_44cc_94ef_02ad6f71c0d1",
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
							controlID = "Panel_ai_chat_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
							UUID = "3def0797_8256_432f_8e09_095048e210d6",
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
									controlID = "Image_ai_chat_Panel_ai_chat_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
									UUID = "65d2b847_cbc9_4c12_8f98_8443287ef5cb",
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
											controlID = "Image_ai_icon_Image_ai_chat_Panel_ai_chat_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
											UUID = "b0aa2590_a01b_47b4_8de8_c976e4dfa3ac",
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
													controlID = "Label_ai_tip1_Image_ai_icon_Image_ai_chat_Panel_ai_chat_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
													UUID = "5cfe3287_db16_4d6e_bd08_889a8e8c883a",
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
													text = "消息",
													touchAble = "False",
													touchScaleEnable = "False",
													UILayoutViewModel = 
													{
														PositionX = 25,
													},
													width = "47",
													ZOrder = "1",
												},
												{
													controlID = "Label_ai_tip2_Image_ai_icon_Image_ai_chat_Panel_ai_chat_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
													UUID = "49b57d07_d4cd_43b1_afb6_80f9291646c6",
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
													name = "Label_ai_tip2",
													nTextAlign = "1",
													nTextHAlign = "1",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "770",
													text = "现在",
													touchAble = "False",
													touchScaleEnable = "False",
													UILayoutViewModel = 
													{
														PositionX = 750,
													},
													width = "47",
													ZOrder = "1",
												},
											},
										},
									},
								},
								{
									controlID = "Image_head_bord_Panel_ai_chat_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
									UUID = "e0086c65_5194_4cff_bb7b_e47a3ac32f47",
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
											controlID = "ClippingNode_player_Image_head_bord_Panel_ai_chat_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
											UUID = "35122575_c6fd_42f5_96a5_c326a3cc8f89",
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
													controlID = "Image_head_ClippingNode_player_Image_head_bord_Panel_ai_chat_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
													UUID = "4dfb6e21_e4d1_4971_9c12_a9714c3f9dcb",
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
									controlID = "Label_hero_name_Panel_ai_chat_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
									UUID = "81890f01_1a4a_4039_b0f9_9bc3ec9a6a4c",
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
									fontSize = "24",
									fontStroke = 
									{
										IsStroke = false,
										StrokeColor = "#FFE6E6E6",
										StrokeSize = 1,
									},
									height = "30",
									ignoreSize = "True",
									name = "Label_hero_name",
									nTextAlign = "1",
									nTextHAlign = "1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "十香",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionX = -326,
										PositionY = -3,
									},
									width = "51",
									ZOrder = "1",
								},
								{
									controlID = "Panel_ai_mask_Panel_ai_chat_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
									UUID = "e85c3fdb_cf65_497c_990b_b580bedd880d",
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
									controlID = "Label_ai_message_Panel_ai_chat_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
									UUID = "dfee251b_b91a_4b2a_8d69_eaf7f49abd53",
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
									text = "…",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionX = 376,
										PositionY = -43,
									},
									width = "25",
									ZOrder = "1",
								},
							},
						},
						{
							controlID = "Image_switch_role_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
							UUID = "0b44cd6f_d74f_42ec_b3c4_0f1a075536e4",
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
							controlID = "Panel_black_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
							UUID = "ac475374_85a7_4048_9b51_3b99ca157e82",
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
							controlID = "Spine_changeEffect_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
							UUID = "707ddcd8_67e0_4122_9798_6ed63e75fc3b",
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
							controlID = "PrefabGift_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
							UUID = "e2915c05_6f23_4b1c_9fba_f7e50c0d9331",
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
									controlID = "Button_Gift_PrefabGift_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
									UUID = "f8f9470b_75cc_42a5_ad7f_d9dc8ff8760d",
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
									controlID = "Name_PrefabGift_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
									UUID = "72143d73_35c9_47c9_b9e2_093815e5bb3f",
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
									height = "22",
									ignoreSize = "True",
									name = "Name",
									nTextAlign = "1",
									nTextHAlign = "1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "圣诞礼包",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionX = -2,
										PositionY = -31,
										relativeToName = "Panel",
									},
									width = "68",
									ZOrder = "1",
								},
								{
									controlID = "TimeCount_PrefabGift_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
									UUID = "50ab6c67_5cd4_4703_9ccb_479ee3d69415",
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
									width = "57",
									ZOrder = "1",
								},
							},
						},
						{
							controlID = "GiftRoot_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
							UUID = "681002de_fd1f_435d_90a8_1561e01e9970",
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
				id = "Image_top_bar_bg_Panel_top_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
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
				id = "Image_camera_Panel_top_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
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
				id = "Image_tili_bg_top_part2_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
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
				id = "Image_tili_top_part2_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
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
				id = "Label_tili_count_top_part2_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
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
				id = "Button_add_tili_top_part2_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
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
				id = "Image_coin_bg_top_part2_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
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
				id = "Image_coin_top_part2_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
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
				id = "Label_coin_count_top_part2_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
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
				id = "Button_add_coin_top_part2_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
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
				id = "Image_zuan_bg_top_part2_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
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
				id = "Image_zuan_top_part2_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
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
				id = "Label_zuan_count_top_part2_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
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
				id = "Button_add_zuan_top_part2_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
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
				id = "Button_setting_Panel_top_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
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
				id = "Image_MainLayer_1_Panel_clip_Panel_right_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
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
				id = "button_yuehui_Panel_clip_Panel_right_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
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
				id = "Image_MainLayer_1(2)_Panel_clip_Panel_right_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
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
				id = "Button_zuozhan_Panel_clip_Panel_right_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
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
				id = "Image_MainLayer_1(4)_Panel_clip_Panel_right_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
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
				id = "Image_text_Panel_clip_Panel_right_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
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
				id = "Image_MainLayer_1(3)_Panel_clip_Panel_right_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
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
				id = "Image_MainLayer_1(3)(2)_Panel_clip_Panel_right_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
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
				id = "Image_MainLayer_1(3)(3)_Panel_clip_Panel_right_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
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
				id = "Button_pokedex_Panel_clip_Panel_right_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
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
				id = "Button_friend_Panel_clip_Panel_right_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
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
				id = "Button_task_Panel_clip_Panel_right_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
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
				id = "Panel_activity_Panel_clip_Panel_right_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
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
				id = "Image_fairyMain_1_Panel_bottom_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
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
				id = "Image_fairyMain_1(2)_Panel_bottom_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
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
				id = "Image_fairyMain_1(3)_Panel_bottom_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
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
				id = "Button_fairy_Panel_bottom_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
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
				id = "Button_bag_Panel_bottom_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
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
				id = "Button_zhaohuan_Panel_bottom_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
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
				id = "Button_shop_Panel_bottom_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
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
				id = "Button_phone_Panel_bottom_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
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
				id = "Image_chat_bg_Panel_chat_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
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
				id = "Panel_chat_di_Panel_chat_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
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
				id = "Image_chat_Panel_chat_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
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
				id = "Panel_player_info_Panel_top_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
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
				id = "Image_split_line_Panel_bottom_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
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
				id = "Button_recharge_Panel_bottom_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
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
				id = "btn_infoStation_Panel_clip_Panel_right_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
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
				id = "Image_MainLayer_1(5)_Panel_clip_Panel_right_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
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
				id = "Button_league_Panel_bottom_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
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
				id = "Image_MainLayer_1(3)-Copy1_Panel_clip_Panel_right_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
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
				id = "Button_dispatch_Panel_clip_Panel_right_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
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
				id = "Panel_system_Panel_top_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
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
				id = "Panel_feelling_info__Panel_right_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
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
				id = "Panel_feelling_info__Panel_right_Panel_base_Panel-MerryMainLayer_Layer1_MainScene_Game",
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
			"ui/mainLayer/new_ui_5/camera_logo.png",
			"ui/mainLayer/new_ui_5/top_bar_bg.png",
			"ui/mainLayer/new_ui_5/ui_008.png",
			"ui/playerInfo/avatar/TXBK_moren_0.png",
			"icon/hero/name/1101011.png",
			"ui/playerInfo/avatar/TXBK_moren_1.png",
			"ui/playerInfo/avatar/TXBK_1.png",
			"ui/mainLayer/new_ui_5/lvbg.png",
			"ui/mainLayer/new_ui_5/ui_007.png",
			"ui/mainLayer/new_ui_5/ui_006.png",
			"icon/hero/face/1101011.png",
			"ui/common/news_small.png",
			"ui/mainLayer/new_ui/ui_002.png",
			"ui/003.png",
			"ui/mainLayer/new_ui_5/btn_setting.png",
			"ui/mainLayer/new_ui/ui_004.png",
			"ui/newCity/build/9.png",
			"ui/mainLayer/new_ui/progress_01.png",
			"ui/mainLayer/new_ui/progress_02.png",
			"ui/common/button09.png",
			"ui/065.png",
			"ui/020.png",
			"ui/mainLayer/new_ui_5/btn_battle.png",
			"ui/028.png",
			"ui/mainLayer/new_ui/battle_text.png",
			"ui/mainLayer/new_ui/bai1.png",
			"ui/mainLayer/new_ui_5/btn_dating.png",
			"ui/027.png",
			"ui/mainui/arrow_r.png",
			"ui/920.png",
			"ui/mainLayer/new_ui/dating_text.png",
			"ui/mainLayer/new_ui_5/a3.png",
			"ui/mainLayer/new_ui_5/a3new.png",
			"ui/mainLayer/new_ui_5/btn_order.png",
			"ui/mainLayer/new_ui_5/btn_ordernew.png",
			"ui/mainLayer/new_ui_5/btn_tujian.png",
			"ui/mainLayer/new_ui_5/btn_tujiannew.png",
			"ui/mainui/main_infoStation.png",
			"ui/mainLayer/sxsr.png",
			"ui/mainui/main_mask.png",
			"ui/mainLayer/new_ui/bai2.png",
			"ui/mainLayer/new_ui/btn_guoqing.png",
			"ui/mainLayer/new_ui/activity_tab_01.png",
			"ui/mainLayer/new_ui/activity_tab_02.png",
			"ui/mainLayer/ad_btn.png",
			"ui/mainLayer/new_ui/a2.png",
			"ui/mainLayer/new_ui_5/btn_mail.png",
			"ui/mainui/mail_logo.png",
			"ui/mainLayer/new_ui_5/btn_mailnew.png",
			"ui/mail/special_mail/img_bubble.png",
			"ui/activity/fanShi/08.png",
			"ui/mainLayer3/c13.png",
			"ui/mainLayer3/35.png",
			"ui/activity/bingKai/003.png",
			"ui/mainLayer/new_ui/btn_ativity.png",
			"ui/mainLayer3/36.png",
			"ui/mainLayer/new_ui_5/btn_contact.png",
			"ui/mainLayer/new_ui_5/btn_contactnew.png",
			"ui/mainLayer/new_ui_4/rukou.png",
			"ui/mainLayer/new_ui/a6.png",
			"ui/mainLayer/c2.png",
			"ui/mainLayer/L1.png",
			"ui/mainLayer/L3.png",
			"ui/mainLayer/L2.png",
			"ui/mainLayer/c3.png",
			"ui/mainLayer/c1.png",
			"ui/mainLayer/new_ui_5/bottombg.png",
			"ui/mainLayer/new_ui_5/ui_001.png",
			"ui/mainLayer/new_ui_5/iconbg.png",
			"ui/mainLayer/new_ui_5/btn_sprite.png",
			"ui/common/redPoint.png",
			"ui/fairy/new_ui/unlcok2.png",
			"ui/mainLayer/new_ui_5/btn_spritenew.png",
			"ui/mainLayer/new_ui_5/btn_bag.png",
			"ui/mainLayer/new_ui_5/btn_league.png",
			"ui/mainLayer/new_ui_5/btn_leaguenew.png",
			"ui/mainLayer/new_ui_5/btn_summon.png",
			"ui/mainLayer/new_ui_5/btn_summonnew.png",
			"ui/summon/024.png",
			"ui/summon/elf_contract/033.png",
			"ui/summon/elf_contract/034.png",
			"ui/001.png",
			"ui/mainLayer/new_ui_5/btn_phone.png",
			"ui/mainLayer/new_ui_5/btn_phonenew.png",
			"ui/mainLayer/new_ui_5/btn_store.png",
			"ui/mainLayer/new_ui_5/btn_recharge.png",
			"ui/recharge/new.png",
			"ui/mainLayer/new_ui_5/chat_bg.png",
			"ui/mainLayer/new_ui_5/btn_chat.png",
			"ui/mainLayer/new_ui/redpack_tips_bg.png",
			"ui/league/ui_10.png",
			"ui/mainLayer/a004.png",
			"ui/mainLayer/a002.png",
			"ui/mainLayer/a001.png",
			"ui/mainui/camera_logo.png",
			"ui/mainLayer/new_ui_5/res_bg.png",
			"icon/system/001.png",
			"ui/mainLayer/new_ui_5/jiahao.png",
			"icon/system/003.png",
			"icon/system/005.png",
			"ui/mainLayer/new_ui/a1.png",
			"ui/mainLayer/new_ui_5/btn_notice.png",
			"ui/mainui/notice_logo.png",
			"ui/mainLayer/new_ui_5/btn_noticenew.png",
			"ui/mainLayer/new_ui_5/btn_welfare.png",
			"ui/mainui/gift_logo.png",
			"ui/mainLayer/new_ui_5/btn_welfarenew.png",
			"ui/mainLayer/new_ui_5/btn_ativity.png",
			"ui/mainLayer/new_ui_5/btn_ativitynew.png",
			"ui/mainLayer/new_ui_5/btn_focus.png",
			"ui/mainLayer/new_ui_5/btn_focusnew.png",
			"ui/mainLayer/new_ui_5/044.png",
			"ui/mainLayer/new_ui_5/049.png",
			"ui/mainLayer/new_ui_5/btn_zhibo.png",
			"ui/mainLayer/new_ui_5/btn_zhibo_s.png",
			"ui/mainLayer/new_ui_5/a4.png",
			"ui/mainLayer/new_ui_5/a4new.png",
			"ui/mainLayer/new_ui/btn_assist.png",
			"ui/mainLayer/new_ui/btn_back.png",
			"ui/mainLayer/new_ui/btn_monthcard.png",
			"ui/mainLayer/new_ui_5/btn_tzr.png",
			"ui/mainLayer/new_ui_5/btn_tzrnew.png",
			"ui/mainLayer/new_ui/btn_newPlayer.png",
			"ui/task/01/4.png",
			"ui/mainLayer/new_ui_5/003.png",
			"ui/mainLayer/new_ui_5/004.png",
			"ui/preview/main_btn.png",
			"ui/mainLayer/new_ui_5/btn_back.png",
			"ui/mainLayer/new_ui_5/btn_update.png",
			"ui/mainLayer/new_ui_5/btn_survey.png",
			"ui/mainLayer/new_ui_5/9small.png",
			"ui/mainLayer/new_ui_5/btn_zhuifan.png",
			"ui/mainLayer/new_ui_5/btn_phone_small.png",
			"ui/fuli/activityNewPlayerPop/1.png",
			"ui/mainLayer/new_ui/ai_tip/001.png",
			"ui/mainLayer/new_ui/ai_tip/002.png",
			"ui/mainLayer/new_ui/ai_tip/003.png",
			"icon/hero/face/1108011.png",
			"ui/recharge/gifts/giftIcon/regression.png",
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

