local t = 
{
	version = 1,
	components = 
	{
		
		{
			controlID = "Panel-fubenTheaterRewardView_Layer1_fuben_Game",
			UUID = "1d278e1d_eabb_4088_9646_928780e27b12",
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
					controlID = "Panel_root_Panel-fubenTheaterRewardView_Layer1_fuben_Game",
					UUID = "2995e164_1fbf_44f5_bcf5_0ad38519c214",
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
							controlID = "Image_bg_Panel_root_Panel-fubenTheaterRewardView_Layer1_fuben_Game",
							UUID = "acdd9cdb_86ea_4671_9179_7a837b653ede",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							backGroundScale9Enable = "True;capInsetsX:0;capInsetsY:0;capInsetsWidth:0;capInsetsHeight:0",
							classname = "MEImage",
							dstBlendFunc = "771",
							height = "428",
							ignoreSize = "False",
							name = "Image_bg",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							texturePath = "ui/common/pop_ui/pop_bg_01.png",
							touchAble = "True",
							UILayoutViewModel = 
							{
								
							},
							width = "747",
							ZOrder = "1",
							components = 
							{
								
								{
									controlID = "Image_fubenStarRewardView_1_Image_bg_Panel_root_Panel-fubenTheaterRewardView_Layer1_fuben_Game",
									UUID = "d0926b0a_ea9e_42cf_adb5_360d3b33ccc7",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "354",
									ignoreSize = "False",
									name = "Image_fubenStarRewardView_1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/common/pop_ui/pop_bg_02.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionY = -20,
									},
									width = "726",
									ZOrder = "1",
								},
								{
									controlID = "Label_name_Image_bg_Panel_root_Panel-fubenTheaterRewardView_Layer1_fuben_Game",
									UUID = "1fd4aa22_b779_4025_b300_2b75ddf48c06",
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
									height = "32",
									ignoreSize = "True",
									name = "Label_name",
									nTextAlign = "1",
									nTextHAlign = "1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "Belohnung tauschen",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionX = -353,
										PositionY = 182,
									},
									width = "299",
									ZOrder = "1",
								},
								{
									controlID = "Label_en_name_Image_bg_Panel_root_Panel-fubenTheaterRewardView_Layer1_fuben_Game",
									UUID = "e39fa676_2ef9_43b5_885e_e839115a6e3b",
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
									fontSize = "16",
									fontStroke = 
									{
										IsStroke = false,
										StrokeColor = "#FFE6E6E6",
										StrokeSize = 1,
									},
									height = "18",
									ignoreSize = "True",
									name = "Label_en_name",
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
										PositionX = -224,
										PositionY = 176,
									},
									visible = "False",
									width = "67",
									ZOrder = "1",
								},
								{
									controlID = "Image_split_Image_bg_Panel_root_Panel-fubenTheaterRewardView_Layer1_fuben_Game",
									UUID = "5390974a_13b6_4a7c_95fb_5fd48b8fbde8",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "26",
									ignoreSize = "True",
									name = "Image_split",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/common/pop_ui/pop_ui_02.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = -229,
										PositionY = 184,
									},
									visible = "False",
									width = "2",
									ZOrder = "1",
								},
								{
									controlID = "ScrollView_star_Image_bg_Panel_root_Panel-fubenTheaterRewardView_Layer1_fuben_Game",
									UUID = "4dcc376b_01ef_4f7d_a727_fdd31cde605d",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									bgColorOpacity = "50",
									bIsOpenClipping = "True",
									bounceEnable = "True",
									classname = "MEScrollView",
									colorType = "0;SingleColor:#FFE6E6E6;GraduallyChangingColorStart:#FFFFFFFF;GraduallyChangingColorEnd:#FFFFFFFF;vectorX:0;vectorY:0",
									direction = "1",
									dstBlendFunc = "771",
									height = "345",
									ignoreSize = "False",
									innerHeight = "345",
									innerWidth = "720",
									name = "ScrollView_star",
									showScrollbar = "False",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "True",
									UILayoutViewModel = 
									{
										PositionY = -19,
									},
									uipanelviewmodel = 
									{
										Layout="Absolute",
										nType = "0"
									},
									width = "720",
									ZOrder = "1",
								},
								{
									controlID = "Button_close_Image_bg_Panel_root_Panel-fubenTheaterRewardView_Layer1_fuben_Game",
									UUID = "f8beb9ea_a42b_4163_803d_7427c221397a",
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
										PositionX = 339,
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
				{
					controlID = "Panel_prefab_Panel-fubenTheaterRewardView_Layer1_fuben_Game",
					UUID = "6bb0dc49_600f_405e_b92a_ef17c8f68aee",
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
						PositionX = 6,
						PositionY = -696,
						LeftPositon = 6,
						TopPosition = 696,
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
							controlID = "Panel_starItem_Panel_prefab_Panel-fubenTheaterRewardView_Layer1_fuben_Game",
							UUID = "58400339_e7b2_4d40_aa8a_1306ea5b6d9b",
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
							height = "112",
							ignoreSize = "False",
							name = "Panel_starItem",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							touchAble = "False",
							UILayoutViewModel = 
							{
								PositionX = 494,
								PositionY = 488,
							},
							uipanelviewmodel = 
							{
								Layout="Absolute",
								nType = "0"
							},
							width = "716",
							ZOrder = "1",
							components = 
							{
								
								{
									controlID = "Image_diban_Panel_starItem_Panel_prefab_Panel-fubenTheaterRewardView_Layer1_fuben_Game",
									UUID = "174e9b05_d939_42d6_af2b_7ae9e3610b51",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "112",
									ignoreSize = "True",
									name = "Image_diban",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/fuben/reward_diban.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										
									},
									width = "716",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "Button_get_Image_diban_Panel_starItem_Panel_prefab_Panel-fubenTheaterRewardView_Layer1_fuben_Game",
											UUID = "43af8844_b85f_478b_9fc4_237b5513f625",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "True;capInsetsX:0;capInsetsY:0;capInsetsWidth:0;capInsetsHeight:0",
											classname = "MEButton",
											ClickHighLightEnabled = "True",
											dstBlendFunc = "771",
											flipX = "False",
											flipY = "False",
											height = "53",
											ignoreSize = "False",
											name = "Button_get",
											normal = "ui/common/button09.png",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "True",
											UILayoutViewModel = 
											{
												PositionX = 289,
											},
											UItype = "Button",
											visible = "False",
											width = "115",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "Label_get_Button_get_Image_diban_Panel_starItem_Panel_prefab_Panel-fubenTheaterRewardView_Layer1_fuben_Game",
													UUID = "aadd7121_1634_45a1_a533_ba9062e411e0",
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
														IsStroke = false,
														StrokeColor = "#FFE6E6E6",
														StrokeSize = 1,
													},
													height = "25",
													ignoreSize = "True",
													name = "Label_get",
													nTextAlign = "1",
													nTextHAlign = "1",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "770",
													text = "Tausch",
													touchAble = "False",
													touchScaleEnable = "False",
													UILayoutViewModel = 
													{
														
													},
													width = "64",
													ZOrder = "1",
												},
											},
										},
										{
											controlID = "Label_alreadyGet_Image_diban_Panel_starItem_Panel_prefab_Panel-fubenTheaterRewardView_Layer1_fuben_Game",
											UUID = "5063be6f_0af8_48e2_b408_f31740f92c7b",
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
												IsStroke = false,
												StrokeColor = "#FFE6E6E6",
												StrokeSize = 1,
											},
											height = "25",
											ignoreSize = "True",
											name = "Label_alreadyGet",
											nTextAlign = "1",
											nTextHAlign = "1",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "770",
											text = "Abgeholt",
											touchAble = "False",
											touchScaleEnable = "False",
											UILayoutViewModel = 
											{
												PositionX = 283,
											},
											visible = "False",
											width = "81",
											ZOrder = "1",
										},
										{
											controlID = "Label_notReach_Image_diban_Panel_starItem_Panel_prefab_Panel-fubenTheaterRewardView_Layer1_fuben_Game",
											UUID = "6ac1dbef_d45c_4143_8956_15070d360822",
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
												IsStroke = false,
												StrokeColor = "#FFE6E6E6",
												StrokeSize = 1,
											},
											height = "25",
											ignoreSize = "True",
											name = "Label_notReach",
											nTextAlign = "1",
											nTextHAlign = "1",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "770",
											text = "Nicht erreicht",
											touchAble = "False",
											touchScaleEnable = "False",
											UILayoutViewModel = 
											{
												PositionX = 281,
											},
											width = "126",
											ZOrder = "1",
										},
										{
											controlID = "ScrollView_reward_Image_diban_Panel_starItem_Panel_prefab_Panel-fubenTheaterRewardView_Layer1_fuben_Game",
											UUID = "e96981cb_2e1d_4eeb_b3e7_ea46fc3bc346",
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
											height = "75",
											ignoreSize = "False",
											innerHeight = "75",
											innerWidth = "240",
											name = "ScrollView_reward",
											showScrollbar = "False",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 32,
												PositionY = -14,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "240",
											ZOrder = "1",
										},
										{
											controlID = "Image_fubenStarRewardView_1_Image_diban_Panel_starItem_Panel_prefab_Panel-fubenTheaterRewardView_Layer1_fuben_Game",
											UUID = "9ac3e283_da8f_4422_a830_f5ff13bc7533",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											classname = "MEImage",
											dstBlendFunc = "771",
											height = "24",
											ignoreSize = "True",
											name = "Image_fubenStarRewardView_1",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											texturePath = "ui/fuben/title_2.png",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = -347,
												PositionY = 41,
											},
											width = "4",
											ZOrder = "1",
										},
										{
											controlID = "Label_collect_Image_diban_Panel_starItem_Panel_prefab_Panel-fubenTheaterRewardView_Layer1_fuben_Game",
											UUID = "ca1a93f7_397f_4e94_a67e_c302ece1e87f",
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
											fontSize = "22",
											fontStroke = 
											{
												IsStroke = false,
												StrokeColor = "#FFE6E6E6",
												StrokeSize = 1,
											},
											height = "25",
											ignoreSize = "True",
											name = "Label_collect",
											nTextAlign = "1",
											nTextHAlign = "1",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "770",
											text = "Sammeln",
											touchAble = "False",
											touchScaleEnable = "False",
											UILayoutViewModel = 
											{
												PositionX = -341,
												PositionY = 40,
											},
											width = "84",
											ZOrder = "1",
										},
										{
											controlID = "Label_star_num_Image_diban_Panel_starItem_Panel_prefab_Panel-fubenTheaterRewardView_Layer1_fuben_Game",
											UUID = "1be0606a_4703_43bb_81e5_61ea7640d02e",
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
											fontSize = "54",
											fontStroke = 
											{
												IsStroke = false,
												StrokeColor = "#FFE6E6E6",
												StrokeSize = 1,
											},
											height = "62",
											ignoreSize = "True",
											name = "Label_star_num",
											nTextAlign = "1",
											nTextHAlign = "1",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "770",
											text = "99999",
											touchAble = "False",
											touchScaleEnable = "False",
											UILayoutViewModel = 
											{
												PositionX = -250,
												PositionY = -18,
											},
											width = "144",
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
			"ui/common/pop_ui/pop_bg_02.png",
			"ui/common/pop_ui/pop_ui_02.png",
			"ui/common/pop_ui/pop_btn_02.png",
			"ui/fuben/reward_diban.png",
			"ui/common/button09.png",
			"ui/fuben/title_2.png",
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

