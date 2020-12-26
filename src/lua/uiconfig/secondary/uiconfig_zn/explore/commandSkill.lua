local t = 
{
	version = 1,
	components = 
	{
		
		{
			controlID = "Panel-commandSkill_flyShipGrowUp_explore_Game",
			UUID = "5f96dc52_b100_4ae1_8848_d1721989a612",
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
					controlID = "Panel_base_Panel-commandSkill_flyShipGrowUp_explore_Game",
					UUID = "57a1db12_e5b3_46aa_8c80_a28ee474e095",
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
						PositionX = -58,
						PositionY = 34,
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
							controlID = "Image_bg_Panel_base_Panel-commandSkill_flyShipGrowUp_explore_Game",
							UUID = "1308061f_5035_4080_8b47_82073f118a98",
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
							texturePath = "ui/explore/growup/common/BG.png",
							touchAble = "False",
							UILayoutViewModel = 
							{
								PositionX = 568,
								PositionY = 320,
							},
							width = "1386",
							ZOrder = "1",
						},
						{
							controlID = "Image_1_Panel_base_Panel-commandSkill_flyShipGrowUp_explore_Game",
							UUID = "fba6bc19_ac88_4cfa_a349_9fd4e80ecfd5",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							backGroundScale9Enable = "False",
							classname = "MEImage",
							dstBlendFunc = "771",
							height = "640",
							ignoreSize = "True",
							name = "Image_1",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							texturePath = "ui/explore/growup/common/t001.png",
							touchAble = "False",
							UILayoutViewModel = 
							{
								PositionX = 568,
								PositionY = 320,
							},
							width = "1386",
							ZOrder = "1",
						},
						{
							controlID = "Spine_effect_Panel_base_Panel-commandSkill_flyShipGrowUp_explore_Game",
							UUID = "5ee7e105_57ae_4b9d_b71e_cfe64c3d740d",
							classname = "MESpine",
							dstBlendFunc = "771",
							name = "Spine_effect",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							spineModel = 
							{
								SpinePath = "effect/TS_texiao/TS_dianzizhankai",
								animationName = "pingmu_xia",
								IsLoop = false,
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
								PositionX = 563,
								PositionY = 321,
							},
							ZOrder = "1",
						},
						{
							controlID = "Spine_bg_Panel_base_Panel-commandSkill_flyShipGrowUp_explore_Game",
							UUID = "a8de37ea_5dca_4ff0_8542_3ced7c185f8f",
							classname = "MESpine",
							dstBlendFunc = "771",
							name = "Spine_bg",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							spineModel = 
							{
								SpinePath = "effect/TS_UIjiemian/afk_beijingtexiao",
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
							ZOrder = "1",
						},
						{
							controlID = "Image_3_Panel_base_Panel-commandSkill_flyShipGrowUp_explore_Game",
							UUID = "efe7825d_43a4_4a39_89bf_ffb8e4a7a874",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							backGroundScale9Enable = "False",
							classname = "MEImage",
							dstBlendFunc = "771",
							height = "508",
							ignoreSize = "True",
							name = "Image_3",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							texturePath = "ui/explore/growup/command/skill/lingshi001.png",
							touchAble = "False",
							UILayoutViewModel = 
							{
								PositionX = 568,
								PositionY = 320,
							},
							width = "1076",
							ZOrder = "1",
						},
						{
							controlID = "Panel_show_Panel_base_Panel-commandSkill_flyShipGrowUp_explore_Game",
							UUID = "95a704c9_93f8_4c38_ab7f_fb7062da7126",
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
							name = "Panel_show",
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
							width = "400",
							ZOrder = "1",
							components = 
							{
								
								{
									controlID = "Image_weaponRoom_12_Panel_show_Panel_base_Panel-commandSkill_flyShipGrowUp_explore_Game",
									UUID = "f629d488_3885_4945_8387_2a47b13c9893",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "508",
									ignoreSize = "True",
									name = "Image_weaponRoom_12",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/explore/growup/command/skill/001.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = 206,
										PositionY = 320,
									},
									width = "280",
									ZOrder = "1",
								},
								{
									controlID = "Image_4_Panel_show_Panel_base_Panel-commandSkill_flyShipGrowUp_explore_Game",
									UUID = "b9531678_da7c_41b2_8d52_fb6311bec2f6",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "58",
									ignoreSize = "True",
									name = "Image_4",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/explore/growup/common/t003.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = 840,
										PositionY = 541,
									},
									width = "512",
									ZOrder = "1",
								},
								{
									controlID = "Label_name_Panel_show_Panel_base_Panel-commandSkill_flyShipGrowUp_explore_Game",
									UUID = "55086b37_361b_4b19_b498_7dd3808bc468",
									anchorPoint = "False",
									anchorPointX = "1",
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
										IsStroke = false,
										StrokeColor = "#FFE6E6E6",
										StrokeSize = 1,
									},
									height = "30",
									ignoreSize = "True",
									name = "Label_name",
									nTextAlign = "0",
									nTextHAlign = "0",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "TextLable",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionX = 1056,
										PositionY = 540,
									},
									width = "159",
									ZOrder = "1",
								},
								{
									controlID = "Panel_state_Panel_show_Panel_base_Panel-commandSkill_flyShipGrowUp_explore_Game",
									UUID = "90b89a38_76b8_4e72_91bc_d647700b3bc2",
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
									name = "Panel_state",
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
									width = "400",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "working_Panel_state_Panel_show_Panel_base_Panel-commandSkill_flyShipGrowUp_explore_Game",
											UUID = "b1f4c67b_54b5_403e_84ee_ad75ddd56d16",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											classname = "MEImage",
											dstBlendFunc = "771",
											height = "50",
											ignoreSize = "True",
											name = "working",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											texturePath = "ui/explore/growup/command/skill/014.png",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 1009,
												PositionY = 504,
											},
											width = "142",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "Label_working_working_Panel_state_Panel_show_Panel_base_Panel-commandSkill_flyShipGrowUp_explore_Game",
													UUID = "78525226_ca4f_4c80_9ce8_0a66d65e48b3",
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
													name = "Label_working",
													nTextAlign = "1",
													nTextHAlign = "1",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "770",
													text = "激活中",
													touchAble = "False",
													touchScaleEnable = "False",
													UILayoutViewModel = 
													{
														
													},
													width = "57",
													ZOrder = "1",
												},
											},
										},
										{
											controlID = "notWorking_Panel_state_Panel_show_Panel_base_Panel-commandSkill_flyShipGrowUp_explore_Game",
											UUID = "8d03ae61_3b72_460d_a74a_ae4cff6693ce",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											classname = "MEImage",
											dstBlendFunc = "771",
											height = "50",
											ignoreSize = "True",
											name = "notWorking",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											texturePath = "ui/explore/growup/command/skill/015.png",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 1009,
												PositionY = 504,
											},
											width = "142",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "Label_notWorking_notWorking_Panel_state_Panel_show_Panel_base_Panel-commandSkill_flyShipGrowUp_explore_Game",
													UUID = "c1b8898f_4f24_4ebb_b87b_ffc6a6db9f70",
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
													name = "Label_notWorking",
													nTextAlign = "1",
													nTextHAlign = "1",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "770",
													text = "未激活",
													touchAble = "False",
													touchScaleEnable = "False",
													UILayoutViewModel = 
													{
														
													},
													width = "57",
													ZOrder = "1",
												},
											},
										},
										{
											controlID = "Image_5_Panel_state_Panel_show_Panel_base_Panel-commandSkill_flyShipGrowUp_explore_Game",
											UUID = "71f7cc58_da44_4dfe_b6f1_db03b6a2e87d",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											classname = "MEImage",
											dstBlendFunc = "771",
											height = "12",
											ignoreSize = "True",
											name = "Image_5",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											texturePath = "ui/explore/growup/command/skill/016.png",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 959,
												PositionY = 474,
											},
											width = "12",
											ZOrder = "1",
										},
										{
											controlID = "Label_process_Panel_state_Panel_show_Panel_base_Panel-commandSkill_flyShipGrowUp_explore_Game",
											UUID = "81363749_1f35_4207_98b0_ef95c96a1a9e",
											anchorPoint = "False",
											anchorPointX = "1",
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
											name = "Label_process",
											nTextAlign = "1",
											nTextHAlign = "1",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "770",
											text = "10 50",
											touchAble = "False",
											touchScaleEnable = "False",
											UILayoutViewModel = 
											{
												PositionX = 1068,
												PositionY = 468,
											},
											width = "70",
											ZOrder = "1",
										},
									},
								},
								{
									controlID = "Panel_skillMap_Panel_show_Panel_base_Panel-commandSkill_flyShipGrowUp_explore_Game",
									UUID = "c679910d_5ee9_401f_94f3_ebbf94b0efa2",
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
									height = "403",
									ignoreSize = "False",
									name = "Panel_skillMap",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = 184,
										PositionY = 110,
									},
									uipanelviewmodel = 
									{
										Layout="Absolute",
										nType = "0"
									},
									width = "874",
									ZOrder = "1",
								},
								{
									controlID = "ScrollView_style_Panel_show_Panel_base_Panel-commandSkill_flyShipGrowUp_explore_Game",
									UUID = "cac3f085_7e05_41b0_872b_c34790628883",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									bgColorOpacity = "50",
									bIsOpenClipping = "False",
									bounceEnable = "False",
									classname = "MEScrollView",
									colorType = "0;SingleColor:#FFE6E6E6;GraduallyChangingColorStart:#FFFFFFFF;GraduallyChangingColorEnd:#FFFFFFFF;vectorX:0;vectorY:0",
									direction = "1",
									dstBlendFunc = "771",
									height = "435",
									ignoreSize = "False",
									innerHeight = "435",
									innerWidth = "150",
									name = "ScrollView_style",
									showScrollbar = "False",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "True",
									UILayoutViewModel = 
									{
										PositionX = 95,
										PositionY = 324,
										LeftPositon = -38,
										TopPosition = 279,
										relativeToName = "Panel",
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
									controlID = "Button_active_Panel_show_Panel_base_Panel-commandSkill_flyShipGrowUp_explore_Game",
									UUID = "8bab43d4_b100_411e_a7b2_263a794e2116",
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
									name = "Button_active",
									normal = "ui/common/button_middle_n.png",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "True",
									UILayoutViewModel = 
									{
										PositionX = 1013,
										PositionY = 112,
									},
									UItype = "Button",
									width = "124",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "Label_active_Button_active_Panel_show_Panel_base_Panel-commandSkill_flyShipGrowUp_explore_Game",
											UUID = "687152a3_a162_41da_a757_e25d280826f3",
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
												IsStroke = false,
												StrokeColor = "#FFE6E6E6",
												StrokeSize = 1,
											},
											height = "32",
											ignoreSize = "True",
											name = "Label_active",
											nTextAlign = "1",
											nTextHAlign = "1",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "770",
											text = "激活形态",
											touchAble = "False",
											touchScaleEnable = "False",
											UILayoutViewModel = 
											{
												
											},
											width = "107",
											ZOrder = "1",
										},
									},
								},
							},
						},
						{
							controlID = "Spine_effect1_Panel_base_Panel-commandSkill_flyShipGrowUp_explore_Game",
							UUID = "9f1d6d09_1801_447d_bb04_af1f39d1636d",
							classname = "MESpine",
							dstBlendFunc = "771",
							name = "Spine_effect1",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							spineModel = 
							{
								SpinePath = "effect/TS_texiao/TS_dianzizhankai",
								animationName = "pingmu_shang",
								IsLoop = false,
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
								PositionX = 563,
								PositionY = 321,
							},
							ZOrder = "1",
						},
					},
				},
				{
					controlID = "Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
					UUID = "60bd0500_c102_4e4a_a264_76c62f020662",
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
					height = "400",
					ignoreSize = "False",
					name = "Panel_prefab",
					sizepercentx = "0",
					sizepercenty = "0",
					sizeType = "0",
					srcBlendFunc = "1",
					touchAble = "False",
					UILayoutViewModel = 
					{
						PositionY = -640,
						BottomPosition = -640,
						relativeToName = "Panel",
						nType = 3,
						nGravity = 4,
						nAlign = 7
					},
					uipanelviewmodel = 
					{
						Layout="Absolute",
						nType = "0"
					},
					width = "400",
					ZOrder = "1",
					components = 
					{
						
						{
							controlID = "Panel_styleItem_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
							UUID = "a31bdbd6_e8b5_43ae_b7b6_0fe128af7aa6",
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
							name = "Panel_styleItem",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							touchAble = "False",
							UILayoutViewModel = 
							{
								PositionX = 80,
								PositionY = 126,
							},
							uipanelviewmodel = 
							{
								Layout="Absolute",
								nType = "0"
							},
							width = "86",
							ZOrder = "1",
							components = 
							{
								
								{
									controlID = "Image_select_Panel_styleItem_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
									UUID = "a7164607_da30_4411_ac5f_06d4996d28d0",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "114",
									ignoreSize = "True",
									name = "Image_select",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/explore/growup/command/skill/style_select_2.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										
									},
									visible = "False",
									width = "114",
									ZOrder = "1",
								},
								{
									controlID = "Image_normal_Panel_styleItem_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
									UUID = "152852dd_61aa_4eb1_bdeb_26a8b857f77a",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "114",
									ignoreSize = "True",
									name = "Image_normal",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/explore/growup/command/skill/style_normal_2.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										
									},
									width = "114",
									ZOrder = "1",
								},
								{
									controlID = "Image_flag_Panel_styleItem_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
									UUID = "6022d24c_e164_4fbd_8da3_fde03bea28aa",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "26",
									ignoreSize = "True",
									name = "Image_flag",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/explore/growup/command/skill/style_flag_2.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										
									},
									width = "88",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "Label_flag_Image_flag_Panel_styleItem_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
											UUID = "22e31e0d_5cdc_4947_9880_e1246011203a",
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
											name = "Label_flag",
											nTextAlign = "1",
											nTextHAlign = "1",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "770",
											text = "激活中",
											touchAble = "False",
											touchScaleEnable = "False",
											UILayoutViewModel = 
											{
												PositionY = -2,
											},
											width = "62",
											ZOrder = "1",
										},
									},
								},
								{
									controlID = "Spine_effect_Panel_styleItem_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
									UUID = "53e4014d_3cdd_4d7c_8af6_db4f5ae7b0c0",
									classname = "MESpine",
									dstBlendFunc = "771",
									name = "Spine_effect",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									spineModel = 
									{
										SpinePath = "effect/TS_UIjiemian/afk_anniutexiao",
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
									controlID = "Image_redTip_Panel_styleItem_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
									UUID = "3c746a7a_aac6_453b_afe1_b02678fa433b",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "30",
									ignoreSize = "True",
									name = "Image_redTip",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/common/news_small.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = 20,
										PositionY = 34,
									},
									width = "30",
									ZOrder = "1",
								},
							},
						},
						{
							controlID = "Panel_skillMap1_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
							UUID = "fe3364e1_461e_4192_aded_8e9ea51574e1",
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
							height = "403",
							ignoreSize = "False",
							name = "Panel_skillMap1",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							touchAble = "False",
							UILayoutViewModel = 
							{
								PositionX = 8,
								PositionY = 219,
							},
							uipanelviewmodel = 
							{
								Layout="Absolute",
								nType = "0"
							},
							width = "3796",
							ZOrder = "1",
							components = 
							{
								
								{
									controlID = "Panel_points_Panel_skillMap1_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
									UUID = "f636aa0a_a25c_48ba_b3c9_55bbc11a5664",
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
									name = "Panel_points",
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
									width = "400",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "Panel_point1_Panel_points_Panel_skillMap1_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
											UUID = "c6501b10_2780_4bf9_850c_04e45a8122a4",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											bgColorOpacity = "50",
											bIsOpenClipping = "False",
											classname = "MEPanel",
											colorType = "1;SingleColor:#FFFF0000;GraduallyChangingColorStart:#FFFFFFFF;GraduallyChangingColorEnd:#FFFFFFFF;vectorX:0;vectorY:0",
											DesignHeight = "640",
											DesignType = "0",
											DesignWidth = "960",
											dstBlendFunc = "771",
											height = "10",
											ignoreSize = "False",
											name = "Panel_point1",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 93,
												PositionY = 210,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "10",
											ZOrder = "1",
										},
										{
											controlID = "Panel_point2_Panel_points_Panel_skillMap1_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
											UUID = "8ce93c78_cfb5_435f_a43c_4e4cec294880",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											bgColorOpacity = "50",
											bIsOpenClipping = "False",
											classname = "MEPanel",
											colorType = "1;SingleColor:#FFFF0000;GraduallyChangingColorStart:#FFFFFFFF;GraduallyChangingColorEnd:#FFFFFFFF;vectorX:0;vectorY:0",
											DesignHeight = "640",
											DesignType = "0",
											DesignWidth = "960",
											dstBlendFunc = "771",
											height = "10",
											ignoreSize = "False",
											name = "Panel_point2",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 223,
												PositionY = 209,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "10",
											ZOrder = "1",
										},
										{
											controlID = "Panel_point3_Panel_points_Panel_skillMap1_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
											UUID = "5134694d_4f9c_4723_9758_ff1c8e9392dd",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											bgColorOpacity = "50",
											bIsOpenClipping = "False",
											classname = "MEPanel",
											colorType = "1;SingleColor:#FFFF0000;GraduallyChangingColorStart:#FFFFFFFF;GraduallyChangingColorEnd:#FFFFFFFF;vectorX:0;vectorY:0",
											DesignHeight = "640",
											DesignType = "0",
											DesignWidth = "960",
											dstBlendFunc = "771",
											height = "10",
											ignoreSize = "False",
											name = "Panel_point3",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 349,
												PositionY = 310,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "10",
											ZOrder = "1",
										},
										{
											controlID = "Panel_point4_Panel_points_Panel_skillMap1_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
											UUID = "4b58aedf_ace5_4f06_a69e_349eb8aba874",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											bgColorOpacity = "50",
											bIsOpenClipping = "False",
											classname = "MEPanel",
											colorType = "1;SingleColor:#FFFF0000;GraduallyChangingColorStart:#FFFFFFFF;GraduallyChangingColorEnd:#FFFFFFFF;vectorX:0;vectorY:0",
											DesignHeight = "640",
											DesignType = "0",
											DesignWidth = "960",
											dstBlendFunc = "771",
											height = "10",
											ignoreSize = "False",
											name = "Panel_point4",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 473,
												PositionY = 209,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "10",
											ZOrder = "1",
										},
										{
											controlID = "Panel_point5_Panel_points_Panel_skillMap1_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
											UUID = "a28d00ac_706b_462d_aa77_e8b9eb2ea151",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											bgColorOpacity = "50",
											bIsOpenClipping = "False",
											classname = "MEPanel",
											colorType = "1;SingleColor:#FFFF0000;GraduallyChangingColorStart:#FFFFFFFF;GraduallyChangingColorEnd:#FFFFFFFF;vectorX:0;vectorY:0",
											DesignHeight = "640",
											DesignType = "0",
											DesignWidth = "960",
											dstBlendFunc = "771",
											height = "10",
											ignoreSize = "False",
											name = "Panel_point5",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 604,
												PositionY = 209,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "10",
											ZOrder = "1",
										},
										{
											controlID = "Panel_point6_Panel_points_Panel_skillMap1_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
											UUID = "39615f9a_8ac2_400d_96f1_674fa9867662",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											bgColorOpacity = "50",
											bIsOpenClipping = "False",
											classname = "MEPanel",
											colorType = "1;SingleColor:#FFFF0000;GraduallyChangingColorStart:#FFFFFFFF;GraduallyChangingColorEnd:#FFFFFFFF;vectorX:0;vectorY:0",
											DesignHeight = "640",
											DesignType = "0",
											DesignWidth = "960",
											dstBlendFunc = "771",
											height = "10",
											ignoreSize = "False",
											name = "Panel_point6",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 726,
												PositionY = 108,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "10",
											ZOrder = "1",
										},
										{
											controlID = "Panel_point7_Panel_points_Panel_skillMap1_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
											UUID = "eaef9c74_1975_4ac6_ace2_7376b0202d28",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											bgColorOpacity = "50",
											bIsOpenClipping = "False",
											classname = "MEPanel",
											colorType = "1;SingleColor:#FFFF0000;GraduallyChangingColorStart:#FFFFFFFF;GraduallyChangingColorEnd:#FFFFFFFF;vectorX:0;vectorY:0",
											DesignHeight = "640",
											DesignType = "0",
											DesignWidth = "960",
											dstBlendFunc = "771",
											height = "10",
											ignoreSize = "False",
											name = "Panel_point7",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 851,
												PositionY = 209,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "10",
											ZOrder = "1",
										},
										{
											controlID = "Panel_point8_Panel_points_Panel_skillMap1_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
											UUID = "8e959793_1c83_4926_8037_56b3acfb8e6e",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											bgColorOpacity = "50",
											bIsOpenClipping = "False",
											classname = "MEPanel",
											colorType = "1;SingleColor:#FFFF0000;GraduallyChangingColorStart:#FFFFFFFF;GraduallyChangingColorEnd:#FFFFFFFF;vectorX:0;vectorY:0",
											DesignHeight = "640",
											DesignType = "0",
											DesignWidth = "960",
											dstBlendFunc = "771",
											height = "10",
											ignoreSize = "False",
											name = "Panel_point8",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 981,
												PositionY = 208,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "10",
											ZOrder = "1",
										},
										{
											controlID = "Panel_point9_Panel_points_Panel_skillMap1_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
											UUID = "814d9259_00e5_4899_9f59_b65c00690a33",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											bgColorOpacity = "50",
											bIsOpenClipping = "False",
											classname = "MEPanel",
											colorType = "1;SingleColor:#FFFF0000;GraduallyChangingColorStart:#FFFFFFFF;GraduallyChangingColorEnd:#FFFFFFFF;vectorX:0;vectorY:0",
											DesignHeight = "640",
											DesignType = "0",
											DesignWidth = "960",
											dstBlendFunc = "771",
											height = "10",
											ignoreSize = "False",
											name = "Panel_point9",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 1107,
												PositionY = 309,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "10",
											ZOrder = "1",
										},
										{
											controlID = "Panel_point10_Panel_points_Panel_skillMap1_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
											UUID = "25bed72c_e118_43df_8007_5a49d8a7458f",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											bgColorOpacity = "50",
											bIsOpenClipping = "False",
											classname = "MEPanel",
											colorType = "1;SingleColor:#FFFF0000;GraduallyChangingColorStart:#FFFFFFFF;GraduallyChangingColorEnd:#FFFFFFFF;vectorX:0;vectorY:0",
											DesignHeight = "640",
											DesignType = "0",
											DesignWidth = "960",
											dstBlendFunc = "771",
											height = "10",
											ignoreSize = "False",
											name = "Panel_point10",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 1231,
												PositionY = 208,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "10",
											ZOrder = "1",
										},
										{
											controlID = "Panel_point11_Panel_points_Panel_skillMap1_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
											UUID = "db25524f_ccad_4789_a130_bf54fde684e5",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											bgColorOpacity = "50",
											bIsOpenClipping = "False",
											classname = "MEPanel",
											colorType = "1;SingleColor:#FFFF0000;GraduallyChangingColorStart:#FFFFFFFF;GraduallyChangingColorEnd:#FFFFFFFF;vectorX:0;vectorY:0",
											DesignHeight = "640",
											DesignType = "0",
											DesignWidth = "960",
											dstBlendFunc = "771",
											height = "10",
											ignoreSize = "False",
											name = "Panel_point11",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 1362,
												PositionY = 208,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "10",
											ZOrder = "1",
										},
										{
											controlID = "Panel_point12_Panel_points_Panel_skillMap1_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
											UUID = "3365602f_3394_4778_8ecb_5e39dbad0a74",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											bgColorOpacity = "50",
											bIsOpenClipping = "False",
											classname = "MEPanel",
											colorType = "1;SingleColor:#FFFF0000;GraduallyChangingColorStart:#FFFFFFFF;GraduallyChangingColorEnd:#FFFFFFFF;vectorX:0;vectorY:0",
											DesignHeight = "640",
											DesignType = "0",
											DesignWidth = "960",
											dstBlendFunc = "771",
											height = "10",
											ignoreSize = "False",
											name = "Panel_point12",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 1484,
												PositionY = 107,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "10",
											ZOrder = "1",
										},
										{
											controlID = "Panel_point13_Panel_points_Panel_skillMap1_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
											UUID = "a55170c2_9247_4836_b72d_c4c978a85bbe",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											bgColorOpacity = "50",
											bIsOpenClipping = "False",
											classname = "MEPanel",
											colorType = "1;SingleColor:#FFFF0000;GraduallyChangingColorStart:#FFFFFFFF;GraduallyChangingColorEnd:#FFFFFFFF;vectorX:0;vectorY:0",
											DesignHeight = "640",
											DesignType = "0",
											DesignWidth = "960",
											dstBlendFunc = "771",
											height = "10",
											ignoreSize = "False",
											name = "Panel_point13",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 1608,
												PositionY = 210,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "10",
											ZOrder = "1",
										},
										{
											controlID = "Panel_point14_Panel_points_Panel_skillMap1_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
											UUID = "f7804fae_da06_47f0_9a5a_6befe2bf77c6",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											bgColorOpacity = "50",
											bIsOpenClipping = "False",
											classname = "MEPanel",
											colorType = "1;SingleColor:#FFFF0000;GraduallyChangingColorStart:#FFFFFFFF;GraduallyChangingColorEnd:#FFFFFFFF;vectorX:0;vectorY:0",
											DesignHeight = "640",
											DesignType = "0",
											DesignWidth = "960",
											dstBlendFunc = "771",
											height = "10",
											ignoreSize = "False",
											name = "Panel_point14",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 1738,
												PositionY = 209,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "10",
											ZOrder = "1",
										},
										{
											controlID = "Panel_point15_Panel_points_Panel_skillMap1_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
											UUID = "235f638e_f509_46e5_bb20_1ed7766463c9",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											bgColorOpacity = "50",
											bIsOpenClipping = "False",
											classname = "MEPanel",
											colorType = "1;SingleColor:#FFFF0000;GraduallyChangingColorStart:#FFFFFFFF;GraduallyChangingColorEnd:#FFFFFFFF;vectorX:0;vectorY:0",
											DesignHeight = "640",
											DesignType = "0",
											DesignWidth = "960",
											dstBlendFunc = "771",
											height = "10",
											ignoreSize = "False",
											name = "Panel_point15",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 1864,
												PositionY = 310,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "10",
											ZOrder = "1",
										},
										{
											controlID = "Panel_point16_Panel_points_Panel_skillMap1_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
											UUID = "ae032e2b_3f84_4173_be35_b87549458b47",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											bgColorOpacity = "50",
											bIsOpenClipping = "False",
											classname = "MEPanel",
											colorType = "1;SingleColor:#FFFF0000;GraduallyChangingColorStart:#FFFFFFFF;GraduallyChangingColorEnd:#FFFFFFFF;vectorX:0;vectorY:0",
											DesignHeight = "640",
											DesignType = "0",
											DesignWidth = "960",
											dstBlendFunc = "771",
											height = "10",
											ignoreSize = "False",
											name = "Panel_point16",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 1988,
												PositionY = 209,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "10",
											ZOrder = "1",
										},
										{
											controlID = "Panel_point17_Panel_points_Panel_skillMap1_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
											UUID = "2b3028fc_872e_43c6_83ba_87623efe3319",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											bgColorOpacity = "50",
											bIsOpenClipping = "False",
											classname = "MEPanel",
											colorType = "1;SingleColor:#FFFF0000;GraduallyChangingColorStart:#FFFFFFFF;GraduallyChangingColorEnd:#FFFFFFFF;vectorX:0;vectorY:0",
											DesignHeight = "640",
											DesignType = "0",
											DesignWidth = "960",
											dstBlendFunc = "771",
											height = "10",
											ignoreSize = "False",
											name = "Panel_point17",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 2119,
												PositionY = 209,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "10",
											ZOrder = "1",
										},
										{
											controlID = "Panel_point18_Panel_points_Panel_skillMap1_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
											UUID = "ec81614d_d8c0_4f18_bda4_2164d5f24160",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											bgColorOpacity = "50",
											bIsOpenClipping = "False",
											classname = "MEPanel",
											colorType = "1;SingleColor:#FFFF0000;GraduallyChangingColorStart:#FFFFFFFF;GraduallyChangingColorEnd:#FFFFFFFF;vectorX:0;vectorY:0",
											DesignHeight = "640",
											DesignType = "0",
											DesignWidth = "960",
											dstBlendFunc = "771",
											height = "10",
											ignoreSize = "False",
											name = "Panel_point18",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 2241,
												PositionY = 108,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "10",
											ZOrder = "1",
										},
										{
											controlID = "Panel_point19_Panel_points_Panel_skillMap1_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
											UUID = "7b8f42c5_bc57_4bda_8623_66390f05b475",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											bgColorOpacity = "50",
											bIsOpenClipping = "False",
											classname = "MEPanel",
											colorType = "1;SingleColor:#FFFF0000;GraduallyChangingColorStart:#FFFFFFFF;GraduallyChangingColorEnd:#FFFFFFFF;vectorX:0;vectorY:0",
											DesignHeight = "640",
											DesignType = "0",
											DesignWidth = "960",
											dstBlendFunc = "771",
											height = "10",
											ignoreSize = "False",
											name = "Panel_point19",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 2366,
												PositionY = 209,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "10",
											ZOrder = "1",
										},
										{
											controlID = "Panel_point20_Panel_points_Panel_skillMap1_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
											UUID = "76eca56f_c29b_4464_bd5e_9452f6315854",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											bgColorOpacity = "50",
											bIsOpenClipping = "False",
											classname = "MEPanel",
											colorType = "1;SingleColor:#FFFF0000;GraduallyChangingColorStart:#FFFFFFFF;GraduallyChangingColorEnd:#FFFFFFFF;vectorX:0;vectorY:0",
											DesignHeight = "640",
											DesignType = "0",
											DesignWidth = "960",
											dstBlendFunc = "771",
											height = "10",
											ignoreSize = "False",
											name = "Panel_point20",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 2496,
												PositionY = 208,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "10",
											ZOrder = "1",
										},
										{
											controlID = "Panel_point21_Panel_points_Panel_skillMap1_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
											UUID = "5eaba338_7c25_48b9_b54c_48699bfb797b",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											bgColorOpacity = "50",
											bIsOpenClipping = "False",
											classname = "MEPanel",
											colorType = "1;SingleColor:#FFFF0000;GraduallyChangingColorStart:#FFFFFFFF;GraduallyChangingColorEnd:#FFFFFFFF;vectorX:0;vectorY:0",
											DesignHeight = "640",
											DesignType = "0",
											DesignWidth = "960",
											dstBlendFunc = "771",
											height = "10",
											ignoreSize = "False",
											name = "Panel_point21",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 2622,
												PositionY = 309,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "10",
											ZOrder = "1",
										},
										{
											controlID = "Panel_point22_Panel_points_Panel_skillMap1_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
											UUID = "c378a1f2_6d05_47c1_aa16_b1b2f5626635",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											bgColorOpacity = "50",
											bIsOpenClipping = "False",
											classname = "MEPanel",
											colorType = "1;SingleColor:#FFFF0000;GraduallyChangingColorStart:#FFFFFFFF;GraduallyChangingColorEnd:#FFFFFFFF;vectorX:0;vectorY:0",
											DesignHeight = "640",
											DesignType = "0",
											DesignWidth = "960",
											dstBlendFunc = "771",
											height = "10",
											ignoreSize = "False",
											name = "Panel_point22",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 2746,
												PositionY = 208,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "10",
											ZOrder = "1",
										},
										{
											controlID = "Panel_point23_Panel_points_Panel_skillMap1_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
											UUID = "f125a766_1f59_497e_bf65_565b016bc9f4",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											bgColorOpacity = "50",
											bIsOpenClipping = "False",
											classname = "MEPanel",
											colorType = "1;SingleColor:#FFFF0000;GraduallyChangingColorStart:#FFFFFFFF;GraduallyChangingColorEnd:#FFFFFFFF;vectorX:0;vectorY:0",
											DesignHeight = "640",
											DesignType = "0",
											DesignWidth = "960",
											dstBlendFunc = "771",
											height = "10",
											ignoreSize = "False",
											name = "Panel_point23",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 2877,
												PositionY = 208,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "10",
											ZOrder = "1",
										},
										{
											controlID = "Panel_point24_Panel_points_Panel_skillMap1_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
											UUID = "b591f45e_2fda_4e24_8417_0b58c759f69a",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											bgColorOpacity = "50",
											bIsOpenClipping = "False",
											classname = "MEPanel",
											colorType = "1;SingleColor:#FFFF0000;GraduallyChangingColorStart:#FFFFFFFF;GraduallyChangingColorEnd:#FFFFFFFF;vectorX:0;vectorY:0",
											DesignHeight = "640",
											DesignType = "0",
											DesignWidth = "960",
											dstBlendFunc = "771",
											height = "10",
											ignoreSize = "False",
											name = "Panel_point24",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 2999,
												PositionY = 107,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "10",
											ZOrder = "1",
										},
										{
											controlID = "Panel_point25_Panel_points_Panel_skillMap1_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
											UUID = "7897b69b_c744_4d6a_ad03_d806ab7f913e",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											bgColorOpacity = "50",
											bIsOpenClipping = "False",
											classname = "MEPanel",
											colorType = "1;SingleColor:#FFFF0000;GraduallyChangingColorStart:#FFFFFFFF;GraduallyChangingColorEnd:#FFFFFFFF;vectorX:0;vectorY:0",
											DesignHeight = "640",
											DesignType = "0",
											DesignWidth = "960",
											dstBlendFunc = "771",
											height = "10",
											ignoreSize = "False",
											name = "Panel_point25",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 3122,
												PositionY = 209,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "10",
											ZOrder = "1",
										},
										{
											controlID = "Panel_point26_Panel_points_Panel_skillMap1_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
											UUID = "2dd9fadc_0d4c_48c2_a415_c8a55a8732cb",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											bgColorOpacity = "50",
											bIsOpenClipping = "False",
											classname = "MEPanel",
											colorType = "1;SingleColor:#FFFF0000;GraduallyChangingColorStart:#FFFFFFFF;GraduallyChangingColorEnd:#FFFFFFFF;vectorX:0;vectorY:0",
											DesignHeight = "640",
											DesignType = "0",
											DesignWidth = "960",
											dstBlendFunc = "771",
											height = "10",
											ignoreSize = "False",
											name = "Panel_point26",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 3252,
												PositionY = 208,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "10",
											ZOrder = "1",
										},
										{
											controlID = "Panel_point27_Panel_points_Panel_skillMap1_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
											UUID = "1ef587ec_6b45_4b72_a4dc_7f1029074d55",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											bgColorOpacity = "50",
											bIsOpenClipping = "False",
											classname = "MEPanel",
											colorType = "1;SingleColor:#FFFF0000;GraduallyChangingColorStart:#FFFFFFFF;GraduallyChangingColorEnd:#FFFFFFFF;vectorX:0;vectorY:0",
											DesignHeight = "640",
											DesignType = "0",
											DesignWidth = "960",
											dstBlendFunc = "771",
											height = "10",
											ignoreSize = "False",
											name = "Panel_point27",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 3378,
												PositionY = 309,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "10",
											ZOrder = "1",
										},
										{
											controlID = "Panel_point28_Panel_points_Panel_skillMap1_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
											UUID = "d8ae423d_030b_46a0_a2aa_6e3df67e045b",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											bgColorOpacity = "50",
											bIsOpenClipping = "False",
											classname = "MEPanel",
											colorType = "1;SingleColor:#FFFF0000;GraduallyChangingColorStart:#FFFFFFFF;GraduallyChangingColorEnd:#FFFFFFFF;vectorX:0;vectorY:0",
											DesignHeight = "640",
											DesignType = "0",
											DesignWidth = "960",
											dstBlendFunc = "771",
											height = "10",
											ignoreSize = "False",
											name = "Panel_point28",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 3502,
												PositionY = 208,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "10",
											ZOrder = "1",
										},
										{
											controlID = "Panel_point29_Panel_points_Panel_skillMap1_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
											UUID = "66843c3b_156d_4649_90e0_9d81d6d4a446",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											bgColorOpacity = "50",
											bIsOpenClipping = "False",
											classname = "MEPanel",
											colorType = "1;SingleColor:#FFFF0000;GraduallyChangingColorStart:#FFFFFFFF;GraduallyChangingColorEnd:#FFFFFFFF;vectorX:0;vectorY:0",
											DesignHeight = "640",
											DesignType = "0",
											DesignWidth = "960",
											dstBlendFunc = "771",
											height = "10",
											ignoreSize = "False",
											name = "Panel_point29",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 3633,
												PositionY = 208,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "10",
											ZOrder = "1",
										},
										{
											controlID = "Panel_point30_Panel_points_Panel_skillMap1_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
											UUID = "ea8cdda8_4c97_4c78_b6ac_197558e456e9",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											bgColorOpacity = "50",
											bIsOpenClipping = "False",
											classname = "MEPanel",
											colorType = "1;SingleColor:#FFFF0000;GraduallyChangingColorStart:#FFFFFFFF;GraduallyChangingColorEnd:#FFFFFFFF;vectorX:0;vectorY:0",
											DesignHeight = "640",
											DesignType = "0",
											DesignWidth = "960",
											dstBlendFunc = "771",
											height = "10",
											ignoreSize = "False",
											name = "Panel_point30",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 3755,
												PositionY = 107,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "10",
											ZOrder = "1",
										},
									},
								},
								{
									controlID = "Panel_lines_Panel_skillMap1_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
									UUID = "c007d659_1a79_4e06_9fb1_7a1fe39e58c0",
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
									name = "Panel_lines",
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
									width = "400",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "Panel_line1_Panel_lines_Panel_skillMap1_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
											UUID = "fb9e8542_7f01_44ee_8602_b8daaf7ae341",
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
											height = "10",
											ignoreSize = "False",
											name = "Panel_line1",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 135,
												PositionY = 206,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "10",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "Panel_dark_Panel_line1_Panel_lines_Panel_skillMap1_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
													UUID = "1275dede_6481_402f_a178_9486d8c437d3",
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
													height = "10",
													ignoreSize = "False",
													name = "Panel_dark",
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
													width = "10",
													ZOrder = "1",
													components = 
													{
														
														{
															controlID = "Image_line1_Panel_dark_Panel_line1_Panel_lines_Panel_skillMap1_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
															UUID = "071a40d1_5185_4eaf_88f8_aaff6ccd1894",
															anchorPoint = "False",
															anchorPointX = "0",
															anchorPointY = "0.5",
															backGroundScale9Enable = "True;capInsetsX:0;capInsetsY:0;capInsetsWidth:0;capInsetsHeight:0",
															classname = "MEImage",
															dstBlendFunc = "771",
															height = "28",
															ignoreSize = "False",
															name = "Image_line1",
															sizepercentx = "0",
															sizepercenty = "0",
															sizeType = "0",
															srcBlendFunc = "1",
															texturePath = "ui/explore/growup/command/skill/013.png",
															touchAble = "False",
															UILayoutViewModel = 
															{
																PositionY = 6,
															},
															width = "46",
															ZOrder = "1",
														},
													},
												},
												{
													controlID = "Panel_light_Panel_line1_Panel_lines_Panel_skillMap1_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
													UUID = "f2fd0e28_90a1_4552_8fc2_8f69fe27512d",
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
													height = "10",
													ignoreSize = "False",
													name = "Panel_light",
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
													width = "10",
													ZOrder = "1",
													components = 
													{
														
														{
															controlID = "Image_line1_Panel_light_Panel_line1_Panel_lines_Panel_skillMap1_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
															UUID = "80de5dff_7ea0_4842_98c2_e81bdff49ad8",
															anchorPoint = "False",
															anchorPointX = "0",
															anchorPointY = "0.5",
															backGroundScale9Enable = "True;capInsetsX:0;capInsetsY:0;capInsetsWidth:0;capInsetsHeight:0",
															classname = "MEImage",
															dstBlendFunc = "771",
															height = "28",
															ignoreSize = "False",
															name = "Image_line1",
															sizepercentx = "0",
															sizepercenty = "0",
															sizeType = "0",
															srcBlendFunc = "1",
															texturePath = "ui/explore/growup/command/skill/011.png",
															touchAble = "False",
															UILayoutViewModel = 
															{
																PositionY = 6,
															},
															width = "46",
															ZOrder = "1",
														},
													},
												},
											},
										},
										{
											controlID = "Panel_line2_Panel_lines_Panel_skillMap1_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
											UUID = "f7621912_1b1d_498c_8b16_cfb20ff72497",
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
											height = "10",
											ignoreSize = "False",
											name = "Panel_line2",
											rotation = "-45",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 259,
												PositionY = 226,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "10",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "Panel_dark_Panel_line2_Panel_lines_Panel_skillMap1_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
													UUID = "880f10a3_82d8_4552_a77b_4628a7865259",
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
													height = "10",
													ignoreSize = "False",
													name = "Panel_dark",
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
													width = "10",
													ZOrder = "1",
													components = 
													{
														
														{
															controlID = "Image_line1_Panel_dark_Panel_line2_Panel_lines_Panel_skillMap1_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
															UUID = "24b146aa_f168_4120_8d2b_bbc5d9537305",
															anchorPoint = "False",
															anchorPointX = "0",
															anchorPointY = "0.5",
															backGroundScale9Enable = "True;capInsetsX:0;capInsetsY:0;capInsetsWidth:0;capInsetsHeight:0",
															classname = "MEImage",
															dstBlendFunc = "771",
															height = "28",
															ignoreSize = "False",
															name = "Image_line1",
															sizepercentx = "0",
															sizepercenty = "0",
															sizeType = "0",
															srcBlendFunc = "1",
															texturePath = "ui/explore/growup/command/skill/013.png",
															touchAble = "False",
															UILayoutViewModel = 
															{
																PositionY = 6,
															},
															width = "87",
															ZOrder = "1",
														},
													},
												},
												{
													controlID = "Panel_light_Panel_line2_Panel_lines_Panel_skillMap1_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
													UUID = "ae2e19dd_6747_440d_9b83_0cd091c2d037",
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
													height = "10",
													ignoreSize = "False",
													name = "Panel_light",
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
													width = "10",
													ZOrder = "1",
													components = 
													{
														
														{
															controlID = "Image_line1_Panel_light_Panel_line2_Panel_lines_Panel_skillMap1_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
															UUID = "bee38e68_4837_430e_a5fe_1e961a56e567",
															anchorPoint = "False",
															anchorPointX = "0",
															anchorPointY = "0.5",
															backGroundScale9Enable = "True;capInsetsX:0;capInsetsY:0;capInsetsWidth:0;capInsetsHeight:0",
															classname = "MEImage",
															dstBlendFunc = "771",
															height = "28",
															ignoreSize = "False",
															name = "Image_line1",
															sizepercentx = "0",
															sizepercenty = "0",
															sizeType = "0",
															srcBlendFunc = "1",
															texturePath = "ui/explore/growup/command/skill/011.png",
															touchAble = "False",
															UILayoutViewModel = 
															{
																PositionY = 6,
															},
															width = "86",
															ZOrder = "1",
														},
													},
												},
											},
										},
										{
											controlID = "Panel_line3_Panel_lines_Panel_skillMap1_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
											UUID = "214e7619_1e96_4296_9894_0ff0dd30d8dd",
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
											height = "10",
											ignoreSize = "False",
											name = "Panel_line3",
											rotation = "45",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 377,
												PositionY = 286,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "10",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "Panel_dark_Panel_line3_Panel_lines_Panel_skillMap1_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
													UUID = "c1975da5_3418_4bdc_9966_ff11802a5219",
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
													height = "10",
													ignoreSize = "False",
													name = "Panel_dark",
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
													width = "10",
													ZOrder = "1",
													components = 
													{
														
														{
															controlID = "Image_line1_Panel_dark_Panel_line3_Panel_lines_Panel_skillMap1_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
															UUID = "38f8ab17_6e22_4c34_a812_bcd1a20fa906",
															anchorPoint = "False",
															anchorPointX = "0",
															anchorPointY = "0.5",
															backGroundScale9Enable = "True;capInsetsX:0;capInsetsY:0;capInsetsWidth:0;capInsetsHeight:0",
															classname = "MEImage",
															dstBlendFunc = "771",
															height = "28",
															ignoreSize = "False",
															name = "Image_line1",
															sizepercentx = "0",
															sizepercenty = "0",
															sizeType = "0",
															srcBlendFunc = "1",
															texturePath = "ui/explore/growup/command/skill/013.png",
															touchAble = "False",
															UILayoutViewModel = 
															{
																PositionY = 6,
															},
															width = "84",
															ZOrder = "1",
														},
													},
												},
												{
													controlID = "Panel_light_Panel_line3_Panel_lines_Panel_skillMap1_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
													UUID = "1d2efd91_44fb_412d_a57c_3c5b67f75840",
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
													height = "10",
													ignoreSize = "False",
													name = "Panel_light",
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
													width = "10",
													ZOrder = "1",
													components = 
													{
														
														{
															controlID = "Image_line1_Panel_light_Panel_line3_Panel_lines_Panel_skillMap1_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
															UUID = "bb3418e8_4ff1_4779_91e1_ef8af57753a0",
															anchorPoint = "False",
															anchorPointX = "0",
															anchorPointY = "0.5",
															backGroundScale9Enable = "True;capInsetsX:0;capInsetsY:0;capInsetsWidth:0;capInsetsHeight:0",
															classname = "MEImage",
															dstBlendFunc = "771",
															height = "28",
															ignoreSize = "False",
															name = "Image_line1",
															sizepercentx = "0",
															sizepercenty = "0",
															sizeType = "0",
															srcBlendFunc = "1",
															texturePath = "ui/explore/growup/command/skill/011.png",
															touchAble = "False",
															UILayoutViewModel = 
															{
																PositionY = 6,
															},
															width = "85",
															ZOrder = "1",
														},
													},
												},
											},
										},
										{
											controlID = "Panel_line4_Panel_lines_Panel_skillMap1_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
											UUID = "53e7af7e_b0d9_4ce4_970a_faf64f6d6acf",
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
											height = "10",
											ignoreSize = "False",
											name = "Panel_line4",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 516,
												PositionY = 206,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "10",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "Panel_dark_Panel_line4_Panel_lines_Panel_skillMap1_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
													UUID = "663b970f_21e1_492d_b7f7_e55fac4cd057",
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
													height = "10",
													ignoreSize = "False",
													name = "Panel_dark",
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
													width = "10",
													ZOrder = "1",
													components = 
													{
														
														{
															controlID = "Image_line1_Panel_dark_Panel_line4_Panel_lines_Panel_skillMap1_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
															UUID = "185591ad_cf5d_4be3_a41c_d3b1338b6833",
															anchorPoint = "False",
															anchorPointX = "0",
															anchorPointY = "0.5",
															backGroundScale9Enable = "True;capInsetsX:0;capInsetsY:0;capInsetsWidth:0;capInsetsHeight:0",
															classname = "MEImage",
															dstBlendFunc = "771",
															height = "28",
															ignoreSize = "False",
															name = "Image_line1",
															sizepercentx = "0",
															sizepercenty = "0",
															sizeType = "0",
															srcBlendFunc = "1",
															texturePath = "ui/explore/growup/command/skill/013.png",
															touchAble = "False",
															UILayoutViewModel = 
															{
																PositionY = 6,
															},
															width = "46",
															ZOrder = "1",
														},
													},
												},
												{
													controlID = "Panel_light_Panel_line4_Panel_lines_Panel_skillMap1_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
													UUID = "71bed306_3fb3_46ee_b1f1_499874b6db92",
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
													height = "10",
													ignoreSize = "False",
													name = "Panel_light",
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
													width = "10",
													ZOrder = "1",
													components = 
													{
														
														{
															controlID = "Image_line1_Panel_light_Panel_line4_Panel_lines_Panel_skillMap1_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
															UUID = "5c65417f_f9d1_4c33_91f1_526b07384f9d",
															anchorPoint = "False",
															anchorPointX = "0",
															anchorPointY = "0.5",
															backGroundScale9Enable = "True;capInsetsX:0;capInsetsY:0;capInsetsWidth:0;capInsetsHeight:0",
															classname = "MEImage",
															dstBlendFunc = "771",
															height = "28",
															ignoreSize = "False",
															name = "Image_line1",
															sizepercentx = "0",
															sizepercenty = "0",
															sizeType = "0",
															srcBlendFunc = "1",
															texturePath = "ui/explore/growup/command/skill/011.png",
															touchAble = "False",
															UILayoutViewModel = 
															{
																PositionY = 6,
															},
															width = "46",
															ZOrder = "1",
														},
													},
												},
											},
										},
										{
											controlID = "Panel_line5_Panel_lines_Panel_skillMap1_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
											UUID = "ee1517f7_2b19_4442_bed6_d1f2a51c5bbe",
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
											height = "10",
											ignoreSize = "False",
											name = "Panel_line5",
											rotation = "45",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 632,
												PositionY = 185,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "10",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "Panel_dark_Panel_line5_Panel_lines_Panel_skillMap1_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
													UUID = "f07a7093_4f4c_42de_aff5_06957bafea72",
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
													height = "10",
													ignoreSize = "False",
													name = "Panel_dark",
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
													width = "10",
													ZOrder = "1",
													components = 
													{
														
														{
															controlID = "Image_line1_Panel_dark_Panel_line5_Panel_lines_Panel_skillMap1_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
															UUID = "70c92bf3_1542_46ac_8d07_b572cf6bf888",
															anchorPoint = "False",
															anchorPointX = "0",
															anchorPointY = "0.5",
															backGroundScale9Enable = "True;capInsetsX:0;capInsetsY:0;capInsetsWidth:0;capInsetsHeight:0",
															classname = "MEImage",
															dstBlendFunc = "771",
															height = "28",
															ignoreSize = "False",
															name = "Image_line1",
															sizepercentx = "0",
															sizepercenty = "0",
															sizeType = "0",
															srcBlendFunc = "1",
															texturePath = "ui/explore/growup/command/skill/013.png",
															touchAble = "False",
															UILayoutViewModel = 
															{
																PositionY = 6,
															},
															width = "84",
															ZOrder = "1",
														},
													},
												},
												{
													controlID = "Panel_light_Panel_line5_Panel_lines_Panel_skillMap1_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
													UUID = "643c64c2_c946_49a2_83bf_7276aeaccc8c",
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
													height = "10",
													ignoreSize = "False",
													name = "Panel_light",
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
													width = "10",
													ZOrder = "1",
													components = 
													{
														
														{
															controlID = "Image_line1_Panel_light_Panel_line5_Panel_lines_Panel_skillMap1_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
															UUID = "d717b1fc_ee9d_4b13_977b_cde5413c9528",
															anchorPoint = "False",
															anchorPointX = "0",
															anchorPointY = "0.5",
															backGroundScale9Enable = "True;capInsetsX:0;capInsetsY:0;capInsetsWidth:0;capInsetsHeight:0",
															classname = "MEImage",
															dstBlendFunc = "771",
															height = "28",
															ignoreSize = "False",
															name = "Image_line1",
															sizepercentx = "0",
															sizepercenty = "0",
															sizeType = "0",
															srcBlendFunc = "1",
															texturePath = "ui/explore/growup/command/skill/011.png",
															touchAble = "False",
															UILayoutViewModel = 
															{
																PositionY = 6,
															},
															width = "85",
															ZOrder = "1",
														},
													},
												},
											},
										},
										{
											controlID = "Panel_line6_Panel_lines_Panel_skillMap1_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
											UUID = "a870a701_9fd5_48bc_9e1f_6a8d77bbb1db",
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
											height = "10",
											ignoreSize = "False",
											name = "Panel_line6",
											rotation = "-45",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 761,
												PositionY = 124,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "10",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "Panel_dark_Panel_line6_Panel_lines_Panel_skillMap1_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
													UUID = "63604da7_af6b_4689_8152_56496b4ee80a",
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
													height = "10",
													ignoreSize = "False",
													name = "Panel_dark",
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
													width = "10",
													ZOrder = "1",
													components = 
													{
														
														{
															controlID = "Image_line1_Panel_dark_Panel_line6_Panel_lines_Panel_skillMap1_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
															UUID = "ab6cf9ce_65f6_48c6_bd31_c0a5d0d77d6b",
															anchorPoint = "False",
															anchorPointX = "0",
															anchorPointY = "0.5",
															backGroundScale9Enable = "True;capInsetsX:0;capInsetsY:0;capInsetsWidth:0;capInsetsHeight:0",
															classname = "MEImage",
															dstBlendFunc = "771",
															height = "28",
															ignoreSize = "False",
															name = "Image_line1",
															sizepercentx = "0",
															sizepercenty = "0",
															sizeType = "0",
															srcBlendFunc = "1",
															texturePath = "ui/explore/growup/command/skill/013.png",
															touchAble = "False",
															UILayoutViewModel = 
															{
																PositionY = 6,
															},
															width = "87",
															ZOrder = "1",
														},
													},
												},
												{
													controlID = "Panel_light_Panel_line6_Panel_lines_Panel_skillMap1_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
													UUID = "29df47b2_3a42_4699_9f33_137a07d49df2",
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
													height = "10",
													ignoreSize = "False",
													name = "Panel_light",
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
													width = "10",
													ZOrder = "1",
													components = 
													{
														
														{
															controlID = "Image_line1_Panel_light_Panel_line6_Panel_lines_Panel_skillMap1_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
															UUID = "6bfdd95b_53da_4d27_a2d7_c8e1b05fde67",
															anchorPoint = "False",
															anchorPointX = "0",
															anchorPointY = "0.5",
															backGroundScale9Enable = "True;capInsetsX:0;capInsetsY:0;capInsetsWidth:0;capInsetsHeight:0",
															classname = "MEImage",
															dstBlendFunc = "771",
															height = "28",
															ignoreSize = "False",
															name = "Image_line1",
															sizepercentx = "0",
															sizepercenty = "0",
															sizeType = "0",
															srcBlendFunc = "1",
															texturePath = "ui/explore/growup/command/skill/011.png",
															touchAble = "False",
															UILayoutViewModel = 
															{
																PositionY = 6,
															},
															width = "86",
															ZOrder = "1",
														},
													},
												},
											},
										},
										{
											controlID = "Panel_line7_Panel_lines_Panel_skillMap1_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
											UUID = "e555f875_6e8d_4889_9cfd_e89f2f24b17c",
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
											height = "10",
											ignoreSize = "False",
											name = "Panel_line7",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 893,
												PositionY = 206,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "10",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "Panel_dark_Panel_line7_Panel_lines_Panel_skillMap1_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
													UUID = "14623319_de35_47df_85c2_834b15de7cfe",
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
													height = "10",
													ignoreSize = "False",
													name = "Panel_dark",
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
													width = "10",
													ZOrder = "1",
													components = 
													{
														
														{
															controlID = "Image_line1_Panel_dark_Panel_line7_Panel_lines_Panel_skillMap1_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
															UUID = "e0ba6e08_3134_454e_ab60_26984044c445",
															anchorPoint = "False",
															anchorPointX = "0",
															anchorPointY = "0.5",
															backGroundScale9Enable = "True;capInsetsX:0;capInsetsY:0;capInsetsWidth:0;capInsetsHeight:0",
															classname = "MEImage",
															dstBlendFunc = "771",
															height = "28",
															ignoreSize = "False",
															name = "Image_line1",
															sizepercentx = "0",
															sizepercenty = "0",
															sizeType = "0",
															srcBlendFunc = "1",
															texturePath = "ui/explore/growup/command/skill/013.png",
															touchAble = "False",
															UILayoutViewModel = 
															{
																PositionY = 6,
															},
															width = "46",
															ZOrder = "1",
														},
													},
												},
												{
													controlID = "Panel_light_Panel_line7_Panel_lines_Panel_skillMap1_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
													UUID = "19eabf9b_f488_440b_bbd8_05cf2e3e6819",
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
													height = "10",
													ignoreSize = "False",
													name = "Panel_light",
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
													width = "10",
													ZOrder = "1",
													components = 
													{
														
														{
															controlID = "Image_line1_Panel_light_Panel_line7_Panel_lines_Panel_skillMap1_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
															UUID = "730c2ad3_fd2b_4f02_b703_14ac70203c8b",
															anchorPoint = "False",
															anchorPointX = "0",
															anchorPointY = "0.5",
															backGroundScale9Enable = "True;capInsetsX:0;capInsetsY:0;capInsetsWidth:0;capInsetsHeight:0",
															classname = "MEImage",
															dstBlendFunc = "771",
															height = "28",
															ignoreSize = "False",
															name = "Image_line1",
															sizepercentx = "0",
															sizepercenty = "0",
															sizeType = "0",
															srcBlendFunc = "1",
															texturePath = "ui/explore/growup/command/skill/011.png",
															touchAble = "False",
															UILayoutViewModel = 
															{
																PositionY = 6,
															},
															width = "46",
															ZOrder = "1",
														},
													},
												},
											},
										},
										{
											controlID = "Panel_line8_Panel_lines_Panel_skillMap1_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
											UUID = "e4327770_fbe3_4757_ba50_17f544a5eba2",
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
											height = "10",
											ignoreSize = "False",
											name = "Panel_line8",
											rotation = "-45",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 1017,
												PositionY = 226,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "10",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "Panel_dark_Panel_line8_Panel_lines_Panel_skillMap1_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
													UUID = "6fdef093_a232_420e_bfc9_34113a35121a",
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
													height = "10",
													ignoreSize = "False",
													name = "Panel_dark",
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
													width = "10",
													ZOrder = "1",
													components = 
													{
														
														{
															controlID = "Image_line1_Panel_dark_Panel_line8_Panel_lines_Panel_skillMap1_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
															UUID = "3834f52f_bc3b_4a01_b8b5_177c00914a76",
															anchorPoint = "False",
															anchorPointX = "0",
															anchorPointY = "0.5",
															backGroundScale9Enable = "True;capInsetsX:0;capInsetsY:0;capInsetsWidth:0;capInsetsHeight:0",
															classname = "MEImage",
															dstBlendFunc = "771",
															height = "28",
															ignoreSize = "False",
															name = "Image_line1",
															sizepercentx = "0",
															sizepercenty = "0",
															sizeType = "0",
															srcBlendFunc = "1",
															texturePath = "ui/explore/growup/command/skill/013.png",
															touchAble = "False",
															UILayoutViewModel = 
															{
																PositionY = 6,
															},
															width = "87",
															ZOrder = "1",
														},
													},
												},
												{
													controlID = "Panel_light_Panel_line8_Panel_lines_Panel_skillMap1_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
													UUID = "1ec00db7_e2cb_4af1_960f_ef4d16451eed",
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
													height = "10",
													ignoreSize = "False",
													name = "Panel_light",
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
													width = "10",
													ZOrder = "1",
													components = 
													{
														
														{
															controlID = "Image_line1_Panel_light_Panel_line8_Panel_lines_Panel_skillMap1_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
															UUID = "a5e2eaee_e580_4dfe_859f_a6fdcee44fe4",
															anchorPoint = "False",
															anchorPointX = "0",
															anchorPointY = "0.5",
															backGroundScale9Enable = "True;capInsetsX:0;capInsetsY:0;capInsetsWidth:0;capInsetsHeight:0",
															classname = "MEImage",
															dstBlendFunc = "771",
															height = "28",
															ignoreSize = "False",
															name = "Image_line1",
															sizepercentx = "0",
															sizepercenty = "0",
															sizeType = "0",
															srcBlendFunc = "1",
															texturePath = "ui/explore/growup/command/skill/011.png",
															touchAble = "False",
															UILayoutViewModel = 
															{
																PositionY = 6,
															},
															width = "86",
															ZOrder = "1",
														},
													},
												},
											},
										},
										{
											controlID = "Panel_line9_Panel_lines_Panel_skillMap1_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
											UUID = "e1a4935c_d57c_43a9_8efd_6cf492092c24",
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
											height = "10",
											ignoreSize = "False",
											name = "Panel_line9",
											rotation = "45",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 1135,
												PositionY = 286,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "10",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "Panel_dark_Panel_line9_Panel_lines_Panel_skillMap1_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
													UUID = "fb9d444f_194f_46ce_9d59_55fc9c49def7",
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
													height = "10",
													ignoreSize = "False",
													name = "Panel_dark",
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
													width = "10",
													ZOrder = "1",
													components = 
													{
														
														{
															controlID = "Image_line1_Panel_dark_Panel_line9_Panel_lines_Panel_skillMap1_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
															UUID = "1ad355d4_01a2_4dad_ba40_75583341ca4b",
															anchorPoint = "False",
															anchorPointX = "0",
															anchorPointY = "0.5",
															backGroundScale9Enable = "True;capInsetsX:0;capInsetsY:0;capInsetsWidth:0;capInsetsHeight:0",
															classname = "MEImage",
															dstBlendFunc = "771",
															height = "28",
															ignoreSize = "False",
															name = "Image_line1",
															sizepercentx = "0",
															sizepercenty = "0",
															sizeType = "0",
															srcBlendFunc = "1",
															texturePath = "ui/explore/growup/command/skill/013.png",
															touchAble = "False",
															UILayoutViewModel = 
															{
																PositionY = 6,
															},
															width = "84",
															ZOrder = "1",
														},
													},
												},
												{
													controlID = "Panel_light_Panel_line9_Panel_lines_Panel_skillMap1_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
													UUID = "e0d58212_fac4_45b9_891c_491649474d87",
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
													height = "10",
													ignoreSize = "False",
													name = "Panel_light",
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
													width = "10",
													ZOrder = "1",
													components = 
													{
														
														{
															controlID = "Image_line1_Panel_light_Panel_line9_Panel_lines_Panel_skillMap1_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
															UUID = "3acd8f98_2bad_4dca_8213_92a69dd10ddb",
															anchorPoint = "False",
															anchorPointX = "0",
															anchorPointY = "0.5",
															backGroundScale9Enable = "True;capInsetsX:0;capInsetsY:0;capInsetsWidth:0;capInsetsHeight:0",
															classname = "MEImage",
															dstBlendFunc = "771",
															height = "28",
															ignoreSize = "False",
															name = "Image_line1",
															sizepercentx = "0",
															sizepercenty = "0",
															sizeType = "0",
															srcBlendFunc = "1",
															texturePath = "ui/explore/growup/command/skill/011.png",
															touchAble = "False",
															UILayoutViewModel = 
															{
																PositionY = 6,
															},
															width = "85",
															ZOrder = "1",
														},
													},
												},
											},
										},
										{
											controlID = "Panel_line10_Panel_lines_Panel_skillMap1_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
											UUID = "7b68b761_1b66_4af3_8ec6_bc8fe4f2531b",
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
											height = "10",
											ignoreSize = "False",
											name = "Panel_line10",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 1274,
												PositionY = 206,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "10",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "Panel_dark_Panel_line10_Panel_lines_Panel_skillMap1_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
													UUID = "58531183_bf47_4e1c_8a96_5b989c79c0ed",
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
													height = "10",
													ignoreSize = "False",
													name = "Panel_dark",
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
													width = "10",
													ZOrder = "1",
													components = 
													{
														
														{
															controlID = "Image_line1_Panel_dark_Panel_line10_Panel_lines_Panel_skillMap1_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
															UUID = "d43f0075_fb27_41fc_a800_a79f03e4a821",
															anchorPoint = "False",
															anchorPointX = "0",
															anchorPointY = "0.5",
															backGroundScale9Enable = "True;capInsetsX:0;capInsetsY:0;capInsetsWidth:0;capInsetsHeight:0",
															classname = "MEImage",
															dstBlendFunc = "771",
															height = "28",
															ignoreSize = "False",
															name = "Image_line1",
															sizepercentx = "0",
															sizepercenty = "0",
															sizeType = "0",
															srcBlendFunc = "1",
															texturePath = "ui/explore/growup/command/skill/013.png",
															touchAble = "False",
															UILayoutViewModel = 
															{
																PositionY = 6,
															},
															width = "46",
															ZOrder = "1",
														},
													},
												},
												{
													controlID = "Panel_light_Panel_line10_Panel_lines_Panel_skillMap1_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
													UUID = "e4a9b1b8_69c2_4a48_a719_c8023f476b7e",
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
													height = "10",
													ignoreSize = "False",
													name = "Panel_light",
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
													width = "10",
													ZOrder = "1",
													components = 
													{
														
														{
															controlID = "Image_line1_Panel_light_Panel_line10_Panel_lines_Panel_skillMap1_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
															UUID = "3e1b2a57_3da3_45d3_84c3_a989efe56910",
															anchorPoint = "False",
															anchorPointX = "0",
															anchorPointY = "0.5",
															backGroundScale9Enable = "True;capInsetsX:0;capInsetsY:0;capInsetsWidth:0;capInsetsHeight:0",
															classname = "MEImage",
															dstBlendFunc = "771",
															height = "28",
															ignoreSize = "False",
															name = "Image_line1",
															sizepercentx = "0",
															sizepercenty = "0",
															sizeType = "0",
															srcBlendFunc = "1",
															texturePath = "ui/explore/growup/command/skill/011.png",
															touchAble = "False",
															UILayoutViewModel = 
															{
																PositionY = 6,
															},
															width = "46",
															ZOrder = "1",
														},
													},
												},
											},
										},
										{
											controlID = "Panel_line11_Panel_lines_Panel_skillMap1_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
											UUID = "8b2a6a82_a1b6_461a_bb0d_4f5b5c366139",
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
											height = "10",
											ignoreSize = "False",
											name = "Panel_line11",
											rotation = "45",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 1390,
												PositionY = 185,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "10",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "Panel_dark_Panel_line11_Panel_lines_Panel_skillMap1_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
													UUID = "b385f6d1_a449_49a3_b087_5166901651eb",
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
													height = "10",
													ignoreSize = "False",
													name = "Panel_dark",
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
													width = "10",
													ZOrder = "1",
													components = 
													{
														
														{
															controlID = "Image_line1_Panel_dark_Panel_line11_Panel_lines_Panel_skillMap1_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
															UUID = "203dd047_1ba0_4c8c_8ef9_5ba67cd8cf7f",
															anchorPoint = "False",
															anchorPointX = "0",
															anchorPointY = "0.5",
															backGroundScale9Enable = "True;capInsetsX:0;capInsetsY:0;capInsetsWidth:0;capInsetsHeight:0",
															classname = "MEImage",
															dstBlendFunc = "771",
															height = "28",
															ignoreSize = "False",
															name = "Image_line1",
															sizepercentx = "0",
															sizepercenty = "0",
															sizeType = "0",
															srcBlendFunc = "1",
															texturePath = "ui/explore/growup/command/skill/013.png",
															touchAble = "False",
															UILayoutViewModel = 
															{
																PositionY = 6,
															},
															width = "84",
															ZOrder = "1",
														},
													},
												},
												{
													controlID = "Panel_light_Panel_line11_Panel_lines_Panel_skillMap1_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
													UUID = "f747211b_298e_4f64_bb16_b0a5ecf25ec4",
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
													height = "10",
													ignoreSize = "False",
													name = "Panel_light",
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
													width = "10",
													ZOrder = "1",
													components = 
													{
														
														{
															controlID = "Image_line1_Panel_light_Panel_line11_Panel_lines_Panel_skillMap1_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
															UUID = "4734fafa_014f_434d_9ccc_a89e2765a288",
															anchorPoint = "False",
															anchorPointX = "0",
															anchorPointY = "0.5",
															backGroundScale9Enable = "True;capInsetsX:0;capInsetsY:0;capInsetsWidth:0;capInsetsHeight:0",
															classname = "MEImage",
															dstBlendFunc = "771",
															height = "28",
															ignoreSize = "False",
															name = "Image_line1",
															sizepercentx = "0",
															sizepercenty = "0",
															sizeType = "0",
															srcBlendFunc = "1",
															texturePath = "ui/explore/growup/command/skill/011.png",
															touchAble = "False",
															UILayoutViewModel = 
															{
																PositionY = 6,
															},
															width = "85",
															ZOrder = "1",
														},
													},
												},
											},
										},
										{
											controlID = "Panel_line12_Panel_lines_Panel_skillMap1_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
											UUID = "4b75443a_c310_4e51_b1e2_6de6ac106e12",
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
											height = "10",
											ignoreSize = "False",
											name = "Panel_line12",
											rotation = "-45",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 1519,
												PositionY = 124,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "10",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "Panel_dark_Panel_line12_Panel_lines_Panel_skillMap1_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
													UUID = "7a2506aa_ae09_42c9_b912_9f535545dc5a",
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
													height = "10",
													ignoreSize = "False",
													name = "Panel_dark",
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
													width = "10",
													ZOrder = "1",
													components = 
													{
														
														{
															controlID = "Image_line1_Panel_dark_Panel_line12_Panel_lines_Panel_skillMap1_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
															UUID = "297cec51_8175_411b_b87f_6c0d312155af",
															anchorPoint = "False",
															anchorPointX = "0",
															anchorPointY = "0.5",
															backGroundScale9Enable = "True;capInsetsX:0;capInsetsY:0;capInsetsWidth:0;capInsetsHeight:0",
															classname = "MEImage",
															dstBlendFunc = "771",
															height = "28",
															ignoreSize = "False",
															name = "Image_line1",
															sizepercentx = "0",
															sizepercenty = "0",
															sizeType = "0",
															srcBlendFunc = "1",
															texturePath = "ui/explore/growup/command/skill/013.png",
															touchAble = "False",
															UILayoutViewModel = 
															{
																PositionY = 6,
															},
															width = "87",
															ZOrder = "1",
														},
													},
												},
												{
													controlID = "Panel_light_Panel_line12_Panel_lines_Panel_skillMap1_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
													UUID = "600c004c_0b0b_4886_b8db_d4986b7a634d",
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
													height = "10",
													ignoreSize = "False",
													name = "Panel_light",
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
													width = "10",
													ZOrder = "1",
													components = 
													{
														
														{
															controlID = "Image_line1_Panel_light_Panel_line12_Panel_lines_Panel_skillMap1_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
															UUID = "984827e6_4adc_4649_a7a2_31c99ec1846d",
															anchorPoint = "False",
															anchorPointX = "0",
															anchorPointY = "0.5",
															backGroundScale9Enable = "True;capInsetsX:0;capInsetsY:0;capInsetsWidth:0;capInsetsHeight:0",
															classname = "MEImage",
															dstBlendFunc = "771",
															height = "28",
															ignoreSize = "False",
															name = "Image_line1",
															sizepercentx = "0",
															sizepercenty = "0",
															sizeType = "0",
															srcBlendFunc = "1",
															texturePath = "ui/explore/growup/command/skill/011.png",
															touchAble = "False",
															UILayoutViewModel = 
															{
																PositionY = 6,
															},
															width = "86",
															ZOrder = "1",
														},
													},
												},
											},
										},
										{
											controlID = "Panel_line13_Panel_lines_Panel_skillMap1_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
											UUID = "9892d39d_e10c_4d3c_865b_2a473f793e89",
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
											height = "10",
											ignoreSize = "False",
											name = "Panel_line13",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 1651,
												PositionY = 206,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "10",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "Panel_dark_Panel_line13_Panel_lines_Panel_skillMap1_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
													UUID = "7ccc0a67_a992_49ac_9dd8_cca92166bd7e",
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
													height = "10",
													ignoreSize = "False",
													name = "Panel_dark",
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
													width = "10",
													ZOrder = "1",
													components = 
													{
														
														{
															controlID = "Image_line1_Panel_dark_Panel_line13_Panel_lines_Panel_skillMap1_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
															UUID = "35ba3ef5_5b3f_434b_bed3_e0dccad6d7af",
															anchorPoint = "False",
															anchorPointX = "0",
															anchorPointY = "0.5",
															backGroundScale9Enable = "True;capInsetsX:0;capInsetsY:0;capInsetsWidth:0;capInsetsHeight:0",
															classname = "MEImage",
															dstBlendFunc = "771",
															height = "28",
															ignoreSize = "False",
															name = "Image_line1",
															sizepercentx = "0",
															sizepercenty = "0",
															sizeType = "0",
															srcBlendFunc = "1",
															texturePath = "ui/explore/growup/command/skill/013.png",
															touchAble = "False",
															UILayoutViewModel = 
															{
																PositionY = 6,
															},
															width = "46",
															ZOrder = "1",
														},
													},
												},
												{
													controlID = "Panel_light_Panel_line13_Panel_lines_Panel_skillMap1_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
													UUID = "8aa2c4f9_5ef7_46fa_b658_2afbbfb585fc",
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
													height = "10",
													ignoreSize = "False",
													name = "Panel_light",
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
													width = "10",
													ZOrder = "1",
													components = 
													{
														
														{
															controlID = "Image_line1_Panel_light_Panel_line13_Panel_lines_Panel_skillMap1_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
															UUID = "30922144_ac23_4f56_bd91_ac392c21d0d2",
															anchorPoint = "False",
															anchorPointX = "0",
															anchorPointY = "0.5",
															backGroundScale9Enable = "True;capInsetsX:0;capInsetsY:0;capInsetsWidth:0;capInsetsHeight:0",
															classname = "MEImage",
															dstBlendFunc = "771",
															height = "28",
															ignoreSize = "False",
															name = "Image_line1",
															sizepercentx = "0",
															sizepercenty = "0",
															sizeType = "0",
															srcBlendFunc = "1",
															texturePath = "ui/explore/growup/command/skill/011.png",
															touchAble = "False",
															UILayoutViewModel = 
															{
																PositionY = 6,
															},
															width = "46",
															ZOrder = "1",
														},
													},
												},
											},
										},
										{
											controlID = "Panel_line14_Panel_lines_Panel_skillMap1_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
											UUID = "4bfce919_9302_4ed8_b389_50d67999967d",
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
											height = "10",
											ignoreSize = "False",
											name = "Panel_line14",
											rotation = "-45",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 1775,
												PositionY = 226,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "10",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "Panel_dark_Panel_line14_Panel_lines_Panel_skillMap1_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
													UUID = "9e7245a5_6a20_4090_9647_66d0f5a94383",
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
													height = "10",
													ignoreSize = "False",
													name = "Panel_dark",
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
													width = "10",
													ZOrder = "1",
													components = 
													{
														
														{
															controlID = "Image_line1_Panel_dark_Panel_line14_Panel_lines_Panel_skillMap1_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
															UUID = "c2d6e19f_5088_4c34_99ed_24068bbab760",
															anchorPoint = "False",
															anchorPointX = "0",
															anchorPointY = "0.5",
															backGroundScale9Enable = "True;capInsetsX:0;capInsetsY:0;capInsetsWidth:0;capInsetsHeight:0",
															classname = "MEImage",
															dstBlendFunc = "771",
															height = "28",
															ignoreSize = "False",
															name = "Image_line1",
															sizepercentx = "0",
															sizepercenty = "0",
															sizeType = "0",
															srcBlendFunc = "1",
															texturePath = "ui/explore/growup/command/skill/013.png",
															touchAble = "False",
															UILayoutViewModel = 
															{
																PositionY = 6,
															},
															width = "87",
															ZOrder = "1",
														},
													},
												},
												{
													controlID = "Panel_light_Panel_line14_Panel_lines_Panel_skillMap1_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
													UUID = "21b3bd51_ad11_4f68_acb2_25e92bd20382",
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
													height = "10",
													ignoreSize = "False",
													name = "Panel_light",
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
													width = "10",
													ZOrder = "1",
													components = 
													{
														
														{
															controlID = "Image_line1_Panel_light_Panel_line14_Panel_lines_Panel_skillMap1_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
															UUID = "2d346569_6f12_42ac_bdc7_165e765e505a",
															anchorPoint = "False",
															anchorPointX = "0",
															anchorPointY = "0.5",
															backGroundScale9Enable = "True;capInsetsX:0;capInsetsY:0;capInsetsWidth:0;capInsetsHeight:0",
															classname = "MEImage",
															dstBlendFunc = "771",
															height = "28",
															ignoreSize = "False",
															name = "Image_line1",
															sizepercentx = "0",
															sizepercenty = "0",
															sizeType = "0",
															srcBlendFunc = "1",
															texturePath = "ui/explore/growup/command/skill/011.png",
															touchAble = "False",
															UILayoutViewModel = 
															{
																PositionY = 6,
															},
															width = "86",
															ZOrder = "1",
														},
													},
												},
											},
										},
										{
											controlID = "Panel_line15_Panel_lines_Panel_skillMap1_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
											UUID = "b41a2977_1562_41f2_a74a_d4838085c2b9",
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
											height = "10",
											ignoreSize = "False",
											name = "Panel_line15",
											rotation = "45",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 1893,
												PositionY = 286,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "10",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "Panel_dark_Panel_line15_Panel_lines_Panel_skillMap1_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
													UUID = "8fd28f3b_6683_46db_89c5_25281d80586a",
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
													height = "10",
													ignoreSize = "False",
													name = "Panel_dark",
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
													width = "10",
													ZOrder = "1",
													components = 
													{
														
														{
															controlID = "Image_line1_Panel_dark_Panel_line15_Panel_lines_Panel_skillMap1_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
															UUID = "feea8573_079b_4fd1_b054_02fcac2b9979",
															anchorPoint = "False",
															anchorPointX = "0",
															anchorPointY = "0.5",
															backGroundScale9Enable = "True;capInsetsX:0;capInsetsY:0;capInsetsWidth:0;capInsetsHeight:0",
															classname = "MEImage",
															dstBlendFunc = "771",
															height = "28",
															ignoreSize = "False",
															name = "Image_line1",
															sizepercentx = "0",
															sizepercenty = "0",
															sizeType = "0",
															srcBlendFunc = "1",
															texturePath = "ui/explore/growup/command/skill/013.png",
															touchAble = "False",
															UILayoutViewModel = 
															{
																PositionY = 6,
															},
															width = "84",
															ZOrder = "1",
														},
													},
												},
												{
													controlID = "Panel_light_Panel_line15_Panel_lines_Panel_skillMap1_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
													UUID = "93a1365e_2e0a_49aa_83e2_cb28ec36a2d8",
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
													height = "10",
													ignoreSize = "False",
													name = "Panel_light",
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
													width = "10",
													ZOrder = "1",
													components = 
													{
														
														{
															controlID = "Image_line1_Panel_light_Panel_line15_Panel_lines_Panel_skillMap1_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
															UUID = "e544a455_c442_42a9_a807_5651788e6abc",
															anchorPoint = "False",
															anchorPointX = "0",
															anchorPointY = "0.5",
															backGroundScale9Enable = "True;capInsetsX:0;capInsetsY:0;capInsetsWidth:0;capInsetsHeight:0",
															classname = "MEImage",
															dstBlendFunc = "771",
															height = "28",
															ignoreSize = "False",
															name = "Image_line1",
															sizepercentx = "0",
															sizepercenty = "0",
															sizeType = "0",
															srcBlendFunc = "1",
															texturePath = "ui/explore/growup/command/skill/011.png",
															touchAble = "False",
															UILayoutViewModel = 
															{
																PositionY = 6,
															},
															width = "85",
															ZOrder = "1",
														},
													},
												},
											},
										},
										{
											controlID = "Panel_line16_Panel_lines_Panel_skillMap1_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
											UUID = "4261718e_7dab_415a_9918_51d9dfa4f353",
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
											height = "10",
											ignoreSize = "False",
											name = "Panel_line16",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 2032,
												PositionY = 206,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "10",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "Panel_dark_Panel_line16_Panel_lines_Panel_skillMap1_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
													UUID = "e046073f_1284_4236_a11a_57c55b2acfba",
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
													height = "10",
													ignoreSize = "False",
													name = "Panel_dark",
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
													width = "10",
													ZOrder = "1",
													components = 
													{
														
														{
															controlID = "Image_line1_Panel_dark_Panel_line16_Panel_lines_Panel_skillMap1_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
															UUID = "9b71a30b_a75b_447d_8a52_ac47c0091c22",
															anchorPoint = "False",
															anchorPointX = "0",
															anchorPointY = "0.5",
															backGroundScale9Enable = "True;capInsetsX:0;capInsetsY:0;capInsetsWidth:0;capInsetsHeight:0",
															classname = "MEImage",
															dstBlendFunc = "771",
															height = "28",
															ignoreSize = "False",
															name = "Image_line1",
															sizepercentx = "0",
															sizepercenty = "0",
															sizeType = "0",
															srcBlendFunc = "1",
															texturePath = "ui/explore/growup/command/skill/013.png",
															touchAble = "False",
															UILayoutViewModel = 
															{
																PositionY = 6,
															},
															width = "46",
															ZOrder = "1",
														},
													},
												},
												{
													controlID = "Panel_light_Panel_line16_Panel_lines_Panel_skillMap1_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
													UUID = "dbeb36a5_c72f_4480_b333_db506752cca0",
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
													height = "10",
													ignoreSize = "False",
													name = "Panel_light",
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
													width = "10",
													ZOrder = "1",
													components = 
													{
														
														{
															controlID = "Image_line1_Panel_light_Panel_line16_Panel_lines_Panel_skillMap1_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
															UUID = "05238422_d0d1_47fb_aca0_605fa1725954",
															anchorPoint = "False",
															anchorPointX = "0",
															anchorPointY = "0.5",
															backGroundScale9Enable = "True;capInsetsX:0;capInsetsY:0;capInsetsWidth:0;capInsetsHeight:0",
															classname = "MEImage",
															dstBlendFunc = "771",
															height = "28",
															ignoreSize = "False",
															name = "Image_line1",
															sizepercentx = "0",
															sizepercenty = "0",
															sizeType = "0",
															srcBlendFunc = "1",
															texturePath = "ui/explore/growup/command/skill/011.png",
															touchAble = "False",
															UILayoutViewModel = 
															{
																PositionY = 6,
															},
															width = "46",
															ZOrder = "1",
														},
													},
												},
											},
										},
										{
											controlID = "Panel_line17_Panel_lines_Panel_skillMap1_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
											UUID = "4098d42a_30d5_4209_99ec_2659354e444c",
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
											height = "10",
											ignoreSize = "False",
											name = "Panel_line17",
											rotation = "45",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 2148,
												PositionY = 185,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "10",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "Panel_dark_Panel_line17_Panel_lines_Panel_skillMap1_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
													UUID = "3ee15fdb_96a8_458a_a6f7_a965564ba387",
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
													height = "10",
													ignoreSize = "False",
													name = "Panel_dark",
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
													width = "10",
													ZOrder = "1",
													components = 
													{
														
														{
															controlID = "Image_line1_Panel_dark_Panel_line17_Panel_lines_Panel_skillMap1_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
															UUID = "b35f2c45_1a31_4489_a487_d1b70632e886",
															anchorPoint = "False",
															anchorPointX = "0",
															anchorPointY = "0.5",
															backGroundScale9Enable = "True;capInsetsX:0;capInsetsY:0;capInsetsWidth:0;capInsetsHeight:0",
															classname = "MEImage",
															dstBlendFunc = "771",
															height = "28",
															ignoreSize = "False",
															name = "Image_line1",
															sizepercentx = "0",
															sizepercenty = "0",
															sizeType = "0",
															srcBlendFunc = "1",
															texturePath = "ui/explore/growup/command/skill/013.png",
															touchAble = "False",
															UILayoutViewModel = 
															{
																PositionY = 6,
															},
															width = "84",
															ZOrder = "1",
														},
													},
												},
												{
													controlID = "Panel_light_Panel_line17_Panel_lines_Panel_skillMap1_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
													UUID = "c6a496d6_0aa9_4900_9ee7_dca38eb9b7d6",
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
													height = "10",
													ignoreSize = "False",
													name = "Panel_light",
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
													width = "10",
													ZOrder = "1",
													components = 
													{
														
														{
															controlID = "Image_line1_Panel_light_Panel_line17_Panel_lines_Panel_skillMap1_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
															UUID = "76332d9f_a4dd_4e59_bbbe_d473459b10fb",
															anchorPoint = "False",
															anchorPointX = "0",
															anchorPointY = "0.5",
															backGroundScale9Enable = "True;capInsetsX:0;capInsetsY:0;capInsetsWidth:0;capInsetsHeight:0",
															classname = "MEImage",
															dstBlendFunc = "771",
															height = "28",
															ignoreSize = "False",
															name = "Image_line1",
															sizepercentx = "0",
															sizepercenty = "0",
															sizeType = "0",
															srcBlendFunc = "1",
															texturePath = "ui/explore/growup/command/skill/011.png",
															touchAble = "False",
															UILayoutViewModel = 
															{
																PositionY = 6,
															},
															width = "85",
															ZOrder = "1",
														},
													},
												},
											},
										},
										{
											controlID = "Panel_line18_Panel_lines_Panel_skillMap1_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
											UUID = "d2df4275_fa10_4449_af14_79b5bd39464d",
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
											height = "10",
											ignoreSize = "False",
											name = "Panel_line18",
											rotation = "-45",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 2277,
												PositionY = 124,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "10",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "Panel_dark_Panel_line18_Panel_lines_Panel_skillMap1_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
													UUID = "d4b5e09e_39ef_4649_bb9a_1d0757bfbd47",
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
													height = "10",
													ignoreSize = "False",
													name = "Panel_dark",
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
													width = "10",
													ZOrder = "1",
													components = 
													{
														
														{
															controlID = "Image_line1_Panel_dark_Panel_line18_Panel_lines_Panel_skillMap1_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
															UUID = "eb17c5ae_7b32_4e5e_aca7_7624f4bda109",
															anchorPoint = "False",
															anchorPointX = "0",
															anchorPointY = "0.5",
															backGroundScale9Enable = "True;capInsetsX:0;capInsetsY:0;capInsetsWidth:0;capInsetsHeight:0",
															classname = "MEImage",
															dstBlendFunc = "771",
															height = "28",
															ignoreSize = "False",
															name = "Image_line1",
															sizepercentx = "0",
															sizepercenty = "0",
															sizeType = "0",
															srcBlendFunc = "1",
															texturePath = "ui/explore/growup/command/skill/013.png",
															touchAble = "False",
															UILayoutViewModel = 
															{
																PositionY = 6,
															},
															width = "87",
															ZOrder = "1",
														},
													},
												},
												{
													controlID = "Panel_light_Panel_line18_Panel_lines_Panel_skillMap1_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
													UUID = "bd13929e_70f7_4f85_9f74_b5011e96fb7d",
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
													height = "10",
													ignoreSize = "False",
													name = "Panel_light",
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
													width = "10",
													ZOrder = "1",
													components = 
													{
														
														{
															controlID = "Image_line1_Panel_light_Panel_line18_Panel_lines_Panel_skillMap1_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
															UUID = "36339d0c_ff62_4b2d_9ab6_be8764a3179e",
															anchorPoint = "False",
															anchorPointX = "0",
															anchorPointY = "0.5",
															backGroundScale9Enable = "True;capInsetsX:0;capInsetsY:0;capInsetsWidth:0;capInsetsHeight:0",
															classname = "MEImage",
															dstBlendFunc = "771",
															height = "28",
															ignoreSize = "False",
															name = "Image_line1",
															sizepercentx = "0",
															sizepercenty = "0",
															sizeType = "0",
															srcBlendFunc = "1",
															texturePath = "ui/explore/growup/command/skill/011.png",
															touchAble = "False",
															UILayoutViewModel = 
															{
																PositionY = 6,
															},
															width = "86",
															ZOrder = "1",
														},
													},
												},
											},
										},
										{
											controlID = "Panel_line19_Panel_lines_Panel_skillMap1_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
											UUID = "c9a29ec9_689b_437b_a8e5_aa223f806030",
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
											height = "10",
											ignoreSize = "False",
											name = "Panel_line19",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 2409,
												PositionY = 206,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "10",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "Panel_dark_Panel_line19_Panel_lines_Panel_skillMap1_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
													UUID = "d925ba0d_44c4_4ee5_885b_b94a236b5bf1",
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
													height = "10",
													ignoreSize = "False",
													name = "Panel_dark",
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
													width = "10",
													ZOrder = "1",
													components = 
													{
														
														{
															controlID = "Image_line1_Panel_dark_Panel_line19_Panel_lines_Panel_skillMap1_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
															UUID = "e3096571_561e_42e1_b6b0_b7dabbf40ed1",
															anchorPoint = "False",
															anchorPointX = "0",
															anchorPointY = "0.5",
															backGroundScale9Enable = "True;capInsetsX:0;capInsetsY:0;capInsetsWidth:0;capInsetsHeight:0",
															classname = "MEImage",
															dstBlendFunc = "771",
															height = "28",
															ignoreSize = "False",
															name = "Image_line1",
															sizepercentx = "0",
															sizepercenty = "0",
															sizeType = "0",
															srcBlendFunc = "1",
															texturePath = "ui/explore/growup/command/skill/013.png",
															touchAble = "False",
															UILayoutViewModel = 
															{
																PositionY = 6,
															},
															width = "46",
															ZOrder = "1",
														},
													},
												},
												{
													controlID = "Panel_light_Panel_line19_Panel_lines_Panel_skillMap1_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
													UUID = "dd69bb61_afb8_4c7b_8c02_7509c2d2da21",
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
													height = "10",
													ignoreSize = "False",
													name = "Panel_light",
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
													width = "10",
													ZOrder = "1",
													components = 
													{
														
														{
															controlID = "Image_line1_Panel_light_Panel_line19_Panel_lines_Panel_skillMap1_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
															UUID = "cdd342c9_237b_45f9_b6a4_3220d0c61772",
															anchorPoint = "False",
															anchorPointX = "0",
															anchorPointY = "0.5",
															backGroundScale9Enable = "True;capInsetsX:0;capInsetsY:0;capInsetsWidth:0;capInsetsHeight:0",
															classname = "MEImage",
															dstBlendFunc = "771",
															height = "28",
															ignoreSize = "False",
															name = "Image_line1",
															sizepercentx = "0",
															sizepercenty = "0",
															sizeType = "0",
															srcBlendFunc = "1",
															texturePath = "ui/explore/growup/command/skill/011.png",
															touchAble = "False",
															UILayoutViewModel = 
															{
																PositionY = 6,
															},
															width = "46",
															ZOrder = "1",
														},
													},
												},
											},
										},
										{
											controlID = "Panel_line20_Panel_lines_Panel_skillMap1_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
											UUID = "a37c2773_4704_40ff_9759_e5ed9f4e6707",
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
											height = "10",
											ignoreSize = "False",
											name = "Panel_line20",
											rotation = "-45",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 2533,
												PositionY = 226,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "10",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "Panel_dark_Panel_line20_Panel_lines_Panel_skillMap1_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
													UUID = "16dd45c1_b097_4601_be59_07fa487db81c",
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
													height = "10",
													ignoreSize = "False",
													name = "Panel_dark",
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
													width = "10",
													ZOrder = "1",
													components = 
													{
														
														{
															controlID = "Image_line1_Panel_dark_Panel_line20_Panel_lines_Panel_skillMap1_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
															UUID = "224ce87e_4a30_437a_b1df_7c35fabbccba",
															anchorPoint = "False",
															anchorPointX = "0",
															anchorPointY = "0.5",
															backGroundScale9Enable = "True;capInsetsX:0;capInsetsY:0;capInsetsWidth:0;capInsetsHeight:0",
															classname = "MEImage",
															dstBlendFunc = "771",
															height = "28",
															ignoreSize = "False",
															name = "Image_line1",
															sizepercentx = "0",
															sizepercenty = "0",
															sizeType = "0",
															srcBlendFunc = "1",
															texturePath = "ui/explore/growup/command/skill/013.png",
															touchAble = "False",
															UILayoutViewModel = 
															{
																PositionY = 6,
															},
															width = "87",
															ZOrder = "1",
														},
													},
												},
												{
													controlID = "Panel_light_Panel_line20_Panel_lines_Panel_skillMap1_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
													UUID = "bf7df679_182c_4480_be4b_ab0827fe524a",
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
													height = "10",
													ignoreSize = "False",
													name = "Panel_light",
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
													width = "10",
													ZOrder = "1",
													components = 
													{
														
														{
															controlID = "Image_line1_Panel_light_Panel_line20_Panel_lines_Panel_skillMap1_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
															UUID = "75b9693b_f814_4e31_83bf_d08140f6794d",
															anchorPoint = "False",
															anchorPointX = "0",
															anchorPointY = "0.5",
															backGroundScale9Enable = "True;capInsetsX:0;capInsetsY:0;capInsetsWidth:0;capInsetsHeight:0",
															classname = "MEImage",
															dstBlendFunc = "771",
															height = "28",
															ignoreSize = "False",
															name = "Image_line1",
															sizepercentx = "0",
															sizepercenty = "0",
															sizeType = "0",
															srcBlendFunc = "1",
															texturePath = "ui/explore/growup/command/skill/011.png",
															touchAble = "False",
															UILayoutViewModel = 
															{
																PositionY = 6,
															},
															width = "86",
															ZOrder = "1",
														},
													},
												},
											},
										},
										{
											controlID = "Panel_line21_Panel_lines_Panel_skillMap1_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
											UUID = "b410c472_aeae_433c_ae73_56c94b737de7",
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
											height = "10",
											ignoreSize = "False",
											name = "Panel_line21",
											rotation = "45",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 2651,
												PositionY = 286,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "10",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "Panel_dark_Panel_line21_Panel_lines_Panel_skillMap1_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
													UUID = "0e7b361f_6667_4ba1_b5cf_61d6cc5b655a",
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
													height = "10",
													ignoreSize = "False",
													name = "Panel_dark",
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
													width = "10",
													ZOrder = "1",
													components = 
													{
														
														{
															controlID = "Image_line1_Panel_dark_Panel_line21_Panel_lines_Panel_skillMap1_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
															UUID = "144aaff0_cf53_4d1b_add7_2f02f82ac313",
															anchorPoint = "False",
															anchorPointX = "0",
															anchorPointY = "0.5",
															backGroundScale9Enable = "True;capInsetsX:0;capInsetsY:0;capInsetsWidth:0;capInsetsHeight:0",
															classname = "MEImage",
															dstBlendFunc = "771",
															height = "28",
															ignoreSize = "False",
															name = "Image_line1",
															sizepercentx = "0",
															sizepercenty = "0",
															sizeType = "0",
															srcBlendFunc = "1",
															texturePath = "ui/explore/growup/command/skill/013.png",
															touchAble = "False",
															UILayoutViewModel = 
															{
																PositionY = 6,
															},
															width = "84",
															ZOrder = "1",
														},
													},
												},
												{
													controlID = "Panel_light_Panel_line21_Panel_lines_Panel_skillMap1_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
													UUID = "e0a16f10_62d1_4672_b254_3f6c924b62b4",
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
													height = "10",
													ignoreSize = "False",
													name = "Panel_light",
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
													width = "10",
													ZOrder = "1",
													components = 
													{
														
														{
															controlID = "Image_line1_Panel_light_Panel_line21_Panel_lines_Panel_skillMap1_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
															UUID = "8d1db5b0_40d8_439a_a8ef_14c7dcf8e380",
															anchorPoint = "False",
															anchorPointX = "0",
															anchorPointY = "0.5",
															backGroundScale9Enable = "True;capInsetsX:0;capInsetsY:0;capInsetsWidth:0;capInsetsHeight:0",
															classname = "MEImage",
															dstBlendFunc = "771",
															height = "28",
															ignoreSize = "False",
															name = "Image_line1",
															sizepercentx = "0",
															sizepercenty = "0",
															sizeType = "0",
															srcBlendFunc = "1",
															texturePath = "ui/explore/growup/command/skill/011.png",
															touchAble = "False",
															UILayoutViewModel = 
															{
																PositionY = 6,
															},
															width = "85",
															ZOrder = "1",
														},
													},
												},
											},
										},
										{
											controlID = "Panel_line22_Panel_lines_Panel_skillMap1_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
											UUID = "3e4f6b80_6a88_41dd_aa45_61481a5bc480",
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
											height = "10",
											ignoreSize = "False",
											name = "Panel_line22",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 2790,
												PositionY = 206,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "10",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "Panel_dark_Panel_line22_Panel_lines_Panel_skillMap1_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
													UUID = "b500d657_3afa_455d_866b_2bdd1940f8cc",
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
													height = "10",
													ignoreSize = "False",
													name = "Panel_dark",
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
													width = "10",
													ZOrder = "1",
													components = 
													{
														
														{
															controlID = "Image_line1_Panel_dark_Panel_line22_Panel_lines_Panel_skillMap1_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
															UUID = "d57bb521_6450_457c_8092_0976780dea7f",
															anchorPoint = "False",
															anchorPointX = "0",
															anchorPointY = "0.5",
															backGroundScale9Enable = "True;capInsetsX:0;capInsetsY:0;capInsetsWidth:0;capInsetsHeight:0",
															classname = "MEImage",
															dstBlendFunc = "771",
															height = "28",
															ignoreSize = "False",
															name = "Image_line1",
															sizepercentx = "0",
															sizepercenty = "0",
															sizeType = "0",
															srcBlendFunc = "1",
															texturePath = "ui/explore/growup/command/skill/013.png",
															touchAble = "False",
															UILayoutViewModel = 
															{
																PositionY = 6,
															},
															width = "46",
															ZOrder = "1",
														},
													},
												},
												{
													controlID = "Panel_light_Panel_line22_Panel_lines_Panel_skillMap1_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
													UUID = "79ccfb97_35da_4066_99b3_ecc7dfe9d12a",
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
													height = "10",
													ignoreSize = "False",
													name = "Panel_light",
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
													width = "10",
													ZOrder = "1",
													components = 
													{
														
														{
															controlID = "Image_line1_Panel_light_Panel_line22_Panel_lines_Panel_skillMap1_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
															UUID = "1c5a9684_d1ce_4fc6_b9e3_c9eeb16fa870",
															anchorPoint = "False",
															anchorPointX = "0",
															anchorPointY = "0.5",
															backGroundScale9Enable = "True;capInsetsX:0;capInsetsY:0;capInsetsWidth:0;capInsetsHeight:0",
															classname = "MEImage",
															dstBlendFunc = "771",
															height = "28",
															ignoreSize = "False",
															name = "Image_line1",
															sizepercentx = "0",
															sizepercenty = "0",
															sizeType = "0",
															srcBlendFunc = "1",
															texturePath = "ui/explore/growup/command/skill/011.png",
															touchAble = "False",
															UILayoutViewModel = 
															{
																PositionY = 6,
															},
															width = "46",
															ZOrder = "1",
														},
													},
												},
											},
										},
										{
											controlID = "Panel_line23_Panel_lines_Panel_skillMap1_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
											UUID = "972f6d58_8ca3_4a39_ba2f_829093bcbf8b",
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
											height = "10",
											ignoreSize = "False",
											name = "Panel_line23",
											rotation = "45",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 2906,
												PositionY = 185,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "10",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "Panel_dark_Panel_line23_Panel_lines_Panel_skillMap1_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
													UUID = "772e4607_bffe_42ba_8453_48eb8c3de6a4",
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
													height = "10",
													ignoreSize = "False",
													name = "Panel_dark",
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
													width = "10",
													ZOrder = "1",
													components = 
													{
														
														{
															controlID = "Image_line1_Panel_dark_Panel_line23_Panel_lines_Panel_skillMap1_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
															UUID = "7de16be5_fc16_4a36_a1d4_8a48e386648d",
															anchorPoint = "False",
															anchorPointX = "0",
															anchorPointY = "0.5",
															backGroundScale9Enable = "True;capInsetsX:0;capInsetsY:0;capInsetsWidth:0;capInsetsHeight:0",
															classname = "MEImage",
															dstBlendFunc = "771",
															height = "28",
															ignoreSize = "False",
															name = "Image_line1",
															sizepercentx = "0",
															sizepercenty = "0",
															sizeType = "0",
															srcBlendFunc = "1",
															texturePath = "ui/explore/growup/command/skill/013.png",
															touchAble = "False",
															UILayoutViewModel = 
															{
																PositionY = 6,
															},
															width = "84",
															ZOrder = "1",
														},
													},
												},
												{
													controlID = "Panel_light_Panel_line23_Panel_lines_Panel_skillMap1_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
													UUID = "e98e430c_b243_45e6_8f4c_7a3c8577f7be",
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
													height = "10",
													ignoreSize = "False",
													name = "Panel_light",
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
													width = "10",
													ZOrder = "1",
													components = 
													{
														
														{
															controlID = "Image_line1_Panel_light_Panel_line23_Panel_lines_Panel_skillMap1_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
															UUID = "d90d8a03_2ae9_475d_8b15_909eace81283",
															anchorPoint = "False",
															anchorPointX = "0",
															anchorPointY = "0.5",
															backGroundScale9Enable = "True;capInsetsX:0;capInsetsY:0;capInsetsWidth:0;capInsetsHeight:0",
															classname = "MEImage",
															dstBlendFunc = "771",
															height = "28",
															ignoreSize = "False",
															name = "Image_line1",
															sizepercentx = "0",
															sizepercenty = "0",
															sizeType = "0",
															srcBlendFunc = "1",
															texturePath = "ui/explore/growup/command/skill/011.png",
															touchAble = "False",
															UILayoutViewModel = 
															{
																PositionY = 6,
															},
															width = "85",
															ZOrder = "1",
														},
													},
												},
											},
										},
										{
											controlID = "Panel_line24_Panel_lines_Panel_skillMap1_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
											UUID = "77eb56cf_ea2d_4038_838a_9013852ace10",
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
											height = "10",
											ignoreSize = "False",
											name = "Panel_line24",
											rotation = "-45",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 3035,
												PositionY = 124,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "10",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "Panel_dark_Panel_line24_Panel_lines_Panel_skillMap1_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
													UUID = "42faade2_ba64_4ed3_9497_366898e05fbe",
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
													height = "10",
													ignoreSize = "False",
													name = "Panel_dark",
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
													width = "10",
													ZOrder = "1",
													components = 
													{
														
														{
															controlID = "Image_line1_Panel_dark_Panel_line24_Panel_lines_Panel_skillMap1_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
															UUID = "de1012ef_8e17_4ce7_b398_24e6d5e27521",
															anchorPoint = "False",
															anchorPointX = "0",
															anchorPointY = "0.5",
															backGroundScale9Enable = "True;capInsetsX:0;capInsetsY:0;capInsetsWidth:0;capInsetsHeight:0",
															classname = "MEImage",
															dstBlendFunc = "771",
															height = "28",
															ignoreSize = "False",
															name = "Image_line1",
															sizepercentx = "0",
															sizepercenty = "0",
															sizeType = "0",
															srcBlendFunc = "1",
															texturePath = "ui/explore/growup/command/skill/013.png",
															touchAble = "False",
															UILayoutViewModel = 
															{
																PositionY = 6,
															},
															width = "87",
															ZOrder = "1",
														},
													},
												},
												{
													controlID = "Panel_light_Panel_line24_Panel_lines_Panel_skillMap1_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
													UUID = "67a1a4f0_f630_43f2_a7f4_200ffece8f84",
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
													height = "10",
													ignoreSize = "False",
													name = "Panel_light",
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
													width = "10",
													ZOrder = "1",
													components = 
													{
														
														{
															controlID = "Image_line1_Panel_light_Panel_line24_Panel_lines_Panel_skillMap1_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
															UUID = "bd2fa85c_7584_41a3_9973_745c5c519cd1",
															anchorPoint = "False",
															anchorPointX = "0",
															anchorPointY = "0.5",
															backGroundScale9Enable = "True;capInsetsX:0;capInsetsY:0;capInsetsWidth:0;capInsetsHeight:0",
															classname = "MEImage",
															dstBlendFunc = "771",
															height = "28",
															ignoreSize = "False",
															name = "Image_line1",
															sizepercentx = "0",
															sizepercenty = "0",
															sizeType = "0",
															srcBlendFunc = "1",
															texturePath = "ui/explore/growup/command/skill/011.png",
															touchAble = "False",
															UILayoutViewModel = 
															{
																PositionY = 6,
															},
															width = "86",
															ZOrder = "1",
														},
													},
												},
											},
										},
										{
											controlID = "Panel_line25_Panel_lines_Panel_skillMap1_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
											UUID = "4616b233_cd5f_40ab_86be_7b6d857cf689",
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
											height = "10",
											ignoreSize = "False",
											name = "Panel_line25",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 3167,
												PositionY = 206,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "10",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "Panel_dark_Panel_line25_Panel_lines_Panel_skillMap1_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
													UUID = "a135be1e_eafb_44c3_b1fa_2190e70b6def",
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
													height = "10",
													ignoreSize = "False",
													name = "Panel_dark",
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
													width = "10",
													ZOrder = "1",
													components = 
													{
														
														{
															controlID = "Image_line1_Panel_dark_Panel_line25_Panel_lines_Panel_skillMap1_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
															UUID = "4c086dc2_4f1b_44aa_8792_ba9861c8567f",
															anchorPoint = "False",
															anchorPointX = "0",
															anchorPointY = "0.5",
															backGroundScale9Enable = "True;capInsetsX:0;capInsetsY:0;capInsetsWidth:0;capInsetsHeight:0",
															classname = "MEImage",
															dstBlendFunc = "771",
															height = "28",
															ignoreSize = "False",
															name = "Image_line1",
															sizepercentx = "0",
															sizepercenty = "0",
															sizeType = "0",
															srcBlendFunc = "1",
															texturePath = "ui/explore/growup/command/skill/013.png",
															touchAble = "False",
															UILayoutViewModel = 
															{
																PositionY = 6,
															},
															width = "46",
															ZOrder = "1",
														},
													},
												},
												{
													controlID = "Panel_light_Panel_line25_Panel_lines_Panel_skillMap1_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
													UUID = "86cde847_5e70_4295_8ffc_4982566c827d",
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
													height = "10",
													ignoreSize = "False",
													name = "Panel_light",
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
													width = "10",
													ZOrder = "1",
													components = 
													{
														
														{
															controlID = "Image_line1_Panel_light_Panel_line25_Panel_lines_Panel_skillMap1_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
															UUID = "faea5114_5b50_4655_ae16_feab713e2398",
															anchorPoint = "False",
															anchorPointX = "0",
															anchorPointY = "0.5",
															backGroundScale9Enable = "True;capInsetsX:0;capInsetsY:0;capInsetsWidth:0;capInsetsHeight:0",
															classname = "MEImage",
															dstBlendFunc = "771",
															height = "28",
															ignoreSize = "False",
															name = "Image_line1",
															sizepercentx = "0",
															sizepercenty = "0",
															sizeType = "0",
															srcBlendFunc = "1",
															texturePath = "ui/explore/growup/command/skill/011.png",
															touchAble = "False",
															UILayoutViewModel = 
															{
																PositionY = 6,
															},
															width = "46",
															ZOrder = "1",
														},
													},
												},
											},
										},
										{
											controlID = "Panel_line26_Panel_lines_Panel_skillMap1_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
											UUID = "cb2fcb4f_ff24_487f_b170_9e5ae455a470",
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
											height = "10",
											ignoreSize = "False",
											name = "Panel_line26",
											rotation = "-45",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 3291,
												PositionY = 226,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "10",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "Panel_dark_Panel_line26_Panel_lines_Panel_skillMap1_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
													UUID = "c99c3a7e_fa9d_4b24_9801_3b1864fe117c",
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
													height = "10",
													ignoreSize = "False",
													name = "Panel_dark",
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
													width = "10",
													ZOrder = "1",
													components = 
													{
														
														{
															controlID = "Image_line1_Panel_dark_Panel_line26_Panel_lines_Panel_skillMap1_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
															UUID = "c9528e32_49c3_4a85_9c4d_b1b28d4a241c",
															anchorPoint = "False",
															anchorPointX = "0",
															anchorPointY = "0.5",
															backGroundScale9Enable = "True;capInsetsX:0;capInsetsY:0;capInsetsWidth:0;capInsetsHeight:0",
															classname = "MEImage",
															dstBlendFunc = "771",
															height = "28",
															ignoreSize = "False",
															name = "Image_line1",
															sizepercentx = "0",
															sizepercenty = "0",
															sizeType = "0",
															srcBlendFunc = "1",
															texturePath = "ui/explore/growup/command/skill/013.png",
															touchAble = "False",
															UILayoutViewModel = 
															{
																PositionY = 6,
															},
															width = "87",
															ZOrder = "1",
														},
													},
												},
												{
													controlID = "Panel_light_Panel_line26_Panel_lines_Panel_skillMap1_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
													UUID = "4bed0add_bafa_422f_af86_db9317dc72f3",
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
													height = "10",
													ignoreSize = "False",
													name = "Panel_light",
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
													width = "10",
													ZOrder = "1",
													components = 
													{
														
														{
															controlID = "Image_line1_Panel_light_Panel_line26_Panel_lines_Panel_skillMap1_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
															UUID = "e6b9ec7d_a67b_4c86_9d54_987656ff288d",
															anchorPoint = "False",
															anchorPointX = "0",
															anchorPointY = "0.5",
															backGroundScale9Enable = "True;capInsetsX:0;capInsetsY:0;capInsetsWidth:0;capInsetsHeight:0",
															classname = "MEImage",
															dstBlendFunc = "771",
															height = "28",
															ignoreSize = "False",
															name = "Image_line1",
															sizepercentx = "0",
															sizepercenty = "0",
															sizeType = "0",
															srcBlendFunc = "1",
															texturePath = "ui/explore/growup/command/skill/011.png",
															touchAble = "False",
															UILayoutViewModel = 
															{
																PositionY = 6,
															},
															width = "86",
															ZOrder = "1",
														},
													},
												},
											},
										},
										{
											controlID = "Panel_line27_Panel_lines_Panel_skillMap1_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
											UUID = "61fd6b1d_a857_460f_a481_c44ee4981412",
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
											height = "10",
											ignoreSize = "False",
											name = "Panel_line27",
											rotation = "45",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 3409,
												PositionY = 286,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "10",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "Panel_dark_Panel_line27_Panel_lines_Panel_skillMap1_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
													UUID = "322fed5c_a7d9_4cf7_9b8e_764ea01a509b",
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
													height = "10",
													ignoreSize = "False",
													name = "Panel_dark",
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
													width = "10",
													ZOrder = "1",
													components = 
													{
														
														{
															controlID = "Image_line1_Panel_dark_Panel_line27_Panel_lines_Panel_skillMap1_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
															UUID = "619e6800_8e26_4f2a_9e06_341f7fa458eb",
															anchorPoint = "False",
															anchorPointX = "0",
															anchorPointY = "0.5",
															backGroundScale9Enable = "True;capInsetsX:0;capInsetsY:0;capInsetsWidth:0;capInsetsHeight:0",
															classname = "MEImage",
															dstBlendFunc = "771",
															height = "28",
															ignoreSize = "False",
															name = "Image_line1",
															sizepercentx = "0",
															sizepercenty = "0",
															sizeType = "0",
															srcBlendFunc = "1",
															texturePath = "ui/explore/growup/command/skill/013.png",
															touchAble = "False",
															UILayoutViewModel = 
															{
																PositionY = 6,
															},
															width = "84",
															ZOrder = "1",
														},
													},
												},
												{
													controlID = "Panel_light_Panel_line27_Panel_lines_Panel_skillMap1_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
													UUID = "f2a8f00b_f0c0_43e6_9edf_a707927a8cff",
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
													height = "10",
													ignoreSize = "False",
													name = "Panel_light",
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
													width = "10",
													ZOrder = "1",
													components = 
													{
														
														{
															controlID = "Image_line1_Panel_light_Panel_line27_Panel_lines_Panel_skillMap1_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
															UUID = "0a9f7aa8_8eb6_4b71_8ade_9db8438c2ba1",
															anchorPoint = "False",
															anchorPointX = "0",
															anchorPointY = "0.5",
															backGroundScale9Enable = "True;capInsetsX:0;capInsetsY:0;capInsetsWidth:0;capInsetsHeight:0",
															classname = "MEImage",
															dstBlendFunc = "771",
															height = "28",
															ignoreSize = "False",
															name = "Image_line1",
															sizepercentx = "0",
															sizepercenty = "0",
															sizeType = "0",
															srcBlendFunc = "1",
															texturePath = "ui/explore/growup/command/skill/011.png",
															touchAble = "False",
															UILayoutViewModel = 
															{
																PositionY = 6,
															},
															width = "85",
															ZOrder = "1",
														},
													},
												},
											},
										},
										{
											controlID = "Panel_line28_Panel_lines_Panel_skillMap1_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
											UUID = "1a789366_a712_49d9_8cf1_acfd8100c5c2",
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
											height = "10",
											ignoreSize = "False",
											name = "Panel_line28",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 3548,
												PositionY = 206,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "10",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "Panel_dark_Panel_line28_Panel_lines_Panel_skillMap1_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
													UUID = "6be64c22_c2f3_40d4_b25b_ec10f0dfce0c",
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
													height = "10",
													ignoreSize = "False",
													name = "Panel_dark",
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
													width = "10",
													ZOrder = "1",
													components = 
													{
														
														{
															controlID = "Image_line1_Panel_dark_Panel_line28_Panel_lines_Panel_skillMap1_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
															UUID = "9e7be3b6_b09f_4ec4_9eb9_176084e124ef",
															anchorPoint = "False",
															anchorPointX = "0",
															anchorPointY = "0.5",
															backGroundScale9Enable = "True;capInsetsX:0;capInsetsY:0;capInsetsWidth:0;capInsetsHeight:0",
															classname = "MEImage",
															dstBlendFunc = "771",
															height = "28",
															ignoreSize = "False",
															name = "Image_line1",
															sizepercentx = "0",
															sizepercenty = "0",
															sizeType = "0",
															srcBlendFunc = "1",
															texturePath = "ui/explore/growup/command/skill/013.png",
															touchAble = "False",
															UILayoutViewModel = 
															{
																PositionY = 6,
															},
															width = "46",
															ZOrder = "1",
														},
													},
												},
												{
													controlID = "Panel_light_Panel_line28_Panel_lines_Panel_skillMap1_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
													UUID = "a4aa2adb_f3e8_412c_b960_2cb019ed9e16",
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
													height = "10",
													ignoreSize = "False",
													name = "Panel_light",
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
													width = "10",
													ZOrder = "1",
													components = 
													{
														
														{
															controlID = "Image_line1_Panel_light_Panel_line28_Panel_lines_Panel_skillMap1_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
															UUID = "b01213c3_dd95_4ee0_8c41_b243ade4b080",
															anchorPoint = "False",
															anchorPointX = "0",
															anchorPointY = "0.5",
															backGroundScale9Enable = "True;capInsetsX:0;capInsetsY:0;capInsetsWidth:0;capInsetsHeight:0",
															classname = "MEImage",
															dstBlendFunc = "771",
															height = "28",
															ignoreSize = "False",
															name = "Image_line1",
															sizepercentx = "0",
															sizepercenty = "0",
															sizeType = "0",
															srcBlendFunc = "1",
															texturePath = "ui/explore/growup/command/skill/011.png",
															touchAble = "False",
															UILayoutViewModel = 
															{
																PositionY = 6,
															},
															width = "46",
															ZOrder = "1",
														},
													},
												},
											},
										},
										{
											controlID = "Panel_line29_Panel_lines_Panel_skillMap1_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
											UUID = "98aac777_1e6b_4d67_9607_9a7de79a1ee8",
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
											height = "10",
											ignoreSize = "False",
											name = "Panel_line29",
											rotation = "45",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 3664,
												PositionY = 185,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "10",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "Panel_dark_Panel_line29_Panel_lines_Panel_skillMap1_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
													UUID = "dcd4818d_bffa_44a0_adb2_373a1cee4b9a",
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
													height = "10",
													ignoreSize = "False",
													name = "Panel_dark",
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
													width = "10",
													ZOrder = "1",
													components = 
													{
														
														{
															controlID = "Image_line1_Panel_dark_Panel_line29_Panel_lines_Panel_skillMap1_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
															UUID = "1c86e254_53c7_4bf3_9e04_b50d088c01c4",
															anchorPoint = "False",
															anchorPointX = "0",
															anchorPointY = "0.5",
															backGroundScale9Enable = "True;capInsetsX:0;capInsetsY:0;capInsetsWidth:0;capInsetsHeight:0",
															classname = "MEImage",
															dstBlendFunc = "771",
															height = "28",
															ignoreSize = "False",
															name = "Image_line1",
															sizepercentx = "0",
															sizepercenty = "0",
															sizeType = "0",
															srcBlendFunc = "1",
															texturePath = "ui/explore/growup/command/skill/013.png",
															touchAble = "False",
															UILayoutViewModel = 
															{
																PositionY = 6,
															},
															width = "84",
															ZOrder = "1",
														},
													},
												},
												{
													controlID = "Panel_light_Panel_line29_Panel_lines_Panel_skillMap1_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
													UUID = "27d7d1d6_156d_4193_9ae3_7793e4ac6c0b",
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
													height = "10",
													ignoreSize = "False",
													name = "Panel_light",
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
													width = "10",
													ZOrder = "1",
													components = 
													{
														
														{
															controlID = "Image_line1_Panel_light_Panel_line29_Panel_lines_Panel_skillMap1_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
															UUID = "a838f322_c181_4425_ab73_61e76ac2f516",
															anchorPoint = "False",
															anchorPointX = "0",
															anchorPointY = "0.5",
															backGroundScale9Enable = "True;capInsetsX:0;capInsetsY:0;capInsetsWidth:0;capInsetsHeight:0",
															classname = "MEImage",
															dstBlendFunc = "771",
															height = "28",
															ignoreSize = "False",
															name = "Image_line1",
															sizepercentx = "0",
															sizepercenty = "0",
															sizeType = "0",
															srcBlendFunc = "1",
															texturePath = "ui/explore/growup/command/skill/011.png",
															touchAble = "False",
															UILayoutViewModel = 
															{
																PositionY = 6,
															},
															width = "85",
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
							controlID = "Panel_skillMap2_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
							UUID = "534bb44d_28ce_47a8_8c95_ed5df2bd4908",
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
							height = "403",
							ignoreSize = "False",
							name = "Panel_skillMap2",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							touchAble = "False",
							UILayoutViewModel = 
							{
								PositionX = 8,
							},
							uipanelviewmodel = 
							{
								Layout="Absolute",
								nType = "0"
							},
							width = "3796",
							ZOrder = "1",
							components = 
							{
								
								{
									controlID = "Panel_points_Panel_skillMap2_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
									UUID = "f89821f3_df0e_427b_b500_213a9d0f7f51",
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
									name = "Panel_points",
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
									width = "400",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "Panel_point1_Panel_points_Panel_skillMap2_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
											UUID = "d903e25d_7395_4fb0_b08a_5647199bdfc5",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											bgColorOpacity = "50",
											bIsOpenClipping = "False",
											classname = "MEPanel",
											colorType = "1;SingleColor:#FFFF0000;GraduallyChangingColorStart:#FFFFFFFF;GraduallyChangingColorEnd:#FFFFFFFF;vectorX:0;vectorY:0",
											DesignHeight = "640",
											DesignType = "0",
											DesignWidth = "960",
											dstBlendFunc = "771",
											height = "10",
											ignoreSize = "False",
											name = "Panel_point1",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 93,
												PositionY = 210,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "10",
											ZOrder = "1",
										},
										{
											controlID = "Panel_point2_Panel_points_Panel_skillMap2_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
											UUID = "ad04b368_f85b_402c_bade_2ded2ccfe1aa",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											bgColorOpacity = "50",
											bIsOpenClipping = "False",
											classname = "MEPanel",
											colorType = "1;SingleColor:#FFFF0000;GraduallyChangingColorStart:#FFFFFFFF;GraduallyChangingColorEnd:#FFFFFFFF;vectorX:0;vectorY:0",
											DesignHeight = "640",
											DesignType = "0",
											DesignWidth = "960",
											dstBlendFunc = "771",
											height = "10",
											ignoreSize = "False",
											name = "Panel_point2",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 223,
												PositionY = 209,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "10",
											ZOrder = "1",
										},
										{
											controlID = "Panel_point3_Panel_points_Panel_skillMap2_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
											UUID = "699b2538_f76d_47a9_af53_dea9461fa9b9",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											bgColorOpacity = "50",
											bIsOpenClipping = "False",
											classname = "MEPanel",
											colorType = "1;SingleColor:#FFFF0000;GraduallyChangingColorStart:#FFFFFFFF;GraduallyChangingColorEnd:#FFFFFFFF;vectorX:0;vectorY:0",
											DesignHeight = "640",
											DesignType = "0",
											DesignWidth = "960",
											dstBlendFunc = "771",
											height = "10",
											ignoreSize = "False",
											name = "Panel_point3",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 349,
												PositionY = 310,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "10",
											ZOrder = "1",
										},
										{
											controlID = "Panel_point4_Panel_points_Panel_skillMap2_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
											UUID = "1af7ba7b_90f2_463e_aabe_7122118c91c8",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											bgColorOpacity = "50",
											bIsOpenClipping = "False",
											classname = "MEPanel",
											colorType = "1;SingleColor:#FFFF0000;GraduallyChangingColorStart:#FFFFFFFF;GraduallyChangingColorEnd:#FFFFFFFF;vectorX:0;vectorY:0",
											DesignHeight = "640",
											DesignType = "0",
											DesignWidth = "960",
											dstBlendFunc = "771",
											height = "10",
											ignoreSize = "False",
											name = "Panel_point4",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 473,
												PositionY = 209,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "10",
											ZOrder = "1",
										},
										{
											controlID = "Panel_point5_Panel_points_Panel_skillMap2_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
											UUID = "83563e51_41fc_4f9f_b8dd_82f985f6805b",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											bgColorOpacity = "50",
											bIsOpenClipping = "False",
											classname = "MEPanel",
											colorType = "1;SingleColor:#FFFF0000;GraduallyChangingColorStart:#FFFFFFFF;GraduallyChangingColorEnd:#FFFFFFFF;vectorX:0;vectorY:0",
											DesignHeight = "640",
											DesignType = "0",
											DesignWidth = "960",
											dstBlendFunc = "771",
											height = "10",
											ignoreSize = "False",
											name = "Panel_point5",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 604,
												PositionY = 209,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "10",
											ZOrder = "1",
										},
										{
											controlID = "Panel_point6_Panel_points_Panel_skillMap2_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
											UUID = "e62d2736_7fc6_4647_bad3_e6e1082e2ee7",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											bgColorOpacity = "50",
											bIsOpenClipping = "False",
											classname = "MEPanel",
											colorType = "1;SingleColor:#FFFF0000;GraduallyChangingColorStart:#FFFFFFFF;GraduallyChangingColorEnd:#FFFFFFFF;vectorX:0;vectorY:0",
											DesignHeight = "640",
											DesignType = "0",
											DesignWidth = "960",
											dstBlendFunc = "771",
											height = "10",
											ignoreSize = "False",
											name = "Panel_point6",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 726,
												PositionY = 108,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "10",
											ZOrder = "1",
										},
										{
											controlID = "Panel_point7_Panel_points_Panel_skillMap2_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
											UUID = "2510eb9e_d92d_4a5c_810f_8133c146594d",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											bgColorOpacity = "50",
											bIsOpenClipping = "False",
											classname = "MEPanel",
											colorType = "1;SingleColor:#FFFF0000;GraduallyChangingColorStart:#FFFFFFFF;GraduallyChangingColorEnd:#FFFFFFFF;vectorX:0;vectorY:0",
											DesignHeight = "640",
											DesignType = "0",
											DesignWidth = "960",
											dstBlendFunc = "771",
											height = "10",
											ignoreSize = "False",
											name = "Panel_point7",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 851,
												PositionY = 209,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "10",
											ZOrder = "1",
										},
										{
											controlID = "Panel_point8_Panel_points_Panel_skillMap2_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
											UUID = "e1b36437_4c27_42e0_9834_890f00a521cf",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											bgColorOpacity = "50",
											bIsOpenClipping = "False",
											classname = "MEPanel",
											colorType = "1;SingleColor:#FFFF0000;GraduallyChangingColorStart:#FFFFFFFF;GraduallyChangingColorEnd:#FFFFFFFF;vectorX:0;vectorY:0",
											DesignHeight = "640",
											DesignType = "0",
											DesignWidth = "960",
											dstBlendFunc = "771",
											height = "10",
											ignoreSize = "False",
											name = "Panel_point8",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 981,
												PositionY = 208,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "10",
											ZOrder = "1",
										},
										{
											controlID = "Panel_point9_Panel_points_Panel_skillMap2_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
											UUID = "f93f2e44_9a08_45fe_89f8_cc04194230e5",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											bgColorOpacity = "50",
											bIsOpenClipping = "False",
											classname = "MEPanel",
											colorType = "1;SingleColor:#FFFF0000;GraduallyChangingColorStart:#FFFFFFFF;GraduallyChangingColorEnd:#FFFFFFFF;vectorX:0;vectorY:0",
											DesignHeight = "640",
											DesignType = "0",
											DesignWidth = "960",
											dstBlendFunc = "771",
											height = "10",
											ignoreSize = "False",
											name = "Panel_point9",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 1107,
												PositionY = 309,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "10",
											ZOrder = "1",
										},
										{
											controlID = "Panel_point10_Panel_points_Panel_skillMap2_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
											UUID = "967c557e_ca8f_46bb_80a1_10cd81ee5fdf",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											bgColorOpacity = "50",
											bIsOpenClipping = "False",
											classname = "MEPanel",
											colorType = "1;SingleColor:#FFFF0000;GraduallyChangingColorStart:#FFFFFFFF;GraduallyChangingColorEnd:#FFFFFFFF;vectorX:0;vectorY:0",
											DesignHeight = "640",
											DesignType = "0",
											DesignWidth = "960",
											dstBlendFunc = "771",
											height = "10",
											ignoreSize = "False",
											name = "Panel_point10",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 1231,
												PositionY = 208,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "10",
											ZOrder = "1",
										},
										{
											controlID = "Panel_point11_Panel_points_Panel_skillMap2_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
											UUID = "15cf62f7_b00f_4019_9ccf_0df672ce54e6",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											bgColorOpacity = "50",
											bIsOpenClipping = "False",
											classname = "MEPanel",
											colorType = "1;SingleColor:#FFFF0000;GraduallyChangingColorStart:#FFFFFFFF;GraduallyChangingColorEnd:#FFFFFFFF;vectorX:0;vectorY:0",
											DesignHeight = "640",
											DesignType = "0",
											DesignWidth = "960",
											dstBlendFunc = "771",
											height = "10",
											ignoreSize = "False",
											name = "Panel_point11",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 1362,
												PositionY = 208,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "10",
											ZOrder = "1",
										},
										{
											controlID = "Panel_point12_Panel_points_Panel_skillMap2_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
											UUID = "4185695f_1ecf_4d51_ad42_b0da4bddf6ac",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											bgColorOpacity = "50",
											bIsOpenClipping = "False",
											classname = "MEPanel",
											colorType = "1;SingleColor:#FFFF0000;GraduallyChangingColorStart:#FFFFFFFF;GraduallyChangingColorEnd:#FFFFFFFF;vectorX:0;vectorY:0",
											DesignHeight = "640",
											DesignType = "0",
											DesignWidth = "960",
											dstBlendFunc = "771",
											height = "10",
											ignoreSize = "False",
											name = "Panel_point12",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 1484,
												PositionY = 107,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "10",
											ZOrder = "1",
										},
										{
											controlID = "Panel_point13_Panel_points_Panel_skillMap2_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
											UUID = "005a7405_d1a5_48fe_b5ae_b3286d59275c",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											bgColorOpacity = "50",
											bIsOpenClipping = "False",
											classname = "MEPanel",
											colorType = "1;SingleColor:#FFFF0000;GraduallyChangingColorStart:#FFFFFFFF;GraduallyChangingColorEnd:#FFFFFFFF;vectorX:0;vectorY:0",
											DesignHeight = "640",
											DesignType = "0",
											DesignWidth = "960",
											dstBlendFunc = "771",
											height = "10",
											ignoreSize = "False",
											name = "Panel_point13",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 1608,
												PositionY = 210,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "10",
											ZOrder = "1",
										},
										{
											controlID = "Panel_point14_Panel_points_Panel_skillMap2_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
											UUID = "ec420b8f_cae0_4411_a9e9_238f047c5dc8",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											bgColorOpacity = "50",
											bIsOpenClipping = "False",
											classname = "MEPanel",
											colorType = "1;SingleColor:#FFFF0000;GraduallyChangingColorStart:#FFFFFFFF;GraduallyChangingColorEnd:#FFFFFFFF;vectorX:0;vectorY:0",
											DesignHeight = "640",
											DesignType = "0",
											DesignWidth = "960",
											dstBlendFunc = "771",
											height = "10",
											ignoreSize = "False",
											name = "Panel_point14",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 1738,
												PositionY = 209,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "10",
											ZOrder = "1",
										},
										{
											controlID = "Panel_point15_Panel_points_Panel_skillMap2_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
											UUID = "2fb1027c_0f36_4f92_b9c0_80c9839d13db",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											bgColorOpacity = "50",
											bIsOpenClipping = "False",
											classname = "MEPanel",
											colorType = "1;SingleColor:#FFFF0000;GraduallyChangingColorStart:#FFFFFFFF;GraduallyChangingColorEnd:#FFFFFFFF;vectorX:0;vectorY:0",
											DesignHeight = "640",
											DesignType = "0",
											DesignWidth = "960",
											dstBlendFunc = "771",
											height = "10",
											ignoreSize = "False",
											name = "Panel_point15",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 1864,
												PositionY = 310,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "10",
											ZOrder = "1",
										},
										{
											controlID = "Panel_point16_Panel_points_Panel_skillMap2_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
											UUID = "6505fa41_420d_45f7_a6c5_230dc51c534b",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											bgColorOpacity = "50",
											bIsOpenClipping = "False",
											classname = "MEPanel",
											colorType = "1;SingleColor:#FFFF0000;GraduallyChangingColorStart:#FFFFFFFF;GraduallyChangingColorEnd:#FFFFFFFF;vectorX:0;vectorY:0",
											DesignHeight = "640",
											DesignType = "0",
											DesignWidth = "960",
											dstBlendFunc = "771",
											height = "10",
											ignoreSize = "False",
											name = "Panel_point16",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 1988,
												PositionY = 209,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "10",
											ZOrder = "1",
										},
										{
											controlID = "Panel_point17_Panel_points_Panel_skillMap2_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
											UUID = "5c2e58d1_9e52_4c69_ae1b_03c2d5dc43ef",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											bgColorOpacity = "50",
											bIsOpenClipping = "False",
											classname = "MEPanel",
											colorType = "1;SingleColor:#FFFF0000;GraduallyChangingColorStart:#FFFFFFFF;GraduallyChangingColorEnd:#FFFFFFFF;vectorX:0;vectorY:0",
											DesignHeight = "640",
											DesignType = "0",
											DesignWidth = "960",
											dstBlendFunc = "771",
											height = "10",
											ignoreSize = "False",
											name = "Panel_point17",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 2119,
												PositionY = 209,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "10",
											ZOrder = "1",
										},
										{
											controlID = "Panel_point18_Panel_points_Panel_skillMap2_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
											UUID = "7708ab15_eda2_4152_bff1_e42590fbe745",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											bgColorOpacity = "50",
											bIsOpenClipping = "False",
											classname = "MEPanel",
											colorType = "1;SingleColor:#FFFF0000;GraduallyChangingColorStart:#FFFFFFFF;GraduallyChangingColorEnd:#FFFFFFFF;vectorX:0;vectorY:0",
											DesignHeight = "640",
											DesignType = "0",
											DesignWidth = "960",
											dstBlendFunc = "771",
											height = "10",
											ignoreSize = "False",
											name = "Panel_point18",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 2241,
												PositionY = 108,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "10",
											ZOrder = "1",
										},
										{
											controlID = "Panel_point19_Panel_points_Panel_skillMap2_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
											UUID = "41ce4e79_0866_4569_878e_2cb1322df221",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											bgColorOpacity = "50",
											bIsOpenClipping = "False",
											classname = "MEPanel",
											colorType = "1;SingleColor:#FFFF0000;GraduallyChangingColorStart:#FFFFFFFF;GraduallyChangingColorEnd:#FFFFFFFF;vectorX:0;vectorY:0",
											DesignHeight = "640",
											DesignType = "0",
											DesignWidth = "960",
											dstBlendFunc = "771",
											height = "10",
											ignoreSize = "False",
											name = "Panel_point19",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 2366,
												PositionY = 209,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "10",
											ZOrder = "1",
										},
										{
											controlID = "Panel_point20_Panel_points_Panel_skillMap2_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
											UUID = "e5e9e8b1_11f3_4969_baef_f068dbf8d9dd",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											bgColorOpacity = "50",
											bIsOpenClipping = "False",
											classname = "MEPanel",
											colorType = "1;SingleColor:#FFFF0000;GraduallyChangingColorStart:#FFFFFFFF;GraduallyChangingColorEnd:#FFFFFFFF;vectorX:0;vectorY:0",
											DesignHeight = "640",
											DesignType = "0",
											DesignWidth = "960",
											dstBlendFunc = "771",
											height = "10",
											ignoreSize = "False",
											name = "Panel_point20",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 2496,
												PositionY = 208,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "10",
											ZOrder = "1",
										},
										{
											controlID = "Panel_point21_Panel_points_Panel_skillMap2_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
											UUID = "e99a60b2_de7b_4bff_811d_cd53bacad977",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											bgColorOpacity = "50",
											bIsOpenClipping = "False",
											classname = "MEPanel",
											colorType = "1;SingleColor:#FFFF0000;GraduallyChangingColorStart:#FFFFFFFF;GraduallyChangingColorEnd:#FFFFFFFF;vectorX:0;vectorY:0",
											DesignHeight = "640",
											DesignType = "0",
											DesignWidth = "960",
											dstBlendFunc = "771",
											height = "10",
											ignoreSize = "False",
											name = "Panel_point21",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 2622,
												PositionY = 309,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "10",
											ZOrder = "1",
										},
										{
											controlID = "Panel_point22_Panel_points_Panel_skillMap2_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
											UUID = "ad740d48_b867_4613_8c82_5548fba642c2",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											bgColorOpacity = "50",
											bIsOpenClipping = "False",
											classname = "MEPanel",
											colorType = "1;SingleColor:#FFFF0000;GraduallyChangingColorStart:#FFFFFFFF;GraduallyChangingColorEnd:#FFFFFFFF;vectorX:0;vectorY:0",
											DesignHeight = "640",
											DesignType = "0",
											DesignWidth = "960",
											dstBlendFunc = "771",
											height = "10",
											ignoreSize = "False",
											name = "Panel_point22",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 2746,
												PositionY = 208,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "10",
											ZOrder = "1",
										},
										{
											controlID = "Panel_point23_Panel_points_Panel_skillMap2_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
											UUID = "e9e7ddef_9769_4a47_a7aa_d960017cb298",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											bgColorOpacity = "50",
											bIsOpenClipping = "False",
											classname = "MEPanel",
											colorType = "1;SingleColor:#FFFF0000;GraduallyChangingColorStart:#FFFFFFFF;GraduallyChangingColorEnd:#FFFFFFFF;vectorX:0;vectorY:0",
											DesignHeight = "640",
											DesignType = "0",
											DesignWidth = "960",
											dstBlendFunc = "771",
											height = "10",
											ignoreSize = "False",
											name = "Panel_point23",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 2877,
												PositionY = 208,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "10",
											ZOrder = "1",
										},
										{
											controlID = "Panel_point24_Panel_points_Panel_skillMap2_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
											UUID = "03fcb032_5af4_4dcd_a933_9fdf5a06266e",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											bgColorOpacity = "50",
											bIsOpenClipping = "False",
											classname = "MEPanel",
											colorType = "1;SingleColor:#FFFF0000;GraduallyChangingColorStart:#FFFFFFFF;GraduallyChangingColorEnd:#FFFFFFFF;vectorX:0;vectorY:0",
											DesignHeight = "640",
											DesignType = "0",
											DesignWidth = "960",
											dstBlendFunc = "771",
											height = "10",
											ignoreSize = "False",
											name = "Panel_point24",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 2999,
												PositionY = 107,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "10",
											ZOrder = "1",
										},
										{
											controlID = "Panel_point25_Panel_points_Panel_skillMap2_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
											UUID = "99639f2b_48ca_4835_87fa_58784749a7f0",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											bgColorOpacity = "50",
											bIsOpenClipping = "False",
											classname = "MEPanel",
											colorType = "1;SingleColor:#FFFF0000;GraduallyChangingColorStart:#FFFFFFFF;GraduallyChangingColorEnd:#FFFFFFFF;vectorX:0;vectorY:0",
											DesignHeight = "640",
											DesignType = "0",
											DesignWidth = "960",
											dstBlendFunc = "771",
											height = "10",
											ignoreSize = "False",
											name = "Panel_point25",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 3122,
												PositionY = 209,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "10",
											ZOrder = "1",
										},
										{
											controlID = "Panel_point26_Panel_points_Panel_skillMap2_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
											UUID = "d77ac3d5_edae_4db3_860b_05694061b7f5",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											bgColorOpacity = "50",
											bIsOpenClipping = "False",
											classname = "MEPanel",
											colorType = "1;SingleColor:#FFFF0000;GraduallyChangingColorStart:#FFFFFFFF;GraduallyChangingColorEnd:#FFFFFFFF;vectorX:0;vectorY:0",
											DesignHeight = "640",
											DesignType = "0",
											DesignWidth = "960",
											dstBlendFunc = "771",
											height = "10",
											ignoreSize = "False",
											name = "Panel_point26",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 3252,
												PositionY = 208,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "10",
											ZOrder = "1",
										},
										{
											controlID = "Panel_point27_Panel_points_Panel_skillMap2_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
											UUID = "82dbb6ed_4bb6_4699_bd1a_8813db990dac",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											bgColorOpacity = "50",
											bIsOpenClipping = "False",
											classname = "MEPanel",
											colorType = "1;SingleColor:#FFFF0000;GraduallyChangingColorStart:#FFFFFFFF;GraduallyChangingColorEnd:#FFFFFFFF;vectorX:0;vectorY:0",
											DesignHeight = "640",
											DesignType = "0",
											DesignWidth = "960",
											dstBlendFunc = "771",
											height = "10",
											ignoreSize = "False",
											name = "Panel_point27",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 3378,
												PositionY = 309,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "10",
											ZOrder = "1",
										},
										{
											controlID = "Panel_point28_Panel_points_Panel_skillMap2_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
											UUID = "206a635e_bab6_4886_9e1e_e8335970493c",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											bgColorOpacity = "50",
											bIsOpenClipping = "False",
											classname = "MEPanel",
											colorType = "1;SingleColor:#FFFF0000;GraduallyChangingColorStart:#FFFFFFFF;GraduallyChangingColorEnd:#FFFFFFFF;vectorX:0;vectorY:0",
											DesignHeight = "640",
											DesignType = "0",
											DesignWidth = "960",
											dstBlendFunc = "771",
											height = "10",
											ignoreSize = "False",
											name = "Panel_point28",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 3502,
												PositionY = 208,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "10",
											ZOrder = "1",
										},
										{
											controlID = "Panel_point29_Panel_points_Panel_skillMap2_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
											UUID = "b5f530c3_0a1a_483d_bb59_d47b45e0cc3a",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											bgColorOpacity = "50",
											bIsOpenClipping = "False",
											classname = "MEPanel",
											colorType = "1;SingleColor:#FFFF0000;GraduallyChangingColorStart:#FFFFFFFF;GraduallyChangingColorEnd:#FFFFFFFF;vectorX:0;vectorY:0",
											DesignHeight = "640",
											DesignType = "0",
											DesignWidth = "960",
											dstBlendFunc = "771",
											height = "10",
											ignoreSize = "False",
											name = "Panel_point29",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 3633,
												PositionY = 208,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "10",
											ZOrder = "1",
										},
										{
											controlID = "Panel_point30_Panel_points_Panel_skillMap2_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
											UUID = "f0b4c2e6_8b6b_4910_829a_e908320af47c",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											bgColorOpacity = "50",
											bIsOpenClipping = "False",
											classname = "MEPanel",
											colorType = "1;SingleColor:#FFFF0000;GraduallyChangingColorStart:#FFFFFFFF;GraduallyChangingColorEnd:#FFFFFFFF;vectorX:0;vectorY:0",
											DesignHeight = "640",
											DesignType = "0",
											DesignWidth = "960",
											dstBlendFunc = "771",
											height = "10",
											ignoreSize = "False",
											name = "Panel_point30",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 3755,
												PositionY = 107,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "10",
											ZOrder = "1",
										},
									},
								},
								{
									controlID = "Panel_lines_Panel_skillMap2_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
									UUID = "ba538f49_8c35_448a_b782_0c2efea08a79",
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
									name = "Panel_lines",
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
									width = "400",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "Panel_line1_Panel_lines_Panel_skillMap2_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
											UUID = "7d5f8e0a_1811_4bd9_a875_08c4c1207581",
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
											height = "10",
											ignoreSize = "False",
											name = "Panel_line1",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 135,
												PositionY = 206,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "10",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "Panel_dark_Panel_line1_Panel_lines_Panel_skillMap2_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
													UUID = "a7a6ba82_a436_490d_91d0_fef9b8002a4e",
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
													height = "10",
													ignoreSize = "False",
													name = "Panel_dark",
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
													width = "10",
													ZOrder = "1",
													components = 
													{
														
														{
															controlID = "Image_line1_Panel_dark_Panel_line1_Panel_lines_Panel_skillMap2_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
															UUID = "38406f69_5d9d_46c0_92f3_25c1ee3aca25",
															anchorPoint = "False",
															anchorPointX = "0",
															anchorPointY = "0.5",
															backGroundScale9Enable = "True;capInsetsX:0;capInsetsY:0;capInsetsWidth:0;capInsetsHeight:0",
															classname = "MEImage",
															dstBlendFunc = "771",
															height = "28",
															ignoreSize = "False",
															name = "Image_line1",
															sizepercentx = "0",
															sizepercenty = "0",
															sizeType = "0",
															srcBlendFunc = "1",
															texturePath = "ui/explore/growup/command/skill/013.png",
															touchAble = "False",
															UILayoutViewModel = 
															{
																PositionY = 6,
															},
															width = "46",
															ZOrder = "1",
														},
													},
												},
												{
													controlID = "Panel_light_Panel_line1_Panel_lines_Panel_skillMap2_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
													UUID = "56c7a265_29a4_4253_9672_0a8f6839142b",
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
													height = "10",
													ignoreSize = "False",
													name = "Panel_light",
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
													width = "10",
													ZOrder = "1",
													components = 
													{
														
														{
															controlID = "Image_line1_Panel_light_Panel_line1_Panel_lines_Panel_skillMap2_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
															UUID = "f47bd35d_f309_4217_9274_d9c37fe01b12",
															anchorPoint = "False",
															anchorPointX = "0",
															anchorPointY = "0.5",
															backGroundScale9Enable = "True;capInsetsX:0;capInsetsY:0;capInsetsWidth:0;capInsetsHeight:0",
															classname = "MEImage",
															dstBlendFunc = "771",
															height = "28",
															ignoreSize = "False",
															name = "Image_line1",
															sizepercentx = "0",
															sizepercenty = "0",
															sizeType = "0",
															srcBlendFunc = "1",
															texturePath = "ui/explore/growup/command/skill/011.png",
															touchAble = "False",
															UILayoutViewModel = 
															{
																PositionY = 6,
															},
															width = "46",
															ZOrder = "1",
														},
													},
												},
											},
										},
										{
											controlID = "Panel_line2_Panel_lines_Panel_skillMap2_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
											UUID = "8a4eeb67_0b6d_4475_8f20_79f3e2ce0fe0",
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
											height = "10",
											ignoreSize = "False",
											name = "Panel_line2",
											rotation = "-45",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 259,
												PositionY = 226,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "10",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "Panel_dark_Panel_line2_Panel_lines_Panel_skillMap2_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
													UUID = "5ccbc1cb_d0cd_417b_88a4_15ed2d539346",
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
													height = "10",
													ignoreSize = "False",
													name = "Panel_dark",
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
													width = "10",
													ZOrder = "1",
													components = 
													{
														
														{
															controlID = "Image_line1_Panel_dark_Panel_line2_Panel_lines_Panel_skillMap2_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
															UUID = "533126f3_369c_45d3_b455_19626d65685c",
															anchorPoint = "False",
															anchorPointX = "0",
															anchorPointY = "0.5",
															backGroundScale9Enable = "True;capInsetsX:0;capInsetsY:0;capInsetsWidth:0;capInsetsHeight:0",
															classname = "MEImage",
															dstBlendFunc = "771",
															height = "28",
															ignoreSize = "False",
															name = "Image_line1",
															sizepercentx = "0",
															sizepercenty = "0",
															sizeType = "0",
															srcBlendFunc = "1",
															texturePath = "ui/explore/growup/command/skill/013.png",
															touchAble = "False",
															UILayoutViewModel = 
															{
																PositionY = 6,
															},
															width = "87",
															ZOrder = "1",
														},
													},
												},
												{
													controlID = "Panel_light_Panel_line2_Panel_lines_Panel_skillMap2_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
													UUID = "998d19a3_ce0a_48e7_8dd2_d91d58d70e50",
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
													height = "10",
													ignoreSize = "False",
													name = "Panel_light",
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
													width = "10",
													ZOrder = "1",
													components = 
													{
														
														{
															controlID = "Image_line1_Panel_light_Panel_line2_Panel_lines_Panel_skillMap2_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
															UUID = "845626e6_1364_4be0_a6b4_c26d1826b647",
															anchorPoint = "False",
															anchorPointX = "0",
															anchorPointY = "0.5",
															backGroundScale9Enable = "True;capInsetsX:0;capInsetsY:0;capInsetsWidth:0;capInsetsHeight:0",
															classname = "MEImage",
															dstBlendFunc = "771",
															height = "28",
															ignoreSize = "False",
															name = "Image_line1",
															sizepercentx = "0",
															sizepercenty = "0",
															sizeType = "0",
															srcBlendFunc = "1",
															texturePath = "ui/explore/growup/command/skill/011.png",
															touchAble = "False",
															UILayoutViewModel = 
															{
																PositionY = 6,
															},
															width = "86",
															ZOrder = "1",
														},
													},
												},
											},
										},
										{
											controlID = "Panel_line3_Panel_lines_Panel_skillMap2_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
											UUID = "a1e2bf5d_242d_42d0_a305_1df101b9f89e",
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
											height = "10",
											ignoreSize = "False",
											name = "Panel_line3",
											rotation = "45",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 377,
												PositionY = 286,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "10",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "Panel_dark_Panel_line3_Panel_lines_Panel_skillMap2_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
													UUID = "846b7dc3_d2c9_48f6_ac43_16d6d4540350",
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
													height = "10",
													ignoreSize = "False",
													name = "Panel_dark",
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
													width = "10",
													ZOrder = "1",
													components = 
													{
														
														{
															controlID = "Image_line1_Panel_dark_Panel_line3_Panel_lines_Panel_skillMap2_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
															UUID = "52765e55_20ad_491e_9be4_cab40a5d45a5",
															anchorPoint = "False",
															anchorPointX = "0",
															anchorPointY = "0.5",
															backGroundScale9Enable = "True;capInsetsX:0;capInsetsY:0;capInsetsWidth:0;capInsetsHeight:0",
															classname = "MEImage",
															dstBlendFunc = "771",
															height = "28",
															ignoreSize = "False",
															name = "Image_line1",
															sizepercentx = "0",
															sizepercenty = "0",
															sizeType = "0",
															srcBlendFunc = "1",
															texturePath = "ui/explore/growup/command/skill/013.png",
															touchAble = "False",
															UILayoutViewModel = 
															{
																PositionY = 6,
															},
															width = "84",
															ZOrder = "1",
														},
													},
												},
												{
													controlID = "Panel_light_Panel_line3_Panel_lines_Panel_skillMap2_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
													UUID = "6cd45bb3_9830_419d_85af_107210b85b52",
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
													height = "10",
													ignoreSize = "False",
													name = "Panel_light",
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
													width = "10",
													ZOrder = "1",
													components = 
													{
														
														{
															controlID = "Image_line1_Panel_light_Panel_line3_Panel_lines_Panel_skillMap2_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
															UUID = "ce066eb7_0d4e_4db1_acd7_88c714125904",
															anchorPoint = "False",
															anchorPointX = "0",
															anchorPointY = "0.5",
															backGroundScale9Enable = "True;capInsetsX:0;capInsetsY:0;capInsetsWidth:0;capInsetsHeight:0",
															classname = "MEImage",
															dstBlendFunc = "771",
															height = "28",
															ignoreSize = "False",
															name = "Image_line1",
															sizepercentx = "0",
															sizepercenty = "0",
															sizeType = "0",
															srcBlendFunc = "1",
															texturePath = "ui/explore/growup/command/skill/011.png",
															touchAble = "False",
															UILayoutViewModel = 
															{
																PositionY = 6,
															},
															width = "85",
															ZOrder = "1",
														},
													},
												},
											},
										},
										{
											controlID = "Panel_line4_Panel_lines_Panel_skillMap2_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
											UUID = "2c8a8510_9991_4705_a556_8331ee890049",
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
											height = "10",
											ignoreSize = "False",
											name = "Panel_line4",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 516,
												PositionY = 206,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "10",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "Panel_dark_Panel_line4_Panel_lines_Panel_skillMap2_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
													UUID = "70fca53e_5db2_4837_a632_1ed80bb7ce35",
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
													height = "10",
													ignoreSize = "False",
													name = "Panel_dark",
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
													width = "10",
													ZOrder = "1",
													components = 
													{
														
														{
															controlID = "Image_line1_Panel_dark_Panel_line4_Panel_lines_Panel_skillMap2_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
															UUID = "14ecb7a2_d5a0_4252_b94d_fd4f40a51a4b",
															anchorPoint = "False",
															anchorPointX = "0",
															anchorPointY = "0.5",
															backGroundScale9Enable = "True;capInsetsX:0;capInsetsY:0;capInsetsWidth:0;capInsetsHeight:0",
															classname = "MEImage",
															dstBlendFunc = "771",
															height = "28",
															ignoreSize = "False",
															name = "Image_line1",
															sizepercentx = "0",
															sizepercenty = "0",
															sizeType = "0",
															srcBlendFunc = "1",
															texturePath = "ui/explore/growup/command/skill/013.png",
															touchAble = "False",
															UILayoutViewModel = 
															{
																PositionY = 6,
															},
															width = "46",
															ZOrder = "1",
														},
													},
												},
												{
													controlID = "Panel_light_Panel_line4_Panel_lines_Panel_skillMap2_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
													UUID = "9b376417_9d9a_495b_93cf_ea16d51cc334",
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
													height = "10",
													ignoreSize = "False",
													name = "Panel_light",
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
													width = "10",
													ZOrder = "1",
													components = 
													{
														
														{
															controlID = "Image_line1_Panel_light_Panel_line4_Panel_lines_Panel_skillMap2_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
															UUID = "24a968ca_7c8a_4fa8_816d_4cb695fa3888",
															anchorPoint = "False",
															anchorPointX = "0",
															anchorPointY = "0.5",
															backGroundScale9Enable = "True;capInsetsX:0;capInsetsY:0;capInsetsWidth:0;capInsetsHeight:0",
															classname = "MEImage",
															dstBlendFunc = "771",
															height = "28",
															ignoreSize = "False",
															name = "Image_line1",
															sizepercentx = "0",
															sizepercenty = "0",
															sizeType = "0",
															srcBlendFunc = "1",
															texturePath = "ui/explore/growup/command/skill/011.png",
															touchAble = "False",
															UILayoutViewModel = 
															{
																PositionY = 6,
															},
															width = "46",
															ZOrder = "1",
														},
													},
												},
											},
										},
										{
											controlID = "Panel_line5_Panel_lines_Panel_skillMap2_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
											UUID = "db188742_7aec_4974_8200_3dd6fbfecdde",
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
											height = "10",
											ignoreSize = "False",
											name = "Panel_line5",
											rotation = "45",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 632,
												PositionY = 185,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "10",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "Panel_dark_Panel_line5_Panel_lines_Panel_skillMap2_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
													UUID = "fc629433_fd2d_4f68_bea1_0530cf9a4364",
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
													height = "10",
													ignoreSize = "False",
													name = "Panel_dark",
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
													width = "10",
													ZOrder = "1",
													components = 
													{
														
														{
															controlID = "Image_line1_Panel_dark_Panel_line5_Panel_lines_Panel_skillMap2_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
															UUID = "59cd865b_440b_4314_a4e5_56d86bb68e47",
															anchorPoint = "False",
															anchorPointX = "0",
															anchorPointY = "0.5",
															backGroundScale9Enable = "True;capInsetsX:0;capInsetsY:0;capInsetsWidth:0;capInsetsHeight:0",
															classname = "MEImage",
															dstBlendFunc = "771",
															height = "28",
															ignoreSize = "False",
															name = "Image_line1",
															sizepercentx = "0",
															sizepercenty = "0",
															sizeType = "0",
															srcBlendFunc = "1",
															texturePath = "ui/explore/growup/command/skill/013.png",
															touchAble = "False",
															UILayoutViewModel = 
															{
																PositionY = 6,
															},
															width = "84",
															ZOrder = "1",
														},
													},
												},
												{
													controlID = "Panel_light_Panel_line5_Panel_lines_Panel_skillMap2_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
													UUID = "6286ae57_9644_423b_a937_bc8c68e4ce1a",
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
													height = "10",
													ignoreSize = "False",
													name = "Panel_light",
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
													width = "10",
													ZOrder = "1",
													components = 
													{
														
														{
															controlID = "Image_line1_Panel_light_Panel_line5_Panel_lines_Panel_skillMap2_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
															UUID = "5d8226a6_0c2f_4ccf_ac26_c8b3f895aa0e",
															anchorPoint = "False",
															anchorPointX = "0",
															anchorPointY = "0.5",
															backGroundScale9Enable = "True;capInsetsX:0;capInsetsY:0;capInsetsWidth:0;capInsetsHeight:0",
															classname = "MEImage",
															dstBlendFunc = "771",
															height = "28",
															ignoreSize = "False",
															name = "Image_line1",
															sizepercentx = "0",
															sizepercenty = "0",
															sizeType = "0",
															srcBlendFunc = "1",
															texturePath = "ui/explore/growup/command/skill/011.png",
															touchAble = "False",
															UILayoutViewModel = 
															{
																PositionY = 6,
															},
															width = "85",
															ZOrder = "1",
														},
													},
												},
											},
										},
										{
											controlID = "Panel_line6_Panel_lines_Panel_skillMap2_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
											UUID = "1db7f5fb_2fce_4a52_882f_85f23b450b7d",
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
											height = "10",
											ignoreSize = "False",
											name = "Panel_line6",
											rotation = "-45",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 761,
												PositionY = 124,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "10",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "Panel_dark_Panel_line6_Panel_lines_Panel_skillMap2_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
													UUID = "d7d6b6e5_0542_4a7f_ba28_e4e541372235",
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
													height = "10",
													ignoreSize = "False",
													name = "Panel_dark",
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
													width = "10",
													ZOrder = "1",
													components = 
													{
														
														{
															controlID = "Image_line1_Panel_dark_Panel_line6_Panel_lines_Panel_skillMap2_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
															UUID = "7e1c8dd0_2d7f_42df_afd6_bd621337b57f",
															anchorPoint = "False",
															anchorPointX = "0",
															anchorPointY = "0.5",
															backGroundScale9Enable = "True;capInsetsX:0;capInsetsY:0;capInsetsWidth:0;capInsetsHeight:0",
															classname = "MEImage",
															dstBlendFunc = "771",
															height = "28",
															ignoreSize = "False",
															name = "Image_line1",
															sizepercentx = "0",
															sizepercenty = "0",
															sizeType = "0",
															srcBlendFunc = "1",
															texturePath = "ui/explore/growup/command/skill/013.png",
															touchAble = "False",
															UILayoutViewModel = 
															{
																PositionY = 6,
															},
															width = "87",
															ZOrder = "1",
														},
													},
												},
												{
													controlID = "Panel_light_Panel_line6_Panel_lines_Panel_skillMap2_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
													UUID = "28ebc795_f46f_4d3b_a8cd_839421f0f1fe",
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
													height = "10",
													ignoreSize = "False",
													name = "Panel_light",
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
													width = "10",
													ZOrder = "1",
													components = 
													{
														
														{
															controlID = "Image_line1_Panel_light_Panel_line6_Panel_lines_Panel_skillMap2_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
															UUID = "ac8f78ba_7461_4c3d_8089_55c044272153",
															anchorPoint = "False",
															anchorPointX = "0",
															anchorPointY = "0.5",
															backGroundScale9Enable = "True;capInsetsX:0;capInsetsY:0;capInsetsWidth:0;capInsetsHeight:0",
															classname = "MEImage",
															dstBlendFunc = "771",
															height = "28",
															ignoreSize = "False",
															name = "Image_line1",
															sizepercentx = "0",
															sizepercenty = "0",
															sizeType = "0",
															srcBlendFunc = "1",
															texturePath = "ui/explore/growup/command/skill/011.png",
															touchAble = "False",
															UILayoutViewModel = 
															{
																PositionY = 6,
															},
															width = "86",
															ZOrder = "1",
														},
													},
												},
											},
										},
										{
											controlID = "Panel_line7_Panel_lines_Panel_skillMap2_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
											UUID = "4c937d43_e2c8_4d9e_860b_ef37dcbd25c6",
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
											height = "10",
											ignoreSize = "False",
											name = "Panel_line7",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 893,
												PositionY = 206,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "10",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "Panel_dark_Panel_line7_Panel_lines_Panel_skillMap2_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
													UUID = "e4c77b12_5104_49b2_95c8_2f8077010c77",
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
													height = "10",
													ignoreSize = "False",
													name = "Panel_dark",
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
													width = "10",
													ZOrder = "1",
													components = 
													{
														
														{
															controlID = "Image_line1_Panel_dark_Panel_line7_Panel_lines_Panel_skillMap2_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
															UUID = "42ed2e4c_d4bf_4f94_ab55_10ff15619b2c",
															anchorPoint = "False",
															anchorPointX = "0",
															anchorPointY = "0.5",
															backGroundScale9Enable = "True;capInsetsX:0;capInsetsY:0;capInsetsWidth:0;capInsetsHeight:0",
															classname = "MEImage",
															dstBlendFunc = "771",
															height = "28",
															ignoreSize = "False",
															name = "Image_line1",
															sizepercentx = "0",
															sizepercenty = "0",
															sizeType = "0",
															srcBlendFunc = "1",
															texturePath = "ui/explore/growup/command/skill/013.png",
															touchAble = "False",
															UILayoutViewModel = 
															{
																PositionY = 6,
															},
															width = "46",
															ZOrder = "1",
														},
													},
												},
												{
													controlID = "Panel_light_Panel_line7_Panel_lines_Panel_skillMap2_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
													UUID = "636b49e4_0f78_4c0e_ad11_9e8a49bed4ce",
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
													height = "10",
													ignoreSize = "False",
													name = "Panel_light",
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
													width = "10",
													ZOrder = "1",
													components = 
													{
														
														{
															controlID = "Image_line1_Panel_light_Panel_line7_Panel_lines_Panel_skillMap2_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
															UUID = "b6555f31_9a3a_435d_a1cd_7feb569989ad",
															anchorPoint = "False",
															anchorPointX = "0",
															anchorPointY = "0.5",
															backGroundScale9Enable = "True;capInsetsX:0;capInsetsY:0;capInsetsWidth:0;capInsetsHeight:0",
															classname = "MEImage",
															dstBlendFunc = "771",
															height = "28",
															ignoreSize = "False",
															name = "Image_line1",
															sizepercentx = "0",
															sizepercenty = "0",
															sizeType = "0",
															srcBlendFunc = "1",
															texturePath = "ui/explore/growup/command/skill/011.png",
															touchAble = "False",
															UILayoutViewModel = 
															{
																PositionY = 6,
															},
															width = "46",
															ZOrder = "1",
														},
													},
												},
											},
										},
										{
											controlID = "Panel_line8_Panel_lines_Panel_skillMap2_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
											UUID = "42eee1cf_acfa_4310_9dc1_456e66a9f944",
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
											height = "10",
											ignoreSize = "False",
											name = "Panel_line8",
											rotation = "-45",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 1017,
												PositionY = 226,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "10",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "Panel_dark_Panel_line8_Panel_lines_Panel_skillMap2_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
													UUID = "f750634d_df5a_4e83_8d01_91b61be39e03",
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
													height = "10",
													ignoreSize = "False",
													name = "Panel_dark",
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
													width = "10",
													ZOrder = "1",
													components = 
													{
														
														{
															controlID = "Image_line1_Panel_dark_Panel_line8_Panel_lines_Panel_skillMap2_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
															UUID = "a7342b63_0ba0_49ab_8e8f_5a0551f6249f",
															anchorPoint = "False",
															anchorPointX = "0",
															anchorPointY = "0.5",
															backGroundScale9Enable = "True;capInsetsX:0;capInsetsY:0;capInsetsWidth:0;capInsetsHeight:0",
															classname = "MEImage",
															dstBlendFunc = "771",
															height = "28",
															ignoreSize = "False",
															name = "Image_line1",
															sizepercentx = "0",
															sizepercenty = "0",
															sizeType = "0",
															srcBlendFunc = "1",
															texturePath = "ui/explore/growup/command/skill/013.png",
															touchAble = "False",
															UILayoutViewModel = 
															{
																PositionY = 6,
															},
															width = "87",
															ZOrder = "1",
														},
													},
												},
												{
													controlID = "Panel_light_Panel_line8_Panel_lines_Panel_skillMap2_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
													UUID = "c7187aaf_fb5a_48ab_bcbe_6e5f3a85df81",
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
													height = "10",
													ignoreSize = "False",
													name = "Panel_light",
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
													width = "10",
													ZOrder = "1",
													components = 
													{
														
														{
															controlID = "Image_line1_Panel_light_Panel_line8_Panel_lines_Panel_skillMap2_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
															UUID = "fbb6fb68_25ae_4a55_afc6_11f7b69a883e",
															anchorPoint = "False",
															anchorPointX = "0",
															anchorPointY = "0.5",
															backGroundScale9Enable = "True;capInsetsX:0;capInsetsY:0;capInsetsWidth:0;capInsetsHeight:0",
															classname = "MEImage",
															dstBlendFunc = "771",
															height = "28",
															ignoreSize = "False",
															name = "Image_line1",
															sizepercentx = "0",
															sizepercenty = "0",
															sizeType = "0",
															srcBlendFunc = "1",
															texturePath = "ui/explore/growup/command/skill/011.png",
															touchAble = "False",
															UILayoutViewModel = 
															{
																PositionY = 6,
															},
															width = "86",
															ZOrder = "1",
														},
													},
												},
											},
										},
										{
											controlID = "Panel_line9_Panel_lines_Panel_skillMap2_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
											UUID = "0a40269d_f78c_4ed9_ab78_d3da3de69572",
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
											height = "10",
											ignoreSize = "False",
											name = "Panel_line9",
											rotation = "45",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 1135,
												PositionY = 286,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "10",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "Panel_dark_Panel_line9_Panel_lines_Panel_skillMap2_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
													UUID = "58aa8f00_e38a_46d3_9a1f_be3c7a493d60",
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
													height = "10",
													ignoreSize = "False",
													name = "Panel_dark",
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
													width = "10",
													ZOrder = "1",
													components = 
													{
														
														{
															controlID = "Image_line1_Panel_dark_Panel_line9_Panel_lines_Panel_skillMap2_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
															UUID = "2e4571d1_db91_4f82_a72c_f91682f5d55c",
															anchorPoint = "False",
															anchorPointX = "0",
															anchorPointY = "0.5",
															backGroundScale9Enable = "True;capInsetsX:0;capInsetsY:0;capInsetsWidth:0;capInsetsHeight:0",
															classname = "MEImage",
															dstBlendFunc = "771",
															height = "28",
															ignoreSize = "False",
															name = "Image_line1",
															sizepercentx = "0",
															sizepercenty = "0",
															sizeType = "0",
															srcBlendFunc = "1",
															texturePath = "ui/explore/growup/command/skill/013.png",
															touchAble = "False",
															UILayoutViewModel = 
															{
																PositionY = 6,
															},
															width = "84",
															ZOrder = "1",
														},
													},
												},
												{
													controlID = "Panel_light_Panel_line9_Panel_lines_Panel_skillMap2_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
													UUID = "19dbc2e8_ecd3_4ebd_8430_f4fb9834bdb7",
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
													height = "10",
													ignoreSize = "False",
													name = "Panel_light",
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
													width = "10",
													ZOrder = "1",
													components = 
													{
														
														{
															controlID = "Image_line1_Panel_light_Panel_line9_Panel_lines_Panel_skillMap2_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
															UUID = "05b8037f_d36b_425c_a0cd_ba6ed5d95007",
															anchorPoint = "False",
															anchorPointX = "0",
															anchorPointY = "0.5",
															backGroundScale9Enable = "True;capInsetsX:0;capInsetsY:0;capInsetsWidth:0;capInsetsHeight:0",
															classname = "MEImage",
															dstBlendFunc = "771",
															height = "28",
															ignoreSize = "False",
															name = "Image_line1",
															sizepercentx = "0",
															sizepercenty = "0",
															sizeType = "0",
															srcBlendFunc = "1",
															texturePath = "ui/explore/growup/command/skill/011.png",
															touchAble = "False",
															UILayoutViewModel = 
															{
																PositionY = 6,
															},
															width = "85",
															ZOrder = "1",
														},
													},
												},
											},
										},
										{
											controlID = "Panel_line10_Panel_lines_Panel_skillMap2_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
											UUID = "6a6515cc_d02a_4eb5_96f8_0d03d9c51e19",
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
											height = "10",
											ignoreSize = "False",
											name = "Panel_line10",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 1274,
												PositionY = 206,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "10",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "Panel_dark_Panel_line10_Panel_lines_Panel_skillMap2_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
													UUID = "139ab3f7_94fb_4eff_b36c_5b3295f45b45",
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
													height = "10",
													ignoreSize = "False",
													name = "Panel_dark",
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
													width = "10",
													ZOrder = "1",
													components = 
													{
														
														{
															controlID = "Image_line1_Panel_dark_Panel_line10_Panel_lines_Panel_skillMap2_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
															UUID = "19238489_2afc_4d34_b598_aa71d33323a1",
															anchorPoint = "False",
															anchorPointX = "0",
															anchorPointY = "0.5",
															backGroundScale9Enable = "True;capInsetsX:0;capInsetsY:0;capInsetsWidth:0;capInsetsHeight:0",
															classname = "MEImage",
															dstBlendFunc = "771",
															height = "28",
															ignoreSize = "False",
															name = "Image_line1",
															sizepercentx = "0",
															sizepercenty = "0",
															sizeType = "0",
															srcBlendFunc = "1",
															texturePath = "ui/explore/growup/command/skill/013.png",
															touchAble = "False",
															UILayoutViewModel = 
															{
																PositionY = 6,
															},
															width = "46",
															ZOrder = "1",
														},
													},
												},
												{
													controlID = "Panel_light_Panel_line10_Panel_lines_Panel_skillMap2_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
													UUID = "8f5460c0_90f7_450b_ab8f_c4559fe8dbb7",
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
													height = "10",
													ignoreSize = "False",
													name = "Panel_light",
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
													width = "10",
													ZOrder = "1",
													components = 
													{
														
														{
															controlID = "Image_line1_Panel_light_Panel_line10_Panel_lines_Panel_skillMap2_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
															UUID = "961fcc7d_1d6e_4fa6_aa6e_cc400ed98e81",
															anchorPoint = "False",
															anchorPointX = "0",
															anchorPointY = "0.5",
															backGroundScale9Enable = "True;capInsetsX:0;capInsetsY:0;capInsetsWidth:0;capInsetsHeight:0",
															classname = "MEImage",
															dstBlendFunc = "771",
															height = "28",
															ignoreSize = "False",
															name = "Image_line1",
															sizepercentx = "0",
															sizepercenty = "0",
															sizeType = "0",
															srcBlendFunc = "1",
															texturePath = "ui/explore/growup/command/skill/011.png",
															touchAble = "False",
															UILayoutViewModel = 
															{
																PositionY = 6,
															},
															width = "46",
															ZOrder = "1",
														},
													},
												},
											},
										},
										{
											controlID = "Panel_line11_Panel_lines_Panel_skillMap2_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
											UUID = "4ce53dbf_5160_4ad4_9e12_f062ba07bcd8",
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
											height = "10",
											ignoreSize = "False",
											name = "Panel_line11",
											rotation = "45",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 1390,
												PositionY = 185,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "10",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "Panel_dark_Panel_line11_Panel_lines_Panel_skillMap2_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
													UUID = "909e6876_d2a3_4ad0_8d88_3775c2da6628",
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
													height = "10",
													ignoreSize = "False",
													name = "Panel_dark",
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
													width = "10",
													ZOrder = "1",
													components = 
													{
														
														{
															controlID = "Image_line1_Panel_dark_Panel_line11_Panel_lines_Panel_skillMap2_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
															UUID = "9a1d1eba_1bf3_4d88_956c_ec00dfcf7050",
															anchorPoint = "False",
															anchorPointX = "0",
															anchorPointY = "0.5",
															backGroundScale9Enable = "True;capInsetsX:0;capInsetsY:0;capInsetsWidth:0;capInsetsHeight:0",
															classname = "MEImage",
															dstBlendFunc = "771",
															height = "28",
															ignoreSize = "False",
															name = "Image_line1",
															sizepercentx = "0",
															sizepercenty = "0",
															sizeType = "0",
															srcBlendFunc = "1",
															texturePath = "ui/explore/growup/command/skill/013.png",
															touchAble = "False",
															UILayoutViewModel = 
															{
																PositionY = 6,
															},
															width = "84",
															ZOrder = "1",
														},
													},
												},
												{
													controlID = "Panel_light_Panel_line11_Panel_lines_Panel_skillMap2_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
													UUID = "3bcbc6f5_4b69_4b57_a20e_74f5de100ca0",
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
													height = "10",
													ignoreSize = "False",
													name = "Panel_light",
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
													width = "10",
													ZOrder = "1",
													components = 
													{
														
														{
															controlID = "Image_line1_Panel_light_Panel_line11_Panel_lines_Panel_skillMap2_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
															UUID = "e6859801_e8b9_48b4_b1ea_f9d849d35707",
															anchorPoint = "False",
															anchorPointX = "0",
															anchorPointY = "0.5",
															backGroundScale9Enable = "True;capInsetsX:0;capInsetsY:0;capInsetsWidth:0;capInsetsHeight:0",
															classname = "MEImage",
															dstBlendFunc = "771",
															height = "28",
															ignoreSize = "False",
															name = "Image_line1",
															sizepercentx = "0",
															sizepercenty = "0",
															sizeType = "0",
															srcBlendFunc = "1",
															texturePath = "ui/explore/growup/command/skill/011.png",
															touchAble = "False",
															UILayoutViewModel = 
															{
																PositionY = 6,
															},
															width = "85",
															ZOrder = "1",
														},
													},
												},
											},
										},
										{
											controlID = "Panel_line12_Panel_lines_Panel_skillMap2_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
											UUID = "9c54d352_2c70_4211_8614_7ed1ca0062ee",
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
											height = "10",
											ignoreSize = "False",
											name = "Panel_line12",
											rotation = "-45",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 1519,
												PositionY = 124,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "10",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "Panel_dark_Panel_line12_Panel_lines_Panel_skillMap2_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
													UUID = "791b211b_f1d4_4c59_8bb5_a483b18a2918",
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
													height = "10",
													ignoreSize = "False",
													name = "Panel_dark",
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
													width = "10",
													ZOrder = "1",
													components = 
													{
														
														{
															controlID = "Image_line1_Panel_dark_Panel_line12_Panel_lines_Panel_skillMap2_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
															UUID = "82762143_bcd2_4d46_ad31_14efefa1e88d",
															anchorPoint = "False",
															anchorPointX = "0",
															anchorPointY = "0.5",
															backGroundScale9Enable = "True;capInsetsX:0;capInsetsY:0;capInsetsWidth:0;capInsetsHeight:0",
															classname = "MEImage",
															dstBlendFunc = "771",
															height = "28",
															ignoreSize = "False",
															name = "Image_line1",
															sizepercentx = "0",
															sizepercenty = "0",
															sizeType = "0",
															srcBlendFunc = "1",
															texturePath = "ui/explore/growup/command/skill/013.png",
															touchAble = "False",
															UILayoutViewModel = 
															{
																PositionY = 6,
															},
															width = "87",
															ZOrder = "1",
														},
													},
												},
												{
													controlID = "Panel_light_Panel_line12_Panel_lines_Panel_skillMap2_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
													UUID = "3043ad80_8205_4bf3_938b_7fb4b8b52ee8",
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
													height = "10",
													ignoreSize = "False",
													name = "Panel_light",
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
													width = "10",
													ZOrder = "1",
													components = 
													{
														
														{
															controlID = "Image_line1_Panel_light_Panel_line12_Panel_lines_Panel_skillMap2_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
															UUID = "9f46d74c_5948_477d_a13c_3b4a03aed86a",
															anchorPoint = "False",
															anchorPointX = "0",
															anchorPointY = "0.5",
															backGroundScale9Enable = "True;capInsetsX:0;capInsetsY:0;capInsetsWidth:0;capInsetsHeight:0",
															classname = "MEImage",
															dstBlendFunc = "771",
															height = "28",
															ignoreSize = "False",
															name = "Image_line1",
															sizepercentx = "0",
															sizepercenty = "0",
															sizeType = "0",
															srcBlendFunc = "1",
															texturePath = "ui/explore/growup/command/skill/011.png",
															touchAble = "False",
															UILayoutViewModel = 
															{
																PositionY = 6,
															},
															width = "86",
															ZOrder = "1",
														},
													},
												},
											},
										},
										{
											controlID = "Panel_line13_Panel_lines_Panel_skillMap2_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
											UUID = "f0a081b7_31bf_4b2f_865f_0602e1e2dad8",
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
											height = "10",
											ignoreSize = "False",
											name = "Panel_line13",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 1651,
												PositionY = 206,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "10",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "Panel_dark_Panel_line13_Panel_lines_Panel_skillMap2_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
													UUID = "02a4db4a_6e6c_4e7a_a6dd_20697ca55a52",
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
													height = "10",
													ignoreSize = "False",
													name = "Panel_dark",
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
													width = "10",
													ZOrder = "1",
													components = 
													{
														
														{
															controlID = "Image_line1_Panel_dark_Panel_line13_Panel_lines_Panel_skillMap2_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
															UUID = "4283c57c_7bb2_48a7_a6ba_4aa2d64192cb",
															anchorPoint = "False",
															anchorPointX = "0",
															anchorPointY = "0.5",
															backGroundScale9Enable = "True;capInsetsX:0;capInsetsY:0;capInsetsWidth:0;capInsetsHeight:0",
															classname = "MEImage",
															dstBlendFunc = "771",
															height = "28",
															ignoreSize = "False",
															name = "Image_line1",
															sizepercentx = "0",
															sizepercenty = "0",
															sizeType = "0",
															srcBlendFunc = "1",
															texturePath = "ui/explore/growup/command/skill/013.png",
															touchAble = "False",
															UILayoutViewModel = 
															{
																PositionY = 6,
															},
															width = "46",
															ZOrder = "1",
														},
													},
												},
												{
													controlID = "Panel_light_Panel_line13_Panel_lines_Panel_skillMap2_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
													UUID = "8a4f78e8_37b0_434a_93c6_607c7dc48eda",
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
													height = "10",
													ignoreSize = "False",
													name = "Panel_light",
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
													width = "10",
													ZOrder = "1",
													components = 
													{
														
														{
															controlID = "Image_line1_Panel_light_Panel_line13_Panel_lines_Panel_skillMap2_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
															UUID = "c353de6a_e799_45f5_815f_e81941ef76d4",
															anchorPoint = "False",
															anchorPointX = "0",
															anchorPointY = "0.5",
															backGroundScale9Enable = "True;capInsetsX:0;capInsetsY:0;capInsetsWidth:0;capInsetsHeight:0",
															classname = "MEImage",
															dstBlendFunc = "771",
															height = "28",
															ignoreSize = "False",
															name = "Image_line1",
															sizepercentx = "0",
															sizepercenty = "0",
															sizeType = "0",
															srcBlendFunc = "1",
															texturePath = "ui/explore/growup/command/skill/011.png",
															touchAble = "False",
															UILayoutViewModel = 
															{
																PositionY = 6,
															},
															width = "46",
															ZOrder = "1",
														},
													},
												},
											},
										},
										{
											controlID = "Panel_line14_Panel_lines_Panel_skillMap2_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
											UUID = "59cf3ee4_2e9d_4090_8e26_37fe59794495",
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
											height = "10",
											ignoreSize = "False",
											name = "Panel_line14",
											rotation = "-45",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 1775,
												PositionY = 226,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "10",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "Panel_dark_Panel_line14_Panel_lines_Panel_skillMap2_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
													UUID = "4823800f_8b1e_45c5_82dc_afb7f78bc147",
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
													height = "10",
													ignoreSize = "False",
													name = "Panel_dark",
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
													width = "10",
													ZOrder = "1",
													components = 
													{
														
														{
															controlID = "Image_line1_Panel_dark_Panel_line14_Panel_lines_Panel_skillMap2_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
															UUID = "361b8863_6917_4812_ab50_92284397f773",
															anchorPoint = "False",
															anchorPointX = "0",
															anchorPointY = "0.5",
															backGroundScale9Enable = "True;capInsetsX:0;capInsetsY:0;capInsetsWidth:0;capInsetsHeight:0",
															classname = "MEImage",
															dstBlendFunc = "771",
															height = "28",
															ignoreSize = "False",
															name = "Image_line1",
															sizepercentx = "0",
															sizepercenty = "0",
															sizeType = "0",
															srcBlendFunc = "1",
															texturePath = "ui/explore/growup/command/skill/013.png",
															touchAble = "False",
															UILayoutViewModel = 
															{
																PositionY = 6,
															},
															width = "87",
															ZOrder = "1",
														},
													},
												},
												{
													controlID = "Panel_light_Panel_line14_Panel_lines_Panel_skillMap2_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
													UUID = "ee44a287_47c8_4a63_9397_aa289cf41d0a",
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
													height = "10",
													ignoreSize = "False",
													name = "Panel_light",
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
													width = "10",
													ZOrder = "1",
													components = 
													{
														
														{
															controlID = "Image_line1_Panel_light_Panel_line14_Panel_lines_Panel_skillMap2_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
															UUID = "47438669_d5fa_4159_9e16_aaec8a044706",
															anchorPoint = "False",
															anchorPointX = "0",
															anchorPointY = "0.5",
															backGroundScale9Enable = "True;capInsetsX:0;capInsetsY:0;capInsetsWidth:0;capInsetsHeight:0",
															classname = "MEImage",
															dstBlendFunc = "771",
															height = "28",
															ignoreSize = "False",
															name = "Image_line1",
															sizepercentx = "0",
															sizepercenty = "0",
															sizeType = "0",
															srcBlendFunc = "1",
															texturePath = "ui/explore/growup/command/skill/011.png",
															touchAble = "False",
															UILayoutViewModel = 
															{
																PositionY = 6,
															},
															width = "86",
															ZOrder = "1",
														},
													},
												},
											},
										},
										{
											controlID = "Panel_line15_Panel_lines_Panel_skillMap2_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
											UUID = "a08ebdf6_4e92_4a5c_b5af_878e4bbdc1f1",
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
											height = "10",
											ignoreSize = "False",
											name = "Panel_line15",
											rotation = "45",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 1893,
												PositionY = 286,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "10",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "Panel_dark_Panel_line15_Panel_lines_Panel_skillMap2_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
													UUID = "1ea5f2ec_70c5_406a_a357_cf124b6d8545",
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
													height = "10",
													ignoreSize = "False",
													name = "Panel_dark",
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
													width = "10",
													ZOrder = "1",
													components = 
													{
														
														{
															controlID = "Image_line1_Panel_dark_Panel_line15_Panel_lines_Panel_skillMap2_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
															UUID = "6c26e132_f836_42af_8105_ff4794857178",
															anchorPoint = "False",
															anchorPointX = "0",
															anchorPointY = "0.5",
															backGroundScale9Enable = "True;capInsetsX:0;capInsetsY:0;capInsetsWidth:0;capInsetsHeight:0",
															classname = "MEImage",
															dstBlendFunc = "771",
															height = "28",
															ignoreSize = "False",
															name = "Image_line1",
															sizepercentx = "0",
															sizepercenty = "0",
															sizeType = "0",
															srcBlendFunc = "1",
															texturePath = "ui/explore/growup/command/skill/013.png",
															touchAble = "False",
															UILayoutViewModel = 
															{
																PositionY = 6,
															},
															width = "84",
															ZOrder = "1",
														},
													},
												},
												{
													controlID = "Panel_light_Panel_line15_Panel_lines_Panel_skillMap2_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
													UUID = "101177cb_3e47_450a_9ba5_4095aefd852b",
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
													height = "10",
													ignoreSize = "False",
													name = "Panel_light",
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
													width = "10",
													ZOrder = "1",
													components = 
													{
														
														{
															controlID = "Image_line1_Panel_light_Panel_line15_Panel_lines_Panel_skillMap2_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
															UUID = "13b3b1fd_4418_4592_b0b3_8e533d92b62f",
															anchorPoint = "False",
															anchorPointX = "0",
															anchorPointY = "0.5",
															backGroundScale9Enable = "True;capInsetsX:0;capInsetsY:0;capInsetsWidth:0;capInsetsHeight:0",
															classname = "MEImage",
															dstBlendFunc = "771",
															height = "28",
															ignoreSize = "False",
															name = "Image_line1",
															sizepercentx = "0",
															sizepercenty = "0",
															sizeType = "0",
															srcBlendFunc = "1",
															texturePath = "ui/explore/growup/command/skill/011.png",
															touchAble = "False",
															UILayoutViewModel = 
															{
																PositionY = 6,
															},
															width = "85",
															ZOrder = "1",
														},
													},
												},
											},
										},
										{
											controlID = "Panel_line16_Panel_lines_Panel_skillMap2_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
											UUID = "09f93f8c_057e_425f_a339_d011be1b8051",
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
											height = "10",
											ignoreSize = "False",
											name = "Panel_line16",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 2032,
												PositionY = 206,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "10",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "Panel_dark_Panel_line16_Panel_lines_Panel_skillMap2_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
													UUID = "0b39fd3f_c774_495c_8a35_fce2b66032ac",
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
													height = "10",
													ignoreSize = "False",
													name = "Panel_dark",
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
													width = "10",
													ZOrder = "1",
													components = 
													{
														
														{
															controlID = "Image_line1_Panel_dark_Panel_line16_Panel_lines_Panel_skillMap2_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
															UUID = "e9c237bf_40ff_49a2_b874_5df485c638a2",
															anchorPoint = "False",
															anchorPointX = "0",
															anchorPointY = "0.5",
															backGroundScale9Enable = "True;capInsetsX:0;capInsetsY:0;capInsetsWidth:0;capInsetsHeight:0",
															classname = "MEImage",
															dstBlendFunc = "771",
															height = "28",
															ignoreSize = "False",
															name = "Image_line1",
															sizepercentx = "0",
															sizepercenty = "0",
															sizeType = "0",
															srcBlendFunc = "1",
															texturePath = "ui/explore/growup/command/skill/013.png",
															touchAble = "False",
															UILayoutViewModel = 
															{
																PositionY = 6,
															},
															width = "46",
															ZOrder = "1",
														},
													},
												},
												{
													controlID = "Panel_light_Panel_line16_Panel_lines_Panel_skillMap2_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
													UUID = "b372d307_3de6_4659_8f67_d20149fc6c3d",
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
													height = "10",
													ignoreSize = "False",
													name = "Panel_light",
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
													width = "10",
													ZOrder = "1",
													components = 
													{
														
														{
															controlID = "Image_line1_Panel_light_Panel_line16_Panel_lines_Panel_skillMap2_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
															UUID = "8711cbbf_2387_48f9_9282_a619e5c905e1",
															anchorPoint = "False",
															anchorPointX = "0",
															anchorPointY = "0.5",
															backGroundScale9Enable = "True;capInsetsX:0;capInsetsY:0;capInsetsWidth:0;capInsetsHeight:0",
															classname = "MEImage",
															dstBlendFunc = "771",
															height = "28",
															ignoreSize = "False",
															name = "Image_line1",
															sizepercentx = "0",
															sizepercenty = "0",
															sizeType = "0",
															srcBlendFunc = "1",
															texturePath = "ui/explore/growup/command/skill/011.png",
															touchAble = "False",
															UILayoutViewModel = 
															{
																PositionY = 6,
															},
															width = "46",
															ZOrder = "1",
														},
													},
												},
											},
										},
										{
											controlID = "Panel_line17_Panel_lines_Panel_skillMap2_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
											UUID = "dc56c1c0_3346_4fc6_81f7_0450fee408c8",
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
											height = "10",
											ignoreSize = "False",
											name = "Panel_line17",
											rotation = "45",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 2148,
												PositionY = 185,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "10",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "Panel_dark_Panel_line17_Panel_lines_Panel_skillMap2_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
													UUID = "71f107b9_7ab2_468f_b4da_17bea1e91efc",
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
													height = "10",
													ignoreSize = "False",
													name = "Panel_dark",
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
													width = "10",
													ZOrder = "1",
													components = 
													{
														
														{
															controlID = "Image_line1_Panel_dark_Panel_line17_Panel_lines_Panel_skillMap2_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
															UUID = "6e9bcb5e_c49a_40e6_abe1_37d7fa6bbadc",
															anchorPoint = "False",
															anchorPointX = "0",
															anchorPointY = "0.5",
															backGroundScale9Enable = "True;capInsetsX:0;capInsetsY:0;capInsetsWidth:0;capInsetsHeight:0",
															classname = "MEImage",
															dstBlendFunc = "771",
															height = "28",
															ignoreSize = "False",
															name = "Image_line1",
															sizepercentx = "0",
															sizepercenty = "0",
															sizeType = "0",
															srcBlendFunc = "1",
															texturePath = "ui/explore/growup/command/skill/013.png",
															touchAble = "False",
															UILayoutViewModel = 
															{
																PositionY = 6,
															},
															width = "84",
															ZOrder = "1",
														},
													},
												},
												{
													controlID = "Panel_light_Panel_line17_Panel_lines_Panel_skillMap2_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
													UUID = "7a5c85be_c8a4_43e3_8fb1_e67911bf89bf",
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
													height = "10",
													ignoreSize = "False",
													name = "Panel_light",
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
													width = "10",
													ZOrder = "1",
													components = 
													{
														
														{
															controlID = "Image_line1_Panel_light_Panel_line17_Panel_lines_Panel_skillMap2_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
															UUID = "a4eb894f_1fa4_411f_a006_4d73720d9e14",
															anchorPoint = "False",
															anchorPointX = "0",
															anchorPointY = "0.5",
															backGroundScale9Enable = "True;capInsetsX:0;capInsetsY:0;capInsetsWidth:0;capInsetsHeight:0",
															classname = "MEImage",
															dstBlendFunc = "771",
															height = "28",
															ignoreSize = "False",
															name = "Image_line1",
															sizepercentx = "0",
															sizepercenty = "0",
															sizeType = "0",
															srcBlendFunc = "1",
															texturePath = "ui/explore/growup/command/skill/011.png",
															touchAble = "False",
															UILayoutViewModel = 
															{
																PositionY = 6,
															},
															width = "85",
															ZOrder = "1",
														},
													},
												},
											},
										},
										{
											controlID = "Panel_line18_Panel_lines_Panel_skillMap2_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
											UUID = "1926a704_990a_441b_bb78_65adcf70fefa",
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
											height = "10",
											ignoreSize = "False",
											name = "Panel_line18",
											rotation = "-45",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 2277,
												PositionY = 124,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "10",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "Panel_dark_Panel_line18_Panel_lines_Panel_skillMap2_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
													UUID = "4cf3e073_75d2_469a_b238_456b334827d3",
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
													height = "10",
													ignoreSize = "False",
													name = "Panel_dark",
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
													width = "10",
													ZOrder = "1",
													components = 
													{
														
														{
															controlID = "Image_line1_Panel_dark_Panel_line18_Panel_lines_Panel_skillMap2_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
															UUID = "323c06ba_f1ec_4dbc_87a3_55448a535cfb",
															anchorPoint = "False",
															anchorPointX = "0",
															anchorPointY = "0.5",
															backGroundScale9Enable = "True;capInsetsX:0;capInsetsY:0;capInsetsWidth:0;capInsetsHeight:0",
															classname = "MEImage",
															dstBlendFunc = "771",
															height = "28",
															ignoreSize = "False",
															name = "Image_line1",
															sizepercentx = "0",
															sizepercenty = "0",
															sizeType = "0",
															srcBlendFunc = "1",
															texturePath = "ui/explore/growup/command/skill/013.png",
															touchAble = "False",
															UILayoutViewModel = 
															{
																PositionY = 6,
															},
															width = "87",
															ZOrder = "1",
														},
													},
												},
												{
													controlID = "Panel_light_Panel_line18_Panel_lines_Panel_skillMap2_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
													UUID = "8ebcf906_98fb_45c6_a02f_8a52d204a6b1",
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
													height = "10",
													ignoreSize = "False",
													name = "Panel_light",
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
													width = "10",
													ZOrder = "1",
													components = 
													{
														
														{
															controlID = "Image_line1_Panel_light_Panel_line18_Panel_lines_Panel_skillMap2_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
															UUID = "00394817_cf6a_4120_b107_0eb5631ea48d",
															anchorPoint = "False",
															anchorPointX = "0",
															anchorPointY = "0.5",
															backGroundScale9Enable = "True;capInsetsX:0;capInsetsY:0;capInsetsWidth:0;capInsetsHeight:0",
															classname = "MEImage",
															dstBlendFunc = "771",
															height = "28",
															ignoreSize = "False",
															name = "Image_line1",
															sizepercentx = "0",
															sizepercenty = "0",
															sizeType = "0",
															srcBlendFunc = "1",
															texturePath = "ui/explore/growup/command/skill/011.png",
															touchAble = "False",
															UILayoutViewModel = 
															{
																PositionY = 6,
															},
															width = "86",
															ZOrder = "1",
														},
													},
												},
											},
										},
										{
											controlID = "Panel_line19_Panel_lines_Panel_skillMap2_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
											UUID = "ec8efcb8_56f6_43f0_b8ac_10e359a07a6b",
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
											height = "10",
											ignoreSize = "False",
											name = "Panel_line19",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 2409,
												PositionY = 206,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "10",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "Panel_dark_Panel_line19_Panel_lines_Panel_skillMap2_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
													UUID = "0866bb74_c875_4804_b2f5_ec2fb8c14286",
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
													height = "10",
													ignoreSize = "False",
													name = "Panel_dark",
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
													width = "10",
													ZOrder = "1",
													components = 
													{
														
														{
															controlID = "Image_line1_Panel_dark_Panel_line19_Panel_lines_Panel_skillMap2_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
															UUID = "5647fa1e_7810_4cb6_8301_9c5808f74b0a",
															anchorPoint = "False",
															anchorPointX = "0",
															anchorPointY = "0.5",
															backGroundScale9Enable = "True;capInsetsX:0;capInsetsY:0;capInsetsWidth:0;capInsetsHeight:0",
															classname = "MEImage",
															dstBlendFunc = "771",
															height = "28",
															ignoreSize = "False",
															name = "Image_line1",
															sizepercentx = "0",
															sizepercenty = "0",
															sizeType = "0",
															srcBlendFunc = "1",
															texturePath = "ui/explore/growup/command/skill/013.png",
															touchAble = "False",
															UILayoutViewModel = 
															{
																PositionY = 6,
															},
															width = "46",
															ZOrder = "1",
														},
													},
												},
												{
													controlID = "Panel_light_Panel_line19_Panel_lines_Panel_skillMap2_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
													UUID = "7322d0e2_e769_4307_bf95_29c76ee9c7ba",
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
													height = "10",
													ignoreSize = "False",
													name = "Panel_light",
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
													width = "10",
													ZOrder = "1",
													components = 
													{
														
														{
															controlID = "Image_line1_Panel_light_Panel_line19_Panel_lines_Panel_skillMap2_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
															UUID = "7c233da1_7a32_4202_bc68_df396e3503a2",
															anchorPoint = "False",
															anchorPointX = "0",
															anchorPointY = "0.5",
															backGroundScale9Enable = "True;capInsetsX:0;capInsetsY:0;capInsetsWidth:0;capInsetsHeight:0",
															classname = "MEImage",
															dstBlendFunc = "771",
															height = "28",
															ignoreSize = "False",
															name = "Image_line1",
															sizepercentx = "0",
															sizepercenty = "0",
															sizeType = "0",
															srcBlendFunc = "1",
															texturePath = "ui/explore/growup/command/skill/011.png",
															touchAble = "False",
															UILayoutViewModel = 
															{
																PositionY = 6,
															},
															width = "46",
															ZOrder = "1",
														},
													},
												},
											},
										},
										{
											controlID = "Panel_line20_Panel_lines_Panel_skillMap2_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
											UUID = "1bc54d7d_71da_4fed_9215_76fdb6441159",
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
											height = "10",
											ignoreSize = "False",
											name = "Panel_line20",
											rotation = "-45",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 2533,
												PositionY = 226,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "10",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "Panel_dark_Panel_line20_Panel_lines_Panel_skillMap2_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
													UUID = "d58fb239_95a0_4afa_8706_7109724b540f",
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
													height = "10",
													ignoreSize = "False",
													name = "Panel_dark",
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
													width = "10",
													ZOrder = "1",
													components = 
													{
														
														{
															controlID = "Image_line1_Panel_dark_Panel_line20_Panel_lines_Panel_skillMap2_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
															UUID = "76826c0e_b698_4106_a262_f35cb2836259",
															anchorPoint = "False",
															anchorPointX = "0",
															anchorPointY = "0.5",
															backGroundScale9Enable = "True;capInsetsX:0;capInsetsY:0;capInsetsWidth:0;capInsetsHeight:0",
															classname = "MEImage",
															dstBlendFunc = "771",
															height = "28",
															ignoreSize = "False",
															name = "Image_line1",
															sizepercentx = "0",
															sizepercenty = "0",
															sizeType = "0",
															srcBlendFunc = "1",
															texturePath = "ui/explore/growup/command/skill/013.png",
															touchAble = "False",
															UILayoutViewModel = 
															{
																PositionY = 6,
															},
															width = "87",
															ZOrder = "1",
														},
													},
												},
												{
													controlID = "Panel_light_Panel_line20_Panel_lines_Panel_skillMap2_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
													UUID = "4c662992_5f00_4ff3_8489_d645028bd3f3",
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
													height = "10",
													ignoreSize = "False",
													name = "Panel_light",
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
													width = "10",
													ZOrder = "1",
													components = 
													{
														
														{
															controlID = "Image_line1_Panel_light_Panel_line20_Panel_lines_Panel_skillMap2_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
															UUID = "d2f1e893_9f5f_4888_9eef_c97a35b4e6af",
															anchorPoint = "False",
															anchorPointX = "0",
															anchorPointY = "0.5",
															backGroundScale9Enable = "True;capInsetsX:0;capInsetsY:0;capInsetsWidth:0;capInsetsHeight:0",
															classname = "MEImage",
															dstBlendFunc = "771",
															height = "28",
															ignoreSize = "False",
															name = "Image_line1",
															sizepercentx = "0",
															sizepercenty = "0",
															sizeType = "0",
															srcBlendFunc = "1",
															texturePath = "ui/explore/growup/command/skill/011.png",
															touchAble = "False",
															UILayoutViewModel = 
															{
																PositionY = 6,
															},
															width = "86",
															ZOrder = "1",
														},
													},
												},
											},
										},
										{
											controlID = "Panel_line21_Panel_lines_Panel_skillMap2_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
											UUID = "2c7e9c78_2463_4c83_b3fb_7eab4db5848e",
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
											height = "10",
											ignoreSize = "False",
											name = "Panel_line21",
											rotation = "45",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 2651,
												PositionY = 286,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "10",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "Panel_dark_Panel_line21_Panel_lines_Panel_skillMap2_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
													UUID = "4fc62444_8c74_4f78_a7cd_ffa53d1c47f5",
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
													height = "10",
													ignoreSize = "False",
													name = "Panel_dark",
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
													width = "10",
													ZOrder = "1",
													components = 
													{
														
														{
															controlID = "Image_line1_Panel_dark_Panel_line21_Panel_lines_Panel_skillMap2_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
															UUID = "893a5f99_0a81_43c3_b54e_845a4c54ff10",
															anchorPoint = "False",
															anchorPointX = "0",
															anchorPointY = "0.5",
															backGroundScale9Enable = "True;capInsetsX:0;capInsetsY:0;capInsetsWidth:0;capInsetsHeight:0",
															classname = "MEImage",
															dstBlendFunc = "771",
															height = "28",
															ignoreSize = "False",
															name = "Image_line1",
															sizepercentx = "0",
															sizepercenty = "0",
															sizeType = "0",
															srcBlendFunc = "1",
															texturePath = "ui/explore/growup/command/skill/013.png",
															touchAble = "False",
															UILayoutViewModel = 
															{
																PositionY = 6,
															},
															width = "84",
															ZOrder = "1",
														},
													},
												},
												{
													controlID = "Panel_light_Panel_line21_Panel_lines_Panel_skillMap2_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
													UUID = "0b4440b4_ca3f_4334_ab20_86883a313789",
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
													height = "10",
													ignoreSize = "False",
													name = "Panel_light",
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
													width = "10",
													ZOrder = "1",
													components = 
													{
														
														{
															controlID = "Image_line1_Panel_light_Panel_line21_Panel_lines_Panel_skillMap2_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
															UUID = "b17cd494_bd1f_4ae1_b449_6b3437585624",
															anchorPoint = "False",
															anchorPointX = "0",
															anchorPointY = "0.5",
															backGroundScale9Enable = "True;capInsetsX:0;capInsetsY:0;capInsetsWidth:0;capInsetsHeight:0",
															classname = "MEImage",
															dstBlendFunc = "771",
															height = "28",
															ignoreSize = "False",
															name = "Image_line1",
															sizepercentx = "0",
															sizepercenty = "0",
															sizeType = "0",
															srcBlendFunc = "1",
															texturePath = "ui/explore/growup/command/skill/011.png",
															touchAble = "False",
															UILayoutViewModel = 
															{
																PositionY = 6,
															},
															width = "85",
															ZOrder = "1",
														},
													},
												},
											},
										},
										{
											controlID = "Panel_line22_Panel_lines_Panel_skillMap2_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
											UUID = "8bb52300_caa6_42ce_82f3_e873eb016cdb",
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
											height = "10",
											ignoreSize = "False",
											name = "Panel_line22",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 2790,
												PositionY = 206,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "10",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "Panel_dark_Panel_line22_Panel_lines_Panel_skillMap2_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
													UUID = "fdb74a8f_24fd_4b8f_a2e6_ceb9c2b9e1fc",
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
													height = "10",
													ignoreSize = "False",
													name = "Panel_dark",
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
													width = "10",
													ZOrder = "1",
													components = 
													{
														
														{
															controlID = "Image_line1_Panel_dark_Panel_line22_Panel_lines_Panel_skillMap2_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
															UUID = "b72a1b45_08e3_4d15_a6c9_70d06caf281f",
															anchorPoint = "False",
															anchorPointX = "0",
															anchorPointY = "0.5",
															backGroundScale9Enable = "True;capInsetsX:0;capInsetsY:0;capInsetsWidth:0;capInsetsHeight:0",
															classname = "MEImage",
															dstBlendFunc = "771",
															height = "28",
															ignoreSize = "False",
															name = "Image_line1",
															sizepercentx = "0",
															sizepercenty = "0",
															sizeType = "0",
															srcBlendFunc = "1",
															texturePath = "ui/explore/growup/command/skill/013.png",
															touchAble = "False",
															UILayoutViewModel = 
															{
																PositionY = 6,
															},
															width = "46",
															ZOrder = "1",
														},
													},
												},
												{
													controlID = "Panel_light_Panel_line22_Panel_lines_Panel_skillMap2_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
													UUID = "ceb65815_b859_4b52_a6f4_c7e0ee348f21",
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
													height = "10",
													ignoreSize = "False",
													name = "Panel_light",
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
													width = "10",
													ZOrder = "1",
													components = 
													{
														
														{
															controlID = "Image_line1_Panel_light_Panel_line22_Panel_lines_Panel_skillMap2_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
															UUID = "32ff7f0e_8c9f_4173_87ca_485001fdc6be",
															anchorPoint = "False",
															anchorPointX = "0",
															anchorPointY = "0.5",
															backGroundScale9Enable = "True;capInsetsX:0;capInsetsY:0;capInsetsWidth:0;capInsetsHeight:0",
															classname = "MEImage",
															dstBlendFunc = "771",
															height = "28",
															ignoreSize = "False",
															name = "Image_line1",
															sizepercentx = "0",
															sizepercenty = "0",
															sizeType = "0",
															srcBlendFunc = "1",
															texturePath = "ui/explore/growup/command/skill/011.png",
															touchAble = "False",
															UILayoutViewModel = 
															{
																PositionY = 6,
															},
															width = "46",
															ZOrder = "1",
														},
													},
												},
											},
										},
										{
											controlID = "Panel_line23_Panel_lines_Panel_skillMap2_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
											UUID = "2c224f88_a61b_46b6_880f_abf8cb9b2bbd",
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
											height = "10",
											ignoreSize = "False",
											name = "Panel_line23",
											rotation = "45",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 2906,
												PositionY = 185,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "10",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "Panel_dark_Panel_line23_Panel_lines_Panel_skillMap2_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
													UUID = "7b28dc9d_4a4b_426a_8e70_d61bf4c4f988",
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
													height = "10",
													ignoreSize = "False",
													name = "Panel_dark",
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
													width = "10",
													ZOrder = "1",
													components = 
													{
														
														{
															controlID = "Image_line1_Panel_dark_Panel_line23_Panel_lines_Panel_skillMap2_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
															UUID = "5ced4857_36f8_4efb_aef0_aed68336ce60",
															anchorPoint = "False",
															anchorPointX = "0",
															anchorPointY = "0.5",
															backGroundScale9Enable = "True;capInsetsX:0;capInsetsY:0;capInsetsWidth:0;capInsetsHeight:0",
															classname = "MEImage",
															dstBlendFunc = "771",
															height = "28",
															ignoreSize = "False",
															name = "Image_line1",
															sizepercentx = "0",
															sizepercenty = "0",
															sizeType = "0",
															srcBlendFunc = "1",
															texturePath = "ui/explore/growup/command/skill/013.png",
															touchAble = "False",
															UILayoutViewModel = 
															{
																PositionY = 6,
															},
															width = "84",
															ZOrder = "1",
														},
													},
												},
												{
													controlID = "Panel_light_Panel_line23_Panel_lines_Panel_skillMap2_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
													UUID = "7d37eb23_c376_456a_8c55_0d262728f73e",
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
													height = "10",
													ignoreSize = "False",
													name = "Panel_light",
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
													width = "10",
													ZOrder = "1",
													components = 
													{
														
														{
															controlID = "Image_line1_Panel_light_Panel_line23_Panel_lines_Panel_skillMap2_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
															UUID = "d3d45d42_6613_470f_8df5_85ff0696b307",
															anchorPoint = "False",
															anchorPointX = "0",
															anchorPointY = "0.5",
															backGroundScale9Enable = "True;capInsetsX:0;capInsetsY:0;capInsetsWidth:0;capInsetsHeight:0",
															classname = "MEImage",
															dstBlendFunc = "771",
															height = "28",
															ignoreSize = "False",
															name = "Image_line1",
															sizepercentx = "0",
															sizepercenty = "0",
															sizeType = "0",
															srcBlendFunc = "1",
															texturePath = "ui/explore/growup/command/skill/011.png",
															touchAble = "False",
															UILayoutViewModel = 
															{
																PositionY = 6,
															},
															width = "85",
															ZOrder = "1",
														},
													},
												},
											},
										},
										{
											controlID = "Panel_line24_Panel_lines_Panel_skillMap2_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
											UUID = "8d55a7a5_8b78_4e71_a276_388938138388",
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
											height = "10",
											ignoreSize = "False",
											name = "Panel_line24",
											rotation = "-45",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 3035,
												PositionY = 124,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "10",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "Panel_dark_Panel_line24_Panel_lines_Panel_skillMap2_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
													UUID = "a39b9a37_b053_4fe4_b956_55857da860a8",
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
													height = "10",
													ignoreSize = "False",
													name = "Panel_dark",
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
													width = "10",
													ZOrder = "1",
													components = 
													{
														
														{
															controlID = "Image_line1_Panel_dark_Panel_line24_Panel_lines_Panel_skillMap2_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
															UUID = "b37f2b20_aa0e_4402_9272_e88d9178a026",
															anchorPoint = "False",
															anchorPointX = "0",
															anchorPointY = "0.5",
															backGroundScale9Enable = "True;capInsetsX:0;capInsetsY:0;capInsetsWidth:0;capInsetsHeight:0",
															classname = "MEImage",
															dstBlendFunc = "771",
															height = "28",
															ignoreSize = "False",
															name = "Image_line1",
															sizepercentx = "0",
															sizepercenty = "0",
															sizeType = "0",
															srcBlendFunc = "1",
															texturePath = "ui/explore/growup/command/skill/013.png",
															touchAble = "False",
															UILayoutViewModel = 
															{
																PositionY = 6,
															},
															width = "87",
															ZOrder = "1",
														},
													},
												},
												{
													controlID = "Panel_light_Panel_line24_Panel_lines_Panel_skillMap2_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
													UUID = "70c347df_e809_4192_b2df_b5246db39eae",
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
													height = "10",
													ignoreSize = "False",
													name = "Panel_light",
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
													width = "10",
													ZOrder = "1",
													components = 
													{
														
														{
															controlID = "Image_line1_Panel_light_Panel_line24_Panel_lines_Panel_skillMap2_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
															UUID = "f0b84743_acb3_417d_ab80_d57d240620bb",
															anchorPoint = "False",
															anchorPointX = "0",
															anchorPointY = "0.5",
															backGroundScale9Enable = "True;capInsetsX:0;capInsetsY:0;capInsetsWidth:0;capInsetsHeight:0",
															classname = "MEImage",
															dstBlendFunc = "771",
															height = "28",
															ignoreSize = "False",
															name = "Image_line1",
															sizepercentx = "0",
															sizepercenty = "0",
															sizeType = "0",
															srcBlendFunc = "1",
															texturePath = "ui/explore/growup/command/skill/011.png",
															touchAble = "False",
															UILayoutViewModel = 
															{
																PositionY = 6,
															},
															width = "86",
															ZOrder = "1",
														},
													},
												},
											},
										},
										{
											controlID = "Panel_line25_Panel_lines_Panel_skillMap2_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
											UUID = "dcbcf081_164d_4361_aa7e_3ced0b9fe69c",
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
											height = "10",
											ignoreSize = "False",
											name = "Panel_line25",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 3167,
												PositionY = 206,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "10",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "Panel_dark_Panel_line25_Panel_lines_Panel_skillMap2_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
													UUID = "f59de9bb_c07a_4916_a071_59ee26cc8c3b",
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
													height = "10",
													ignoreSize = "False",
													name = "Panel_dark",
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
													width = "10",
													ZOrder = "1",
													components = 
													{
														
														{
															controlID = "Image_line1_Panel_dark_Panel_line25_Panel_lines_Panel_skillMap2_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
															UUID = "0757e587_290a_4da6_adbb_821172259daa",
															anchorPoint = "False",
															anchorPointX = "0",
															anchorPointY = "0.5",
															backGroundScale9Enable = "True;capInsetsX:0;capInsetsY:0;capInsetsWidth:0;capInsetsHeight:0",
															classname = "MEImage",
															dstBlendFunc = "771",
															height = "28",
															ignoreSize = "False",
															name = "Image_line1",
															sizepercentx = "0",
															sizepercenty = "0",
															sizeType = "0",
															srcBlendFunc = "1",
															texturePath = "ui/explore/growup/command/skill/013.png",
															touchAble = "False",
															UILayoutViewModel = 
															{
																PositionY = 6,
															},
															width = "46",
															ZOrder = "1",
														},
													},
												},
												{
													controlID = "Panel_light_Panel_line25_Panel_lines_Panel_skillMap2_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
													UUID = "5600c7d2_56d8_43ea_b566_37739209b0d1",
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
													height = "10",
													ignoreSize = "False",
													name = "Panel_light",
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
													width = "10",
													ZOrder = "1",
													components = 
													{
														
														{
															controlID = "Image_line1_Panel_light_Panel_line25_Panel_lines_Panel_skillMap2_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
															UUID = "7cb41e87_0c3d_4bb0_bca4_6923d1ee40b4",
															anchorPoint = "False",
															anchorPointX = "0",
															anchorPointY = "0.5",
															backGroundScale9Enable = "True;capInsetsX:0;capInsetsY:0;capInsetsWidth:0;capInsetsHeight:0",
															classname = "MEImage",
															dstBlendFunc = "771",
															height = "28",
															ignoreSize = "False",
															name = "Image_line1",
															sizepercentx = "0",
															sizepercenty = "0",
															sizeType = "0",
															srcBlendFunc = "1",
															texturePath = "ui/explore/growup/command/skill/011.png",
															touchAble = "False",
															UILayoutViewModel = 
															{
																PositionY = 6,
															},
															width = "46",
															ZOrder = "1",
														},
													},
												},
											},
										},
										{
											controlID = "Panel_line26_Panel_lines_Panel_skillMap2_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
											UUID = "a88e6127_1e38_49bf_8f3a_f5423e629b88",
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
											height = "10",
											ignoreSize = "False",
											name = "Panel_line26",
											rotation = "-45",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 3291,
												PositionY = 226,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "10",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "Panel_dark_Panel_line26_Panel_lines_Panel_skillMap2_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
													UUID = "287bdcb7_a0d1_410b_b452_b9bcd1631a44",
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
													height = "10",
													ignoreSize = "False",
													name = "Panel_dark",
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
													width = "10",
													ZOrder = "1",
													components = 
													{
														
														{
															controlID = "Image_line1_Panel_dark_Panel_line26_Panel_lines_Panel_skillMap2_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
															UUID = "e0aaabdb_f7ba_4091_bf17_8b5a92e1ef89",
															anchorPoint = "False",
															anchorPointX = "0",
															anchorPointY = "0.5",
															backGroundScale9Enable = "True;capInsetsX:0;capInsetsY:0;capInsetsWidth:0;capInsetsHeight:0",
															classname = "MEImage",
															dstBlendFunc = "771",
															height = "28",
															ignoreSize = "False",
															name = "Image_line1",
															sizepercentx = "0",
															sizepercenty = "0",
															sizeType = "0",
															srcBlendFunc = "1",
															texturePath = "ui/explore/growup/command/skill/013.png",
															touchAble = "False",
															UILayoutViewModel = 
															{
																PositionY = 6,
															},
															width = "87",
															ZOrder = "1",
														},
													},
												},
												{
													controlID = "Panel_light_Panel_line26_Panel_lines_Panel_skillMap2_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
													UUID = "003fcbe8_3668_483f_ae32_77840fe2141c",
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
													height = "10",
													ignoreSize = "False",
													name = "Panel_light",
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
													width = "10",
													ZOrder = "1",
													components = 
													{
														
														{
															controlID = "Image_line1_Panel_light_Panel_line26_Panel_lines_Panel_skillMap2_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
															UUID = "0a434125_08d6_4963_9ce5_65dc26b9271f",
															anchorPoint = "False",
															anchorPointX = "0",
															anchorPointY = "0.5",
															backGroundScale9Enable = "True;capInsetsX:0;capInsetsY:0;capInsetsWidth:0;capInsetsHeight:0",
															classname = "MEImage",
															dstBlendFunc = "771",
															height = "28",
															ignoreSize = "False",
															name = "Image_line1",
															sizepercentx = "0",
															sizepercenty = "0",
															sizeType = "0",
															srcBlendFunc = "1",
															texturePath = "ui/explore/growup/command/skill/011.png",
															touchAble = "False",
															UILayoutViewModel = 
															{
																PositionY = 6,
															},
															width = "86",
															ZOrder = "1",
														},
													},
												},
											},
										},
										{
											controlID = "Panel_line27_Panel_lines_Panel_skillMap2_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
											UUID = "0673d13f_13db_43e5_a861_a2a4babf8476",
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
											height = "10",
											ignoreSize = "False",
											name = "Panel_line27",
											rotation = "45",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 3409,
												PositionY = 286,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "10",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "Panel_dark_Panel_line27_Panel_lines_Panel_skillMap2_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
													UUID = "ccfd15b9_e578_4e6f_9fae_ea3d23f6f05e",
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
													height = "10",
													ignoreSize = "False",
													name = "Panel_dark",
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
													width = "10",
													ZOrder = "1",
													components = 
													{
														
														{
															controlID = "Image_line1_Panel_dark_Panel_line27_Panel_lines_Panel_skillMap2_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
															UUID = "9965079f_66e5_48e6_ae3d_b12fb6fab5bf",
															anchorPoint = "False",
															anchorPointX = "0",
															anchorPointY = "0.5",
															backGroundScale9Enable = "True;capInsetsX:0;capInsetsY:0;capInsetsWidth:0;capInsetsHeight:0",
															classname = "MEImage",
															dstBlendFunc = "771",
															height = "28",
															ignoreSize = "False",
															name = "Image_line1",
															sizepercentx = "0",
															sizepercenty = "0",
															sizeType = "0",
															srcBlendFunc = "1",
															texturePath = "ui/explore/growup/command/skill/013.png",
															touchAble = "False",
															UILayoutViewModel = 
															{
																PositionY = 6,
															},
															width = "84",
															ZOrder = "1",
														},
													},
												},
												{
													controlID = "Panel_light_Panel_line27_Panel_lines_Panel_skillMap2_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
													UUID = "284600d9_14b4_484b_a76e_386312042d60",
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
													height = "10",
													ignoreSize = "False",
													name = "Panel_light",
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
													width = "10",
													ZOrder = "1",
													components = 
													{
														
														{
															controlID = "Image_line1_Panel_light_Panel_line27_Panel_lines_Panel_skillMap2_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
															UUID = "188110d1_afea_4f9f_871e_1ee887ba096c",
															anchorPoint = "False",
															anchorPointX = "0",
															anchorPointY = "0.5",
															backGroundScale9Enable = "True;capInsetsX:0;capInsetsY:0;capInsetsWidth:0;capInsetsHeight:0",
															classname = "MEImage",
															dstBlendFunc = "771",
															height = "28",
															ignoreSize = "False",
															name = "Image_line1",
															sizepercentx = "0",
															sizepercenty = "0",
															sizeType = "0",
															srcBlendFunc = "1",
															texturePath = "ui/explore/growup/command/skill/011.png",
															touchAble = "False",
															UILayoutViewModel = 
															{
																PositionY = 6,
															},
															width = "85",
															ZOrder = "1",
														},
													},
												},
											},
										},
										{
											controlID = "Panel_line28_Panel_lines_Panel_skillMap2_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
											UUID = "6292fcdc_6971_4563_ac15_043905c54cfd",
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
											height = "10",
											ignoreSize = "False",
											name = "Panel_line28",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 3548,
												PositionY = 206,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "10",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "Panel_dark_Panel_line28_Panel_lines_Panel_skillMap2_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
													UUID = "c927ebf6_f45d_4de0_b205_7baa88de02a2",
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
													height = "10",
													ignoreSize = "False",
													name = "Panel_dark",
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
													width = "10",
													ZOrder = "1",
													components = 
													{
														
														{
															controlID = "Image_line1_Panel_dark_Panel_line28_Panel_lines_Panel_skillMap2_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
															UUID = "6ea2427f_e033_445a_8e67_3fe0920b964d",
															anchorPoint = "False",
															anchorPointX = "0",
															anchorPointY = "0.5",
															backGroundScale9Enable = "True;capInsetsX:0;capInsetsY:0;capInsetsWidth:0;capInsetsHeight:0",
															classname = "MEImage",
															dstBlendFunc = "771",
															height = "28",
															ignoreSize = "False",
															name = "Image_line1",
															sizepercentx = "0",
															sizepercenty = "0",
															sizeType = "0",
															srcBlendFunc = "1",
															texturePath = "ui/explore/growup/command/skill/013.png",
															touchAble = "False",
															UILayoutViewModel = 
															{
																PositionY = 6,
															},
															width = "46",
															ZOrder = "1",
														},
													},
												},
												{
													controlID = "Panel_light_Panel_line28_Panel_lines_Panel_skillMap2_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
													UUID = "411ea047_fcc0_4245_b008_c52ba8d764a3",
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
													height = "10",
													ignoreSize = "False",
													name = "Panel_light",
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
													width = "10",
													ZOrder = "1",
													components = 
													{
														
														{
															controlID = "Image_line1_Panel_light_Panel_line28_Panel_lines_Panel_skillMap2_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
															UUID = "f0f3d207_1fd6_4412_a72f_2e74899ea217",
															anchorPoint = "False",
															anchorPointX = "0",
															anchorPointY = "0.5",
															backGroundScale9Enable = "True;capInsetsX:0;capInsetsY:0;capInsetsWidth:0;capInsetsHeight:0",
															classname = "MEImage",
															dstBlendFunc = "771",
															height = "28",
															ignoreSize = "False",
															name = "Image_line1",
															sizepercentx = "0",
															sizepercenty = "0",
															sizeType = "0",
															srcBlendFunc = "1",
															texturePath = "ui/explore/growup/command/skill/011.png",
															touchAble = "False",
															UILayoutViewModel = 
															{
																PositionY = 6,
															},
															width = "46",
															ZOrder = "1",
														},
													},
												},
											},
										},
										{
											controlID = "Panel_line29_Panel_lines_Panel_skillMap2_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
											UUID = "b806f4d7_e7b7_457d_87db_460bb9bba85a",
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
											height = "10",
											ignoreSize = "False",
											name = "Panel_line29",
											rotation = "45",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 3664,
												PositionY = 185,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "10",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "Panel_dark_Panel_line29_Panel_lines_Panel_skillMap2_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
													UUID = "538c42f4_0589_4d8d_b97c_4e2efef3e264",
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
													height = "10",
													ignoreSize = "False",
													name = "Panel_dark",
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
													width = "10",
													ZOrder = "1",
													components = 
													{
														
														{
															controlID = "Image_line1_Panel_dark_Panel_line29_Panel_lines_Panel_skillMap2_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
															UUID = "5589186e_5ca3_44bc_909e_ddec1b350f7d",
															anchorPoint = "False",
															anchorPointX = "0",
															anchorPointY = "0.5",
															backGroundScale9Enable = "True;capInsetsX:0;capInsetsY:0;capInsetsWidth:0;capInsetsHeight:0",
															classname = "MEImage",
															dstBlendFunc = "771",
															height = "28",
															ignoreSize = "False",
															name = "Image_line1",
															sizepercentx = "0",
															sizepercenty = "0",
															sizeType = "0",
															srcBlendFunc = "1",
															texturePath = "ui/explore/growup/command/skill/013.png",
															touchAble = "False",
															UILayoutViewModel = 
															{
																PositionY = 6,
															},
															width = "84",
															ZOrder = "1",
														},
													},
												},
												{
													controlID = "Panel_light_Panel_line29_Panel_lines_Panel_skillMap2_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
													UUID = "e3abbefd_d180_4e50_8fac_123c601ba97d",
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
													height = "10",
													ignoreSize = "False",
													name = "Panel_light",
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
													width = "10",
													ZOrder = "1",
													components = 
													{
														
														{
															controlID = "Image_line1_Panel_light_Panel_line29_Panel_lines_Panel_skillMap2_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
															UUID = "5bb1eaae_52eb_4713_8b4b_549578c32710",
															anchorPoint = "False",
															anchorPointX = "0",
															anchorPointY = "0.5",
															backGroundScale9Enable = "True;capInsetsX:0;capInsetsY:0;capInsetsWidth:0;capInsetsHeight:0",
															classname = "MEImage",
															dstBlendFunc = "771",
															height = "28",
															ignoreSize = "False",
															name = "Image_line1",
															sizepercentx = "0",
															sizepercenty = "0",
															sizeType = "0",
															srcBlendFunc = "1",
															texturePath = "ui/explore/growup/command/skill/011.png",
															touchAble = "False",
															UILayoutViewModel = 
															{
																PositionY = 6,
															},
															width = "85",
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
							controlID = "Panel_skillMap3_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
							UUID = "721f3a82_8eaf_4693_bb99_0ca77e66a331",
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
							height = "403",
							ignoreSize = "False",
							name = "Panel_skillMap3",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							touchAble = "False",
							UILayoutViewModel = 
							{
								PositionX = 8,
								PositionY = -219,
							},
							uipanelviewmodel = 
							{
								Layout="Absolute",
								nType = "0"
							},
							width = "3796",
							ZOrder = "1",
							components = 
							{
								
								{
									controlID = "Panel_points_Panel_skillMap3_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
									UUID = "baf087fb_42e0_4130_a113_f310c9ab687c",
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
									name = "Panel_points",
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
									width = "400",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "Panel_point1_Panel_points_Panel_skillMap3_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
											UUID = "b89546c3_395c_429d_b37d_a425dcf7af6e",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											bgColorOpacity = "50",
											bIsOpenClipping = "False",
											classname = "MEPanel",
											colorType = "1;SingleColor:#FFFF0000;GraduallyChangingColorStart:#FFFFFFFF;GraduallyChangingColorEnd:#FFFFFFFF;vectorX:0;vectorY:0",
											DesignHeight = "640",
											DesignType = "0",
											DesignWidth = "960",
											dstBlendFunc = "771",
											height = "10",
											ignoreSize = "False",
											name = "Panel_point1",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 93,
												PositionY = 210,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "10",
											ZOrder = "1",
										},
										{
											controlID = "Panel_point2_Panel_points_Panel_skillMap3_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
											UUID = "4f29ba0e_0dcf_4bcb_9727_18a5edbbd14c",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											bgColorOpacity = "50",
											bIsOpenClipping = "False",
											classname = "MEPanel",
											colorType = "1;SingleColor:#FFFF0000;GraduallyChangingColorStart:#FFFFFFFF;GraduallyChangingColorEnd:#FFFFFFFF;vectorX:0;vectorY:0",
											DesignHeight = "640",
											DesignType = "0",
											DesignWidth = "960",
											dstBlendFunc = "771",
											height = "10",
											ignoreSize = "False",
											name = "Panel_point2",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 223,
												PositionY = 209,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "10",
											ZOrder = "1",
										},
										{
											controlID = "Panel_point3_Panel_points_Panel_skillMap3_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
											UUID = "e8005dda_6bcd_4f34_9914_d4cc42ebfa6c",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											bgColorOpacity = "50",
											bIsOpenClipping = "False",
											classname = "MEPanel",
											colorType = "1;SingleColor:#FFFF0000;GraduallyChangingColorStart:#FFFFFFFF;GraduallyChangingColorEnd:#FFFFFFFF;vectorX:0;vectorY:0",
											DesignHeight = "640",
											DesignType = "0",
											DesignWidth = "960",
											dstBlendFunc = "771",
											height = "10",
											ignoreSize = "False",
											name = "Panel_point3",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 349,
												PositionY = 310,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "10",
											ZOrder = "1",
										},
										{
											controlID = "Panel_point4_Panel_points_Panel_skillMap3_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
											UUID = "1cfa9432_b810_4be3_95c0_c98e3d157617",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											bgColorOpacity = "50",
											bIsOpenClipping = "False",
											classname = "MEPanel",
											colorType = "1;SingleColor:#FFFF0000;GraduallyChangingColorStart:#FFFFFFFF;GraduallyChangingColorEnd:#FFFFFFFF;vectorX:0;vectorY:0",
											DesignHeight = "640",
											DesignType = "0",
											DesignWidth = "960",
											dstBlendFunc = "771",
											height = "10",
											ignoreSize = "False",
											name = "Panel_point4",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 473,
												PositionY = 209,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "10",
											ZOrder = "1",
										},
										{
											controlID = "Panel_point5_Panel_points_Panel_skillMap3_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
											UUID = "ec2c6476_4fd0_492b_ac5d_96444ca2b8f5",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											bgColorOpacity = "50",
											bIsOpenClipping = "False",
											classname = "MEPanel",
											colorType = "1;SingleColor:#FFFF0000;GraduallyChangingColorStart:#FFFFFFFF;GraduallyChangingColorEnd:#FFFFFFFF;vectorX:0;vectorY:0",
											DesignHeight = "640",
											DesignType = "0",
											DesignWidth = "960",
											dstBlendFunc = "771",
											height = "10",
											ignoreSize = "False",
											name = "Panel_point5",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 604,
												PositionY = 209,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "10",
											ZOrder = "1",
										},
										{
											controlID = "Panel_point6_Panel_points_Panel_skillMap3_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
											UUID = "65ea05c6_aa91_421d_bf75_da95123761c1",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											bgColorOpacity = "50",
											bIsOpenClipping = "False",
											classname = "MEPanel",
											colorType = "1;SingleColor:#FFFF0000;GraduallyChangingColorStart:#FFFFFFFF;GraduallyChangingColorEnd:#FFFFFFFF;vectorX:0;vectorY:0",
											DesignHeight = "640",
											DesignType = "0",
											DesignWidth = "960",
											dstBlendFunc = "771",
											height = "10",
											ignoreSize = "False",
											name = "Panel_point6",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 726,
												PositionY = 108,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "10",
											ZOrder = "1",
										},
										{
											controlID = "Panel_point7_Panel_points_Panel_skillMap3_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
											UUID = "b33a1821_f3ff_457d_b733_e81b602db5f3",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											bgColorOpacity = "50",
											bIsOpenClipping = "False",
											classname = "MEPanel",
											colorType = "1;SingleColor:#FFFF0000;GraduallyChangingColorStart:#FFFFFFFF;GraduallyChangingColorEnd:#FFFFFFFF;vectorX:0;vectorY:0",
											DesignHeight = "640",
											DesignType = "0",
											DesignWidth = "960",
											dstBlendFunc = "771",
											height = "10",
											ignoreSize = "False",
											name = "Panel_point7",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 851,
												PositionY = 209,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "10",
											ZOrder = "1",
										},
										{
											controlID = "Panel_point8_Panel_points_Panel_skillMap3_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
											UUID = "f2d20357_a84d_4761_a9bb_624bd0af6309",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											bgColorOpacity = "50",
											bIsOpenClipping = "False",
											classname = "MEPanel",
											colorType = "1;SingleColor:#FFFF0000;GraduallyChangingColorStart:#FFFFFFFF;GraduallyChangingColorEnd:#FFFFFFFF;vectorX:0;vectorY:0",
											DesignHeight = "640",
											DesignType = "0",
											DesignWidth = "960",
											dstBlendFunc = "771",
											height = "10",
											ignoreSize = "False",
											name = "Panel_point8",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 981,
												PositionY = 208,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "10",
											ZOrder = "1",
										},
										{
											controlID = "Panel_point9_Panel_points_Panel_skillMap3_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
											UUID = "5172a890_0fe9_4f45_a6ac_124dc0b3b5bd",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											bgColorOpacity = "50",
											bIsOpenClipping = "False",
											classname = "MEPanel",
											colorType = "1;SingleColor:#FFFF0000;GraduallyChangingColorStart:#FFFFFFFF;GraduallyChangingColorEnd:#FFFFFFFF;vectorX:0;vectorY:0",
											DesignHeight = "640",
											DesignType = "0",
											DesignWidth = "960",
											dstBlendFunc = "771",
											height = "10",
											ignoreSize = "False",
											name = "Panel_point9",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 1107,
												PositionY = 309,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "10",
											ZOrder = "1",
										},
										{
											controlID = "Panel_point10_Panel_points_Panel_skillMap3_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
											UUID = "f612de4e_b62b_4b60_844d_ec863d1d0b3a",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											bgColorOpacity = "50",
											bIsOpenClipping = "False",
											classname = "MEPanel",
											colorType = "1;SingleColor:#FFFF0000;GraduallyChangingColorStart:#FFFFFFFF;GraduallyChangingColorEnd:#FFFFFFFF;vectorX:0;vectorY:0",
											DesignHeight = "640",
											DesignType = "0",
											DesignWidth = "960",
											dstBlendFunc = "771",
											height = "10",
											ignoreSize = "False",
											name = "Panel_point10",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 1231,
												PositionY = 208,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "10",
											ZOrder = "1",
										},
										{
											controlID = "Panel_point11_Panel_points_Panel_skillMap3_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
											UUID = "b115d418_2a1a_4423_a629_cc936e5603b4",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											bgColorOpacity = "50",
											bIsOpenClipping = "False",
											classname = "MEPanel",
											colorType = "1;SingleColor:#FFFF0000;GraduallyChangingColorStart:#FFFFFFFF;GraduallyChangingColorEnd:#FFFFFFFF;vectorX:0;vectorY:0",
											DesignHeight = "640",
											DesignType = "0",
											DesignWidth = "960",
											dstBlendFunc = "771",
											height = "10",
											ignoreSize = "False",
											name = "Panel_point11",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 1362,
												PositionY = 208,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "10",
											ZOrder = "1",
										},
										{
											controlID = "Panel_point12_Panel_points_Panel_skillMap3_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
											UUID = "91877eac_712b_4b30_86a7_a1e5db05b7ae",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											bgColorOpacity = "50",
											bIsOpenClipping = "False",
											classname = "MEPanel",
											colorType = "1;SingleColor:#FFFF0000;GraduallyChangingColorStart:#FFFFFFFF;GraduallyChangingColorEnd:#FFFFFFFF;vectorX:0;vectorY:0",
											DesignHeight = "640",
											DesignType = "0",
											DesignWidth = "960",
											dstBlendFunc = "771",
											height = "10",
											ignoreSize = "False",
											name = "Panel_point12",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 1484,
												PositionY = 107,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "10",
											ZOrder = "1",
										},
										{
											controlID = "Panel_point13_Panel_points_Panel_skillMap3_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
											UUID = "3ea42733_6fff_4616_8776_c802cf9a8297",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											bgColorOpacity = "50",
											bIsOpenClipping = "False",
											classname = "MEPanel",
											colorType = "1;SingleColor:#FFFF0000;GraduallyChangingColorStart:#FFFFFFFF;GraduallyChangingColorEnd:#FFFFFFFF;vectorX:0;vectorY:0",
											DesignHeight = "640",
											DesignType = "0",
											DesignWidth = "960",
											dstBlendFunc = "771",
											height = "10",
											ignoreSize = "False",
											name = "Panel_point13",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 1608,
												PositionY = 210,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "10",
											ZOrder = "1",
										},
										{
											controlID = "Panel_point14_Panel_points_Panel_skillMap3_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
											UUID = "1f796d5b_cb6e_4945_aada_479c16d65f56",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											bgColorOpacity = "50",
											bIsOpenClipping = "False",
											classname = "MEPanel",
											colorType = "1;SingleColor:#FFFF0000;GraduallyChangingColorStart:#FFFFFFFF;GraduallyChangingColorEnd:#FFFFFFFF;vectorX:0;vectorY:0",
											DesignHeight = "640",
											DesignType = "0",
											DesignWidth = "960",
											dstBlendFunc = "771",
											height = "10",
											ignoreSize = "False",
											name = "Panel_point14",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 1738,
												PositionY = 209,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "10",
											ZOrder = "1",
										},
										{
											controlID = "Panel_point15_Panel_points_Panel_skillMap3_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
											UUID = "884fd750_5934_4d9c_9d89_0ab68dc1dfc8",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											bgColorOpacity = "50",
											bIsOpenClipping = "False",
											classname = "MEPanel",
											colorType = "1;SingleColor:#FFFF0000;GraduallyChangingColorStart:#FFFFFFFF;GraduallyChangingColorEnd:#FFFFFFFF;vectorX:0;vectorY:0",
											DesignHeight = "640",
											DesignType = "0",
											DesignWidth = "960",
											dstBlendFunc = "771",
											height = "10",
											ignoreSize = "False",
											name = "Panel_point15",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 1864,
												PositionY = 310,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "10",
											ZOrder = "1",
										},
										{
											controlID = "Panel_point16_Panel_points_Panel_skillMap3_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
											UUID = "9ac38f2d_e1c7_4566_ab4e_21e04cad156b",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											bgColorOpacity = "50",
											bIsOpenClipping = "False",
											classname = "MEPanel",
											colorType = "1;SingleColor:#FFFF0000;GraduallyChangingColorStart:#FFFFFFFF;GraduallyChangingColorEnd:#FFFFFFFF;vectorX:0;vectorY:0",
											DesignHeight = "640",
											DesignType = "0",
											DesignWidth = "960",
											dstBlendFunc = "771",
											height = "10",
											ignoreSize = "False",
											name = "Panel_point16",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 1988,
												PositionY = 209,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "10",
											ZOrder = "1",
										},
										{
											controlID = "Panel_point17_Panel_points_Panel_skillMap3_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
											UUID = "11e70601_cbb2_4041_a68a_5b7539a39754",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											bgColorOpacity = "50",
											bIsOpenClipping = "False",
											classname = "MEPanel",
											colorType = "1;SingleColor:#FFFF0000;GraduallyChangingColorStart:#FFFFFFFF;GraduallyChangingColorEnd:#FFFFFFFF;vectorX:0;vectorY:0",
											DesignHeight = "640",
											DesignType = "0",
											DesignWidth = "960",
											dstBlendFunc = "771",
											height = "10",
											ignoreSize = "False",
											name = "Panel_point17",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 2119,
												PositionY = 209,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "10",
											ZOrder = "1",
										},
										{
											controlID = "Panel_point18_Panel_points_Panel_skillMap3_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
											UUID = "9c42677b_c183_453e_99e5_276a653aa11c",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											bgColorOpacity = "50",
											bIsOpenClipping = "False",
											classname = "MEPanel",
											colorType = "1;SingleColor:#FFFF0000;GraduallyChangingColorStart:#FFFFFFFF;GraduallyChangingColorEnd:#FFFFFFFF;vectorX:0;vectorY:0",
											DesignHeight = "640",
											DesignType = "0",
											DesignWidth = "960",
											dstBlendFunc = "771",
											height = "10",
											ignoreSize = "False",
											name = "Panel_point18",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 2241,
												PositionY = 108,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "10",
											ZOrder = "1",
										},
										{
											controlID = "Panel_point19_Panel_points_Panel_skillMap3_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
											UUID = "aa7fa01e_4e06_46ed_8cb9_512da94b9605",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											bgColorOpacity = "50",
											bIsOpenClipping = "False",
											classname = "MEPanel",
											colorType = "1;SingleColor:#FFFF0000;GraduallyChangingColorStart:#FFFFFFFF;GraduallyChangingColorEnd:#FFFFFFFF;vectorX:0;vectorY:0",
											DesignHeight = "640",
											DesignType = "0",
											DesignWidth = "960",
											dstBlendFunc = "771",
											height = "10",
											ignoreSize = "False",
											name = "Panel_point19",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 2366,
												PositionY = 209,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "10",
											ZOrder = "1",
										},
										{
											controlID = "Panel_point20_Panel_points_Panel_skillMap3_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
											UUID = "c713ba71_5d38_411d_9992_c4a89cab493c",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											bgColorOpacity = "50",
											bIsOpenClipping = "False",
											classname = "MEPanel",
											colorType = "1;SingleColor:#FFFF0000;GraduallyChangingColorStart:#FFFFFFFF;GraduallyChangingColorEnd:#FFFFFFFF;vectorX:0;vectorY:0",
											DesignHeight = "640",
											DesignType = "0",
											DesignWidth = "960",
											dstBlendFunc = "771",
											height = "10",
											ignoreSize = "False",
											name = "Panel_point20",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 2496,
												PositionY = 208,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "10",
											ZOrder = "1",
										},
										{
											controlID = "Panel_point21_Panel_points_Panel_skillMap3_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
											UUID = "8be8a485_2769_4f57_93a3_012239d2dd64",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											bgColorOpacity = "50",
											bIsOpenClipping = "False",
											classname = "MEPanel",
											colorType = "1;SingleColor:#FFFF0000;GraduallyChangingColorStart:#FFFFFFFF;GraduallyChangingColorEnd:#FFFFFFFF;vectorX:0;vectorY:0",
											DesignHeight = "640",
											DesignType = "0",
											DesignWidth = "960",
											dstBlendFunc = "771",
											height = "10",
											ignoreSize = "False",
											name = "Panel_point21",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 2622,
												PositionY = 309,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "10",
											ZOrder = "1",
										},
										{
											controlID = "Panel_point22_Panel_points_Panel_skillMap3_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
											UUID = "297b24f3_4cb1_4b11_b70a_f27aeb1b8b95",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											bgColorOpacity = "50",
											bIsOpenClipping = "False",
											classname = "MEPanel",
											colorType = "1;SingleColor:#FFFF0000;GraduallyChangingColorStart:#FFFFFFFF;GraduallyChangingColorEnd:#FFFFFFFF;vectorX:0;vectorY:0",
											DesignHeight = "640",
											DesignType = "0",
											DesignWidth = "960",
											dstBlendFunc = "771",
											height = "10",
											ignoreSize = "False",
											name = "Panel_point22",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 2746,
												PositionY = 208,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "10",
											ZOrder = "1",
										},
										{
											controlID = "Panel_point23_Panel_points_Panel_skillMap3_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
											UUID = "ec5e3700_af21_489f_bc23_4f14ec3243c4",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											bgColorOpacity = "50",
											bIsOpenClipping = "False",
											classname = "MEPanel",
											colorType = "1;SingleColor:#FFFF0000;GraduallyChangingColorStart:#FFFFFFFF;GraduallyChangingColorEnd:#FFFFFFFF;vectorX:0;vectorY:0",
											DesignHeight = "640",
											DesignType = "0",
											DesignWidth = "960",
											dstBlendFunc = "771",
											height = "10",
											ignoreSize = "False",
											name = "Panel_point23",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 2877,
												PositionY = 208,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "10",
											ZOrder = "1",
										},
										{
											controlID = "Panel_point24_Panel_points_Panel_skillMap3_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
											UUID = "5d27cc96_4320_43f4_aa5e_3f1619d088f4",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											bgColorOpacity = "50",
											bIsOpenClipping = "False",
											classname = "MEPanel",
											colorType = "1;SingleColor:#FFFF0000;GraduallyChangingColorStart:#FFFFFFFF;GraduallyChangingColorEnd:#FFFFFFFF;vectorX:0;vectorY:0",
											DesignHeight = "640",
											DesignType = "0",
											DesignWidth = "960",
											dstBlendFunc = "771",
											height = "10",
											ignoreSize = "False",
											name = "Panel_point24",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 2999,
												PositionY = 107,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "10",
											ZOrder = "1",
										},
										{
											controlID = "Panel_point25_Panel_points_Panel_skillMap3_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
											UUID = "e4e4e226_f41d_429f_aed0_7aea1f189c25",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											bgColorOpacity = "50",
											bIsOpenClipping = "False",
											classname = "MEPanel",
											colorType = "1;SingleColor:#FFFF0000;GraduallyChangingColorStart:#FFFFFFFF;GraduallyChangingColorEnd:#FFFFFFFF;vectorX:0;vectorY:0",
											DesignHeight = "640",
											DesignType = "0",
											DesignWidth = "960",
											dstBlendFunc = "771",
											height = "10",
											ignoreSize = "False",
											name = "Panel_point25",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 3122,
												PositionY = 209,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "10",
											ZOrder = "1",
										},
										{
											controlID = "Panel_point26_Panel_points_Panel_skillMap3_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
											UUID = "f033a8a6_cbed_4731_98fd_4af97517b3e2",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											bgColorOpacity = "50",
											bIsOpenClipping = "False",
											classname = "MEPanel",
											colorType = "1;SingleColor:#FFFF0000;GraduallyChangingColorStart:#FFFFFFFF;GraduallyChangingColorEnd:#FFFFFFFF;vectorX:0;vectorY:0",
											DesignHeight = "640",
											DesignType = "0",
											DesignWidth = "960",
											dstBlendFunc = "771",
											height = "10",
											ignoreSize = "False",
											name = "Panel_point26",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 3252,
												PositionY = 208,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "10",
											ZOrder = "1",
										},
										{
											controlID = "Panel_point27_Panel_points_Panel_skillMap3_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
											UUID = "2c2a81e1_0b5f_4c3a_8d2c_4939efc44ac7",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											bgColorOpacity = "50",
											bIsOpenClipping = "False",
											classname = "MEPanel",
											colorType = "1;SingleColor:#FFFF0000;GraduallyChangingColorStart:#FFFFFFFF;GraduallyChangingColorEnd:#FFFFFFFF;vectorX:0;vectorY:0",
											DesignHeight = "640",
											DesignType = "0",
											DesignWidth = "960",
											dstBlendFunc = "771",
											height = "10",
											ignoreSize = "False",
											name = "Panel_point27",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 3378,
												PositionY = 309,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "10",
											ZOrder = "1",
										},
										{
											controlID = "Panel_point28_Panel_points_Panel_skillMap3_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
											UUID = "0824bbf5_d855_466c_8e90_f949ea792ffb",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											bgColorOpacity = "50",
											bIsOpenClipping = "False",
											classname = "MEPanel",
											colorType = "1;SingleColor:#FFFF0000;GraduallyChangingColorStart:#FFFFFFFF;GraduallyChangingColorEnd:#FFFFFFFF;vectorX:0;vectorY:0",
											DesignHeight = "640",
											DesignType = "0",
											DesignWidth = "960",
											dstBlendFunc = "771",
											height = "10",
											ignoreSize = "False",
											name = "Panel_point28",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 3502,
												PositionY = 208,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "10",
											ZOrder = "1",
										},
										{
											controlID = "Panel_point29_Panel_points_Panel_skillMap3_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
											UUID = "9fa86916_1c24_483b_bf47_44960ec22311",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											bgColorOpacity = "50",
											bIsOpenClipping = "False",
											classname = "MEPanel",
											colorType = "1;SingleColor:#FFFF0000;GraduallyChangingColorStart:#FFFFFFFF;GraduallyChangingColorEnd:#FFFFFFFF;vectorX:0;vectorY:0",
											DesignHeight = "640",
											DesignType = "0",
											DesignWidth = "960",
											dstBlendFunc = "771",
											height = "10",
											ignoreSize = "False",
											name = "Panel_point29",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 3633,
												PositionY = 208,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "10",
											ZOrder = "1",
										},
										{
											controlID = "Panel_point30_Panel_points_Panel_skillMap3_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
											UUID = "f72dd289_ee43_4a42_bd77_2503b407c289",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											bgColorOpacity = "50",
											bIsOpenClipping = "False",
											classname = "MEPanel",
											colorType = "1;SingleColor:#FFFF0000;GraduallyChangingColorStart:#FFFFFFFF;GraduallyChangingColorEnd:#FFFFFFFF;vectorX:0;vectorY:0",
											DesignHeight = "640",
											DesignType = "0",
											DesignWidth = "960",
											dstBlendFunc = "771",
											height = "10",
											ignoreSize = "False",
											name = "Panel_point30",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 3755,
												PositionY = 107,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "10",
											ZOrder = "1",
										},
									},
								},
								{
									controlID = "Panel_lines_Panel_skillMap3_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
									UUID = "e06f5904_9ce7_419a_a440_324ed3a309c3",
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
									name = "Panel_lines",
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
									width = "400",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "Panel_line1_Panel_lines_Panel_skillMap3_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
											UUID = "467b75b0_8320_474f_92fa_c54973f912f0",
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
											height = "10",
											ignoreSize = "False",
											name = "Panel_line1",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 135,
												PositionY = 206,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "10",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "Panel_dark_Panel_line1_Panel_lines_Panel_skillMap3_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
													UUID = "d3a86bf3_be3c_4062_8536_499df5239b3e",
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
													height = "10",
													ignoreSize = "False",
													name = "Panel_dark",
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
													width = "10",
													ZOrder = "1",
													components = 
													{
														
														{
															controlID = "Image_line1_Panel_dark_Panel_line1_Panel_lines_Panel_skillMap3_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
															UUID = "ef18389d_f040_4c32_b3d6_c6ed33256b3a",
															anchorPoint = "False",
															anchorPointX = "0",
															anchorPointY = "0.5",
															backGroundScale9Enable = "True;capInsetsX:0;capInsetsY:0;capInsetsWidth:0;capInsetsHeight:0",
															classname = "MEImage",
															dstBlendFunc = "771",
															height = "28",
															ignoreSize = "False",
															name = "Image_line1",
															sizepercentx = "0",
															sizepercenty = "0",
															sizeType = "0",
															srcBlendFunc = "1",
															texturePath = "ui/explore/growup/command/skill/013.png",
															touchAble = "False",
															UILayoutViewModel = 
															{
																PositionY = 6,
															},
															width = "46",
															ZOrder = "1",
														},
													},
												},
												{
													controlID = "Panel_light_Panel_line1_Panel_lines_Panel_skillMap3_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
													UUID = "3b553d7f_048d_40b2_b4ae_412a5391c2c6",
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
													height = "10",
													ignoreSize = "False",
													name = "Panel_light",
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
													width = "10",
													ZOrder = "1",
													components = 
													{
														
														{
															controlID = "Image_line1_Panel_light_Panel_line1_Panel_lines_Panel_skillMap3_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
															UUID = "9a854755_880b_4af7_b3a9_b781a833df8d",
															anchorPoint = "False",
															anchorPointX = "0",
															anchorPointY = "0.5",
															backGroundScale9Enable = "True;capInsetsX:0;capInsetsY:0;capInsetsWidth:0;capInsetsHeight:0",
															classname = "MEImage",
															dstBlendFunc = "771",
															height = "28",
															ignoreSize = "False",
															name = "Image_line1",
															sizepercentx = "0",
															sizepercenty = "0",
															sizeType = "0",
															srcBlendFunc = "1",
															texturePath = "ui/explore/growup/command/skill/011.png",
															touchAble = "False",
															UILayoutViewModel = 
															{
																PositionY = 6,
															},
															width = "46",
															ZOrder = "1",
														},
													},
												},
											},
										},
										{
											controlID = "Panel_line2_Panel_lines_Panel_skillMap3_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
											UUID = "098ae39e_94b4_4d92_8470_6419c0bf6224",
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
											height = "10",
											ignoreSize = "False",
											name = "Panel_line2",
											rotation = "-45",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 259,
												PositionY = 226,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "10",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "Panel_dark_Panel_line2_Panel_lines_Panel_skillMap3_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
													UUID = "616c9b76_5b1a_47f4_98e2_d87376c793c9",
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
													height = "10",
													ignoreSize = "False",
													name = "Panel_dark",
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
													width = "10",
													ZOrder = "1",
													components = 
													{
														
														{
															controlID = "Image_line1_Panel_dark_Panel_line2_Panel_lines_Panel_skillMap3_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
															UUID = "a6bb2c78_fcea_49d5_b02b_ab47336a006d",
															anchorPoint = "False",
															anchorPointX = "0",
															anchorPointY = "0.5",
															backGroundScale9Enable = "True;capInsetsX:0;capInsetsY:0;capInsetsWidth:0;capInsetsHeight:0",
															classname = "MEImage",
															dstBlendFunc = "771",
															height = "28",
															ignoreSize = "False",
															name = "Image_line1",
															sizepercentx = "0",
															sizepercenty = "0",
															sizeType = "0",
															srcBlendFunc = "1",
															texturePath = "ui/explore/growup/command/skill/013.png",
															touchAble = "False",
															UILayoutViewModel = 
															{
																PositionY = 6,
															},
															width = "87",
															ZOrder = "1",
														},
													},
												},
												{
													controlID = "Panel_light_Panel_line2_Panel_lines_Panel_skillMap3_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
													UUID = "9ac1cb34_bc76_4a84_bd02_3dfb1538bc88",
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
													height = "10",
													ignoreSize = "False",
													name = "Panel_light",
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
													width = "10",
													ZOrder = "1",
													components = 
													{
														
														{
															controlID = "Image_line1_Panel_light_Panel_line2_Panel_lines_Panel_skillMap3_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
															UUID = "ab2cfcc6_f27d_433b_ba53_4dd9c2bbfa7a",
															anchorPoint = "False",
															anchorPointX = "0",
															anchorPointY = "0.5",
															backGroundScale9Enable = "True;capInsetsX:0;capInsetsY:0;capInsetsWidth:0;capInsetsHeight:0",
															classname = "MEImage",
															dstBlendFunc = "771",
															height = "28",
															ignoreSize = "False",
															name = "Image_line1",
															sizepercentx = "0",
															sizepercenty = "0",
															sizeType = "0",
															srcBlendFunc = "1",
															texturePath = "ui/explore/growup/command/skill/011.png",
															touchAble = "False",
															UILayoutViewModel = 
															{
																PositionY = 6,
															},
															width = "86",
															ZOrder = "1",
														},
													},
												},
											},
										},
										{
											controlID = "Panel_line3_Panel_lines_Panel_skillMap3_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
											UUID = "65418659_1392_425f_b7a1_6826e4044dcb",
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
											height = "10",
											ignoreSize = "False",
											name = "Panel_line3",
											rotation = "45",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 377,
												PositionY = 286,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "10",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "Panel_dark_Panel_line3_Panel_lines_Panel_skillMap3_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
													UUID = "552a07d0_054e_49c7_9648_2bf899510088",
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
													height = "10",
													ignoreSize = "False",
													name = "Panel_dark",
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
													width = "10",
													ZOrder = "1",
													components = 
													{
														
														{
															controlID = "Image_line1_Panel_dark_Panel_line3_Panel_lines_Panel_skillMap3_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
															UUID = "ca126db2_db11_4c9a_b1a9_b26afb6cbf78",
															anchorPoint = "False",
															anchorPointX = "0",
															anchorPointY = "0.5",
															backGroundScale9Enable = "True;capInsetsX:0;capInsetsY:0;capInsetsWidth:0;capInsetsHeight:0",
															classname = "MEImage",
															dstBlendFunc = "771",
															height = "28",
															ignoreSize = "False",
															name = "Image_line1",
															sizepercentx = "0",
															sizepercenty = "0",
															sizeType = "0",
															srcBlendFunc = "1",
															texturePath = "ui/explore/growup/command/skill/013.png",
															touchAble = "False",
															UILayoutViewModel = 
															{
																PositionY = 6,
															},
															width = "84",
															ZOrder = "1",
														},
													},
												},
												{
													controlID = "Panel_light_Panel_line3_Panel_lines_Panel_skillMap3_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
													UUID = "03d66302_d9bc_42f2_87d0_45e8f587e6bb",
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
													height = "10",
													ignoreSize = "False",
													name = "Panel_light",
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
													width = "10",
													ZOrder = "1",
													components = 
													{
														
														{
															controlID = "Image_line1_Panel_light_Panel_line3_Panel_lines_Panel_skillMap3_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
															UUID = "4f20d4bf_feb2_4e4a_876b_24b499399742",
															anchorPoint = "False",
															anchorPointX = "0",
															anchorPointY = "0.5",
															backGroundScale9Enable = "True;capInsetsX:0;capInsetsY:0;capInsetsWidth:0;capInsetsHeight:0",
															classname = "MEImage",
															dstBlendFunc = "771",
															height = "28",
															ignoreSize = "False",
															name = "Image_line1",
															sizepercentx = "0",
															sizepercenty = "0",
															sizeType = "0",
															srcBlendFunc = "1",
															texturePath = "ui/explore/growup/command/skill/011.png",
															touchAble = "False",
															UILayoutViewModel = 
															{
																PositionY = 6,
															},
															width = "85",
															ZOrder = "1",
														},
													},
												},
											},
										},
										{
											controlID = "Panel_line4_Panel_lines_Panel_skillMap3_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
											UUID = "8475188a_dbf7_445a_9e9b_3c936a58f69a",
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
											height = "10",
											ignoreSize = "False",
											name = "Panel_line4",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 516,
												PositionY = 206,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "10",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "Panel_dark_Panel_line4_Panel_lines_Panel_skillMap3_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
													UUID = "3c437319_ef11_4b9f_8dd7_60f43c742999",
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
													height = "10",
													ignoreSize = "False",
													name = "Panel_dark",
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
													width = "10",
													ZOrder = "1",
													components = 
													{
														
														{
															controlID = "Image_line1_Panel_dark_Panel_line4_Panel_lines_Panel_skillMap3_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
															UUID = "83838436_57f6_4cb7_a761_e12cf3c8727f",
															anchorPoint = "False",
															anchorPointX = "0",
															anchorPointY = "0.5",
															backGroundScale9Enable = "True;capInsetsX:0;capInsetsY:0;capInsetsWidth:0;capInsetsHeight:0",
															classname = "MEImage",
															dstBlendFunc = "771",
															height = "28",
															ignoreSize = "False",
															name = "Image_line1",
															sizepercentx = "0",
															sizepercenty = "0",
															sizeType = "0",
															srcBlendFunc = "1",
															texturePath = "ui/explore/growup/command/skill/013.png",
															touchAble = "False",
															UILayoutViewModel = 
															{
																PositionY = 6,
															},
															width = "46",
															ZOrder = "1",
														},
													},
												},
												{
													controlID = "Panel_light_Panel_line4_Panel_lines_Panel_skillMap3_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
													UUID = "213a2982_f8a7_4209_a7ac_122c40611bc4",
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
													height = "10",
													ignoreSize = "False",
													name = "Panel_light",
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
													width = "10",
													ZOrder = "1",
													components = 
													{
														
														{
															controlID = "Image_line1_Panel_light_Panel_line4_Panel_lines_Panel_skillMap3_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
															UUID = "c4cbf08c_fecc_4d92_8414_e9757d82623e",
															anchorPoint = "False",
															anchorPointX = "0",
															anchorPointY = "0.5",
															backGroundScale9Enable = "True;capInsetsX:0;capInsetsY:0;capInsetsWidth:0;capInsetsHeight:0",
															classname = "MEImage",
															dstBlendFunc = "771",
															height = "28",
															ignoreSize = "False",
															name = "Image_line1",
															sizepercentx = "0",
															sizepercenty = "0",
															sizeType = "0",
															srcBlendFunc = "1",
															texturePath = "ui/explore/growup/command/skill/011.png",
															touchAble = "False",
															UILayoutViewModel = 
															{
																PositionY = 6,
															},
															width = "46",
															ZOrder = "1",
														},
													},
												},
											},
										},
										{
											controlID = "Panel_line5_Panel_lines_Panel_skillMap3_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
											UUID = "2cbe6ecb_1984_4d41_bbfe_bbfa94ad7b37",
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
											height = "10",
											ignoreSize = "False",
											name = "Panel_line5",
											rotation = "45",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 632,
												PositionY = 185,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "10",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "Panel_dark_Panel_line5_Panel_lines_Panel_skillMap3_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
													UUID = "a928391e_6640_4685_85a8_36325761aea1",
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
													height = "10",
													ignoreSize = "False",
													name = "Panel_dark",
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
													width = "10",
													ZOrder = "1",
													components = 
													{
														
														{
															controlID = "Image_line1_Panel_dark_Panel_line5_Panel_lines_Panel_skillMap3_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
															UUID = "0e5af021_1579_4a14_92d9_4eb0b1005fa3",
															anchorPoint = "False",
															anchorPointX = "0",
															anchorPointY = "0.5",
															backGroundScale9Enable = "True;capInsetsX:0;capInsetsY:0;capInsetsWidth:0;capInsetsHeight:0",
															classname = "MEImage",
															dstBlendFunc = "771",
															height = "28",
															ignoreSize = "False",
															name = "Image_line1",
															sizepercentx = "0",
															sizepercenty = "0",
															sizeType = "0",
															srcBlendFunc = "1",
															texturePath = "ui/explore/growup/command/skill/013.png",
															touchAble = "False",
															UILayoutViewModel = 
															{
																PositionY = 6,
															},
															width = "84",
															ZOrder = "1",
														},
													},
												},
												{
													controlID = "Panel_light_Panel_line5_Panel_lines_Panel_skillMap3_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
													UUID = "b402cccc_abd7_490d_948d_b1245668f742",
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
													height = "10",
													ignoreSize = "False",
													name = "Panel_light",
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
													width = "10",
													ZOrder = "1",
													components = 
													{
														
														{
															controlID = "Image_line1_Panel_light_Panel_line5_Panel_lines_Panel_skillMap3_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
															UUID = "f7d1e540_7f4b_4383_b015_22af9e756ea3",
															anchorPoint = "False",
															anchorPointX = "0",
															anchorPointY = "0.5",
															backGroundScale9Enable = "True;capInsetsX:0;capInsetsY:0;capInsetsWidth:0;capInsetsHeight:0",
															classname = "MEImage",
															dstBlendFunc = "771",
															height = "28",
															ignoreSize = "False",
															name = "Image_line1",
															sizepercentx = "0",
															sizepercenty = "0",
															sizeType = "0",
															srcBlendFunc = "1",
															texturePath = "ui/explore/growup/command/skill/011.png",
															touchAble = "False",
															UILayoutViewModel = 
															{
																PositionY = 6,
															},
															width = "85",
															ZOrder = "1",
														},
													},
												},
											},
										},
										{
											controlID = "Panel_line6_Panel_lines_Panel_skillMap3_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
											UUID = "60a6df81_a6cb_401c_a3fd_c363f0602d1c",
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
											height = "10",
											ignoreSize = "False",
											name = "Panel_line6",
											rotation = "-45",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 761,
												PositionY = 124,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "10",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "Panel_dark_Panel_line6_Panel_lines_Panel_skillMap3_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
													UUID = "06c5339c_febb_4464_897a_a968a57e312e",
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
													height = "10",
													ignoreSize = "False",
													name = "Panel_dark",
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
													width = "10",
													ZOrder = "1",
													components = 
													{
														
														{
															controlID = "Image_line1_Panel_dark_Panel_line6_Panel_lines_Panel_skillMap3_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
															UUID = "302e26a8_4fcc_4f27_b44b_ec4f5293a0be",
															anchorPoint = "False",
															anchorPointX = "0",
															anchorPointY = "0.5",
															backGroundScale9Enable = "True;capInsetsX:0;capInsetsY:0;capInsetsWidth:0;capInsetsHeight:0",
															classname = "MEImage",
															dstBlendFunc = "771",
															height = "28",
															ignoreSize = "False",
															name = "Image_line1",
															sizepercentx = "0",
															sizepercenty = "0",
															sizeType = "0",
															srcBlendFunc = "1",
															texturePath = "ui/explore/growup/command/skill/013.png",
															touchAble = "False",
															UILayoutViewModel = 
															{
																PositionY = 6,
															},
															width = "87",
															ZOrder = "1",
														},
													},
												},
												{
													controlID = "Panel_light_Panel_line6_Panel_lines_Panel_skillMap3_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
													UUID = "1adb1cb0_0359_4a62_8349_c6b0db609aef",
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
													height = "10",
													ignoreSize = "False",
													name = "Panel_light",
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
													width = "10",
													ZOrder = "1",
													components = 
													{
														
														{
															controlID = "Image_line1_Panel_light_Panel_line6_Panel_lines_Panel_skillMap3_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
															UUID = "8e8463fa_b23f_4cba_96a6_007e05f855d4",
															anchorPoint = "False",
															anchorPointX = "0",
															anchorPointY = "0.5",
															backGroundScale9Enable = "True;capInsetsX:0;capInsetsY:0;capInsetsWidth:0;capInsetsHeight:0",
															classname = "MEImage",
															dstBlendFunc = "771",
															height = "28",
															ignoreSize = "False",
															name = "Image_line1",
															sizepercentx = "0",
															sizepercenty = "0",
															sizeType = "0",
															srcBlendFunc = "1",
															texturePath = "ui/explore/growup/command/skill/011.png",
															touchAble = "False",
															UILayoutViewModel = 
															{
																PositionY = 6,
															},
															width = "86",
															ZOrder = "1",
														},
													},
												},
											},
										},
										{
											controlID = "Panel_line7_Panel_lines_Panel_skillMap3_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
											UUID = "7ff8b7f6_0b86_4b66_a8b1_dc4299333616",
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
											height = "10",
											ignoreSize = "False",
											name = "Panel_line7",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 893,
												PositionY = 206,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "10",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "Panel_dark_Panel_line7_Panel_lines_Panel_skillMap3_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
													UUID = "7f0b17af_3d42_4b8c_87e5_3f4f8235e87f",
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
													height = "10",
													ignoreSize = "False",
													name = "Panel_dark",
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
													width = "10",
													ZOrder = "1",
													components = 
													{
														
														{
															controlID = "Image_line1_Panel_dark_Panel_line7_Panel_lines_Panel_skillMap3_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
															UUID = "0caadcd2_ae84_4080_9827_b570b97609af",
															anchorPoint = "False",
															anchorPointX = "0",
															anchorPointY = "0.5",
															backGroundScale9Enable = "True;capInsetsX:0;capInsetsY:0;capInsetsWidth:0;capInsetsHeight:0",
															classname = "MEImage",
															dstBlendFunc = "771",
															height = "28",
															ignoreSize = "False",
															name = "Image_line1",
															sizepercentx = "0",
															sizepercenty = "0",
															sizeType = "0",
															srcBlendFunc = "1",
															texturePath = "ui/explore/growup/command/skill/013.png",
															touchAble = "False",
															UILayoutViewModel = 
															{
																PositionY = 6,
															},
															width = "46",
															ZOrder = "1",
														},
													},
												},
												{
													controlID = "Panel_light_Panel_line7_Panel_lines_Panel_skillMap3_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
													UUID = "4a5d7db4_0635_41f1_bfbc_07dbe739a5c6",
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
													height = "10",
													ignoreSize = "False",
													name = "Panel_light",
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
													width = "10",
													ZOrder = "1",
													components = 
													{
														
														{
															controlID = "Image_line1_Panel_light_Panel_line7_Panel_lines_Panel_skillMap3_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
															UUID = "712aa22e_568e_446e_a54f_1af681af81f8",
															anchorPoint = "False",
															anchorPointX = "0",
															anchorPointY = "0.5",
															backGroundScale9Enable = "True;capInsetsX:0;capInsetsY:0;capInsetsWidth:0;capInsetsHeight:0",
															classname = "MEImage",
															dstBlendFunc = "771",
															height = "28",
															ignoreSize = "False",
															name = "Image_line1",
															sizepercentx = "0",
															sizepercenty = "0",
															sizeType = "0",
															srcBlendFunc = "1",
															texturePath = "ui/explore/growup/command/skill/011.png",
															touchAble = "False",
															UILayoutViewModel = 
															{
																PositionY = 6,
															},
															width = "46",
															ZOrder = "1",
														},
													},
												},
											},
										},
										{
											controlID = "Panel_line8_Panel_lines_Panel_skillMap3_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
											UUID = "04614885_1dcf_4ca2_bfd5_4713557dcf88",
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
											height = "10",
											ignoreSize = "False",
											name = "Panel_line8",
											rotation = "-45",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 1017,
												PositionY = 226,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "10",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "Panel_dark_Panel_line8_Panel_lines_Panel_skillMap3_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
													UUID = "029a6f73_30e3_4b52_9b6f_e22aad15a9fd",
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
													height = "10",
													ignoreSize = "False",
													name = "Panel_dark",
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
													width = "10",
													ZOrder = "1",
													components = 
													{
														
														{
															controlID = "Image_line1_Panel_dark_Panel_line8_Panel_lines_Panel_skillMap3_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
															UUID = "f1e1eb09_6625_4ab7_ad38_a2b2022bcb87",
															anchorPoint = "False",
															anchorPointX = "0",
															anchorPointY = "0.5",
															backGroundScale9Enable = "True;capInsetsX:0;capInsetsY:0;capInsetsWidth:0;capInsetsHeight:0",
															classname = "MEImage",
															dstBlendFunc = "771",
															height = "28",
															ignoreSize = "False",
															name = "Image_line1",
															sizepercentx = "0",
															sizepercenty = "0",
															sizeType = "0",
															srcBlendFunc = "1",
															texturePath = "ui/explore/growup/command/skill/013.png",
															touchAble = "False",
															UILayoutViewModel = 
															{
																PositionY = 6,
															},
															width = "87",
															ZOrder = "1",
														},
													},
												},
												{
													controlID = "Panel_light_Panel_line8_Panel_lines_Panel_skillMap3_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
													UUID = "92687445_3e8d_4a76_b966_4f485cfa6ea8",
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
													height = "10",
													ignoreSize = "False",
													name = "Panel_light",
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
													width = "10",
													ZOrder = "1",
													components = 
													{
														
														{
															controlID = "Image_line1_Panel_light_Panel_line8_Panel_lines_Panel_skillMap3_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
															UUID = "2210ce09_97f1_4c51_a205_286a2345b6dc",
															anchorPoint = "False",
															anchorPointX = "0",
															anchorPointY = "0.5",
															backGroundScale9Enable = "True;capInsetsX:0;capInsetsY:0;capInsetsWidth:0;capInsetsHeight:0",
															classname = "MEImage",
															dstBlendFunc = "771",
															height = "28",
															ignoreSize = "False",
															name = "Image_line1",
															sizepercentx = "0",
															sizepercenty = "0",
															sizeType = "0",
															srcBlendFunc = "1",
															texturePath = "ui/explore/growup/command/skill/011.png",
															touchAble = "False",
															UILayoutViewModel = 
															{
																PositionY = 6,
															},
															width = "86",
															ZOrder = "1",
														},
													},
												},
											},
										},
										{
											controlID = "Panel_line9_Panel_lines_Panel_skillMap3_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
											UUID = "c2633dd6_1da2_4578_9bb5_217f85ba9443",
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
											height = "10",
											ignoreSize = "False",
											name = "Panel_line9",
											rotation = "45",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 1135,
												PositionY = 286,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "10",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "Panel_dark_Panel_line9_Panel_lines_Panel_skillMap3_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
													UUID = "09e633b7_eb6f_4aa2_9637_ff45b4593937",
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
													height = "10",
													ignoreSize = "False",
													name = "Panel_dark",
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
													width = "10",
													ZOrder = "1",
													components = 
													{
														
														{
															controlID = "Image_line1_Panel_dark_Panel_line9_Panel_lines_Panel_skillMap3_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
															UUID = "c5695c6f_a68a_42bb_855b_b35a0f725554",
															anchorPoint = "False",
															anchorPointX = "0",
															anchorPointY = "0.5",
															backGroundScale9Enable = "True;capInsetsX:0;capInsetsY:0;capInsetsWidth:0;capInsetsHeight:0",
															classname = "MEImage",
															dstBlendFunc = "771",
															height = "28",
															ignoreSize = "False",
															name = "Image_line1",
															sizepercentx = "0",
															sizepercenty = "0",
															sizeType = "0",
															srcBlendFunc = "1",
															texturePath = "ui/explore/growup/command/skill/013.png",
															touchAble = "False",
															UILayoutViewModel = 
															{
																PositionY = 6,
															},
															width = "84",
															ZOrder = "1",
														},
													},
												},
												{
													controlID = "Panel_light_Panel_line9_Panel_lines_Panel_skillMap3_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
													UUID = "4742d765_3543_46a9_b262_5a0b74ae7806",
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
													height = "10",
													ignoreSize = "False",
													name = "Panel_light",
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
													width = "10",
													ZOrder = "1",
													components = 
													{
														
														{
															controlID = "Image_line1_Panel_light_Panel_line9_Panel_lines_Panel_skillMap3_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
															UUID = "e66eb9ee_424e_4c4e_a819_6ccef4b3bc5c",
															anchorPoint = "False",
															anchorPointX = "0",
															anchorPointY = "0.5",
															backGroundScale9Enable = "True;capInsetsX:0;capInsetsY:0;capInsetsWidth:0;capInsetsHeight:0",
															classname = "MEImage",
															dstBlendFunc = "771",
															height = "28",
															ignoreSize = "False",
															name = "Image_line1",
															sizepercentx = "0",
															sizepercenty = "0",
															sizeType = "0",
															srcBlendFunc = "1",
															texturePath = "ui/explore/growup/command/skill/011.png",
															touchAble = "False",
															UILayoutViewModel = 
															{
																PositionY = 6,
															},
															width = "85",
															ZOrder = "1",
														},
													},
												},
											},
										},
										{
											controlID = "Panel_line10_Panel_lines_Panel_skillMap3_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
											UUID = "3faa9db3_93e1_49d1_8957_e2fca6a02e4f",
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
											height = "10",
											ignoreSize = "False",
											name = "Panel_line10",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 1274,
												PositionY = 206,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "10",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "Panel_dark_Panel_line10_Panel_lines_Panel_skillMap3_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
													UUID = "279f36ac_c92e_436e_8059_84f2f21731d3",
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
													height = "10",
													ignoreSize = "False",
													name = "Panel_dark",
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
													width = "10",
													ZOrder = "1",
													components = 
													{
														
														{
															controlID = "Image_line1_Panel_dark_Panel_line10_Panel_lines_Panel_skillMap3_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
															UUID = "610733aa_3c4b_4c00_a930_b5ac3366c7d5",
															anchorPoint = "False",
															anchorPointX = "0",
															anchorPointY = "0.5",
															backGroundScale9Enable = "True;capInsetsX:0;capInsetsY:0;capInsetsWidth:0;capInsetsHeight:0",
															classname = "MEImage",
															dstBlendFunc = "771",
															height = "28",
															ignoreSize = "False",
															name = "Image_line1",
															sizepercentx = "0",
															sizepercenty = "0",
															sizeType = "0",
															srcBlendFunc = "1",
															texturePath = "ui/explore/growup/command/skill/013.png",
															touchAble = "False",
															UILayoutViewModel = 
															{
																PositionY = 6,
															},
															width = "46",
															ZOrder = "1",
														},
													},
												},
												{
													controlID = "Panel_light_Panel_line10_Panel_lines_Panel_skillMap3_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
													UUID = "c7ef1de2_ad6f_46cc_80f2_5152df4f045d",
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
													height = "10",
													ignoreSize = "False",
													name = "Panel_light",
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
													width = "10",
													ZOrder = "1",
													components = 
													{
														
														{
															controlID = "Image_line1_Panel_light_Panel_line10_Panel_lines_Panel_skillMap3_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
															UUID = "379ae61a_5117_4dc4_ac6f_096ca9f321f1",
															anchorPoint = "False",
															anchorPointX = "0",
															anchorPointY = "0.5",
															backGroundScale9Enable = "True;capInsetsX:0;capInsetsY:0;capInsetsWidth:0;capInsetsHeight:0",
															classname = "MEImage",
															dstBlendFunc = "771",
															height = "28",
															ignoreSize = "False",
															name = "Image_line1",
															sizepercentx = "0",
															sizepercenty = "0",
															sizeType = "0",
															srcBlendFunc = "1",
															texturePath = "ui/explore/growup/command/skill/011.png",
															touchAble = "False",
															UILayoutViewModel = 
															{
																PositionY = 6,
															},
															width = "46",
															ZOrder = "1",
														},
													},
												},
											},
										},
										{
											controlID = "Panel_line11_Panel_lines_Panel_skillMap3_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
											UUID = "95c3d437_5730_42f4_8fb6_8571c720da95",
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
											height = "10",
											ignoreSize = "False",
											name = "Panel_line11",
											rotation = "45",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 1390,
												PositionY = 185,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "10",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "Panel_dark_Panel_line11_Panel_lines_Panel_skillMap3_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
													UUID = "636b0aa9_58a6_4dbb_b53a_bc96997d7809",
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
													height = "10",
													ignoreSize = "False",
													name = "Panel_dark",
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
													width = "10",
													ZOrder = "1",
													components = 
													{
														
														{
															controlID = "Image_line1_Panel_dark_Panel_line11_Panel_lines_Panel_skillMap3_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
															UUID = "d95879d4_d931_4610_a3ac_e7ecf454e75f",
															anchorPoint = "False",
															anchorPointX = "0",
															anchorPointY = "0.5",
															backGroundScale9Enable = "True;capInsetsX:0;capInsetsY:0;capInsetsWidth:0;capInsetsHeight:0",
															classname = "MEImage",
															dstBlendFunc = "771",
															height = "28",
															ignoreSize = "False",
															name = "Image_line1",
															sizepercentx = "0",
															sizepercenty = "0",
															sizeType = "0",
															srcBlendFunc = "1",
															texturePath = "ui/explore/growup/command/skill/013.png",
															touchAble = "False",
															UILayoutViewModel = 
															{
																PositionY = 6,
															},
															width = "84",
															ZOrder = "1",
														},
													},
												},
												{
													controlID = "Panel_light_Panel_line11_Panel_lines_Panel_skillMap3_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
													UUID = "cc51c31f_a0d2_499a_a199_73af1109c64c",
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
													height = "10",
													ignoreSize = "False",
													name = "Panel_light",
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
													width = "10",
													ZOrder = "1",
													components = 
													{
														
														{
															controlID = "Image_line1_Panel_light_Panel_line11_Panel_lines_Panel_skillMap3_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
															UUID = "5a615689_2b76_43c8_80c8_2238661e1b58",
															anchorPoint = "False",
															anchorPointX = "0",
															anchorPointY = "0.5",
															backGroundScale9Enable = "True;capInsetsX:0;capInsetsY:0;capInsetsWidth:0;capInsetsHeight:0",
															classname = "MEImage",
															dstBlendFunc = "771",
															height = "28",
															ignoreSize = "False",
															name = "Image_line1",
															sizepercentx = "0",
															sizepercenty = "0",
															sizeType = "0",
															srcBlendFunc = "1",
															texturePath = "ui/explore/growup/command/skill/011.png",
															touchAble = "False",
															UILayoutViewModel = 
															{
																PositionY = 6,
															},
															width = "85",
															ZOrder = "1",
														},
													},
												},
											},
										},
										{
											controlID = "Panel_line12_Panel_lines_Panel_skillMap3_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
											UUID = "6d64e387_ab3a_42d5_8c87_582902fe42cf",
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
											height = "10",
											ignoreSize = "False",
											name = "Panel_line12",
											rotation = "-45",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 1519,
												PositionY = 124,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "10",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "Panel_dark_Panel_line12_Panel_lines_Panel_skillMap3_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
													UUID = "fbc951c1_74b7_481f_8dbe_f3f71d4874e7",
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
													height = "10",
													ignoreSize = "False",
													name = "Panel_dark",
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
													width = "10",
													ZOrder = "1",
													components = 
													{
														
														{
															controlID = "Image_line1_Panel_dark_Panel_line12_Panel_lines_Panel_skillMap3_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
															UUID = "129dbc91_7cea_41ca_8f39_dbc2b04dd5c5",
															anchorPoint = "False",
															anchorPointX = "0",
															anchorPointY = "0.5",
															backGroundScale9Enable = "True;capInsetsX:0;capInsetsY:0;capInsetsWidth:0;capInsetsHeight:0",
															classname = "MEImage",
															dstBlendFunc = "771",
															height = "28",
															ignoreSize = "False",
															name = "Image_line1",
															sizepercentx = "0",
															sizepercenty = "0",
															sizeType = "0",
															srcBlendFunc = "1",
															texturePath = "ui/explore/growup/command/skill/013.png",
															touchAble = "False",
															UILayoutViewModel = 
															{
																PositionY = 6,
															},
															width = "87",
															ZOrder = "1",
														},
													},
												},
												{
													controlID = "Panel_light_Panel_line12_Panel_lines_Panel_skillMap3_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
													UUID = "e651957c_5c47_49b2_a0df_e774ec879d25",
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
													height = "10",
													ignoreSize = "False",
													name = "Panel_light",
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
													width = "10",
													ZOrder = "1",
													components = 
													{
														
														{
															controlID = "Image_line1_Panel_light_Panel_line12_Panel_lines_Panel_skillMap3_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
															UUID = "01ea3a9a_2b41_4754_8683_cf2cbc668c76",
															anchorPoint = "False",
															anchorPointX = "0",
															anchorPointY = "0.5",
															backGroundScale9Enable = "True;capInsetsX:0;capInsetsY:0;capInsetsWidth:0;capInsetsHeight:0",
															classname = "MEImage",
															dstBlendFunc = "771",
															height = "28",
															ignoreSize = "False",
															name = "Image_line1",
															sizepercentx = "0",
															sizepercenty = "0",
															sizeType = "0",
															srcBlendFunc = "1",
															texturePath = "ui/explore/growup/command/skill/011.png",
															touchAble = "False",
															UILayoutViewModel = 
															{
																PositionY = 6,
															},
															width = "86",
															ZOrder = "1",
														},
													},
												},
											},
										},
										{
											controlID = "Panel_line13_Panel_lines_Panel_skillMap3_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
											UUID = "0f76b764_0a0f_4572_a02d_394c7199dd99",
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
											height = "10",
											ignoreSize = "False",
											name = "Panel_line13",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 1651,
												PositionY = 206,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "10",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "Panel_dark_Panel_line13_Panel_lines_Panel_skillMap3_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
													UUID = "d94b6571_8f35_438b_92ad_eab4aafe3a33",
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
													height = "10",
													ignoreSize = "False",
													name = "Panel_dark",
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
													width = "10",
													ZOrder = "1",
													components = 
													{
														
														{
															controlID = "Image_line1_Panel_dark_Panel_line13_Panel_lines_Panel_skillMap3_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
															UUID = "1feec1e7_80a1_49ce_8159_173e5760d76c",
															anchorPoint = "False",
															anchorPointX = "0",
															anchorPointY = "0.5",
															backGroundScale9Enable = "True;capInsetsX:0;capInsetsY:0;capInsetsWidth:0;capInsetsHeight:0",
															classname = "MEImage",
															dstBlendFunc = "771",
															height = "28",
															ignoreSize = "False",
															name = "Image_line1",
															sizepercentx = "0",
															sizepercenty = "0",
															sizeType = "0",
															srcBlendFunc = "1",
															texturePath = "ui/explore/growup/command/skill/013.png",
															touchAble = "False",
															UILayoutViewModel = 
															{
																PositionY = 6,
															},
															width = "46",
															ZOrder = "1",
														},
													},
												},
												{
													controlID = "Panel_light_Panel_line13_Panel_lines_Panel_skillMap3_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
													UUID = "d4788c12_7225_49fd_a37e_793bd1fc23a2",
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
													height = "10",
													ignoreSize = "False",
													name = "Panel_light",
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
													width = "10",
													ZOrder = "1",
													components = 
													{
														
														{
															controlID = "Image_line1_Panel_light_Panel_line13_Panel_lines_Panel_skillMap3_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
															UUID = "f0f0337a_3821_473e_82ed_2469e68fb57f",
															anchorPoint = "False",
															anchorPointX = "0",
															anchorPointY = "0.5",
															backGroundScale9Enable = "True;capInsetsX:0;capInsetsY:0;capInsetsWidth:0;capInsetsHeight:0",
															classname = "MEImage",
															dstBlendFunc = "771",
															height = "28",
															ignoreSize = "False",
															name = "Image_line1",
															sizepercentx = "0",
															sizepercenty = "0",
															sizeType = "0",
															srcBlendFunc = "1",
															texturePath = "ui/explore/growup/command/skill/011.png",
															touchAble = "False",
															UILayoutViewModel = 
															{
																PositionY = 6,
															},
															width = "46",
															ZOrder = "1",
														},
													},
												},
											},
										},
										{
											controlID = "Panel_line14_Panel_lines_Panel_skillMap3_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
											UUID = "044918e9_bdbe_4371_bb7a_52b4bb1679a7",
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
											height = "10",
											ignoreSize = "False",
											name = "Panel_line14",
											rotation = "-45",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 1775,
												PositionY = 226,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "10",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "Panel_dark_Panel_line14_Panel_lines_Panel_skillMap3_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
													UUID = "1f1aaa32_79b2_40cb_8492_f9e094850bdf",
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
													height = "10",
													ignoreSize = "False",
													name = "Panel_dark",
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
													width = "10",
													ZOrder = "1",
													components = 
													{
														
														{
															controlID = "Image_line1_Panel_dark_Panel_line14_Panel_lines_Panel_skillMap3_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
															UUID = "1f3025c3_a1eb_41c6_9d0d_04288d8c81c7",
															anchorPoint = "False",
															anchorPointX = "0",
															anchorPointY = "0.5",
															backGroundScale9Enable = "True;capInsetsX:0;capInsetsY:0;capInsetsWidth:0;capInsetsHeight:0",
															classname = "MEImage",
															dstBlendFunc = "771",
															height = "28",
															ignoreSize = "False",
															name = "Image_line1",
															sizepercentx = "0",
															sizepercenty = "0",
															sizeType = "0",
															srcBlendFunc = "1",
															texturePath = "ui/explore/growup/command/skill/013.png",
															touchAble = "False",
															UILayoutViewModel = 
															{
																PositionY = 6,
															},
															width = "87",
															ZOrder = "1",
														},
													},
												},
												{
													controlID = "Panel_light_Panel_line14_Panel_lines_Panel_skillMap3_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
													UUID = "121bb65d_fe87_4ddb_a31b_fc8746b40ee8",
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
													height = "10",
													ignoreSize = "False",
													name = "Panel_light",
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
													width = "10",
													ZOrder = "1",
													components = 
													{
														
														{
															controlID = "Image_line1_Panel_light_Panel_line14_Panel_lines_Panel_skillMap3_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
															UUID = "90c7c32e_fcc9_41a5_bf53_53010aec5383",
															anchorPoint = "False",
															anchorPointX = "0",
															anchorPointY = "0.5",
															backGroundScale9Enable = "True;capInsetsX:0;capInsetsY:0;capInsetsWidth:0;capInsetsHeight:0",
															classname = "MEImage",
															dstBlendFunc = "771",
															height = "28",
															ignoreSize = "False",
															name = "Image_line1",
															sizepercentx = "0",
															sizepercenty = "0",
															sizeType = "0",
															srcBlendFunc = "1",
															texturePath = "ui/explore/growup/command/skill/011.png",
															touchAble = "False",
															UILayoutViewModel = 
															{
																PositionY = 6,
															},
															width = "86",
															ZOrder = "1",
														},
													},
												},
											},
										},
										{
											controlID = "Panel_line15_Panel_lines_Panel_skillMap3_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
											UUID = "e0acc6d3_5b05_4ae7_980d_6b2be4dd0fc4",
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
											height = "10",
											ignoreSize = "False",
											name = "Panel_line15",
											rotation = "45",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 1893,
												PositionY = 286,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "10",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "Panel_dark_Panel_line15_Panel_lines_Panel_skillMap3_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
													UUID = "8786659f_5e48_4516_8502_f93e58ce4ee4",
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
													height = "10",
													ignoreSize = "False",
													name = "Panel_dark",
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
													width = "10",
													ZOrder = "1",
													components = 
													{
														
														{
															controlID = "Image_line1_Panel_dark_Panel_line15_Panel_lines_Panel_skillMap3_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
															UUID = "9a6210d3_0222_4a18_b094_8f6149c4da42",
															anchorPoint = "False",
															anchorPointX = "0",
															anchorPointY = "0.5",
															backGroundScale9Enable = "True;capInsetsX:0;capInsetsY:0;capInsetsWidth:0;capInsetsHeight:0",
															classname = "MEImage",
															dstBlendFunc = "771",
															height = "28",
															ignoreSize = "False",
															name = "Image_line1",
															sizepercentx = "0",
															sizepercenty = "0",
															sizeType = "0",
															srcBlendFunc = "1",
															texturePath = "ui/explore/growup/command/skill/013.png",
															touchAble = "False",
															UILayoutViewModel = 
															{
																PositionY = 6,
															},
															width = "84",
															ZOrder = "1",
														},
													},
												},
												{
													controlID = "Panel_light_Panel_line15_Panel_lines_Panel_skillMap3_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
													UUID = "71300ec3_8df1_4e46_a39d_d099a41d61b4",
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
													height = "10",
													ignoreSize = "False",
													name = "Panel_light",
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
													width = "10",
													ZOrder = "1",
													components = 
													{
														
														{
															controlID = "Image_line1_Panel_light_Panel_line15_Panel_lines_Panel_skillMap3_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
															UUID = "0f98caa3_c21b_4324_ae0e_35965bf69e12",
															anchorPoint = "False",
															anchorPointX = "0",
															anchorPointY = "0.5",
															backGroundScale9Enable = "True;capInsetsX:0;capInsetsY:0;capInsetsWidth:0;capInsetsHeight:0",
															classname = "MEImage",
															dstBlendFunc = "771",
															height = "28",
															ignoreSize = "False",
															name = "Image_line1",
															sizepercentx = "0",
															sizepercenty = "0",
															sizeType = "0",
															srcBlendFunc = "1",
															texturePath = "ui/explore/growup/command/skill/011.png",
															touchAble = "False",
															UILayoutViewModel = 
															{
																PositionY = 6,
															},
															width = "85",
															ZOrder = "1",
														},
													},
												},
											},
										},
										{
											controlID = "Panel_line16_Panel_lines_Panel_skillMap3_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
											UUID = "b4b4e12a_ac50_4f4a_aa55_8ca92cdd7e91",
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
											height = "10",
											ignoreSize = "False",
											name = "Panel_line16",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 2032,
												PositionY = 206,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "10",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "Panel_dark_Panel_line16_Panel_lines_Panel_skillMap3_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
													UUID = "e6360730_9e6e_476a_b918_21492bb7317f",
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
													height = "10",
													ignoreSize = "False",
													name = "Panel_dark",
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
													width = "10",
													ZOrder = "1",
													components = 
													{
														
														{
															controlID = "Image_line1_Panel_dark_Panel_line16_Panel_lines_Panel_skillMap3_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
															UUID = "4ecd3ad3_4efa_4ebc_a248_6450d81c1cf3",
															anchorPoint = "False",
															anchorPointX = "0",
															anchorPointY = "0.5",
															backGroundScale9Enable = "True;capInsetsX:0;capInsetsY:0;capInsetsWidth:0;capInsetsHeight:0",
															classname = "MEImage",
															dstBlendFunc = "771",
															height = "28",
															ignoreSize = "False",
															name = "Image_line1",
															sizepercentx = "0",
															sizepercenty = "0",
															sizeType = "0",
															srcBlendFunc = "1",
															texturePath = "ui/explore/growup/command/skill/013.png",
															touchAble = "False",
															UILayoutViewModel = 
															{
																PositionY = 6,
															},
															width = "46",
															ZOrder = "1",
														},
													},
												},
												{
													controlID = "Panel_light_Panel_line16_Panel_lines_Panel_skillMap3_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
													UUID = "0b763b4d_3b87_4eb6_9f00_adcca896159b",
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
													height = "10",
													ignoreSize = "False",
													name = "Panel_light",
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
													width = "10",
													ZOrder = "1",
													components = 
													{
														
														{
															controlID = "Image_line1_Panel_light_Panel_line16_Panel_lines_Panel_skillMap3_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
															UUID = "b3822ab3_b218_4381_a26a_f898c3f396ab",
															anchorPoint = "False",
															anchorPointX = "0",
															anchorPointY = "0.5",
															backGroundScale9Enable = "True;capInsetsX:0;capInsetsY:0;capInsetsWidth:0;capInsetsHeight:0",
															classname = "MEImage",
															dstBlendFunc = "771",
															height = "28",
															ignoreSize = "False",
															name = "Image_line1",
															sizepercentx = "0",
															sizepercenty = "0",
															sizeType = "0",
															srcBlendFunc = "1",
															texturePath = "ui/explore/growup/command/skill/011.png",
															touchAble = "False",
															UILayoutViewModel = 
															{
																PositionY = 6,
															},
															width = "46",
															ZOrder = "1",
														},
													},
												},
											},
										},
										{
											controlID = "Panel_line17_Panel_lines_Panel_skillMap3_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
											UUID = "0d2f5189_74c9_477e_b2ef_1b82697da37b",
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
											height = "10",
											ignoreSize = "False",
											name = "Panel_line17",
											rotation = "45",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 2148,
												PositionY = 185,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "10",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "Panel_dark_Panel_line17_Panel_lines_Panel_skillMap3_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
													UUID = "f00487a7_9969_4aeb_9538_0a22d973d4e6",
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
													height = "10",
													ignoreSize = "False",
													name = "Panel_dark",
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
													width = "10",
													ZOrder = "1",
													components = 
													{
														
														{
															controlID = "Image_line1_Panel_dark_Panel_line17_Panel_lines_Panel_skillMap3_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
															UUID = "0c2d4dd9_bac5_48ad_afaf_c6325d575768",
															anchorPoint = "False",
															anchorPointX = "0",
															anchorPointY = "0.5",
															backGroundScale9Enable = "True;capInsetsX:0;capInsetsY:0;capInsetsWidth:0;capInsetsHeight:0",
															classname = "MEImage",
															dstBlendFunc = "771",
															height = "28",
															ignoreSize = "False",
															name = "Image_line1",
															sizepercentx = "0",
															sizepercenty = "0",
															sizeType = "0",
															srcBlendFunc = "1",
															texturePath = "ui/explore/growup/command/skill/013.png",
															touchAble = "False",
															UILayoutViewModel = 
															{
																PositionY = 6,
															},
															width = "84",
															ZOrder = "1",
														},
													},
												},
												{
													controlID = "Panel_light_Panel_line17_Panel_lines_Panel_skillMap3_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
													UUID = "832d6c09_545a_4692_9502_1c8b71a30b51",
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
													height = "10",
													ignoreSize = "False",
													name = "Panel_light",
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
													width = "10",
													ZOrder = "1",
													components = 
													{
														
														{
															controlID = "Image_line1_Panel_light_Panel_line17_Panel_lines_Panel_skillMap3_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
															UUID = "e7bd6cd4_d173_4031_ad94_6b6e367ce88d",
															anchorPoint = "False",
															anchorPointX = "0",
															anchorPointY = "0.5",
															backGroundScale9Enable = "True;capInsetsX:0;capInsetsY:0;capInsetsWidth:0;capInsetsHeight:0",
															classname = "MEImage",
															dstBlendFunc = "771",
															height = "28",
															ignoreSize = "False",
															name = "Image_line1",
															sizepercentx = "0",
															sizepercenty = "0",
															sizeType = "0",
															srcBlendFunc = "1",
															texturePath = "ui/explore/growup/command/skill/011.png",
															touchAble = "False",
															UILayoutViewModel = 
															{
																PositionY = 6,
															},
															width = "85",
															ZOrder = "1",
														},
													},
												},
											},
										},
										{
											controlID = "Panel_line18_Panel_lines_Panel_skillMap3_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
											UUID = "8d174cac_e1b3_4485_ae3e_35bfc2c1be7a",
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
											height = "10",
											ignoreSize = "False",
											name = "Panel_line18",
											rotation = "-45",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 2277,
												PositionY = 124,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "10",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "Panel_dark_Panel_line18_Panel_lines_Panel_skillMap3_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
													UUID = "3139756d_4bf7_4983_8544_7752767eb6d2",
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
													height = "10",
													ignoreSize = "False",
													name = "Panel_dark",
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
													width = "10",
													ZOrder = "1",
													components = 
													{
														
														{
															controlID = "Image_line1_Panel_dark_Panel_line18_Panel_lines_Panel_skillMap3_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
															UUID = "d390f0b5_8deb_478b_a892_7e57e125455b",
															anchorPoint = "False",
															anchorPointX = "0",
															anchorPointY = "0.5",
															backGroundScale9Enable = "True;capInsetsX:0;capInsetsY:0;capInsetsWidth:0;capInsetsHeight:0",
															classname = "MEImage",
															dstBlendFunc = "771",
															height = "28",
															ignoreSize = "False",
															name = "Image_line1",
															sizepercentx = "0",
															sizepercenty = "0",
															sizeType = "0",
															srcBlendFunc = "1",
															texturePath = "ui/explore/growup/command/skill/013.png",
															touchAble = "False",
															UILayoutViewModel = 
															{
																PositionY = 6,
															},
															width = "87",
															ZOrder = "1",
														},
													},
												},
												{
													controlID = "Panel_light_Panel_line18_Panel_lines_Panel_skillMap3_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
													UUID = "28ace4c3_0b83_4d51_a645_df7d60c30a81",
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
													height = "10",
													ignoreSize = "False",
													name = "Panel_light",
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
													width = "10",
													ZOrder = "1",
													components = 
													{
														
														{
															controlID = "Image_line1_Panel_light_Panel_line18_Panel_lines_Panel_skillMap3_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
															UUID = "0c9d4733_9802_47f6_aa07_90525be19e67",
															anchorPoint = "False",
															anchorPointX = "0",
															anchorPointY = "0.5",
															backGroundScale9Enable = "True;capInsetsX:0;capInsetsY:0;capInsetsWidth:0;capInsetsHeight:0",
															classname = "MEImage",
															dstBlendFunc = "771",
															height = "28",
															ignoreSize = "False",
															name = "Image_line1",
															sizepercentx = "0",
															sizepercenty = "0",
															sizeType = "0",
															srcBlendFunc = "1",
															texturePath = "ui/explore/growup/command/skill/011.png",
															touchAble = "False",
															UILayoutViewModel = 
															{
																PositionY = 6,
															},
															width = "86",
															ZOrder = "1",
														},
													},
												},
											},
										},
										{
											controlID = "Panel_line19_Panel_lines_Panel_skillMap3_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
											UUID = "4670c3e7_ed8a_4580_8e3e_117eca2d45ea",
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
											height = "10",
											ignoreSize = "False",
											name = "Panel_line19",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 2409,
												PositionY = 206,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "10",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "Panel_dark_Panel_line19_Panel_lines_Panel_skillMap3_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
													UUID = "4c678ba1_ab44_498d_93fc_fe58274c7bc2",
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
													height = "10",
													ignoreSize = "False",
													name = "Panel_dark",
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
													width = "10",
													ZOrder = "1",
													components = 
													{
														
														{
															controlID = "Image_line1_Panel_dark_Panel_line19_Panel_lines_Panel_skillMap3_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
															UUID = "438382a1_43e4_470e_8bb4_d61aa9ef3c7c",
															anchorPoint = "False",
															anchorPointX = "0",
															anchorPointY = "0.5",
															backGroundScale9Enable = "True;capInsetsX:0;capInsetsY:0;capInsetsWidth:0;capInsetsHeight:0",
															classname = "MEImage",
															dstBlendFunc = "771",
															height = "28",
															ignoreSize = "False",
															name = "Image_line1",
															sizepercentx = "0",
															sizepercenty = "0",
															sizeType = "0",
															srcBlendFunc = "1",
															texturePath = "ui/explore/growup/command/skill/013.png",
															touchAble = "False",
															UILayoutViewModel = 
															{
																PositionY = 6,
															},
															width = "46",
															ZOrder = "1",
														},
													},
												},
												{
													controlID = "Panel_light_Panel_line19_Panel_lines_Panel_skillMap3_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
													UUID = "e2ce7fb2_a57a_481c_8337_72368fe8af16",
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
													height = "10",
													ignoreSize = "False",
													name = "Panel_light",
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
													width = "10",
													ZOrder = "1",
													components = 
													{
														
														{
															controlID = "Image_line1_Panel_light_Panel_line19_Panel_lines_Panel_skillMap3_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
															UUID = "a3fde8bb_75b5_4750_a27a_5375c21360f1",
															anchorPoint = "False",
															anchorPointX = "0",
															anchorPointY = "0.5",
															backGroundScale9Enable = "True;capInsetsX:0;capInsetsY:0;capInsetsWidth:0;capInsetsHeight:0",
															classname = "MEImage",
															dstBlendFunc = "771",
															height = "28",
															ignoreSize = "False",
															name = "Image_line1",
															sizepercentx = "0",
															sizepercenty = "0",
															sizeType = "0",
															srcBlendFunc = "1",
															texturePath = "ui/explore/growup/command/skill/011.png",
															touchAble = "False",
															UILayoutViewModel = 
															{
																PositionY = 6,
															},
															width = "46",
															ZOrder = "1",
														},
													},
												},
											},
										},
										{
											controlID = "Panel_line20_Panel_lines_Panel_skillMap3_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
											UUID = "777a62b4_18a0_4c4b_acbb_29e454a40301",
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
											height = "10",
											ignoreSize = "False",
											name = "Panel_line20",
											rotation = "-45",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 2533,
												PositionY = 226,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "10",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "Panel_dark_Panel_line20_Panel_lines_Panel_skillMap3_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
													UUID = "8c49b93d_1182_493b_a90b_42e8ef68a5ad",
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
													height = "10",
													ignoreSize = "False",
													name = "Panel_dark",
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
													width = "10",
													ZOrder = "1",
													components = 
													{
														
														{
															controlID = "Image_line1_Panel_dark_Panel_line20_Panel_lines_Panel_skillMap3_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
															UUID = "0cf59b09_0703_4177_b37b_138a5f6ec580",
															anchorPoint = "False",
															anchorPointX = "0",
															anchorPointY = "0.5",
															backGroundScale9Enable = "True;capInsetsX:0;capInsetsY:0;capInsetsWidth:0;capInsetsHeight:0",
															classname = "MEImage",
															dstBlendFunc = "771",
															height = "28",
															ignoreSize = "False",
															name = "Image_line1",
															sizepercentx = "0",
															sizepercenty = "0",
															sizeType = "0",
															srcBlendFunc = "1",
															texturePath = "ui/explore/growup/command/skill/013.png",
															touchAble = "False",
															UILayoutViewModel = 
															{
																PositionY = 6,
															},
															width = "87",
															ZOrder = "1",
														},
													},
												},
												{
													controlID = "Panel_light_Panel_line20_Panel_lines_Panel_skillMap3_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
													UUID = "5788d1e9_e062_4a8a_830b_b5d98c23d52e",
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
													height = "10",
													ignoreSize = "False",
													name = "Panel_light",
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
													width = "10",
													ZOrder = "1",
													components = 
													{
														
														{
															controlID = "Image_line1_Panel_light_Panel_line20_Panel_lines_Panel_skillMap3_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
															UUID = "d34fe4b9_2d60_4d8f_b915_db1c1e32388f",
															anchorPoint = "False",
															anchorPointX = "0",
															anchorPointY = "0.5",
															backGroundScale9Enable = "True;capInsetsX:0;capInsetsY:0;capInsetsWidth:0;capInsetsHeight:0",
															classname = "MEImage",
															dstBlendFunc = "771",
															height = "28",
															ignoreSize = "False",
															name = "Image_line1",
															sizepercentx = "0",
															sizepercenty = "0",
															sizeType = "0",
															srcBlendFunc = "1",
															texturePath = "ui/explore/growup/command/skill/011.png",
															touchAble = "False",
															UILayoutViewModel = 
															{
																PositionY = 6,
															},
															width = "86",
															ZOrder = "1",
														},
													},
												},
											},
										},
										{
											controlID = "Panel_line21_Panel_lines_Panel_skillMap3_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
											UUID = "f50bc437_6a0b_4acc_99d2_cd98cb58b6ab",
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
											height = "10",
											ignoreSize = "False",
											name = "Panel_line21",
											rotation = "45",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 2651,
												PositionY = 286,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "10",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "Panel_dark_Panel_line21_Panel_lines_Panel_skillMap3_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
													UUID = "3886db56_4502_4349_bcfd_440d6705944f",
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
													height = "10",
													ignoreSize = "False",
													name = "Panel_dark",
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
													width = "10",
													ZOrder = "1",
													components = 
													{
														
														{
															controlID = "Image_line1_Panel_dark_Panel_line21_Panel_lines_Panel_skillMap3_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
															UUID = "5eeb9311_d167_462b_a8c5_87dfed62a922",
															anchorPoint = "False",
															anchorPointX = "0",
															anchorPointY = "0.5",
															backGroundScale9Enable = "True;capInsetsX:0;capInsetsY:0;capInsetsWidth:0;capInsetsHeight:0",
															classname = "MEImage",
															dstBlendFunc = "771",
															height = "28",
															ignoreSize = "False",
															name = "Image_line1",
															sizepercentx = "0",
															sizepercenty = "0",
															sizeType = "0",
															srcBlendFunc = "1",
															texturePath = "ui/explore/growup/command/skill/013.png",
															touchAble = "False",
															UILayoutViewModel = 
															{
																PositionY = 6,
															},
															width = "84",
															ZOrder = "1",
														},
													},
												},
												{
													controlID = "Panel_light_Panel_line21_Panel_lines_Panel_skillMap3_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
													UUID = "0063a7b4_00ac_4325_bed7_a35b09fd83c6",
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
													height = "10",
													ignoreSize = "False",
													name = "Panel_light",
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
													width = "10",
													ZOrder = "1",
													components = 
													{
														
														{
															controlID = "Image_line1_Panel_light_Panel_line21_Panel_lines_Panel_skillMap3_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
															UUID = "cdea8bbf_2b5d_4021_a34d_af59d50588ce",
															anchorPoint = "False",
															anchorPointX = "0",
															anchorPointY = "0.5",
															backGroundScale9Enable = "True;capInsetsX:0;capInsetsY:0;capInsetsWidth:0;capInsetsHeight:0",
															classname = "MEImage",
															dstBlendFunc = "771",
															height = "28",
															ignoreSize = "False",
															name = "Image_line1",
															sizepercentx = "0",
															sizepercenty = "0",
															sizeType = "0",
															srcBlendFunc = "1",
															texturePath = "ui/explore/growup/command/skill/011.png",
															touchAble = "False",
															UILayoutViewModel = 
															{
																PositionY = 6,
															},
															width = "85",
															ZOrder = "1",
														},
													},
												},
											},
										},
										{
											controlID = "Panel_line22_Panel_lines_Panel_skillMap3_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
											UUID = "faf64523_78cc_4b37_bf0c_0d1c63c22588",
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
											height = "10",
											ignoreSize = "False",
											name = "Panel_line22",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 2790,
												PositionY = 206,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "10",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "Panel_dark_Panel_line22_Panel_lines_Panel_skillMap3_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
													UUID = "dece76b5_337b_4f91_a0a1_7dc6c03005ea",
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
													height = "10",
													ignoreSize = "False",
													name = "Panel_dark",
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
													width = "10",
													ZOrder = "1",
													components = 
													{
														
														{
															controlID = "Image_line1_Panel_dark_Panel_line22_Panel_lines_Panel_skillMap3_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
															UUID = "363a6719_0e8d_4889_b869_143864e3f553",
															anchorPoint = "False",
															anchorPointX = "0",
															anchorPointY = "0.5",
															backGroundScale9Enable = "True;capInsetsX:0;capInsetsY:0;capInsetsWidth:0;capInsetsHeight:0",
															classname = "MEImage",
															dstBlendFunc = "771",
															height = "28",
															ignoreSize = "False",
															name = "Image_line1",
															sizepercentx = "0",
															sizepercenty = "0",
															sizeType = "0",
															srcBlendFunc = "1",
															texturePath = "ui/explore/growup/command/skill/013.png",
															touchAble = "False",
															UILayoutViewModel = 
															{
																PositionY = 6,
															},
															width = "46",
															ZOrder = "1",
														},
													},
												},
												{
													controlID = "Panel_light_Panel_line22_Panel_lines_Panel_skillMap3_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
													UUID = "a9beba3a_b59b_4a24_afd5_aa2ae0df9ead",
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
													height = "10",
													ignoreSize = "False",
													name = "Panel_light",
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
													width = "10",
													ZOrder = "1",
													components = 
													{
														
														{
															controlID = "Image_line1_Panel_light_Panel_line22_Panel_lines_Panel_skillMap3_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
															UUID = "e6d930f7_f690_44bc_bcaa_eedefa28fe0d",
															anchorPoint = "False",
															anchorPointX = "0",
															anchorPointY = "0.5",
															backGroundScale9Enable = "True;capInsetsX:0;capInsetsY:0;capInsetsWidth:0;capInsetsHeight:0",
															classname = "MEImage",
															dstBlendFunc = "771",
															height = "28",
															ignoreSize = "False",
															name = "Image_line1",
															sizepercentx = "0",
															sizepercenty = "0",
															sizeType = "0",
															srcBlendFunc = "1",
															texturePath = "ui/explore/growup/command/skill/011.png",
															touchAble = "False",
															UILayoutViewModel = 
															{
																PositionY = 6,
															},
															width = "46",
															ZOrder = "1",
														},
													},
												},
											},
										},
										{
											controlID = "Panel_line23_Panel_lines_Panel_skillMap3_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
											UUID = "2804fce7_e54b_4aa1_a8b6_c88701e34767",
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
											height = "10",
											ignoreSize = "False",
											name = "Panel_line23",
											rotation = "45",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 2906,
												PositionY = 185,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "10",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "Panel_dark_Panel_line23_Panel_lines_Panel_skillMap3_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
													UUID = "81bb21b3_430d_41b0_ade9_e980b1a1fac3",
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
													height = "10",
													ignoreSize = "False",
													name = "Panel_dark",
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
													width = "10",
													ZOrder = "1",
													components = 
													{
														
														{
															controlID = "Image_line1_Panel_dark_Panel_line23_Panel_lines_Panel_skillMap3_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
															UUID = "823433ce_fda9_4c03_8c86_a7333fe934c2",
															anchorPoint = "False",
															anchorPointX = "0",
															anchorPointY = "0.5",
															backGroundScale9Enable = "True;capInsetsX:0;capInsetsY:0;capInsetsWidth:0;capInsetsHeight:0",
															classname = "MEImage",
															dstBlendFunc = "771",
															height = "28",
															ignoreSize = "False",
															name = "Image_line1",
															sizepercentx = "0",
															sizepercenty = "0",
															sizeType = "0",
															srcBlendFunc = "1",
															texturePath = "ui/explore/growup/command/skill/013.png",
															touchAble = "False",
															UILayoutViewModel = 
															{
																PositionY = 6,
															},
															width = "84",
															ZOrder = "1",
														},
													},
												},
												{
													controlID = "Panel_light_Panel_line23_Panel_lines_Panel_skillMap3_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
													UUID = "5e0132c5_ab7e_4dbc_aed6_60312ef08316",
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
													height = "10",
													ignoreSize = "False",
													name = "Panel_light",
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
													width = "10",
													ZOrder = "1",
													components = 
													{
														
														{
															controlID = "Image_line1_Panel_light_Panel_line23_Panel_lines_Panel_skillMap3_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
															UUID = "113df611_a249_4e4a_9930_8135f06d1ee2",
															anchorPoint = "False",
															anchorPointX = "0",
															anchorPointY = "0.5",
															backGroundScale9Enable = "True;capInsetsX:0;capInsetsY:0;capInsetsWidth:0;capInsetsHeight:0",
															classname = "MEImage",
															dstBlendFunc = "771",
															height = "28",
															ignoreSize = "False",
															name = "Image_line1",
															sizepercentx = "0",
															sizepercenty = "0",
															sizeType = "0",
															srcBlendFunc = "1",
															texturePath = "ui/explore/growup/command/skill/011.png",
															touchAble = "False",
															UILayoutViewModel = 
															{
																PositionY = 6,
															},
															width = "85",
															ZOrder = "1",
														},
													},
												},
											},
										},
										{
											controlID = "Panel_line24_Panel_lines_Panel_skillMap3_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
											UUID = "61a0dd1d_e35f_4a13_90e9_94abc2381115",
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
											height = "10",
											ignoreSize = "False",
											name = "Panel_line24",
											rotation = "-45",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 3035,
												PositionY = 124,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "10",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "Panel_dark_Panel_line24_Panel_lines_Panel_skillMap3_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
													UUID = "cdec979a_8112_4a14_9358_cae09797b8fb",
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
													height = "10",
													ignoreSize = "False",
													name = "Panel_dark",
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
													width = "10",
													ZOrder = "1",
													components = 
													{
														
														{
															controlID = "Image_line1_Panel_dark_Panel_line24_Panel_lines_Panel_skillMap3_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
															UUID = "134dc37b_9fa1_4ac3_a368_7ac2786ddfda",
															anchorPoint = "False",
															anchorPointX = "0",
															anchorPointY = "0.5",
															backGroundScale9Enable = "True;capInsetsX:0;capInsetsY:0;capInsetsWidth:0;capInsetsHeight:0",
															classname = "MEImage",
															dstBlendFunc = "771",
															height = "28",
															ignoreSize = "False",
															name = "Image_line1",
															sizepercentx = "0",
															sizepercenty = "0",
															sizeType = "0",
															srcBlendFunc = "1",
															texturePath = "ui/explore/growup/command/skill/013.png",
															touchAble = "False",
															UILayoutViewModel = 
															{
																PositionY = 6,
															},
															width = "87",
															ZOrder = "1",
														},
													},
												},
												{
													controlID = "Panel_light_Panel_line24_Panel_lines_Panel_skillMap3_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
													UUID = "0def2a15_085e_4f72_8c77_4f605e90f293",
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
													height = "10",
													ignoreSize = "False",
													name = "Panel_light",
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
													width = "10",
													ZOrder = "1",
													components = 
													{
														
														{
															controlID = "Image_line1_Panel_light_Panel_line24_Panel_lines_Panel_skillMap3_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
															UUID = "3da1556c_84e5_487b_a757_6af0ac3a9dba",
															anchorPoint = "False",
															anchorPointX = "0",
															anchorPointY = "0.5",
															backGroundScale9Enable = "True;capInsetsX:0;capInsetsY:0;capInsetsWidth:0;capInsetsHeight:0",
															classname = "MEImage",
															dstBlendFunc = "771",
															height = "28",
															ignoreSize = "False",
															name = "Image_line1",
															sizepercentx = "0",
															sizepercenty = "0",
															sizeType = "0",
															srcBlendFunc = "1",
															texturePath = "ui/explore/growup/command/skill/011.png",
															touchAble = "False",
															UILayoutViewModel = 
															{
																PositionY = 6,
															},
															width = "86",
															ZOrder = "1",
														},
													},
												},
											},
										},
										{
											controlID = "Panel_line25_Panel_lines_Panel_skillMap3_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
											UUID = "4ad6acd3_cf49_4797_ab01_53397fa163c2",
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
											height = "10",
											ignoreSize = "False",
											name = "Panel_line25",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 3167,
												PositionY = 206,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "10",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "Panel_dark_Panel_line25_Panel_lines_Panel_skillMap3_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
													UUID = "3f590461_8510_44ca_91b4_d49c3668b1f7",
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
													height = "10",
													ignoreSize = "False",
													name = "Panel_dark",
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
													width = "10",
													ZOrder = "1",
													components = 
													{
														
														{
															controlID = "Image_line1_Panel_dark_Panel_line25_Panel_lines_Panel_skillMap3_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
															UUID = "ba0654e6_2f79_4a14_b878_8fedf4abb688",
															anchorPoint = "False",
															anchorPointX = "0",
															anchorPointY = "0.5",
															backGroundScale9Enable = "True;capInsetsX:0;capInsetsY:0;capInsetsWidth:0;capInsetsHeight:0",
															classname = "MEImage",
															dstBlendFunc = "771",
															height = "28",
															ignoreSize = "False",
															name = "Image_line1",
															sizepercentx = "0",
															sizepercenty = "0",
															sizeType = "0",
															srcBlendFunc = "1",
															texturePath = "ui/explore/growup/command/skill/013.png",
															touchAble = "False",
															UILayoutViewModel = 
															{
																PositionY = 6,
															},
															width = "46",
															ZOrder = "1",
														},
													},
												},
												{
													controlID = "Panel_light_Panel_line25_Panel_lines_Panel_skillMap3_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
													UUID = "b683c1c4_7f9d_4e57_bfd0_e87fb13dea72",
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
													height = "10",
													ignoreSize = "False",
													name = "Panel_light",
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
													width = "10",
													ZOrder = "1",
													components = 
													{
														
														{
															controlID = "Image_line1_Panel_light_Panel_line25_Panel_lines_Panel_skillMap3_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
															UUID = "ece29473_26fc_4bcb_971f_b28f62f282be",
															anchorPoint = "False",
															anchorPointX = "0",
															anchorPointY = "0.5",
															backGroundScale9Enable = "True;capInsetsX:0;capInsetsY:0;capInsetsWidth:0;capInsetsHeight:0",
															classname = "MEImage",
															dstBlendFunc = "771",
															height = "28",
															ignoreSize = "False",
															name = "Image_line1",
															sizepercentx = "0",
															sizepercenty = "0",
															sizeType = "0",
															srcBlendFunc = "1",
															texturePath = "ui/explore/growup/command/skill/011.png",
															touchAble = "False",
															UILayoutViewModel = 
															{
																PositionY = 6,
															},
															width = "46",
															ZOrder = "1",
														},
													},
												},
											},
										},
										{
											controlID = "Panel_line26_Panel_lines_Panel_skillMap3_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
											UUID = "496d287e_f3ec_4481_8701_eeb5f944326e",
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
											height = "10",
											ignoreSize = "False",
											name = "Panel_line26",
											rotation = "-45",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 3291,
												PositionY = 226,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "10",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "Panel_dark_Panel_line26_Panel_lines_Panel_skillMap3_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
													UUID = "279f29a4_c563_47ba_b55c_86eca7489557",
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
													height = "10",
													ignoreSize = "False",
													name = "Panel_dark",
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
													width = "10",
													ZOrder = "1",
													components = 
													{
														
														{
															controlID = "Image_line1_Panel_dark_Panel_line26_Panel_lines_Panel_skillMap3_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
															UUID = "e727f10f_f85f_48ef_bc10_a4787a575a4d",
															anchorPoint = "False",
															anchorPointX = "0",
															anchorPointY = "0.5",
															backGroundScale9Enable = "True;capInsetsX:0;capInsetsY:0;capInsetsWidth:0;capInsetsHeight:0",
															classname = "MEImage",
															dstBlendFunc = "771",
															height = "28",
															ignoreSize = "False",
															name = "Image_line1",
															sizepercentx = "0",
															sizepercenty = "0",
															sizeType = "0",
															srcBlendFunc = "1",
															texturePath = "ui/explore/growup/command/skill/013.png",
															touchAble = "False",
															UILayoutViewModel = 
															{
																PositionY = 6,
															},
															width = "87",
															ZOrder = "1",
														},
													},
												},
												{
													controlID = "Panel_light_Panel_line26_Panel_lines_Panel_skillMap3_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
													UUID = "53b902b5_fced_4a7e_a60a_1e807bd9cb2b",
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
													height = "10",
													ignoreSize = "False",
													name = "Panel_light",
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
													width = "10",
													ZOrder = "1",
													components = 
													{
														
														{
															controlID = "Image_line1_Panel_light_Panel_line26_Panel_lines_Panel_skillMap3_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
															UUID = "2de0adb0_5266_4721_9c09_78749bc483ec",
															anchorPoint = "False",
															anchorPointX = "0",
															anchorPointY = "0.5",
															backGroundScale9Enable = "True;capInsetsX:0;capInsetsY:0;capInsetsWidth:0;capInsetsHeight:0",
															classname = "MEImage",
															dstBlendFunc = "771",
															height = "28",
															ignoreSize = "False",
															name = "Image_line1",
															sizepercentx = "0",
															sizepercenty = "0",
															sizeType = "0",
															srcBlendFunc = "1",
															texturePath = "ui/explore/growup/command/skill/011.png",
															touchAble = "False",
															UILayoutViewModel = 
															{
																PositionY = 6,
															},
															width = "86",
															ZOrder = "1",
														},
													},
												},
											},
										},
										{
											controlID = "Panel_line27_Panel_lines_Panel_skillMap3_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
											UUID = "ff13c8f7_b662_4d01_b8f2_03a0b313f861",
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
											height = "10",
											ignoreSize = "False",
											name = "Panel_line27",
											rotation = "45",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 3409,
												PositionY = 286,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "10",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "Panel_dark_Panel_line27_Panel_lines_Panel_skillMap3_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
													UUID = "8c5d538b_a631_4b01_995f_22a6d82ee2fc",
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
													height = "10",
													ignoreSize = "False",
													name = "Panel_dark",
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
													width = "10",
													ZOrder = "1",
													components = 
													{
														
														{
															controlID = "Image_line1_Panel_dark_Panel_line27_Panel_lines_Panel_skillMap3_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
															UUID = "ccdeb1f2_3b70_4f55_bb5f_62990a43ced2",
															anchorPoint = "False",
															anchorPointX = "0",
															anchorPointY = "0.5",
															backGroundScale9Enable = "True;capInsetsX:0;capInsetsY:0;capInsetsWidth:0;capInsetsHeight:0",
															classname = "MEImage",
															dstBlendFunc = "771",
															height = "28",
															ignoreSize = "False",
															name = "Image_line1",
															sizepercentx = "0",
															sizepercenty = "0",
															sizeType = "0",
															srcBlendFunc = "1",
															texturePath = "ui/explore/growup/command/skill/013.png",
															touchAble = "False",
															UILayoutViewModel = 
															{
																PositionY = 6,
															},
															width = "84",
															ZOrder = "1",
														},
													},
												},
												{
													controlID = "Panel_light_Panel_line27_Panel_lines_Panel_skillMap3_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
													UUID = "e374129e_5c67_4388_812c_7db53d37dd43",
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
													height = "10",
													ignoreSize = "False",
													name = "Panel_light",
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
													width = "10",
													ZOrder = "1",
													components = 
													{
														
														{
															controlID = "Image_line1_Panel_light_Panel_line27_Panel_lines_Panel_skillMap3_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
															UUID = "b2f7d515_4a83_4d01_b377_a92f0e84e945",
															anchorPoint = "False",
															anchorPointX = "0",
															anchorPointY = "0.5",
															backGroundScale9Enable = "True;capInsetsX:0;capInsetsY:0;capInsetsWidth:0;capInsetsHeight:0",
															classname = "MEImage",
															dstBlendFunc = "771",
															height = "28",
															ignoreSize = "False",
															name = "Image_line1",
															sizepercentx = "0",
															sizepercenty = "0",
															sizeType = "0",
															srcBlendFunc = "1",
															texturePath = "ui/explore/growup/command/skill/011.png",
															touchAble = "False",
															UILayoutViewModel = 
															{
																PositionY = 6,
															},
															width = "85",
															ZOrder = "1",
														},
													},
												},
											},
										},
										{
											controlID = "Panel_line28_Panel_lines_Panel_skillMap3_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
											UUID = "ac97f62a_5bb1_4c94_ba62_635e1b3ff40e",
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
											height = "10",
											ignoreSize = "False",
											name = "Panel_line28",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 3548,
												PositionY = 206,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "10",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "Panel_dark_Panel_line28_Panel_lines_Panel_skillMap3_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
													UUID = "7e20b1b8_1602_42bf_965e_4b323144fa61",
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
													height = "10",
													ignoreSize = "False",
													name = "Panel_dark",
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
													width = "10",
													ZOrder = "1",
													components = 
													{
														
														{
															controlID = "Image_line1_Panel_dark_Panel_line28_Panel_lines_Panel_skillMap3_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
															UUID = "456639b0_3e6a_4b22_891e_041e55cdeedb",
															anchorPoint = "False",
															anchorPointX = "0",
															anchorPointY = "0.5",
															backGroundScale9Enable = "True;capInsetsX:0;capInsetsY:0;capInsetsWidth:0;capInsetsHeight:0",
															classname = "MEImage",
															dstBlendFunc = "771",
															height = "28",
															ignoreSize = "False",
															name = "Image_line1",
															sizepercentx = "0",
															sizepercenty = "0",
															sizeType = "0",
															srcBlendFunc = "1",
															texturePath = "ui/explore/growup/command/skill/013.png",
															touchAble = "False",
															UILayoutViewModel = 
															{
																PositionY = 6,
															},
															width = "46",
															ZOrder = "1",
														},
													},
												},
												{
													controlID = "Panel_light_Panel_line28_Panel_lines_Panel_skillMap3_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
													UUID = "65a87d55_4516_41a1_9c23_722d5872e3d2",
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
													height = "10",
													ignoreSize = "False",
													name = "Panel_light",
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
													width = "10",
													ZOrder = "1",
													components = 
													{
														
														{
															controlID = "Image_line1_Panel_light_Panel_line28_Panel_lines_Panel_skillMap3_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
															UUID = "a7f47bcc_7db4_45d9_9e72_230f1ad2d018",
															anchorPoint = "False",
															anchorPointX = "0",
															anchorPointY = "0.5",
															backGroundScale9Enable = "True;capInsetsX:0;capInsetsY:0;capInsetsWidth:0;capInsetsHeight:0",
															classname = "MEImage",
															dstBlendFunc = "771",
															height = "28",
															ignoreSize = "False",
															name = "Image_line1",
															sizepercentx = "0",
															sizepercenty = "0",
															sizeType = "0",
															srcBlendFunc = "1",
															texturePath = "ui/explore/growup/command/skill/011.png",
															touchAble = "False",
															UILayoutViewModel = 
															{
																PositionY = 6,
															},
															width = "46",
															ZOrder = "1",
														},
													},
												},
											},
										},
										{
											controlID = "Panel_line29_Panel_lines_Panel_skillMap3_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
											UUID = "91e82802_bdb4_477c_a2ab_7ce2bd575470",
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
											height = "10",
											ignoreSize = "False",
											name = "Panel_line29",
											rotation = "45",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 3664,
												PositionY = 185,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "10",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "Panel_dark_Panel_line29_Panel_lines_Panel_skillMap3_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
													UUID = "32c30961_640e_4bef_82da_62156db27fcc",
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
													height = "10",
													ignoreSize = "False",
													name = "Panel_dark",
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
													width = "10",
													ZOrder = "1",
													components = 
													{
														
														{
															controlID = "Image_line1_Panel_dark_Panel_line29_Panel_lines_Panel_skillMap3_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
															UUID = "281a0433_2cbd_4f86_8d2b_38cf348ae1b6",
															anchorPoint = "False",
															anchorPointX = "0",
															anchorPointY = "0.5",
															backGroundScale9Enable = "True;capInsetsX:0;capInsetsY:0;capInsetsWidth:0;capInsetsHeight:0",
															classname = "MEImage",
															dstBlendFunc = "771",
															height = "28",
															ignoreSize = "False",
															name = "Image_line1",
															sizepercentx = "0",
															sizepercenty = "0",
															sizeType = "0",
															srcBlendFunc = "1",
															texturePath = "ui/explore/growup/command/skill/013.png",
															touchAble = "False",
															UILayoutViewModel = 
															{
																PositionY = 6,
															},
															width = "84",
															ZOrder = "1",
														},
													},
												},
												{
													controlID = "Panel_light_Panel_line29_Panel_lines_Panel_skillMap3_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
													UUID = "7510c143_82fe_420a_a074_9f3d44126797",
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
													height = "10",
													ignoreSize = "False",
													name = "Panel_light",
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
													width = "10",
													ZOrder = "1",
													components = 
													{
														
														{
															controlID = "Image_line1_Panel_light_Panel_line29_Panel_lines_Panel_skillMap3_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
															UUID = "5646c9e3_96ae_4240_af82_87fb3537bdcf",
															anchorPoint = "False",
															anchorPointX = "0",
															anchorPointY = "0.5",
															backGroundScale9Enable = "True;capInsetsX:0;capInsetsY:0;capInsetsWidth:0;capInsetsHeight:0",
															classname = "MEImage",
															dstBlendFunc = "771",
															height = "28",
															ignoreSize = "False",
															name = "Image_line1",
															sizepercentx = "0",
															sizepercenty = "0",
															sizeType = "0",
															srcBlendFunc = "1",
															texturePath = "ui/explore/growup/command/skill/011.png",
															touchAble = "False",
															UILayoutViewModel = 
															{
																PositionY = 6,
															},
															width = "85",
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
							controlID = "Panel_skillItem_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
							UUID = "0bed069e_ae12_4c6a_aaff_781b8c66aac2",
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
							height = "10",
							ignoreSize = "False",
							name = "Panel_skillItem",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							touchAble = "False",
							UILayoutViewModel = 
							{
								PositionX = 220,
								PositionY = 129,
							},
							uipanelviewmodel = 
							{
								Layout="Absolute",
								nType = "0"
							},
							width = "10",
							ZOrder = "1",
							components = 
							{
								
								{
									controlID = "Image_light_Panel_skillItem_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
									UUID = "2cf7536f_2cad_41e3_bdaa_2c4b4651a165",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "104",
									ignoreSize = "True",
									name = "Image_light",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/explore/growup/command/skill/010.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										
									},
									visible = "False",
									width = "112",
									ZOrder = "1",
								},
								{
									controlID = "Image_dark_Panel_skillItem_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
									UUID = "380ead53_34a6_4730_8f2a_c1d1ab1256eb",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "84",
									ignoreSize = "True",
									name = "Image_dark",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/explore/growup/command/skill/020.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										
									},
									width = "94",
									ZOrder = "1",
								},
								{
									controlID = "Image_icon_Panel_skillItem_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
									UUID = "4985c0c3_a099_456a_b075_bd58e5b0d5de",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "74",
									ignoreSize = "True",
									name = "Image_icon",
									scaleX = "0.8",
									scaleY = "0.8",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/explore/growup/weapon/lingshijinengdianliang.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										
									},
									width = "74",
									ZOrder = "1",
								},
								{
									controlID = "Image_flag_Panel_skillItem_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
									UUID = "4d5afc4b_452a_4ba0_9762_52e8ee288a6f",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "148",
									ignoreSize = "True",
									name = "Image_flag",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/explore/growup/command/skill/012.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										
									},
									width = "42",
									ZOrder = "1",
								},
								{
									controlID = "Image_redTip_Panel_skillItem_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
									UUID = "30d13036_7aea_42e5_b175_9b554423d529",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "30",
									ignoreSize = "True",
									name = "Image_redTip",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/common/news_small.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = 20,
										PositionY = 34,
									},
									width = "30",
									ZOrder = "1",
								},
								{
									controlID = "Spine_item_Panel_skillItem_Panel_prefab_Panel-commandSkill_flyShipGrowUp_explore_Game",
									UUID = "b0aef573_2d24_4795_afdf_d7bec3ed5913",
									classname = "MESpine",
									dstBlendFunc = "771",
									name = "Spine_item",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									spineModel = 
									{
										SpinePath = "effect/effects_zhihuishi_jineng/effects_zhihuishi_jineng",
										animationName = "animation",
										IsLoop = false,
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
										PositionX = -3,
										relativeToName = "Panel",
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
			"ui/explore/growup/common/BG.png",
			"ui/explore/growup/common/t001.png",
			"ui/explore/growup/command/skill/lingshi001.png",
			"ui/explore/growup/command/skill/001.png",
			"ui/explore/growup/common/t003.png",
			"ui/explore/growup/command/skill/014.png",
			"ui/explore/growup/command/skill/015.png",
			"ui/explore/growup/command/skill/016.png",
			"ui/common/button_middle_n.png",
			"ui/explore/growup/command/skill/style_select_2.png",
			"ui/explore/growup/command/skill/style_normal_2.png",
			"ui/explore/growup/command/skill/style_flag_2.png",
			"ui/common/news_small.png",
			"ui/explore/growup/command/skill/013.png",
			"ui/explore/growup/command/skill/011.png",
			"ui/explore/growup/command/skill/010.png",
			"ui/explore/growup/command/skill/020.png",
			"ui/explore/growup/weapon/lingshijinengdianliang.png",
			"ui/explore/growup/command/skill/012.png",
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

