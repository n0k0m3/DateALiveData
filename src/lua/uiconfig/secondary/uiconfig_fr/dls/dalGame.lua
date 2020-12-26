local t = 
{
	version = 1,
	components = 
	{
		
		{
			controlID = "Panel-dalGame_Layer1_dls_Game",
			UUID = "aa438035_b1a3_4ab6_9278_ec37db4c05ea",
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
					controlID = "Panel_root_Panel-dalGame_Layer1_dls_Game",
					UUID = "2eba35b9_663d_42d6_b5a7_4736056af78a",
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
					name = "Panel_root",
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
							controlID = "Image_mini_Panel_root_Panel-dalGame_Layer1_dls_Game",
							UUID = "fb21be83_ba35_44e1_9897_c36f716d1220",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							backGroundScale9Enable = "True;capInsetsX:0;capInsetsY:0;capInsetsWidth:0;capInsetsHeight:0",
							classname = "MEImage",
							dstBlendFunc = "771",
							height = "500",
							ignoreSize = "False",
							name = "Image_mini",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							texturePath = "ui/common/pop_ui/pop_bg_01.png",
							touchAble = "False",
							UILayoutViewModel = 
							{
								PositionX = 568,
								PositionY = 320,
								IsPercent = true,
								PercentX = 50,
								PercentY = 50,
							},
							width = "380",
							ZOrder = "1",
							components = 
							{
								
								{
									controlID = "Image_di2_Image_mini_Panel_root_Panel-dalGame_Layer1_dls_Game",
									UUID = "9a2b8c11_6809_48ba_802c_595467cfc350",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "86",
									ignoreSize = "True",
									name = "Image_di2",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/dalmap/dalmap/001.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = 97,
										PositionY = -198,
									},
									width = "162",
									ZOrder = "1",
								},
								{
									controlID = "Button_close_Image_mini_Panel_root_Panel-dalGame_Layer1_dls_Game",
									UUID = "76fcbeb8_0b28_47c1_93d2_815d8c3d3482",
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
										PositionX = 161,
										PositionY = 220,
									},
									UItype = "Button",
									width = "60",
									ZOrder = "1",
								},
								{
									controlID = "Label_title_Image_mini_Panel_root_Panel-dalGame_Layer1_dls_Game",
									UUID = "476c1a21_e4a5_49c6_a57d_60204080a2fc",
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
									name = "Label_title",
									nTextAlign = "1",
									nTextHAlign = "1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "Source divine",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionX = -177,
										PositionY = 220,
									},
									width = "115",
									ZOrder = "1",
								},
								{
									controlID = "Label_desc_Image_mini_Panel_root_Panel-dalGame_Layer1_dls_Game",
									UUID = "f337d9ce_8fdc_498d_85dd_dc3e43e173ca",
									anchorPoint = "False",
									anchorPointX = "0",
									anchorPointY = "1",
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
									height = "150",
									ignoreSize = "False",
									name = "Label_desc",
									nTextAlign = "0",
									nTextHAlign = "0",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "Vous pouvez obtenir le buff suivant Vous pouvez obtenir le buff suivant",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionX = -149,
										PositionY = 184,
									},
									width = "300",
									ZOrder = "1",
								},
								{
									controlID = "Image_split_Image_mini_Panel_root_Panel-dalGame_Layer1_dls_Game",
									UUID = "ef583b84_09bf_46c3_9d7a_ecac543d0f99",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "14",
									ignoreSize = "True",
									name = "Image_split",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/kabalatree/game/055.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										
									},
									width = "344",
									ZOrder = "1",
								},
								{
									controlID = "Button_choose1_Image_mini_Panel_root_Panel-dalGame_Layer1_dls_Game",
									UUID = "25c2a597_47f2_4a0b_a7b9_fc309b5ececf",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEButton",
									ClickHighLightEnabled = "True",
									dstBlendFunc = "771",
									flipX = "False",
									flipY = "False",
									height = "68",
									ignoreSize = "True",
									name = "Button_choose1",
									normal = "ui/kabalatree/game/058.png",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "True",
									UILayoutViewModel = 
									{
										PositionY = -68,
									},
									UItype = "Button",
									width = "324",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "Label_chooseName_Button_choose1_Image_mini_Panel_root_Panel-dalGame_Layer1_dls_Game",
											UUID = "f1e28478_410e_428f_8813_1b5467743223",
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
											fontSize = "22",
											fontStroke = 
											{
												IsStroke = false,
												StrokeColor = "#FFE6E6E6",
												StrokeSize = 1,
											},
											height = "25",
											ignoreSize = "True",
											name = "Label_chooseName",
											nTextAlign = "1",
											nTextHAlign = "1",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "770",
											text = "Investir",
											touchAble = "False",
											touchScaleEnable = "False",
											UILayoutViewModel = 
											{
												
											},
											width = "47",
											ZOrder = "1",
										},
										{
											controlID = "Panel_money_Button_choose1_Image_mini_Panel_root_Panel-dalGame_Layer1_dls_Game",
											UUID = "3c1d01a0_7a70_4f8a_b953_cf5666fa4839",
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
											height = "68",
											ignoreSize = "False",
											name = "Panel_money",
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
											width = "324",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "Label_chooseName1_Panel_money_Button_choose1_Image_mini_Panel_root_Panel-dalGame_Layer1_dls_Game",
													UUID = "807fc977_e5ff_42fc_bc9d_4bea64bbe9a6",
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
													fontSize = "22",
													fontStroke = 
													{
														IsStroke = false,
														StrokeColor = "#FFE6E6E6",
														StrokeSize = 1,
													},
													height = "25",
													ignoreSize = "True",
													name = "Label_chooseName1",
													nTextAlign = "1",
													nTextHAlign = "1",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "770",
													text = "Investir",
													touchAble = "False",
													touchScaleEnable = "False",
													UILayoutViewModel = 
													{
														PositionX = -69,
														PositionY = 1,
													},
													width = "47",
													ZOrder = "1",
												},
												{
													controlID = "Image_text_Panel_money_Button_choose1_Image_mini_Panel_root_Panel-dalGame_Layer1_dls_Game",
													UUID = "d1e75d99_90a0_4015_98c8_77997ee72b24",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0.5",
													backGroundScale9Enable = "False",
													classname = "MEImage",
													dstBlendFunc = "771",
													height = "26",
													ignoreSize = "True",
													name = "Image_text",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "1",
													texturePath = "ui/dalmap/dalmap/018.png",
													touchAble = "False",
													UILayoutViewModel = 
													{
														PositionX = 71,
														PositionY = 1,
													},
													width = "108",
													ZOrder = "1",
													components = 
													{
														
														{
															controlID = "icon_Image_text_Panel_money_Button_choose1_Image_mini_Panel_root_Panel-dalGame_Layer1_dls_Game",
															UUID = "a17f3437_a545_45fa_beca_eb2d01b99d20",
															anchorPoint = "False",
															anchorPointX = "0.5",
															anchorPointY = "0.5",
															backGroundScale9Enable = "False",
															classname = "MEImage",
															dstBlendFunc = "771",
															height = "100",
															ignoreSize = "True",
															name = "icon",
															scaleX = "0.4",
															scaleY = "0.4",
															sizepercentx = "0",
															sizepercenty = "0",
															sizeType = "0",
															srcBlendFunc = "1",
															texturePath = "icon/system/003.png",
															touchAble = "False",
															UILayoutViewModel = 
															{
																PositionX = -42,
															},
															width = "100",
															ZOrder = "1",
														},
														{
															controlID = "num_Image_text_Panel_money_Button_choose1_Image_mini_Panel_root_Panel-dalGame_Layer1_dls_Game",
															UUID = "16dd5615_0fc4_4058_a4c2_aa5eccfb1c3a",
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
															name = "num",
															nTextAlign = "1",
															nTextHAlign = "1",
															sizepercentx = "0",
															sizepercenty = "0",
															sizeType = "0",
															srcBlendFunc = "770",
															text = "-5000.0",
															touchAble = "False",
															touchScaleEnable = "False",
															UILayoutViewModel = 
															{
																PositionX = 50,
															},
															width = "64",
															ZOrder = "1",
														},
													},
												},
											},
										},
									},
								},
								{
									controlID = "Button_choose2_Image_mini_Panel_root_Panel-dalGame_Layer1_dls_Game",
									UUID = "d3b41aa6_72d5_4444_b354_5e50115863a4",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEButton",
									ClickHighLightEnabled = "True",
									dstBlendFunc = "771",
									flipX = "False",
									flipY = "False",
									height = "68",
									ignoreSize = "True",
									name = "Button_choose2",
									normal = "ui/kabalatree/game/058.png",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "True",
									UILayoutViewModel = 
									{
										PositionX = -1,
										PositionY = -156,
									},
									UItype = "Button",
									width = "324",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "Panel_money_Button_choose2_Image_mini_Panel_root_Panel-dalGame_Layer1_dls_Game",
											UUID = "e970462c_0dfe_42e4_a578_595c75bdaf95",
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
											height = "68",
											ignoreSize = "False",
											name = "Panel_money",
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
											width = "324",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "Label_chooseName1_Panel_money_Button_choose2_Image_mini_Panel_root_Panel-dalGame_Layer1_dls_Game",
													UUID = "880f7380_e5f0_4797_a0e3_46c07105c125",
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
													fontSize = "22",
													fontStroke = 
													{
														IsStroke = false,
														StrokeColor = "#FFE6E6E6",
														StrokeSize = 1,
													},
													height = "25",
													ignoreSize = "True",
													name = "Label_chooseName1",
													nTextAlign = "1",
													nTextHAlign = "1",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "770",
													text = "Investir",
													touchAble = "False",
													touchScaleEnable = "False",
													UILayoutViewModel = 
													{
														PositionX = -69,
														PositionY = 1,
													},
													width = "47",
													ZOrder = "1",
												},
												{
													controlID = "Image_text_Panel_money_Button_choose2_Image_mini_Panel_root_Panel-dalGame_Layer1_dls_Game",
													UUID = "b87451d7_ac2e_43db_a2b6_2120613ecbce",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0.5",
													backGroundScale9Enable = "False",
													classname = "MEImage",
													dstBlendFunc = "771",
													height = "26",
													ignoreSize = "True",
													name = "Image_text",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "1",
													texturePath = "ui/dalmap/dalmap/018.png",
													touchAble = "False",
													UILayoutViewModel = 
													{
														PositionX = 71,
														PositionY = 1,
													},
													width = "108",
													ZOrder = "1",
													components = 
													{
														
														{
															controlID = "icon_Image_text_Panel_money_Button_choose2_Image_mini_Panel_root_Panel-dalGame_Layer1_dls_Game",
															UUID = "2f250d27_f490_4fc3_b725_744e9f846aaa",
															anchorPoint = "False",
															anchorPointX = "0.5",
															anchorPointY = "0.5",
															backGroundScale9Enable = "False",
															classname = "MEImage",
															dstBlendFunc = "771",
															height = "100",
															ignoreSize = "True",
															name = "icon",
															scaleX = "0.4",
															scaleY = "0.4",
															sizepercentx = "0",
															sizepercenty = "0",
															sizeType = "0",
															srcBlendFunc = "1",
															texturePath = "icon/system/003.png",
															touchAble = "False",
															UILayoutViewModel = 
															{
																PositionX = -42,
															},
															width = "100",
															ZOrder = "1",
														},
														{
															controlID = "num_Image_text_Panel_money_Button_choose2_Image_mini_Panel_root_Panel-dalGame_Layer1_dls_Game",
															UUID = "000f7ecb_51ad_42c1_853d_57152da6b612",
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
															name = "num",
															nTextAlign = "1",
															nTextHAlign = "1",
															sizepercentx = "0",
															sizepercenty = "0",
															sizeType = "0",
															srcBlendFunc = "770",
															text = "-5000.0",
															touchAble = "False",
															touchScaleEnable = "False",
															UILayoutViewModel = 
															{
																PositionX = 51,
															},
															width = "64",
															ZOrder = "1",
														},
													},
												},
											},
										},
										{
											controlID = "Label_chooseName_Button_choose2_Image_mini_Panel_root_Panel-dalGame_Layer1_dls_Game",
											UUID = "1fefe02c_554a_4284_b10f_897e64498c43",
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
											fontSize = "22",
											fontStroke = 
											{
												IsStroke = false,
												StrokeColor = "#FFE6E6E6",
												StrokeSize = 1,
											},
											height = "25",
											ignoreSize = "True",
											name = "Label_chooseName",
											nTextAlign = "1",
											nTextHAlign = "1",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "770",
											text = "Investir",
											touchAble = "False",
											touchScaleEnable = "False",
											UILayoutViewModel = 
											{
												
											},
											width = "47",
											ZOrder = "1",
										},
									},
								},
							},
						},
					},
				},
				{
					controlID = "Panel_prefab_Panel-dalGame_Layer1_dls_Game",
					UUID = "1de693cf_367c_45fd_9044_107dd4399a86",
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
					sizepercentx = "100",
					sizepercenty = "100",
					sizeType = "1",
					srcBlendFunc = "1",
					touchAble = "False",
					UILayoutViewModel = 
					{
						PositionX = 35,
						PositionY = -836,
						LeftPositon = 35,
						TopPosition = 836,
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
			"ui/common/pop_ui/pop_bg_01.png",
			"ui/dalmap/dalmap/001.png",
			"ui/common/pop_ui/pop_btn_02.png",
			"ui/kabalatree/game/055.png",
			"ui/kabalatree/game/058.png",
			"ui/dalmap/dalmap/018.png",
			"icon/system/003.png",
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

