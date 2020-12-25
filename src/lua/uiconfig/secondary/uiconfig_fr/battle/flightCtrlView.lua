local t = 
{
	version = 1,
	components = 
	{
		
		{
			controlID = "Panel-flightCtrlView_ui_battle_Game",
			UUID = "9c6136e3_853f_44a7_8351_3e07c4e7ce15",
			anchorPoint = "False",
			anchorPointX = "0",
			anchorPointY = "0",
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
					controlID = "Panel_base_Panel-flightCtrlView_ui_battle_Game",
					UUID = "7fbf0e18_c9ce_4a16_a096_19adcb684031",
					anchorPoint = "False",
					anchorPointX = "0",
					anchorPointY = "0",
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
					sizepercentx = "100",
					sizepercenty = "100",
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
						Layout="Relative",
						nType = "3"
					},
					width = "1136",
					ZOrder = "1",
					components = 
					{
						
						{
							controlID = "Panel_roke_touch_Panel_base_Panel-flightCtrlView_ui_battle_Game",
							UUID = "34dbedee_06ff_4dbe_91df_cf5bac6d614b",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							backGroundScale9Enable = "False",
							bgColorOpacity = "80",
							bIsOpenClipping = "False",
							classname = "MEPanel",
							colorType = "0;SingleColor:#FFF0F8FF;GraduallyChangingColorStart:#FFFFFFFF;GraduallyChangingColorEnd:#FFFFFFFF;vectorX:0;vectorY:0",
							DesignHeight = "640",
							DesignType = "0",
							DesignWidth = "960",
							dstBlendFunc = "771",
							height = "400",
							ignoreSize = "False",
							name = "Panel_roke_touch",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							touchAble = "False",
							UILayoutViewModel = 
							{
								PositionX = 155,
								PositionY = 170,
								LeftPositon = -120,
								BottomPosition = -30,
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
							width = "550",
							ZOrder = "1",
							components = 
							{
								
								{
									controlID = "Image_roker_Panel_roke_touch_Panel_base_Panel-flightCtrlView_ui_battle_Game",
									UUID = "03e679f8_0d1d_4bec_998f_b951855e2ece",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "200",
									ignoreSize = "True",
									name = "Image_roker",
									scaleX = "0.66",
									scaleY = "0.66",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/battle/048.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										LeftPositon = 27,
										BottomPosition = 100,
										relativeToName = "Panel",
										nGravity = 4,
										nAlign = 7
									},
									width = "200",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "Image_ctrl_Image_roker_Panel_roke_touch_Panel_base_Panel-flightCtrlView_ui_battle_Game",
											UUID = "1026e475_47b4_4f25_b2d6_f31353f95d82",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											classname = "MEImage",
											dstBlendFunc = "771",
											height = "200",
											ignoreSize = "True",
											name = "Image_ctrl",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											texturePath = "ui/battle/047.png",
											touchAble = "False",
											UILayoutViewModel = 
											{
												
											},
											width = "200",
											ZOrder = "1",
										},
										{
											controlID = "Button_ctrl_Image_roker_Panel_roke_touch_Panel_base_Panel-flightCtrlView_ui_battle_Game",
											UUID = "8608c8a0_9c70_457b_a93a_3729f223db55",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											classname = "MEImage",
											dstBlendFunc = "771",
											height = "80",
											ignoreSize = "True",
											name = "Button_ctrl",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											texturePath = "ui/battle/046.png",
											touchAble = "False",
											UILayoutViewModel = 
											{
												
											},
											width = "80",
											ZOrder = "1",
										},
									},
								},
							},
						},
						{
							controlID = "Button_ctrlA_bg_Panel_base_Panel-flightCtrlView_ui_battle_Game",
							UUID = "d8eeea37_2f07_41be_a5d3_c8615d710393",
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
							height = "150",
							ignoreSize = "False",
							name = "Button_ctrlA_bg",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							touchAble = "True",
							UILayoutViewModel = 
							{
								PositionX = 1028,
								PositionY = 96,
								RightPosition = 33,
								BottomPosition = 21,
								relativeToName = "Panel_base",
								nType = 3,
								nGravity = 3,
								nAlign = 9
							},
							uipanelviewmodel = 
							{
								Layout="Absolute",
								nType = "0"
							},
							width = "150",
							ZOrder = "1",
							components = 
							{
								
								{
									controlID = "Button_ctrlA_Button_ctrlA_bg_Panel_base_Panel-flightCtrlView_ui_battle_Game",
									UUID = "435c37a7_2fbc_4e3b_840b_ce13147b06db",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEButton",
									ClickHighLightEnabled = "True",
									dstBlendFunc = "771",
									flipX = "False",
									flipY = "False",
									height = "120",
									HitType = 
									{
										nHitType = 3,
									},
									ignoreSize = "True",
									name = "Button_ctrlA",
									normal = "ui/battle/flight/010.png",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "True",
									UILayoutViewModel = 
									{
										RightPosition = 5,
										BottomPosition = 107,
										relativeToName = "Panel",
										nGravity = 3,
										nAlign = 9
									},
									UItype = "Button",
									width = "118",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "Image_icon_Button_ctrlA_Button_ctrlA_bg_Panel_base_Panel-flightCtrlView_ui_battle_Game",
											UUID = "cb49ae03_498c_42b5_843b_f663fe20b136",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											classname = "MEImage",
											dstBlendFunc = "771",
											height = "110",
											ignoreSize = "True",
											name = "Image_icon",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											texturePath = "icon/skill/10101_skillG.png",
											touchAble = "False",
											UILayoutViewModel = 
											{
												relativeToName = "Panel",
											},
											width = "110",
											ZOrder = "1",
										},
										{
											controlID = "Image_mask_Button_ctrlA_Button_ctrlA_bg_Panel_base_Panel-flightCtrlView_ui_battle_Game",
											UUID = "605b02a4_890b_46db_9f95_5c97c1c3d934",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											classname = "MEImage",
											dstBlendFunc = "771",
											height = "106",
											ignoreSize = "True",
											name = "Image_mask",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											texturePath = "ui/battle/flight/009.png",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = -2,
												relativeToName = "Panel",
											},
											width = "104",
											ZOrder = "1",
										},
										{
											controlID = "Label_cdTime_Button_ctrlA_Button_ctrlA_bg_Panel_base_Panel-flightCtrlView_ui_battle_Game",
											UUID = "aa813ca6_d265_4798_8e54_90ccf5f24d04",
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
												IsStroke = false,
												StrokeColor = "#FFE6E6E6",
												StrokeSize = 1,
											},
											height = "25",
											ignoreSize = "True",
											name = "Label_cdTime",
											nTextAlign = "1",
											nTextHAlign = "1",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "770",
											text = "22.0",
											touchAble = "False",
											touchScaleEnable = "False",
											UILayoutViewModel = 
											{
												
											},
											width = "45",
											ZOrder = "1",
										},
									},
								},
							},
						},
						{
							controlID = "Button_ctrlB_bg_Panel_base_Panel-flightCtrlView_ui_battle_Game",
							UUID = "90ff423e_46b3_4ef2_9697_39915437ad4b",
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
							height = "150",
							ignoreSize = "False",
							name = "Button_ctrlB_bg",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							touchAble = "True",
							UILayoutViewModel = 
							{
								PositionX = 861,
								PositionY = 80,
								RightPosition = 200,
								BottomPosition = 5,
								relativeToName = "Panel_base",
								nType = 3,
								nGravity = 3,
								nAlign = 9
							},
							uipanelviewmodel = 
							{
								Layout="Absolute",
								nType = "0"
							},
							width = "150",
							ZOrder = "1",
							components = 
							{
								
								{
									controlID = "Button_ctrlB_Button_ctrlB_bg_Panel_base_Panel-flightCtrlView_ui_battle_Game",
									UUID = "655ac834_56f4_4549_98bf_dcfc8be9161c",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEButton",
									ClickHighLightEnabled = "True",
									dstBlendFunc = "771",
									flipX = "False",
									flipY = "False",
									height = "120",
									HitType = 
									{
										nHitType = 3,
									},
									ignoreSize = "True",
									name = "Button_ctrlB",
									normal = "ui/battle/flight/010.png",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "True",
									UILayoutViewModel = 
									{
										RightPosition = 5,
										BottomPosition = 107,
										relativeToName = "Panel",
										nGravity = 3,
										nAlign = 9
									},
									UItype = "Button",
									width = "118",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "Image_icon_Button_ctrlB_Button_ctrlB_bg_Panel_base_Panel-flightCtrlView_ui_battle_Game",
											UUID = "59138934_e845_48cd_a170_f4286232cd65",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											classname = "MEImage",
											dstBlendFunc = "771",
											height = "110",
											ignoreSize = "True",
											name = "Image_icon",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											texturePath = "icon/skill/10101_skillG.png",
											touchAble = "False",
											UILayoutViewModel = 
											{
												relativeToName = "Panel",
											},
											width = "110",
											ZOrder = "1",
										},
										{
											controlID = "Image_mask_Button_ctrlB_Button_ctrlB_bg_Panel_base_Panel-flightCtrlView_ui_battle_Game",
											UUID = "d606e26f_470c_4a14_951b_7af29a79c63e",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											classname = "MEImage",
											dstBlendFunc = "771",
											height = "106",
											ignoreSize = "True",
											name = "Image_mask",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											texturePath = "ui/battle/flight/009.png",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = -2,
												relativeToName = "Panel",
											},
											width = "104",
											ZOrder = "1",
										},
										{
											controlID = "Label_cdTime_Button_ctrlB_Button_ctrlB_bg_Panel_base_Panel-flightCtrlView_ui_battle_Game",
											UUID = "ec7ffe11_ead9_4fca_9b7e_765958c6c44f",
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
												IsStroke = false,
												StrokeColor = "#FFE6E6E6",
												StrokeSize = 1,
											},
											height = "25",
											ignoreSize = "True",
											name = "Label_cdTime",
											nTextAlign = "1",
											nTextHAlign = "1",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "770",
											text = "22.0",
											touchAble = "False",
											touchScaleEnable = "False",
											UILayoutViewModel = 
											{
												
											},
											width = "45",
											ZOrder = "1",
										},
									},
								},
							},
						},
					},
				},
				{
					controlID = "Panel_pause_Panel-flightCtrlView_ui_battle_Game",
					UUID = "7ce33f28_d14d_4b0d_ae88_2ef5c106adb0",
					anchorPoint = "False",
					anchorPointX = "0",
					anchorPointY = "0",
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
					name = "Panel_pause",
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
						Layout="Relative",
						nType = "3"
					},
					width = "1136",
					ZOrder = "1",
					components = 
					{
						
						{
							controlID = "Button_pause_Panel_pause_Panel-flightCtrlView_ui_battle_Game",
							UUID = "d60c33e1_eb8f_4cb7_9ff5_38b7bb60f306",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							backGroundScale9Enable = "False",
							classname = "MEButton",
							ClickHighLightEnabled = "True",
							dstBlendFunc = "771",
							flipX = "False",
							flipY = "False",
							height = "50",
							ignoreSize = "True",
							name = "Button_pause",
							normal = "ui/battle/023.png",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							touchAble = "True",
							UILayoutViewModel = 
							{
								PositionX = 1079,
								PositionY = 615,
								RightPosition = 32,
								relativeToName = "Panel_ui",
								nType = 3,
								nGravity = 3,
								nAlign = 3
							},
							UItype = "Button",
							width = "50",
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
			"ui/battle/048.png",
			"ui/battle/047.png",
			"ui/battle/046.png",
			"ui/battle/flight/010.png",
			"icon/skill/10101_skillG.png",
			"ui/battle/flight/009.png",
			"ui/battle/023.png",
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

