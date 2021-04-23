local t = 
{
	version = 1,
	components = 
	{
		
		{
			controlID = "Panel-snowCastleMain_iceSnowDay_activity_Game",
			UUID = "455470f8_0f4c_4b6e_8bde_19ad2135a5a5",
			anchorPoint = "False",
			anchorPointX = "0",
			anchorPointY = "0",
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
				
			},
			uipanelviewmodel = 
			{
				Layout="Absolute",
				nType = "0"
			},
			width = "960",
			ZOrder = "1",
			components = 
			{
				
				{
					controlID = "Panel_root_Panel-snowCastleMain_iceSnowDay_activity_Game",
					UUID = "c6e56ea2_7ece_4b95_8c96_0eb6644b4dc7",
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
							controlID = "Image_content_Panel_root_Panel-snowCastleMain_iceSnowDay_activity_Game",
							UUID = "1195800a_3024_4b8a_a451_409c6b659462",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							backGroundScale9Enable = "False",
							classname = "MEImage",
							dstBlendFunc = "771",
							height = "543",
							ignoreSize = "True",
							name = "Image_content",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							texturePath = "ui/activity/2020SnowDay/book/bggg.png",
							touchAble = "False",
							UILayoutViewModel = 
							{
								
							},
							width = "923",
							ZOrder = "1",
							components = 
							{
								
								{
									controlID = "Image_snowCastleMain_1_Image_content_Panel_root_Panel-snowCastleMain_iceSnowDay_activity_Game",
									UUID = "d1ce43c5_843b_41d7_961b_4cb69f7f5599",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "70",
									ignoreSize = "True",
									name = "Image_snowCastleMain_1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/activity/2020SnowDay/book/014.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = -176,
										PositionY = -212,
									},
									width = "537",
									ZOrder = "1",
								},
								{
									controlID = "ProgressBg_Image_content_Panel_root_Panel-snowCastleMain_iceSnowDay_activity_Game",
									UUID = "fb836ef7_9c66_40e5_98a5_8e0edcf0c7b4",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "True;capInsetsX:30;capInsetsY:5;capInsetsWidth:76;capInsetsHeight:11",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "21",
									ignoreSize = "False",
									name = "ProgressBg",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/activity/2020SnowDay/book/011.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = -116,
										PositionY = -203,
									},
									width = "380",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "TaskProgress_ProgressBg_Image_content_Panel_root_Panel-snowCastleMain_iceSnowDay_activity_Game",
											UUID = "ec643dff_2f6e_4ba1_958f_f10cba6d97f3",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "True;capInsetsX:30;capInsetsY:5;capInsetsWidth:76;capInsetsHeight:11",
											classname = "MELoadingBar",
											direction = "0",
											dstBlendFunc = "771",
											height = "21",
											ignoreSize = "False",
											name = "TaskProgress",
											percent = "56",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											texture = "ui/activity/2020SnowDay/book/010.png",
											touchAble = "False",
											UILayoutViewModel = 
											{
												
											},
											width = "380",
											ZOrder = "1",
										},
										{
											controlID = "DayLimit_ProgressBg_Image_content_Panel_root_Panel-snowCastleMain_iceSnowDay_activity_Game",
											UUID = "2a31c47d_3598_48f9_9101_17bf87c17563",
											anchorPoint = "False",
											anchorPointX = "0",
											anchorPointY = "0.5",
											classname = "MELabel",
											compPath = "luacomponents.common.MEIconLabel",
											dstBlendFunc = "771",
											FontColor = "#FF46658E",
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
											name = "DayLimit",
											nTextAlign = "1",
											nTextHAlign = "1",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "770",
											text = "每日",
											touchAble = "False",
											touchScaleEnable = "False",
											UILayoutViewModel = 
											{
												PositionX = -319,
												PositionY = -29,
											},
											width = "46",
											ZOrder = "1",
										},
										{
											controlID = "Spine_lv_ProgressBg_Image_content_Panel_root_Panel-snowCastleMain_iceSnowDay_activity_Game",
											UUID = "c1bd45fe_a29b_4952_b394_edcd73553947",
											classname = "MESpine",
											dstBlendFunc = "771",
											name = "Spine_lv",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											spineModel = 
											{
												SpinePath = "effect/activity_snowFes/snowFes_pamphletHint/snowFes_pamphletHint",
												animationName = "snowFes_pamphletHint_2",
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
											controlID = "LvProgress_ProgressBg_Image_content_Panel_root_Panel-snowCastleMain_iceSnowDay_activity_Game",
											UUID = "733dc180_22ce_4d39_b00e_1e6c18433cb1",
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
											fontSize = "20",
											fontStroke = 
											{
												IsStroke = true,
												StrokeColor = "#FF2F3338",
												StrokeSize = 1,
											},
											height = "25",
											ignoreSize = "True",
											name = "LvProgress",
											nTextAlign = "1",
											nTextHAlign = "1",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "770",
											text = "10",
											touchAble = "False",
											touchScaleEnable = "False",
											UILayoutViewModel = 
											{
												PositionX = 187,
												PositionY = -1,
											},
											width = "22",
											ZOrder = "1",
										},
									},
								},
								{
									controlID = "Level_Image_content_Panel_root_Panel-snowCastleMain_iceSnowDay_activity_Game",
									UUID = "45df2788_dfc5_429a_820f_2013110a2ff7",
									anchorPoint = "False",
									anchorPointX = "0",
									anchorPointY = "0.5",
									classname = "MELabel",
									compPath = "luacomponents.common.MEIconLabel",
									dstBlendFunc = "771",
									FontColor = "#FF46658E",
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
									name = "Level",
									nTextAlign = "1",
									nTextHAlign = "1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "等级:14",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionX = -436,
										PositionY = -202,
									},
									width = "78",
									ZOrder = "1",
								},
								{
									controlID = "Button_castle_Image_content_Panel_root_Panel-snowCastleMain_iceSnowDay_activity_Game",
									UUID = "c2541baf_6217_4a01_988e_25b2d4e3e10b",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEButton",
									ClickHighLightEnabled = "True",
									dstBlendFunc = "771",
									flipX = "False",
									flipY = "False",
									height = "98",
									ignoreSize = "True",
									name = "Button_castle",
									normal = "ui/activity/2020SnowDay/book/013.png",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "True",
									UILayoutViewModel = 
									{
										PositionX = 363,
										PositionY = -212,
									},
									UItype = "Button",
									width = "180",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "Label_castle_Button_castle_Image_content_Panel_root_Panel-snowCastleMain_iceSnowDay_activity_Game",
											UUID = "ae8c4971_9556_41b4_a2cb_f9f2e635f90c",
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
												IsStroke = false,
												StrokeColor = "#FFE6E6E6",
												StrokeSize = 1,
											},
											height = "30",
											ignoreSize = "True",
											name = "Label_castle",
											nTextAlign = "1",
											nTextHAlign = "1",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "770",
											text = "升级手册",
											touchAble = "False",
											touchScaleEnable = "False",
											UILayoutViewModel = 
											{
												PositionY = -4,
											},
											width = "100",
											ZOrder = "1",
										},
										{
											controlID = "Spine_lv_Button_castle_Image_content_Panel_root_Panel-snowCastleMain_iceSnowDay_activity_Game",
											UUID = "c8bf8098_8818_4fec_a6b0_10bfacefa581",
											classname = "MESpine",
											dstBlendFunc = "771",
											name = "Spine_lv",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											spineModel = 
											{
												SpinePath = "effect/activity_snowFes/snowFes_pamphletHint/snowFes_pamphletHint",
												animationName = "snowFes_pamphletHint_1",
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
												PositionY = 2,
											},
											ZOrder = "1",
										},
									},
								},
								{
									controlID = "Button_book_Image_content_Panel_root_Panel-snowCastleMain_iceSnowDay_activity_Game",
									UUID = "086bbf0d_f2a0_430b_abe2_03316f1757d0",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEButton",
									ClickHighLightEnabled = "True",
									dstBlendFunc = "771",
									flipX = "False",
									flipY = "False",
									height = "98",
									ignoreSize = "True",
									name = "Button_book",
									normal = "ui/activity/2020SnowDay/book/012.png",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "True",
									UILayoutViewModel = 
									{
										PositionX = 187,
										PositionY = -212,
									},
									UItype = "Button",
									width = "180",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "Label_book_Button_book_Image_content_Panel_root_Panel-snowCastleMain_iceSnowDay_activity_Game",
											UUID = "b9e7973c_89ef_4c0c_8baa_cd49316850b4",
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
												IsStroke = false,
												StrokeColor = "#FFE6E6E6",
												StrokeSize = 1,
											},
											height = "30",
											ignoreSize = "True",
											name = "Label_book",
											nTextAlign = "1",
											nTextHAlign = "1",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "770",
											text = "查看详情",
											touchAble = "False",
											touchScaleEnable = "False",
											UILayoutViewModel = 
											{
												PositionY = -4,
											},
											width = "98",
											ZOrder = "1",
										},
									},
								},
								{
									controlID = "Label_progress_Image_content_Panel_root_Panel-snowCastleMain_iceSnowDay_activity_Game",
									UUID = "e852d018_c8c8_4de9_9f7f_5958f57bfc38",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									classname = "MELabel",
									compPath = "luacomponents.common.MEIconLabel",
									dstBlendFunc = "771",
									FontColor = "#FFFFFFFF",
									fontName = "phanta.ttf",
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
									name = "Label_progress",
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
										PositionX = -218,
										PositionY = -217,
									},
									visible = "False",
									width = "80",
									ZOrder = "1",
								},
								{
									controlID = "Image_Time_Image_content_Panel_root_Panel-snowCastleMain_iceSnowDay_activity_Game",
									UUID = "67c90402_a1ec_43a5_866e_615b6d550587",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "50",
									ignoreSize = "True",
									name = "Image_Time",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/activity/time.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = -399,
										PositionY = 241,
									},
									width = "136",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "act_time_Image_Time_Image_content_Panel_root_Panel-snowCastleMain_iceSnowDay_activity_Game",
											UUID = "a4765654_2014_4c14_a3c9_554b998248a4",
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
											fontSize = "22",
											fontStroke = 
											{
												IsStroke = true,
												StrokeColor = "#FF7891B5",
												StrokeSize = 1,
											},
											height = "29",
											ignoreSize = "True",
											name = "act_time",
											nTextAlign = "1",
											nTextHAlign = "1",
											rotation = "-12",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "770",
											text = "活动时间",
											touchAble = "False",
											touchScaleEnable = "False",
											UILayoutViewModel = 
											{
												PositionX = 23,
												PositionY = 7,
											},
											width = "91",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "act_timeStart_act_time_Image_Time_Image_content_Panel_root_Panel-snowCastleMain_iceSnowDay_activity_Game",
													UUID = "af99c0e8_97b8_4002_af1b_686834922bf9",
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
													fontSize = "18",
													fontStroke = 
													{
														IsStroke = true,
														StrokeColor = "#FF7891B5",
														StrokeSize = 2,
													},
													height = "26",
													ignoreSize = "True",
													name = "act_timeStart",
													nTextAlign = "1",
													nTextHAlign = "1",
													rotation = "-3",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "770",
													text = "20200416",
													touchAble = "False",
													touchScaleEnable = "False",
													UILayoutViewModel = 
													{
														PositionX = -48,
														PositionY = -24,
													},
													width = "120",
													ZOrder = "1",
												},
												{
													controlID = "act_timeEnd_act_time_Image_Time_Image_content_Panel_root_Panel-snowCastleMain_iceSnowDay_activity_Game",
													UUID = "246f4fd7_1dbc_4433_952a_8e0be5df31bf",
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
													fontSize = "18",
													fontStroke = 
													{
														IsStroke = true,
														StrokeColor = "#FF7891B5",
														StrokeSize = 2,
													},
													height = "26",
													ignoreSize = "True",
													name = "act_timeEnd",
													nTextAlign = "1",
													nTextHAlign = "1",
													rotation = "-3",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "770",
													text = "20200416",
													touchAble = "False",
													touchScaleEnable = "False",
													UILayoutViewModel = 
													{
														PositionX = -86,
														PositionY = -44,
													},
													width = "120",
													ZOrder = "1",
												},
											},
										},
									},
								},
								{
									controlID = "Image_snowMan_Image_content_Panel_root_Panel-snowCastleMain_iceSnowDay_activity_Game",
									UUID = "26f11583_8aac_4182_bffa_827d00aaded0",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "369",
									ignoreSize = "True",
									name = "Image_snowMan",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/activity/2020SnowDay/book/snowMan3.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = -141,
										PositionY = 63,
									},
									width = "401",
									ZOrder = "1",
								},
							},
						},
						{
							controlID = "Spine_snowCastleMain_1_Panel_root_Panel-snowCastleMain_iceSnowDay_activity_Game",
							UUID = "d4d6902e_0c81_47f0_8983_be3bff08a9a6",
							classname = "MESpine",
							dstBlendFunc = "771",
							name = "Spine_snowCastleMain_1",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							spineModel = 
							{
								SpinePath = "effect/activity_snowFes/snowFes_main/snowFes_main",
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
							controlID = "Spine_snowCastleMain_2_Panel_root_Panel-snowCastleMain_iceSnowDay_activity_Game",
							UUID = "c7bc56f4_3c9d_49bb_b210_bfa6ca841fc5",
							classname = "MESpine",
							dstBlendFunc = "771",
							name = "Spine_snowCastleMain_2",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							spineModel = 
							{
								SpinePath = "effect/activity_snowFes/snowFes_main1/snowFes_main1",
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
	actions = 
	{
		
	},
	respaths = 
	{
		textures = 
		{
			"ui/activity/2020SnowDay/book/bggg.png",
			"ui/activity/2020SnowDay/book/014.png",
			"ui/activity/2020SnowDay/book/011.png",
			"ui/activity/2020SnowDay/book/010.png",
			"ui/activity/2020SnowDay/book/013.png",
			"ui/activity/2020SnowDay/book/012.png",
			"ui/activity/time.png",
			"ui/activity/2020SnowDay/book/snowMan3.png",
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

