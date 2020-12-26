local t = 
{
	version = 1,
	components = 
	{
		
		{
			controlID = "Panel-downLoadingTips_Layer1_loginScene_Game",
			UUID = "4318df5a_3040_4313_aa88_7667e9a8d5ac",
			anchorPoint = "False",
			anchorPointX = "0.5",
			anchorPointY = "0.5",
			backGroundScale9Enable = "False",
			bgColorOpacity = "255",
			bIsOpenClipping = "False",
			classname = "MEPanel",
			colorType = "0;SingleColor:#FFE6E6E6;GraduallyChangingColorStart:#FFFFFFFF;GraduallyChangingColorEnd:#FFFFFFFF;vectorX:0;vectorY:0",
			DesignHeight = "640",
			DesignType = "0",
			DesignWidth = "501",
			dstBlendFunc = "771",
			height = "640",
			ignoreSize = "False",
			name = "Panel",
			sizepercentx = "44",
			sizepercenty = "30",
			sizeType = "0",
			srcBlendFunc = "1",
			touchAble = "False",
			UILayoutViewModel = 
			{
				PositionX = 568,
				PositionY = 320,
				IsPercent = true,
				PercentX = 50,
				PercentY = 50,
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
					controlID = "Image_downLoadingTips_1_Panel-downLoadingTips_Layer1_loginScene_Game",
					UUID = "a5a5d603_b4b9_4b85_88d2_49f3c333f46f",
					anchorPoint = "False",
					anchorPointX = "0.5",
					anchorPointY = "0.5",
					backGroundScale9Enable = "False",
					classname = "MEImage",
					dstBlendFunc = "771",
					height = "350",
					ignoreSize = "False",
					name = "Image_downLoadingTips_1",
					sizepercentx = "0",
					sizepercenty = "0",
					sizeType = "0",
					srcBlendFunc = "1",
					texturePath = "ui/common/pop_ui/pop_bg_01.png",
					touchAble = "False",
					UILayoutViewModel = 
					{
						IsPercent = true,
						nGravity = 1,
					},
					width = "600",
					ZOrder = "1",
					components = 
					{
						
						{
							controlID = "Image_bg_Image_downLoadingTips_1_Panel-downLoadingTips_Layer1_loginScene_Game",
							UUID = "d8f170e2_0b24_4c72_8080_dc0be9a7ec3e",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							backGroundScale9Enable = "False",
							classname = "MEImage",
							dstBlendFunc = "771",
							height = "242",
							ignoreSize = "False",
							name = "Image_bg",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							texturePath = "ui/common/pop_ui/pop_bg_02.png",
							touchAble = "False",
							UILayoutViewModel = 
							{
								PositionY = 4,
							},
							width = "575",
							ZOrder = "1",
						},
						{
							controlID = "Label_Title_Image_downLoadingTips_1_Panel-downLoadingTips_Layer1_loginScene_Game",
							UUID = "d7ed3cc0_3151_4f04_97e5_c033259b7400",
							anchorPoint = "False",
							anchorPointX = "0",
							anchorPointY = "0.5",
							classname = "MELabel",
							compPath = "luacomponents.common.MEIconLabel",
							dstBlendFunc = "771",
							FontColor = "#FF30354A",
							fontName = "font/MFLiHei_Noncommercial.ttf",
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
							name = "Label_Title",
							nTextAlign = "1",
							nTextHAlign = "1",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "770",
							text = "数据更新",
							touchAble = "False",
							touchScaleEnable = "False",
							UILayoutViewModel = 
							{
								PositionX = -284,
								PositionY = 146,
							},
							width = "122",
							ZOrder = "1",
						},
						{
							controlID = "Image_downLoadingTips_5_Image_downLoadingTips_1_Panel-downLoadingTips_Layer1_loginScene_Game",
							UUID = "374412b4_3114_416b_8a47_6711a1b040f7",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							backGroundScale9Enable = "False",
							classname = "MEImage",
							dstBlendFunc = "771",
							height = "180",
							ignoreSize = "False",
							name = "Image_downLoadingTips_5",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							texturePath = "ui/common/pop_ui/pop_bg_02.png",
							touchAble = "False",
							UILayoutViewModel = 
							{
								PositionY = 34,
							},
							visible = "False",
							width = "583",
							ZOrder = "1",
						},
						{
							controlID = "Button_close_Image_downLoadingTips_1_Panel-downLoadingTips_Layer1_loginScene_Game",
							UUID = "4d78266f_33c9_41fb_a684_adfdfda068db",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							backGroundScale9Enable = "True;capInsetsX:0;capInsetsY:0;capInsetsWidth:0;capInsetsHeight:0",
							classname = "MEButton",
							ClickHighLightEnabled = "True",
							dstBlendFunc = "771",
							flipX = "False",
							flipY = "False",
							height = "40",
							ignoreSize = "False",
							name = "Button_close",
							normal = "ui/common/pop_ui/pop_btn_01.png",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							touchAble = "True",
							UILayoutViewModel = 
							{
								PositionX = -163,
								PositionY = -141,
							},
							UItype = "Button",
							width = "200",
							ZOrder = "1",
							components = 
							{
								
								{
									controlID = "Label_downLoadingTips_1_Button_close_Image_downLoadingTips_1_Panel-downLoadingTips_Layer1_loginScene_Game",
									UUID = "2e10509a_7c2d_4451_b7cd_4ab3c74ecfd7",
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
									fontSize = "26",
									fontStroke = 
									{
										IsStroke = false,
										StrokeColor = "#FFE6E6E6",
										StrokeSize = 1,
									},
									height = "30",
									ignoreSize = "True",
									name = "Label_downLoadingTips_1",
									nTextAlign = "1",
									nTextHAlign = "1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "稍后下载",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										
									},
									width = "107",
									ZOrder = "1",
								},
							},
						},
						{
							controlID = "Button_ok_Image_downLoadingTips_1_Panel-downLoadingTips_Layer1_loginScene_Game",
							UUID = "c3976955_5292_4cec_a7f4_cdf1c20b6188",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							backGroundScale9Enable = "True;capInsetsX:0;capInsetsY:0;capInsetsWidth:0;capInsetsHeight:0",
							classname = "MEButton",
							ClickHighLightEnabled = "True",
							dstBlendFunc = "771",
							flipX = "False",
							flipY = "False",
							height = "40",
							ignoreSize = "False",
							name = "Button_ok",
							normal = "ui/common/pop_ui/pop_btn_01.png",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							touchAble = "True",
							UILayoutViewModel = 
							{
								PositionX = 168,
								PositionY = -141,
							},
							UItype = "Button",
							width = "200",
							ZOrder = "1",
							components = 
							{
								
								{
									controlID = "Label_downLoadingTips_1_Button_ok_Image_downLoadingTips_1_Panel-downLoadingTips_Layer1_loginScene_Game",
									UUID = "eea19d16_3db5_4c5e_8d26_1233cf359af1",
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
									fontSize = "26",
									fontStroke = 
									{
										IsStroke = false,
										StrokeColor = "#FFE6E6E6",
										StrokeSize = 1,
									},
									height = "30",
									ignoreSize = "True",
									name = "Label_downLoadingTips_1",
									nTextAlign = "1",
									nTextHAlign = "1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "立即下载",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										
									},
									width = "107",
									ZOrder = "1",
								},
							},
						},
						{
							controlID = "Panel_down_Image_downLoadingTips_1_Panel-downLoadingTips_Layer1_loginScene_Game",
							UUID = "f2cdd1e9_256e_4934_bc32_ce21b7069cd0",
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
							height = "238",
							ignoreSize = "False",
							name = "Panel_down",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							touchAble = "False",
							UILayoutViewModel = 
							{
								PositionX = -290,
								PositionY = -115,
								IsPercent = true,
								PercentX = -48.34,
								PercentY = -32.89,
							},
							uipanelviewmodel = 
							{
								Layout="Absolute",
								nType = "0"
							},
							width = "580",
							ZOrder = "1",
							components = 
							{
								
								{
									controlID = "size_text_Panel_down_Image_downLoadingTips_1_Panel-downLoadingTips_Layer1_loginScene_Game",
									UUID = "51b84dc6_e1ce_45c9_8a65_3846b984ae9c",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									classname = "METextArea",
									ColorMixing = "#FFEB3569",
									dstBlendFunc = "771",
									fontName = "font/fangzheng_zhunyuan.ttf",
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
									hAlignment = "1",
									height = "29",
									ignoreSize = "True",
									name = "size_text",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "266M",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionX = 235,
										PositionY = 95,
										IsPercent = true,
										PercentX = 40.63,
										PercentY = 40.11,
									},
									vAlignment = "1",
									width = "64",
									ZOrder = "1",
								},
								{
									controlID = "text_version_Panel_down_Image_downLoadingTips_1_Panel-downLoadingTips_Layer1_loginScene_Game",
									UUID = "96c9268a_0001_467c_ba4a_fcf0a488b37a",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									classname = "METextArea",
									ColorMixing = "#FF8F1033",
									dstBlendFunc = "771",
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
									hAlignment = "1",
									height = "27",
									ignoreSize = "True",
									name = "text_version",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "Update contents in patch 1025",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionX = 290,
										PositionY = 200,
										IsPercent = true,
										PercentX = 50,
										PercentY = 84.15,
									},
									vAlignment = "1",
									visible = "False",
									width = "293",
									ZOrder = "1",
								},
								{
									controlID = "text_Panel_down_Image_downLoadingTips_1_Panel-downLoadingTips_Layer1_loginScene_Game",
									UUID = "20130889_aadf_4a18_9849_6954fded570e",
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
									fontSize = "25",
									fontStroke = 
									{
										IsStroke = false,
										StrokeColor = "#FFE6E6E6",
										StrokeSize = 1,
									},
									height = "0",
									ignoreSize = "False",
									name = "text",
									nTextAlign = "1",
									nTextHAlign = "0",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "发现               可下载，是否更新？",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionX = 340,
										PositionY = 95,
									},
									width = "400",
									ZOrder = "1",
								},
								{
									controlID = "ScrollView_downLoadingTips_Panel_down_Image_downLoadingTips_1_Panel-downLoadingTips_Layer1_loginScene_Game",
									UUID = "d866a0b2_4102_4ed4_96fb_9bc9bc8642e0",
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
									height = "223",
									ignoreSize = "False",
									innerHeight = "223",
									innerWidth = "760",
									name = "ScrollView_downLoadingTips",
									showScrollbar = "False",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "True",
									UILayoutViewModel = 
									{
										PositionX = -52,
										PositionY = 8,
									},
									uipanelviewmodel = 
									{
										Layout="Absolute",
										nType = "0"
									},
									visible = "False",
									width = "760",
									ZOrder = "1",
								},
								{
									controlID = "Label_updateItem_Panel_down_Image_downLoadingTips_1_Panel-downLoadingTips_Layer1_loginScene_Game",
									UUID = "b3910f38_b727_4ed1_9bd5_53181623a51e",
									anchorPoint = "False",
									anchorPointX = "0",
									anchorPointY = "0.5",
									classname = "MELabel",
									compPath = "luacomponents.common.MEIconLabel",
									dstBlendFunc = "771",
									FontColor = "#FF30354A",
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
									name = "Label_updateItem",
									nTextAlign = "0",
									nTextHAlign = "0",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "1 Char",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionY = -45,
									},
									visible = "False",
									width = "63",
									ZOrder = "1",
								},
								{
									controlID = "Image_downLoadingTips_1_Panel_down_Image_downLoadingTips_1_Panel-downLoadingTips_Layer1_loginScene_Game",
									UUID = "5f8495e4_b9cb_4af9_9131_6df0476f77cc",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "51",
									ignoreSize = "True",
									name = "Image_downLoadingTips_1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/common/025.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = 290,
										PositionY = 167,
									},
									width = "61",
									ZOrder = "1",
								},
							},
						},
						{
							controlID = "Panel_error_Image_downLoadingTips_1_Panel-downLoadingTips_Layer1_loginScene_Game",
							UUID = "478008c7_1f62_43c2_a77a_470e7ef01dea",
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
							height = "458",
							ignoreSize = "False",
							name = "Panel_error",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							touchAble = "False",
							UILayoutViewModel = 
							{
								PositionX = -300,
								PositionY = -175,
								IsPercent = true,
								PercentX = -50,
								PercentY = -50,
							},
							uipanelviewmodel = 
							{
								Layout="Absolute",
								nType = "0"
							},
							visible = "False",
							width = "816",
							ZOrder = "1",
							components = 
							{
								
								{
									controlID = "text_Panel_error_Image_downLoadingTips_1_Panel-downLoadingTips_Layer1_loginScene_Game",
									UUID = "20d21148_27fa_448d_8bdb_8a25fe9f3c6b",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									classname = "METextArea",
									dstBlendFunc = "771",
									fontName = "font/fangzheng_zhunyuan.ttf",
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
									hAlignment = "1",
									height = "30",
									ignoreSize = "True",
									name = "text",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "更新资源失败是否重试",
									touchAble = "False",
									touchScaleEnable = "True",
									UILayoutViewModel = 
									{
										PositionX = 308,
										PositionY = 109,
										IsPercent = true,
										PercentX = 37.77,
										PercentY = 23.83,
									},
									vAlignment = "1",
									width = "263",
									ZOrder = "1",
								},
								{
									controlID = "Image_downLoadingTips_1_Panel_error_Image_downLoadingTips_1_Panel-downLoadingTips_Layer1_loginScene_Game",
									UUID = "5f507539_0a25_4264_8972_085213312250",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "51",
									ignoreSize = "True",
									name = "Image_downLoadingTips_1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/common/025.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = 296,
										PositionY = 199,
									},
									width = "61",
									ZOrder = "1",
								},
							},
						},
						{
							controlID = "Image_loginLayer_1_Image_downLoadingTips_1_Panel-downLoadingTips_Layer1_loginScene_Game",
							UUID = "d7f05c18_6ab1_4e85_a4d6_4abb2ceae01f",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							backGroundScale9Enable = "False",
							classname = "MEImage",
							dstBlendFunc = "771",
							height = "14",
							ignoreSize = "True",
							name = "Image_loginLayer_1",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							texturePath = "ui/common/pop_ui/pop_ui_01.png",
							touchAble = "False",
							UILayoutViewModel = 
							{
								PositionX = -133,
								PositionY = 192,
							},
							visible = "False",
							width = "14",
							ZOrder = "1",
						},
						{
							controlID = "Image_fubenReadyView_1_Image_downLoadingTips_1_Panel-downLoadingTips_Layer1_loginScene_Game",
							UUID = "b5f123bc_dd67_4abf_9a04_2ef5d6e61a36",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							backGroundScale9Enable = "False",
							classname = "MEImage",
							dstBlendFunc = "771",
							height = "26",
							ignoreSize = "True",
							name = "Image_fubenReadyView_1",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "770",
							texturePath = "ui/common/pop_ui/pop_ui_02.png",
							touchAble = "False",
							UILayoutViewModel = 
							{
								PositionX = -149,
								PositionY = 197,
							},
							visible = "False",
							width = "2",
							ZOrder = "1",
						},
						{
							controlID = "Label_englishName_Image_downLoadingTips_1_Panel-downLoadingTips_Layer1_loginScene_Game",
							UUID = "608257da_d78f_4a99_86df_b4fce3f68875",
							anchorPoint = "False",
							anchorPointX = "0",
							anchorPointY = "0.5",
							classname = "MELabel",
							compPath = "luacomponents.common.MEIconLabel",
							dstBlendFunc = "771",
							FontColor = "#FF30354A",
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
							name = "Label_englishName",
							nTextAlign = "1",
							nTextHAlign = "1",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "770",
							text = "Version Update",
							touchAble = "False",
							touchScaleEnable = "False",
							UILayoutViewModel = 
							{
								PositionX = -143,
								PositionY = 192,
							},
							visible = "False",
							width = "102",
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
			"ui/common/pop_ui/pop_bg_01.png",
			"ui/common/pop_ui/pop_bg_02.png",
			"ui/common/pop_ui/pop_btn_01.png",
			"ui/common/025.png",
			"ui/common/pop_ui/pop_ui_01.png",
			"ui/common/pop_ui/pop_ui_02.png",
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

