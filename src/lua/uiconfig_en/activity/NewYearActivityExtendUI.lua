local t = 
{
	version = 1,
	components = 
	{
		
		{
			controlID = "Panel-NewYearActivityExtendUI_Layer1_activity_Game",
			UUID = "9b01cf73_a49e_4d6e_8b29_b5187f33ca7c",
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
					controlID = "panel_base_Panel-NewYearActivityExtendUI_Layer1_activity_Game",
					UUID = "aad1c903_dae8_4a1e_8c77_066f14fe67ef",
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
					name = "panel_base",
					sizepercentx = "0",
					sizepercenty = "0",
					sizeType = "0",
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
							controlID = "btn_yanhua_panel_base_Panel-NewYearActivityExtendUI_Layer1_activity_Game",
							UUID = "cb5c6e24_b3d7_46ff_9857_83344ba48b0e",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							backGroundScale9Enable = "False",
							classname = "MEButton",
							ClickHighLightEnabled = "True",
							dstBlendFunc = "771",
							flipX = "False",
							flipY = "False",
							height = "60",
							ignoreSize = "True",
							name = "btn_yanhua",
							normal = "ui/activity/newYear/city/001.png",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							touchAble = "True",
							UILayoutViewModel = 
							{
								PositionX = 588,
								PositionY = 58,
							},
							UItype = "Button",
							width = "60",
							ZOrder = "1",
							components = 
							{
								
								{
									controlID = "label_yanhua_btn_yanhua_panel_base_Panel-NewYearActivityExtendUI_Layer1_activity_Game",
									UUID = "71eb1bb1_f448_44aa_b8a2_1041f6fa4ae7",
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
									fontSize = "24",
									fontStroke = 
									{
										IsStroke = false,
										StrokeColor = "#FFE6E6E6",
										StrokeSize = 1,
									},
									height = "27",
									ignoreSize = "True",
									name = "label_yanhua",
									nTextAlign = "1",
									nTextHAlign = "1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "Fireworks",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionY = -40,
									},
									width = "51",
									ZOrder = "1",
								},
							},
						},
						{
							controlID = "spine_ani_panel_base_Panel-NewYearActivityExtendUI_Layer1_activity_Game",
							UUID = "f20316f4_5a72_446f_ac08_5a6addd5483a",
							classname = "MESpine",
							dstBlendFunc = "771",
							name = "spine_ani",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							spineModel = 
							{
								SpinePath = "effect/newyear/effect_zhaodaonianshou",
								animationName = "animation",
								IsLoop = true,
								IsPlay = true,
								IsUseQueue = false,
								AnimationQueue = 
								{
									
								},
							},
							srcBlendFunc = "1",
							touchAble = "False",
							UILayoutViewModel = 
							{
								PositionX = 1045,
								PositionY = 457,
							},
							ZOrder = "1",
						},
						{
							controlID = "btn_nianshou_panel_base_Panel-NewYearActivityExtendUI_Layer1_activity_Game",
							UUID = "7db98829_5e42_4b6c_a0cb_7ed95c0a5868",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							backGroundScale9Enable = "False",
							classname = "MEButton",
							ClickHighLightEnabled = "True",
							dstBlendFunc = "771",
							flipX = "False",
							flipY = "False",
							height = "240",
							ignoreSize = "True",
							name = "btn_nianshou",
							normal = "ui/activity/newYear/nianshou/008.png",
							scaleX = "0.55",
							scaleY = "0.55",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							touchAble = "True",
							UILayoutViewModel = 
							{
								PositionX = 1048,
								PositionY = 457,
							},
							UItype = "Button",
							width = "240",
							ZOrder = "1",
						},
						{
							controlID = "label_tip_panel_base_Panel-NewYearActivityExtendUI_Layer1_activity_Game",
							UUID = "c7c9fd57_5675_4994_a777_c8efe8405b4e",
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
								StrokeColor = "#FFA3211F",
								StrokeSize = 2,
							},
							height = "25",
							ignoreSize = "True",
							name = "label_tip",
							nTextAlign = "1",
							nTextHAlign = "1",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "770",
							text = "Nian Beast Escape Countdown",
							touchAble = "False",
							touchScaleEnable = "False",
							UILayoutViewModel = 
							{
								PositionX = 1048,
								PositionY = 424,
							},
							width = "131",
							ZOrder = "1",
						},
						{
							controlID = "bg_image_panel_base_Panel-NewYearActivityExtendUI_Layer1_activity_Game",
							UUID = "b94d9818_da6f_43b5_82cc_5e8ca2ed8226",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							backGroundScale9Enable = "False",
							classname = "MEImage",
							dstBlendFunc = "771",
							height = "34",
							ignoreSize = "True",
							name = "bg_image",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							texturePath = "ui/activity/newYear/city/004.png",
							touchAble = "False",
							UILayoutViewModel = 
							{
								PositionX = 1046,
								PositionY = 389,
							},
							width = "150",
							ZOrder = "1",
							components = 
							{
								
								{
									controlID = "txt_refreshTime_bg_image_panel_base_Panel-NewYearActivityExtendUI_Layer1_activity_Game",
									UUID = "2b5f120c_89da_40bb_b956_e64d55b00a6b",
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
									height = "25",
									ignoreSize = "True",
									name = "txt_refreshTime",
									nTextAlign = "1",
									nTextHAlign = "1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "00m 00s",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionY = 2,
										LeftPositon = 966,
										TopPosition = 241,
										relativeToName = "Panel",
									},
									width = "95",
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
			"ui/activity/newYear/city/001.png",
			"ui/activity/newYear/nianshou/008.png",
			"ui/activity/newYear/city/004.png",
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

