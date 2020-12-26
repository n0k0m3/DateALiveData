local t = 
{
	version = 1,
	components = 
	{
		
		{
			controlID = "Panel-welfareRechargeView_Layer1_activity_Game",
			UUID = "44e9da21_4336_4242_90ee_c553d66e0d99",
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
					controlID = "Panel_root_Panel-welfareRechargeView_Layer1_activity_Game",
					UUID = "2c910f5b_34f5_4ff0_8f06_0e2b83500900",
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
							controlID = "Image_content_Panel_root_Panel-welfareRechargeView_Layer1_activity_Game",
							UUID = "7276892b_9ad8_43be_b003_f73c3b08c12f",
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
							texturePath = "ui/activity/activity_bg/a1.png",
							touchAble = "True",
							UILayoutViewModel = 
							{
								
							},
							width = "924",
							ZOrder = "1",
							components = 
							{
								
								{
									controlID = "ScrollView_reward_Image_content_Panel_root_Panel-welfareRechargeView_Layer1_activity_Game",
									UUID = "c88b779d_3e0b_4399_8936_bfb0c7ace089",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									bgColorOpacity = "50",
									bIsOpenClipping = "False",
									bounceEnable = "False",
									classname = "MEScrollView",
									colorType = "0;SingleColor:#FF0000FF;GraduallyChangingColorStart:#FFFFFFFF;GraduallyChangingColorEnd:#FFFFFFFF;vectorX:0;vectorY:0",
									direction = "2",
									dstBlendFunc = "771",
									height = "80",
									ignoreSize = "False",
									innerHeight = "80",
									innerWidth = "345",
									name = "ScrollView_reward",
									showScrollbar = "False",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = -280,
										PositionY = -213,
									},
									uipanelviewmodel = 
									{
										Layout="Absolute",
										nType = "0"
									},
									width = "345",
									ZOrder = "1",
								},
								{
									controlID = "label_tip_Image_content_Panel_root_Panel-welfareRechargeView_Layer1_activity_Game",
									UUID = "011bc2fb_7e87_48c3_8521_c3af45f43660",
									anchorPoint = "False",
									anchorPointX = "0",
									anchorPointY = "1",
									classname = "MELabel",
									compPath = "luacomponents.common.MEIconLabel",
									dstBlendFunc = "771",
									FontColor = "#FFD2F7FF",
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
									height = "0",
									ignoreSize = "False",
									name = "label_tip",
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
										PositionX = 63,
										PositionY = 27,
									},
									width = "355",
									ZOrder = "1",
								},
								{
									controlID = "label_buyTimes_Image_content_Panel_root_Panel-welfareRechargeView_Layer1_activity_Game",
									UUID = "2f2a5578_7c85_4c7d_a4ce_1ac958ae067d",
									anchorPoint = "False",
									anchorPointX = "0",
									anchorPointY = "0.5",
									classname = "MELabel",
									compPath = "luacomponents.common.MEIconLabel",
									dstBlendFunc = "771",
									FontColor = "#FF557588",
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
									name = "label_buyTimes",
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
										PositionX = 254,
										PositionY = -175,
									},
									width = "144",
									ZOrder = "1",
								},
								{
									controlID = "label_hdts_Image_content_Panel_root_Panel-welfareRechargeView_Layer1_activity_Game",
									UUID = "48d4c90b_f897_42ea_8af6_5facd0961cfa",
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
									height = "0",
									ignoreSize = "False",
									name = "label_hdts",
									nTextAlign = "1",
									nTextHAlign = "1",
									rotation = "16",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "Erinnerung",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionX = 390,
										PositionY = 65,
									},
									width = "53",
									ZOrder = "1",
								},
							},
						},
						{
							controlID = "Button_action_Panel_root_Panel-welfareRechargeView_Layer1_activity_Game",
							UUID = "9ec8dcf2_da22_4f87_aa21_a54cca83b9e8",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							backGroundScale9Enable = "False",
							classname = "MEButton",
							ClickHighLightEnabled = "True",
							dstBlendFunc = "771",
							flipX = "False",
							flipY = "False",
							height = "54",
							ignoreSize = "True",
							name = "Button_action",
							normal = "ui/common/button_noframe.png",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							touchAble = "True",
							UILayoutViewModel = 
							{
								PositionX = 360,
								PositionY = -221,
							},
							UItype = "Button",
							width = "164",
							ZOrder = "1",
							components = 
							{
								
								{
									controlID = "Label_signInReceive_Button_action_Panel_root_Panel-welfareRechargeView_Layer1_activity_Game",
									UUID = "65dc1b40_2a13_44f0_b91c_a43f3a00f8a3",
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
									text = "Abholen",
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
	actions = 
	{
		
	},
	respaths = 
	{
		textures = 
		{
			"ui/activity/activity_bg/a1.png",
			"ui/common/button_noframe.png",
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

