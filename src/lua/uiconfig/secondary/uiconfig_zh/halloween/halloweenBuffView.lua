local t = 
{
	version = 1,
	components = 
	{
		
		{
			controlID = "Panel-halloweenBuffView_popUp_halloween_Game",
			UUID = "071bb35d_e26a_41ee_9b8e_9a31e71804e6",
			anchorPoint = "False",
			anchorPointX = "0",
			anchorPointY = "0",
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
					controlID = "Panel_base_Panel-halloweenBuffView_popUp_halloween_Game",
					UUID = "b65c7e88_9e6a_435f_a539_3eacd613647f",
					anchorPoint = "False",
					anchorPointX = "0",
					anchorPointY = "0",
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
							controlID = "Image_bg_Panel_base_Panel-halloweenBuffView_popUp_halloween_Game",
							UUID = "f0c12e62_ca8e_4aed_abb9_d44030d45311",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							backGroundScale9Enable = "False",
							classname = "MEImage",
							dstBlendFunc = "771",
							height = "448",
							ignoreSize = "True",
							name = "Image_bg",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							texturePath = "ui/Halloween/Popup/001.png",
							touchAble = "False",
							UILayoutViewModel = 
							{
								PositionX = 493,
								PositionY = 323,
							},
							width = "1030",
							ZOrder = "1",
							components = 
							{
								
								{
									controlID = "Image_halloweenTaskView_1_Image_bg_Panel_base_Panel-halloweenBuffView_popUp_halloween_Game",
									UUID = "3aebf430_a60e_446b_b1de_0f9833dc1c44",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "True;capInsetsX:0;capInsetsY:0;capInsetsWidth:0;capInsetsHeight:0",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "340",
									ignoreSize = "False",
									name = "Image_halloweenTaskView_1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/Halloween/Popup/002.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = 139,
										PositionY = -14,
									},
									width = "718",
									ZOrder = "1",
								},
							},
						},
						{
							controlID = "Button_close_Panel_base_Panel-halloweenBuffView_popUp_halloween_Game",
							UUID = "0e90e87a_ea10_4ba2_8475_792672e9c238",
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
								PositionX = 964,
								PositionY = 503,
							},
							UItype = "Button",
							width = "60",
							ZOrder = "1",
						},
						{
							controlID = "ScrollView_buff_Panel_base_Panel-halloweenBuffView_popUp_halloween_Game",
							UUID = "bc6937c8_34b6_41e0_aaff_3eb7ff718f4b",
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
							height = "340",
							ignoreSize = "False",
							innerHeight = "340",
							innerWidth = "718",
							name = "ScrollView_buff",
							showScrollbar = "False",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							touchAble = "True",
							UILayoutViewModel = 
							{
								PositionX = 272,
								PositionY = 139,
							},
							uipanelviewmodel = 
							{
								Layout="Absolute",
								nType = "0"
							},
							width = "718",
							ZOrder = "1",
						},
						{
							controlID = "title_Panel_base_Panel-halloweenBuffView_popUp_halloween_Game",
							UUID = "3813a676_0adc_415c_ae92_e8db20cd2c6a",
							anchorPoint = "False",
							anchorPointX = "0",
							anchorPointY = "0.5",
							classname = "MELabel",
							compPath = "luacomponents.common.MEIconLabel",
							dstBlendFunc = "771",
							FontColor = "#FFFFBB59",
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
							text = "增益",
							touchAble = "False",
							touchScaleEnable = "False",
							UILayoutViewModel = 
							{
								PositionX = 274,
								PositionY = 500,
							},
							width = "59",
							ZOrder = "1",
							components = 
							{
								
								{
									controlID = "Label_flag_title_Panel_base_Panel-halloweenBuffView_popUp_halloween_Game",
									UUID = "891ce97b_341a_43c0_af5e_63edf602e1fa",
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
									fontSize = "30",
									fontStroke = 
									{
										IsStroke = false,
										StrokeColor = "#FFE6E6E6",
										StrokeSize = 1,
									},
									height = "34",
									ignoreSize = "True",
									name = "Label_flag",
									nTextAlign = "1",
									nTextHAlign = "1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "|",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionX = 60,
										PositionY = -1,
									},
									width = "8",
									ZOrder = "1",
								},
								{
									controlID = "title_en_title_Panel_base_Panel-halloweenBuffView_popUp_halloween_Game",
									UUID = "6e49530b_996a_44e9_8ffa_8d0edbccf779",
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
									name = "title_en",
									nTextAlign = "1",
									nTextHAlign = "1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "buff",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionX = 66,
										PositionY = -4,
									},
									width = "30",
									ZOrder = "1",
								},
							},
						},
						{
							controlID = "tip1_Panel_base_Panel-halloweenBuffView_popUp_halloween_Game",
							UUID = "1c212155_c088_4d3e_bca3_6706ff1f7f39",
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
							name = "tip1",
							nTextAlign = "1",
							nTextHAlign = "1",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "770",
							text = "重置提示描述",
							touchAble = "False",
							touchScaleEnable = "False",
							UILayoutViewModel = 
							{
								PositionX = 275,
								PositionY = 128,
							},
							width = "99",
							ZOrder = "1",
						},
					},
				},
				{
					controlID = "Panel_prefab_Panel-halloweenBuffView_popUp_halloween_Game",
					UUID = "b169c91e_11a5_4679_8651_6758e13da70d",
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
						PositionY = -700,
						BottomPosition = -700,
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
					width = "1136",
					ZOrder = "1",
					components = 
					{
						
						{
							controlID = "Panel_item_Panel_prefab_Panel-halloweenBuffView_popUp_halloween_Game",
							UUID = "96ab5710_26ee_4eee_8dcb_1720aa6361eb",
							anchorPoint = "False",
							anchorPointX = "0",
							anchorPointY = "0",
							backGroundScale9Enable = "False",
							bgColorOpacity = "50",
							bIsOpenClipping = "False",
							classname = "MEPanel",
							colorType = "0;SingleColor:#FFE6E6E6;GraduallyChangingColorStart:#FFFFFFFF;GraduallyChangingColorEnd:#FFFFFFFF;vectorX:0;vectorY:0",
							DesignHeight = "640",
							DesignType = "0",
							DesignWidth = "960",
							dstBlendFunc = "771",
							height = "109",
							ignoreSize = "False",
							name = "Panel_item",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							touchAble = "False",
							UILayoutViewModel = 
							{
								PositionX = 247,
								PositionY = 343,
							},
							uipanelviewmodel = 
							{
								Layout="Absolute",
								nType = "0"
							},
							width = "712",
							ZOrder = "1",
							components = 
							{
								
								{
									controlID = "Panel_normal_Panel_item_Panel_prefab_Panel-halloweenBuffView_popUp_halloween_Game",
									UUID = "297cbddc_349d_447f_ac7a_be589f512a3c",
									anchorPoint = "False",
									anchorPointX = "0",
									anchorPointY = "0",
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
									name = "Panel_normal",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionY = 3,
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
											controlID = "Image_bg_Panel_normal_Panel_item_Panel_prefab_Panel-halloweenBuffView_popUp_halloween_Game",
											UUID = "55dc6086_ff40_4bd1_8dfd_9472cac63cf4",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											classname = "MEImage",
											dstBlendFunc = "771",
											height = "108",
											ignoreSize = "True",
											name = "Image_bg",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											texturePath = "ui/Halloween/Popup/010.png",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 356,
												PositionY = 50,
											},
											width = "712",
											ZOrder = "1",
										},
										{
											controlID = "label_flag_Panel_normal_Panel_item_Panel_prefab_Panel-halloweenBuffView_popUp_halloween_Game",
											UUID = "9842ca27_01bf_47dc_9e78_e7d14e14bca9",
											anchorPoint = "False",
											anchorPointX = "1",
											anchorPointY = "0.5",
											classname = "MELabel",
											compPath = "luacomponents.common.MEIconLabel",
											dstBlendFunc = "771",
											FontColor = "#FFFFCE78",
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
											name = "label_flag",
											nTextAlign = "1",
											nTextHAlign = "1",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "770",
											text = "確認洗練將消耗洗練材料，並返還90%材料",
											touchAble = "False",
											touchScaleEnable = "False",
											UILayoutViewModel = 
											{
												PositionX = 669,
												PositionY = 84,
											},
											width = "88",
											ZOrder = "1",
										},
										{
											controlID = "Image_lock_Panel_normal_Panel_item_Panel_prefab_Panel-halloweenBuffView_popUp_halloween_Game",
											UUID = "c951ecd3_761a_4c56_993d_7d1d7a833542",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											classname = "MEImage",
											dstBlendFunc = "771",
											height = "44",
											ignoreSize = "True",
											name = "Image_lock",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											texturePath = "ui/Halloween/Popup/009.png",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 689,
												PositionY = 84,
											},
											width = "44",
											ZOrder = "1",
										},
									},
								},
								{
									controlID = "Panel_activity_Panel_item_Panel_prefab_Panel-halloweenBuffView_popUp_halloween_Game",
									UUID = "efd21db1_5592_4bb4_8ea7_d288286cbfa9",
									anchorPoint = "False",
									anchorPointX = "0",
									anchorPointY = "0",
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
									name = "Panel_activity",
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
									width = "400",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "Image_bg_Panel_activity_Panel_item_Panel_prefab_Panel-halloweenBuffView_popUp_halloween_Game",
											UUID = "ec3733d8_7938_4003_af2d_1f6f9013e58c",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											classname = "MEImage",
											dstBlendFunc = "771",
											height = "108",
											ignoreSize = "True",
											name = "Image_bg",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											texturePath = "ui/Halloween/Popup/011.png",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 356,
												PositionY = 50,
											},
											width = "712",
											ZOrder = "1",
										},
										{
											controlID = "label_flag_Panel_activity_Panel_item_Panel_prefab_Panel-halloweenBuffView_popUp_halloween_Game",
											UUID = "31ba36dc_f31c_4f53_be0e_0920fba1f84b",
											anchorPoint = "False",
											anchorPointX = "1",
											anchorPointY = "0.5",
											classname = "MELabel",
											compPath = "luacomponents.common.MEIconLabel",
											dstBlendFunc = "771",
											FontColor = "#FFFFCC24",
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
											name = "label_flag",
											nTextAlign = "1",
											nTextHAlign = "1",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "770",
											text = "[ 已啟動 ]",
											touchAble = "False",
											touchScaleEnable = "False",
											UILayoutViewModel = 
											{
												PositionX = 701,
												PositionY = 84,
											},
											width = "90",
											ZOrder = "1",
										},
									},
								},
								{
									controlID = "bg_icon_Panel_item_Panel_prefab_Panel-halloweenBuffView_popUp_halloween_Game",
									UUID = "5b1eca60_5e4f_4cf1_8098_c5801e29e18e",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "96",
									ignoreSize = "True",
									name = "bg_icon",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/Halloween/Popup/007.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = 57,
										PositionY = 50,
									},
									width = "86",
									ZOrder = "1",
								},
								{
									controlID = "icon_Panel_item_Panel_prefab_Panel-halloweenBuffView_popUp_halloween_Game",
									UUID = "91c31284_df61_4afe_9d21_6b8be2e6da54",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "88",
									ignoreSize = "True",
									name = "icon",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/Halloween/Popup/BUFF/001.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = 57,
										PositionY = 49,
									},
									width = "88",
									ZOrder = "1",
								},
								{
									controlID = "Image_des_Panel_item_Panel_prefab_Panel-halloweenBuffView_popUp_halloween_Game",
									UUID = "3679b54a_9d8e_429e_95a5_942e9a660669",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "64",
									ignoreSize = "True",
									name = "Image_des",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/Halloween/Popup/008.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = 412,
										PositionY = 37,
									},
									width = "586",
									ZOrder = "1",
								},
								{
									controlID = "buff_des_Panel_item_Panel_prefab_Panel-halloweenBuffView_popUp_halloween_Game",
									UUID = "618ce362_100d_4dd3_aac8_bda40ce288a1",
									anchorPoint = "False",
									anchorPointX = "0",
									anchorPointY = "1",
									classname = "MELabel",
									compPath = "luacomponents.common.MEIconLabel",
									dstBlendFunc = "771",
									FontColor = "#FFD4C6E6",
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
									height = "50",
									ignoreSize = "False",
									name = "buff_des",
									nTextAlign = "0",
									nTextHAlign = "0",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "確認洗練將消耗洗練材料，並返還90%材料",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionX = 126,
										PositionY = 63,
									},
									width = "573",
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
			"ui/Halloween/Popup/001.png",
			"ui/Halloween/Popup/002.png",
			"ui/common/pop_ui/pop_btn_02.png",
			"ui/Halloween/Popup/010.png",
			"ui/Halloween/Popup/009.png",
			"ui/Halloween/Popup/011.png",
			"ui/Halloween/Popup/007.png",
			"ui/Halloween/Popup/BUFF/001.png",
			"ui/Halloween/Popup/008.png",
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

