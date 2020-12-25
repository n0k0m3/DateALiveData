local t = 
{
	version = 1,
	components = 
	{
		
		{
			controlID = "Panel-skillHelpView_ui_battle_Game",
			UUID = "7e961120_1233_43bf_9feb_98d0b0110a33",
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
				PositionX = -2,
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
					controlID = "Panel_root_Panel-skillHelpView_ui_battle_Game",
					UUID = "c4b077bf_26ef_49bd_97a4_2327ae127201",
					anchorPoint = "False",
					anchorPointX = "0.5",
					anchorPointY = "0.5",
					backGroundScale9Enable = "False",
					bgColorOpacity = "200",
					bIsOpenClipping = "False",
					classname = "MEPanel",
					colorType = "0;SingleColor:#FF000000;GraduallyChangingColorStart:#FFFFFFFF;GraduallyChangingColorEnd:#FFFFFFFF;vectorX:0;vectorY:0",
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
					width = "1386",
					ZOrder = "1",
					components = 
					{
						
						{
							controlID = "Panel_page_Panel_root_Panel-skillHelpView_ui_battle_Game",
							UUID = "a61da43d_7e80_4ef0_bf10_9922bfca7aa3",
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
							height = "420",
							ignoreSize = "False",
							name = "Panel_page",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "770",
							touchAble = "True",
							UILayoutViewModel = 
							{
								
							},
							uipanelviewmodel = 
							{
								Layout="Absolute",
								nType = "0"
							},
							width = "730",
							ZOrder = "1",
							components = 
							{
								
								{
									controlID = "Image_bg_Panel_page_Panel_root_Panel-skillHelpView_ui_battle_Game",
									UUID = "51dd9dc2_f83c_47b6_8a4d_137d2cf88665",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "True;capInsetsX:0;capInsetsY:0;capInsetsWidth:0;capInsetsHeight:0",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "430",
									ignoreSize = "False",
									name = "Image_bg",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/common/pop_ui/pop_bg_01.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										
									},
									width = "740",
									ZOrder = "1",
								},
								{
									controlID = "Image_bg2_Panel_page_Panel_root_Panel-skillHelpView_ui_battle_Game",
									UUID = "7e65b648_5ef0_40c6_86d4_18b41569bade",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "True;capInsetsX:0;capInsetsY:0;capInsetsWidth:0;capInsetsHeight:0",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "360",
									ignoreSize = "False",
									name = "Image_bg2",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/common/pop_ui/pop_bg_02.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionY = -17,
									},
									width = "720",
									ZOrder = "1",
								},
								{
									controlID = "Label_pad_title_Panel_page_Panel_root_Panel-skillHelpView_ui_battle_Game",
									UUID = "3a3bb167_d3da_480c_b74c_2c9edba01019",
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
									name = "Label_pad_title",
									nTextAlign = "1",
									nTextHAlign = "1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "รายการย้าย",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionX = -355,
										PositionY = 184,
									},
									width = "88",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "Panel_title_sign_Label_pad_title_Panel_page_Panel_root_Panel-skillHelpView_ui_battle_Game",
											UUID = "505b5ded_b641_4fb7_a00e_10ca573666b5",
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
												PositionX = 117,
												IsPercent = true,
												PercentX = 100,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "0",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "Image_line_Panel_title_sign_Label_pad_title_Panel_page_Panel_root_Panel-skillHelpView_ui_battle_Game",
													UUID = "4bcca85e_2b62_4bcb_b9ae_9d34e9bd8d6d",
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
													width = "2",
													ZOrder = "1",
												},
												{
													controlID = "Image_red_Panel_title_sign_Label_pad_title_Panel_page_Panel_root_Panel-skillHelpView_ui_battle_Game",
													UUID = "a09dad7b_4c73_4eca_b68b_dfac9493c175",
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
													width = "14",
													ZOrder = "1",
												},
												{
													controlID = "Label_english_Panel_title_sign_Label_pad_title_Panel_page_Panel_root_Panel-skillHelpView_ui_battle_Game",
													UUID = "b033e925_0328_4b87_a5f6_52b3b0ade0c7",
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
													text = "สร้างข้อมูล",
													touchAble = "False",
													touchScaleEnable = "False",
													UILayoutViewModel = 
													{
														PositionY = -7,
													},
													width = "115",
													ZOrder = "1",
												},
											},
										},
									},
								},
								{
									controlID = "ScrollView_list_Panel_page_Panel_root_Panel-skillHelpView_ui_battle_Game",
									UUID = "e42f6e15_2469_4340_81da_df7972aab554",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "1",
									backGroundScale9Enable = "False",
									bgColorOpacity = "50",
									bIsOpenClipping = "True",
									bounceEnable = "True",
									classname = "MEScrollView",
									colorType = "0;SingleColor:#FFE6E6E6;GraduallyChangingColorStart:#FFFFFFFF;GraduallyChangingColorEnd:#FFFFFFFF;vectorX:0;vectorY:0",
									direction = "1",
									dstBlendFunc = "771",
									height = "347",
									ignoreSize = "False",
									innerHeight = "355",
									innerWidth = "720",
									name = "ScrollView_list",
									showScrollbar = "False",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "True",
									UILayoutViewModel = 
									{
										PositionY = 155,
									},
									uipanelviewmodel = 
									{
										Layout="Absolute",
										nType = "0"
									},
									width = "720",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "Panel_cell_ScrollView_list_Panel_page_Panel_root_Panel-skillHelpView_ui_battle_Game",
											UUID = "ee178508_ecef_4745_be5f_123bfc187140",
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
											name = "Panel_cell",
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
											visible = "False",
											width = "720",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "Image_bg_Panel_cell_ScrollView_list_Panel_page_Panel_root_Panel-skillHelpView_ui_battle_Game",
													UUID = "b69e3e0e_0118_4f12_8100_9b70546ac545",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0.5",
													backGroundScale9Enable = "False",
													classname = "MEImage",
													dstBlendFunc = "771",
													height = "64",
													ignoreSize = "True",
													name = "Image_bg",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "1",
													texturePath = "ui/battle/skillhelp/skill_group_bg.png",
													touchAble = "False",
													UILayoutViewModel = 
													{
														PositionX = 360,
														PositionY = 35,
														IsPercent = true,
														PercentX = 50,
														PercentY = 50,
													},
													width = "688",
													ZOrder = "1",
												},
												{
													controlID = "ScrollView_skillList_Panel_cell_ScrollView_list_Panel_page_Panel_root_Panel-skillHelpView_ui_battle_Game",
													UUID = "e21823d5_2fbe_42a7_bdd0_ac585883e9fa",
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
													height = "50",
													ignoreSize = "False",
													innerHeight = "50",
													innerWidth = "295",
													name = "ScrollView_skillList",
													showScrollbar = "False",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "1",
													touchAble = "False",
													UILayoutViewModel = 
													{
														PositionX = 190,
														PositionY = 43,
													},
													uipanelviewmodel = 
													{
														Layout="Absolute",
														nType = "0"
													},
													width = "295",
													ZOrder = "1",
													components = 
													{
														
														{
															controlID = "Panel_skill_ScrollView_skillList_Panel_cell_ScrollView_list_Panel_page_Panel_root_Panel-skillHelpView_ui_battle_Game",
															UUID = "39c038b0_4e19_4767_9493_cee1d2456251",
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
															height = "50",
															ignoreSize = "False",
															name = "Panel_skill",
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
															visible = "False",
															width = "50",
															ZOrder = "1",
															components = 
															{
																
																{
																	controlID = "Image_skill_Panel_skill_ScrollView_skillList_Panel_cell_ScrollView_list_Panel_page_Panel_root_Panel-skillHelpView_ui_battle_Game",
																	UUID = "97d23d28_cfcd_4b89_9e97_c3ad96a625d9",
																	anchorPoint = "False",
																	anchorPointX = "0.5",
																	anchorPointY = "0.5",
																	backGroundScale9Enable = "False",
																	classname = "MEImage",
																	dstBlendFunc = "771",
																	height = "44",
																	ignoreSize = "True",
																	name = "Image_skill",
																	sizepercentx = "0",
																	sizepercenty = "0",
																	sizeType = "0",
																	srcBlendFunc = "1",
																	texturePath = "ui/battle/skillhelp/skill_logo_A.png",
																	touchAble = "False",
																	UILayoutViewModel = 
																	{
																		PositionX = 25,
																		PositionY = 25,
																		IsPercent = true,
																		PercentX = 50,
																		PercentY = 50,
																	},
																	width = "44",
																	ZOrder = "1",
																},
															},
														},
													},
												},
												{
													controlID = "Label_group_name_Panel_cell_ScrollView_list_Panel_page_Panel_root_Panel-skillHelpView_ui_battle_Game",
													UUID = "ae2ca619_ff84_42cc_9c28_2d7a788ad04c",
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
													fontSize = "20",
													fontStroke = 
													{
														IsStroke = false,
														StrokeColor = "#FFE6E6E6",
														StrokeSize = 1,
													},
													height = "25",
													ignoreSize = "True",
													name = "Label_group_name",
													nTextAlign = "1",
													nTextHAlign = "1",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "770",
													text = "ป้ายข้อความ",
													touchAble = "False",
													touchScaleEnable = "False",
													UILayoutViewModel = 
													{
														PositionX = 550,
														PositionY = 43,
													},
													width = "135",
													ZOrder = "1",
												},
											},
										},
									},
								},
								{
									controlID = "Button_close_Panel_page_Panel_root_Panel-skillHelpView_ui_battle_Game",
									UUID = "0318841b_b8d2_4016_a2c3_80875c7145ee",
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
										PositionX = 336,
										PositionY = 183,
									},
									UItype = "Button",
									width = "60",
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
			"ui/common/pop_ui/pop_bg_01.png",
			"ui/common/pop_ui/pop_bg_02.png",
			"ui/common/pop_ui/pop_ui_02.png",
			"ui/common/pop_ui/pop_ui_01.png",
			"ui/battle/skillhelp/skill_group_bg.png",
			"ui/battle/skillhelp/skill_logo_A.png",
			"ui/common/pop_ui/pop_btn_02.png",
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

