local t = 
{
	version = 1,
	components = 
	{
		
		{
			controlID = "Panel-allServerAssistanceActivity_allServerAssistance_activity_Game",
			UUID = "636a48cb_1590_4e41_8fb7_bf104547f6b9",
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
			height = "534",
			ignoreSize = "False",
			name = "Panel",
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
			width = "924",
			ZOrder = "1",
			components = 
			{
				
				{
					controlID = "Panel_base_Panel-allServerAssistanceActivity_allServerAssistance_activity_Game",
					UUID = "b3a26db2_f7f6_4dce_ae16_9bb7ca3e8354",
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
					height = "534",
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
						nGravity = 6,
						nAlign = 5
					},
					uipanelviewmodel = 
					{
						Layout="Absolute",
						nType = "0"
					},
					width = "924",
					ZOrder = "1",
					components = 
					{
						
						{
							controlID = "bg_Panel_base_Panel-allServerAssistanceActivity_allServerAssistance_activity_Game",
							UUID = "d9d6dcc3_0b39_4b51_b9f9_f7dd3b3bb93c",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							backGroundScale9Enable = "False",
							classname = "MEImage",
							dstBlendFunc = "771",
							height = "546",
							ignoreSize = "True",
							name = "bg",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							texturePath = "ui/activity/allServerAssistance/main/bgActivity.png",
							touchAble = "False",
							UILayoutViewModel = 
							{
								
							},
							width = "890",
							ZOrder = "1",
						},
						{
							controlID = "Label_allServerAssistanceActivity_1_Panel_base_Panel-allServerAssistanceActivity_allServerAssistance_activity_Game",
							UUID = "b997fe85_1f35_4aa5_b504_2bea086f9c22",
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
							fontSize = "12",
							fontStroke = 
							{
								IsStroke = false,
								StrokeColor = "#FFE6E6E6",
								StrokeSize = 1,
							},
							height = "14",
							ignoreSize = "True",
							name = "Label_allServerAssistanceActivity_1",
							nTextAlign = "1",
							nTextHAlign = "1",
							rotation = "-13",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "770",
							text = "time",
							touchAble = "False",
							touchScaleEnable = "False",
							UILayoutViewModel = 
							{
								PositionX = -409,
								PositionY = 259,
							},
							width = "24",
							ZOrder = "1",
						},
						{
							controlID = "label_timeTxt_Panel_base_Panel-allServerAssistanceActivity_allServerAssistance_activity_Game",
							UUID = "9adf8b8c_8bdc_45fe_8f8b_c77eedaaf6e5",
							anchorPoint = "False",
							anchorPointX = "0",
							anchorPointY = "0.5",
							classname = "MELabel",
							compPath = "luacomponents.common.MEIconLabel",
							dstBlendFunc = "771",
							FontColor = "#FF1A1D2B",
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
							height = "27",
							ignoreSize = "True",
							name = "label_timeTxt",
							nTextAlign = "1",
							nTextHAlign = "0",
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
								PositionX = -398,
								PositionY = 239,
							},
							width = "90",
							ZOrder = "1",
						},
						{
							controlID = "label_timeBegin_Panel_base_Panel-allServerAssistanceActivity_allServerAssistance_activity_Game",
							UUID = "0f3b5fd4_80cc_49e8_ac64_3d091c440863",
							anchorPoint = "False",
							anchorPointX = "0",
							anchorPointY = "0.5",
							classname = "MELabel",
							compPath = "luacomponents.common.MEIconLabel",
							dstBlendFunc = "771",
							FontColor = "#FF1A1D2B",
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
							height = "22",
							ignoreSize = "True",
							name = "label_timeBegin",
							nTextAlign = "1",
							nTextHAlign = "0",
							rotation = "-12",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "770",
							text = "2002454545",
							touchAble = "False",
							touchScaleEnable = "False",
							UILayoutViewModel = 
							{
								PositionX = -415,
								PositionY = 214,
							},
							width = "155",
							ZOrder = "1",
						},
						{
							controlID = "label_timeEnd_Panel_base_Panel-allServerAssistanceActivity_allServerAssistance_activity_Game",
							UUID = "3928860c_c1f8_4ff5_8a2a_0e4d92906d7a",
							anchorPoint = "False",
							anchorPointX = "0",
							anchorPointY = "0.5",
							classname = "MELabel",
							compPath = "luacomponents.common.MEIconLabel",
							dstBlendFunc = "771",
							FontColor = "#FF1A1D2B",
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
							height = "22",
							ignoreSize = "True",
							name = "label_timeEnd",
							nTextAlign = "1",
							nTextHAlign = "0",
							rotation = "-12",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "770",
							text = "2002454545",
							touchAble = "False",
							touchScaleEnable = "False",
							UILayoutViewModel = 
							{
								PositionX = -430,
								PositionY = 192,
							},
							width = "155",
							ZOrder = "1",
						},
						{
							controlID = "Button_go_Panel_base_Panel-allServerAssistanceActivity_allServerAssistance_activity_Game",
							UUID = "d88efee0_fd38_4d01_b15f_a924fd3d0e12",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							backGroundScale9Enable = "False",
							classname = "MEButton",
							ClickHighLightEnabled = "True",
							dstBlendFunc = "771",
							flipX = "False",
							flipY = "False",
							height = "160",
							ignoreSize = "True",
							name = "Button_go",
							normal = "ui/activity/allServerAssistance/main/btn.png",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							touchAble = "True",
							UILayoutViewModel = 
							{
								PositionX = -11,
								PositionY = -174,
							},
							UItype = "Button",
							width = "172",
							ZOrder = "1",
							components = 
							{
								
								{
									controlID = "Spine_btn1_Button_go_Panel_base_Panel-allServerAssistanceActivity_allServerAssistance_activity_Game",
									UUID = "cfb17aaa_fc56_403f_b2d2_87a1f268a930",
									classname = "MESpine",
									dstBlendFunc = "771",
									name = "Spine_btn1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									spineModel = 
									{
										SpinePath = "effect/eff_quanfuyingyuan/effects_yingyuan",
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
										PositionX = -1,
										PositionY = 6,
									},
									ZOrder = "1",
								},
								{
									controlID = "lab_go_Button_go_Panel_base_Panel-allServerAssistanceActivity_allServerAssistance_activity_Game",
									UUID = "b36c48ff_231c_4ffb_8d33_ebb3fa17f37d",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									classname = "MELabel",
									compPath = "luacomponents.common.MEIconLabel",
									dstBlendFunc = "771",
									FontColor = "#FF242C54",
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
									height = "79",
									ignoreSize = "False",
									name = "lab_go",
									nTextAlign = "1",
									nTextHAlign = "1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "应援",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionX = -2,
										PositionY = 13,
									},
									visible = "False",
									width = "79",
									ZOrder = "1",
								},
							},
						},
						{
							controlID = "Label_allServerAssistanceActivity_2_Panel_base_Panel-allServerAssistanceActivity_allServerAssistance_activity_Game",
							UUID = "7ebc69f3_6504_437d_b7db_b95dbba0ed42",
							anchorPoint = "False",
							anchorPointX = "0",
							anchorPointY = "0.5",
							classname = "MELabel",
							compPath = "luacomponents.common.MEIconLabel",
							dstBlendFunc = "771",
							FontColor = "#FF3F4669",
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
							name = "Label_allServerAssistanceActivity_2",
							nTextAlign = "1",
							nTextHAlign = "1",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "770",
							text = "我的积分：",
							touchAble = "False",
							touchScaleEnable = "False",
							UILayoutViewModel = 
							{
								PositionX = -430,
								PositionY = -243,
							},
							width = "90",
							ZOrder = "1",
							components = 
							{
								
								{
									controlID = "lab_myScore_Label_allServerAssistanceActivity_2_Panel_base_Panel-allServerAssistanceActivity_allServerAssistance_activity_Game",
									UUID = "a180c830_7c7a_4c0b_bf75_5dc7c1a48f2e",
									anchorPoint = "False",
									anchorPointX = "0",
									anchorPointY = "0.5",
									classname = "MELabel",
									compPath = "luacomponents.common.MEIconLabel",
									dstBlendFunc = "771",
									FontColor = "#FF3F4669",
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
									name = "lab_myScore",
									nTextAlign = "1",
									nTextHAlign = "1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "562348",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionX = 98,
									},
									width = "103",
									ZOrder = "1",
								},
							},
						},
						{
							controlID = "btn_ques_Panel_base_Panel-allServerAssistanceActivity_allServerAssistance_activity_Game",
							UUID = "e1bb39a8_c582_47a3_92cf_07645b1d53ea",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							backGroundScale9Enable = "False",
							classname = "MEButton",
							ClickHighLightEnabled = "True",
							dstBlendFunc = "771",
							flipX = "False",
							flipY = "False",
							height = "72",
							ignoreSize = "True",
							name = "btn_ques",
							normal = "ui/activity/allServerAssistance/main/btn1.png",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							touchAble = "True",
							UILayoutViewModel = 
							{
								PositionX = 356,
								PositionY = 230,
							},
							UItype = "Button",
							width = "78",
							ZOrder = "1",
							components = 
							{
								
								{
									controlID = "Spine_btn2_btn_ques_Panel_base_Panel-allServerAssistanceActivity_allServerAssistance_activity_Game",
									UUID = "7f76753d_ee2d_465b_b924_6bd5338d9bea",
									classname = "MESpine",
									dstBlendFunc = "771",
									name = "Spine_btn2",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									spineModel = 
									{
										SpinePath = "effect/eff_quanfuyingyuan/eff_quanfuyingyuan",
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
			"ui/activity/allServerAssistance/main/bgActivity.png",
			"ui/activity/allServerAssistance/main/btn.png",
			"ui/activity/allServerAssistance/main/btn1.png",
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

