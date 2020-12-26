local t = 
{
	version = 1,
	components = 
	{
		
		{
			controlID = "Panel-jumpActivityView4_jumpActivityModel_activity_Game",
			UUID = "60189259_2b82_44f9_af2b_08bfd642f87b",
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
					controlID = "Panel_root_Panel-jumpActivityView4_jumpActivityModel_activity_Game",
					UUID = "513405fa_08c3_466c_8788_4cbd471de211",
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
							controlID = "Image_bg_Panel_root_Panel-jumpActivityView4_jumpActivityModel_activity_Game",
							UUID = "45e8b707_cee0_4e1d_a6f3_f00fb8f89280",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							backGroundScale9Enable = "False",
							classname = "MEImage",
							dstBlendFunc = "771",
							height = "547",
							ignoreSize = "True",
							name = "Image_bg",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							texturePath = "ui/activity/activity_bg/bg2.png",
							touchAble = "False",
							UILayoutViewModel = 
							{
								LeftPositon = 430,
								TopPosition = 236,
								relativeToName = "Panel",
							},
							width = "891",
							ZOrder = "1",
						},
						{
							controlID = "label_time_Panel_root_Panel-jumpActivityView4_jumpActivityModel_activity_Game",
							UUID = "679a8a6b_902c_42a5_b403_3148df2fe6fa",
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
						},
						{
							controlID = "Button_jump_Panel_root_Panel-jumpActivityView4_jumpActivityModel_activity_Game",
							UUID = "2a7e3633_2b0d_43d2_98ea_364cdf537d83",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							backGroundScale9Enable = "False",
							classname = "MEButton",
							ClickHighLightEnabled = "True",
							dstBlendFunc = "771",
							flipX = "False",
							flipY = "False",
							height = "206",
							ignoreSize = "True",
							name = "Button_jump",
							normal = "ui/activity/activity_bg/btn2.png",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							touchAble = "True",
							UILayoutViewModel = 
							{
								PositionX = 295,
								PositionY = -179,
							},
							UItype = "Button",
							width = "284",
							ZOrder = "1",
							components = 
							{
								
								{
									controlID = "label_jump_Button_jump_Panel_root_Panel-jumpActivityView4_jumpActivityModel_activity_Game",
									UUID = "78b8d61f_b5f2_409b_8da9_b77ece2b3261",
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
									name = "label_jump",
									nTextAlign = "1",
									nTextHAlign = "1",
									scaleX = "1.7",
									scaleY = "1.2",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "前往召唤",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										
									},
									visible = "False",
									width = "106",
									ZOrder = "1",
								},
								{
									controlID = "Image_bg_Button_jump_Panel_root_Panel-jumpActivityView4_jumpActivityModel_activity_Game",
									UUID = "11a59b39_c655_4ad7_a2fd_997db8e8d45f",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "208",
									ignoreSize = "True",
									name = "Image_bg",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/activity/activity_bg/037.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = -216,
										PositionY = 74,
										LeftPositon = 430,
										TopPosition = 236,
										relativeToName = "Panel",
									},
									visible = "False",
									width = "252",
									ZOrder = "1",
								},
							},
						},
						{
							controlID = "panel_date_Panel_root_Panel-jumpActivityView4_jumpActivityModel_activity_Game",
							UUID = "4d48d406_06bb_44e2_8657_9d24a92b0ed9",
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
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							touchAble = "False",
							UILayoutViewModel = 
							{
								PositionX = 231,
								PositionY = 243,
							},
							uipanelviewmodel = 
							{
								Layout="Absolute",
								nType = "0"
							},
							width = "60",
							ZOrder = "2",
							components = 
							{
								
								{
									controlID = "label_date_panel_date_Panel_root_Panel-jumpActivityView4_jumpActivityModel_activity_Game",
									UUID = "498def07_1032_44c7_9192_3511da4136dd",
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
										PositionX = 51,
										PositionY = 11,
									},
									width = "80",
									ZOrder = "1",
								},
							},
						},
						{
							controlID = "Image_time_bg_Panel_root_Panel-jumpActivityView4_jumpActivityModel_activity_Game",
							UUID = "9c95fbe4_86ca_4c3e_91ff_656686174e07",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							backGroundScale9Enable = "False",
							classname = "MEImage",
							dstBlendFunc = "771",
							height = "40",
							ignoreSize = "True",
							name = "Image_time_bg",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							texturePath = "ui/activity/003.png",
							touchAble = "False",
							UILayoutViewModel = 
							{
								PositionY = 248,
							},
							visible = "False",
							width = "923",
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
			"ui/activity/activity_bg/bg2.png",
			"ui/activity/activity_bg/btn2.png",
			"ui/activity/activity_bg/037.png",
			"ui/activity/003.png",
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

