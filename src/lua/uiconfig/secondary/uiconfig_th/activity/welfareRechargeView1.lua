local t = 
{
	version = 1,
	components = 
	{
		
		{
			controlID = "Panel-welfareRechargeView1_Layer1_activity_Game",
			UUID = "5ef7732b_ae29_476e_80f4_76a7d7271063",
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
			sizepercentx = "100",
			sizepercenty = "100",
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
					controlID = "Panel_root_Panel-welfareRechargeView1_Layer1_activity_Game",
					UUID = "ddcb3dc8_e90e_4338_9f6b_7f6e90ce10be",
					anchorPoint = "False",
					anchorPointX = "0.5",
					anchorPointY = "0.5",
					backGroundScale9Enable = "False",
					bgColorOpacity = "50",
					bIsOpenClipping = "False",
					classname = "MEPanel",
					colorType = "0;SingleColor:#FFFF0000;GraduallyChangingColorStart:#FFFFFFFF;GraduallyChangingColorEnd:#FFFFFFFF;vectorX:0;vectorY:0",
					DesignHeight = "640",
					DesignType = "0",
					DesignWidth = "960",
					dstBlendFunc = "771",
					height = "536",
					ignoreSize = "False",
					name = "Panel_root",
					sizepercentx = "888",
					sizepercenty = "548",
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
					width = "879",
					ZOrder = "1",
					components = 
					{
						
						{
							controlID = "Image_content_Panel_root_Panel-welfareRechargeView1_Layer1_activity_Game",
							UUID = "9e42cec7_4b44_48a8_aaf7_9c27804b7688",
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
							texturePath = "ui/activity/anniversary/welfare_01.png",
							touchAble = "True",
							UILayoutViewModel = 
							{
								
							},
							width = "926",
							ZOrder = "1",
							components = 
							{
								
								{
									controlID = "Image_flag_Image_content_Panel_root_Panel-welfareRechargeView1_Layer1_activity_Game",
									UUID = "c0248897_1460_4b0c_81b6_019d3c725a0c",
									anchorPoint = "False",
									anchorPointX = "0",
									anchorPointY = "1",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "88",
									ignoreSize = "True",
									name = "Image_flag",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/activity/anniversary/ui_013.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = -463,
										PositionY = 268,
										IsPercent = true,
										PercentX = -50,
										PercentY = 50,
									},
									width = "150",
									ZOrder = "1",
								},
								{
									controlID = "Label_timing_Image_content_Panel_root_Panel-welfareRechargeView1_Layer1_activity_Game",
									UUID = "aafbf068_ee51_4131_84ca_c7819c1ebd67",
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
									name = "Label_timing",
									nTextAlign = "1",
									nTextHAlign = "1",
									rotation = "-30",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "2018  2018",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionX = -383,
										PositionY = 209,
									},
									width = "119",
									ZOrder = "1",
								},
								{
									controlID = "ScrollView_reward_Image_content_Panel_root_Panel-welfareRechargeView1_Layer1_activity_Game",
									UUID = "a4224d91_17c0_467c_93c9_159d6a5e9baa",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									bgColorOpacity = "50",
									bIsOpenClipping = "True",
									bounceEnable = "True",
									classname = "MEScrollView",
									colorType = "0;SingleColor:#FF0000FF;GraduallyChangingColorStart:#FFFFFFFF;GraduallyChangingColorEnd:#FFFFFFFF;vectorX:0;vectorY:0",
									direction = "2",
									dstBlendFunc = "771",
									height = "80",
									ignoreSize = "False",
									innerHeight = "80",
									innerWidth = "300",
									name = "ScrollView_reward",
									showScrollbar = "False",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "True",
									UILayoutViewModel = 
									{
										PositionX = -305,
										PositionY = -199,
									},
									uipanelviewmodel = 
									{
										Layout="Absolute",
										nType = "0"
									},
									width = "300",
									ZOrder = "1",
								},
								{
									controlID = "Label_reward_title_Image_content_Panel_root_Panel-welfareRechargeView1_Layer1_activity_Game",
									UUID = "c2c0e7bd_3616_453e_80db_c8f44a144f19",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									classname = "MELabel",
									compPath = "luacomponents.common.MEIconLabel",
									dstBlendFunc = "771",
									FontColor = "#FFD65B1E",
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
									name = "Label_reward_title",
									nTextAlign = "1",
									nTextHAlign = "1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "จอแสดงผลรางวัล",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionX = -394,
										PositionY = -131,
									},
									width = "116",
									ZOrder = "1",
								},
								{
									controlID = "Image_time_bg_Image_content_Panel_root_Panel-welfareRechargeView1_Layer1_activity_Game",
									UUID = "d4b494e6_6a03_452d_9e80_1ccf1f738214",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "35",
									ignoreSize = "True",
									name = "Image_time_bg",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/activity/anniversary/welfare_03.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = 57,
										PositionY = -229,
									},
									width = "390",
									ZOrder = "1",
								},
								{
									controlID = "label_tip_Image_content_Panel_root_Panel-welfareRechargeView1_Layer1_activity_Game",
									UUID = "512f7d8f_74fb_47cc_bf0a_458b38406116",
									anchorPoint = "False",
									anchorPointX = "0",
									anchorPointY = "1",
									classname = "MELabel",
									compPath = "luacomponents.common.MEIconLabel",
									dstBlendFunc = "771",
									FontColor = "#FF4B4FC4",
									fontName = "font/fangzheng_zhunyuan.ttf",
									fontShadow = 
									{
										IsShadow = false,
										ShadowColor = "#FFFFFFFF",
										ShadowAlpha = 255,
										OffsetX = 0,
										OffsetY = 0,
									},
									fontSize = "21",
									fontStroke = 
									{
										IsStroke = false,
										StrokeColor = "#FFE6E6E6",
										StrokeSize = 1,
									},
									height = "140",
									ignoreSize = "False",
									name = "label_tip",
									nTextAlign = "0",
									nTextHAlign = "0",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionX = 138,
										PositionY = -33,
									},
									width = "320",
									ZOrder = "1",
								},
								{
									controlID = "label_buyTimes_Image_content_Panel_root_Panel-welfareRechargeView1_Layer1_activity_Game",
									UUID = "2ba84600_4648_4bbe_b7a4_a991239502d6",
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
									fontSize = "22",
									fontStroke = 
									{
										IsStroke = true,
										StrokeColor = "#FF8D5AB8",
										StrokeSize = 1,
									},
									height = "29",
									ignoreSize = "True",
									name = "label_buyTimes",
									nTextAlign = "1",
									nTextHAlign = "1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "ป้ายข้อความ",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionX = 221,
										PositionY = -230,
									},
									width = "145",
									ZOrder = "5",
								},
								{
									controlID = "Button_action_Image_content_Panel_root_Panel-welfareRechargeView1_Layer1_activity_Game",
									UUID = "e56ed191_d35b_4421_a632_016757cbab2d",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEButton",
									ClickHighLightEnabled = "True",
									dstBlendFunc = "771",
									flipX = "False",
									flipY = "False",
									height = "93",
									ignoreSize = "True",
									name = "Button_action",
									normal = "ui/activity/anniversary/welfare_02.png",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "True",
									UILayoutViewModel = 
									{
										PositionX = 331,
										PositionY = -212,
									},
									UItype = "Button",
									width = "222",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "Label_signInReceive_Button_action_Image_content_Panel_root_Panel-welfareRechargeView1_Layer1_activity_Game",
											UUID = "e527d03e_8771_4953_8b42_5ae7adbc607f",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											classname = "MELabel",
											compPath = "luacomponents.common.MEIconLabel",
											dstBlendFunc = "771",
											FontColor = "#FF6C43E2",
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
											name = "Label_signInReceive",
											nTextAlign = "1",
											nTextHAlign = "1",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "770",
											text = "รับ",
											touchAble = "False",
											touchScaleEnable = "False",
											UILayoutViewModel = 
											{
												
											},
											width = "55",
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
			"ui/activity/anniversary/welfare_01.png",
			"ui/activity/anniversary/ui_013.png",
			"ui/activity/anniversary/welfare_03.png",
			"ui/activity/anniversary/welfare_02.png",
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

