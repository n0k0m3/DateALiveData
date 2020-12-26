local t = 
{
	version = 1,
	components = 
	{
		
		{
			controlID = "Panel-actor_prefab_znq_yly_activity_Game",
			UUID = "2794b2e5_a986_4419_b60b_e254156bcbd4",
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
			width = "1020",
			ZOrder = "1",
			components = 
			{
				
				{
					controlID = "Panel_player_Panel-actor_prefab_znq_yly_activity_Game",
					UUID = "781226a3_e3e5_43a9_b996_c4fc62cccf89",
					anchorPoint = "False",
					anchorPointX = "0.5",
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
					height = "400",
					ignoreSize = "False",
					name = "Panel_player",
					sizepercentx = "0",
					sizepercenty = "0",
					sizeType = "0",
					srcBlendFunc = "1",
					touchAble = "False",
					UILayoutViewModel = 
					{
						PositionX = 226,
						PositionY = 115,
					},
					uipanelviewmodel = 
					{
						Layout="Absolute",
						nType = "0"
					},
					width = "400",
					ZOrder = "1",
					components = 
					{
						
						{
							controlID = "lable_name_Panel_player_Panel-actor_prefab_znq_yly_activity_Game",
							UUID = "1cf12170_c82e_4e35_896c_c2a7e3045714",
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
							fontSize = "18",
							fontStroke = 
							{
								IsStroke = true,
								StrokeColor = "#FF535D7A",
								StrokeSize = 1,
							},
							height = "23",
							ignoreSize = "True",
							name = "lable_name",
							nTextAlign = "1",
							nTextHAlign = "1",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "770",
							text = "1111",
							touchAble = "False",
							touchScaleEnable = "False",
							UILayoutViewModel = 
							{
								PositionY = -25,
							},
							width = "27",
							ZOrder = "1",
						},
						{
							controlID = "Image_bubble_Panel_player_Panel-actor_prefab_znq_yly_activity_Game",
							UUID = "14800b91_ad41_4e6a_a2ff_0744ad2d801c",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0",
							backGroundScale9Enable = "False",
							classname = "MEImage",
							dstBlendFunc = "771",
							height = "223",
							ignoreSize = "False",
							name = "Image_bubble",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							texturePath = "ui/activity/znq_yly/mainUi/chatBubble.png",
							touchAble = "False",
							UILayoutViewModel = 
							{
								PositionY = 130,
							},
							width = "320",
							ZOrder = "1",
							components = 
							{
								
								{
									controlID = "Label_bubble_Image_bubble_Panel_player_Panel-actor_prefab_znq_yly_activity_Game",
									UUID = "7e861b98_99a2_4dcc_9bd0_670a1266bf46",
									anchorPoint = "False",
									anchorPointX = "0",
									anchorPointY = "1",
									classname = "MELabel",
									compPath = "luacomponents.common.MEIconLabel",
									dstBlendFunc = "771",
									FontColor = "#FF49557F",
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
									height = "90",
									ignoreSize = "False",
									name = "Label_bubble",
									nTextAlign = "0",
									nTextHAlign = "0",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "玩家名称玩家名称玩家名称玩家名称玩名称玩家名称玩名称玩家名称玩",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionX = -106,
										PositionY = 162,
									},
									width = "212",
									ZOrder = "1",
								},
							},
						},
					},
				},
				{
					controlID = "Panel_npc_Panel-actor_prefab_znq_yly_activity_Game",
					UUID = "ccafc6f5_12d1_4abd_86f7_5787e008151a",
					anchorPoint = "False",
					anchorPointX = "0.5",
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
					height = "400",
					ignoreSize = "False",
					name = "Panel_npc",
					sizepercentx = "0",
					sizepercenty = "0",
					sizeType = "0",
					srcBlendFunc = "1",
					touchAble = "False",
					UILayoutViewModel = 
					{
						PositionX = 765,
						PositionY = 175,
					},
					uipanelviewmodel = 
					{
						Layout="Absolute",
						nType = "0"
					},
					width = "400",
					ZOrder = "1",
					components = 
					{
						
						{
							controlID = "Image_bubble_Panel_npc_Panel-actor_prefab_znq_yly_activity_Game",
							UUID = "45ee7f58_3e48_43c8_9c19_768c9f89962f",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0",
							backGroundScale9Enable = "False",
							classname = "MEImage",
							dstBlendFunc = "771",
							height = "98",
							ignoreSize = "True",
							name = "Image_bubble",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							texturePath = "ui/osd/main/003.png",
							touchAble = "False",
							UILayoutViewModel = 
							{
								PositionY = 159,
							},
							width = "98",
							ZOrder = "1",
							components = 
							{
								
								{
									controlID = "Label_bubble_Image_bubble_Panel_npc_Panel-actor_prefab_znq_yly_activity_Game",
									UUID = "41ac61f6_b6d3_48c5_a4b2_a1a798701e9a",
									anchorPoint = "False",
									anchorPointX = "0",
									anchorPointY = "1",
									classname = "MELabel",
									compPath = "luacomponents.common.MEIconLabel",
									dstBlendFunc = "771",
									FontColor = "#FF49557F",
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
									height = "65",
									ignoreSize = "False",
									name = "Label_bubble",
									nTextAlign = "0",
									nTextHAlign = "0",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "玩家名称",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionX = -45,
										PositionY = 89,
									},
									width = "89",
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
			"ui/activity/znq_yly/mainUi/chatBubble.png",
			"ui/osd/main/003.png",
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

