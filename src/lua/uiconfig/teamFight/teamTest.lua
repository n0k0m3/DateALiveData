local t = 
{
	version = 1,
	components = 
	{
		
		{
			controlID = "Panel-teamTest_Layer1_teamFight_Game",
			UUID = "51ff4785_2811_4226_9504_ccee708bad66",
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
					controlID = "Panel_teamTest_1_Panel-teamTest_Layer1_teamFight_Game",
					UUID = "a500557a_14c6_4520_9c9f_768c1b52d33c",
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
					height = "400",
					ignoreSize = "False",
					name = "Panel_teamTest_1",
					panelTexturePath = "ui/025.png",
					sizepercentx = "0",
					sizepercenty = "0",
					sizeType = "0",
					srcBlendFunc = "1",
					touchAble = "False",
					UILayoutViewModel = 
					{
						PositionX = 368,
						PositionY = 120,
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
					width = "400",
					ZOrder = "1",
					components = 
					{
						
						{
							controlID = "edit_txt_Panel_teamTest_1_Panel-teamTest_Layer1_teamFight_Game",
							UUID = "5914bd64_ba82_4c4d_8754_6b1c9a933169",
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
							KeyBoradType = "0",
							maxLengthEnable = "False",
							name = "edit_txt",
							outlineColor = "#FF000000",
							outlineSize = "1",
							passwordEnable = "False",
							placeHolder = "input teamid",
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
								PositionX = 201,
								PositionY = 339,
							},
							useOutline = "False",
							useShadow = "False",
							vAlignment = "0",
							width = "171",
							ZOrder = "1",
						},
						{
							controlID = "btn_create_Panel_teamTest_1_Panel-teamTest_Layer1_teamFight_Game",
							UUID = "0dc1f63d_9e47_4ed0_91fa_82bf186a4531",
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
							name = "btn_create",
							normal = "ui/037.png",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							touchAble = "True",
							UILayoutViewModel = 
							{
								PositionX = 200,
								PositionY = 285,
							},
							UItype = "Button",
							width = "288",
							ZOrder = "1",
							components = 
							{
								
								{
									controlID = "txt_btn_create_Panel_teamTest_1_Panel-teamTest_Layer1_teamFight_Game",
									UUID = "f8e21c7e_55ab_4ea2_a73c_39bb418552c5",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									classname = "MELabel",
									ColorMixing = "#FF000000",
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
									height = "37",
									ignoreSize = "True",
									name = "txt",
									nTextAlign = "1",
									nTextHAlign = "1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "创 建 队 伍",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										
									},
									width = "125",
									ZOrder = "1",
								},
							},
						},
						{
							controlID = "btn_join_Panel_teamTest_1_Panel-teamTest_Layer1_teamFight_Game",
							UUID = "a4e9e77c_5411_47c5_8203_c3de7009907b",
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
							name = "btn_join",
							normal = "ui/037.png",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							touchAble = "True",
							UILayoutViewModel = 
							{
								PositionX = 200,
								PositionY = 118,
							},
							UItype = "Button",
							width = "288",
							ZOrder = "1",
							components = 
							{
								
								{
									controlID = "txt_btn_join_Panel_teamTest_1_Panel-teamTest_Layer1_teamFight_Game",
									UUID = "6f12eaa9_263f_430c_a081_66ae7f261dab",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									classname = "MELabel",
									ColorMixing = "#FF000000",
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
									height = "37",
									ignoreSize = "True",
									name = "txt",
									nTextAlign = "1",
									nTextHAlign = "1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "加 入 队 伍",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										
									},
									width = "125",
									ZOrder = "1",
								},
							},
						},
						{
							controlID = "btn_match_Panel_teamTest_1_Panel-teamTest_Layer1_teamFight_Game",
							UUID = "b3a7a580_88ff_48e1_8b69_e12500593ed1",
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
							name = "btn_match",
							normal = "ui/037.png",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							touchAble = "True",
							UILayoutViewModel = 
							{
								PositionX = 200,
								PositionY = 200,
							},
							UItype = "Button",
							width = "288",
							ZOrder = "1",
							components = 
							{
								
								{
									controlID = "txt_btn_match_Panel_teamTest_1_Panel-teamTest_Layer1_teamFight_Game",
									UUID = "0e7f0b20_fc4e_4a05_b363_b200902d5db0",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									classname = "MELabel",
									ColorMixing = "#FF000000",
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
									height = "37",
									ignoreSize = "True",
									name = "txt",
									nTextAlign = "1",
									nTextHAlign = "1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "匹 配 队 伍",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										
									},
									width = "125",
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
			"ui/025.png",
			"ui/037.png",
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

