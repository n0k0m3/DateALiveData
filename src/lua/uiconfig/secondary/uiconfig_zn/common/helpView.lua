local t = 
{
	version = 1,
	components = 
	{
		
		{
			controlID = "Panel-helpView_Layer1_common_Game",
			UUID = "da6ed9f6_c982_4a23_9677_1ffb15525e90",
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
					controlID = "Panel_base_Panel-helpView_Layer1_common_Game",
					UUID = "366adbf3_040b_4aa1_93c8_2236c40988f2",
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
							controlID = "Panel_content_Panel_base_Panel-helpView_Layer1_common_Game",
							UUID = "c5fda388_5993_43ec_9454_c64323b6d8ad",
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
							height = "503",
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
							width = "1008",
							ZOrder = "1",
							components = 
							{
								
								{
									controlID = "Image_bg1_Panel_content_Panel_base_Panel-helpView_Layer1_common_Game",
									UUID = "88205204_5bfb_4a4c_97fd_aef415454d36",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "True;capInsetsX:0;capInsetsY:0;capInsetsWidth:0;capInsetsHeight:0",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "517",
									ignoreSize = "False",
									name = "Image_bg1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/common/help/001.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										
									},
									width = "1020",
									ZOrder = "1",
								},
								{
									controlID = "Image_bg2_Panel_content_Panel_base_Panel-helpView_Layer1_common_Game",
									UUID = "6b07c961_eae5_4774_9307_a3a59b00e6d6",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "166",
									ignoreSize = "True",
									name = "Image_bg2",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/common/help/002.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = -443,
										PositionY = -147,
									},
									width = "52",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "Label_helpView_1_Image_bg2_Panel_content_Panel_base_Panel-helpView_Layer1_common_Game",
											UUID = "6f1fbada_e742_4eec_ade2_a37bdb698cf5",
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
												StrokeColor = "#FF457278",
												StrokeSize = 1,
											},
											height = "0",
											ignoreSize = "False",
											name = "Label_helpView_1",
											nTextAlign = "1",
											nTextHAlign = "1",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "770",
											text = "莉莉子",
											touchAble = "False",
											touchScaleEnable = "False",
											UILayoutViewModel = 
											{
												PositionX = 4,
												PositionY = -1,
											},
											width = "26",
											ZOrder = "1",
										},
									},
								},
								{
									controlID = "Button_close_Panel_content_Panel_base_Panel-helpView_Layer1_common_Game",
									UUID = "85c93fbe_2202_423c_b629_d8ceadfdf7e4",
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
									pressed = "ui/common/pop_ui/pop_btn_02.png",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "True",
									UILayoutViewModel = 
									{
										PositionX = 479,
										PositionY = 220,
									},
									UItype = "Button",
									width = "60",
									ZOrder = "1",
								},
								{
									controlID = "Panel_info_Panel_content_Panel_base_Panel-helpView_Layer1_common_Game",
									UUID = "e0f8a1d3_9a0e_4aa7_b504_fe72c154952b",
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
									height = "503",
									ignoreSize = "False",
									name = "Panel_info",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = -504,
										PositionY = -252,
									},
									uipanelviewmodel = 
									{
										Layout="Absolute",
										nType = "0"
									},
									width = "1008",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "Label_tittle_Panel_info_Panel_content_Panel_base_Panel-helpView_Layer1_common_Game",
											UUID = "44b33c5e_4588_4a44_93f1_3e3b61ca49c1",
											anchorPoint = "False",
											anchorPointX = "0",
											anchorPointY = "0",
											classname = "MELabel",
											compPath = "luacomponents.common.MEIconLabel",
											dstBlendFunc = "771",
											FontColor = "#FFCFE6F7",
											fontName = "font/MFLiHei_Noncommercial.ttf",
											fontShadow = 
											{
												IsShadow = false,
												ShadowColor = "#FFFFFFFF",
												ShadowAlpha = 255,
												OffsetX = 0,
												OffsetY = 0,
											},
											fontSize = "90",
											fontStroke = 
											{
												IsStroke = false,
												StrokeColor = "#FFE6E6E6",
												StrokeSize = 1,
											},
											height = "0",
											ignoreSize = "False",
											name = "Label_tittle",
											nTextAlign = "2",
											nTextHAlign = "2",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "770",
											text = "帮助",
											touchAble = "False",
											touchScaleEnable = "False",
											UILayoutViewModel = 
											{
												PositionX = 791,
												PositionY = -10,
											},
											width = "200",
											ZOrder = "1",
										},
										{
											controlID = "Panel_page_Panel_info_Panel_content_Panel_base_Panel-helpView_Layer1_common_Game",
											UUID = "e81ad0af_91fc_4b01_8a44_64a2b9e7e1b9",
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
											height = "25",
											ignoreSize = "False",
											name = "Panel_page",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 504,
												PositionY = 73,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "150",
											ZOrder = "1",
										},
										{
											controlID = "PageView_item_Panel_info_Panel_content_Panel_base_Panel-helpView_Layer1_common_Game",
											UUID = "56e8baff_2e64_47a9_9db6_f4963542a5de",
											anchorPoint = "False",
											anchorPointX = "0",
											anchorPointY = "0",
											backGroundScale9Enable = "False",
											bgColorOpacity = "50",
											bIsOpenClipping = "True",
											bounceEnable = "False",
											classname = "MEPageView",
											colorType = "0;SingleColor:#FFE6E6E6;GraduallyChangingColorStart:#FFFFFFFF;GraduallyChangingColorEnd:#FFFFFFFF;vectorX:0;vectorY:0",
											DesignHeight = "640",
											DesignType = "0",
											DesignWidth = "960",
											dstBlendFunc = "771",
											height = "417",
											ignoreSize = "False",
											name = "PageView_item",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "True",
											UILayoutViewModel = 
											{
												PositionX = 363,
												PositionY = 24,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "625",
											ZOrder = "1",
										},
										{
											controlID = "ScrollView_list_Panel_info_Panel_content_Panel_base_Panel-helpView_Layer1_common_Game",
											UUID = "856a5de6_4bc1_43ee_b2b4_232108e4ac23",
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
											height = "417",
											ignoreSize = "False",
											innerHeight = "417",
											innerWidth = "625",
											name = "ScrollView_list",
											showScrollbar = "False",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "True",
											UILayoutViewModel = 
											{
												PositionX = 363,
												PositionY = 24,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "625",
											ZOrder = "1",
										},
									},
								},
								{
									controlID = "Panel_help_item_Panel_content_Panel_base_Panel-helpView_Layer1_common_Game",
									UUID = "25eee37c_ea2a_4a90_b40e_808140ce9b8c",
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
									height = "417",
									ignoreSize = "False",
									name = "Panel_help_item",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = -500,
										PositionY = -800,
									},
									uipanelviewmodel = 
									{
										Layout="Absolute",
										nType = "0"
									},
									width = "625",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "Image_line_Panel_help_item_Panel_content_Panel_base_Panel-helpView_Layer1_common_Game",
											UUID = "cf2c5f7c_8c18_4644_ae78_ad1cd3f7d563",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											classname = "MEImage",
											dstBlendFunc = "771",
											height = "375",
											ignoreSize = "True",
											name = "Image_line",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											texturePath = "ui/help/ui_03.png",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 313,
												PositionY = 189,
											},
											width = "10",
											ZOrder = "1",
										},
										{
											controlID = "Panel_middle_Panel_help_item_Panel_content_Panel_base_Panel-helpView_Layer1_common_Game",
											UUID = "53545408_8947_4309_bb01_9a6d554cd70d",
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
											height = "417",
											ignoreSize = "False",
											name = "Panel_middle",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
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
											width = "625",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "Image_frame_Panel_middle_Panel_help_item_Panel_content_Panel_base_Panel-helpView_Layer1_common_Game",
													UUID = "17ccf175_8f6b_4811_9263_e8f3219ef614",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0.5",
													backGroundScale9Enable = "True;capInsetsX:35;capInsetsY:35;capInsetsWidth:5;capInsetsHeight:5",
													classname = "MEImage",
													dstBlendFunc = "771",
													height = "67",
													ignoreSize = "False",
													name = "Image_frame",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "1",
													texturePath = "ui/help/ui_04.png",
													touchAble = "False",
													UILayoutViewModel = 
													{
														PositionX = 313,
														PositionY = 100,
													},
													width = "300",
													ZOrder = "1",
													components = 
													{
														
														{
															controlID = "Label_dsc_Image_frame_Panel_middle_Panel_help_item_Panel_content_Panel_base_Panel-helpView_Layer1_common_Game",
															UUID = "402847b9_90b8_489e_b47d_d73bd9dcb6df",
															anchorPoint = "False",
															anchorPointX = "0.5",
															anchorPointY = "0.5",
															classname = "MELabel",
															compPath = "luacomponents.common.MEIconLabel",
															dstBlendFunc = "771",
															FontColor = "#FF045A97",
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
															name = "Label_dsc",
															nTextAlign = "1",
															nTextHAlign = "1",
															sizepercentx = "0",
															sizepercenty = "0",
															sizeType = "0",
															srcBlendFunc = "770",
															text = "滑动头像切换精灵",
															touchAble = "False",
															touchScaleEnable = "False",
															UILayoutViewModel = 
															{
																
															},
															width = "163",
															ZOrder = "1",
														},
													},
												},
											},
										},
										{
											controlID = "Panel_left_Panel_help_item_Panel_content_Panel_base_Panel-helpView_Layer1_common_Game",
											UUID = "d8a57fbd_3264_4aa7_a1ac_6f1a2318a60d",
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
											height = "417",
											ignoreSize = "False",
											name = "Panel_left",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
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
											width = "625",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "Image_frame_Panel_left_Panel_help_item_Panel_content_Panel_base_Panel-helpView_Layer1_common_Game",
													UUID = "9c739e48_2ad0_4903_affc_718c2d8aa33a",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0.5",
													backGroundScale9Enable = "True;capInsetsX:35;capInsetsY:35;capInsetsWidth:5;capInsetsHeight:5",
													classname = "MEImage",
													dstBlendFunc = "771",
													height = "67",
													ignoreSize = "False",
													name = "Image_frame",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "1",
													texturePath = "ui/help/ui_04.png",
													touchAble = "False",
													UILayoutViewModel = 
													{
														PositionX = 157,
														PositionY = 45,
													},
													width = "300",
													ZOrder = "1",
													components = 
													{
														
														{
															controlID = "Label_dsc_Image_frame_Panel_left_Panel_help_item_Panel_content_Panel_base_Panel-helpView_Layer1_common_Game",
															UUID = "9daf3988_2839_4945_987d_c8605e992489",
															anchorPoint = "False",
															anchorPointX = "0.5",
															anchorPointY = "0.5",
															classname = "MELabel",
															compPath = "luacomponents.common.MEIconLabel",
															dstBlendFunc = "771",
															FontColor = "#FF045A97",
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
															name = "Label_dsc",
															nTextAlign = "1",
															nTextHAlign = "1",
															sizepercentx = "0",
															sizepercenty = "0",
															sizeType = "0",
															srcBlendFunc = "770",
															text = "滑动头像切换精灵",
															touchAble = "False",
															touchScaleEnable = "False",
															UILayoutViewModel = 
															{
																
															},
															width = "163",
															ZOrder = "1",
														},
													},
												},
											},
										},
										{
											controlID = "Panel_right_Panel_help_item_Panel_content_Panel_base_Panel-helpView_Layer1_common_Game",
											UUID = "a6accde9_a7d5_4e82_81b6_74681e2a4208",
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
											height = "417",
											ignoreSize = "False",
											name = "Panel_right",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "770",
											touchAble = "False",
											UILayoutViewModel = 
											{
												
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "625",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "Image_frame_Panel_right_Panel_help_item_Panel_content_Panel_base_Panel-helpView_Layer1_common_Game",
													UUID = "ccdb42c8_e396_4474_b554_57e11d025059",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0.5",
													backGroundScale9Enable = "True;capInsetsX:35;capInsetsY:35;capInsetsWidth:5;capInsetsHeight:5",
													classname = "MEImage",
													dstBlendFunc = "771",
													flipX = "True",
													height = "67",
													ignoreSize = "False",
													name = "Image_frame",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "1",
													texturePath = "ui/help/ui_04.png",
													touchAble = "False",
													UILayoutViewModel = 
													{
														PositionX = 467,
														PositionY = 301,
													},
													width = "300",
													ZOrder = "1",
													components = 
													{
														
														{
															controlID = "Label_dsc_Image_frame_Panel_right_Panel_help_item_Panel_content_Panel_base_Panel-helpView_Layer1_common_Game",
															UUID = "404d729e_8f73_4bbb_8a4d_3ebf82ae86fe",
															anchorPoint = "False",
															anchorPointX = "0.5",
															anchorPointY = "0.5",
															classname = "MELabel",
															compPath = "luacomponents.common.MEIconLabel",
															dstBlendFunc = "771",
															FontColor = "#FF045A97",
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
															name = "Label_dsc",
															nTextAlign = "1",
															nTextHAlign = "1",
															sizepercentx = "0",
															sizepercenty = "0",
															sizeType = "0",
															srcBlendFunc = "770",
															text = "滑动头像切换精灵",
															touchAble = "False",
															touchScaleEnable = "False",
															UILayoutViewModel = 
															{
																
															},
															width = "163",
															ZOrder = "1",
														},
													},
												},
											},
										},
									},
								},
								{
									controlID = "Label_text_Panel_content_Panel_base_Panel-helpView_Layer1_common_Game",
									UUID = "8e8f764c_1fbb_4607_a7dd_f7afc081fd5b",
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
									name = "Label_text",
									nTextAlign = "0",
									nTextHAlign = "0",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "123456789",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionX = -200,
										PositionY = -500,
									},
									width = "113",
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
			"ui/common/help/001.png",
			"ui/common/help/002.png",
			"ui/common/pop_ui/pop_btn_02.png",
			"ui/help/ui_03.png",
			"ui/help/ui_04.png",
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

