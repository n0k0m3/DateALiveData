local t = 
{
	version = 1,
	components = 
	{
		
		{
			controlID = "Panel-welfareView_Layer1_oneYear_Game",
			UUID = "7baa424a_f37e_445c_aacf_7c0b12f21731",
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
			height = "548",
			ignoreSize = "False",
			name = "Panel",
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
			width = "888",
			ZOrder = "1",
			components = 
			{
				
				{
					controlID = "Panel_root_Panel-welfareView_Layer1_oneYear_Game",
					UUID = "9728662e_b0bb_46c0_b865_93d3116dfd13",
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
					height = "548",
					ignoreSize = "False",
					name = "Panel_root",
					sizepercentx = "100",
					sizepercenty = "100",
					sizeType = "1",
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
					width = "888",
					ZOrder = "1",
					components = 
					{
						
						{
							controlID = "Image_content_Panel_root_Panel-welfareView_Layer1_oneYear_Game",
							UUID = "39ef4fbf_297c_41ad_bc87_e4234af6fdb7",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							backGroundScale9Enable = "False",
							classname = "MEImage",
							dstBlendFunc = "771",
							height = "536",
							ignoreSize = "True",
							name = "Image_content",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							texturePath = "ui/activity/oneYear/card/003.png",
							touchAble = "False",
							UILayoutViewModel = 
							{
								
							},
							width = "926",
							ZOrder = "1",
							components = 
							{
								
								{
									controlID = "Image_corner_Image_content_Panel_root_Panel-welfareView_Layer1_oneYear_Game",
									UUID = "c26949a2_f4fe_48f9_9557_255f3412d9ef",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "88",
									ignoreSize = "True",
									name = "Image_corner",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/activity/oneYear/corner.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = -387,
										PositionY = 224,
									},
									width = "150",
									ZOrder = "1",
								},
								{
									controlID = "Label_vote_cnt_Image_content_Panel_root_Panel-welfareView_Layer1_oneYear_Game",
									UUID = "3dbfb95a_9cd2_456f_a7eb_8f0566d8c725",
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
									fontSize = "20",
									fontStroke = 
									{
										IsStroke = false,
										StrokeColor = "#FFE6E6E6",
										StrokeSize = 1,
									},
									height = "23",
									ignoreSize = "True",
									name = "Label_vote_cnt",
									nTextAlign = "1",
									nTextHAlign = "1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "Chances de dépliage quotidiennes ",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionX = 62,
										PositionY = -170,
									},
									width = "268",
									ZOrder = "1",
								},
								{
									controlID = "Image_cost_icon_Image_content_Panel_root_Panel-welfareView_Layer1_oneYear_Game",
									UUID = "6539b44a_1d02_4f99_a43c_56d483e5243d",
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
									texturePath = "icon/item/goods/500066.png",
									touchAble = "True",
									UILayoutViewModel = 
									{
										PositionX = 81,
										PositionY = -171,
									},
									width = "100",
									ZOrder = "1",
								},
								{
									controlID = "Label_vote_cnt_tip_Image_content_Panel_root_Panel-welfareView_Layer1_oneYear_Game",
									UUID = "855d2ae0_2108_4559_885d_8087eae4e30b",
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
									fontSize = "20",
									fontStroke = 
									{
										IsStroke = false,
										StrokeColor = "#FFE6E6E6",
										StrokeSize = 1,
									},
									height = "23",
									ignoreSize = "True",
									name = "Label_vote_cnt_tip",
									nTextAlign = "1",
									nTextHAlign = "1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "Vous pouvez tirer une carte",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionX = 100,
										PositionY = -170,
									},
									width = "143",
									ZOrder = "1",
								},
								{
									controlID = "Panel_card_Image_content_Panel_root_Panel-welfareView_Layer1_oneYear_Game",
									UUID = "a2cc72fe_3794_4932_89c4_243ff48a8601",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									bgColorOpacity = "50",
									bIsOpenClipping = "True",
									classname = "MEPanel",
									colorType = "0;SingleColor:#FFFF0000;GraduallyChangingColorStart:#FFFFFFFF;GraduallyChangingColorEnd:#FFFFFFFF;vectorX:0;vectorY:0",
									DesignHeight = "640",
									DesignType = "0",
									DesignWidth = "960",
									dstBlendFunc = "771",
									height = "520",
									ignoreSize = "False",
									name = "Panel_card",
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
									width = "900",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "Panel_card_1_Panel_card_Image_content_Panel_root_Panel-welfareView_Layer1_oneYear_Game",
											UUID = "90015449_0f70_45db_ade8_5c4d504e2b03",
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
											height = "312",
											ignoreSize = "False",
											name = "Panel_card_1",
											rotation = "1",
											scaleX = "0.92",
											scaleY = "0.92",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "True",
											UILayoutViewModel = 
											{
												PositionX = -294,
												PositionY = 25,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "218",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "Spine_bg_Panel_card_1_Panel_card_Image_content_Panel_root_Panel-welfareView_Layer1_oneYear_Game",
													UUID = "7968131a_e86d_4b24_8f81_d47ce9de96da",
													classname = "MESpine",
													dstBlendFunc = "771",
													name = "Spine_bg",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													spineModel = 
													{
														SpinePath = "effect/effects_ZNQ_fanka/effects_ZNQ_fanka",
														animationName = "effects_ZNQ_fanka_cheng",
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
														relativeToName = "Panel",
													},
													ZOrder = "1",
												},
												{
													controlID = "Panel_front_Panel_card_1_Panel_card_Image_content_Panel_root_Panel-welfareView_Layer1_oneYear_Game",
													UUID = "eead69c2_6688_4bd1_8700_7d3e79761010",
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
													height = "312",
													ignoreSize = "False",
													name = "Panel_front",
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
													width = "218",
													ZOrder = "1",
													components = 
													{
														
														{
															controlID = "Image_quality_bg1_Panel_front_Panel_card_1_Panel_card_Image_content_Panel_root_Panel-welfareView_Layer1_oneYear_Game",
															UUID = "72606b77_85c9_4441_b30a_9b2b223d147e",
															anchorPoint = "False",
															anchorPointX = "0.5",
															anchorPointY = "0.5",
															backGroundScale9Enable = "False",
															classname = "MEImage",
															dstBlendFunc = "771",
															height = "312",
															ignoreSize = "True",
															name = "Image_quality_bg1",
															sizepercentx = "0",
															sizepercenty = "0",
															sizeType = "0",
															srcBlendFunc = "1",
															texturePath = "ui/activity/oneYear/card/005.png",
															touchAble = "False",
															UILayoutViewModel = 
															{
																
															},
															width = "218",
															ZOrder = "1",
															components = 
															{
																
																{
																	controlID = "Image_item_bg_Image_quality_bg1_Panel_front_Panel_card_1_Panel_card_Image_content_Panel_root_Panel-welfareView_Layer1_oneYear_Game",
																	UUID = "02de4e5a_586a_468a_a0cf_77acc44e0a1a",
																	anchorPoint = "False",
																	anchorPointX = "0.5",
																	anchorPointY = "0.5",
																	backGroundScale9Enable = "False",
																	classname = "MEImage",
																	dstBlendFunc = "771",
																	height = "121",
																	ignoreSize = "True",
																	name = "Image_item_bg",
																	opacity = "127",
																	sizepercentx = "0",
																	sizepercenty = "0",
																	sizeType = "0",
																	srcBlendFunc = "1",
																	texturePath = "ui/activity/oneYear/card/008.png",
																	touchAble = "False",
																	UILayoutViewModel = 
																	{
																		
																	},
																	width = "136",
																	ZOrder = "1",
																},
															},
														},
														{
															controlID = "Image_quality_bg2_Panel_front_Panel_card_1_Panel_card_Image_content_Panel_root_Panel-welfareView_Layer1_oneYear_Game",
															UUID = "3ca1910f_5da2_4861_869b_0ad12c5f85f5",
															anchorPoint = "False",
															anchorPointX = "0.5",
															anchorPointY = "0.5",
															backGroundScale9Enable = "False",
															classname = "MEImage",
															dstBlendFunc = "771",
															height = "312",
															ignoreSize = "True",
															name = "Image_quality_bg2",
															sizepercentx = "0",
															sizepercenty = "0",
															sizeType = "0",
															srcBlendFunc = "1",
															texturePath = "ui/activity/oneYear/card/006.png",
															touchAble = "False",
															UILayoutViewModel = 
															{
																
															},
															width = "218",
															ZOrder = "1",
															components = 
															{
																
																{
																	controlID = "Image_item_bg_Image_quality_bg2_Panel_front_Panel_card_1_Panel_card_Image_content_Panel_root_Panel-welfareView_Layer1_oneYear_Game",
																	UUID = "034d072a_88f4_4188_ab85_582c313a4d9d",
																	anchorPoint = "False",
																	anchorPointX = "0.5",
																	anchorPointY = "0.5",
																	backGroundScale9Enable = "False",
																	classname = "MEImage",
																	dstBlendFunc = "771",
																	height = "121",
																	ignoreSize = "True",
																	name = "Image_item_bg",
																	opacity = "127",
																	sizepercentx = "0",
																	sizepercenty = "0",
																	sizeType = "0",
																	srcBlendFunc = "1",
																	texturePath = "ui/activity/oneYear/card/009.png",
																	touchAble = "False",
																	UILayoutViewModel = 
																	{
																		
																	},
																	width = "136",
																	ZOrder = "1",
																},
															},
														},
														{
															controlID = "Image_quality_bg3_Panel_front_Panel_card_1_Panel_card_Image_content_Panel_root_Panel-welfareView_Layer1_oneYear_Game",
															UUID = "20e9b709_9fbe_459c_8a4c_5f1fd8edfcd8",
															anchorPoint = "False",
															anchorPointX = "0.5",
															anchorPointY = "0.5",
															backGroundScale9Enable = "False",
															classname = "MEImage",
															dstBlendFunc = "771",
															height = "312",
															ignoreSize = "True",
															name = "Image_quality_bg3",
															sizepercentx = "0",
															sizepercenty = "0",
															sizeType = "0",
															srcBlendFunc = "1",
															texturePath = "ui/activity/oneYear/card/007.png",
															touchAble = "False",
															UILayoutViewModel = 
															{
																
															},
															width = "218",
															ZOrder = "1",
															components = 
															{
																
																{
																	controlID = "Image_item_bg_Image_quality_bg3_Panel_front_Panel_card_1_Panel_card_Image_content_Panel_root_Panel-welfareView_Layer1_oneYear_Game",
																	UUID = "54aeb0a4_202b_4928_9928_6408a81c0f6e",
																	anchorPoint = "False",
																	anchorPointX = "0.5",
																	anchorPointY = "0.5",
																	backGroundScale9Enable = "False",
																	classname = "MEImage",
																	dstBlendFunc = "771",
																	height = "121",
																	ignoreSize = "True",
																	name = "Image_item_bg",
																	opacity = "127",
																	sizepercentx = "0",
																	sizepercenty = "0",
																	sizeType = "0",
																	srcBlendFunc = "1",
																	texturePath = "ui/activity/oneYear/card/010.png",
																	touchAble = "False",
																	UILayoutViewModel = 
																	{
																		
																	},
																	width = "136",
																	ZOrder = "1",
																},
															},
														},
														{
															controlID = "Image_item_Panel_front_Panel_card_1_Panel_card_Image_content_Panel_root_Panel-welfareView_Layer1_oneYear_Game",
															UUID = "d8a274d4_485c_4d85_a933_03ab8e243297",
															anchorPoint = "False",
															anchorPointX = "0.5",
															anchorPointY = "0.5",
															backGroundScale9Enable = "False",
															classname = "MEImage",
															dstBlendFunc = "771",
															height = "64",
															ignoreSize = "True",
															name = "Image_item",
															sizepercentx = "0",
															sizepercenty = "0",
															sizeType = "0",
															srcBlendFunc = "1",
															touchAble = "False",
															UILayoutViewModel = 
															{
																
															},
															width = "64",
															ZOrder = "1",
															components = 
															{
																
																{
																	controlID = "Label_name_Image_item_Panel_front_Panel_card_1_Panel_card_Image_content_Panel_root_Panel-welfareView_Layer1_oneYear_Game",
																	UUID = "ee805a5a_0cda_49df_a32d_e1e84f4af9f5",
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
																	name = "Label_name",
																	nTextAlign = "1",
																	nTextHAlign = "1",
																	sizepercentx = "0",
																	sizepercenty = "0",
																	sizeType = "0",
																	srcBlendFunc = "770",
																	text = "Nom de l'objet",
																	touchAble = "False",
																	touchScaleEnable = "False",
																	UILayoutViewModel = 
																	{
																		PositionY = -82,
																	},
																	width = "83",
																	ZOrder = "1",
																},
																{
																	controlID = "Label_num_Image_item_Panel_front_Panel_card_1_Panel_card_Image_content_Panel_root_Panel-welfareView_Layer1_oneYear_Game",
																	UUID = "51a9155b_9508_445e_91b0_649de17261c9",
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
																	name = "Label_num",
																	nTextAlign = "1",
																	nTextHAlign = "1",
																	sizepercentx = "0",
																	sizepercenty = "0",
																	sizeType = "0",
																	srcBlendFunc = "770",
																	text = "x2",
																	touchAble = "False",
																	touchScaleEnable = "False",
																	UILayoutViewModel = 
																	{
																		PositionY = -108,
																	},
																	width = "35",
																	ZOrder = "1",
																},
															},
														},
													},
												},
												{
													controlID = "Spine_front_Panel_card_1_Panel_card_Image_content_Panel_root_Panel-welfareView_Layer1_oneYear_Game",
													UUID = "8f24e433_02ea_41fd_b071_ce6a1481e4d6",
													classname = "MESpine",
													dstBlendFunc = "771",
													name = "Spine_front",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													spineModel = 
													{
														SpinePath = "effect/effects_ZNQ_fanka/effects_ZNQ_fanka",
														animationName = "effects_ZNQ_fanka_zi",
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
														relativeToName = "Panel",
													},
													ZOrder = "1",
												},
												{
													controlID = "Image_back_card_Panel_card_1_Panel_card_Image_content_Panel_root_Panel-welfareView_Layer1_oneYear_Game",
													UUID = "8bfa61ac_7ebe_4ee9_9647_109da8173728",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0.5",
													backGroundScale9Enable = "False",
													classname = "MEImage",
													dstBlendFunc = "771",
													height = "312",
													ignoreSize = "True",
													name = "Image_back_card",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "1",
													texturePath = "ui/activity/oneYear/card/002.png",
													touchAble = "False",
													UILayoutViewModel = 
													{
														
													},
													width = "218",
													ZOrder = "1",
												},
											},
										},
										{
											controlID = "Panel_card_2_Panel_card_Image_content_Panel_root_Panel-welfareView_Layer1_oneYear_Game",
											UUID = "d454507e_13b9_4a44_8917_9707696c697a",
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
											height = "312",
											ignoreSize = "False",
											name = "Panel_card_2",
											rotation = "1",
											scaleX = "0.92",
											scaleY = "0.92",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "True",
											UILayoutViewModel = 
											{
												PositionX = -174,
												PositionY = 25,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "218",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "Spine_bg_Panel_card_2_Panel_card_Image_content_Panel_root_Panel-welfareView_Layer1_oneYear_Game",
													UUID = "a1820d32_6768_43d2_a118_fc1c4adb35fb",
													classname = "MESpine",
													dstBlendFunc = "771",
													name = "Spine_bg",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													spineModel = 
													{
														SpinePath = "effect/effects_ZNQ_fanka/effects_ZNQ_fanka",
														animationName = "effects_ZNQ_fanka_zi2",
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
														relativeToName = "Panel",
													},
													ZOrder = "1",
												},
												{
													controlID = "Panel_front_Panel_card_2_Panel_card_Image_content_Panel_root_Panel-welfareView_Layer1_oneYear_Game",
													UUID = "6cb6a675_07d3_4692_8d4a_bb3aeee9c28c",
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
													height = "312",
													ignoreSize = "False",
													name = "Panel_front",
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
													width = "218",
													ZOrder = "1",
													components = 
													{
														
														{
															controlID = "Image_quality_bg1_Panel_front_Panel_card_2_Panel_card_Image_content_Panel_root_Panel-welfareView_Layer1_oneYear_Game",
															UUID = "a850127b_0865_4c13_98de_6cfb79cbe3ec",
															anchorPoint = "False",
															anchorPointX = "0.5",
															anchorPointY = "0.5",
															backGroundScale9Enable = "False",
															classname = "MEImage",
															dstBlendFunc = "771",
															height = "312",
															ignoreSize = "True",
															name = "Image_quality_bg1",
															sizepercentx = "0",
															sizepercenty = "0",
															sizeType = "0",
															srcBlendFunc = "1",
															texturePath = "ui/activity/oneYear/card/005.png",
															touchAble = "False",
															UILayoutViewModel = 
															{
																
															},
															width = "218",
															ZOrder = "1",
															components = 
															{
																
																{
																	controlID = "Image_item_bg_Image_quality_bg1_Panel_front_Panel_card_2_Panel_card_Image_content_Panel_root_Panel-welfareView_Layer1_oneYear_Game",
																	UUID = "6e14e98e_02fd_414a_a24f_dbad13b9505b",
																	anchorPoint = "False",
																	anchorPointX = "0.5",
																	anchorPointY = "0.5",
																	backGroundScale9Enable = "False",
																	classname = "MEImage",
																	dstBlendFunc = "771",
																	height = "121",
																	ignoreSize = "True",
																	name = "Image_item_bg",
																	opacity = "127",
																	sizepercentx = "0",
																	sizepercenty = "0",
																	sizeType = "0",
																	srcBlendFunc = "1",
																	texturePath = "ui/activity/oneYear/card/008.png",
																	touchAble = "False",
																	UILayoutViewModel = 
																	{
																		
																	},
																	width = "136",
																	ZOrder = "1",
																},
															},
														},
														{
															controlID = "Image_quality_bg2_Panel_front_Panel_card_2_Panel_card_Image_content_Panel_root_Panel-welfareView_Layer1_oneYear_Game",
															UUID = "348afcd5_943a_42fc_a35d_055863f592b0",
															anchorPoint = "False",
															anchorPointX = "0.5",
															anchorPointY = "0.5",
															backGroundScale9Enable = "False",
															classname = "MEImage",
															dstBlendFunc = "771",
															height = "312",
															ignoreSize = "True",
															name = "Image_quality_bg2",
															sizepercentx = "0",
															sizepercenty = "0",
															sizeType = "0",
															srcBlendFunc = "1",
															texturePath = "ui/activity/oneYear/card/006.png",
															touchAble = "False",
															UILayoutViewModel = 
															{
																
															},
															width = "218",
															ZOrder = "1",
															components = 
															{
																
																{
																	controlID = "Image_item_bg_Image_quality_bg2_Panel_front_Panel_card_2_Panel_card_Image_content_Panel_root_Panel-welfareView_Layer1_oneYear_Game",
																	UUID = "55e0e36d_b910_42af_b1e2_a9ff0f2ad94d",
																	anchorPoint = "False",
																	anchorPointX = "0.5",
																	anchorPointY = "0.5",
																	backGroundScale9Enable = "False",
																	classname = "MEImage",
																	dstBlendFunc = "771",
																	height = "121",
																	ignoreSize = "True",
																	name = "Image_item_bg",
																	opacity = "127",
																	sizepercentx = "0",
																	sizepercenty = "0",
																	sizeType = "0",
																	srcBlendFunc = "1",
																	texturePath = "ui/activity/oneYear/card/009.png",
																	touchAble = "False",
																	UILayoutViewModel = 
																	{
																		
																	},
																	width = "136",
																	ZOrder = "1",
																},
															},
														},
														{
															controlID = "Image_quality_bg3_Panel_front_Panel_card_2_Panel_card_Image_content_Panel_root_Panel-welfareView_Layer1_oneYear_Game",
															UUID = "6e79e9c4_a7db_48a6_aa7d_a4f0f43d8586",
															anchorPoint = "False",
															anchorPointX = "0.5",
															anchorPointY = "0.5",
															backGroundScale9Enable = "False",
															classname = "MEImage",
															dstBlendFunc = "771",
															height = "312",
															ignoreSize = "True",
															name = "Image_quality_bg3",
															sizepercentx = "0",
															sizepercenty = "0",
															sizeType = "0",
															srcBlendFunc = "1",
															texturePath = "ui/activity/oneYear/card/007.png",
															touchAble = "False",
															UILayoutViewModel = 
															{
																
															},
															width = "218",
															ZOrder = "1",
															components = 
															{
																
																{
																	controlID = "Image_item_bg_Image_quality_bg3_Panel_front_Panel_card_2_Panel_card_Image_content_Panel_root_Panel-welfareView_Layer1_oneYear_Game",
																	UUID = "1142284d_c0d7_4c75_bbed_1c99f89c62fe",
																	anchorPoint = "False",
																	anchorPointX = "0.5",
																	anchorPointY = "0.5",
																	backGroundScale9Enable = "False",
																	classname = "MEImage",
																	dstBlendFunc = "771",
																	height = "121",
																	ignoreSize = "True",
																	name = "Image_item_bg",
																	opacity = "127",
																	sizepercentx = "0",
																	sizepercenty = "0",
																	sizeType = "0",
																	srcBlendFunc = "1",
																	texturePath = "ui/activity/oneYear/card/010.png",
																	touchAble = "False",
																	UILayoutViewModel = 
																	{
																		
																	},
																	width = "136",
																	ZOrder = "1",
																},
															},
														},
														{
															controlID = "Image_item_Panel_front_Panel_card_2_Panel_card_Image_content_Panel_root_Panel-welfareView_Layer1_oneYear_Game",
															UUID = "208e0893_4b81_467c_b800_fd54be46e622",
															anchorPoint = "False",
															anchorPointX = "0.5",
															anchorPointY = "0.5",
															backGroundScale9Enable = "False",
															classname = "MEImage",
															dstBlendFunc = "771",
															height = "64",
															ignoreSize = "True",
															name = "Image_item",
															sizepercentx = "0",
															sizepercenty = "0",
															sizeType = "0",
															srcBlendFunc = "1",
															touchAble = "False",
															UILayoutViewModel = 
															{
																
															},
															width = "64",
															ZOrder = "1",
															components = 
															{
																
																{
																	controlID = "Label_name_Image_item_Panel_front_Panel_card_2_Panel_card_Image_content_Panel_root_Panel-welfareView_Layer1_oneYear_Game",
																	UUID = "01107b27_f163_4a6d_95cf_9d6e0eb1c159",
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
																	name = "Label_name",
																	nTextAlign = "1",
																	nTextHAlign = "1",
																	sizepercentx = "0",
																	sizepercenty = "0",
																	sizeType = "0",
																	srcBlendFunc = "770",
																	text = "Nom de l'objet",
																	touchAble = "False",
																	touchScaleEnable = "False",
																	UILayoutViewModel = 
																	{
																		PositionY = -82,
																	},
																	width = "83",
																	ZOrder = "1",
																},
																{
																	controlID = "Label_num_Image_item_Panel_front_Panel_card_2_Panel_card_Image_content_Panel_root_Panel-welfareView_Layer1_oneYear_Game",
																	UUID = "a9fa6724_de95_4ba4_9d0f_f4d3e071122f",
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
																	name = "Label_num",
																	nTextAlign = "1",
																	nTextHAlign = "1",
																	sizepercentx = "0",
																	sizepercenty = "0",
																	sizeType = "0",
																	srcBlendFunc = "770",
																	text = "x2",
																	touchAble = "False",
																	touchScaleEnable = "False",
																	UILayoutViewModel = 
																	{
																		PositionY = -108,
																	},
																	width = "35",
																	ZOrder = "1",
																},
															},
														},
													},
												},
												{
													controlID = "Spine_front_Panel_card_2_Panel_card_Image_content_Panel_root_Panel-welfareView_Layer1_oneYear_Game",
													UUID = "f0ce9833_3014_40e6_aa86_b4c94cb837af",
													classname = "MESpine",
													dstBlendFunc = "771",
													name = "Spine_front",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													spineModel = 
													{
														SpinePath = "effect/effects_ZNQ_fanka/effects_ZNQ_fanka",
														animationName = "effects_ZNQ_fanka_zi",
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
														relativeToName = "Panel",
													},
													ZOrder = "1",
												},
												{
													controlID = "Image_back_card_Panel_card_2_Panel_card_Image_content_Panel_root_Panel-welfareView_Layer1_oneYear_Game",
													UUID = "36364392_6b37_48db_a666_fb574eedd70c",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0.5",
													backGroundScale9Enable = "False",
													classname = "MEImage",
													dstBlendFunc = "771",
													height = "312",
													ignoreSize = "True",
													name = "Image_back_card",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "1",
													texturePath = "ui/activity/oneYear/card/002.png",
													touchAble = "False",
													UILayoutViewModel = 
													{
														
													},
													width = "218",
													ZOrder = "1",
												},
											},
										},
										{
											controlID = "Panel_card_3_Panel_card_Image_content_Panel_root_Panel-welfareView_Layer1_oneYear_Game",
											UUID = "195b8f2d_ba1d_42dd_af60_b5a3945e028f",
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
											height = "312",
											ignoreSize = "False",
											name = "Panel_card_3",
											rotation = "1",
											scaleX = "0.92",
											scaleY = "0.92",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "True",
											UILayoutViewModel = 
											{
												PositionX = -54,
												PositionY = 25,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "218",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "Spine_bg_Panel_card_3_Panel_card_Image_content_Panel_root_Panel-welfareView_Layer1_oneYear_Game",
													UUID = "d1e6fa42_473c_4eee_a458_148ef7a063fd",
													classname = "MESpine",
													dstBlendFunc = "771",
													name = "Spine_bg",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													spineModel = 
													{
														SpinePath = "effect/effects_ZNQ_fanka/effects_ZNQ_fanka",
														animationName = "effects_ZNQ_fanka_zi2",
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
														relativeToName = "Panel",
													},
													ZOrder = "1",
												},
												{
													controlID = "Panel_front_Panel_card_3_Panel_card_Image_content_Panel_root_Panel-welfareView_Layer1_oneYear_Game",
													UUID = "76cb082d_14a0_46b3_b67c_07a028510c3a",
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
													height = "312",
													ignoreSize = "False",
													name = "Panel_front",
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
													width = "218",
													ZOrder = "1",
													components = 
													{
														
														{
															controlID = "Image_quality_bg1_Panel_front_Panel_card_3_Panel_card_Image_content_Panel_root_Panel-welfareView_Layer1_oneYear_Game",
															UUID = "8b6b2d61_b036_45b7_baa0_aa0350897842",
															anchorPoint = "False",
															anchorPointX = "0.5",
															anchorPointY = "0.5",
															backGroundScale9Enable = "False",
															classname = "MEImage",
															dstBlendFunc = "771",
															height = "312",
															ignoreSize = "True",
															name = "Image_quality_bg1",
															sizepercentx = "0",
															sizepercenty = "0",
															sizeType = "0",
															srcBlendFunc = "1",
															texturePath = "ui/activity/oneYear/card/005.png",
															touchAble = "False",
															UILayoutViewModel = 
															{
																
															},
															width = "218",
															ZOrder = "1",
															components = 
															{
																
																{
																	controlID = "Image_item_bg_Image_quality_bg1_Panel_front_Panel_card_3_Panel_card_Image_content_Panel_root_Panel-welfareView_Layer1_oneYear_Game",
																	UUID = "13996aa3_5e83_449e_aeaf_bc60e3059253",
																	anchorPoint = "False",
																	anchorPointX = "0.5",
																	anchorPointY = "0.5",
																	backGroundScale9Enable = "False",
																	classname = "MEImage",
																	dstBlendFunc = "771",
																	height = "121",
																	ignoreSize = "True",
																	name = "Image_item_bg",
																	opacity = "127",
																	sizepercentx = "0",
																	sizepercenty = "0",
																	sizeType = "0",
																	srcBlendFunc = "1",
																	texturePath = "ui/activity/oneYear/card/008.png",
																	touchAble = "False",
																	UILayoutViewModel = 
																	{
																		
																	},
																	width = "136",
																	ZOrder = "1",
																},
															},
														},
														{
															controlID = "Image_quality_bg2_Panel_front_Panel_card_3_Panel_card_Image_content_Panel_root_Panel-welfareView_Layer1_oneYear_Game",
															UUID = "121fc326_1390_4181_a80e_35842f7930ef",
															anchorPoint = "False",
															anchorPointX = "0.5",
															anchorPointY = "0.5",
															backGroundScale9Enable = "False",
															classname = "MEImage",
															dstBlendFunc = "771",
															height = "312",
															ignoreSize = "True",
															name = "Image_quality_bg2",
															sizepercentx = "0",
															sizepercenty = "0",
															sizeType = "0",
															srcBlendFunc = "1",
															texturePath = "ui/activity/oneYear/card/006.png",
															touchAble = "False",
															UILayoutViewModel = 
															{
																
															},
															width = "218",
															ZOrder = "1",
															components = 
															{
																
																{
																	controlID = "Image_item_bg_Image_quality_bg2_Panel_front_Panel_card_3_Panel_card_Image_content_Panel_root_Panel-welfareView_Layer1_oneYear_Game",
																	UUID = "25437cf3_6c16_428d_91f8_306fd70372f0",
																	anchorPoint = "False",
																	anchorPointX = "0.5",
																	anchorPointY = "0.5",
																	backGroundScale9Enable = "False",
																	classname = "MEImage",
																	dstBlendFunc = "771",
																	height = "121",
																	ignoreSize = "True",
																	name = "Image_item_bg",
																	opacity = "127",
																	sizepercentx = "0",
																	sizepercenty = "0",
																	sizeType = "0",
																	srcBlendFunc = "1",
																	texturePath = "ui/activity/oneYear/card/009.png",
																	touchAble = "False",
																	UILayoutViewModel = 
																	{
																		
																	},
																	width = "136",
																	ZOrder = "1",
																},
															},
														},
														{
															controlID = "Image_quality_bg3_Panel_front_Panel_card_3_Panel_card_Image_content_Panel_root_Panel-welfareView_Layer1_oneYear_Game",
															UUID = "8f205b71_8cb9_4a1d_9596_0e38c4bb7fc3",
															anchorPoint = "False",
															anchorPointX = "0.5",
															anchorPointY = "0.5",
															backGroundScale9Enable = "False",
															classname = "MEImage",
															dstBlendFunc = "771",
															height = "312",
															ignoreSize = "True",
															name = "Image_quality_bg3",
															sizepercentx = "0",
															sizepercenty = "0",
															sizeType = "0",
															srcBlendFunc = "1",
															texturePath = "ui/activity/oneYear/card/007.png",
															touchAble = "False",
															UILayoutViewModel = 
															{
																
															},
															width = "218",
															ZOrder = "1",
															components = 
															{
																
																{
																	controlID = "Image_item_bg_Image_quality_bg3_Panel_front_Panel_card_3_Panel_card_Image_content_Panel_root_Panel-welfareView_Layer1_oneYear_Game",
																	UUID = "1e53ea9d_96f7_47dd_a790_8345d42bdbcd",
																	anchorPoint = "False",
																	anchorPointX = "0.5",
																	anchorPointY = "0.5",
																	backGroundScale9Enable = "False",
																	classname = "MEImage",
																	dstBlendFunc = "771",
																	height = "121",
																	ignoreSize = "True",
																	name = "Image_item_bg",
																	opacity = "127",
																	sizepercentx = "0",
																	sizepercenty = "0",
																	sizeType = "0",
																	srcBlendFunc = "1",
																	texturePath = "ui/activity/oneYear/card/010.png",
																	touchAble = "False",
																	UILayoutViewModel = 
																	{
																		
																	},
																	width = "136",
																	ZOrder = "1",
																},
															},
														},
														{
															controlID = "Image_item_Panel_front_Panel_card_3_Panel_card_Image_content_Panel_root_Panel-welfareView_Layer1_oneYear_Game",
															UUID = "7171229f_6b0b_4ab3_a25f_0ad64dac6091",
															anchorPoint = "False",
															anchorPointX = "0.5",
															anchorPointY = "0.5",
															backGroundScale9Enable = "False",
															classname = "MEImage",
															dstBlendFunc = "771",
															height = "64",
															ignoreSize = "True",
															name = "Image_item",
															sizepercentx = "0",
															sizepercenty = "0",
															sizeType = "0",
															srcBlendFunc = "1",
															touchAble = "False",
															UILayoutViewModel = 
															{
																
															},
															width = "64",
															ZOrder = "1",
															components = 
															{
																
																{
																	controlID = "Label_name_Image_item_Panel_front_Panel_card_3_Panel_card_Image_content_Panel_root_Panel-welfareView_Layer1_oneYear_Game",
																	UUID = "47cd7bd8_61c9_4641_9b72_acc410c94fbc",
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
																	name = "Label_name",
																	nTextAlign = "1",
																	nTextHAlign = "1",
																	sizepercentx = "0",
																	sizepercenty = "0",
																	sizeType = "0",
																	srcBlendFunc = "770",
																	text = "Nom de l'objet",
																	touchAble = "False",
																	touchScaleEnable = "False",
																	UILayoutViewModel = 
																	{
																		PositionY = -82,
																	},
																	width = "83",
																	ZOrder = "1",
																},
																{
																	controlID = "Label_num_Image_item_Panel_front_Panel_card_3_Panel_card_Image_content_Panel_root_Panel-welfareView_Layer1_oneYear_Game",
																	UUID = "72eca937_521e_4d69_b47d_b992b226e52d",
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
																	name = "Label_num",
																	nTextAlign = "1",
																	nTextHAlign = "1",
																	sizepercentx = "0",
																	sizepercenty = "0",
																	sizeType = "0",
																	srcBlendFunc = "770",
																	text = "x2",
																	touchAble = "False",
																	touchScaleEnable = "False",
																	UILayoutViewModel = 
																	{
																		PositionY = -108,
																	},
																	width = "35",
																	ZOrder = "1",
																},
															},
														},
													},
												},
												{
													controlID = "Spine_front_Panel_card_3_Panel_card_Image_content_Panel_root_Panel-welfareView_Layer1_oneYear_Game",
													UUID = "1173a879_981e_4e96_a94e_3b357eb7f64f",
													classname = "MESpine",
													dstBlendFunc = "771",
													name = "Spine_front",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													spineModel = 
													{
														SpinePath = "effect/effects_ZNQ_fanka/effects_ZNQ_fanka",
														animationName = "effects_ZNQ_fanka_zi",
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
														relativeToName = "Panel",
													},
													ZOrder = "1",
												},
												{
													controlID = "Image_back_card_Panel_card_3_Panel_card_Image_content_Panel_root_Panel-welfareView_Layer1_oneYear_Game",
													UUID = "63ad12fb_adeb_458b_b881_fa42ccff3fdb",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0.5",
													backGroundScale9Enable = "False",
													classname = "MEImage",
													dstBlendFunc = "771",
													height = "312",
													ignoreSize = "True",
													name = "Image_back_card",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "1",
													texturePath = "ui/activity/oneYear/card/002.png",
													touchAble = "False",
													UILayoutViewModel = 
													{
														
													},
													width = "218",
													ZOrder = "1",
												},
											},
										},
										{
											controlID = "Panel_card_4_Panel_card_Image_content_Panel_root_Panel-welfareView_Layer1_oneYear_Game",
											UUID = "6b194f75_99e3_4d44_afe9_a2f08f284af6",
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
											height = "312",
											ignoreSize = "False",
											name = "Panel_card_4",
											rotation = "1",
											scaleX = "0.92",
											scaleY = "0.92",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "True",
											UILayoutViewModel = 
											{
												PositionX = 65,
												PositionY = 25,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "218",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "Spine_bg_Panel_card_4_Panel_card_Image_content_Panel_root_Panel-welfareView_Layer1_oneYear_Game",
													UUID = "f42296c6_bb99_4940_8a43_e793d9555031",
													classname = "MESpine",
													dstBlendFunc = "771",
													name = "Spine_bg",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													spineModel = 
													{
														SpinePath = "effect/effects_ZNQ_fanka/effects_ZNQ_fanka",
														animationName = "effects_ZNQ_fanka_zi2",
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
														relativeToName = "Panel",
													},
													ZOrder = "1",
												},
												{
													controlID = "Panel_front_Panel_card_4_Panel_card_Image_content_Panel_root_Panel-welfareView_Layer1_oneYear_Game",
													UUID = "349c6201_816f_4423_b4d7_e14ec22d4643",
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
													height = "312",
													ignoreSize = "False",
													name = "Panel_front",
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
													width = "218",
													ZOrder = "1",
													components = 
													{
														
														{
															controlID = "Image_quality_bg1_Panel_front_Panel_card_4_Panel_card_Image_content_Panel_root_Panel-welfareView_Layer1_oneYear_Game",
															UUID = "890309e8_2343_4030_a8f8_68dd3b2617dd",
															anchorPoint = "False",
															anchorPointX = "0.5",
															anchorPointY = "0.5",
															backGroundScale9Enable = "False",
															classname = "MEImage",
															dstBlendFunc = "771",
															height = "312",
															ignoreSize = "True",
															name = "Image_quality_bg1",
															sizepercentx = "0",
															sizepercenty = "0",
															sizeType = "0",
															srcBlendFunc = "1",
															texturePath = "ui/activity/oneYear/card/005.png",
															touchAble = "False",
															UILayoutViewModel = 
															{
																
															},
															width = "218",
															ZOrder = "1",
															components = 
															{
																
																{
																	controlID = "Image_item_bg_Image_quality_bg1_Panel_front_Panel_card_4_Panel_card_Image_content_Panel_root_Panel-welfareView_Layer1_oneYear_Game",
																	UUID = "b9e66c0b_86f4_4090_b5f8_144f9381ea21",
																	anchorPoint = "False",
																	anchorPointX = "0.5",
																	anchorPointY = "0.5",
																	backGroundScale9Enable = "False",
																	classname = "MEImage",
																	dstBlendFunc = "771",
																	height = "121",
																	ignoreSize = "True",
																	name = "Image_item_bg",
																	opacity = "127",
																	sizepercentx = "0",
																	sizepercenty = "0",
																	sizeType = "0",
																	srcBlendFunc = "1",
																	texturePath = "ui/activity/oneYear/card/008.png",
																	touchAble = "False",
																	UILayoutViewModel = 
																	{
																		
																	},
																	width = "136",
																	ZOrder = "1",
																},
															},
														},
														{
															controlID = "Image_quality_bg2_Panel_front_Panel_card_4_Panel_card_Image_content_Panel_root_Panel-welfareView_Layer1_oneYear_Game",
															UUID = "24beb5a7_a5b3_4b30_9a47_8b8512dd3b1f",
															anchorPoint = "False",
															anchorPointX = "0.5",
															anchorPointY = "0.5",
															backGroundScale9Enable = "False",
															classname = "MEImage",
															dstBlendFunc = "771",
															height = "312",
															ignoreSize = "True",
															name = "Image_quality_bg2",
															sizepercentx = "0",
															sizepercenty = "0",
															sizeType = "0",
															srcBlendFunc = "1",
															texturePath = "ui/activity/oneYear/card/006.png",
															touchAble = "False",
															UILayoutViewModel = 
															{
																
															},
															width = "218",
															ZOrder = "1",
															components = 
															{
																
																{
																	controlID = "Image_item_bg_Image_quality_bg2_Panel_front_Panel_card_4_Panel_card_Image_content_Panel_root_Panel-welfareView_Layer1_oneYear_Game",
																	UUID = "d9047314_35b9_4f87_808f_03749c73a663",
																	anchorPoint = "False",
																	anchorPointX = "0.5",
																	anchorPointY = "0.5",
																	backGroundScale9Enable = "False",
																	classname = "MEImage",
																	dstBlendFunc = "771",
																	height = "121",
																	ignoreSize = "True",
																	name = "Image_item_bg",
																	opacity = "127",
																	sizepercentx = "0",
																	sizepercenty = "0",
																	sizeType = "0",
																	srcBlendFunc = "1",
																	texturePath = "ui/activity/oneYear/card/009.png",
																	touchAble = "False",
																	UILayoutViewModel = 
																	{
																		
																	},
																	width = "136",
																	ZOrder = "1",
																},
															},
														},
														{
															controlID = "Image_quality_bg3_Panel_front_Panel_card_4_Panel_card_Image_content_Panel_root_Panel-welfareView_Layer1_oneYear_Game",
															UUID = "b4adcdab_5363_4617_8b39_de694687bd17",
															anchorPoint = "False",
															anchorPointX = "0.5",
															anchorPointY = "0.5",
															backGroundScale9Enable = "False",
															classname = "MEImage",
															dstBlendFunc = "771",
															height = "312",
															ignoreSize = "True",
															name = "Image_quality_bg3",
															sizepercentx = "0",
															sizepercenty = "0",
															sizeType = "0",
															srcBlendFunc = "1",
															texturePath = "ui/activity/oneYear/card/007.png",
															touchAble = "False",
															UILayoutViewModel = 
															{
																
															},
															width = "218",
															ZOrder = "1",
															components = 
															{
																
																{
																	controlID = "Image_item_bg_Image_quality_bg3_Panel_front_Panel_card_4_Panel_card_Image_content_Panel_root_Panel-welfareView_Layer1_oneYear_Game",
																	UUID = "28a2a1fb_e74e_407d_bdd5_bf219a3503d2",
																	anchorPoint = "False",
																	anchorPointX = "0.5",
																	anchorPointY = "0.5",
																	backGroundScale9Enable = "False",
																	classname = "MEImage",
																	dstBlendFunc = "771",
																	height = "121",
																	ignoreSize = "True",
																	name = "Image_item_bg",
																	opacity = "127",
																	sizepercentx = "0",
																	sizepercenty = "0",
																	sizeType = "0",
																	srcBlendFunc = "1",
																	texturePath = "ui/activity/oneYear/card/010.png",
																	touchAble = "False",
																	UILayoutViewModel = 
																	{
																		
																	},
																	width = "136",
																	ZOrder = "1",
																},
															},
														},
														{
															controlID = "Image_item_Panel_front_Panel_card_4_Panel_card_Image_content_Panel_root_Panel-welfareView_Layer1_oneYear_Game",
															UUID = "c44ac6de_6f14_42c4_98cf_fed8506d3d8c",
															anchorPoint = "False",
															anchorPointX = "0.5",
															anchorPointY = "0.5",
															backGroundScale9Enable = "False",
															classname = "MEImage",
															dstBlendFunc = "771",
															height = "64",
															ignoreSize = "True",
															name = "Image_item",
															sizepercentx = "0",
															sizepercenty = "0",
															sizeType = "0",
															srcBlendFunc = "1",
															touchAble = "False",
															UILayoutViewModel = 
															{
																
															},
															width = "64",
															ZOrder = "1",
															components = 
															{
																
																{
																	controlID = "Label_num_Image_item_Panel_front_Panel_card_4_Panel_card_Image_content_Panel_root_Panel-welfareView_Layer1_oneYear_Game",
																	UUID = "504c59c2_dea4_4cdc_9c8c_4654ac9e0dd3",
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
																	name = "Label_num",
																	nTextAlign = "1",
																	nTextHAlign = "1",
																	sizepercentx = "0",
																	sizepercenty = "0",
																	sizeType = "0",
																	srcBlendFunc = "770",
																	text = "x2",
																	touchAble = "False",
																	touchScaleEnable = "False",
																	UILayoutViewModel = 
																	{
																		PositionY = -108,
																	},
																	width = "35",
																	ZOrder = "1",
																},
																{
																	controlID = "Label_name_Image_item_Panel_front_Panel_card_4_Panel_card_Image_content_Panel_root_Panel-welfareView_Layer1_oneYear_Game",
																	UUID = "073750b3_f16c_4730_9514_1dc95149441c",
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
																	name = "Label_name",
																	nTextAlign = "1",
																	nTextHAlign = "1",
																	sizepercentx = "0",
																	sizepercenty = "0",
																	sizeType = "0",
																	srcBlendFunc = "770",
																	text = "Nom de l'objet",
																	touchAble = "False",
																	touchScaleEnable = "False",
																	UILayoutViewModel = 
																	{
																		PositionY = -82,
																	},
																	width = "83",
																	ZOrder = "1",
																},
															},
														},
													},
												},
												{
													controlID = "Spine_front_Panel_card_4_Panel_card_Image_content_Panel_root_Panel-welfareView_Layer1_oneYear_Game",
													UUID = "29ade507_477c_4cd1_bdea_84261238c4f3",
													classname = "MESpine",
													dstBlendFunc = "771",
													name = "Spine_front",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													spineModel = 
													{
														SpinePath = "effect/effects_ZNQ_fanka/effects_ZNQ_fanka",
														animationName = "effects_ZNQ_fanka_zi",
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
														relativeToName = "Panel",
													},
													ZOrder = "1",
												},
												{
													controlID = "Image_back_card_Panel_card_4_Panel_card_Image_content_Panel_root_Panel-welfareView_Layer1_oneYear_Game",
													UUID = "c6fbc331_a67d_442c_83a1_13acc1ec6c92",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0.5",
													backGroundScale9Enable = "False",
													classname = "MEImage",
													dstBlendFunc = "771",
													height = "312",
													ignoreSize = "True",
													name = "Image_back_card",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "1",
													texturePath = "ui/activity/oneYear/card/002.png",
													touchAble = "False",
													UILayoutViewModel = 
													{
														
													},
													width = "218",
													ZOrder = "1",
												},
											},
										},
										{
											controlID = "Panel_card_5_Panel_card_Image_content_Panel_root_Panel-welfareView_Layer1_oneYear_Game",
											UUID = "84e69139_61b2_4cc6_b4fa_5029d595752c",
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
											height = "312",
											ignoreSize = "False",
											name = "Panel_card_5",
											rotation = "1",
											scaleX = "0.92",
											scaleY = "0.92",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "True",
											UILayoutViewModel = 
											{
												PositionX = 185,
												PositionY = 25,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "218",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "Spine_bg_Panel_card_5_Panel_card_Image_content_Panel_root_Panel-welfareView_Layer1_oneYear_Game",
													UUID = "4cf83f6e_9caf_4a2a_9007_3e499b9b6b97",
													classname = "MESpine",
													dstBlendFunc = "771",
													name = "Spine_bg",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													spineModel = 
													{
														SpinePath = "effect/effects_ZNQ_fanka/effects_ZNQ_fanka",
														animationName = "effects_ZNQ_fanka_cheng",
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
														relativeToName = "Panel",
													},
													ZOrder = "1",
												},
												{
													controlID = "Panel_front_Panel_card_5_Panel_card_Image_content_Panel_root_Panel-welfareView_Layer1_oneYear_Game",
													UUID = "88f5b61e_78bf_4768_a84c_cbca8e6ec492",
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
													height = "312",
													ignoreSize = "False",
													name = "Panel_front",
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
													width = "218",
													ZOrder = "1",
													components = 
													{
														
														{
															controlID = "Image_quality_bg1_Panel_front_Panel_card_5_Panel_card_Image_content_Panel_root_Panel-welfareView_Layer1_oneYear_Game",
															UUID = "85fa1f43_0fe7_4855_91e7_162c86e657ec",
															anchorPoint = "False",
															anchorPointX = "0.5",
															anchorPointY = "0.5",
															backGroundScale9Enable = "False",
															classname = "MEImage",
															dstBlendFunc = "771",
															height = "312",
															ignoreSize = "True",
															name = "Image_quality_bg1",
															sizepercentx = "0",
															sizepercenty = "0",
															sizeType = "0",
															srcBlendFunc = "1",
															texturePath = "ui/activity/oneYear/card/005.png",
															touchAble = "False",
															UILayoutViewModel = 
															{
																
															},
															width = "218",
															ZOrder = "1",
															components = 
															{
																
																{
																	controlID = "Image_item_bg_Image_quality_bg1_Panel_front_Panel_card_5_Panel_card_Image_content_Panel_root_Panel-welfareView_Layer1_oneYear_Game",
																	UUID = "d83856a4_fd04_40c0_989a_1675f6d75436",
																	anchorPoint = "False",
																	anchorPointX = "0.5",
																	anchorPointY = "0.5",
																	backGroundScale9Enable = "False",
																	classname = "MEImage",
																	dstBlendFunc = "771",
																	height = "121",
																	ignoreSize = "True",
																	name = "Image_item_bg",
																	opacity = "127",
																	sizepercentx = "0",
																	sizepercenty = "0",
																	sizeType = "0",
																	srcBlendFunc = "1",
																	texturePath = "ui/activity/oneYear/card/008.png",
																	touchAble = "False",
																	UILayoutViewModel = 
																	{
																		
																	},
																	width = "136",
																	ZOrder = "1",
																},
															},
														},
														{
															controlID = "Image_quality_bg2_Panel_front_Panel_card_5_Panel_card_Image_content_Panel_root_Panel-welfareView_Layer1_oneYear_Game",
															UUID = "f393e0d0_1a2b_4293_86d8_60ca673b1787",
															anchorPoint = "False",
															anchorPointX = "0.5",
															anchorPointY = "0.5",
															backGroundScale9Enable = "False",
															classname = "MEImage",
															dstBlendFunc = "771",
															height = "312",
															ignoreSize = "True",
															name = "Image_quality_bg2",
															sizepercentx = "0",
															sizepercenty = "0",
															sizeType = "0",
															srcBlendFunc = "1",
															texturePath = "ui/activity/oneYear/card/006.png",
															touchAble = "False",
															UILayoutViewModel = 
															{
																
															},
															width = "218",
															ZOrder = "1",
															components = 
															{
																
																{
																	controlID = "Image_item_bg_Image_quality_bg2_Panel_front_Panel_card_5_Panel_card_Image_content_Panel_root_Panel-welfareView_Layer1_oneYear_Game",
																	UUID = "94284b55_3b24_428a_b47b_cf6cfce81b53",
																	anchorPoint = "False",
																	anchorPointX = "0.5",
																	anchorPointY = "0.5",
																	backGroundScale9Enable = "False",
																	classname = "MEImage",
																	dstBlendFunc = "771",
																	height = "121",
																	ignoreSize = "True",
																	name = "Image_item_bg",
																	opacity = "127",
																	sizepercentx = "0",
																	sizepercenty = "0",
																	sizeType = "0",
																	srcBlendFunc = "1",
																	texturePath = "ui/activity/oneYear/card/009.png",
																	touchAble = "False",
																	UILayoutViewModel = 
																	{
																		
																	},
																	width = "136",
																	ZOrder = "1",
																},
															},
														},
														{
															controlID = "Image_quality_bg3_Panel_front_Panel_card_5_Panel_card_Image_content_Panel_root_Panel-welfareView_Layer1_oneYear_Game",
															UUID = "d4c70117_5cf2_4d08_a8d2_e444dc2a11aa",
															anchorPoint = "False",
															anchorPointX = "0.5",
															anchorPointY = "0.5",
															backGroundScale9Enable = "False",
															classname = "MEImage",
															dstBlendFunc = "771",
															height = "312",
															ignoreSize = "True",
															name = "Image_quality_bg3",
															sizepercentx = "0",
															sizepercenty = "0",
															sizeType = "0",
															srcBlendFunc = "1",
															texturePath = "ui/activity/oneYear/card/007.png",
															touchAble = "False",
															UILayoutViewModel = 
															{
																
															},
															width = "218",
															ZOrder = "1",
															components = 
															{
																
																{
																	controlID = "Image_item_bg_Image_quality_bg3_Panel_front_Panel_card_5_Panel_card_Image_content_Panel_root_Panel-welfareView_Layer1_oneYear_Game",
																	UUID = "b4a81118_201e_4b91_a3f9_77575874dd7d",
																	anchorPoint = "False",
																	anchorPointX = "0.5",
																	anchorPointY = "0.5",
																	backGroundScale9Enable = "False",
																	classname = "MEImage",
																	dstBlendFunc = "771",
																	height = "121",
																	ignoreSize = "True",
																	name = "Image_item_bg",
																	opacity = "127",
																	sizepercentx = "0",
																	sizepercenty = "0",
																	sizeType = "0",
																	srcBlendFunc = "1",
																	texturePath = "ui/activity/oneYear/card/010.png",
																	touchAble = "False",
																	UILayoutViewModel = 
																	{
																		
																	},
																	width = "136",
																	ZOrder = "1",
																},
															},
														},
														{
															controlID = "Image_item_Panel_front_Panel_card_5_Panel_card_Image_content_Panel_root_Panel-welfareView_Layer1_oneYear_Game",
															UUID = "a2b13a43_6601_443d_a68c_68dffce74f3d",
															anchorPoint = "False",
															anchorPointX = "0.5",
															anchorPointY = "0.5",
															backGroundScale9Enable = "False",
															classname = "MEImage",
															dstBlendFunc = "771",
															height = "64",
															ignoreSize = "True",
															name = "Image_item",
															sizepercentx = "0",
															sizepercenty = "0",
															sizeType = "0",
															srcBlendFunc = "1",
															touchAble = "False",
															UILayoutViewModel = 
															{
																
															},
															width = "64",
															ZOrder = "1",
															components = 
															{
																
																{
																	controlID = "Label_name_Image_item_Panel_front_Panel_card_5_Panel_card_Image_content_Panel_root_Panel-welfareView_Layer1_oneYear_Game",
																	UUID = "e777c55e_b8c8_48f6_8ac2_94a2b10e08b0",
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
																	name = "Label_name",
																	nTextAlign = "1",
																	nTextHAlign = "1",
																	sizepercentx = "0",
																	sizepercenty = "0",
																	sizeType = "0",
																	srcBlendFunc = "770",
																	text = "Nom de l'objet",
																	touchAble = "False",
																	touchScaleEnable = "False",
																	UILayoutViewModel = 
																	{
																		PositionY = -82,
																	},
																	width = "83",
																	ZOrder = "1",
																},
																{
																	controlID = "Label_num_Image_item_Panel_front_Panel_card_5_Panel_card_Image_content_Panel_root_Panel-welfareView_Layer1_oneYear_Game",
																	UUID = "ba749c5e_c5b1_436b_9a75_fcd5a3501384",
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
																	name = "Label_num",
																	nTextAlign = "1",
																	nTextHAlign = "1",
																	sizepercentx = "0",
																	sizepercenty = "0",
																	sizeType = "0",
																	srcBlendFunc = "770",
																	text = "x2",
																	touchAble = "False",
																	touchScaleEnable = "False",
																	UILayoutViewModel = 
																	{
																		PositionY = -108,
																	},
																	width = "35",
																	ZOrder = "1",
																},
															},
														},
													},
												},
												{
													controlID = "Spine_front_Panel_card_5_Panel_card_Image_content_Panel_root_Panel-welfareView_Layer1_oneYear_Game",
													UUID = "7dea276e_af15_4b64_a576_87b60d5ad120",
													classname = "MESpine",
													dstBlendFunc = "771",
													name = "Spine_front",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													spineModel = 
													{
														SpinePath = "effect/effects_ZNQ_fanka/effects_ZNQ_fanka",
														animationName = "effects_ZNQ_fanka_zi2",
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
														relativeToName = "Panel",
													},
													ZOrder = "1",
												},
												{
													controlID = "Image_back_card_Panel_card_5_Panel_card_Image_content_Panel_root_Panel-welfareView_Layer1_oneYear_Game",
													UUID = "09681f22_7acd_4e92_9b8d_37b769c92072",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0.5",
													backGroundScale9Enable = "False",
													classname = "MEImage",
													dstBlendFunc = "771",
													height = "312",
													ignoreSize = "True",
													name = "Image_back_card",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "1",
													texturePath = "ui/activity/oneYear/card/002.png",
													touchAble = "False",
													UILayoutViewModel = 
													{
														
													},
													width = "218",
													ZOrder = "1",
												},
											},
										},
										{
											controlID = "Panel_card_6_Panel_card_Image_content_Panel_root_Panel-welfareView_Layer1_oneYear_Game",
											UUID = "66cfe855_d3f8_4e28_ba7a_6b57799896e0",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											bgColorOpacity = "50",
											bIsOpenClipping = "False",
											classname = "MEPanel",
											colorType = "0;SingleColor:#FF000000;GraduallyChangingColorStart:#FFFFFFFF;GraduallyChangingColorEnd:#FFFFFFFF;vectorX:0;vectorY:0",
											DesignHeight = "640",
											DesignType = "0",
											DesignWidth = "960",
											dstBlendFunc = "771",
											height = "312",
											ignoreSize = "False",
											name = "Panel_card_6",
											rotation = "1",
											scaleX = "0.92",
											scaleY = "0.92",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "True",
											UILayoutViewModel = 
											{
												PositionX = 305,
												PositionY = 25,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "218",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "Spine_bg_Panel_card_6_Panel_card_Image_content_Panel_root_Panel-welfareView_Layer1_oneYear_Game",
													UUID = "5105d3a3_b5b2_4979_9b3e_2f9f12d0e858",
													classname = "MESpine",
													dstBlendFunc = "771",
													name = "Spine_bg",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													spineModel = 
													{
														SpinePath = "effect/effects_ZNQ_fanka/effects_ZNQ_fanka",
														animationName = "effects_ZNQ_fanka_zi2",
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
														relativeToName = "Panel",
													},
													ZOrder = "1",
												},
												{
													controlID = "Panel_front_Panel_card_6_Panel_card_Image_content_Panel_root_Panel-welfareView_Layer1_oneYear_Game",
													UUID = "8ea9274b_36ba_4066_8c9f_333c94bb6cfc",
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
													height = "312",
													ignoreSize = "False",
													name = "Panel_front",
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
													width = "218",
													ZOrder = "1",
													components = 
													{
														
														{
															controlID = "Image_quality_bg1_Panel_front_Panel_card_6_Panel_card_Image_content_Panel_root_Panel-welfareView_Layer1_oneYear_Game",
															UUID = "1eed330f_260b_4e3c_a93c_ee97ae2d63ef",
															anchorPoint = "False",
															anchorPointX = "0.5",
															anchorPointY = "0.5",
															backGroundScale9Enable = "False",
															classname = "MEImage",
															dstBlendFunc = "771",
															height = "312",
															ignoreSize = "True",
															name = "Image_quality_bg1",
															sizepercentx = "0",
															sizepercenty = "0",
															sizeType = "0",
															srcBlendFunc = "1",
															texturePath = "ui/activity/oneYear/card/005.png",
															touchAble = "False",
															UILayoutViewModel = 
															{
																
															},
															width = "218",
															ZOrder = "1",
															components = 
															{
																
																{
																	controlID = "Image_item_bg_Image_quality_bg1_Panel_front_Panel_card_6_Panel_card_Image_content_Panel_root_Panel-welfareView_Layer1_oneYear_Game",
																	UUID = "3bc98931_003a_41bb_8cb2_94fdfa98d961",
																	anchorPoint = "False",
																	anchorPointX = "0.5",
																	anchorPointY = "0.5",
																	backGroundScale9Enable = "False",
																	classname = "MEImage",
																	dstBlendFunc = "771",
																	height = "121",
																	ignoreSize = "True",
																	name = "Image_item_bg",
																	opacity = "127",
																	sizepercentx = "0",
																	sizepercenty = "0",
																	sizeType = "0",
																	srcBlendFunc = "1",
																	texturePath = "ui/activity/oneYear/card/008.png",
																	touchAble = "False",
																	UILayoutViewModel = 
																	{
																		
																	},
																	width = "136",
																	ZOrder = "1",
																},
															},
														},
														{
															controlID = "Image_quality_bg2_Panel_front_Panel_card_6_Panel_card_Image_content_Panel_root_Panel-welfareView_Layer1_oneYear_Game",
															UUID = "2e96de45_ba5b_4189_81e3_adccc9192379",
															anchorPoint = "False",
															anchorPointX = "0.5",
															anchorPointY = "0.5",
															backGroundScale9Enable = "False",
															classname = "MEImage",
															dstBlendFunc = "771",
															height = "312",
															ignoreSize = "True",
															name = "Image_quality_bg2",
															sizepercentx = "0",
															sizepercenty = "0",
															sizeType = "0",
															srcBlendFunc = "1",
															texturePath = "ui/activity/oneYear/card/006.png",
															touchAble = "False",
															UILayoutViewModel = 
															{
																
															},
															width = "218",
															ZOrder = "1",
															components = 
															{
																
																{
																	controlID = "Image_item_bg_Image_quality_bg2_Panel_front_Panel_card_6_Panel_card_Image_content_Panel_root_Panel-welfareView_Layer1_oneYear_Game",
																	UUID = "bb61e6fe_1af5_4b44_bbcb_3ad8a2609ec3",
																	anchorPoint = "False",
																	anchorPointX = "0.5",
																	anchorPointY = "0.5",
																	backGroundScale9Enable = "False",
																	classname = "MEImage",
																	dstBlendFunc = "771",
																	height = "121",
																	ignoreSize = "True",
																	name = "Image_item_bg",
																	opacity = "127",
																	sizepercentx = "0",
																	sizepercenty = "0",
																	sizeType = "0",
																	srcBlendFunc = "1",
																	texturePath = "ui/activity/oneYear/card/009.png",
																	touchAble = "False",
																	UILayoutViewModel = 
																	{
																		
																	},
																	width = "136",
																	ZOrder = "1",
																},
															},
														},
														{
															controlID = "Image_quality_bg3_Panel_front_Panel_card_6_Panel_card_Image_content_Panel_root_Panel-welfareView_Layer1_oneYear_Game",
															UUID = "eadb534c_a0ca_4937_a7c5_b758f7f678b8",
															anchorPoint = "False",
															anchorPointX = "0.5",
															anchorPointY = "0.5",
															backGroundScale9Enable = "False",
															classname = "MEImage",
															dstBlendFunc = "771",
															height = "312",
															ignoreSize = "True",
															name = "Image_quality_bg3",
															sizepercentx = "0",
															sizepercenty = "0",
															sizeType = "0",
															srcBlendFunc = "1",
															texturePath = "ui/activity/oneYear/card/007.png",
															touchAble = "False",
															UILayoutViewModel = 
															{
																
															},
															width = "218",
															ZOrder = "1",
															components = 
															{
																
																{
																	controlID = "Image_item_bg_Image_quality_bg3_Panel_front_Panel_card_6_Panel_card_Image_content_Panel_root_Panel-welfareView_Layer1_oneYear_Game",
																	UUID = "3140d199_f114_4e28_86b2_2f472773f080",
																	anchorPoint = "False",
																	anchorPointX = "0.5",
																	anchorPointY = "0.5",
																	backGroundScale9Enable = "False",
																	classname = "MEImage",
																	dstBlendFunc = "771",
																	height = "121",
																	ignoreSize = "True",
																	name = "Image_item_bg",
																	opacity = "127",
																	sizepercentx = "0",
																	sizepercenty = "0",
																	sizeType = "0",
																	srcBlendFunc = "1",
																	texturePath = "ui/activity/oneYear/card/010.png",
																	touchAble = "False",
																	UILayoutViewModel = 
																	{
																		
																	},
																	width = "136",
																	ZOrder = "1",
																},
															},
														},
														{
															controlID = "Image_item_Panel_front_Panel_card_6_Panel_card_Image_content_Panel_root_Panel-welfareView_Layer1_oneYear_Game",
															UUID = "755cce84_17a5_425e_85b0_41441e5652c3",
															anchorPoint = "False",
															anchorPointX = "0.5",
															anchorPointY = "0.5",
															backGroundScale9Enable = "False",
															classname = "MEImage",
															dstBlendFunc = "771",
															height = "64",
															ignoreSize = "True",
															name = "Image_item",
															sizepercentx = "0",
															sizepercenty = "0",
															sizeType = "0",
															srcBlendFunc = "1",
															touchAble = "False",
															UILayoutViewModel = 
															{
																
															},
															width = "64",
															ZOrder = "1",
															components = 
															{
																
																{
																	controlID = "Label_name_Image_item_Panel_front_Panel_card_6_Panel_card_Image_content_Panel_root_Panel-welfareView_Layer1_oneYear_Game",
																	UUID = "06842573_cc23_480b_8526_f6aa50789ea1",
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
																	name = "Label_name",
																	nTextAlign = "1",
																	nTextHAlign = "1",
																	sizepercentx = "0",
																	sizepercenty = "0",
																	sizeType = "0",
																	srcBlendFunc = "770",
																	text = "Nom de l'objet",
																	touchAble = "False",
																	touchScaleEnable = "False",
																	UILayoutViewModel = 
																	{
																		PositionY = -82,
																	},
																	width = "83",
																	ZOrder = "1",
																},
																{
																	controlID = "Label_num_Image_item_Panel_front_Panel_card_6_Panel_card_Image_content_Panel_root_Panel-welfareView_Layer1_oneYear_Game",
																	UUID = "16651996_8790_44f4_a82b_6a972c936cad",
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
																	name = "Label_num",
																	nTextAlign = "1",
																	nTextHAlign = "1",
																	sizepercentx = "0",
																	sizepercenty = "0",
																	sizeType = "0",
																	srcBlendFunc = "770",
																	text = "x2",
																	touchAble = "False",
																	touchScaleEnable = "False",
																	UILayoutViewModel = 
																	{
																		PositionY = -108,
																	},
																	width = "35",
																	ZOrder = "1",
																},
															},
														},
													},
												},
												{
													controlID = "Spine_front_Panel_card_6_Panel_card_Image_content_Panel_root_Panel-welfareView_Layer1_oneYear_Game",
													UUID = "de3eb5d5_d04f_45ec_8103_35ffa8f88381",
													classname = "MESpine",
													dstBlendFunc = "771",
													name = "Spine_front",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													spineModel = 
													{
														SpinePath = "effect/effects_ZNQ_fanka/effects_ZNQ_fanka",
														animationName = "effects_ZNQ_fanka_zi",
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
														relativeToName = "Panel",
													},
													ZOrder = "1",
												},
												{
													controlID = "Image_back_card_Panel_card_6_Panel_card_Image_content_Panel_root_Panel-welfareView_Layer1_oneYear_Game",
													UUID = "d3546ef1_9ab2_4842_8d0c_cc45a77a02d5",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0.5",
													backGroundScale9Enable = "False",
													classname = "MEImage",
													dstBlendFunc = "771",
													height = "312",
													ignoreSize = "True",
													name = "Image_back_card",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "1",
													texturePath = "ui/activity/oneYear/card/002.png",
													touchAble = "False",
													UILayoutViewModel = 
													{
														
													},
													width = "218",
													ZOrder = "1",
												},
											},
										},
									},
								},
								{
									controlID = "Spine_chupai_Image_content_Panel_root_Panel-welfareView_Layer1_oneYear_Game",
									UUID = "ae7466d6_5f4d_43c4_9a66_6d48fabd11ff",
									classname = "MESpine",
									dstBlendFunc = "771",
									name = "Spine_chupai",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									spineModel = 
									{
										SpinePath = "effect/effects_ZNQ_chupai/effects_ZNQ_chupai",
										animationName = "animation2",
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
										PositionX = -104,
										PositionY = 31,
										relativeToName = "Panel",
									},
									visible = "False",
									ZOrder = "1",
								},
								{
									controlID = "Spine_chupai2_Image_content_Panel_root_Panel-welfareView_Layer1_oneYear_Game",
									UUID = "38143892_a66b_4d88_9d7d_e9005daf4c8b",
									classname = "MESpine",
									dstBlendFunc = "771",
									name = "Spine_chupai2",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									spineModel = 
									{
										SpinePath = "effect/effects_ZNQ_chupai/effects_ZNQ_chupai",
										animationName = "animation",
										IsLoop = true,
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
										PositionX = -85,
										PositionY = -20,
										relativeToName = "Panel",
									},
									ZOrder = "1",
								},
								{
									controlID = "Spine_xipai_Image_content_Panel_root_Panel-welfareView_Layer1_oneYear_Game",
									UUID = "38a7c896_1bd5_41a6_bec8_7a26c9912c4b",
									classname = "MESpine",
									dstBlendFunc = "771",
									name = "Spine_xipai",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									spineModel = 
									{
										SpinePath = "effect/effects_ZNQ_xipai/effects_ZNQ_xipai",
										animationName = "animation",
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
										PositionX = -135,
										PositionY = -3,
										relativeToName = "Panel",
									},
									ZOrder = "1",
								},
								{
									controlID = "Label_time_Image_content_Panel_root_Panel-welfareView_Layer1_oneYear_Game",
									UUID = "abcfd3c5_c5bd_4887_96cd_20a0787e4e1b",
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
										IsStroke = true,
										StrokeColor = "#FF216298",
										StrokeSize = 1,
									},
									height = "24",
									ignoreSize = "True",
									name = "Label_time",
									nTextAlign = "1",
									nTextHAlign = "1",
									rotation = "-30",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "TextLable",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionX = -383,
										PositionY = 209,
									},
									width = "125",
									ZOrder = "1",
								},
								{
									controlID = "Image_cost_Image_content_Panel_root_Panel-welfareView_Layer1_oneYear_Game",
									UUID = "50959a1b_a769_40b2_acd4_4319b8bbb46c",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "34",
									ignoreSize = "True",
									name = "Image_cost",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/activity/oneYear/card/001.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = 379,
										PositionY = -210,
									},
									width = "146",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "Label_num_Image_cost_Image_content_Panel_root_Panel-welfareView_Layer1_oneYear_Game",
											UUID = "28b4b814_7e60_4ad1_a364_02247f820c8f",
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
											fontSize = "20",
											fontStroke = 
											{
												IsStroke = false,
												StrokeColor = "#FFE6E6E6",
												StrokeSize = 1,
											},
											height = "23",
											ignoreSize = "True",
											name = "Label_num",
											nTextAlign = "1",
											nTextHAlign = "1",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "770",
											text = "2342.0",
											touchAble = "False",
											touchScaleEnable = "False",
											UILayoutViewModel = 
											{
												PositionX = 65,
												PositionY = 1,
											},
											width = "46",
											ZOrder = "1",
										},
										{
											controlID = "Image_icon_Image_cost_Image_content_Panel_root_Panel-welfareView_Layer1_oneYear_Game",
											UUID = "3e6b9319_409a_47e1_a238_f457ead98a7c",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											classname = "MEImage",
											dstBlendFunc = "771",
											height = "100",
											ignoreSize = "True",
											name = "Image_icon",
											scaleX = "0.4",
											scaleY = "0.4",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											texturePath = "icon/item/goods/500066.png",
											touchAble = "True",
											UILayoutViewModel = 
											{
												PositionX = -45,
												PositionY = -1,
											},
											width = "100",
											ZOrder = "1",
										},
									},
								},
								{
									controlID = "Image_welfareView_1_Image_content_Panel_root_Panel-welfareView_Layer1_oneYear_Game",
									UUID = "81e7e6e0_2e3d_4cd7_a348_2a8376fed53f",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "30",
									ignoreSize = "True",
									name = "Image_welfareView_1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/activity/oneYear/card/004.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionY = -205,
									},
									width = "658",
									ZOrder = "1",
								},
								{
									controlID = "Button_record_Image_content_Panel_root_Panel-welfareView_Layer1_oneYear_Game",
									UUID = "a83110d6_65c0_45d7_8cbd_c796963504c4",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEButton",
									ClickHighLightEnabled = "True",
									dstBlendFunc = "771",
									flipX = "False",
									flipY = "False",
									height = "42",
									ignoreSize = "True",
									name = "Button_record",
									normal = "ui/summon/001.png",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "True",
									UILayoutViewModel = 
									{
										PositionX = -416,
										PositionY = -215,
									},
									UItype = "Button",
									width = "46",
									ZOrder = "1",
								},
								{
									controlID = "Button_preview_Image_content_Panel_root_Panel-welfareView_Layer1_oneYear_Game",
									UUID = "72544934_3438_42a5_992d_338bfcd62dd7",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEButton",
									ClickHighLightEnabled = "True",
									dstBlendFunc = "771",
									flipX = "False",
									flipY = "False",
									height = "42",
									ignoreSize = "True",
									name = "Button_preview",
									normal = "ui/summon/002.png",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "True",
									UILayoutViewModel = 
									{
										PositionX = -416,
										PositionY = -155,
									},
									UItype = "Button",
									width = "46",
									ZOrder = "1",
								},
								{
									controlID = "Label_choose_tip_Image_content_Panel_root_Panel-welfareView_Layer1_oneYear_Game",
									UUID = "7c60076f_7356_4fed_8ef5_9075b6d7732d",
									anchorPoint = "False",
									anchorPointX = "0.5",
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
									fontSize = "26",
									fontStroke = 
									{
										IsStroke = false,
										StrokeColor = "#FFE6E6E6",
										StrokeSize = 1,
									},
									height = "32",
									ignoreSize = "True",
									name = "Label_choose_tip",
									nTextAlign = "1",
									nTextHAlign = "1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "Sélectionnez une des cartes",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionY = -218,
									},
									width = "213",
									ZOrder = "1",
								},
								{
									controlID = "Panel_touch_Image_content_Panel_root_Panel-welfareView_Layer1_oneYear_Game",
									UUID = "e1306042_b455_4d11_b320_723d09964c45",
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
									height = "400",
									ignoreSize = "False",
									name = "Panel_touch",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "True",
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
			"ui/activity/oneYear/card/003.png",
			"ui/activity/oneYear/corner.png",
			"icon/item/goods/500066.png",
			"ui/activity/oneYear/card/005.png",
			"ui/activity/oneYear/card/008.png",
			"ui/activity/oneYear/card/006.png",
			"ui/activity/oneYear/card/009.png",
			"ui/activity/oneYear/card/007.png",
			"ui/activity/oneYear/card/010.png",
			"ui/activity/oneYear/card/002.png",
			"ui/activity/oneYear/card/001.png",
			"ui/activity/oneYear/card/004.png",
			"ui/summon/001.png",
			"ui/summon/002.png",
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

