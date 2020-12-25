local t = 
{
	version = 1,
	components = 
	{
		
		{
			controlID = "Panel-exchangeCodeView_Layer1_playerInfo_Game",
			UUID = "22681c82_3f11_44e7_970c_9a359ce54d46",
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
			height = "709",
			ignoreSize = "False",
			name = "Panel",
			PanelRelativeSizeModel = 
			{
				PanelRelativeEnable = true,
			},
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
			width = "1020",
			ZOrder = "1",
			components = 
			{
				
				{
					controlID = "Panel_base_Panel-exchangeCodeView_Layer1_playerInfo_Game",
					UUID = "59cadacb_4d2b_46d3_9414_47bb0cda8b7f",
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
						PositionX = 125,
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
							controlID = "Image_bg_Panel_base_Panel-exchangeCodeView_Layer1_playerInfo_Game",
							UUID = "c05d67cd_1f65_4fca_84a4_89fe2ce03ce6",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							backGroundScale9Enable = "True;capInsetsX:0;capInsetsY:0;capInsetsWidth:0;capInsetsHeight:0",
							classname = "MEImage",
							dstBlendFunc = "771",
							height = "322",
							ignoreSize = "False",
							name = "Image_bg",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							texturePath = "ui/common/pop_ui/pop_bg_01.png",
							touchAble = "True",
							UILayoutViewModel = 
							{
								PositionX = 568,
								PositionY = 320,
								IsPercent = true,
								PercentX = 50,
								PercentY = 50,
								LeftPositon = 242,
								BottomPosition = 214,
								relativeToName = "Panel_root",
								nGravity = 4,
								nAlign = 7
							},
							width = "539",
							ZOrder = "1",
							components = 
							{
								
								{
									controlID = "Image_bg2_Image_bg_Panel_base_Panel-exchangeCodeView_Layer1_playerInfo_Game",
									UUID = "1d0c15d3_4b1a_4fb9_9298_656fe9ff90db",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "True;capInsetsX:0;capInsetsY:0;capInsetsWidth:0;capInsetsHeight:0",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "135",
									ignoreSize = "False",
									name = "Image_bg2",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "wzui/y008.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										relativeToName = "Panel_base",
										nGravity = 6,
										nAlign = 5
									},
									visible = "False",
									width = "495",
									ZOrder = "1",
								},
								{
									controlID = "Image_top_Image_bg_Panel_base_Panel-exchangeCodeView_Layer1_playerInfo_Game",
									UUID = "cc3a3eda_0bc3_4489_aae8_2ec1c7043158",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "27",
									ignoreSize = "True",
									name = "Image_top",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/common/image_title.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = -80,
										PositionY = 131,
									},
									width = "121",
									ZOrder = "1",
								},
								{
									controlID = "Label_title_Image_bg_Panel_base_Panel-exchangeCodeView_Layer1_playerInfo_Game",
									UUID = "6f34e123_170d_42ef_8e5a_b24bbcaebb3f",
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
									fontSize = "26",
									fontStroke = 
									{
										IsStroke = false,
										StrokeColor = "#FFE6E6E6",
										StrokeSize = 1,
									},
									height = "32",
									ignoreSize = "True",
									name = "Label_title",
									nTextAlign = "1",
									nTextHAlign = "1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "兌換禮物",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionX = -253,
										PositionY = 131,
									},
									width = "105",
									ZOrder = "1",
								},
								{
									controlID = "Label_desc_Image_bg_Panel_base_Panel-exchangeCodeView_Layer1_playerInfo_Game",
									UUID = "ca829637_8a1d_48cd_a8cd_aa1bb29da17a",
									anchorPoint = "False",
									anchorPointX = "0",
									anchorPointY = "0.5",
									classname = "METextArea",
									ColorMixing = "#FF101117",
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
									name = "Label_desc",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "請輸入兌換碼",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionX = -232,
										PositionY = 65,
									},
									vAlignment = "1",
									width = "146",
									ZOrder = "1",
								},
								{
									controlID = "Image_inputBox_Image_bg_Panel_base_Panel-exchangeCodeView_Layer1_playerInfo_Game",
									UUID = "7b840f67_cafc_4281_8877_cf63c4258ee1",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "56",
									ignoreSize = "True",
									name = "Image_inputBox",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/common/pop_ui/pop_ui_06.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionY = 12,
									},
									width = "468",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "TextField_exchangeCode_Image_inputBox_Image_bg_Panel_base_Panel-exchangeCodeView_Layer1_playerInfo_Game",
											UUID = "c3dd1d81_d287_447a_b061_d4d35cd26ec7",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											classname = "METextField",
											CursorEnabled = "False",
											dstBlendFunc = "771",
											fontName = "font/fangzheng_zhunyuan.ttf",
											fontSize = "24",
											hAlignment = "1",
											height = "37",
											ignoreSize = "False",
											KeyBoradType = "0",
											maxLengthEnable = "True;maxLength:12",
											name = "TextField_exchangeCode",
											outlineColor = "#FF000000",
											outlineSize = "1",
											passwordEnable = "False",
											placeHolder = "請輸入兌換碼",
											shadowColor = "#FF000000",
											shadowHeight = "0",
											shadowWidth = "0",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "770",
											text = "23",
											touchAble = "True",
											UILayoutViewModel = 
											{
												PositionY = -3,
											},
											useOutline = "False",
											useShadow = "False",
											vAlignment = "0",
											width = "460",
											ZOrder = "1",
										},
									},
								},
								{
									controlID = "Button_ok_Image_bg_Panel_base_Panel-exchangeCodeView_Layer1_playerInfo_Game",
									UUID = "05d896d2_c58d_4c4e_84f5_e8eccdebc35d",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "True;capInsetsX:0;capInsetsY:0;capInsetsWidth:0;capInsetsHeight:0",
									classname = "MEButton",
									ClickHighLightEnabled = "True",
									dstBlendFunc = "771",
									flipX = "False",
									flipY = "False",
									height = "50",
									ignoreSize = "False",
									name = "Button_ok",
									normal = "ui/common/button09.png",
									pressed = "ui/common/button09.png",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "True",
									UILayoutViewModel = 
									{
										PositionX = 189,
										PositionY = -112,
									},
									UItype = "Button",
									width = "120",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "Label_ok_Button_ok_Image_bg_Panel_base_Panel-exchangeCodeView_Layer1_playerInfo_Game",
											UUID = "a354f23b_c936_4258_b966_6d33086ccd68",
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
											name = "Label_ok",
											nTextAlign = "1",
											nTextHAlign = "1",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "770",
											text = "確認",
											touchAble = "False",
											touchScaleEnable = "False",
											UILayoutViewModel = 
											{
												PositionY = -1,
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
			"ui/common/pop_ui/pop_bg_01.png",
			"wzui/y008.png",
			"ui/common/image_title.png",
			"ui/common/pop_ui/pop_ui_06.png",
			"ui/common/button09.png",
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

