local t = 
{
	version = 1,
	components = 
	{
		
		{
			controlID = "Panel-BalloonOpPanel_balloon_activity_Game",
			UUID = "fc52a7a9_b357_4a51_9b08_abf9593668db",
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
					controlID = "img_bg_Panel-BalloonOpPanel_balloon_activity_Game",
					UUID = "2c4cd1bb_c0c7_4161_9ee8_85938cf988d3",
					anchorPoint = "False",
					anchorPointX = "0.5",
					anchorPointY = "0.5",
					backGroundScale9Enable = "False",
					classname = "MEImage",
					dstBlendFunc = "771",
					height = "308",
					ignoreSize = "True",
					name = "img_bg",
					sizepercentx = "0",
					sizepercenty = "0",
					sizeType = "0",
					srcBlendFunc = "1",
					texturePath = "ui/balloon/21.png",
					touchAble = "True",
					UILayoutViewModel = 
					{
						PositionX = 480,
						PositionY = 320,
						relativeToName = "Panel",
						nType = 3,
						nGravity = 6,
						nAlign = 5
					},
					width = "524",
					ZOrder = "1",
					components = 
					{
						
						{
							controlID = "img_di_img_bg_Panel-BalloonOpPanel_balloon_activity_Game",
							UUID = "6d507634_9910_4d94_a952_08873abab5b3",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							backGroundScale9Enable = "False",
							classname = "MEImage",
							dstBlendFunc = "771",
							height = "189",
							ignoreSize = "True",
							name = "img_di",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							texturePath = "ui/balloon/22.png",
							touchAble = "False",
							UILayoutViewModel = 
							{
								PositionX = 2,
								PositionY = 5,
							},
							width = "517",
						},
						{
							controlID = "label_title_img_bg_Panel-BalloonOpPanel_balloon_activity_Game",
							UUID = "425d61eb_b071_473d_a67e_d1e3417bc135",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							classname = "MELabel",
							compPath = "luacomponents.common.MEIconLabel",
							dstBlendFunc = "771",
							FontColor = "#FF485381",
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
							name = "label_title",
							nTextAlign = "1",
							nTextHAlign = "1",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "770",
							text = "取消交易",
							touchAble = "False",
							touchScaleEnable = "False",
							UILayoutViewModel = 
							{
								PositionX = -189,
								PositionY = 121,
							},
							width = "114",
							ZOrder = "1",
						},
						{
							controlID = "btn_close_img_bg_Panel-BalloonOpPanel_balloon_activity_Game",
							UUID = "40782297_7436_453a_8620_a277cded544e",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							backGroundScale9Enable = "False",
							classname = "MEButton",
							ClickHighLightEnabled = "True",
							dstBlendFunc = "771",
							flipX = "False",
							flipY = "False",
							height = "32",
							ignoreSize = "True",
							name = "btn_close",
							normal = "ui/balloon/close_btn.png",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							touchAble = "True",
							UILayoutViewModel = 
							{
								PositionX = 234,
								PositionY = 124,
							},
							UItype = "Button",
							width = "35",
							ZOrder = "1",
						},
						{
							controlID = "txt_desc_img_bg_Panel-BalloonOpPanel_balloon_activity_Game",
							UUID = "ff59f154_b834_46e0_81c4_1cccaab96805",
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
							fontSize = "22",
							fontStroke = 
							{
								IsStroke = false,
								StrokeColor = "#FFE6E6E6",
								StrokeSize = 1,
							},
							height = "0",
							ignoreSize = "False",
							name = "txt_desc",
							nTextAlign = "1",
							nTextHAlign = "0",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "770",
							text = "全服放飞次数:1000",
							touchAble = "False",
							touchScaleEnable = "False",
							UILayoutViewModel = 
							{
								PositionY = 6,
							},
							width = "450",
							ZOrder = "1",
						},
						{
							controlID = "btn_sure_img_bg_Panel-BalloonOpPanel_balloon_activity_Game",
							UUID = "d4fa8a9c_4799_4e6e_a36f_78e6f7ee4b7e",
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
							name = "btn_sure",
							normal = "ui/balloon/12.png",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							touchAble = "True",
							UILayoutViewModel = 
							{
								PositionX = -172,
								PositionY = -121,
							},
							UItype = "Button",
							width = "124",
							ZOrder = "1",
							components = 
							{
								
								{
									controlID = "btn_label_btn_sure_img_bg_Panel-BalloonOpPanel_balloon_activity_Game",
									UUID = "c78c092b_b890_49d6_9eac_4a8b5f45fa17",
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
									name = "btn_label",
									nTextAlign = "1",
									nTextHAlign = "1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "确认关闭",
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
							controlID = "btn_cancel_img_bg_Panel-BalloonOpPanel_balloon_activity_Game",
							UUID = "24acde7a_e8e5_4aa0_b530_28177bc32e08",
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
							name = "btn_cancel",
							normal = "ui/balloon/13.png",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							touchAble = "True",
							UILayoutViewModel = 
							{
								PositionX = 176,
								PositionY = -121,
							},
							UItype = "Button",
							width = "124",
							ZOrder = "1",
							components = 
							{
								
								{
									controlID = "btn_label_btn_cancel_img_bg_Panel-BalloonOpPanel_balloon_activity_Game",
									UUID = "75d45e7b_9c4c_42fd_890b_4d833c531365",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									classname = "MELabel",
									compPath = "luacomponents.common.MEIconLabel",
									dstBlendFunc = "771",
									FontColor = "#FF737AC8",
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
									name = "btn_label",
									nTextAlign = "1",
									nTextHAlign = "1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "取消关闭",
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
			"ui/balloon/21.png",
			"ui/balloon/22.png",
			"ui/balloon/close_btn.png",
			"ui/balloon/12.png",
			"ui/balloon/13.png",
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

