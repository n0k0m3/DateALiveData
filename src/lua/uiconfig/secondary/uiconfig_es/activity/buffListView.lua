local t = 
{
	version = 1,
	components = 
	{
		
		{
			controlID = "Panel-buffListView_activity_2020_wsj_activity_Game",
			UUID = "a3738306_3244_43aa_8223_e9b9031de70c",
			anchorPoint = "False",
			anchorPointX = "0",
			anchorPointY = "0",
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
					controlID = "Panel_base_Panel-buffListView_activity_2020_wsj_activity_Game",
					UUID = "f91d4ef8_a0dd_4574_a02a_d7d22e240988",
					anchorPoint = "False",
					anchorPointX = "0",
					anchorPointY = "0",
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
							controlID = "Image_bg_Panel_base_Panel-buffListView_activity_2020_wsj_activity_Game",
							UUID = "dfdbfdd0_6539_46d8_b22a_4ec39e356e03",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							backGroundScale9Enable = "False",
							classname = "MEImage",
							dstBlendFunc = "771",
							height = "503",
							ignoreSize = "True",
							name = "Image_bg",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							texturePath = "ui/activity/activity_2020wsj/tip/tip_small.png",
							touchAble = "True",
							UILayoutViewModel = 
							{
								PositionX = 595,
								PositionY = 324,
							},
							width = "840",
							ZOrder = "1",
							components = 
							{
								
								{
									controlID = "Spine_effect1_Image_bg_Panel_base_Panel-buffListView_activity_2020_wsj_activity_Game",
									UUID = "dc982166_1a35_47ee_88ca_550fb92a478b",
									classname = "MESpine",
									dstBlendFunc = "771",
									name = "Spine_effect1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									spineModel = 
									{
										SpinePath = "effect/effects_2020wansheng_jiemian2/effects_2020wansheng_jiemian2",
										animationName = "lizi",
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
										PositionX = 362,
										PositionY = -140,
									},
									ZOrder = "1",
								},
							},
						},
						{
							controlID = "title_Panel_base_Panel-buffListView_activity_2020_wsj_activity_Game",
							UUID = "07d825f7_0db0_4438_9f21_c421118899a5",
							anchorPoint = "False",
							anchorPointX = "0",
							anchorPointY = "0.5",
							classname = "MELabel",
							compPath = "luacomponents.common.MEIconLabel",
							dstBlendFunc = "771",
							FontColor = "#FFFFD776",
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
							name = "title",
							nTextAlign = "1",
							nTextHAlign = "1",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "770",
							text = "异闻进度",
							touchAble = "False",
							touchScaleEnable = "False",
							UILayoutViewModel = 
							{
								PositionX = 274,
								PositionY = 493,
							},
							width = "116",
							ZOrder = "1",
							components = 
							{
								
								{
									controlID = "Image_line_title_Panel_base_Panel-buffListView_activity_2020_wsj_activity_Game",
									UUID = "d31bda64_3342_4ce0_9179_63b29944c34a",
									anchorPoint = "False",
									anchorPointX = "0",
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
									srcBlendFunc = "770",
									texturePath = "ui/activity/activity_2020wsj/tip/007.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = 116,
										PositionY = 2,
										IsPercent = true,
										PercentX = 100,
										PercentY = 5.71,
									},
									width = "2",
									ZOrder = "1",
								},
								{
									controlID = "Label_en_title_Panel_base_Panel-buffListView_activity_2020_wsj_activity_Game",
									UUID = "ca65aebb_378a_4f52_9459_cd6043361ce8",
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
									fontSize = "16",
									fontStroke = 
									{
										IsStroke = false,
										StrokeColor = "#FFE6E6E6",
										StrokeSize = 1,
									},
									height = "18",
									ignoreSize = "True",
									name = "Label_en",
									nTextAlign = "1",
									nTextHAlign = "1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "progress",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionX = 119,
										PositionY = -4,
										IsPercent = true,
										PercentX = 103,
										PercentY = -11.43,
									},
									width = "62",
									ZOrder = "1",
								},
							},
						},
						{
							controlID = "Button_close_Panel_base_Panel-buffListView_activity_2020_wsj_activity_Game",
							UUID = "1e29698b_b969_4692_ab2a_6885cb66bcc1",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							backGroundScale9Enable = "False",
							classname = "MEButton",
							ClickHighLightEnabled = "True",
							dstBlendFunc = "771",
							flipX = "False",
							flipY = "False",
							height = "52",
							ignoreSize = "True",
							name = "Button_close",
							normal = "ui/activity/activity_2020wsj/tip/btn_close.png",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							touchAble = "True",
							UILayoutViewModel = 
							{
								PositionX = 899,
								PositionY = 497,
							},
							UItype = "Button",
							width = "52",
							ZOrder = "1",
						},
						{
							controlID = "ScrollView_buff_Panel_base_Panel-buffListView_activity_2020_wsj_activity_Game",
							UUID = "f86faf38_0550_4cdf_8125_00aa7e4087b7",
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
							height = "355",
							ignoreSize = "False",
							innerHeight = "355",
							innerWidth = "717",
							name = "ScrollView_buff",
							showScrollbar = "False",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							touchAble = "True",
							UILayoutViewModel = 
							{
								PositionX = 211,
								PositionY = 114,
							},
							uipanelviewmodel = 
							{
								Layout="Absolute",
								nType = "0"
							},
							width = "717",
							ZOrder = "1",
						},
						{
							controlID = "tip_Panel_base_Panel-buffListView_activity_2020_wsj_activity_Game",
							UUID = "28ce9566_9bdb_4bc1_8a2c_c3a47e8f7f30",
							anchorPoint = "False",
							anchorPointX = "0",
							anchorPointY = "0.5",
							classname = "MELabel",
							compPath = "luacomponents.common.MEIconLabel",
							dstBlendFunc = "771",
							FontColor = "#FF7B9BBF",
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
							name = "tip",
							nTextAlign = "1",
							nTextHAlign = "1",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "770",
							text = "全服异闻探索度达成后， 解除南瓜大王关卡1项限制效果",
							touchAble = "False",
							touchScaleEnable = "False",
							UILayoutViewModel = 
							{
								PositionX = 270,
								PositionY = 93,
								relativeToName = "Panel",
							},
							width = "495",
							ZOrder = "1",
						},
					},
				},
				{
					controlID = "Panel_prefab_Panel-buffListView_activity_2020_wsj_activity_Game",
					UUID = "d6c0cdcf_52f3_472d_b10b_d58f3897813d",
					anchorPoint = "False",
					anchorPointX = "0",
					anchorPointY = "0",
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
							controlID = "Panel_buff_item_Panel_prefab_Panel-buffListView_activity_2020_wsj_activity_Game",
							UUID = "3f8c5bad_4295_4ef2_b895_d8d86f58770b",
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
							height = "170",
							ignoreSize = "False",
							name = "Panel_buff_item",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							touchAble = "False",
							UILayoutViewModel = 
							{
								PositionX = 588,
								PositionY = 100,
							},
							uipanelviewmodel = 
							{
								Layout="Absolute",
								nType = "0"
							},
							width = "234",
							ZOrder = "1",
							components = 
							{
								
								{
									controlID = "Panel_finish_Panel_buff_item_Panel_prefab_Panel-buffListView_activity_2020_wsj_activity_Game",
									UUID = "6aef8843_1399_4ba3_98d5_019c88e5a3f3",
									anchorPoint = "False",
									anchorPointX = "0",
									anchorPointY = "0",
									backGroundScale9Enable = "False",
									bgColorOpacity = "50",
									bIsOpenClipping = "False",
									classname = "MEPanel",
									colorType = "0;SingleColor:#FFE6E6E6;GraduallyChangingColorStart:#FFFFFFFF;GraduallyChangingColorEnd:#FFFFFFFF;vectorX:0;vectorY:0",
									DesignHeight = "640",
									DesignType = "0",
									DesignWidth = "960",
									dstBlendFunc = "771",
									height = "10",
									ignoreSize = "False",
									name = "Panel_finish",
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
											controlID = "Image_bg_Panel_finish_Panel_buff_item_Panel_prefab_Panel-buffListView_activity_2020_wsj_activity_Game",
											UUID = "d71c0202_c42f_476c_9a21_492f12965feb",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											classname = "MEImage",
											dstBlendFunc = "771",
											height = "170",
											ignoreSize = "True",
											name = "Image_bg",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											texturePath = "ui/activity/activity_2020wsj/tip/012.png",
											touchAble = "False",
											UILayoutViewModel = 
											{
												
											},
											width = "234",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "Label_tip_Image_bg_Panel_finish_Panel_buff_item_Panel_prefab_Panel-buffListView_activity_2020_wsj_activity_Game",
													UUID = "eba44fea_42bb_4e13_939a_10849db959fd",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0.5",
													classname = "MELabel",
													compPath = "luacomponents.common.MEIconLabel",
													dstBlendFunc = "771",
													FontColor = "#FF625C90",
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
													name = "Label_tip",
													nTextAlign = "1",
													nTextHAlign = "1",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "770",
													text = "已解除",
													touchAble = "False",
													touchScaleEnable = "False",
													UILayoutViewModel = 
													{
														PositionY = -28,
													},
													width = "81",
													ZOrder = "1",
												},
											},
										},
										{
											controlID = "Label_des_Panel_finish_Panel_buff_item_Panel_prefab_Panel-buffListView_activity_2020_wsj_activity_Game",
											UUID = "160d32a0_e024_437f_82b9_41c7533a6348",
											anchorPoint = "False",
											anchorPointX = "0",
											anchorPointY = "1",
											classname = "MELabel",
											compPath = "luacomponents.common.MEIconLabel",
											dstBlendFunc = "771",
											FontColor = "#FF6C7EB6",
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
											name = "Label_des",
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
												PositionX = -112,
												PositionY = 82,
											},
											width = "225",
											ZOrder = "1",
										},
									},
								},
								{
									controlID = "Panel_progress_Panel_buff_item_Panel_prefab_Panel-buffListView_activity_2020_wsj_activity_Game",
									UUID = "1e606621_68be_4b70_8094_12bbf2dd1624",
									anchorPoint = "False",
									anchorPointX = "0",
									anchorPointY = "0",
									backGroundScale9Enable = "False",
									bgColorOpacity = "50",
									bIsOpenClipping = "False",
									classname = "MEPanel",
									colorType = "0;SingleColor:#FFE6E6E6;GraduallyChangingColorStart:#FFFFFFFF;GraduallyChangingColorEnd:#FFFFFFFF;vectorX:0;vectorY:0",
									DesignHeight = "640",
									DesignType = "0",
									DesignWidth = "960",
									dstBlendFunc = "771",
									height = "10",
									ignoreSize = "False",
									name = "Panel_progress",
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
									width = "10",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "Image_bg_Panel_progress_Panel_buff_item_Panel_prefab_Panel-buffListView_activity_2020_wsj_activity_Game",
											UUID = "5cf13f5a_41db_4a06_891f_28a8789c020c",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											classname = "MEImage",
											dstBlendFunc = "771",
											height = "170",
											ignoreSize = "True",
											name = "Image_bg",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											texturePath = "ui/activity/activity_2020wsj/tip/013.png",
											touchAble = "False",
											UILayoutViewModel = 
											{
												
											},
											width = "234",
											ZOrder = "1",
										},
										{
											controlID = "Label_des_Panel_progress_Panel_buff_item_Panel_prefab_Panel-buffListView_activity_2020_wsj_activity_Game",
											UUID = "a5deadd6_ada5_45bc_bf30_a129793eace9",
											anchorPoint = "False",
											anchorPointX = "0",
											anchorPointY = "1",
											classname = "MELabel",
											compPath = "luacomponents.common.MEIconLabel",
											dstBlendFunc = "771",
											FontColor = "#FFE8A44D",
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
											name = "Label_des",
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
												PositionX = -112,
												PositionY = 82,
											},
											width = "225",
											ZOrder = "1",
										},
										{
											controlID = "LoadingBar_progress_Panel_progress_Panel_buff_item_Panel_prefab_Panel-buffListView_activity_2020_wsj_activity_Game",
											UUID = "df23e1d8_e5e3_49a4_b88d_2e61c97966b4",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											classname = "MELoadingBar",
											direction = "0",
											dstBlendFunc = "771",
											height = "10",
											ignoreSize = "False",
											name = "LoadingBar_progress",
											percent = "100",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											texture = "ui/activity/activity_2020wsj/tip/progress.png",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 1,
												PositionY = -79,
											},
											width = "232",
											ZOrder = "1",
										},
										{
											controlID = "Label_progress_Panel_progress_Panel_buff_item_Panel_prefab_Panel-buffListView_activity_2020_wsj_activity_Game",
											UUID = "7d655dd0_d0a4_4311_9959_f1ea76493aaa",
											anchorPoint = "False",
											anchorPointX = "1",
											anchorPointY = "0",
											classname = "MELabel",
											compPath = "luacomponents.common.MEIconLabel",
											dstBlendFunc = "771",
											FontColor = "#FFE8A44D",
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
											height = "0",
											ignoreSize = "False",
											name = "Label_progress",
											nTextAlign = "0",
											nTextHAlign = "0",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "770",
											text = "900 9000",
											touchAble = "False",
											touchScaleEnable = "False",
											UILayoutViewModel = 
											{
												PositionX = 112,
												PositionY = -75,
											},
											width = "0",
											ZOrder = "1",
										},
										{
											controlID = "Label_name_Panel_progress_Panel_buff_item_Panel_prefab_Panel-buffListView_activity_2020_wsj_activity_Game",
											UUID = "6b402249_164e_4937_8941_fa52a62be726",
											anchorPoint = "False",
											anchorPointX = "0",
											anchorPointY = "0",
											classname = "MELabel",
											compPath = "luacomponents.common.MEIconLabel",
											dstBlendFunc = "771",
											FontColor = "#FFE8A44D",
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
											name = "Label_name",
											nTextAlign = "1",
											nTextHAlign = "1",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "770",
											text = "无头",
											touchAble = "False",
											touchScaleEnable = "False",
											UILayoutViewModel = 
											{
												PositionX = -116,
												PositionY = -79,
											},
											width = "55",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "Label_subName_Label_name_Panel_progress_Panel_buff_item_Panel_prefab_Panel-buffListView_activity_2020_wsj_activity_Game",
													UUID = "ffcd04db_9809_4e24_94aa_f6b04b4b9067",
													anchorPoint = "False",
													anchorPointX = "0",
													anchorPointY = "0",
													classname = "MELabel",
													compPath = "luacomponents.common.MEIconLabel",
													dstBlendFunc = "771",
													FontColor = "#FFE8A44D",
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
													name = "Label_subName",
													nTextAlign = "1",
													nTextHAlign = "1",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "770",
													text = "异闻",
													touchAble = "False",
													touchScaleEnable = "False",
													UILayoutViewModel = 
													{
														PositionX = 55,
														IsPercent = true,
														PercentX = 100,
													},
													width = "43",
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
		},
	},
	actions = 
	{
		
	},
	respaths = 
	{
		textures = 
		{
			"ui/activity/activity_2020wsj/tip/tip_small.png",
			"ui/activity/activity_2020wsj/tip/007.png",
			"ui/activity/activity_2020wsj/tip/btn_close.png",
			"ui/activity/activity_2020wsj/tip/012.png",
			"ui/activity/activity_2020wsj/tip/013.png",
			"ui/activity/activity_2020wsj/tip/progress.png",
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

