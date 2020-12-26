local t = 
{
	version = 1,
	components = 
	{
		
		{
			controlID = "Panel-editJoinLimitView_Layer1_league_Game",
			UUID = "e8f4614e_d294_4c8f_8895_e123adb2b9a3",
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
					controlID = "Panel_base_Panel-editJoinLimitView_Layer1_league_Game",
					UUID = "e0e1ad20_6088_4dbd_adef_e15520abf231",
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
							controlID = "Image_bg_Panel_base_Panel-editJoinLimitView_Layer1_league_Game",
							UUID = "e70dc124_ad36_4cec_9201_dc1516871242",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							backGroundScale9Enable = "True;capInsetsX:0;capInsetsY:0;capInsetsWidth:0;capInsetsHeight:0",
							classname = "MEImage",
							dstBlendFunc = "771",
							height = "324",
							ignoreSize = "False",
							name = "Image_bg",
							sizepercentx = "100",
							sizepercenty = "100",
							sizeType = "0",
							srcBlendFunc = "1",
							texturePath = "ui/common/pop_ui/pop_bg_01.png",
							touchAble = "False",
							UILayoutViewModel = 
							{
								PositionX = 568,
								PositionY = 340,
								LeftPositon = 118,
								TopPosition = 70,
							},
							width = "540",
							ZOrder = "1",
						},
						{
							controlID = "Panel_content_Panel_base_Panel-editJoinLimitView_Layer1_league_Game",
							UUID = "4908e29e_1238_4551_b91c_889ed7693fad",
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
							height = "320",
							ignoreSize = "False",
							name = "Panel_content",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							touchAble = "False",
							UILayoutViewModel = 
							{
								PositionX = 568,
								PositionY = 340,
							},
							uipanelviewmodel = 
							{
								Layout="Absolute",
								nType = "0"
							},
							width = "540",
							ZOrder = "1",
							components = 
							{
								
								{
									controlID = "Button_close_Panel_content_Panel_base_Panel-editJoinLimitView_Layer1_league_Game",
									UUID = "216333f4_2756_4736_96c1_2fe61d6b506c",
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
										PositionX = 243,
										PositionY = 133,
									},
									UItype = "Button",
									width = "60",
									ZOrder = "1",
								},
								{
									controlID = "Label_tittle_Panel_content_Panel_base_Panel-editJoinLimitView_Layer1_league_Game",
									UUID = "7024ff1f_58e7_4f75_873e_3eb2cabe2f44",
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
									fontSize = "24",
									fontStroke = 
									{
										IsStroke = false,
										StrokeColor = "#FFE6E6E6",
										StrokeSize = 1,
									},
									height = "30",
									ignoreSize = "True",
									name = "Label_tittle",
									nTextAlign = "1",
									nTextHAlign = "1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "Beitrittsvoraussetzung",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionX = -254,
										PositionY = 130,
									},
									width = "147",
									ZOrder = "1",
								},
								{
									controlID = "Button_ok_Panel_content_Panel_base_Panel-editJoinLimitView_Layer1_league_Game",
									UUID = "986d175c_68f3_438d_b3d8_2b5df60bb0d1",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "True;capInsetsX:0;capInsetsY:0;capInsetsWidth:0;capInsetsHeight:0",
									classname = "MEButton",
									ClickHighLightEnabled = "True",
									dstBlendFunc = "771",
									flipX = "False",
									flipY = "False",
									height = "46",
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
										PositionY = -118,
									},
									UItype = "Button",
									width = "120",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "Label_ok_Button_ok_Panel_content_Panel_base_Panel-editJoinLimitView_Layer1_league_Game",
											UUID = "9f80a0e4_288f_4478_b921_f52ffeb78ac1",
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
											fontSize = "22",
											fontStroke = 
											{
												IsStroke = false,
												StrokeColor = "#FFE6E6E6",
												StrokeSize = 1,
											},
											height = "25",
											ignoreSize = "True",
											name = "Label_ok",
											nTextAlign = "1",
											nTextHAlign = "1",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "770",
											text = "Änderungen speichern",
											touchAble = "False",
											touchScaleEnable = "False",
											UILayoutViewModel = 
											{
												
											},
											width = "91",
											ZOrder = "1",
										},
									},
								},
								{
									controlID = "Panel_condition_Panel_content_Panel_base_Panel-editJoinLimitView_Layer1_league_Game",
									UUID = "3f453fe1_4b72_4a0d_b92d_f53addedcf4e",
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
									height = "200",
									ignoreSize = "False",
									name = "Panel_condition",
									scaleX = "1.3",
									scaleY = "1.3",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = -220,
										PositionY = -146,
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
											controlID = "Button_left_Panel_condition_Panel_content_Panel_base_Panel-editJoinLimitView_Layer1_league_Game",
											UUID = "9d3c16bf_d2ae_4c9d_a7a4_a3cb23edf7c2",
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
											name = "Button_left",
											normal = "ui/league/ui_30.png",
											opacity = "234",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "True",
											UILayoutViewModel = 
											{
												PositionX = 75,
												PositionY = 157,
											},
											UItype = "Button",
											width = "138",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "Label_left_Button_left_Panel_condition_Panel_content_Panel_base_Panel-editJoinLimitView_Layer1_league_Game",
													UUID = "39ddb110_735e_41c8_8853_c854e44ac07a",
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
													name = "Label_left",
													nTextAlign = "1",
													nTextHAlign = "1",
													scaleX = "0.77",
													scaleY = "0.77",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "770",
													text = "Erreiche Level",
													touchAble = "False",
													touchScaleEnable = "False",
													UILayoutViewModel = 
													{
														PositionX = -18,
													},
													width = "83",
													ZOrder = "1",
												},
												{
													controlID = "Image_arrow_left_Button_left_Panel_condition_Panel_content_Panel_base_Panel-editJoinLimitView_Layer1_league_Game",
													UUID = "ed71ded1_2120_4e0a_a03c_f4059fefd2bd",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0.5",
													backGroundScale9Enable = "False",
													classname = "MEImage",
													dstBlendFunc = "771",
													height = "17",
													ignoreSize = "True",
													name = "Image_arrow_left",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "1",
													texturePath = "ui/league/ui_32.png",
													touchAble = "False",
													UILayoutViewModel = 
													{
														PositionX = 50,
														PositionY = -5,
													},
													width = "20",
													ZOrder = "1",
												},
											},
										},
										{
											controlID = "Image_left_Panel_condition_Panel_content_Panel_base_Panel-editJoinLimitView_Layer1_league_Game",
											UUID = "a1e8edc4_319e_4ce9_987a_41bf9496f405",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "1",
											backGroundScale9Enable = "False",
											classname = "MEImage",
											dstBlendFunc = "771",
											height = "250",
											ignoreSize = "False",
											name = "Image_left",
											opacity = "0",
											scaleY = "0.1",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											texturePath = "ui/league/ui_31.png",
											touchAble = "True",
											UILayoutViewModel = 
											{
												PositionX = 75,
												PositionY = 130,
											},
											width = "138",
											ZOrder = "1",
										},
									},
								},
								{
									controlID = "Panel_values_Panel_content_Panel_base_Panel-editJoinLimitView_Layer1_league_Game",
									UUID = "9c3cdea6_2dee_4021_99d6_848be56bd8ea",
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
									height = "200",
									ignoreSize = "False",
									name = "Panel_values",
									scaleX = "1.3",
									scaleY = "1.3",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = 35,
										PositionY = -146,
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
											controlID = "Button_right_Panel_values_Panel_content_Panel_base_Panel-editJoinLimitView_Layer1_league_Game",
											UUID = "315b176c_dd4d_4a2b_947c_b657e07867f9",
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
											name = "Button_right",
											normal = "ui/league/ui_30.png",
											opacity = "234",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "True",
											UILayoutViewModel = 
											{
												PositionX = 75,
												PositionY = 157,
											},
											UItype = "Button",
											width = "138",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "Label_right_Button_right_Panel_values_Panel_content_Panel_base_Panel-editJoinLimitView_Layer1_league_Game",
													UUID = "96f47e4d_aec4_42a4_a3cd_47ed64ba5908",
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
													name = "Label_right",
													nTextAlign = "1",
													nTextHAlign = "1",
													scaleX = "0.77",
													scaleY = "0.77",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "770",
													text = "> 10",
													touchAble = "False",
													touchScaleEnable = "False",
													UILayoutViewModel = 
													{
														PositionX = -18,
													},
													width = "38",
													ZOrder = "1",
												},
												{
													controlID = "Image_arrow_right_Button_right_Panel_values_Panel_content_Panel_base_Panel-editJoinLimitView_Layer1_league_Game",
													UUID = "fdd05df9_6f61_4db0_bf13_9323106fcd69",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0.5",
													backGroundScale9Enable = "False",
													classname = "MEImage",
													dstBlendFunc = "771",
													height = "17",
													ignoreSize = "True",
													name = "Image_arrow_right",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "1",
													texturePath = "ui/league/ui_32.png",
													touchAble = "False",
													UILayoutViewModel = 
													{
														PositionX = 50,
														PositionY = -5,
													},
													width = "20",
													ZOrder = "1",
												},
											},
										},
										{
											controlID = "Image_right_Panel_values_Panel_content_Panel_base_Panel-editJoinLimitView_Layer1_league_Game",
											UUID = "efc73665_4bc4_4a99_ae2d_decd9f239e1a",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "1",
											backGroundScale9Enable = "False",
											classname = "MEImage",
											dstBlendFunc = "771",
											height = "250",
											ignoreSize = "False",
											name = "Image_right",
											opacity = "0",
											scaleY = "0.1",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											texturePath = "ui/league/ui_31.png",
											touchAble = "True",
											UILayoutViewModel = 
											{
												PositionX = 75,
												PositionY = 130,
											},
											width = "138",
											ZOrder = "1",
										},
									},
								},
								{
									controlID = "Button_item_Panel_content_Panel_base_Panel-editJoinLimitView_Layer1_league_Game",
									UUID = "0cba6e87_0358_4782_b210_cf7db5d6a7e6",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEButton",
									ClickHighLightEnabled = "True",
									dstBlendFunc = "771",
									flipX = "False",
									flipY = "False",
									height = "40",
									ignoreSize = "False",
									name = "Button_item",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "True",
									UILayoutViewModel = 
									{
										PositionX = -115,
										PositionY = -600,
									},
									UItype = "Button",
									width = "160",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "Label_content_Button_item_Panel_content_Panel_base_Panel-editJoinLimitView_Layer1_league_Game",
											UUID = "fe88fa5c_fbb2_4c2a_9132_1eec81fd1964",
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
											fontSize = "20",
											fontStroke = 
											{
												IsStroke = false,
												StrokeColor = "#FFE6E6E6",
												StrokeSize = 1,
											},
											height = "23",
											ignoreSize = "True",
											name = "Label_content",
											nTextAlign = "1",
											nTextHAlign = "1",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "770",
											text = "Levelanforderung",
											touchAble = "False",
											touchScaleEnable = "False",
											UILayoutViewModel = 
											{
												
											},
											width = "83",
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
			"ui/common/pop_ui/pop_btn_02.png",
			"ui/common/button09.png",
			"ui/league/ui_30.png",
			"ui/league/ui_32.png",
			"ui/league/ui_31.png",
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

