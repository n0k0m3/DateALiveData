local t = 
{
	version = 1,
	components = 
	{
		
		{
			controlID = "Panel-dfwSummerTaskView_Layer2_dafuwong_Game",
			UUID = "65435c19_11fa_42f5_b9b8_8c94a273d0a3",
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
					controlID = "Panel_root_Panel-dfwSummerTaskView_Layer2_dafuwong_Game",
					UUID = "fc0212f5_8ab2_4ffc_9d1c_64365da20a11",
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
							controlID = "Image_di_Panel_root_Panel-dfwSummerTaskView_Layer2_dafuwong_Game",
							UUID = "5d126313_3780_4d71_8398_115cbf991c07",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							backGroundScale9Enable = "False",
							classname = "MEImage",
							dstBlendFunc = "771",
							height = "640",
							ignoreSize = "True",
							name = "Image_di",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							texturePath = "ui/dfwsummer/BG.png",
							touchAble = "False",
							UILayoutViewModel = 
							{
								
							},
							width = "1386",
							ZOrder = "1",
						},
						{
							controlID = "Image_bg_Panel_root_Panel-dfwSummerTaskView_Layer2_dafuwong_Game",
							UUID = "f839c1ac_1201_4c01_b256_c711405899ca",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							backGroundScale9Enable = "False",
							classname = "MEImage",
							dstBlendFunc = "771",
							height = "640",
							ignoreSize = "True",
							name = "Image_bg",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							texturePath = "ui/dfwsummer/turntable/004.png",
							touchAble = "False",
							UILayoutViewModel = 
							{
								
							},
							width = "1386",
							ZOrder = "1",
							components = 
							{
								
								{
									controlID = "Button_refresh_Image_bg_Panel_root_Panel-dfwSummerTaskView_Layer2_dafuwong_Game",
									UUID = "68138599_a9b8_4b62_96b9_50bc19c05dc0",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEButton",
									ClickHighLightEnabled = "True",
									dstBlendFunc = "771",
									flipX = "False",
									flipY = "False",
									height = "340",
									HitType = 
									{
										nHitType = 1,
										nXpos = 0,
										nYpos = 142,
										nHitWidth = 84,
										nHitHeight = 105
									},
									ignoreSize = "True",
									name = "Button_refresh",
									normal = "ui/dfwsummer/task/002.png",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "True",
									UILayoutViewModel = 
									{
										PositionX = -508,
										PositionY = 33,
									},
									UItype = "Button",
									width = "84",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "Label_refresh_Button_refresh_Image_bg_Panel_root_Panel-dfwSummerTaskView_Layer2_dafuwong_Game",
											UUID = "44ee182f_59d5_45c0_89e6_5e41b78642de",
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
												IsStroke = true,
												StrokeColor = "#FFE0B250",
												StrokeSize = 2,
											},
											height = "25",
											ignoreSize = "True",
											name = "Label_refresh",
											nTextAlign = "1",
											nTextHAlign = "1",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "770",
											text = "Refresh",
											touchAble = "False",
											touchScaleEnable = "False",
											UILayoutViewModel = 
											{
												PositionY = -3,
											},
											width = "41",
											ZOrder = "1",
										},
										{
											controlID = "Image_cost_Button_refresh_Image_bg_Panel_root_Panel-dfwSummerTaskView_Layer2_dafuwong_Game",
											UUID = "3a48d207_ad06_4cee_b7ae_2d776d7a0e2c",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											classname = "MEImage",
											dstBlendFunc = "771",
											height = "36",
											ignoreSize = "True",
											name = "Image_cost",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											texturePath = "ui/dfwsummer/task/001.png",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionY = -4,
											},
											width = "72",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "Image_cost_icon_Image_cost_Button_refresh_Image_bg_Panel_root_Panel-dfwSummerTaskView_Layer2_dafuwong_Game",
													UUID = "2fc32b85_6a1a_4fcb_a4b7_583c01bf352d",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0.5",
													backGroundScale9Enable = "False",
													classname = "MEImage",
													dstBlendFunc = "771",
													height = "100",
													ignoreSize = "True",
													name = "Image_cost_icon",
													scaleX = "0.4",
													scaleY = "0.4",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "1",
													texturePath = "icon/system/005.png",
													touchAble = "False",
													UILayoutViewModel = 
													{
														PositionX = -23,
														PositionY = -2,
													},
													width = "100",
													ZOrder = "1",
												},
												{
													controlID = "Label_cost_num_Image_cost_Button_refresh_Image_bg_Panel_root_Panel-dfwSummerTaskView_Layer2_dafuwong_Game",
													UUID = "6f542ff3_ea74_4be6_92e7_562f1c4b3dcf",
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
													height = "23",
													ignoreSize = "True",
													name = "Label_cost_num",
													nTextAlign = "1",
													nTextHAlign = "1",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "770",
													text = "100",
													touchAble = "False",
													touchScaleEnable = "False",
													UILayoutViewModel = 
													{
														PositionX = -4,
													},
													width = "32",
													ZOrder = "1",
												},
											},
										},
										{
											controlID = "Label_tip_Button_refresh_Image_bg_Panel_root_Panel-dfwSummerTaskView_Layer2_dafuwong_Game",
											UUID = "68dfb22f_b962_47e8_a840_fb15b55dd27b",
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
												StrokeColor = "#FFE0B250",
												StrokeSize = 2,
											},
											height = "27",
											ignoreSize = "True",
											name = "Label_tip",
											nTextAlign = "1",
											nTextHAlign = "1",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "770",
											text = "Refresh",
											touchAble = "False",
											touchScaleEnable = "False",
											UILayoutViewModel = 
											{
												PositionY = 60,
											},
											width = "45",
											ZOrder = "1",
										},
										{
											controlID = "Label_tip_time_Button_refresh_Image_bg_Panel_root_Panel-dfwSummerTaskView_Layer2_dafuwong_Game",
											UUID = "f333c748_cbfc_478e_a1e4_7454fc883c6e",
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
												StrokeColor = "#FFE0B250",
												StrokeSize = 2,
											},
											height = "27",
											ignoreSize = "True",
											name = "Label_tip_time",
											nTextAlign = "1",
											nTextHAlign = "1",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "770",
											text = "20 hari 10 jam 6 menit",
											touchAble = "False",
											touchScaleEnable = "False",
											UILayoutViewModel = 
											{
												PositionY = 33,
											},
											width = "127",
											ZOrder = "1",
										},
									},
								},
								{
									controlID = "Image_top_Image_bg_Panel_root_Panel-dfwSummerTaskView_Layer2_dafuwong_Game",
									UUID = "f30dfe21_ebdd_48bf_9938_efb96eb68191",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "142",
									ignoreSize = "True",
									name = "Image_top",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/dfwsummer/turntable/002.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = 580,
										PositionY = 249,
									},
									width = "406",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "Image_xian_Image_top_Image_bg_Panel_root_Panel-dfwSummerTaskView_Layer2_dafuwong_Game",
											UUID = "e7667bb0_b05a_42c5_a977_bd6bb48fd35a",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											classname = "MEImage",
											dstBlendFunc = "771",
											height = "568",
											ignoreSize = "True",
											name = "Image_xian",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											texturePath = "ui/dfwsummer/turntable/001.png",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = -46,
												PositionY = -217,
											},
											width = "184",
											ZOrder = "1",
										},
										{
											controlID = "Image_wa_Image_top_Image_bg_Panel_root_Panel-dfwSummerTaskView_Layer2_dafuwong_Game",
											UUID = "486de008_575f_4e12_9147_774671fcaaec",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											classname = "MEImage",
											dstBlendFunc = "771",
											height = "84",
											ignoreSize = "True",
											name = "Image_wa",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											texturePath = "ui/dfwsummer/turntable/003.png",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = -116,
												PositionY = -521,
											},
											width = "112",
											ZOrder = "1",
										},
									},
								},
							},
						},
						{
							controlID = "Panel_task_1_Panel_root_Panel-dfwSummerTaskView_Layer2_dafuwong_Game",
							UUID = "dc826d78_27c8_4ffc_a3a2_499d70935c6a",
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
							height = "438",
							ignoreSize = "False",
							name = "Panel_task_1",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							touchAble = "False",
							UILayoutViewModel = 
							{
								PositionX = -285,
								PositionY = -18,
							},
							uipanelviewmodel = 
							{
								Layout="Absolute",
								nType = "0"
							},
							width = "272",
							ZOrder = "1",
						},
						{
							controlID = "Panel_task_2_Panel_root_Panel-dfwSummerTaskView_Layer2_dafuwong_Game",
							UUID = "398b6b8d_cf8c_41ff_9ab8_fe8cb6c9030a",
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
							height = "438",
							ignoreSize = "False",
							name = "Panel_task_2",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							touchAble = "False",
							UILayoutViewModel = 
							{
								PositionY = -18,
							},
							uipanelviewmodel = 
							{
								Layout="Absolute",
								nType = "0"
							},
							width = "272",
							ZOrder = "1",
						},
						{
							controlID = "Panel_task_3_Panel_root_Panel-dfwSummerTaskView_Layer2_dafuwong_Game",
							UUID = "a5902540_83b9_47e8_87c5_dd9fd7e99fc2",
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
							height = "438",
							ignoreSize = "False",
							name = "Panel_task_3",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							touchAble = "False",
							UILayoutViewModel = 
							{
								PositionX = 285,
								PositionY = -18,
							},
							uipanelviewmodel = 
							{
								Layout="Absolute",
								nType = "0"
							},
							width = "272",
							ZOrder = "1",
						},
						{
							controlID = "Image_xia2_Panel_root_Panel-dfwSummerTaskView_Layer2_dafuwong_Game",
							UUID = "1784d98e_a2cc_4283_9579_141e94a8c99f",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							backGroundScale9Enable = "False",
							classname = "MEImage",
							dstBlendFunc = "771",
							height = "100",
							ignoreSize = "True",
							name = "Image_xia2",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							texturePath = "ui/dfwsummer/cg/005.png",
							touchAble = "False",
							UILayoutViewModel = 
							{
								PositionY = 210,
							},
							width = "990",
							ZOrder = "1",
						},
						{
							controlID = "Image_xia2(2)_Panel_root_Panel-dfwSummerTaskView_Layer2_dafuwong_Game",
							UUID = "76d6f309_a83c_4cd0_bfe2_d25e18feb7ab",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							backGroundScale9Enable = "False",
							classname = "MEImage",
							dstBlendFunc = "771",
							height = "28",
							ignoreSize = "True",
							name = "Image_xia2(2)",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							texturePath = "ui/dfwsummer/task/005.png",
							touchAble = "False",
							UILayoutViewModel = 
							{
								PositionY = -294,
							},
							width = "886",
							ZOrder = "1",
						},
					},
				},
				{
					controlID = "Panel_prefab_Panel-dfwSummerTaskView_Layer2_dafuwong_Game",
					UUID = "5f1c58fe_60a1_4875_b640_af1546a622a3",
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
						PositionX = 586,
						PositionY = -504,
						LeftPositon = 18,
						TopPosition = 824,
						relativeToName = "Panel",
						nType = 3,
						nGravity = 1,
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
							controlID = "Panel_taskItem_Panel_prefab_Panel-dfwSummerTaskView_Layer2_dafuwong_Game",
							UUID = "019e400b_fe1c_4d19_a4b2_70563a46f384",
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
							height = "456",
							ignoreSize = "False",
							name = "Panel_taskItem",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							touchAble = "False",
							UILayoutViewModel = 
							{
								PositionX = -158,
								PositionY = 32,
							},
							uipanelviewmodel = 
							{
								Layout="Absolute",
								nType = "0"
							},
							width = "286",
							ZOrder = "1",
							components = 
							{
								
								{
									controlID = "Image_diban_Panel_taskItem_Panel_prefab_Panel-dfwSummerTaskView_Layer2_dafuwong_Game",
									UUID = "5cd52087_dfd8_4749_b0f3_ae83deab0384",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "470",
									ignoreSize = "True",
									name = "Image_diban",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/dfwsummer/task/004.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										
									},
									width = "290",
									ZOrder = "1",
								},
								{
									controlID = "Label_name_Panel_taskItem_Panel_prefab_Panel-dfwSummerTaskView_Layer2_dafuwong_Game",
									UUID = "4294c744_ff39_4879_a8a0_c533917e5094",
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
									fontSize = "22",
									fontStroke = 
									{
										IsStroke = true,
										StrokeColor = "#FF345EAF",
										StrokeSize = 1,
									},
									height = "27",
									ignoreSize = "True",
									name = "Label_name",
									nTextAlign = "1",
									nTextHAlign = "1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "Nama Quest",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionY = 193,
									},
									width = "92",
									ZOrder = "1",
								},
								{
									controlID = "Label_get_reward_Panel_taskItem_Panel_prefab_Panel-dfwSummerTaskView_Layer2_dafuwong_Game",
									UUID = "5708bc0b_c68c_4b99_9a25_2cc3cdfdb682",
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
									fontSize = "22",
									fontStroke = 
									{
										IsStroke = false,
										StrokeColor = "#FFE6E6E6",
										StrokeSize = 1,
									},
									height = "25",
									ignoreSize = "True",
									name = "Label_get_reward",
									nTextAlign = "1",
									nTextHAlign = "1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "Hadiah yang didapat",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionY = 150,
									},
									width = "90",
									ZOrder = "1",
								},
								{
									controlID = "Label_tips_Panel_taskItem_Panel_prefab_Panel-dfwSummerTaskView_Layer2_dafuwong_Game",
									UUID = "eb1470e2_dd54_4c9b_ba4b_b00bbea5896d",
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
									height = "50",
									ignoreSize = "False",
									name = "Label_tips",
									nTextAlign = "0",
									nTextHAlign = "0",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "Deskripsi Quest",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionY = -21,
									},
									width = "250",
									ZOrder = "1",
								},
								{
									controlID = "Button_receive_Panel_taskItem_Panel_prefab_Panel-dfwSummerTaskView_Layer2_dafuwong_Game",
									UUID = "daad97e1_e4aa_4976_8c08_0c2111df2c08",
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
									name = "Button_receive",
									normal = "ui/dfwsummer/task/003.png",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "True",
									UILayoutViewModel = 
									{
										PositionX = -2,
										PositionY = -183,
									},
									UItype = "Button",
									width = "132",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "Label_receive_Button_receive_Panel_taskItem_Panel_prefab_Panel-dfwSummerTaskView_Layer2_dafuwong_Game",
											UUID = "9985f75b_3ac8_4b44_9161_c375550e54f0",
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
												StrokeColor = "#FFBA8254",
												StrokeSize = 2,
											},
											height = "36",
											ignoreSize = "True",
											name = "Label_receive",
											nTextAlign = "1",
											nTextHAlign = "1",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "770",
											text = "Beli",
											touchAble = "False",
											touchScaleEnable = "False",
											UILayoutViewModel = 
											{
												PositionY = -1,
											},
											width = "56",
											ZOrder = "1",
										},
									},
								},
								{
									controlID = "Label_geted_Panel_taskItem_Panel_prefab_Panel-dfwSummerTaskView_Layer2_dafuwong_Game",
									UUID = "7c0621e6_67c4_4324_8800_99581acfa4d8",
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
									name = "Label_geted",
									nTextAlign = "1",
									nTextHAlign = "1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "Sudah Beli",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionY = -183,
									},
									visible = "False",
									width = "75",
									ZOrder = "1",
								},
								{
									controlID = "Panel_reward_Panel_taskItem_Panel_prefab_Panel-dfwSummerTaskView_Layer2_dafuwong_Game",
									UUID = "0860e4ba_bc33_4ba8_844d_6f89c3a410ef",
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
									height = "100",
									ignoreSize = "False",
									name = "Panel_reward",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionY = 78,
									},
									uipanelviewmodel = 
									{
										Layout="Absolute",
										nType = "0"
									},
									width = "100",
									ZOrder = "1",
								},
								{
									controlID = "ScrollView_cost_Panel_taskItem_Panel_prefab_Panel-dfwSummerTaskView_Layer2_dafuwong_Game",
									UUID = "119f3120_e26d_4e95_8274_52a3b0e3e2be",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									bgColorOpacity = "50",
									bIsOpenClipping = "True",
									bounceEnable = "False",
									classname = "MEScrollView",
									colorType = "0;SingleColor:#FFE6E6E6;GraduallyChangingColorStart:#FFFFFFFF;GraduallyChangingColorEnd:#FFFFFFFF;vectorX:0;vectorY:0",
									direction = "2",
									dstBlendFunc = "771",
									height = "80",
									ignoreSize = "False",
									innerHeight = "80",
									innerWidth = "200",
									name = "ScrollView_cost",
									showScrollbar = "False",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "True",
									UILayoutViewModel = 
									{
										PositionX = -3,
										PositionY = -101,
									},
									uipanelviewmodel = 
									{
										Layout="Absolute",
										nType = "0"
									},
									width = "200",
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
			"ui/dfwsummer/BG.png",
			"ui/dfwsummer/turntable/004.png",
			"ui/dfwsummer/task/002.png",
			"ui/dfwsummer/task/001.png",
			"icon/system/005.png",
			"ui/dfwsummer/turntable/002.png",
			"ui/dfwsummer/turntable/001.png",
			"ui/dfwsummer/turntable/003.png",
			"ui/dfwsummer/cg/005.png",
			"ui/dfwsummer/task/005.png",
			"ui/dfwsummer/task/004.png",
			"ui/dfwsummer/task/003.png",
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

