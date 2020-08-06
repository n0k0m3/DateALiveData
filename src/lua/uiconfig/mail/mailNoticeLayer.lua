local t = 
{
	version = 1,
	components = 
	{
		
		{
			controlID = "Panel-mailNoticeLayer_Layer1_mail_Game",
			UUID = "22227ca0_02f7_4816_94fd_dd5515e37c81",
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
			width = "1386",
			ZOrder = "1",
			components = 
			{
				
				{
					controlID = "Panel_base_Panel-mailNoticeLayer_Layer1_mail_Game",
					UUID = "96360f4c_5121_42c9_bbd3_010032e0714e",
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
						PositionX = 125,
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
							controlID = "Panel_mail_Panel_base_Panel-mailNoticeLayer_Layer1_mail_Game",
							UUID = "fd9bcf0a_693a_4806_aaeb_69ed46ed8e2d",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							backGroundScale9Enable = "False",
							bgColorOpacity = "50",
							bIsOpenClipping = "False",
							classname = "MEPanel",
							colorType = "0;SingleColor:#FFFF0000;GraduallyChangingColorStart:#FFFFFFFF;GraduallyChangingColorEnd:#FFFFFFFF;vectorX:0;vectorY:0",
							DesignHeight = "640",
							DesignType = "0",
							DesignWidth = "960",
							dstBlendFunc = "771",
							height = "134",
							ignoreSize = "False",
							name = "Panel_mail",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							touchAble = "True",
							UILayoutViewModel = 
							{
								PositionX = 565,
								PositionY = 673,
								relativeToName = "Panel_base",
							},
							uipanelviewmodel = 
							{
								Layout="Absolute",
								nType = "0"
							},
							width = "872",
							ZOrder = "11",
							components = 
							{
								
								{
									controlID = "Image_bg_Panel_mail_Panel_base_Panel-mailNoticeLayer_Layer1_mail_Game",
									UUID = "fa8cfe35_0428_4cde_83c5_b35992db21f0",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "134",
									ignoreSize = "True",
									name = "Image_bg",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/mail/mail_21.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										
									},
									width = "872",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "Image_ai_icon_Image_bg_Panel_mail_Panel_base_Panel-mailNoticeLayer_Layer1_mail_Game",
											UUID = "7043bcd4_d3f0_4d9f_a12c_c34b6c889894",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											classname = "MEImage",
											dstBlendFunc = "771",
											height = "32",
											ignoreSize = "True",
											name = "Image_ai_icon",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											texturePath = "ui/mail/mail_22.png",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = -394,
												PositionY = 41,
											},
											width = "32",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "Label_ai_tip1_Image_ai_icon_Image_bg_Panel_mail_Panel_base_Panel-mailNoticeLayer_Layer1_mail_Game",
													UUID = "7e4a4dea_d5d0_495b_9180_3cc0d1f5b19c",
													anchorPoint = "False",
													anchorPointX = "0",
													anchorPointY = "0.5",
													classname = "MELabel",
													compPath = "luacomponents.common.MEIconLabel",
													dstBlendFunc = "771",
													FontColor = "#FFE34974",
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
													name = "Label_ai_tip1",
													nTextAlign = "1",
													nTextHAlign = "1",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "770",
													text = "称号红包",
													touchAble = "False",
													touchScaleEnable = "False",
													UILayoutViewModel = 
													{
														PositionX = 25,
													},
													width = "90",
													ZOrder = "1",
												},
											},
										},
										{
											controlID = "btn_qiangHongBao_Image_bg_Panel_mail_Panel_base_Panel-mailNoticeLayer_Layer1_mail_Game",
											UUID = "8bad28c0_14fc_4f87_b779_a6cdf4702d78",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											classname = "MEButton",
											ClickHighLightEnabled = "True",
											dstBlendFunc = "771",
											flipX = "False",
											flipY = "False",
											height = "52",
											HitType = 
											{
												nHitType = 1,
												nXpos = 0,
												nYpos = 0,
												nHitWidth = 198,
												nHitHeight = 52
											},
											ignoreSize = "True",
											name = "btn_qiangHongBao",
											normal = "ui/mail/mail_25.png",
											pressed = "ui/mail/mail_24.png",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "True",
											UILayoutViewModel = 
											{
												PositionX = 249,
												PositionY = 41,
											},
											UItype = "Button",
											width = "44",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "Label_ai_tip2_btn_qiangHongBao_Image_bg_Panel_mail_Panel_base_Panel-mailNoticeLayer_Layer1_mail_Game",
													UUID = "263036ec_8525_4cfa_9105_058d6bea1fcd",
													anchorPoint = "False",
													anchorPointX = "0",
													anchorPointY = "0.5",
													classname = "MELabel",
													compPath = "luacomponents.common.MEIconLabel",
													dstBlendFunc = "771",
													FontColor = "#FFE34974",
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
													name = "Label_ai_tip2",
													nTextAlign = "1",
													nTextHAlign = "1",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "770",
													text = "点击可抢红包！",
													touchAble = "False",
													touchScaleEnable = "False",
													UILayoutViewModel = 
													{
														PositionX = 25,
													},
													width = "142",
													ZOrder = "1",
												},
											},
										},
									},
								},
								{
									controlID = "Image_head_bord_Panel_mail_Panel_base_Panel-mailNoticeLayer_Layer1_mail_Game",
									UUID = "0c446529_cade_4138_814a_691ac09c546f",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "68",
									ignoreSize = "True",
									name = "Image_head_bord",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/mail/mail_23.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = -373,
										PositionY = -20,
									},
									width = "68",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "ClippingNode_player_Image_head_bord_Panel_mail_Panel_base_Panel-mailNoticeLayer_Layer1_mail_Game",
											UUID = "87094075_f148_440d_9b42_3b0bf38d529b",
											alphaThreshold = "0.65",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											classname = "MEClippingNode",
											clipNodeX = "0",
											clipNodeY = "0",
											dstBlendFunc = "771",
											height = "0",
											ignoreSize = "False",
											name = "ClippingNode_player",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											stencilPath = "ui/mainLayer/new_ui/ai_tip/004.png",
											touchAble = "False",
											UILayoutViewModel = 
											{
												
											},
											width = "0",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "Image_head_ClippingNode_player_Image_head_bord_Panel_mail_Panel_base_Panel-mailNoticeLayer_Layer1_mail_Game",
													UUID = "47a0c72c_6bd9_4100_830d_5ea5f55d5c96",
													anchorPoint = "False",
													anchorPointX = "1",
													anchorPointY = "0.5",
													backGroundScale9Enable = "False",
													classname = "MEImage",
													dstBlendFunc = "771",
													height = "92",
													ignoreSize = "True",
													name = "Image_head",
													scaleX = "0.7",
													scaleY = "0.7",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "1",
													texturePath = "icon/hero/face/1101011.png",
													touchAble = "False",
													UILayoutViewModel = 
													{
														PositionX = 30,
														PositionY = -2,
													},
													width = "156",
													ZOrder = "1",
												},
											},
										},
									},
								},
								{
									controlID = "Label_title_Panel_mail_Panel_base_Panel-mailNoticeLayer_Layer1_mail_Game",
									UUID = "824e9c95_bf43_4112_abf7_347003e2d300",
									anchorPoint = "False",
									anchorPointX = "0",
									anchorPointY = "0.5",
									classname = "MELabel",
									compPath = "luacomponents.common.MEIconLabel",
									dstBlendFunc = "771",
									FontColor = "#FFFD3E74",
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
									name = "Label_title",
									nTextAlign = "1",
									nTextHAlign = "1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "十香",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionX = -326,
										PositionY = -3,
									},
									width = "51",
									ZOrder = "1",
								},
								{
									controlID = "Label_text_Panel_mail_Panel_base_Panel-mailNoticeLayer_Layer1_mail_Game",
									UUID = "3aa30a94_c460_48ea_8bfd_b9c15b2ec2ca",
									anchorPoint = "False",
									anchorPointX = "0",
									anchorPointY = "0.5",
									classname = "MELabel",
									compPath = "luacomponents.common.MEIconLabel",
									dstBlendFunc = "771",
									FontColor = "#FFE34874",
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
									name = "Label_text",
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
										PositionX = -322,
										PositionY = -33,
									},
									width = "80",
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
			"ui/mail/mail_21.png",
			"ui/mail/mail_22.png",
			"ui/mail/mail_24.png",
			"ui/mail/mail_25.png",
			"ui/mail/mail_23.png",
			"icon/hero/face/1101011.png",
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

