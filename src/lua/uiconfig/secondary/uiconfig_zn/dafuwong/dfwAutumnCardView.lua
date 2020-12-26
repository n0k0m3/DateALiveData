local t = 
{
	version = 1,
	components = 
	{
		
		{
			controlID = "Panel-dfwAutumnCardView_Layer3_dafuwong_Game",
			UUID = "483ba535_8673_4073_aad1_a2bc3208a396",
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
					controlID = "Panel_root_Panel-dfwAutumnCardView_Layer3_dafuwong_Game",
					UUID = "30745a83_36b7_4eed_8435_56c945ad4727",
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
						PositionX = 510,
						PositionY = 354,
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
							controlID = "bg_Panel_root_Panel-dfwAutumnCardView_Layer3_dafuwong_Game",
							UUID = "dd0134df_0a4a_4534_921e_4540e4a3c50f",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							backGroundScale9Enable = "False",
							classname = "MEImage",
							dstBlendFunc = "771",
							height = "583",
							ignoreSize = "True",
							name = "bg",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							texturePath = "ui/dfwautumn/card/bg.png",
							touchAble = "False",
							UILayoutViewModel = 
							{
								
							},
							width = "1022",
							ZOrder = "1",
						},
						{
							controlID = "ScrollView_card_Panel_root_Panel-dfwAutumnCardView_Layer3_dafuwong_Game",
							UUID = "ed8b5cb4_950b_4bc9_8e3c_c92131836b28",
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
							height = "534",
							ignoreSize = "False",
							innerHeight = "534",
							innerWidth = "893",
							name = "ScrollView_card",
							showScrollbar = "False",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							touchAble = "True",
							UILayoutViewModel = 
							{
								PositionX = -447,
								PositionY = -266,
							},
							uipanelviewmodel = 
							{
								Layout="Absolute",
								nType = "0"
							},
							width = "893",
							ZOrder = "1",
						},
						{
							controlID = "Label_empty_Panel_root_Panel-dfwAutumnCardView_Layer3_dafuwong_Game",
							UUID = "0ba3c501_8762_4479_89d0_f66c7f7995c2",
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
							name = "Label_empty",
							nTextAlign = "1",
							nTextHAlign = "1",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "770",
							text = "背包里面没有道具卡，请去游戏获得",
							touchAble = "False",
							touchScaleEnable = "False",
							UILayoutViewModel = 
							{
								
							},
							width = "325",
							ZOrder = "1",
						},
						{
							controlID = "Button_close_Panel_root_Panel-dfwAutumnCardView_Layer3_dafuwong_Game",
							UUID = "c4384467_9bff_461d_8b8e_7a105131c29b",
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
							name = "Button_close",
							normal = "ui/dfwautumn/card/close.png",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							touchAble = "True",
							UILayoutViewModel = 
							{
								PositionX = 404,
								PositionY = 247,
							},
							UItype = "Button",
							width = "189",
							ZOrder = "1",
						},
					},
				},
				{
					controlID = "Panel_prefab_Panel-dfwAutumnCardView_Layer3_dafuwong_Game",
					UUID = "d82df8cf_69c2_42cc_9e01_499ed2c3477e",
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
						PositionX = 692,
						PositionY = -516,
						LeftPositon = 124,
						TopPosition = 905,
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
					components = 
					{
						
						{
							controlID = "Panel_card_Panel_prefab_Panel-dfwAutumnCardView_Layer3_dafuwong_Game",
							UUID = "ee95fdfb_24a8_48b8_899b_989299a39245",
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
							height = "310",
							ignoreSize = "False",
							name = "Panel_card",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							touchAble = "False",
							UILayoutViewModel = 
							{
								PositionX = -360,
								PositionY = 18,
							},
							uipanelviewmodel = 
							{
								Layout="Absolute",
								nType = "0"
							},
							width = "217",
							ZOrder = "1",
							components = 
							{
								
								{
									controlID = "Button_card_Panel_card_Panel_prefab_Panel-dfwAutumnCardView_Layer3_dafuwong_Game",
									UUID = "8fb6c94f_e3dc_4bce_8f74_307a0b7aed42",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEButton",
									ClickHighLightEnabled = "True",
									dstBlendFunc = "771",
									flipX = "False",
									flipY = "False",
									height = "301",
									ignoreSize = "True",
									name = "Button_card",
									normal = "ui/dfwautumn/card/01.png",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "True",
									UILayoutViewModel = 
									{
										
									},
									UItype = "Button",
									width = "216",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "Label_title_Button_card_Panel_card_Panel_prefab_Panel-dfwAutumnCardView_Layer3_dafuwong_Game",
											UUID = "3ac2b043_58a5_4633_a547_c3b6b9034845",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											classname = "MELabel",
											compPath = "luacomponents.common.MEIconLabel",
											dstBlendFunc = "771",
											FontColor = "#FF973947",
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
											height = "0",
											ignoreSize = "False",
											name = "Label_title",
											nTextAlign = "1",
											nTextHAlign = "1",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "770",
											text = "标题标题",
											touchAble = "False",
											touchScaleEnable = "False",
											UILayoutViewModel = 
											{
												PositionX = -1,
												PositionY = -26,
											},
											width = "0",
											ZOrder = "1",
										},
									},
								},
								{
									controlID = "Image_icon_Panel_card_Panel_prefab_Panel-dfwAutumnCardView_Layer3_dafuwong_Game",
									UUID = "ca7e876c_398c_4979_bdcc_d28e8ca75d3e",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "64",
									ignoreSize = "True",
									name = "Image_icon",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = -1,
										PositionY = 58,
									},
									width = "64",
									ZOrder = "1",
								},
								{
									controlID = "Label_desc_Panel_card_Panel_prefab_Panel-dfwAutumnCardView_Layer3_dafuwong_Game",
									UUID = "2b0730b3_12e9_4c53_92ba_1307ea44deef",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									classname = "MELabel",
									compPath = "luacomponents.common.MEIconLabel",
									dstBlendFunc = "771",
									FontColor = "#FFB05461",
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
									height = "60",
									ignoreSize = "False",
									name = "Label_desc",
									nTextAlign = "0",
									nTextHAlign = "0",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "下一次色子步数 +3",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionX = 1,
										PositionY = -80,
									},
									width = "193",
									ZOrder = "1",
								},
								{
									controlID = "Label_num_Panel_card_Panel_prefab_Panel-dfwAutumnCardView_Layer3_dafuwong_Game",
									UUID = "17067234_46f2_44e0_a8a1_348e9051a87e",
									anchorPoint = "False",
									anchorPointX = "1",
									anchorPointY = "0.5",
									classname = "MELabel",
									compPath = "luacomponents.common.MEIconLabel",
									dstBlendFunc = "771",
									FontColor = "#FF973947",
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
										IsStroke = false,
										StrokeColor = "#FFE6E6E6",
										StrokeSize = 1,
									},
									height = "22",
									ignoreSize = "True",
									name = "Label_num",
									nTextAlign = "1",
									nTextHAlign = "1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "5-6",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionX = 93,
										PositionY = 119,
									},
									width = "40",
									ZOrder = "1",
								},
								{
									controlID = "Image_select_Panel_card_Panel_prefab_Panel-dfwAutumnCardView_Layer3_dafuwong_Game",
									UUID = "ab499a07_a7f2_4c1c_add7_edf9676251b9",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "330",
									ignoreSize = "True",
									name = "Image_select",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/dfwautumn/card/02.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										
									},
									width = "245",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "Button_use_Image_select_Panel_card_Panel_prefab_Panel-dfwAutumnCardView_Layer3_dafuwong_Game",
											UUID = "94d63390_b7d6_4035_923e_8676db8fd6e5",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											classname = "MEButton",
											ClickHighLightEnabled = "True",
											dstBlendFunc = "771",
											flipX = "False",
											flipY = "False",
											height = "45",
											ignoreSize = "True",
											name = "Button_use",
											normal = "ui/dfwautumn/card/btn_use.png",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "True",
											UILayoutViewModel = 
											{
												PositionY = -121,
											},
											UItype = "Button",
											width = "133",
											ZOrder = "-1",
											components = 
											{
												
												{
													controlID = "Label_use_Button_use_Image_select_Panel_card_Panel_prefab_Panel-dfwAutumnCardView_Layer3_dafuwong_Game",
													UUID = "61bea7f6_3309_449b_96e0_fbcd2c44b1bf",
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
													name = "Label_use",
													nTextAlign = "1",
													nTextHAlign = "1",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "770",
													text = "使用",
													touchAble = "False",
													touchScaleEnable = "False",
													UILayoutViewModel = 
													{
														PositionY = -3,
													},
													width = "53",
													ZOrder = "1",
												},
											},
										},
									},
								},
								{
									controlID = "Label_effect_Panel_card_Panel_prefab_Panel-dfwAutumnCardView_Layer3_dafuwong_Game",
									UUID = "7d675050_5167_4712_8227_52b1a8eb0176",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									classname = "MELabel",
									compPath = "luacomponents.common.MEIconLabel",
									dstBlendFunc = "771",
									FontColor = "#FF973947",
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
									name = "Label_effect",
									nTextAlign = "1",
									nTextHAlign = "1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "当前正处于该BUFF下",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionY = -130,
									},
									width = "165",
									ZOrder = "1",
								},
								{
									controlID = "Spine_effect_Panel_card_Panel_prefab_Panel-dfwAutumnCardView_Layer3_dafuwong_Game",
									UUID = "b00aaebe_74af_488f_a137_b3bc8ba28595",
									classname = "MESpine",
									dstBlendFunc = "771",
									name = "Spine_effect",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									spineModel = 
									{
										SpinePath = "effect/eff_DFW_daojuka/eff_DFW_daojuka",
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
			"ui/dfwautumn/card/bg.png",
			"ui/dfwautumn/card/close.png",
			"ui/dfwautumn/card/01.png",
			"ui/dfwautumn/card/02.png",
			"ui/dfwautumn/card/btn_use.png",
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

