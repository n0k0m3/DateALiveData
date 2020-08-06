local t = 
{
	version = 1,
	components = 
	{
		
		{
			controlID = "Panel-modifySuitNameView_Layer1_Equip_Game",
			UUID = "9c3ac5c3_ea22_44ba_9859_a620806ae94d",
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
					controlID = "Panel_base_Panel-modifySuitNameView_Layer1_Equip_Game",
					UUID = "df2c0891_b57d_4a94_81fd_dcd0aab39780",
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
							controlID = "Image_bg_Panel_base_Panel-modifySuitNameView_Layer1_Equip_Game",
							UUID = "12232b1d_51b2_4597_99d1_970d4c8803f0",
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
									controlID = "Image_citySpriteSelectView_3_Image_bg_Panel_base_Panel-modifySuitNameView_Layer1_Equip_Game",
									UUID = "934414d7_aaf0_4aee_bed5_730918828526",
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
											controlID = "TextField_modifyName_Image_citySpriteSelectView_3_Image_bg_Panel_base_Panel-modifySuitNameView_Layer1_Equip_Game",
											UUID = "1d0334bd_de95_4fb6_b517_0e4bd1233051",
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
											placeHolder = "请输入新的昵称",
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
											controlID = "Label_modifyName_Image_citySpriteSelectView_3_Image_bg_Panel_base_Panel-modifySuitNameView_Layer1_Equip_Game",
											UUID = "092143aa_9cf8_4169_a009_64c5d88af0a9",
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
											text = "点击输入",
											touchAble = "True",
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
									controlID = "Label_des_Image_bg_Panel_base_Panel-modifySuitNameView_Layer1_Equip_Game",
									UUID = "cac9b38b_f4c3_4397_ad32_81e2d37bc901",
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
									text = "请输入新的预设名",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionY = 71,
										IsPercent = true,
										PercentY = 21.87,
									},
									width = "210",
									ZOrder = "1",
								},
								{
									controlID = "Label_notes_Image_bg_Panel_base_Panel-modifySuitNameView_Layer1_Equip_Game",
									UUID = "63bdeca5_a6b2_4cb5_88ab_b5a5c352015b",
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
									height = "21",
									ignoreSize = "True",
									name = "Label_notes",
									nTextAlign = "1",
									nTextHAlign = "1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "（不能超过8位字符）",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionX = 154,
										PositionY = -39,
									},
									width = "167",
									ZOrder = "1",
								},
								{
									controlID = "Button_ok_Image_bg_Panel_base_Panel-modifySuitNameView_Layer1_Equip_Game",
									UUID = "402b9e64_4a70_487f_9987_6073109609bd",
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
											controlID = "Label_ok_Button_ok_Image_bg_Panel_base_Panel-modifySuitNameView_Layer1_Equip_Game",
											UUID = "e9c39ceb_7e60_41a7_be94_94bf1f115f28",
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
											fontSize = "28",
											fontStroke = 
											{
												IsStroke = false,
												StrokeColor = "#FFE6E6E6",
												StrokeSize = 1,
											},
											height = "32",
											ignoreSize = "True",
											name = "Label_ok",
											nTextAlign = "1",
											nTextHAlign = "1",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "770",
											text = "确定",
											touchAble = "False",
											touchScaleEnable = "False",
											UILayoutViewModel = 
											{
												PositionY = -2,
											},
											width = "58",
											ZOrder = "1",
										},
									},
								},
								{
									controlID = "Label_title_Image_bg_Panel_base_Panel-modifySuitNameView_Layer1_Equip_Game",
									UUID = "932d9204_d34e_450b_82c8_34b7e43086c9",
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
									height = "35",
									ignoreSize = "True",
									name = "Label_title",
									nTextAlign = "1",
									nTextHAlign = "1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "修改预设名 |",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionX = -249,
										PositionY = 130,
									},
									width = "158",
									ZOrder = "1",
								},
								{
									controlID = "Label_title-Copy1_Image_bg_Panel_base_Panel-modifySuitNameView_Layer1_Equip_Game",
									UUID = "f00cb23a_3c04_4b1c_ae7d_cc8fa5e97760",
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
									text = "Infomation Create",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionX = -90,
										PositionY = 123,
									},
									width = "115",
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

