local t = 
{
	version = 1,
	components = 
	{
		
		{
			controlID = "Panel-BalloonReqView_balloon_activity_Game",
			UUID = "b4e46cc1_5b02_4bba_809d_53238fa1f6b6",
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
					controlID = "img_bg_Panel-BalloonReqView_balloon_activity_Game",
					UUID = "b2f74c50_d7cb_4c90_9ca5_b05928dbeba8",
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
					touchAble = "False",
					UILayoutViewModel = 
					{
						PositionX = 568,
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
							controlID = "img_di_img_bg_Panel-BalloonReqView_balloon_activity_Game",
							UUID = "acbc91db_6758_44d7_b130_6c64e883f7e6",
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
							controlID = "label_title_img_bg_Panel-BalloonReqView_balloon_activity_Game",
							UUID = "120d2b99_52a7_4114_8464_7e7dc3d10508",
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
							text = "交易邀请",
							touchAble = "False",
							touchScaleEnable = "False",
							UILayoutViewModel = 
							{
								PositionX = -189,
								PositionY = 121,
							},
							width = "116",
							ZOrder = "1",
						},
						{
							controlID = "txt_desc_img_bg_Panel-BalloonReqView_balloon_activity_Game",
							UUID = "8cb3846d_7ed4_41d6_93c2_de152af340a8",
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
								PositionY = 17,
							},
							width = "450",
							ZOrder = "1",
						},
						{
							controlID = "btn_close_img_bg_Panel-BalloonReqView_balloon_activity_Game",
							UUID = "7838d58e_4185_45e7_ac0e_fdf30c52522b",
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
							controlID = "btn_cancel_img_bg_Panel-BalloonReqView_balloon_activity_Game",
							UUID = "24dd4482_c6ee_4b20_8d4d_29cfd7b17453",
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
								PositionX = 177,
								PositionY = -118,
							},
							UItype = "Button",
							width = "124",
							ZOrder = "1",
							components = 
							{
								
								{
									controlID = "btn_label_btn_cancel_img_bg_Panel-BalloonReqView_balloon_activity_Game",
									UUID = "26567fea_3c51_4b7a_92c6_d02f97c57f40",
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
									fontSize = "24",
									fontStroke = 
									{
										IsStroke = false,
										StrokeColor = "#FFE6E6E6",
										StrokeSize = 1,
									},
									height = "27",
									ignoreSize = "True",
									name = "btn_label",
									nTextAlign = "1",
									nTextHAlign = "1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "取消邀请",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										
									},
									width = "100",
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

