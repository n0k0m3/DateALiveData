local t = 
{
	version = 1,
	components = 
	{
		
		{
			controlID = "Panel-yanhuaActivityEntrance_yanhua_activity_Game",
			UUID = "5d8f4189_fbc5_4d5f_850d_9d29f7914327",
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
			height = "536",
			ignoreSize = "False",
			name = "Panel",
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
			width = "924",
			ZOrder = "1",
			components = 
			{
				
				{
					controlID = "Panel_root_Panel-yanhuaActivityEntrance_yanhua_activity_Game",
					UUID = "59be3cb3_98a7_4079_ba28_5dd166bc7d49",
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
					height = "536",
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
						nType = 3,
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
							controlID = "Image_bg_Panel_root_Panel-yanhuaActivityEntrance_yanhua_activity_Game",
							UUID = "7da0f8c3_6739_4093_939d_2c85a097788e",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							backGroundScale9Enable = "False",
							classname = "MEImage",
							dstBlendFunc = "771",
							height = "538",
							ignoreSize = "True",
							name = "Image_bg",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							texturePath = "ui/activity/yanhua_compose/entrance/004.png",
							touchAble = "False",
							UILayoutViewModel = 
							{
								LeftPositon = 430,
								TopPosition = 236,
								relativeToName = "Panel",
							},
							width = "924",
							ZOrder = "1",
						},
						{
							controlID = "label_time_Panel_root_Panel-yanhuaActivityEntrance_yanhua_activity_Game",
							UUID = "11992670_e364_4647_8167_1fbdf8fa3acb",
							anchorPoint = "False",
							anchorPointX = "1",
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
								PositionX = 456,
								PositionY = 249,
							},
							visible = "False",
							width = "80",
							ZOrder = "1",
						},
						{
							controlID = "label_date_Panel_root_Panel-yanhuaActivityEntrance_yanhua_activity_Game",
							UUID = "13f90816_9d41_47b0_a772_7a5a150cf604",
							anchorPoint = "False",
							anchorPointX = "1",
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
							name = "label_date",
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
								PositionX = 450,
								PositionY = 250,
							},
							width = "80",
							ZOrder = "1",
						},
						{
							controlID = "Button_compose_Panel_root_Panel-yanhuaActivityEntrance_yanhua_activity_Game",
							UUID = "8ccc4e12_927c_437b_9404_20f1dc42c16d",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							backGroundScale9Enable = "False",
							classname = "MEButton",
							ClickHighLightEnabled = "True",
							dstBlendFunc = "771",
							flipX = "False",
							flipY = "False",
							height = "84",
							ignoreSize = "True",
							name = "Button_compose",
							normal = "ui/activity/yanhua_compose/entrance/002.png",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							touchAble = "True",
							UILayoutViewModel = 
							{
								PositionX = 398,
								PositionY = -35,
							},
							UItype = "Button",
							width = "84",
							ZOrder = "1",
							components = 
							{
								
								{
									controlID = "label_compose_Button_compose_Panel_root_Panel-yanhuaActivityEntrance_yanhua_activity_Game",
									UUID = "28d1c6b7_2788_4c5d_8d26_5f40494ff10f",
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
										IsStroke = true,
										StrokeColor = "#FF9A141B",
										StrokeSize = 2,
									},
									height = "29",
									ignoreSize = "True",
									name = "label_compose",
									nTextAlign = "1",
									nTextHAlign = "1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "制作",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionY = -30,
									},
									width = "47",
									ZOrder = "1",
								},
							},
						},
						{
							controlID = "Button_go_Panel_root_Panel-yanhuaActivityEntrance_yanhua_activity_Game",
							UUID = "eeecdd56_e242_4e01_8dea_34e73fa3ee2e",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							backGroundScale9Enable = "False",
							classname = "MEButton",
							ClickHighLightEnabled = "True",
							dstBlendFunc = "771",
							flipX = "False",
							flipY = "False",
							height = "84",
							ignoreSize = "True",
							name = "Button_go",
							normal = "ui/activity/yanhua_compose/entrance/003.png",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							touchAble = "True",
							UILayoutViewModel = 
							{
								PositionX = 398,
								PositionY = -118,
							},
							UItype = "Button",
							width = "84",
							ZOrder = "1",
							components = 
							{
								
								{
									controlID = "label_go_Button_go_Panel_root_Panel-yanhuaActivityEntrance_yanhua_activity_Game",
									UUID = "1ad0364c_2bee_47b8_8664_5bbbde183073",
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
										IsStroke = true,
										StrokeColor = "#FF9A141B",
										StrokeSize = 2,
									},
									height = "29",
									ignoreSize = "True",
									name = "label_go",
									nTextAlign = "1",
									nTextHAlign = "1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "燃放",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionY = -30,
									},
									width = "45",
									ZOrder = "1",
								},
							},
						},
						{
							controlID = "Button_task_Panel_root_Panel-yanhuaActivityEntrance_yanhua_activity_Game",
							UUID = "477e26fb_48a7_4730_800c_944a06bc3b8b",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							backGroundScale9Enable = "False",
							classname = "MEButton",
							ClickHighLightEnabled = "True",
							dstBlendFunc = "771",
							flipX = "False",
							flipY = "False",
							height = "84",
							ignoreSize = "True",
							name = "Button_task",
							normal = "ui/activity/yanhua_compose/entrance/001.png",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "770",
							touchAble = "True",
							UILayoutViewModel = 
							{
								PositionX = 398,
								PositionY = -202,
							},
							UItype = "Button",
							width = "84",
							ZOrder = "1",
							components = 
							{
								
								{
									controlID = "label_task_Button_task_Panel_root_Panel-yanhuaActivityEntrance_yanhua_activity_Game",
									UUID = "be69c49a_1270_43bd_af25_18da0aab4d1d",
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
										IsStroke = true,
										StrokeColor = "#FF9A141B",
										StrokeSize = 2,
									},
									height = "29",
									ignoreSize = "True",
									name = "label_task",
									nTextAlign = "1",
									nTextHAlign = "1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "成就",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionY = -30,
									},
									width = "46",
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
			"ui/activity/yanhua_compose/entrance/004.png",
			"ui/activity/yanhua_compose/entrance/002.png",
			"ui/activity/yanhua_compose/entrance/003.png",
			"ui/activity/yanhua_compose/entrance/001.png",
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

