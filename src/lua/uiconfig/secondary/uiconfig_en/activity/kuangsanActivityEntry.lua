local t = 
{
	version = 1,
	components = 
	{
		
		{
			controlID = "Panel-kuangsanActivityEntry_kuangsanAssist_activity_Game",
			UUID = "5207d15b_6baf_4ac3_86ad_ae069f9ddf07",
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
			height = "542",
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
				
			},
			uipanelviewmodel = 
			{
				Layout="Absolute",
				nType = "0"
			},
			width = "886",
			ZOrder = "1",
			components = 
			{
				
				{
					controlID = "Panel_root_Panel-kuangsanActivityEntry_kuangsanAssist_activity_Game",
					UUID = "38ebc099_85e3_47c1_9f7f_ff7cece397c0",
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
					height = "542",
					ignoreSize = "False",
					name = "Panel_root",
					sizepercentx = "100",
					sizepercenty = "100",
					sizeType = "1",
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
					width = "886",
					ZOrder = "1",
					components = 
					{
						
						{
							controlID = "Image_bg_Panel_root_Panel-kuangsanActivityEntry_kuangsanAssist_activity_Game",
							UUID = "953c216c_1b1b_4851_973e_0de37ba9550e",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							backGroundScale9Enable = "False",
							classname = "MEImage",
							dstBlendFunc = "771",
							height = "534",
							ignoreSize = "True",
							name = "Image_bg",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							texturePath = "ui/activity/kuangsan/kuangsanEntry.png",
							touchAble = "False",
							UILayoutViewModel = 
							{
								
							},
							width = "924",
							ZOrder = "1",
						},
						{
							controlID = "label_time_Panel_root_Panel-kuangsanActivityEntry_kuangsanAssist_activity_Game",
							UUID = "aa76b891_db0d_4885_95a9_2ccc2883b716",
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
							fontSize = "20",
							fontStroke = 
							{
								IsStroke = false,
								StrokeColor = "#FFE6E6E6",
								StrokeSize = 1,
							},
							height = "23",
							ignoreSize = "True",
							name = "label_time",
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
								PositionX = 281,
								PositionY = 95,
							},
							visible = "False",
							width = "80",
							ZOrder = "1",
							components = 
							{
								
								{
									controlID = "Image_jumpActivityView6_1_label_time_Panel_root_Panel-kuangsanActivityEntry_kuangsanAssist_activity_Game",
									UUID = "78cf4cfd_4a60_4e58_99e3_d96bf9b4efaf",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "64",
									ignoreSize = "True",
									name = "Image_jumpActivityView6_1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "False",
									UILayoutViewModel = 
									{
										
									},
									width = "64",
									ZOrder = "1",
								},
							},
						},
						{
							controlID = "Button_jump_Panel_root_Panel-kuangsanActivityEntry_kuangsanAssist_activity_Game",
							UUID = "acd8e151_f1f1_42ac_b725_110d029c584d",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							backGroundScale9Enable = "False",
							classname = "MEButton",
							ClickHighLightEnabled = "True",
							dstBlendFunc = "771",
							flipX = "False",
							flipY = "False",
							height = "104",
							ignoreSize = "True",
							name = "Button_jump",
							normal = "ui/activity/kuangsan/kuangsanEntryBg.png",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							touchAble = "True",
							UILayoutViewModel = 
							{
								PositionX = 360,
								PositionY = -207,
							},
							UItype = "Button",
							width = "198",
							ZOrder = "1",
							components = 
							{
								
								{
									controlID = "Label_Button_jump_Panel_root_Panel-kuangsanActivityEntry_kuangsanAssist_activity_Game",
									UUID = "49e17bde_f4cc_448e_9aa3_e188f60c71ae",
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
									fontSize = "36",
									fontStroke = 
									{
										IsStroke = false,
										StrokeColor = "#FFE6E6E6",
										StrokeSize = 1,
									},
									height = "0",
									ignoreSize = "False",
									name = "Label",
									nTextAlign = "1",
									nTextHAlign = "1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "Enter",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionX = 15,
										PositionY = -2,
									},
									visible = "False",
									width = "158",
									ZOrder = "1",
								},
							},
						},
						{
							controlID = "panel_date_Panel_root_Panel-kuangsanActivityEntry_kuangsanAssist_activity_Game",
							UUID = "c68215c0_47ac_4ee5_b9e6_949ee1d5b727",
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
							height = "60",
							ignoreSize = "False",
							name = "panel_date",
							rotation = "-15",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							touchAble = "False",
							UILayoutViewModel = 
							{
								PositionX = -377,
								PositionY = 217,
							},
							uipanelviewmodel = 
							{
								Layout="Absolute",
								nType = "0"
							},
							width = "60",
							ZOrder = "1",
							components = 
							{
								
								{
									controlID = "label_date_panel_date_Panel_root_Panel-kuangsanActivityEntry_kuangsanAssist_activity_Game",
									UUID = "221ea127_ed8c_41f4_a46d_553d7d31b119",
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
										StrokeColor = "#FF3370C4",
										StrokeSize = 2,
									},
									height = "57",
									ignoreSize = "False",
									name = "label_date",
									nTextAlign = "1",
									nTextHAlign = "1",
									rotation = "-2",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "TextLableTextLable TextLableTextLable TextLableTextLable",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionX = -2,
										PositionY = -1,
									},
									visible = "False",
									width = "200",
									ZOrder = "1",
								},
								{
									controlID = "act_time_panel_date_Panel_root_Panel-kuangsanActivityEntry_kuangsanAssist_activity_Game",
									UUID = "bce201dd_ce2b_4ec4_ac6a_c3f51ebd2c3b",
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
										IsStroke = true,
										StrokeColor = "#FFC43351",
										StrokeSize = 2,
									},
									height = "29",
									ignoreSize = "True",
									name = "act_time",
									nTextAlign = "1",
									nTextHAlign = "1",
									rotation = "1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "活动时间",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionX = 13,
										PositionY = 27,
									},
									width = "93",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "act_timeStart_act_time_panel_date_Panel_root_Panel-kuangsanActivityEntry_kuangsanAssist_activity_Game",
											UUID = "b74287fb_9b27_4b7e_8a30_830c1fb05e80",
											anchorPoint = "False",
											anchorPointX = "0",
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
												StrokeColor = "#FFC43351",
												StrokeSize = 2,
											},
											height = "25",
											ignoreSize = "True",
											name = "act_timeStart",
											nTextAlign = "1",
											nTextHAlign = "1",
											rotation = "-2",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "770",
											text = "20200416",
											touchAble = "False",
											touchScaleEnable = "False",
											UILayoutViewModel = 
											{
												PositionX = -66,
												PositionY = -24,
											},
											width = "85",
											ZOrder = "1",
										},
										{
											controlID = "act_timeEnd_act_time_panel_date_Panel_root_Panel-kuangsanActivityEntry_kuangsanAssist_activity_Game",
											UUID = "e95966de_73ea_4521_8fd1_aefd18842300",
											anchorPoint = "False",
											anchorPointX = "0",
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
												StrokeColor = "#FFC43351",
												StrokeSize = 2,
											},
											height = "25",
											ignoreSize = "True",
											name = "act_timeEnd",
											nTextAlign = "1",
											nTextHAlign = "1",
											rotation = "-2",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "770",
											text = "20200416",
											touchAble = "False",
											touchScaleEnable = "False",
											UILayoutViewModel = 
											{
												PositionX = -85,
												PositionY = -46,
											},
											width = "85",
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
			"ui/activity/kuangsan/kuangsanEntry.png",
			"ui/activity/kuangsan/kuangsanEntryBg.png",
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

