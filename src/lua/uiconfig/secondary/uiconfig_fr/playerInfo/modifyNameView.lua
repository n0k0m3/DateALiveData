local t = 
{
	version = 1,
	components = 
	{
		
		{
			controlID = "Panel-modifyNameView_Layer1_playerInfo_Game",
			UUID = "a69abd47_fdee_4940_9cea_fde9568f5ce7",
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
			height = "710",
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
			width = "1020",
			ZOrder = "1",
			components = 
			{
				
				{
					controlID = "Panel_base_Panel-modifyNameView_Layer1_playerInfo_Game",
					UUID = "6942b13b_baab_480a_8e33_3332dd16c73f",
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
						Layout="Absolute",
						nType = "0"
					},
					width = "1136",
					ZOrder = "1",
					components = 
					{
						
						{
							controlID = "Image_bg_Panel_base_Panel-modifyNameView_Layer1_playerInfo_Game",
							UUID = "d58b49be_dabe_45be_92fe_d070391420e2",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							backGroundScale9Enable = "False",
							classname = "MEImage",
							dstBlendFunc = "771",
							height = "324",
							ignoreSize = "True",
							name = "Image_bg",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							texturePath = "ui/dating/miniWindow/9.png",
							touchAble = "False",
							UILayoutViewModel = 
							{
								PositionX = 693,
								PositionY = 320,
								IsPercent = true,
								PercentX = 50,
								PercentY = 50,
								LeftPositon = 431,
								TopPosition = 513,
								relativeToName = "Panel_base",
							},
							width = "540",
							ZOrder = "1",
							components = 
							{
								
								{
									controlID = "Image_citySpriteSelectView_3_Image_bg_Panel_base_Panel-modifyNameView_Layer1_playerInfo_Game",
									UUID = "27b386d8_e777_4539_b1ad_cb805fda6450",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "56",
									ignoreSize = "True",
									name = "Image_citySpriteSelectView_3",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/dating/miniWindow/5.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionY = 10,
									},
									width = "484",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "TextField_modifyName_Image_citySpriteSelectView_3_Image_bg_Panel_base_Panel-modifyNameView_Layer1_playerInfo_Game",
											UUID = "7dd38f2e_c806_466c_94b8_0f31a052e24c",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											classname = "METextField",
											CursorEnabled = "False",
											dstBlendFunc = "771",
											fontName = "font/fangzheng_zhunyuan.ttf",
											fontSize = "26",
											hAlignment = "1",
											height = "37",
											ignoreSize = "False",
											KeyBoradType = "0",
											maxLengthEnable = "True;maxLength:16",
											name = "TextField_modifyName",
											outlineColor = "#FF000000",
											outlineSize = "1",
											passwordEnable = "False",
											placeHolder = "Entrez un nouveau nom",
											shadowColor = "#FF000000",
											shadowHeight = "0",
											shadowWidth = "0",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "770",
											touchAble = "True",
											UILayoutViewModel = 
											{
												PositionY = -2,
											},
											useOutline = "False",
											useShadow = "False",
											vAlignment = "0",
											visible = "False",
											width = "460",
											ZOrder = "1",
										},
										{
											controlID = "Label_modifyName_Image_citySpriteSelectView_3_Image_bg_Panel_base_Panel-modifyNameView_Layer1_playerInfo_Game",
											UUID = "2c2ae067_b42b_4c01_8948_6f74d8838517",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											classname = "MELabel",
											compPath = "luacomponents.common.MEIconLabel",
											dstBlendFunc = "771",
											FontColor = "#FF808080",
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
											HitType = 
											{
												nHitType = 1,
												nXpos = -230,
												nYpos = -20,
												nHitWidth = 460,
												nHitHeight = 40
											},
											ignoreSize = "True",
											name = "Label_modifyName",
											nTextAlign = "1",
											nTextHAlign = "1",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "770",
											text = "Appuyez pour entrer",
											touchAble = "True",
											touchScaleEnable = "False",
											UILayoutViewModel = 
											{
												
											},
											width = "227",
											ZOrder = "1",
										},
									},
								},
								{
									controlID = "Label_des_Image_bg_Panel_base_Panel-modifyNameView_Layer1_playerInfo_Game",
									UUID = "b9534a5a_248b_4e23_95b4_e91e66169f50",
									anchorPoint = "False",
									anchorPointX = "0.5",
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
									fontSize = "26",
									fontStroke = 
									{
										IsStroke = false,
										StrokeColor = "#FFE6E6E6",
										StrokeSize = 1,
									},
									height = "30",
									ignoreSize = "True",
									name = "Label_des",
									nTextAlign = "1",
									nTextHAlign = "1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "Entrez un nouveau nom",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionY = 71,
										IsPercent = true,
										PercentY = 21.87,
									},
									width = "261",
									ZOrder = "1",
								},
								{
									controlID = "Label_notes_Image_bg_Panel_base_Panel-modifyNameView_Layer1_playerInfo_Game",
									UUID = "c264180b_226c_4a32_8725_e1976b0f65b7",
									anchorPoint = "False",
									anchorPointX = "0.5",
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
									fontSize = "18",
									fontStroke = 
									{
										IsStroke = false,
										StrokeColor = "#FFE6E6E6",
										StrokeSize = 1,
									},
									height = "0",
									ignoreSize = "True",
									name = "Label_notes",
									nTextAlign = "1",
									nTextHAlign = "1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionX = 154,
										PositionY = -39,
									},
									width = "0",
									ZOrder = "1",
								},
								{
									controlID = "Button_ok_Image_bg_Panel_base_Panel-modifyNameView_Layer1_playerInfo_Game",
									UUID = "c1f99686_4dc2_409e_adf8_79c4f6b7c2e6",
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
									name = "Button_ok",
									normal = "ui/dating/miniWindow/miniButton.png",
									pressed = "ui/dating/miniWindow/miniButton.png",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "True",
									UILayoutViewModel = 
									{
										PositionY = -110,
										IsPercent = true,
										PercentY = -33.83,
									},
									UItype = "Button",
									width = "124",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "Label_ok_Button_ok_Image_bg_Panel_base_Panel-modifyNameView_Layer1_playerInfo_Game",
											UUID = "ad2c0626_69f8_4dd0_8850_0355400ce0b7",
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
											fontSize = "20",
											fontStroke = 
											{
												IsStroke = false,
												StrokeColor = "#FFE6E6E6",
												StrokeSize = 1,
											},
											height = "23",
											ignoreSize = "True",
											name = "Label_ok",
											nTextAlign = "1",
											nTextHAlign = "1",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "770",
											text = "Confirmer",
											touchAble = "False",
											touchScaleEnable = "False",
											UILayoutViewModel = 
											{
												PositionX = 1,
												PositionY = -2,
											},
											width = "86",
											ZOrder = "1",
										},
									},
								},
								{
									controlID = "Label_title_Image_bg_Panel_base_Panel-modifyNameView_Layer1_playerInfo_Game",
									UUID = "48ac4cf5_c331_4610_acc0_755271c3c0b9",
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
									fontSize = "28",
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
									text = "Renommer ",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionX = -249,
										PositionY = 130,
									},
									width = "151",
									ZOrder = "1",
								},
								{
									controlID = "Label_title-Copy1_Image_bg_Panel_base_Panel-modifyNameView_Layer1_playerInfo_Game",
									UUID = "0aac6535_8f7b_4c61_9708_a5c4b0be933b",
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
									fontSize = "15",
									fontStroke = 
									{
										IsStroke = false,
										StrokeColor = "#FFE6E6E6",
										StrokeSize = 1,
									},
									height = "17",
									ignoreSize = "True",
									name = "Label_title-Copy1",
									nTextAlign = "1",
									nTextHAlign = "1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "Créer informations",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionX = -120,
										PositionY = 128,
									},
									visible = "False",
									width = "120",
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
			"ui/dating/miniWindow/9.png",
			"ui/dating/miniWindow/5.png",
			"ui/dating/miniWindow/miniButton.png",
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

