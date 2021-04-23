local t = 
{
	version = 1,
	components = 
	{
		
		{
			controlID = "Panel-decrptTip_znq_yly_activity_Game",
			UUID = "de96301d_84f9_458f_b767_15f6bb9dd8ac",
			anchorPoint = "False",
			anchorPointX = "0",
			anchorPointY = "0",
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
			width = "960",
			ZOrder = "1",
			components = 
			{
				
				{
					controlID = "Image_decrptTip_1_Panel-decrptTip_znq_yly_activity_Game",
					UUID = "6c30a2ee_bd19_46f2_9b2c_25cfe962b370",
					anchorPoint = "False",
					anchorPointX = "0.5",
					anchorPointY = "0.5",
					backGroundScale9Enable = "False",
					classname = "MEImage",
					dstBlendFunc = "771",
					height = "640",
					ignoreSize = "True",
					name = "Image_decrptTip_1",
					sizepercentx = "0",
					sizepercenty = "0",
					sizeType = "0",
					srcBlendFunc = "1",
					texturePath = "ui/activity/znq_yly/Image_mark.png",
					touchAble = "False",
					UILayoutViewModel = 
					{
						PositionX = 480,
						PositionY = 320,
						relativeToName = "Panel",
						nType = 3,
						nGravity = 6,
						nAlign = 5
					},
					width = "1386",
					ZOrder = "1",
					components = 
					{
						
						{
							controlID = "Spine_wishTree_1_Image_decrptTip_1_Panel-decrptTip_znq_yly_activity_Game",
							UUID = "f34c86d2_d090_46a5_91f0_041d21716114",
							classname = "MESpine",
							dstBlendFunc = "771",
							name = "Spine_wishTree_1",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							spineModel = 
							{
								SpinePath = "effect/effects_SpringFestival_bgflow/effects_SpringFestival_bgflow",
								animationName = "play_hua",
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
								relativeToName = "Panel",
							},
							ZOrder = "1",
						},
					},
				},
				{
					controlID = "Panel_base_Panel-decrptTip_znq_yly_activity_Game",
					UUID = "86c77706_6647_4db9_adbc_86b54c8cf01c",
					anchorPoint = "False",
					anchorPointX = "0",
					anchorPointY = "0",
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
						PositionX = -88,
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
							controlID = "Image_1_Panel_base_Panel-decrptTip_znq_yly_activity_Game",
							UUID = "f4f7c6f6_2c61_4f29_8d54_8b90eec6abf5",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							backGroundScale9Enable = "False",
							classname = "MEImage",
							dstBlendFunc = "771",
							height = "512",
							ignoreSize = "True",
							name = "Image_1",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							texturePath = "ui/activity/znq_yly/info/009.png",
							touchAble = "True",
							UILayoutViewModel = 
							{
								PositionX = 562,
								PositionY = 330,
							},
							width = "1049",
							ZOrder = "1",
						},
						{
							controlID = "Button_close_Panel_base_Panel-decrptTip_znq_yly_activity_Game",
							UUID = "10f55edc_2375_44a2_b291_8863dd7de1fb",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							backGroundScale9Enable = "False",
							classname = "MEButton",
							ClickHighLightEnabled = "True",
							dstBlendFunc = "771",
							flipX = "False",
							flipY = "False",
							height = "64",
							ignoreSize = "True",
							name = "Button_close",
							normal = "ui/activity/znq_yly/info/012.png",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							touchAble = "True",
							UILayoutViewModel = 
							{
								PositionX = 1025,
								PositionY = 576,
							},
							UItype = "Button",
							width = "62",
							ZOrder = "1",
						},
						{
							controlID = "Label_title_Panel_base_Panel-decrptTip_znq_yly_activity_Game",
							UUID = "f070e783_c397_4c9e_b460_27903500ff3a",
							anchorPoint = "False",
							anchorPointX = "0",
							anchorPointY = "0.5",
							classname = "MELabel",
							compPath = "luacomponents.common.MEIconLabel",
							dstBlendFunc = "771",
							FontColor = "#FF416385",
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
							text = "新春解密",
							touchAble = "False",
							touchScaleEnable = "False",
							UILayoutViewModel = 
							{
								PositionX = 187,
								PositionY = 553,
							},
							width = "115",
							ZOrder = "1",
							components = 
							{
								
								{
									controlID = "Image_line_Label_title_Panel_base_Panel-decrptTip_znq_yly_activity_Game",
									UUID = "5bb0691c_f741_4c80_9a77_2b8bdb6cbeaa",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "32",
									ignoreSize = "True",
									name = "Image_line",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									texturePath = "ui/activity/znq_yly/info/014.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = 120,
										PositionY = 1,
									},
									width = "4",
									ZOrder = "1",
								},
							},
						},
						{
							controlID = "Panel_content_Panel_base_Panel-decrptTip_znq_yly_activity_Game",
							UUID = "fa397a20_e40a_4a90_bae7_26f0350c8fe7",
							anchorPoint = "False",
							anchorPointX = "0",
							anchorPointY = "0",
							backGroundScale9Enable = "False",
							bgColorOpacity = "50",
							bIsOpenClipping = "False",
							classname = "MEPanel",
							colorType = "0;SingleColor:#FFE6E6E6;GraduallyChangingColorStart:#FFFFFFFF;GraduallyChangingColorEnd:#FFFFFFFF;vectorX:0;vectorY:0",
							DesignHeight = "640",
							DesignType = "0",
							DesignWidth = "960",
							dstBlendFunc = "771",
							height = "376",
							ignoreSize = "False",
							name = "Panel_content",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							touchAble = "False",
							UILayoutViewModel = 
							{
								PositionX = 105,
								PositionY = 150,
							},
							uipanelviewmodel = 
							{
								Layout="Absolute",
								nType = "0"
							},
							width = "930",
							ZOrder = "1",
							components = 
							{
								
								{
									controlID = "Image_map_Panel_content_Panel_base_Panel-decrptTip_znq_yly_activity_Game",
									UUID = "76314aa4_47ed_42ec_95ac_5bec856839da",
									anchorPoint = "False",
									anchorPointX = "0",
									anchorPointY = "0",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "187",
									ignoreSize = "True",
									name = "Image_map",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/activity/znq_yly/info/029.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										
									},
									width = "60",
									ZOrder = "1",
								},
							},
						},
						{
							controlID = "ScrollView_tab_Panel_base_Panel-decrptTip_znq_yly_activity_Game",
							UUID = "550a03db_b6bc_4d4d_ac2b_8fe20933beeb",
							anchorPoint = "False",
							anchorPointX = "0",
							anchorPointY = "0",
							backGroundScale9Enable = "False",
							bgColorOpacity = "50",
							bIsOpenClipping = "True",
							bounceEnable = "False",
							classname = "MEScrollView",
							colorType = "0;SingleColor:#FFFF0000;GraduallyChangingColorStart:#FFFFFFFF;GraduallyChangingColorEnd:#FFFFFFFF;vectorX:0;vectorY:0",
							direction = "1",
							dstBlendFunc = "771",
							height = "376",
							ignoreSize = "False",
							innerHeight = "376",
							innerWidth = "60",
							name = "ScrollView_tab",
							showScrollbar = "False",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							touchAble = "True",
							UILayoutViewModel = 
							{
								PositionX = 41,
								PositionY = 153,
							},
							uipanelviewmodel = 
							{
								Layout="Absolute",
								nType = "0"
							},
							width = "60",
							ZOrder = "10",
						},
						{
							controlID = "Image_2_Panel_base_Panel-decrptTip_znq_yly_activity_Game",
							UUID = "7abb62c2_a8a6_4b47_97cc_266d85f8767b",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							backGroundScale9Enable = "False",
							classname = "MEImage",
							dstBlendFunc = "771",
							height = "215",
							ignoreSize = "True",
							name = "Image_2",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							texturePath = "ui/activity/znq_yly/info/026.png",
							touchAble = "False",
							UILayoutViewModel = 
							{
								PositionX = 79,
								PositionY = 519,
							},
							width = "207",
							ZOrder = "1",
						},
						{
							controlID = "Image_3_Panel_base_Panel-decrptTip_znq_yly_activity_Game",
							UUID = "8749c088_3020_4f39_8a6f_5c946be04143",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							backGroundScale9Enable = "False",
							classname = "MEImage",
							dstBlendFunc = "771",
							height = "71",
							ignoreSize = "True",
							name = "Image_3",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							texturePath = "ui/activity/znq_yly/info/027.png",
							touchAble = "False",
							UILayoutViewModel = 
							{
								PositionX = 81,
								PositionY = 119,
							},
							width = "139",
							ZOrder = "1",
						},
						{
							controlID = "Label_time_Panel_base_Panel-decrptTip_znq_yly_activity_Game",
							UUID = "89dd534e_a698_4b10_8875_891f774e43b9",
							anchorPoint = "False",
							anchorPointX = "0",
							anchorPointY = "0.5",
							classname = "MELabel",
							compPath = "luacomponents.common.MEIconLabel",
							dstBlendFunc = "771",
							FontColor = "#FF416385",
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
							name = "Label_time",
							nTextAlign = "0",
							nTextHAlign = "0",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "770",
							text = "重置倒计时：",
							touchAble = "False",
							touchScaleEnable = "False",
							UILayoutViewModel = 
							{
								PositionX = 272,
								PositionY = 110,
							},
							width = "0",
							ZOrder = "1",
							components = 
							{
								
								{
									controlID = "Label_tip_Label_time_Panel_base_Panel-decrptTip_znq_yly_activity_Game",
									UUID = "d3a7d51f_f60c_4ac6_9482_116ba8dfdf56",
									anchorPoint = "False",
									anchorPointX = "0",
									anchorPointY = "0.5",
									classname = "MELabel",
									compPath = "luacomponents.common.MEIconLabel",
									dstBlendFunc = "771",
									FontColor = "#FF416385",
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
									name = "Label_tip",
									nTextAlign = "0",
									nTextHAlign = "0",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "重置倒计时：",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionX = -116,
									},
									width = "0",
									ZOrder = "1",
								},
							},
						},
						{
							controlID = "Label_des_Panel_base_Panel-decrptTip_znq_yly_activity_Game",
							UUID = "204b7063_0566_464a_939c_6a11b4b2ca77",
							anchorPoint = "False",
							anchorPointX = "0",
							anchorPointY = "0.5",
							classname = "MELabel",
							compPath = "luacomponents.common.MEIconLabel",
							dstBlendFunc = "771",
							FontColor = "#FF416385",
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
							name = "Label_des",
							nTextAlign = "0",
							nTextHAlign = "0",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "770",
							text = "重置倒计时：",
							touchAble = "False",
							touchScaleEnable = "False",
							UILayoutViewModel = 
							{
								PositionX = 155,
								PositionY = 110,
							},
							width = "436",
							ZOrder = "1",
						},
						{
							controlID = "Button_help_Panel_base_Panel-decrptTip_znq_yly_activity_Game",
							UUID = "e0c4c99e_8a96_4c1a_9e2c_bb7bed7245c0",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							backGroundScale9Enable = "False",
							classname = "MEButton",
							ClickHighLightEnabled = "True",
							dstBlendFunc = "771",
							flipX = "False",
							flipY = "False",
							height = "48",
							ignoreSize = "True",
							name = "Button_help",
							normal = "ui/activity/spingFestival2021/guessWord/012.png",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							touchAble = "True",
							UILayoutViewModel = 
							{
								PositionX = 338,
								PositionY = 556,
							},
							UItype = "Button",
							width = "48",
							ZOrder = "1",
						},
					},
				},
				{
					controlID = "Panel_prefab_Panel-decrptTip_znq_yly_activity_Game",
					UUID = "122c85b1_84c2_4413_b770_eb03e215496d",
					anchorPoint = "False",
					anchorPointX = "0",
					anchorPointY = "0",
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
						PositionX = -88,
						PositionY = -639,
						LeftPositon = -88,
						BottomPosition = -639,
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
							controlID = "Panel_tabItem_Panel_prefab_Panel-decrptTip_znq_yly_activity_Game",
							UUID = "d300b059_8102_4dcb_ba9a_fe8295c6946e",
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
							height = "187",
							ignoreSize = "False",
							name = "Panel_tabItem",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							touchAble = "True",
							UILayoutViewModel = 
							{
								PositionX = 79,
								PositionY = 183,
								LeftPositon = 61,
								TopPosition = 415,
								relativeToName = "Panel",
							},
							uipanelviewmodel = 
							{
								Layout="Absolute",
								nType = "0"
							},
							width = "60",
							ZOrder = "1",
							components = 
							{
								
								{
									controlID = "Image_normal_Panel_tabItem_Panel_prefab_Panel-decrptTip_znq_yly_activity_Game",
									UUID = "8e3f77bd_7499_44f5_869c_d5189a200c0d",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "187",
									ignoreSize = "True",
									name = "Image_normal",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/activity/znq_yly/info/029.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = -1,
									},
									width = "60",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "Label_cn_Image_normal_Panel_tabItem_Panel_prefab_Panel-decrptTip_znq_yly_activity_Game",
											UUID = "706f5da4_8972_43e2_b2c2_5ce4486b6f4d",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											classname = "MELabel",
											compPath = "luacomponents.common.MEIconLabel",
											dstBlendFunc = "771",
											FontColor = "#FF9BC6F2",
											fontName = "font/MFLiHei_Noncommercial.ttf",
											fontShadow = 
											{
												IsShadow = false,
												ShadowColor = "#FFFFFFFF",
												ShadowAlpha = 255,
												OffsetX = 0,
												OffsetY = 0,
											},
											fontSize = "25",
											fontStroke = 
											{
												IsStroke = false,
												StrokeColor = "#FFE6E6E6",
												StrokeSize = 1,
											},
											height = "0",
											ignoreSize = "False",
											name = "Label_cn",
											nTextAlign = "1",
											nTextHAlign = "1",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "770",
											text = "地图",
											touchAble = "False",
											touchScaleEnable = "False",
											UILayoutViewModel = 
											{
												
											},
											width = "30",
											ZOrder = "1",
										},
									},
								},
								{
									controlID = "select_Panel_tabItem_Panel_prefab_Panel-decrptTip_znq_yly_activity_Game",
									UUID = "9d420f67_03e1_4a57_b657_b1cfabde57ee",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "187",
									ignoreSize = "True",
									name = "select",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/activity/znq_yly/info/028.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										
									},
									width = "60",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "Label_cn_select_Panel_tabItem_Panel_prefab_Panel-decrptTip_znq_yly_activity_Game",
											UUID = "b275b3d7_f159_41a5_ba1a_ef273abe1026",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											classname = "MELabel",
											compPath = "luacomponents.common.MEIconLabel",
											dstBlendFunc = "771",
											FontColor = "#FF902A3B",
											fontName = "font/MFLiHei_Noncommercial.ttf",
											fontShadow = 
											{
												IsShadow = false,
												ShadowColor = "#FFFFFFFF",
												ShadowAlpha = 255,
												OffsetX = 0,
												OffsetY = 0,
											},
											fontSize = "25",
											fontStroke = 
											{
												IsStroke = false,
												StrokeColor = "#FFE6E6E6",
												StrokeSize = 1,
											},
											height = "0",
											ignoreSize = "False",
											name = "Label_cn",
											nTextAlign = "1",
											nTextHAlign = "1",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "770",
											text = "地图",
											touchAble = "False",
											touchScaleEnable = "False",
											UILayoutViewModel = 
											{
												
											},
											width = "30",
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
			"ui/activity/znq_yly/Image_mark.png",
			"ui/activity/znq_yly/info/009.png",
			"ui/activity/znq_yly/info/012.png",
			"ui/activity/znq_yly/info/014.png",
			"ui/activity/znq_yly/info/029.png",
			"ui/activity/znq_yly/info/026.png",
			"ui/activity/znq_yly/info/027.png",
			"ui/activity/spingFestival2021/guessWord/012.png",
			"ui/activity/znq_yly/info/028.png",
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

