local t = 
{
	version = 1,
	components = 
	{
		
		{
			controlID = "Panel-changeWorldRoomView_znq_yly_activity_Game",
			UUID = "372bee26_2632_414e_95bd_b1664d277eac",
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
					controlID = "panel_base_Panel-changeWorldRoomView_znq_yly_activity_Game",
					UUID = "268ef7c8_9d39_48df_9f41_07436180c233",
					anchorPoint = "False",
					anchorPointX = "0",
					anchorPointY = "0",
					backGroundScale9Enable = "False",
					bgColorOpacity = "100",
					bIsOpenClipping = "False",
					classname = "MEPanel",
					colorType = "1;SingleColor:#FF000000;GraduallyChangingColorStart:#FFFFFFFF;GraduallyChangingColorEnd:#FFFFFFFF;vectorX:0;vectorY:0",
					DesignHeight = "640",
					DesignType = "0",
					DesignWidth = "960",
					dstBlendFunc = "771",
					height = "640",
					ignoreSize = "False",
					name = "panel_base",
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
							controlID = "panel_center_panel_base_Panel-changeWorldRoomView_znq_yly_activity_Game",
							UUID = "47d86434_3b20_4657_8fd9_a04f28dc92ff",
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
							height = "340",
							ignoreSize = "False",
							name = "panel_center",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							touchAble = "False",
							UILayoutViewModel = 
							{
								PositionY = 150,
								IsPercent = true,
								PercentY = 23.44,
								relativeToName = "panel_change_room",
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
									controlID = "Button_room_panel_center_panel_base_Panel-changeWorldRoomView_znq_yly_activity_Game",
									UUID = "dcd4dea6_f87e_46db_88d4_31dcfbd94574",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEButton",
									ClickHighLightEnabled = "True",
									dstBlendFunc = "771",
									flipX = "False",
									flipY = "False",
									height = "402",
									HitType = 
									{
										nHitType = 3,
									},
									ignoreSize = "True",
									name = "Button_room",
									normal = "ui/osd/main/023.png",
									pressed = "ui/osd/main/023.png",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "True",
									UILayoutViewModel = 
									{
										PositionX = 360,
										PositionY = 200,
										LeftPositon = -30,
										TopPosition = 627,
										relativeToName = "panel_change_room",
									},
									UItype = "Button",
									width = "402",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "TextField_input_Button_room_panel_center_panel_base_Panel-changeWorldRoomView_znq_yly_activity_Game",
											UUID = "b10bdf4c_2ab1_4d66_9c6d_ff0b1ee35bb7",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											classname = "METextField",
											CursorEnabled = "True",
											dstBlendFunc = "771",
											fontName = "font/fangzheng_zhunyuan.ttf",
											fontSize = "32",
											hAlignment = "0",
											height = "0",
											ignoreSize = "True",
											KeyBoradType = "0",
											maxLengthEnable = "False",
											name = "TextField_input",
											outlineColor = "#FF000000",
											outlineSize = "1",
											passwordEnable = "False",
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
												
											},
											useOutline = "False",
											useShadow = "False",
											vAlignment = "0",
											visible = "False",
											width = "0",
											ZOrder = "1",
										},
										{
											controlID = "label_roomNums_Button_room_panel_center_panel_base_Panel-changeWorldRoomView_znq_yly_activity_Game",
											UUID = "b5884750_cd96_4966_8741_c40988b9fce7",
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
											fontSize = "20",
											fontStroke = 
											{
												IsStroke = false,
												StrokeColor = "#FFE6E6E6",
												StrokeSize = 1,
											},
											height = "25",
											ignoreSize = "True",
											name = "label_roomNums",
											nTextAlign = "1",
											nTextHAlign = "1",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "770",
											text = "1 - 300",
											touchAble = "False",
											touchScaleEnable = "False",
											UILayoutViewModel = 
											{
												PositionY = -128,
											},
											width = "83",
											ZOrder = "1",
										},
									},
								},
								{
									controlID = "Button_gonghui_panel_center_panel_base_Panel-changeWorldRoomView_znq_yly_activity_Game",
									UUID = "e874f518_4987_471e_89a4_cecea3ce67da",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEButton",
									ClickHighLightEnabled = "True",
									dstBlendFunc = "771",
									flipX = "False",
									flipY = "False",
									height = "402",
									HitType = 
									{
										nHitType = 3,
									},
									ignoreSize = "True",
									name = "Button_gonghui",
									normal = "ui/osd/main/025.png",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "True",
									UILayoutViewModel = 
									{
										PositionX = 776,
										PositionY = 200,
										LeftPositon = -30,
										TopPosition = 627,
									},
									UItype = "Button",
									width = "402",
									ZOrder = "1",
								},
								{
									controlID = "Image_MapLayer_1_panel_center_panel_base_Panel-changeWorldRoomView_znq_yly_activity_Game",
									UUID = "0d1a9d85_50bf_4e70_9b5b_16f144767a23",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "42",
									ignoreSize = "True",
									name = "Image_MapLayer_1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/osd/main/022.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = 360,
										PositionY = 30,
									},
									width = "174",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "Label_MapLayer_1_Image_MapLayer_1_panel_center_panel_base_Panel-changeWorldRoomView_znq_yly_activity_Game",
											UUID = "a79272d4_7c10_4995_87e3_5c73f3492597",
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
											name = "Label_MapLayer_1",
											nTextAlign = "1",
											nTextHAlign = "1",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "770",
											text = "查找房间",
											touchAble = "False",
											touchScaleEnable = "False",
											UILayoutViewModel = 
											{
												
											},
											width = "106",
											ZOrder = "1",
										},
									},
								},
								{
									controlID = "Image_MapLayer_2_panel_center_panel_base_Panel-changeWorldRoomView_znq_yly_activity_Game",
									UUID = "97134b1b_4063_4f73_8b55_83aad09dbe82",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "42",
									ignoreSize = "True",
									name = "Image_MapLayer_2",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/osd/main/024.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = 776,
										PositionY = 41,
									},
									width = "174",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "Label_MapLayer_1_Image_MapLayer_2_panel_center_panel_base_Panel-changeWorldRoomView_znq_yly_activity_Game",
											UUID = "a13870f4_30d5_48b1_8e93_fb02ca1c7275",
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
											name = "Label_MapLayer_1",
											nTextAlign = "1",
											nTextHAlign = "1",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "770",
											text = "前往社团",
											touchAble = "False",
											touchScaleEnable = "False",
											UILayoutViewModel = 
											{
												
											},
											width = "105",
											ZOrder = "1",
										},
									},
								},
							},
						},
						{
							controlID = "TextField_input_panel_base_Panel-changeWorldRoomView_znq_yly_activity_Game",
							UUID = "13655b4f_d5c4_44cc_9bf5_73ef40dc6e3e",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							classname = "METextField",
							CursorEnabled = "True",
							dstBlendFunc = "771",
							fontName = "phanta.ttf",
							fontSize = "32",
							hAlignment = "0",
							height = "36",
							ignoreSize = "True",
							KeyBoradType = "1",
							maxLengthEnable = "False",
							name = "TextField_input",
							outlineColor = "#FF000000",
							outlineSize = "1",
							passwordEnable = "False",
							placeHolder = "input TextField",
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
								PositionX = 538,
								PositionY = 780,
								LeftPositon = 442,
								TopPosition = -158,
								relativeToName = "panel_base",
								nType = 3,
							},
							useOutline = "False",
							useShadow = "False",
							vAlignment = "0",
							width = "192",
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
			"ui/osd/main/023.png",
			"ui/osd/main/025.png",
			"ui/osd/main/022.png",
			"ui/osd/main/024.png",
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

