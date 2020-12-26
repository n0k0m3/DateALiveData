local t = 
{
	version = 1,
	components = 
	{
		
		{
			controlID = "Panel-titleDetailView_Layer1_playerInfo_Game",
			UUID = "82e7479a_7586_4771_aa2a_a610bbf49786",
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
					controlID = "Panel_base_Panel-titleDetailView_Layer1_playerInfo_Game",
					UUID = "a75724b0_dd32_4919_9d6e_4e842822a9ae",
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
					name = "Panel_base",
					sizepercentx = "0",
					sizepercenty = "0",
					sizeType = "0",
					srcBlendFunc = "1",
					touchAble = "False",
					UILayoutViewModel = 
					{
						PositionX = -58,
						PositionY = 35,
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
							controlID = "Panel_backgrund_Panel_base_Panel-titleDetailView_Layer1_playerInfo_Game",
							UUID = "e34ab2bf_ab8e_48ba_8691_c068e6d3646a",
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
							height = "260",
							ignoreSize = "False",
							name = "Panel_backgrund",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							touchAble = "True",
							UILayoutViewModel = 
							{
								PositionX = 568,
								PositionY = 304,
							},
							uipanelviewmodel = 
							{
								Layout="Absolute",
								nType = "0"
							},
							width = "500",
							ZOrder = "1",
							components = 
							{
								
								{
									controlID = "Image_evaluationViewEx_1_Panel_backgrund_Panel_base_Panel-titleDetailView_Layer1_playerInfo_Game",
									UUID = "bfa957a0_78fb_44e1_a89a_b5cee475ce84",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "True;capInsetsX:0;capInsetsY:0;capInsetsWidth:0;capInsetsHeight:0",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "410",
									ignoreSize = "False",
									name = "Image_evaluationViewEx_1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/common/pop_ui/pop_bg_01.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionY = -1,
									},
									width = "538",
									ZOrder = "1",
								},
								{
									controlID = "Image_evaluationViewEx_2_Panel_backgrund_Panel_base_Panel-titleDetailView_Layer1_playerInfo_Game",
									UUID = "6bd05384_bc39_4f85_9cfb_4e6c5bb03a6b",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "333",
									ignoreSize = "False",
									name = "Image_evaluationViewEx_2",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/common/pop_ui/pop_bg_02.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionY = -14,
									},
									width = "514",
									ZOrder = "1",
								},
							},
						},
						{
							controlID = "Label_title_Panel_base_Panel-titleDetailView_Layer1_playerInfo_Game",
							UUID = "d1b8b3c4_9862_4254_8d05_82e0449eabcc",
							anchorPoint = "False",
							anchorPointX = "0",
							anchorPointY = "0.5",
							classname = "MELabel",
							compPath = "luacomponents.common.MEIconLabel",
							dstBlendFunc = "771",
							FontColor = "#FF30354A",
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
							height = "30",
							ignoreSize = "True",
							name = "Label_title",
							nTextAlign = "1",
							nTextHAlign = "1",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "770",
							text = "Titel-Info",
							touchAble = "False",
							touchScaleEnable = "False",
							UILayoutViewModel = 
							{
								PositionX = 315,
								PositionY = 477,
							},
							width = "130",
							ZOrder = "1",
						},
						{
							controlID = "Image_line_Panel_base_Panel-titleDetailView_Layer1_playerInfo_Game",
							UUID = "14b2d9f7_a390_4422_bb65_a4618ddc1073",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							backGroundScale9Enable = "False",
							classname = "MEImage",
							dstBlendFunc = "771",
							height = "26",
							ignoreSize = "True",
							name = "Image_line",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							texturePath = "ui/common/pop_ui/pop_ui_02.png",
							touchAble = "False",
							UILayoutViewModel = 
							{
								PositionX = 425,
								PositionY = 480,
							},
							visible = "False",
							width = "2",
							ZOrder = "1",
						},
						{
							controlID = "Label_title_english_Panel_base_Panel-titleDetailView_Layer1_playerInfo_Game",
							UUID = "d67e939e_420f_49f9_a197_452b9a6d9813",
							anchorPoint = "False",
							anchorPointX = "0",
							anchorPointY = "0.5",
							classname = "MELabel",
							compPath = "luacomponents.common.MEIconLabel",
							dstBlendFunc = "771",
							FontColor = "#FF30354A",
							fontName = "font/fangzheng_zhunyuan.ttf",
							fontShadow = 
							{
								IsShadow = false,
								ShadowColor = "#FFFFFFFF",
								ShadowAlpha = 255,
								OffsetX = 0,
								OffsetY = 0,
							},
							fontSize = "14",
							fontStroke = 
							{
								IsStroke = false,
								StrokeColor = "#FFE6E6E6",
								StrokeSize = 1,
							},
							height = "16",
							ignoreSize = "True",
							name = "Label_title_english",
							nTextAlign = "1",
							nTextHAlign = "1",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "770",
							text = "Title Description",
							touchAble = "False",
							touchScaleEnable = "False",
							UILayoutViewModel = 
							{
								PositionX = 428,
								PositionY = 474,
							},
							visible = "False",
							width = "100",
							ZOrder = "1",
						},
						{
							controlID = "Button_close_Panel_base_Panel-titleDetailView_Layer1_playerInfo_Game",
							UUID = "908a2385_a861_4760_bb3d_b523bb7bfc25",
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
							name = "Button_close",
							normal = "ui/common/pop_ui/pop_btn_02.png",
							pressed = "ui/common/pop_ui/pop_btn_02.png",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							touchAble = "True",
							UILayoutViewModel = 
							{
								PositionX = 804,
								PositionY = 479,
							},
							UItype = "Button",
							width = "60",
							ZOrder = "1",
						},
						{
							controlID = "Label_percent_title_Panel_base_Panel-titleDetailView_Layer1_playerInfo_Game",
							UUID = "81c5b0dd_69e6_456b_8cea_771d82de42d1",
							anchorPoint = "False",
							anchorPointX = "0",
							anchorPointY = "1",
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
							name = "Label_percent_title",
							nTextAlign = "0",
							nTextHAlign = "0",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "770",
							text = "Fortschritt",
							touchAble = "False",
							touchScaleEnable = "False",
							UILayoutViewModel = 
							{
								PositionX = 331,
								PositionY = 445,
							},
							width = "97",
							ZOrder = "1",
							components = 
							{
								
								{
									controlID = "Image_titleDetailView_1_Label_percent_title_Panel_base_Panel-titleDetailView_Layer1_playerInfo_Game",
									UUID = "4a3e12b8_a95d_40c7_936f_a050aebd398f",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "13",
									ignoreSize = "True",
									name = "Image_titleDetailView_1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/common/page_flag.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = -8,
										PositionY = -13,
									},
									width = "13",
									ZOrder = "1",
								},
							},
						},
						{
							controlID = "Label_percent_Panel_base_Panel-titleDetailView_Layer1_playerInfo_Game",
							UUID = "546f18bf_5fd7_465f_97e9_f7b4382a819c",
							anchorPoint = "False",
							anchorPointX = "0",
							anchorPointY = "1",
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
							name = "Label_percent",
							nTextAlign = "0",
							nTextHAlign = "0",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "770",
							text = "Fortschritt",
							touchAble = "False",
							touchScaleEnable = "False",
							UILayoutViewModel = 
							{
								PositionX = 441,
								PositionY = 445,
							},
							width = "97",
							ZOrder = "1",
						},
						{
							controlID = "Label_get_desc_title_Panel_base_Panel-titleDetailView_Layer1_playerInfo_Game",
							UUID = "b023133b_bf5d_49a5_a477_ac3bf9a242e0",
							anchorPoint = "False",
							anchorPointX = "0",
							anchorPointY = "1",
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
							name = "Label_get_desc_title",
							nTextAlign = "0",
							nTextHAlign = "0",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "770",
							text = "Wie erhält man",
							touchAble = "False",
							touchScaleEnable = "False",
							UILayoutViewModel = 
							{
								PositionX = 331,
								PositionY = 400,
							},
							width = "137",
							ZOrder = "1",
							components = 
							{
								
								{
									controlID = "Image_titleDetailView_1_Label_get_desc_title_Panel_base_Panel-titleDetailView_Layer1_playerInfo_Game",
									UUID = "ac14f6c6_e9e8_4c1a_9121_06839c709a44",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "13",
									ignoreSize = "True",
									name = "Image_titleDetailView_1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/common/page_flag.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = -8,
										PositionY = -12,
									},
									width = "13",
									ZOrder = "1",
								},
							},
						},
						{
							controlID = "Label_get_desc_Panel_base_Panel-titleDetailView_Layer1_playerInfo_Game",
							UUID = "35ed1bf2_12d7_4b83_9065_f6ccfdd6e8d0",
							anchorPoint = "False",
							anchorPointX = "0",
							anchorPointY = "1",
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
							name = "Label_get_desc",
							nTextAlign = "0",
							nTextHAlign = "0",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "770",
							text = "Erhalten durch Abschluss aller Stufen",
							touchAble = "False",
							touchScaleEnable = "False",
							UILayoutViewModel = 
							{
								PositionX = 470,
								PositionY = 399,
							},
							width = "331",
							ZOrder = "1",
						},
						{
							controlID = "Label_tips_Panel_base_Panel-titleDetailView_Layer1_playerInfo_Game",
							UUID = "35307782_c546_44cd_844b_8da30e194839",
							anchorPoint = "False",
							anchorPointX = "0",
							anchorPointY = "1",
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
							name = "Label_tips",
							nTextAlign = "0",
							nTextHAlign = "0",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "770",
							text = "Dieser Titel kann auf dem Chat-Bildschirm angezeigt werden",
							touchAble = "False",
							touchScaleEnable = "False",
							UILayoutViewModel = 
							{
								PositionX = 331,
								PositionY = 310,
							},
							width = "495",
							ZOrder = "1",
							components = 
							{
								
								{
									controlID = "Image_titleDetailView_1_Label_tips_Panel_base_Panel-titleDetailView_Layer1_playerInfo_Game",
									UUID = "8f2b4a77_97da_476a_8e9c_6ff943cb72f3",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "13",
									ignoreSize = "True",
									name = "Image_titleDetailView_1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/common/page_flag.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = -5,
										PositionY = -12,
									},
									width = "13",
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
			"ui/common/pop_ui/pop_bg_01.png",
			"ui/common/pop_ui/pop_bg_02.png",
			"ui/common/pop_ui/pop_ui_02.png",
			"ui/common/pop_ui/pop_btn_02.png",
			"ui/common/page_flag.png",
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

