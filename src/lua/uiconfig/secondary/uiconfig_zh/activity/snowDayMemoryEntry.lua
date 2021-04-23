local t = 
{
	version = 1,
	components = 
	{
		
		{
			controlID = "Panel-snowDayMemoryEntry_iceSnowDay_activity_Game",
			UUID = "b924e279_bd6f_47c1_81af_082c5a3b45fb",
			anchorPoint = "False",
			anchorPointX = "0",
			anchorPointY = "0",
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
					controlID = "Panel_root_Panel-snowDayMemoryEntry_iceSnowDay_activity_Game",
					UUID = "9558c492_5b3f_46d3_a1d7_dadef40e95fa",
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
							controlID = "Image_content_Panel_root_Panel-snowDayMemoryEntry_iceSnowDay_activity_Game",
							UUID = "5ce84340_81d5_4925_a7b4_7a538194be86",
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
							texturePath = "ui/activity/2020SnowDay/memory/007.png",
							touchAble = "False",
							UILayoutViewModel = 
							{
								
							},
							width = "923",
							ZOrder = "1",
							components = 
							{
								
								{
									controlID = "Button_go_Image_content_Panel_root_Panel-snowDayMemoryEntry_iceSnowDay_activity_Game",
									UUID = "00a2d74f_3bcf_4ffc_aaab_2fb4570713f3",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEButton",
									ClickHighLightEnabled = "True",
									dstBlendFunc = "771",
									flipX = "False",
									flipY = "False",
									height = "165",
									ignoreSize = "True",
									name = "Button_go",
									normal = "ui/activity/2020SnowDay/memory/006.png",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "True",
									UILayoutViewModel = 
									{
										PositionX = 360,
										PositionY = -178,
									},
									UItype = "Button",
									width = "182",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "Label_castle_Button_go_Image_content_Panel_root_Panel-snowDayMemoryEntry_iceSnowDay_activity_Game",
											UUID = "572584cc_e4f5_45e3_92a6_8205ca0d9bc7",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											classname = "MELabel",
											compPath = "luacomponents.common.MEIconLabel",
											dstBlendFunc = "771",
											FontColor = "#FF4284D4",
											fontName = "font/MFLiHei_Noncommercial.ttf",
											fontShadow = 
											{
												IsShadow = false,
												ShadowColor = "#FFFFFFFF",
												ShadowAlpha = 255,
												OffsetX = 0,
												OffsetY = 0,
											},
											fontSize = "40",
											fontStroke = 
											{
												IsStroke = false,
												StrokeColor = "#FFE6E6E6",
												StrokeSize = 1,
											},
											height = "50",
											ignoreSize = "True",
											name = "Label_castle",
											nTextAlign = "1",
											nTextHAlign = "1",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "770",
											text = "进入",
											touchAble = "False",
											touchScaleEnable = "False",
											UILayoutViewModel = 
											{
												PositionX = 23,
												PositionY = -20,
											},
											width = "81",
											ZOrder = "1",
										},
									},
								},
								{
									controlID = "Image_Time_Image_content_Panel_root_Panel-snowDayMemoryEntry_iceSnowDay_activity_Game",
									UUID = "120a688d_6673_4bca_8cb1_e353e8cf1c01",
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
											controlID = "act_time_Image_Time_Image_content_Panel_root_Panel-snowDayMemoryEntry_iceSnowDay_activity_Game",
											UUID = "a984b136_d9c7_4891_bf7a_e573f90092fa",
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
													controlID = "act_timeStart_act_time_Image_Time_Image_content_Panel_root_Panel-snowDayMemoryEntry_iceSnowDay_activity_Game",
													UUID = "333610ee_29f4_4267_b6f3_14b8f2a83285",
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
													controlID = "act_timeEnd_act_time_Image_Time_Image_content_Panel_root_Panel-snowDayMemoryEntry_iceSnowDay_activity_Game",
													UUID = "8bb67041_9e9a_42ea_ada3_64194cef823f",
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
									controlID = "Label_finishedStory_Image_content_Panel_root_Panel-snowDayMemoryEntry_iceSnowDay_activity_Game",
									UUID = "89946ef6_33e0_49cc_a081_000e8ae24483",
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
									fontSize = "24",
									fontStroke = 
									{
										IsStroke = false,
										StrokeColor = "#FFE6E6E6",
										StrokeSize = 1,
									},
									height = "27",
									ignoreSize = "True",
									name = "Label_finishedStory",
									nTextAlign = "1",
									nTextHAlign = "1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "已完成剧情",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionX = -453,
										PositionY = -249,
									},
									width = "123",
									ZOrder = "1",
								},
								{
									controlID = "Spine_snowDayMemoryEntry_1_Image_content_Panel_root_Panel-snowDayMemoryEntry_iceSnowDay_activity_Game",
									UUID = "be30c0ed_7463_4d48_a2fe_92e99833f58a",
									classname = "MESpine",
									dstBlendFunc = "771",
									name = "Spine_snowDayMemoryEntry_1",
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
								{
									controlID = "Spine_snowDayMemoryEntry_1(2)_Image_content_Panel_root_Panel-snowDayMemoryEntry_iceSnowDay_activity_Game",
									UUID = "e635c742_8d03_409c_9a64_245edaaf5815",
									classname = "MESpine",
									dstBlendFunc = "771",
									name = "Spine_snowDayMemoryEntry_1(2)",
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
			"ui/activity/2020SnowDay/memory/007.png",
			"ui/activity/2020SnowDay/memory/006.png",
			"ui/activity/time.png",
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

