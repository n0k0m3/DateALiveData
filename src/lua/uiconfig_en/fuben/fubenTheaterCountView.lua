local t = 
{
	version = 1,
	components = 
	{
		
		{
			controlID = "Panel-fubenTheaterCountView_Layer1_fuben_Game",
			UUID = "52bf2b71_f958_4953_b22d_f6f9baec0847",
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
					controlID = "Panel_root_Panel-fubenTheaterCountView_Layer1_fuben_Game",
					UUID = "75df5215_164b_4846_a09f_39306e0c61f9",
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
						PositionX = 568,
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
							controlID = "Image_content_Panel_root_Panel-fubenTheaterCountView_Layer1_fuben_Game",
							UUID = "79dcea02_4cb6_41d9_be62_8470619c5a2e",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							backGroundScale9Enable = "False",
							classname = "MEImage",
							dstBlendFunc = "771",
							height = "324",
							ignoreSize = "True",
							name = "Image_content",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							texturePath = "ui/common/mini_pop/9.png",
							touchAble = "True",
							UILayoutViewModel = 
							{
								
							},
							width = "540",
							ZOrder = "1",
							components = 
							{
								
								{
									controlID = "Image_fubenTheaterCountView_1_Image_content_Panel_root_Panel-fubenTheaterCountView_Layer1_fuben_Game",
									UUID = "88faa128_8930_49af_819a_1c6925fe79fb",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "True;capInsetsX:0;capInsetsY:0;capInsetsWidth:0;capInsetsHeight:0",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "205",
									ignoreSize = "False",
									name = "Image_fubenTheaterCountView_1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/common/mini_pop/7.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionY = 8,
									},
									width = "521",
									ZOrder = "1",
								},
								{
									controlID = "Label_name_Image_content_Panel_root_Panel-fubenTheaterCountView_Layer1_fuben_Game",
									UUID = "000bfa03_d10e_4fc6_a26f_d03af5ce5cd0",
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
									height = "35",
									ignoreSize = "True",
									name = "Label_name",
									nTextAlign = "1",
									nTextHAlign = "1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "System Notice",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionX = -254,
										PositionY = 130,
									},
									width = "114",
									ZOrder = "1",
								},
								{
									controlID = "Button_close_Image_content_Panel_root_Panel-fubenTheaterCountView_Layer1_fuben_Game",
									UUID = "3e46f576_2dfc_4e69_bb0f_ebd0f5efd21b",
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
										PositionX = 240,
										PositionY = 132,
									},
									UItype = "Button",
									width = "60",
									ZOrder = "1",
								},
								{
									controlID = "Label_remain_Image_content_Panel_root_Panel-fubenTheaterCountView_Layer1_fuben_Game",
									UUID = "747d612f_b1d4_453c_ab37_585557da7021",
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
									fontSize = "22",
									fontStroke = 
									{
										IsStroke = false,
										StrokeColor = "#FFE6E6E6",
										StrokeSize = 1,
									},
									height = "27",
									ignoreSize = "True",
									name = "Label_remain",
									nTextAlign = "1",
									nTextHAlign = "1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "Chances Left",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionX = -241,
										PositionY = -124,
									},
									width = "91",
									ZOrder = "1",
								},
								{
									controlID = "Label_remainCount_Image_content_Panel_root_Panel-fubenTheaterCountView_Layer1_fuben_Game",
									UUID = "bf4c6207_cb3b_46e6_b49b_f2e1197079b2",
									anchorPoint = "False",
									anchorPointX = "0",
									anchorPointY = "0.5",
									classname = "MELabel",
									compPath = "luacomponents.common.MEIconLabel",
									dstBlendFunc = "771",
									FontColor = "#FFEF5F7D",
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
									name = "Label_remainCount",
									nTextAlign = "1",
									nTextHAlign = "1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "4",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionX = -139,
										PositionY = -122,
									},
									width = "26",
									ZOrder = "1",
								},
								{
									controlID = "Button_ok_Image_content_Panel_root_Panel-fubenTheaterCountView_Layer1_fuben_Game",
									UUID = "cb891001_01f9_459d_823a_aebccfefd341",
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
									name = "Button_ok",
									normal = "ui/common/button_middle_n.png",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "True",
									UILayoutViewModel = 
									{
										PositionX = 195,
										PositionY = -122,
									},
									UItype = "Button",
									width = "124",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "Label_ok_Button_ok_Image_content_Panel_root_Panel-fubenTheaterCountView_Layer1_fuben_Game",
											UUID = "0adb2ad7_3cc7_48dd_8813_cfdd554c75ed",
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
											name = "Label_ok",
											nTextAlign = "1",
											nTextHAlign = "1",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "770",
											text = "Confirm",
											touchAble = "False",
											touchScaleEnable = "False",
											UILayoutViewModel = 
											{
												
											},
											width = "54",
											ZOrder = "1",
										},
									},
								},
								{
									controlID = "Image_tips_Image_content_Panel_root_Panel-fubenTheaterCountView_Layer1_fuben_Game",
									UUID = "5dfedfe5_29bc_4c1b_9481_7e99502036d8",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "16",
									ignoreSize = "True",
									name = "Image_tips",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/common/mini_pop/035.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionY = 85,
									},
									width = "386",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "Label_tips_Image_tips_Image_content_Panel_root_Panel-fubenTheaterCountView_Layer1_fuben_Game",
											UUID = "5b364e88_b4de_48db_bcb2_eba4f9e5cd1d",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											classname = "MELabel",
											compPath = "luacomponents.common.MEIconLabel",
											dstBlendFunc = "771",
											FontColor = "#FFE3E4F0",
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
											height = "0",
											ignoreSize = "True",
											name = "Label_tips",
											nTextAlign = "1",
											nTextHAlign = "1",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "770",
											touchAble = "False",
											touchScaleEnable = "False",
											UILayoutViewModel = 
											{
												
											},
											width = "0",
											ZOrder = "1",
										},
									},
								},
								{
									controlID = "Panel_count_1_Image_content_Panel_root_Panel-fubenTheaterCountView_Layer1_fuben_Game",
									UUID = "11411c3f_527c_4bec_a084_0588ea29e78f",
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
									height = "102",
									ignoreSize = "False",
									name = "Panel_count_1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "True",
									UILayoutViewModel = 
									{
										PositionX = -196,
										PositionY = -8,
									},
									uipanelviewmodel = 
									{
										Layout="Absolute",
										nType = "0"
									},
									width = "102",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "Image_count_normal_Panel_count_1_Image_content_Panel_root_Panel-fubenTheaterCountView_Layer1_fuben_Game",
											UUID = "98853866_a3a5_4608_ad33_56e997fd96b7",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											classname = "MEImage",
											dstBlendFunc = "771",
											height = "102",
											ignoreSize = "True",
											name = "Image_count_normal",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											texturePath = "ui/common/mini_pop/037.png",
											touchAble = "False",
											UILayoutViewModel = 
											{
												
											},
											width = "102",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "Label_count_normal_Image_count_normal_Panel_count_1_Image_content_Panel_root_Panel-fubenTheaterCountView_Layer1_fuben_Game",
													UUID = "290584ac_f096_4692_aec3_ef0a0bfb3947",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0.5",
													classname = "MELabel",
													compPath = "luacomponents.common.MEIconLabel",
													dstBlendFunc = "771",
													FontColor = "#FFE3E4F0",
													fontName = "font/MFLiHei_Noncommercial.ttf",
													fontShadow = 
													{
														IsShadow = false,
														ShadowColor = "#FFFFFFFF",
														ShadowAlpha = 255,
														OffsetX = 0,
														OffsetY = 0,
													},
													fontSize = "50",
													fontStroke = 
													{
														IsStroke = true,
														StrokeColor = "#FF3C4664",
														StrokeSize = 1,
													},
													height = "64",
													ignoreSize = "True",
													name = "Label_count_normal",
													nTextAlign = "1",
													nTextHAlign = "1",
													opacity = "76",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "770",
													text = "1",
													touchAble = "False",
													touchScaleEnable = "False",
													UILayoutViewModel = 
													{
														
													},
													width = "29",
													ZOrder = "1",
												},
											},
										},
										{
											controlID = "Image_count_select_Panel_count_1_Image_content_Panel_root_Panel-fubenTheaterCountView_Layer1_fuben_Game",
											UUID = "8e05e301_aa23_4098_ad66_a5eedc7ac191",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											classname = "MEImage",
											dstBlendFunc = "771",
											height = "102",
											ignoreSize = "True",
											name = "Image_count_select",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											texturePath = "ui/common/mini_pop/039.png",
											touchAble = "False",
											UILayoutViewModel = 
											{
												
											},
											visible = "False",
											width = "102",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "Label_count_select_Image_count_select_Panel_count_1_Image_content_Panel_root_Panel-fubenTheaterCountView_Layer1_fuben_Game",
													UUID = "4791a9d2_d289_4fea_af4e_1cfb0fe399fe",
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
													fontSize = "50",
													fontStroke = 
													{
														IsStroke = true,
														StrokeColor = "#FF722C40",
														StrokeSize = 1,
													},
													height = "64",
													ignoreSize = "True",
													name = "Label_count_select",
													nTextAlign = "1",
													nTextHAlign = "1",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "770",
													text = "1",
													touchAble = "False",
													touchScaleEnable = "False",
													UILayoutViewModel = 
													{
														
													},
													width = "29",
													ZOrder = "1",
												},
												{
													controlID = "Image_fubenTheaterCountView_1_Image_count_select_Panel_count_1_Image_content_Panel_root_Panel-fubenTheaterCountView_Layer1_fuben_Game",
													UUID = "830a84d1_3a49_4489_9e80_661de32bf8e3",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0.5",
													backGroundScale9Enable = "False",
													classname = "MEImage",
													dstBlendFunc = "771",
													height = "122",
													ignoreSize = "True",
													name = "Image_fubenTheaterCountView_1",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "1",
													texturePath = "ui/common/mini_pop/038.png",
													touchAble = "False",
													UILayoutViewModel = 
													{
														
													},
													width = "20",
													ZOrder = "1",
												},
											},
										},
										{
											controlID = "Image_count_disable_Panel_count_1_Image_content_Panel_root_Panel-fubenTheaterCountView_Layer1_fuben_Game",
											UUID = "f19c6603_087a_47f5_b7bc_0ea1d010a368",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											classname = "MEImage",
											dstBlendFunc = "771",
											height = "102",
											ignoreSize = "True",
											name = "Image_count_disable",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											texturePath = "ui/common/mini_pop/036.png",
											touchAble = "False",
											UILayoutViewModel = 
											{
												
											},
											width = "102",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "Label_count_disable_Image_count_disable_Panel_count_1_Image_content_Panel_root_Panel-fubenTheaterCountView_Layer1_fuben_Game",
													UUID = "27b92079_7572_41a7_8af7_44ca2e961c36",
													anchorPoint = "False",
													anchorPointX = "0.5",
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
													fontSize = "50",
													fontStroke = 
													{
														IsStroke = false,
														StrokeColor = "#FFE6E6E6",
														StrokeSize = 1,
													},
													height = "62",
													ignoreSize = "True",
													name = "Label_count_disable",
													nTextAlign = "1",
													nTextHAlign = "1",
													opacity = "125",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "770",
													text = "1",
													touchAble = "False",
													touchScaleEnable = "False",
													UILayoutViewModel = 
													{
														
													},
													width = "28",
													ZOrder = "1",
												},
											},
										},
									},
								},
								{
									controlID = "Panel_count_2_Image_content_Panel_root_Panel-fubenTheaterCountView_Layer1_fuben_Game",
									UUID = "22f0d640_4a84_4265_a354_4c77e4006fbb",
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
									height = "102",
									ignoreSize = "False",
									name = "Panel_count_2",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "True",
									UILayoutViewModel = 
									{
										PositionX = -96,
										PositionY = -8,
									},
									uipanelviewmodel = 
									{
										Layout="Absolute",
										nType = "0"
									},
									width = "102",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "Image_count_normal_Panel_count_2_Image_content_Panel_root_Panel-fubenTheaterCountView_Layer1_fuben_Game",
											UUID = "a42ece41_41b9_4c0d_bac2_16f4c32adc56",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											classname = "MEImage",
											dstBlendFunc = "771",
											height = "102",
											ignoreSize = "True",
											name = "Image_count_normal",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											texturePath = "ui/common/mini_pop/037.png",
											touchAble = "False",
											UILayoutViewModel = 
											{
												
											},
											width = "102",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "Label_count_normal_Image_count_normal_Panel_count_2_Image_content_Panel_root_Panel-fubenTheaterCountView_Layer1_fuben_Game",
													UUID = "00685284_f69f_4a06_ae2b_d26fbcb59be0",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0.5",
													classname = "MELabel",
													compPath = "luacomponents.common.MEIconLabel",
													dstBlendFunc = "771",
													FontColor = "#FFE3E4F0",
													fontName = "font/MFLiHei_Noncommercial.ttf",
													fontShadow = 
													{
														IsShadow = false,
														ShadowColor = "#FFFFFFFF",
														ShadowAlpha = 255,
														OffsetX = 0,
														OffsetY = 0,
													},
													fontSize = "50",
													fontStroke = 
													{
														IsStroke = true,
														StrokeColor = "#FF3C4664",
														StrokeSize = 1,
													},
													height = "64",
													ignoreSize = "True",
													name = "Label_count_normal",
													nTextAlign = "1",
													nTextHAlign = "1",
													opacity = "76",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "770",
													text = "1",
													touchAble = "False",
													touchScaleEnable = "False",
													UILayoutViewModel = 
													{
														
													},
													width = "29",
													ZOrder = "1",
												},
											},
										},
										{
											controlID = "Image_count_select_Panel_count_2_Image_content_Panel_root_Panel-fubenTheaterCountView_Layer1_fuben_Game",
											UUID = "e6b706cc_c7af_426f_861f_a68e9874511a",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											classname = "MEImage",
											dstBlendFunc = "771",
											height = "102",
											ignoreSize = "True",
											name = "Image_count_select",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											texturePath = "ui/common/mini_pop/039.png",
											touchAble = "False",
											UILayoutViewModel = 
											{
												
											},
											visible = "False",
											width = "102",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "Label_count_select_Image_count_select_Panel_count_2_Image_content_Panel_root_Panel-fubenTheaterCountView_Layer1_fuben_Game",
													UUID = "82eb0bee_fb26_4e28_88d4_c4f67fc9ed02",
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
													fontSize = "50",
													fontStroke = 
													{
														IsStroke = true,
														StrokeColor = "#FF722C40",
														StrokeSize = 1,
													},
													height = "64",
													ignoreSize = "True",
													name = "Label_count_select",
													nTextAlign = "1",
													nTextHAlign = "1",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "770",
													text = "1",
													touchAble = "False",
													touchScaleEnable = "False",
													UILayoutViewModel = 
													{
														
													},
													width = "29",
													ZOrder = "1",
												},
												{
													controlID = "Image_fubenTheaterCountView_1_Image_count_select_Panel_count_2_Image_content_Panel_root_Panel-fubenTheaterCountView_Layer1_fuben_Game",
													UUID = "8b89ce3e_1fb5_4583_a0f6_0dc11de69216",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0.5",
													backGroundScale9Enable = "False",
													classname = "MEImage",
													dstBlendFunc = "771",
													height = "122",
													ignoreSize = "True",
													name = "Image_fubenTheaterCountView_1",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "1",
													texturePath = "ui/common/mini_pop/038.png",
													touchAble = "False",
													UILayoutViewModel = 
													{
														
													},
													width = "20",
													ZOrder = "1",
												},
											},
										},
										{
											controlID = "Image_count_disable_Panel_count_2_Image_content_Panel_root_Panel-fubenTheaterCountView_Layer1_fuben_Game",
											UUID = "26eda537_20d5_4645_b13f_50a24818d767",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											classname = "MEImage",
											dstBlendFunc = "771",
											height = "102",
											ignoreSize = "True",
											name = "Image_count_disable",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											texturePath = "ui/common/mini_pop/036.png",
											touchAble = "False",
											UILayoutViewModel = 
											{
												
											},
											width = "102",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "Label_count_disable_Image_count_disable_Panel_count_2_Image_content_Panel_root_Panel-fubenTheaterCountView_Layer1_fuben_Game",
													UUID = "b70f66ea_3571_4211_879f_95e9d034a49b",
													anchorPoint = "False",
													anchorPointX = "0.5",
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
													fontSize = "50",
													fontStroke = 
													{
														IsStroke = false,
														StrokeColor = "#FFE6E6E6",
														StrokeSize = 1,
													},
													height = "62",
													ignoreSize = "True",
													name = "Label_count_disable",
													nTextAlign = "1",
													nTextHAlign = "1",
													opacity = "125",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "770",
													text = "1",
													touchAble = "False",
													touchScaleEnable = "False",
													UILayoutViewModel = 
													{
														
													},
													width = "28",
													ZOrder = "1",
												},
											},
										},
									},
								},
								{
									controlID = "Panel_count_3_Image_content_Panel_root_Panel-fubenTheaterCountView_Layer1_fuben_Game",
									UUID = "23c9ae14_9864_4ca2_9551_43c4eed6f119",
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
									height = "102",
									ignoreSize = "False",
									name = "Panel_count_3",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "True",
									UILayoutViewModel = 
									{
										PositionY = -8,
									},
									uipanelviewmodel = 
									{
										Layout="Absolute",
										nType = "0"
									},
									width = "102",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "Image_count_normal_Panel_count_3_Image_content_Panel_root_Panel-fubenTheaterCountView_Layer1_fuben_Game",
											UUID = "f452e319_ffcf_4228_ae92_d11d1f9ec4c6",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											classname = "MEImage",
											dstBlendFunc = "771",
											height = "102",
											ignoreSize = "True",
											name = "Image_count_normal",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											texturePath = "ui/common/mini_pop/037.png",
											touchAble = "False",
											UILayoutViewModel = 
											{
												
											},
											width = "102",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "Label_count_normal_Image_count_normal_Panel_count_3_Image_content_Panel_root_Panel-fubenTheaterCountView_Layer1_fuben_Game",
													UUID = "b76fca82_f89f_4a8f_997c_66970bc93de4",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0.5",
													classname = "MELabel",
													compPath = "luacomponents.common.MEIconLabel",
													dstBlendFunc = "771",
													FontColor = "#FFE3E4F0",
													fontName = "font/MFLiHei_Noncommercial.ttf",
													fontShadow = 
													{
														IsShadow = false,
														ShadowColor = "#FFFFFFFF",
														ShadowAlpha = 255,
														OffsetX = 0,
														OffsetY = 0,
													},
													fontSize = "50",
													fontStroke = 
													{
														IsStroke = true,
														StrokeColor = "#FF3C4664",
														StrokeSize = 1,
													},
													height = "64",
													ignoreSize = "True",
													name = "Label_count_normal",
													nTextAlign = "1",
													nTextHAlign = "1",
													opacity = "76",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "770",
													text = "1",
													touchAble = "False",
													touchScaleEnable = "False",
													UILayoutViewModel = 
													{
														
													},
													width = "29",
													ZOrder = "1",
												},
											},
										},
										{
											controlID = "Image_count_select_Panel_count_3_Image_content_Panel_root_Panel-fubenTheaterCountView_Layer1_fuben_Game",
											UUID = "80b9fff5_b92d_4f91_b15f_76ae73d5fa42",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											classname = "MEImage",
											dstBlendFunc = "771",
											height = "102",
											ignoreSize = "True",
											name = "Image_count_select",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											texturePath = "ui/common/mini_pop/039.png",
											touchAble = "False",
											UILayoutViewModel = 
											{
												
											},
											visible = "False",
											width = "102",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "Label_count_select_Image_count_select_Panel_count_3_Image_content_Panel_root_Panel-fubenTheaterCountView_Layer1_fuben_Game",
													UUID = "9713b687_faf4_4ace_880e_8365c83dd41d",
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
													fontSize = "50",
													fontStroke = 
													{
														IsStroke = true,
														StrokeColor = "#FF722C40",
														StrokeSize = 1,
													},
													height = "64",
													ignoreSize = "True",
													name = "Label_count_select",
													nTextAlign = "1",
													nTextHAlign = "1",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "770",
													text = "1",
													touchAble = "False",
													touchScaleEnable = "False",
													UILayoutViewModel = 
													{
														
													},
													width = "29",
													ZOrder = "1",
												},
												{
													controlID = "Image_fubenTheaterCountView_1_Image_count_select_Panel_count_3_Image_content_Panel_root_Panel-fubenTheaterCountView_Layer1_fuben_Game",
													UUID = "db464024_4d79_44e1_9d77_b77b722c1008",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0.5",
													backGroundScale9Enable = "False",
													classname = "MEImage",
													dstBlendFunc = "771",
													height = "122",
													ignoreSize = "True",
													name = "Image_fubenTheaterCountView_1",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "1",
													texturePath = "ui/common/mini_pop/038.png",
													touchAble = "False",
													UILayoutViewModel = 
													{
														
													},
													width = "20",
													ZOrder = "1",
												},
											},
										},
										{
											controlID = "Image_count_disable_Panel_count_3_Image_content_Panel_root_Panel-fubenTheaterCountView_Layer1_fuben_Game",
											UUID = "bfa8be2a_fdf8_41e8_ab4a_fbc09d11f48f",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											classname = "MEImage",
											dstBlendFunc = "771",
											height = "102",
											ignoreSize = "True",
											name = "Image_count_disable",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											texturePath = "ui/common/mini_pop/036.png",
											touchAble = "False",
											UILayoutViewModel = 
											{
												
											},
											width = "102",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "Label_count_disable_Image_count_disable_Panel_count_3_Image_content_Panel_root_Panel-fubenTheaterCountView_Layer1_fuben_Game",
													UUID = "76b9bbb2_572e_462d_9654_bd6062d2b868",
													anchorPoint = "False",
													anchorPointX = "0.5",
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
													fontSize = "50",
													fontStroke = 
													{
														IsStroke = false,
														StrokeColor = "#FFE6E6E6",
														StrokeSize = 1,
													},
													height = "62",
													ignoreSize = "True",
													name = "Label_count_disable",
													nTextAlign = "1",
													nTextHAlign = "1",
													opacity = "125",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "770",
													text = "1",
													touchAble = "False",
													touchScaleEnable = "False",
													UILayoutViewModel = 
													{
														
													},
													width = "28",
													ZOrder = "1",
												},
											},
										},
									},
								},
								{
									controlID = "Panel_count_4_Image_content_Panel_root_Panel-fubenTheaterCountView_Layer1_fuben_Game",
									UUID = "cf09a226_1cba_46db_bc2e_377acbe81a38",
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
									height = "102",
									ignoreSize = "False",
									name = "Panel_count_4",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "True",
									UILayoutViewModel = 
									{
										PositionX = 102,
										PositionY = -8,
									},
									uipanelviewmodel = 
									{
										Layout="Absolute",
										nType = "0"
									},
									width = "102",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "Image_count_normal_Panel_count_4_Image_content_Panel_root_Panel-fubenTheaterCountView_Layer1_fuben_Game",
											UUID = "30fa3a6b_3355_422b_96c0_4d86f22c364d",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											classname = "MEImage",
											dstBlendFunc = "771",
											height = "102",
											ignoreSize = "True",
											name = "Image_count_normal",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											texturePath = "ui/common/mini_pop/037.png",
											touchAble = "False",
											UILayoutViewModel = 
											{
												
											},
											width = "102",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "Label_count_normal_Image_count_normal_Panel_count_4_Image_content_Panel_root_Panel-fubenTheaterCountView_Layer1_fuben_Game",
													UUID = "d32d4ce4_72a4_4833_8170_f33b1e632c9b",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0.5",
													classname = "MELabel",
													compPath = "luacomponents.common.MEIconLabel",
													dstBlendFunc = "771",
													FontColor = "#FFE3E4F0",
													fontName = "font/MFLiHei_Noncommercial.ttf",
													fontShadow = 
													{
														IsShadow = false,
														ShadowColor = "#FFFFFFFF",
														ShadowAlpha = 255,
														OffsetX = 0,
														OffsetY = 0,
													},
													fontSize = "50",
													fontStroke = 
													{
														IsStroke = true,
														StrokeColor = "#FF3C4664",
														StrokeSize = 1,
													},
													height = "64",
													ignoreSize = "True",
													name = "Label_count_normal",
													nTextAlign = "1",
													nTextHAlign = "1",
													opacity = "76",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "770",
													text = "1",
													touchAble = "False",
													touchScaleEnable = "False",
													UILayoutViewModel = 
													{
														
													},
													width = "29",
													ZOrder = "1",
												},
											},
										},
										{
											controlID = "Image_count_select_Panel_count_4_Image_content_Panel_root_Panel-fubenTheaterCountView_Layer1_fuben_Game",
											UUID = "8d3fdb3b_d360_495c_990f_a3ed68ffc258",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											classname = "MEImage",
											dstBlendFunc = "771",
											height = "102",
											ignoreSize = "True",
											name = "Image_count_select",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											texturePath = "ui/common/mini_pop/039.png",
											touchAble = "False",
											UILayoutViewModel = 
											{
												
											},
											visible = "False",
											width = "102",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "Label_count_select_Image_count_select_Panel_count_4_Image_content_Panel_root_Panel-fubenTheaterCountView_Layer1_fuben_Game",
													UUID = "49614e38_b429_469d_8324_51dd1a3a1c2b",
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
													fontSize = "50",
													fontStroke = 
													{
														IsStroke = true,
														StrokeColor = "#FF722C40",
														StrokeSize = 1,
													},
													height = "64",
													ignoreSize = "True",
													name = "Label_count_select",
													nTextAlign = "1",
													nTextHAlign = "1",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "770",
													text = "1",
													touchAble = "False",
													touchScaleEnable = "False",
													UILayoutViewModel = 
													{
														
													},
													width = "29",
													ZOrder = "1",
												},
												{
													controlID = "Image_fubenTheaterCountView_1_Image_count_select_Panel_count_4_Image_content_Panel_root_Panel-fubenTheaterCountView_Layer1_fuben_Game",
													UUID = "23e697d0_7b38_4f95_a3e9_c2ba9217466d",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0.5",
													backGroundScale9Enable = "False",
													classname = "MEImage",
													dstBlendFunc = "771",
													height = "122",
													ignoreSize = "True",
													name = "Image_fubenTheaterCountView_1",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "1",
													texturePath = "ui/common/mini_pop/038.png",
													touchAble = "False",
													UILayoutViewModel = 
													{
														
													},
													width = "20",
													ZOrder = "1",
												},
											},
										},
										{
											controlID = "Image_count_disable_Panel_count_4_Image_content_Panel_root_Panel-fubenTheaterCountView_Layer1_fuben_Game",
											UUID = "f969f578_a509_4707_a3c7_24c157956f93",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											classname = "MEImage",
											dstBlendFunc = "771",
											height = "102",
											ignoreSize = "True",
											name = "Image_count_disable",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											texturePath = "ui/common/mini_pop/036.png",
											touchAble = "False",
											UILayoutViewModel = 
											{
												
											},
											width = "102",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "Label_count_disable_Image_count_disable_Panel_count_4_Image_content_Panel_root_Panel-fubenTheaterCountView_Layer1_fuben_Game",
													UUID = "ba12299e_0560_43c1_8adb_f2720f44d917",
													anchorPoint = "False",
													anchorPointX = "0.5",
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
													fontSize = "50",
													fontStroke = 
													{
														IsStroke = false,
														StrokeColor = "#FFE6E6E6",
														StrokeSize = 1,
													},
													height = "62",
													ignoreSize = "True",
													name = "Label_count_disable",
													nTextAlign = "1",
													nTextHAlign = "1",
													opacity = "125",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "770",
													text = "1",
													touchAble = "False",
													touchScaleEnable = "False",
													UILayoutViewModel = 
													{
														
													},
													width = "28",
													ZOrder = "1",
												},
											},
										},
									},
								},
								{
									controlID = "Panel_count_5_Image_content_Panel_root_Panel-fubenTheaterCountView_Layer1_fuben_Game",
									UUID = "afd58468_e833_4d4d_aa33_95115c34a577",
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
									height = "102",
									ignoreSize = "False",
									name = "Panel_count_5",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "True",
									UILayoutViewModel = 
									{
										PositionX = 200,
										PositionY = -8,
									},
									uipanelviewmodel = 
									{
										Layout="Absolute",
										nType = "0"
									},
									width = "102",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "Image_count_normal_Panel_count_5_Image_content_Panel_root_Panel-fubenTheaterCountView_Layer1_fuben_Game",
											UUID = "23ac2811_5e22_4a09_b312_b657679e7c80",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											classname = "MEImage",
											dstBlendFunc = "771",
											height = "102",
											ignoreSize = "True",
											name = "Image_count_normal",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											texturePath = "ui/common/mini_pop/037.png",
											touchAble = "False",
											UILayoutViewModel = 
											{
												
											},
											width = "102",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "Label_count_normal_Image_count_normal_Panel_count_5_Image_content_Panel_root_Panel-fubenTheaterCountView_Layer1_fuben_Game",
													UUID = "e077de6d_2b59_4cca_9cd3_c17e8dbaff89",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0.5",
													classname = "MELabel",
													compPath = "luacomponents.common.MEIconLabel",
													dstBlendFunc = "771",
													FontColor = "#FFE3E4F0",
													fontName = "font/MFLiHei_Noncommercial.ttf",
													fontShadow = 
													{
														IsShadow = false,
														ShadowColor = "#FFFFFFFF",
														ShadowAlpha = 255,
														OffsetX = 0,
														OffsetY = 0,
													},
													fontSize = "50",
													fontStroke = 
													{
														IsStroke = true,
														StrokeColor = "#FF3C4664",
														StrokeSize = 1,
													},
													height = "64",
													ignoreSize = "True",
													name = "Label_count_normal",
													nTextAlign = "1",
													nTextHAlign = "1",
													opacity = "76",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "770",
													text = "1",
													touchAble = "False",
													touchScaleEnable = "False",
													UILayoutViewModel = 
													{
														
													},
													width = "29",
													ZOrder = "1",
												},
											},
										},
										{
											controlID = "Image_count_select_Panel_count_5_Image_content_Panel_root_Panel-fubenTheaterCountView_Layer1_fuben_Game",
											UUID = "21b151f8_5a97_4191_91c9_278fda5a2102",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											classname = "MEImage",
											dstBlendFunc = "771",
											height = "102",
											ignoreSize = "True",
											name = "Image_count_select",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											texturePath = "ui/common/mini_pop/039.png",
											touchAble = "False",
											UILayoutViewModel = 
											{
												
											},
											visible = "False",
											width = "102",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "Label_count_select_Image_count_select_Panel_count_5_Image_content_Panel_root_Panel-fubenTheaterCountView_Layer1_fuben_Game",
													UUID = "94285840_bcf4_40a5_89e7_c6da67cc9aff",
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
													fontSize = "50",
													fontStroke = 
													{
														IsStroke = true,
														StrokeColor = "#FF722C40",
														StrokeSize = 1,
													},
													height = "64",
													ignoreSize = "True",
													name = "Label_count_select",
													nTextAlign = "1",
													nTextHAlign = "1",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "770",
													text = "1",
													touchAble = "False",
													touchScaleEnable = "False",
													UILayoutViewModel = 
													{
														
													},
													width = "29",
													ZOrder = "1",
												},
												{
													controlID = "Image_fubenTheaterCountView_1_Image_count_select_Panel_count_5_Image_content_Panel_root_Panel-fubenTheaterCountView_Layer1_fuben_Game",
													UUID = "40d413ba_1437_48ca_b131_35fc93741e74",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0.5",
													backGroundScale9Enable = "False",
													classname = "MEImage",
													dstBlendFunc = "771",
													height = "122",
													ignoreSize = "True",
													name = "Image_fubenTheaterCountView_1",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "1",
													texturePath = "ui/common/mini_pop/038.png",
													touchAble = "False",
													UILayoutViewModel = 
													{
														
													},
													width = "20",
													ZOrder = "1",
												},
											},
										},
										{
											controlID = "Image_count_disable_Panel_count_5_Image_content_Panel_root_Panel-fubenTheaterCountView_Layer1_fuben_Game",
											UUID = "f2838474_7c67_4cf4_99ed_0c0edec2eeb0",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											classname = "MEImage",
											dstBlendFunc = "771",
											height = "102",
											ignoreSize = "True",
											name = "Image_count_disable",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											texturePath = "ui/common/mini_pop/036.png",
											touchAble = "False",
											UILayoutViewModel = 
											{
												
											},
											width = "102",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "Label_count_disable_Image_count_disable_Panel_count_5_Image_content_Panel_root_Panel-fubenTheaterCountView_Layer1_fuben_Game",
													UUID = "0230eea8_56bc_4ced_a06c_ff31d57d4e2f",
													anchorPoint = "False",
													anchorPointX = "0.5",
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
													fontSize = "50",
													fontStroke = 
													{
														IsStroke = false,
														StrokeColor = "#FFE6E6E6",
														StrokeSize = 1,
													},
													height = "62",
													ignoreSize = "True",
													name = "Label_count_disable",
													nTextAlign = "1",
													nTextHAlign = "1",
													opacity = "125",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "770",
													text = "1",
													touchAble = "False",
													touchScaleEnable = "False",
													UILayoutViewModel = 
													{
														
													},
													width = "28",
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
					controlID = "Panel_prefab_Panel-fubenTheaterCountView_Layer1_fuben_Game",
					UUID = "63622924_11f8_430a_bca7_c7952e02f470",
					anchorPoint = "False",
					anchorPointX = "0",
					anchorPointY = "0",
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
						PositionY = -693,
						TopPosition = 693,
						relativeToName = "Panel",
						nType = 3,
						nGravity = 6,
						nAlign = 2
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
			"ui/common/mini_pop/9.png",
			"ui/common/mini_pop/7.png",
			"ui/common/pop_ui/pop_btn_02.png",
			"ui/common/button_middle_n.png",
			"ui/common/mini_pop/035.png",
			"ui/common/mini_pop/037.png",
			"ui/common/mini_pop/039.png",
			"ui/common/mini_pop/038.png",
			"ui/common/mini_pop/036.png",
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

