local t = 
{
	version = 1,
	components = 
	{
		
		{
			controlID = "Panel-duanwuPop2_duanwu_activity_activity_Game",
			UUID = "7cabf2c5_fc08_4e8b_8d47_625aff73796f",
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
					controlID = "Panel_base_Panel-duanwuPop2_duanwu_activity_activity_Game",
					UUID = "f6f6f148_1c77_4449_bf61_6a15e016fa8c",
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
							controlID = "Image_bg_Panel_base_Panel-duanwuPop2_duanwu_activity_activity_Game",
							UUID = "d4dbcecd_27e7_41e0_b450_3943bc2d6345",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							backGroundScale9Enable = "False",
							classname = "MEImage",
							dstBlendFunc = "771",
							height = "321",
							ignoreSize = "True",
							name = "Image_bg",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							texturePath = "ui/activity/duanwu_mfdzz/pop/bg.png",
							touchAble = "True",
							UILayoutViewModel = 
							{
								PositionX = 578,
								PositionY = 321,
							},
							width = "537",
							ZOrder = "1",
						},
						{
							controlID = "Label_title_Panel_base_Panel-duanwuPop2_duanwu_activity_activity_Game",
							UUID = "76a00520_4ad4_4cb0_84cc_1d7e706bce7b",
							anchorPoint = "False",
							anchorPointX = "0",
							anchorPointY = "0.5",
							classname = "MELabel",
							compPath = "luacomponents.common.MEIconLabel",
							dstBlendFunc = "771",
							FontColor = "#FF912325",
							fontName = "font/MFLiHei_Noncommercial.ttf",
							fontShadow = 
							{
								IsShadow = false,
								ShadowColor = "#FFFFFFFF",
								ShadowAlpha = 255,
								OffsetX = 0,
								OffsetY = 0,
							},
							fontSize = "30",
							fontStroke = 
							{
								IsStroke = false,
								StrokeColor = "#FFE6E6E6",
								StrokeSize = 1,
							},
							height = "37",
							ignoreSize = "True",
							name = "Label_title",
							nTextAlign = "1",
							nTextHAlign = "1",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "770",
							text = "提示",
							touchAble = "False",
							touchScaleEnable = "False",
							UILayoutViewModel = 
							{
								PositionX = 322,
								PositionY = 449,
							},
							width = "62",
							ZOrder = "1",
						},
						{
							controlID = "Button_close_Panel_base_Panel-duanwuPop2_duanwu_activity_activity_Game",
							UUID = "7a8a634b_b3b9_4ee2_850b_77a609be5f29",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							backGroundScale9Enable = "False",
							classname = "MEButton",
							ClickHighLightEnabled = "True",
							dstBlendFunc = "771",
							flipX = "False",
							flipY = "False",
							height = "28",
							ignoreSize = "True",
							name = "Button_close",
							normal = "ui/activity/duanwu_mfdzz/fortReady/close.png",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							touchAble = "True",
							UILayoutViewModel = 
							{
								PositionX = 816,
								PositionY = 453,
							},
							UItype = "Button",
							width = "28",
							ZOrder = "1",
						},
						{
							controlID = "Label_1_Panel_base_Panel-duanwuPop2_duanwu_activity_activity_Game",
							UUID = "970efba2_c916_4a50_8f28_5646ac2e2d2a",
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
							name = "Label_1",
							nTextAlign = "1",
							nTextHAlign = "1",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "770",
							text = "是否设置支援角色？",
							touchAble = "False",
							touchScaleEnable = "False",
							UILayoutViewModel = 
							{
								PositionX = 571,
								PositionY = 406,
							},
							width = "190",
							ZOrder = "1",
						},
						{
							controlID = "Label_2_Panel_base_Panel-duanwuPop2_duanwu_activity_activity_Game",
							UUID = "99c818e2_773e_4852_9b7a_f4f13f10dceb",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							classname = "MELabel",
							compPath = "luacomponents.common.MEIconLabel",
							dstBlendFunc = "771",
							FontColor = "#FFE79B17",
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
							name = "Label_2",
							nTextAlign = "1",
							nTextHAlign = "1",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "770",
							text = "支援角色可正常进行探索",
							touchAble = "False",
							touchScaleEnable = "False",
							UILayoutViewModel = 
							{
								PositionX = 559,
								PositionY = 248,
							},
							width = "246",
							ZOrder = "1",
						},
						{
							controlID = "Button_cancel_Panel_base_Panel-duanwuPop2_duanwu_activity_activity_Game",
							UUID = "a670f6dc_7261_4164_be4e_65ac16bbb363",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							backGroundScale9Enable = "False",
							classname = "MEButton",
							ClickHighLightEnabled = "True",
							dstBlendFunc = "771",
							flipX = "False",
							flipY = "False",
							height = "63",
							ignoreSize = "True",
							name = "Button_cancel",
							normal = "ui/activity/duanwu_mfdzz/fortReady/button.png",
							scaleX = "0.8",
							scaleY = "0.8",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							touchAble = "True",
							UILayoutViewModel = 
							{
								PositionX = 389,
								PositionY = 199,
							},
							UItype = "Button",
							width = "139",
							ZOrder = "1",
							components = 
							{
								
								{
									controlID = "Label_btn_Button_cancel_Panel_base_Panel-duanwuPop2_duanwu_activity_activity_Game",
									UUID = "b057c977_c04e_4135_9f06_2271baab0f81",
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
									name = "Label_btn",
									nTextAlign = "1",
									nTextHAlign = "1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "取消",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										
									},
									width = "50",
									ZOrder = "1",
								},
							},
						},
						{
							controlID = "Button_sure_Panel_base_Panel-duanwuPop2_duanwu_activity_activity_Game",
							UUID = "7cec0e12_0e2d_4986_9b6f_8a86f7597bac",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							backGroundScale9Enable = "False",
							classname = "MEButton",
							ClickHighLightEnabled = "True",
							dstBlendFunc = "771",
							flipX = "False",
							flipY = "False",
							height = "63",
							ignoreSize = "True",
							name = "Button_sure",
							normal = "ui/activity/duanwu_mfdzz/fortReady/button.png",
							scaleX = "0.8",
							scaleY = "0.8",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							touchAble = "True",
							UILayoutViewModel = 
							{
								PositionX = 770,
								PositionY = 198,
							},
							UItype = "Button",
							width = "139",
							ZOrder = "1",
							components = 
							{
								
								{
									controlID = "Label_btn_Button_sure_Panel_base_Panel-duanwuPop2_duanwu_activity_activity_Game",
									UUID = "a2d7c7c3_90cc_4e1e_8681_5af6925761b1",
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
									name = "Label_btn",
									nTextAlign = "1",
									nTextHAlign = "1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "确定",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										
									},
									width = "51",
									ZOrder = "1",
								},
							},
						},
						{
							controlID = "Panel_role_Panel_base_Panel-duanwuPop2_duanwu_activity_activity_Game",
							UUID = "15bf784f_ff0a_453e_88b7_e0cdeed46033",
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
							height = "89",
							ignoreSize = "False",
							name = "Panel_role",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							touchAble = "False",
							UILayoutViewModel = 
							{
								PositionX = 524,
								PositionY = 284,
							},
							uipanelviewmodel = 
							{
								Layout="Absolute",
								nType = "0"
							},
							width = "89",
							ZOrder = "1",
							components = 
							{
								
								{
									controlID = "Image_headBg_Panel_role_Panel_base_Panel-duanwuPop2_duanwu_activity_activity_Game",
									UUID = "cb90404f_97d8_478a_9881_c8c002669ad0",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "110",
									ignoreSize = "True",
									name = "Image_headBg",
									scaleX = "0.8",
									scaleY = "0.8",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/common/frame_normal.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = 45,
										PositionY = 44,
									},
									width = "110",
									ZOrder = "1",
								},
								{
									controlID = "ClippingNode_head_Panel_role_Panel_base_Panel-duanwuPop2_duanwu_activity_activity_Game",
									UUID = "96b45b73_4102_46d8_ab35_98237b154397",
									anchorPoint = "False",
									anchorPointX = "0",
									anchorPointY = "0",
									classname = "MEClippingNode",
									clipNodeX = "0",
									clipNodeY = "0",
									dstBlendFunc = "771",
									height = "100",
									ignoreSize = "False",
									name = "ClippingNode_head",
									scaleX = "0.9",
									scaleY = "0.9",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									stencilPath = "icon/hero/mask/01.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = 45,
										PositionY = 44,
										relativeToName = "Panel",
									},
									width = "100",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "Image_icon_ClippingNode_head_Panel_role_Panel_base_Panel-duanwuPop2_duanwu_activity_activity_Game",
											UUID = "22b587e8_7102_4901_9ab7_f1f4b33ad94d",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											classname = "MEImage",
											dstBlendFunc = "771",
											height = "92",
											ignoreSize = "True",
											name = "Image_icon",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											texturePath = "icon/hero/face/1104011.png",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = -32,
											},
											width = "156",
											ZOrder = "1",
										},
									},
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
			"ui/activity/duanwu_mfdzz/pop/bg.png",
			"ui/activity/duanwu_mfdzz/fortReady/close.png",
			"ui/activity/duanwu_mfdzz/fortReady/button.png",
			"ui/common/frame_normal.png",
			"icon/hero/face/1104011.png",
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

