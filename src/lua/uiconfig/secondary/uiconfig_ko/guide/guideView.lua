local t = 
{
	version = 1,
	components = 
	{
		
		{
			controlID = "Panel-guideView_Layer1_guide_Game",
			UUID = "289c22f9_dd4e_4d58_8cea_55932c3f8346",
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
					controlID = "Panel_root_Panel-guideView_Layer1_guide_Game",
					UUID = "fc097604_90a3_4544_9fbf_97720354ab53",
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
					name = "Panel_root",
					sizepercentx = "100",
					sizepercenty = "100",
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
							controlID = "Panel_frame_Panel_root_Panel-guideView_Layer1_guide_Game",
							UUID = "e41c046b_ee45_4108_8f10_37cc9c2f7d0f",
							anchorPoint = "False",
							anchorPointX = "0",
							anchorPointY = "0",
							backGroundScale9Enable = "False",
							bgColorOpacity = "100",
							bIsOpenClipping = "False",
							classname = "MEPanel",
							colorType = "0;SingleColor:#FF000000;GraduallyChangingColorStart:#FFFFFFFF;GraduallyChangingColorEnd:#FFFFFFFF;vectorX:0;vectorY:0",
							DesignHeight = "640",
							DesignType = "0",
							DesignWidth = "960",
							dstBlendFunc = "771",
							height = "640",
							ignoreSize = "False",
							name = "Panel_frame",
							sizepercentx = "100",
							sizepercenty = "100",
							sizeType = "1",
							srcBlendFunc = "1",
							touchAble = "False",
							UILayoutViewModel = 
							{
								relativeToName = "Panel",
							},
							uipanelviewmodel = 
							{
								Layout="Relative",
								nType = "3"
							},
							width = "1136",
							ZOrder = "1",
						},
						{
							controlID = "Panel_effect_Panel_root_Panel-guideView_Layer1_guide_Game",
							UUID = "e69bd011_d46f_4948_a62c_71caf7058d62",
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
							height = "270",
							ignoreSize = "False",
							name = "Panel_effect",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							touchAble = "False",
							UILayoutViewModel = 
							{
								PositionX = 153,
								PositionY = 215,
								relativeToName = "Panel",
							},
							uipanelviewmodel = 
							{
								Layout="Absolute",
								nType = "0"
							},
							width = "270",
							ZOrder = "1",
							components = 
							{
								
								{
									controlID = "Spine_effect_Panel_effect_Panel_root_Panel-guideView_Layer1_guide_Game",
									UUID = "84d09ff5_c13d_416f_8b1d_322e738fcf7d",
									classname = "MESpine",
									dstBlendFunc = "771",
									name = "Spine_effect",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									spineModel = 
									{
										SpinePath = "effect/effects_yindao/effects_yindao",
										animationName = "effects_yindao_1",
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
										
									},
									ZOrder = "1",
								},
							},
						},
						{
							controlID = "Panel_tip_Panel_root_Panel-guideView_Layer1_guide_Game",
							UUID = "e9c85f42_0105_4b06_a6e1_6d8ac0bd207a",
							anchorPoint = "False",
							anchorPointX = "0",
							anchorPointY = "0",
							backGroundScale9Enable = "True;capInsetsX:0;capInsetsY:0;capInsetsWidth:0;capInsetsHeight:0",
							bgColorOpacity = "200",
							bIsOpenClipping = "False",
							classname = "MEPanel",
							colorType = "0;SingleColor:#FFFFFFFF;GraduallyChangingColorStart:#FFFFFFFF;GraduallyChangingColorEnd:#FFFFFFFF;vectorX:0;vectorY:0",
							DesignHeight = "640",
							DesignType = "0",
							DesignWidth = "960",
							dstBlendFunc = "771",
							height = "144",
							ignoreSize = "False",
							name = "Panel_tip",
							panelTexturePath = "ui/guide/811.png",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							touchAble = "False",
							UILayoutViewModel = 
							{
								PositionX = 261,
								PositionY = 253,
								LeftPositon = 261,
								TopPosition = 243,
								relativeToName = "Panel_root",
							},
							uipanelviewmodel = 
							{
								Layout="Absolute",
								nType = "0"
							},
							width = "600",
							ZOrder = "1",
							components = 
							{
								
								{
									controlID = "Label_tip_Panel_tip_Panel_root_Panel-guideView_Layer1_guide_Game",
									UUID = "20606007_266c_4ae1_bad4_91183d0f7921",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									classname = "MELabel",
									compPath = "luacomponents.common.MEIconLabel",
									dstBlendFunc = "771",
									FontColor = "#FF302F2F",
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
									height = "118",
									ignoreSize = "False",
									name = "Label_tip",
									nTextAlign = "0",
									nTextHAlign = "0",
									sizepercentx = "61",
									sizepercenty = "82",
									sizeType = "1",
									srcBlendFunc = "770",
									text = "안녕하세요",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionX = 300,
										PositionY = 72,
									},
									width = "366",
									ZOrder = "1",
								},
								{
									controlID = "Image_role_r_Panel_tip_Panel_root_Panel-guideView_Layer1_guide_Game",
									UUID = "68395178_fe15_48ec_88df_1647e647320f",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "200",
									ignoreSize = "True",
									name = "Image_role_r",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/guide/810.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = 600,
										PositionY = 106,
										IsPercent = true,
										PercentX = 100,
										PercentY = 73.27,
									},
									width = "246",
									ZOrder = "1",
								},
								{
									controlID = "Image_role_l_Panel_tip_Panel_root_Panel-guideView_Layer1_guide_Game",
									UUID = "7a486df0_bdb6_47bd_a951_0da4bf22e340",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									flipX = "True",
									height = "200",
									ignoreSize = "True",
									name = "Image_role_l",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/guide/809.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionY = 106,
									},
									visible = "False",
									width = "246",
									ZOrder = "1",
								},
							},
						},
						{
							controlID = "Label_continue_Panel_root_Panel-guideView_Layer1_guide_Game",
							UUID = "9a7eae91_4d74_4700_b5d4_27af72f432ac",
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
							fontSize = "28",
							fontStroke = 
							{
								IsStroke = true,
								StrokeColor = "#FFFE3A72",
								StrokeSize = 1,
							},
							height = "34",
							ignoreSize = "True",
							name = "Label_continue",
							nTextAlign = "1",
							nTextHAlign = "1",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "770",
							text = "-터치하여 계속하기-",
							touchAble = "False",
							touchScaleEnable = "False",
							UILayoutViewModel = 
							{
								PositionX = 568,
								PositionY = 72,
								LeftPositon = 499,
								TopPosition = 547,
								relativeToName = "Panel",
							},
							width = "244",
							ZOrder = "1",
						},
						{
							controlID = "Button_skip_Panel_root_Panel-guideView_Layer1_guide_Game",
							UUID = "39339a9a_56b3_4493_9f78_cf6862118e87",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							backGroundScale9Enable = "False",
							classname = "MEButton",
							ClickHighLightEnabled = "True",
							dstBlendFunc = "771",
							flipX = "False",
							flipY = "False",
							height = "34",
							ignoreSize = "True",
							name = "Button_skip",
							normal = "ui/guide/807.png",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							touchAble = "True",
							UILayoutViewModel = 
							{
								PositionX = 1080,
								PositionY = 599,
								LeftPositon = 1065,
								TopPosition = 24,
								relativeToName = "Panel",
							},
							UItype = "Button",
							width = "30",
							ZOrder = "1",
							components = 
							{
								
								{
									controlID = "Label_skip_Button_skip_Panel_root_Panel-guideView_Layer1_guide_Game",
									UUID = "a6446a68_ac7d_4d80_b20c_dc4e598077e0",
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
									fontSize = "28",
									fontStroke = 
									{
										IsStroke = true,
										StrokeColor = "#FFFE3A72",
										StrokeSize = 1,
									},
									height = "34",
									ignoreSize = "True",
									name = "Label_skip",
									nTextAlign = "1",
									nTextHAlign = "1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "스킵",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionX = -49,
										relativeToName = "Panel",
									},
									width = "51",
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
			"ui/guide/811.png",
			"ui/guide/810.png",
			"ui/guide/809.png",
			"ui/guide/807.png",
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

