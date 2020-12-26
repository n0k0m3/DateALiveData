local t = 
{
	version = 1,
	components = 
	{
		
		{
			controlID = "Panel-catKSActivityView_activityEn_activity_Game",
			UUID = "3aca49ab_7e86_4087_8b9d_9b73af0b1042",
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
				
			},
			uipanelviewmodel = 
			{
				Layout="Absolute",
				nType = "0"
			},
			width = "960",
			ZOrder = "1",
			components = 
			{
				
				{
					controlID = "panel_root_Panel-catKSActivityView_activityEn_activity_Game",
					UUID = "b812e265_f7b0_4d07_8988_f731a9ab8981",
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
					name = "panel_root",
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
					width = "888",
					ZOrder = "1",
					components = 
					{
						
						{
							controlID = "img_content_panel_root_Panel-catKSActivityView_activityEn_activity_Game",
							UUID = "d770a50f_6681_4d68_bf38_9a77bc8978b8",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							backGroundScale9Enable = "False",
							classname = "MEImage",
							dstBlendFunc = "771",
							height = "548",
							ignoreSize = "True",
							name = "img_content",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							texturePath = "ui/activity/catKSAcvivity/img_bg.png",
							touchAble = "False",
							UILayoutViewModel = 
							{
								
							},
							width = "892",
							ZOrder = "1",
						},
						{
							controlID = "label_date_panel_root_Panel-catKSActivityView_activityEn_activity_Game",
							UUID = "8c0c6258_7929_47a8_b0b4_4b6a826d444f",
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
							fontSize = "20",
							fontStroke = 
							{
								IsStroke = true,
								StrokeColor = "#FF49488A",
								StrokeSize = 1,
							},
							height = "27",
							ignoreSize = "True",
							name = "label_date",
							nTextAlign = "1",
							nTextHAlign = "1",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "770",
							text = "2018.12.25-2020.02.02",
							touchAble = "False",
							touchScaleEnable = "False",
							UILayoutViewModel = 
							{
								PositionX = -440,
								PositionY = 254,
							},
							width = "292",
							ZOrder = "1",
						},
						{
							controlID = "img_time_panel_root_Panel-catKSActivityView_activityEn_activity_Game",
							UUID = "980701b6_b336_42ea_acb1_b17a5ab8c62a",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							backGroundScale9Enable = "False",
							classname = "MEImage",
							dstBlendFunc = "771",
							height = "59",
							ignoreSize = "True",
							name = "img_time",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							texturePath = "ui/activity/catKSAcvivity/img_1.png",
							touchAble = "False",
							UILayoutViewModel = 
							{
								PositionX = -385,
								PositionY = -205,
							},
							visible = "False",
							width = "141",
							ZOrder = "1",
						},
						{
							controlID = "Button_jump_panel_root_Panel-catKSActivityView_activityEn_activity_Game",
							UUID = "225b7a86_2b78_47b1_a7f4_53128121d664",
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
							name = "Button_jump",
							normal = "ui/common/button_middle_n.png",
							pressed = "ui/common/button_middle_n.png",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							touchAble = "True",
							UILayoutViewModel = 
							{
								PositionX = 334,
								PositionY = -226,
							},
							UItype = "Button",
							width = "124",
							ZOrder = "1",
							components = 
							{
								
								{
									controlID = "btn_label_Button_jump_panel_root_Panel-catKSActivityView_activityEn_activity_Game",
									UUID = "bdac6c10_5062_4548_aeaf_c1fa228be584",
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
									fontSize = "24",
									fontStroke = 
									{
										IsStroke = false,
										StrokeColor = "#FFE6E6E6",
										StrokeSize = 1,
									},
									height = "30",
									ignoreSize = "True",
									name = "btn_label",
									nTextAlign = "1",
									nTextHAlign = "1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "GO",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										
									},
									width = "47",
									ZOrder = "1",
								},
							},
						},
						{
							controlID = "label_time_panel_root_Panel-catKSActivityView_activityEn_activity_Game",
							UUID = "fd2acd32_6e4c_40ef_bcf9_122b344b6b06",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							classname = "MELabel",
							compPath = "luacomponents.common.MEIconLabel",
							dstBlendFunc = "771",
							FontColor = "#FFFFFFFF",
							fontName = "phanta.ttf",
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
								
							},
							visible = "False",
							width = "80",
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
			"ui/activity/catKSAcvivity/img_bg.png",
			"ui/activity/catKSAcvivity/img_1.png",
			"ui/common/button_middle_n.png",
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

