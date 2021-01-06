local t = 
{
	version = 1,
	components = 
	{
		
		{
			controlID = "Panel-pushGiftRegression_Layer1_recharge_Game",
			UUID = "450db711_ddaa_4ad2_bb36_1968de062358",
			anchorPoint = "False",
			anchorPointX = "0",
			anchorPointY = "0",
			backGroundScale9Enable = "False",
			bgColorOpacity = "50",
			bIsOpenClipping = "False",
			classname = "MEPanel",
			colorType = "0;SingleColor:#FFFF4500;GraduallyChangingColorStart:#FFFFFFFF;GraduallyChangingColorEnd:#FFFFFFFF;vectorX:0;vectorY:0",
			DesignHeight = "640",
			DesignType = "0",
			DesignWidth = "960",
			dstBlendFunc = "771",
			height = "640",
			ignoreSize = "False",
			name = "Panel",
			sizepercentx = "100",
			sizepercenty = "100",
			sizeType = "1",
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
			width = "1136",
			ZOrder = "1",
			components = 
			{
				
				{
					controlID = "Panel_root_Panel-pushGiftRegression_Layer1_recharge_Game",
					UUID = "e0ad6b43_d8bd_432a_afe1_e21b1c256f0f",
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
					height = "640",
					ignoreSize = "False",
					name = "Panel_root",
					sizepercentx = "100",
					sizepercenty = "100",
					sizeType = "1",
					srcBlendFunc = "1",
					touchAble = "False",
					UILayoutViewModel = 
					{
						PositionX = 568,
						PositionY = 320,
						IsPercent = true,
						PercentX = 50,
						PercentY = 50,
						relativeToName = "Panel",
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
							controlID = "Image_diban_Panel_root_Panel-pushGiftRegression_Layer1_recharge_Game",
							UUID = "699a71e0_b512_4ffe_976b_2eeecae8ffb3",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							backGroundScale9Enable = "False",
							classname = "MEImage",
							dstBlendFunc = "771",
							height = "541",
							ignoreSize = "True",
							name = "Image_diban",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							texturePath = "ui/recharge/gifts/regression/3.png",
							touchAble = "False",
							UILayoutViewModel = 
							{
								relativeToName = "Panel",
								nGravity = 6,
								nAlign = 5
							},
							width = "795",
							ZOrder = "1",
						},
						{
							controlID = "Button_close_Panel_root_Panel-pushGiftRegression_Layer1_recharge_Game",
							UUID = "3737749a_486a_46f6_8078_599db6d532d6",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							backGroundScale9Enable = "False",
							classname = "MEButton",
							ClickHighLightEnabled = "True",
							dstBlendFunc = "771",
							flipX = "False",
							flipY = "False",
							height = "78",
							ignoreSize = "True",
							name = "Button_close",
							normal = "ui/recharge/gifts/regression/2.png",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							touchAble = "True",
							UILayoutViewModel = 
							{
								PositionX = 263,
								PositionY = 182,
							},
							UItype = "Button",
							width = "94",
							ZOrder = "1",
						},
						{
							controlID = "ImageDescript_Panel_root_Panel-pushGiftRegression_Layer1_recharge_Game",
							UUID = "2fd65265_165e_4edd_917a_a3eeea99a861",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							backGroundScale9Enable = "False",
							classname = "MEImage",
							dstBlendFunc = "771",
							height = "118",
							ignoreSize = "True",
							name = "ImageDescript",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							texturePath = "ui/recharge/gifts/regression/1.png",
							touchAble = "False",
							UILayoutViewModel = 
							{
								PositionX = -267,
								PositionY = 195,
							},
							width = "204",
							ZOrder = "1",
							components = 
							{
								
								{
									controlID = "DesLabel_ImageDescript_Panel_root_Panel-pushGiftRegression_Layer1_recharge_Game",
									UUID = "21c51ea8_334e_4bf9_9544_03656f6d09e4",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									classname = "MELabel",
									compPath = "luacomponents.common.MEIconLabel",
									dstBlendFunc = "771",
									FontColor = "#FF32436C",
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
									height = "50",
									ignoreSize = "False",
									name = "DesLabel",
									nTextAlign = "1",
									nTextHAlign = "1",
									rotation = "-4",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "Description",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionX = 1,
										PositionY = 6,
									},
									width = "120",
									ZOrder = "1",
								},
							},
						},
						{
							controlID = "giftName_Panel_root_Panel-pushGiftRegression_Layer1_recharge_Game",
							UUID = "e642c621_ae64_4901_87e1_9971e7be5a79",
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
							fontSize = "25",
							fontStroke = 
							{
								IsStroke = false,
								StrokeColor = "#FFE6E6E6",
								StrokeSize = 1,
							},
							height = "0",
							ignoreSize = "False",
							name = "giftName",
							nTextAlign = "1",
							nTextHAlign = "1",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "770",
							text = "Pack Name",
							touchAble = "False",
							touchScaleEnable = "False",
							UILayoutViewModel = 
							{
								PositionX = -211,
								PositionY = -77,
							},
							width = "230",
							ZOrder = "1",
						},
						{
							controlID = "gifts_Panel_root_Panel-pushGiftRegression_Layer1_recharge_Game",
							UUID = "3e4b2848_5bb7_4e10_8fe4_eb9cf1378523",
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
							height = "0",
							ignoreSize = "False",
							name = "gifts",
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
							width = "0",
							ZOrder = "1",
							components = 
							{
								
								{
									controlID = "gift1_gifts_Panel_root_Panel-pushGiftRegression_Layer1_recharge_Game",
									UUID = "dfe098c3_2271_4a06_a153_b1f75f8ccdeb",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "64",
									ignoreSize = "True",
									name = "gift1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = 130,
										PositionY = 110,
									},
									width = "64",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "price_gift1_gifts_Panel_root_Panel-pushGiftRegression_Layer1_recharge_Game",
											UUID = "398c3383_6c0a_48fa_90b7_585a269554c8",
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
											fontSize = "24",
											fontStroke = 
											{
												IsStroke = false,
												StrokeColor = "#FFE6E6E6",
												StrokeSize = 1,
											},
											height = "27",
											ignoreSize = "True",
											name = "price",
											nTextAlign = "1",
											nTextHAlign = "1",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "770",
											text = "12000",
											touchAble = "False",
											touchScaleEnable = "False",
											UILayoutViewModel = 
											{
												PositionX = -2,
												PositionY = -69,
											},
											width = "67",
											ZOrder = "1",
										},
									},
								},
								{
									controlID = "empty_2_gifts_Panel_root_Panel-pushGiftRegression_Layer1_recharge_Game",
									UUID = "a2122f90_5ab8_4f62_a48b_f26e5c5ba112",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "186",
									ignoreSize = "True",
									name = "empty_2",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/recharge/gifts/regression/empty_1.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = 241,
										PositionY = 66,
									},
									visible = "False",
									width = "216",
									ZOrder = "1",
								},
								{
									controlID = "gift2_gifts_Panel_root_Panel-pushGiftRegression_Layer1_recharge_Game",
									UUID = "9cec8541_ae2a_4bcc_94f9_af6f93711e82",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "64",
									ignoreSize = "True",
									name = "gift2",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = 240,
										PositionY = 38,
									},
									width = "64",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "price_gift2_gifts_Panel_root_Panel-pushGiftRegression_Layer1_recharge_Game",
											UUID = "8b4bbfcf_814b_4e79_b7ef_b705799bba0b",
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
											fontSize = "24",
											fontStroke = 
											{
												IsStroke = false,
												StrokeColor = "#FFE6E6E6",
												StrokeSize = 1,
											},
											height = "27",
											ignoreSize = "True",
											name = "price",
											nTextAlign = "1",
											nTextHAlign = "1",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "770",
											text = "12000",
											touchAble = "False",
											touchScaleEnable = "False",
											UILayoutViewModel = 
											{
												PositionX = 1,
												PositionY = -54,
											},
											width = "67",
											ZOrder = "1",
										},
									},
								},
								{
									controlID = "empty_3_gifts_Panel_root_Panel-pushGiftRegression_Layer1_recharge_Game",
									UUID = "8e56739a_763c_4e1c_9113_da9748505c7d",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "187",
									ignoreSize = "True",
									name = "empty_3",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/recharge/gifts/regression/empty_2.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = 242,
										PositionY = -124,
									},
									visible = "False",
									width = "216",
									ZOrder = "1",
								},
								{
									controlID = "gift3_gifts_Panel_root_Panel-pushGiftRegression_Layer1_recharge_Game",
									UUID = "450690eb_eae4_46eb_954f_ad45a9eaae44",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "64",
									ignoreSize = "True",
									name = "gift3",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = 242,
										PositionY = -85,
									},
									width = "64",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "price_gift3_gifts_Panel_root_Panel-pushGiftRegression_Layer1_recharge_Game",
											UUID = "59d3a1ef_1417_4fd2_98ae_a43a78095681",
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
											fontSize = "24",
											fontStroke = 
											{
												IsStroke = false,
												StrokeColor = "#FFE6E6E6",
												StrokeSize = 1,
											},
											height = "27",
											ignoreSize = "True",
											name = "price",
											nTextAlign = "1",
											nTextHAlign = "1",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "770",
											text = "12000",
											touchAble = "False",
											touchScaleEnable = "False",
											UILayoutViewModel = 
											{
												PositionX = -2,
												PositionY = -72,
											},
											width = "67",
											ZOrder = "1",
										},
									},
								},
							},
						},
						{
							controlID = "btn_pay_Panel_root_Panel-pushGiftRegression_Layer1_recharge_Game",
							UUID = "7a2cb2ed_3104_4530_af73_6219254283d9",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							backGroundScale9Enable = "False",
							classname = "MEButton",
							ClickHighLightEnabled = "True",
							dstBlendFunc = "771",
							flipX = "False",
							flipY = "False",
							height = "201",
							ignoreSize = "True",
							name = "btn_pay",
							normal = "ui/recharge/gifts/regression/btn.png",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							touchAble = "True",
							UILayoutViewModel = 
							{
								PositionX = 128,
								PositionY = -134,
							},
							UItype = "Button",
							width = "229",
							ZOrder = "1",
							components = 
							{
								
								{
									controlID = "originPrice_btn_pay_Panel_root_Panel-pushGiftRegression_Layer1_recharge_Game",
									UUID = "8397bc36_72f1_478e_b105_5bbd34ef6549",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									classname = "MELabel",
									compPath = "luacomponents.common.MEIconLabel",
									dstBlendFunc = "771",
									FontColor = "#FFFFC9DC",
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
									height = "32",
									ignoreSize = "True",
									name = "originPrice",
									nTextAlign = "1",
									nTextHAlign = "1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "200",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionY = 15,
									},
									width = "48",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "discountLine_originPrice_btn_pay_Panel_root_Panel-pushGiftRegression_Layer1_recharge_Game",
											UUID = "28424f55_b895_4e29_aa4c_5ea297ea5f14",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											classname = "MEImage",
											dstBlendFunc = "771",
											height = "2",
											ignoreSize = "True",
											name = "discountLine",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											texturePath = "ui/recharge/gifts/xianshi_001.png",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 1,
												PositionY = -1,
											},
											width = "77",
											ZOrder = "1",
										},
									},
								},
								{
									controlID = "discountTag_btn_pay_Panel_root_Panel-pushGiftRegression_Layer1_recharge_Game",
									UUID = "915dfb73_3f90_44ec_b206_f383604e55dc",
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
									name = "discountTag",
									nTextAlign = "1",
									nTextHAlign = "1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "70% Off",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionX = -1,
										PositionY = -25,
									},
									width = "91",
									ZOrder = "1",
								},
								{
									controlID = "discountPrice_btn_pay_Panel_root_Panel-pushGiftRegression_Layer1_recharge_Game",
									UUID = "2d5b6008_eb18_40d5_82e4_4b67b2973270",
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
									fontSize = "40",
									fontStroke = 
									{
										IsStroke = false,
										StrokeColor = "#FFE6E6E6",
										StrokeSize = 1,
									},
									height = "46",
									ignoreSize = "True",
									name = "discountPrice",
									nTextAlign = "1",
									nTextHAlign = "1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "600",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionX = -1,
										PositionY = -68,
									},
									width = "68",
									ZOrder = "1",
								},
								{
									controlID = "ImgCost_btn_pay_Panel_root_Panel-pushGiftRegression_Layer1_recharge_Game",
									UUID = "dce0d16d_21e9_4dc9_975d_9ccd79f34775",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "100",
									ignoreSize = "True",
									name = "ImgCost",
									scaleX = "0.5",
									scaleY = "0.5",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "icon/system/003.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = -2,
										PositionY = 17,
									},
									width = "100",
									ZOrder = "1",
								},
							},
						},
						{
							controlID = "timeCount_Panel_root_Panel-pushGiftRegression_Layer1_recharge_Game",
							UUID = "9cbf2388_72b5_4b17_9dae_fb730bc460c9",
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
							height = "0",
							ignoreSize = "False",
							name = "timeCount",
							nTextAlign = "1",
							nTextHAlign = "0",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "770",
							text = "Disappear after 23:10:12",
							touchAble = "False",
							touchScaleEnable = "False",
							UILayoutViewModel = 
							{
								PositionX = 74,
								PositionY = 184,
							},
							width = "155",
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
			"ui/recharge/gifts/regression/3.png",
			"ui/recharge/gifts/regression/2.png",
			"ui/recharge/gifts/regression/1.png",
			"ui/recharge/gifts/regression/empty_1.png",
			"ui/recharge/gifts/regression/empty_2.png",
			"ui/recharge/gifts/regression/btn.png",
			"ui/recharge/gifts/xianshi_001.png",
			"icon/system/003.png",
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

