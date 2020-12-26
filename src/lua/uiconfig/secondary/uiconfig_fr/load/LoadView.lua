local t = 
{
	version = 1,
	components = 
	{
		
		{
			controlID = "Panel-LoadView_Layer1_load_Game",
			UUID = "f502aef9_88dd_4bf3_b349_ef3498222736",
			anchorPoint = "False",
			anchorPointX = "0",
			anchorPointY = "0",
			backGroundScale9Enable = "False",
			bgColorOpacity = "255",
			bIsOpenClipping = "False",
			classname = "MEPanel",
			colorType = "1;SingleColor:#FF000000;GraduallyChangingColorStart:#FFFFFFFF;GraduallyChangingColorEnd:#FFFFFFFF;vectorX:0;vectorY:0",
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
					controlID = "Panel_base_Panel-LoadView_Layer1_load_Game",
					UUID = "b4cb6438_7390_48a7_8751_0c2072bedc45",
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
					panelTexturePath = "ui/battle/load/team/014.png",
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
							controlID = "Image_bg_normal_Panel_base_Panel-LoadView_Layer1_load_Game",
							UUID = "fb85113b_e3fd_417c_82cc_375d9d149f75",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0",
							backGroundScale9Enable = "True;capInsetsX:50;capInsetsY:0;capInsetsWidth:20;capInsetsHeight:0",
							classname = "MEImage",
							dstBlendFunc = "771",
							height = "92",
							ignoreSize = "False",
							name = "Image_bg_normal",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							texturePath = "ui/battle/load/001.png",
							touchAble = "False",
							UILayoutViewModel = 
							{
								PositionX = 568,
								LeftPositon = -32,
								TopPosition = 608,
								relativeToName = "Panel",
							},
							width = "1386",
							ZOrder = "1",
							components = 
							{
								
								{
									controlID = "Image_left_Image_bg_normal_Panel_base_Panel-LoadView_Layer1_load_Game",
									UUID = "b4376d15_d7a4_4704_889f_5bcbcb10e096",
									anchorPoint = "False",
									anchorPointX = "0",
									anchorPointY = "0",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "60",
									ignoreSize = "True",
									name = "Image_left",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/battle/load/003.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = -693,
									},
									visible = "False",
									width = "368",
									ZOrder = "1",
								},
								{
									controlID = "Image_xts_Image_bg_normal_Panel_base_Panel-LoadView_Layer1_load_Game",
									UUID = "6c0e1af4_bb55_4413_b6e1_9dbf506b63da",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "44",
									ignoreSize = "True",
									name = "Image_xts",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/battle/load/002.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = -504,
										PositionY = 31,
									},
									width = "110",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "Label_xts_Image_xts_Image_bg_normal_Panel_base_Panel-LoadView_Layer1_load_Game",
											UUID = "dc6a91a2_2539_4c78_998a_347e0070473c",
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
											fontSize = "18",
											fontStroke = 
											{
												IsStroke = false,
												StrokeColor = "#FFE6E6E6",
												StrokeSize = 1,
											},
											height = "21",
											ignoreSize = "True",
											name = "Label_xts",
											nTextAlign = "1",
											nTextHAlign = "1",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "770",
											text = "Astuces",
											touchAble = "False",
											touchScaleEnable = "False",
											UILayoutViewModel = 
											{
												PositionX = -17,
											},
											width = "74",
											ZOrder = "1",
										},
									},
								},
							},
						},
						{
							controlID = "Panel_team_Panel_base_Panel-LoadView_Layer1_load_Game",
							UUID = "2cb9183a_98ce_4064_a56f_fa1877a8853e",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0",
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
							name = "Panel_team",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							touchAble = "False",
							UILayoutViewModel = 
							{
								PositionX = 568,
							},
							uipanelviewmodel = 
							{
								Layout="Absolute",
								nType = "0"
							},
							width = "1386",
							ZOrder = "1",
						},
						{
							controlID = "Panel_load_Panel_base_Panel-LoadView_Layer1_load_Game",
							UUID = "620d7a30_77fc_42fb_8161_de6d02af910f",
							anchorPoint = "False",
							anchorPointX = "0",
							anchorPointY = "0",
							backGroundScale9Enable = "True;capInsetsX:20;capInsetsY:0;capInsetsWidth:10;capInsetsHeight:5",
							bgColorOpacity = "50",
							bIsOpenClipping = "False",
							classname = "MEPanel",
							colorType = "0;SingleColor:#FFE6E6E6;GraduallyChangingColorStart:#FFFFFFFF;GraduallyChangingColorEnd:#FFFFFFFF;vectorX:0;vectorY:0",
							DesignHeight = "640",
							DesignType = "0",
							DesignWidth = "960",
							dstBlendFunc = "771",
							height = "8",
							ignoreSize = "False",
							name = "Panel_load",
							panelTexturePath = "ui/load_bg.png",
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
							width = "1136",
							ZOrder = "1",
							components = 
							{
								
								{
									controlID = "LoadingBar_Panel_load_Panel_base_Panel-LoadView_Layer1_load_Game",
									UUID = "0054d39c_fed5_4392_b768_cfe1ffec61fc",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "True;capInsetsX:20;capInsetsY:0;capInsetsWidth:20;capInsetsHeight:5",
									classname = "MELoadingBar",
									direction = "0",
									dstBlendFunc = "771",
									height = "8",
									ignoreSize = "False",
									name = "LoadingBar",
									percent = "100",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texture = "ui/load.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = 568,
										PositionY = 4,
										IsPercent = true,
										PercentX = 50,
										PercentY = 50,
										relativeToName = "Panel",
									},
									width = "1136",
									ZOrder = "1",
								},
							},
						},
						{
							controlID = "Label_tip_Panel_base_Panel-LoadView_Layer1_load_Game",
							UUID = "8117be68_35d5_4f91_9e8e_6a3171737a45",
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
							fontSize = "18",
							fontStroke = 
							{
								IsStroke = false,
								StrokeColor = "#FFE6E6E6",
								StrokeSize = 1,
							},
							height = "0",
							ignoreSize = "False",
							name = "Label_tip",
							nTextAlign = "0",
							nTextHAlign = "0",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "770",
							text = "Conseils de bataille",
							touchAble = "False",
							touchScaleEnable = "False",
							UILayoutViewModel = 
							{
								PositionX = 119,
								PositionY = 31,
							},
							width = "1000",
							ZOrder = "1",
						},
						{
							controlID = "Label_percent_Panel_base_Panel-LoadView_Layer1_load_Game",
							UUID = "cfd5b659_cf6a_4209_adfc_dc544ed6546b",
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
							name = "Label_percent",
							nTextAlign = "1",
							nTextHAlign = "1",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "770",
							text = "load10%",
							touchAble = "False",
							touchScaleEnable = "False",
							UILayoutViewModel = 
							{
								PositionX = 541,
								PositionY = 240,
								IsPercent = true,
								PercentX = 47.61,
								PercentY = 37.54,
							},
							width = "71",
							ZOrder = "1",
						},
						{
							controlID = "Panel_role1_Panel_base_Panel-LoadView_Layer1_load_Game",
							UUID = "66de4b09_f8fb_4f1f_b3e5_630057435394",
							anchorPoint = "False",
							anchorPointX = "0",
							anchorPointY = "0",
							backGroundScale9Enable = "False",
							bgColorOpacity = "120",
							bIsOpenClipping = "False",
							classname = "MEPanel",
							colorType = "0;SingleColor:#FFFF0000;GraduallyChangingColorStart:#FFFFFFFF;GraduallyChangingColorEnd:#FFFFFFFF;vectorX:0;vectorY:0",
							DesignHeight = "640",
							DesignType = "0",
							DesignWidth = "960",
							dstBlendFunc = "771",
							height = "522",
							ignoreSize = "False",
							name = "Panel_role1",
							panelTexturePath = "ui/battle/load/team/009.png",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							touchAble = "False",
							UILayoutViewModel = 
							{
								PositionX = 13,
								PositionY = 60,
								LeftPositon = 33,
								TopPosition = 549,
								relativeToName = "Panel",
							},
							uipanelviewmodel = 
							{
								Layout="Absolute",
								nType = "0"
							},
							width = "225",
							ZOrder = "1",
							components = 
							{
								
								{
									controlID = "Panel_role_Panel_role1_Panel_base_Panel-LoadView_Layer1_load_Game",
									UUID = "6c0ee1b8_b488_4562_b0cc_1130c852409d",
									anchorPoint = "False",
									anchorPointX = "0",
									anchorPointY = "0",
									backGroundScale9Enable = "False",
									bgColorOpacity = "50",
									bIsOpenClipping = "True",
									classname = "MEPanel",
									colorType = "1;SingleColor:#FFFF0000;GraduallyChangingColorStart:#FFFFFFFF;GraduallyChangingColorEnd:#FFFFFFFF;vectorX:0;vectorY:0",
									DesignHeight = "640",
									DesignType = "0",
									DesignWidth = "960",
									dstBlendFunc = "771",
									height = "566",
									ignoreSize = "False",
									name = "Panel_role",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = 4,
										PositionY = 13,
									},
									uipanelviewmodel = 
									{
										Layout="Absolute",
										nType = "0"
									},
									width = "208",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "Image_back_Panel_role_Panel_role1_Panel_base_Panel-LoadView_Layer1_load_Game",
											UUID = "e3d76ae2_f71a_4eee_a7c6_ef71894d7af7",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											classname = "MEImage",
											dstBlendFunc = "771",
											height = "506",
											ignoreSize = "True",
											name = "Image_back",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											texturePath = "ui/battle/load/team/010.png",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 104,
												PositionY = 253,
											},
											width = "208",
											ZOrder = "1",
										},
										{
											controlID = "Image_front_mask_Panel_role_Panel_role1_Panel_base_Panel-LoadView_Layer1_load_Game",
											UUID = "40761af4_5ae8_4329_a9d1_61b0c8e58b90",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											classname = "MEImage",
											dstBlendFunc = "771",
											height = "248",
											ignoreSize = "True",
											name = "Image_front_mask",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											texturePath = "ui/battle/load/team/012.png",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 104,
												PositionY = 442,
												IsPercent = true,
												PercentX = 50,
												PercentY = 78.09,
											},
											width = "208",
											ZOrder = "1",
										},
										{
											controlID = "Image_role_Panel_role_Panel_role1_Panel_base_Panel-LoadView_Layer1_load_Game",
											UUID = "8be94f4b_513d_4c8c_bdf9_aeb7532b8132",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											classname = "MEImage",
											dstBlendFunc = "771",
											height = "64",
											ignoreSize = "True",
											name = "Image_role",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 104,
												PositionY = 253,
											},
											width = "64",
											ZOrder = "1",
										},
									},
								},
								{
									controlID = "Image_front_Panel_role1_Panel_base_Panel-LoadView_Layer1_load_Game",
									UUID = "4956792b_f70d_4fbc_a6f4_0aad5a08ca37",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "471",
									ignoreSize = "True",
									name = "Image_front",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/battle/load/team/011.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = 108,
										PositionY = 248,
									},
									width = "209",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "Image_front005_Image_front_Panel_role1_Panel_base_Panel-LoadView_Layer1_load_Game",
											UUID = "99734180_cc65_46ed_85fa_2630fa8148b2",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											classname = "MEImage",
											dstBlendFunc = "771",
											height = "35",
											ignoreSize = "True",
											name = "Image_front005",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											texturePath = "ui/battle/load/team/005.png",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionY = -218,
											},
											width = "210",
											ZOrder = "1",
										},
										{
											controlID = "Image_front004_Image_front_Panel_role1_Panel_base_Panel-LoadView_Layer1_load_Game",
											UUID = "07b4aa03_cd26_4364_85ea_b4e2e77fa6d4",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											classname = "MEImage",
											dstBlendFunc = "771",
											height = "35",
											ignoreSize = "True",
											name = "Image_front004",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											texturePath = "ui/battle/load/team/004.png",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = -1,
												PositionY = -218,
											},
											width = "210",
											ZOrder = "1",
										},
										{
											controlID = "Image_leader_parent_Image_front_Panel_role1_Panel_base_Panel-LoadView_Layer1_load_Game",
											UUID = "13dfaa62_df51_494e_8f15_d2a03b39ed0f",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											classname = "MEImage",
											dstBlendFunc = "771",
											height = "46",
											ignoreSize = "True",
											name = "Image_leader_parent",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											texturePath = "ui/battle/load/team/003.png",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionY = 308,
											},
											width = "208",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "Image_leader_Image_leader_parent_Image_front_Panel_role1_Panel_base_Panel-LoadView_Layer1_load_Game",
													UUID = "9f0497c9_3acd_48e1_a604_0feb473c4840",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0.5",
													backGroundScale9Enable = "False",
													classname = "MEImage",
													dstBlendFunc = "771",
													height = "78",
													ignoreSize = "True",
													name = "Image_leader",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "1",
													texturePath = "ui/battle/teamex/005.png",
													touchAble = "False",
													UILayoutViewModel = 
													{
														PositionX = -14,
														PositionY = -2,
													},
													width = "78",
													ZOrder = "1",
												},
												{
													controlID = "Label_leader_Image_leader_parent_Image_front_Panel_role1_Panel_base_Panel-LoadView_Layer1_load_Game",
													UUID = "04014ba2_e1b2_453a_96c1_9a0cd8914b6a",
													anchorPoint = "False",
													anchorPointX = "0",
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
													fontSize = "15",
													fontStroke = 
													{
														IsStroke = false,
														StrokeColor = "#FFE6E6E6",
														StrokeSize = 1,
													},
													height = "17",
													ignoreSize = "True",
													name = "Label_leader",
													nTextAlign = "1",
													nTextHAlign = "1",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "770",
													text = "Capitaine",
													touchAble = "False",
													touchScaleEnable = "False",
													UILayoutViewModel = 
													{
														PositionX = 13,
														PositionY = -4,
													},
													width = "77",
													ZOrder = "1",
												},
											},
										},
									},
								},
								{
									controlID = "Image_load_Panel_role1_Panel_base_Panel-LoadView_Layer1_load_Game",
									UUID = "bfd72532_316a_4256_83f5_520ee8faf0e5",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "117",
									ignoreSize = "True",
									name = "Image_load",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/battle/load/team/006.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = 110,
										PositionY = 150,
									},
									width = "117",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "Load_per_Image_load_Panel_role1_Panel_base_Panel-LoadView_Layer1_load_Game",
											UUID = "4dc7ee1d_5c7c_41da_8119_bf0b65f358c1",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											classname = "MELoadingBar",
											direction = "4",
											dstBlendFunc = "771",
											height = "99",
											ignoreSize = "True",
											name = "Load_per",
											percent = "100",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											texture = "ui/battle/load/team/007.png",
											touchAble = "False",
											UILayoutViewModel = 
											{
												relativeToName = "Panel",
											},
											width = "99",
											ZOrder = "1",
										},
										{
											controlID = "Label_per_Image_load_Panel_role1_Panel_base_Panel-LoadView_Layer1_load_Game",
											UUID = "d5ce790a_db1f_471b_b086_fc5d11358606",
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
											fontSize = "28",
											fontStroke = 
											{
												IsStroke = false,
												StrokeColor = "#FFE6E6E6",
												StrokeSize = 1,
											},
											height = "32",
											ignoreSize = "True",
											name = "Label_per",
											nTextAlign = "1",
											nTextHAlign = "1",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "770",
											text = "99.0",
											touchAble = "False",
											touchScaleEnable = "False",
											UILayoutViewModel = 
											{
												PositionX = 14,
											},
											width = "53",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "Label_per_p_Label_per_Image_load_Panel_role1_Panel_base_Panel-LoadView_Layer1_load_Game",
													UUID = "0155fa20_6b0b_49ec_a703_491a937ba3cb",
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
														IsStroke = false,
														StrokeColor = "#FFE6E6E6",
														StrokeSize = 1,
													},
													height = "16",
													ignoreSize = "True",
													name = "Label_per_p",
													nTextAlign = "1",
													nTextHAlign = "1",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "770",
													text = "%",
													touchAble = "False",
													touchScaleEnable = "False",
													UILayoutViewModel = 
													{
														PositionX = 6,
														PositionY = -3,
													},
													width = "12",
													ZOrder = "1",
												},
											},
										},
										{
											controlID = "Image_ok_Image_load_Panel_role1_Panel_base_Panel-LoadView_Layer1_load_Game",
											UUID = "37186bba_4c9c_4ee4_a8b6_ad9917105aab",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											classname = "MEImage",
											dstBlendFunc = "771",
											height = "118",
											ignoreSize = "True",
											name = "Image_ok",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											texturePath = "ui/battle/load/team/008.png",
											touchAble = "False",
											UILayoutViewModel = 
											{
												
											},
											width = "118",
											ZOrder = "1",
										},
										{
											controlID = "Spine_effect_Image_load_Panel_role1_Panel_base_Panel-LoadView_Layer1_load_Game",
											UUID = "1e9408b3_520a_4220_8acf_8cf30fdee41a",
											classname = "MESpine",
											dstBlendFunc = "771",
											name = "Spine_effect",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											spineModel = 
											{
												SpinePath = "effect/effect_teamNew3/effect_teamNew3",
												animationName = "effect_teamNew_08",
												IsLoop = false,
												IsPlay = false,
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
									controlID = "Label_name_Panel_role1_Panel_base_Panel-LoadView_Layer1_load_Game",
									UUID = "7e80ed12_5037_4c7c_9ffe_7cb4787d1caf",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0",
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
									fontSize = "15",
									fontStroke = 
									{
										IsStroke = false,
										StrokeColor = "#FFE6E6E6",
										StrokeSize = 1,
									},
									height = "0",
									ignoreSize = "False",
									name = "Label_name",
									nTextAlign = "1",
									nTextHAlign = "1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "Nom du joueur",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionX = 110,
										PositionY = 51,
									},
									width = "194",
									ZOrder = "1",
								},
								{
									controlID = "Label_fight_Panel_role1_Panel_base_Panel-LoadView_Layer1_load_Game",
									UUID = "75ea5f43_3e71_41d6_a8cf_017473a01ba8",
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
									height = "25",
									ignoreSize = "True",
									name = "Label_fight",
									nTextAlign = "1",
									nTextHAlign = "1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "99999.0",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionX = 72,
										PositionY = 27,
									},
									width = "82",
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
			"ui/battle/load/team/014.png",
			"ui/battle/load/001.png",
			"ui/battle/load/003.png",
			"ui/battle/load/002.png",
			"ui/load_bg.png",
			"ui/load.png",
			"ui/battle/load/team/009.png",
			"ui/battle/load/team/010.png",
			"ui/battle/load/team/012.png",
			"ui/battle/load/team/011.png",
			"ui/battle/load/team/005.png",
			"ui/battle/load/team/004.png",
			"ui/battle/load/team/003.png",
			"ui/battle/teamex/005.png",
			"ui/battle/load/team/006.png",
			"ui/battle/load/team/007.png",
			"ui/battle/load/team/008.png",
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

