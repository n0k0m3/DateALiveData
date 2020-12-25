local t = 
{
	version = 1,
	components = 
	{
		
		{
			controlID = "Panel-SpecialMail_Layer1_mail_Game",
			UUID = "436e028e_d6a9_444a_ac30_5d71eee67dd5",
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
			sizepercentx = "100",
			sizepercenty = "100",
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
					controlID = "panel_root_Panel-SpecialMail_Layer1_mail_Game",
					UUID = "7726ed0f_c1ff_4618_b416_fda1b92329bb",
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
					height = "400",
					ignoreSize = "False",
					name = "panel_root",
					sizepercentx = "0",
					sizepercenty = "0",
					sizeType = "0",
					srcBlendFunc = "1",
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
							controlID = "img_bg_panel_root_Panel-SpecialMail_Layer1_mail_Game",
							UUID = "a43dcbe3_21de_4285_aa64_c0c194a321ca",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							backGroundScale9Enable = "False",
							classname = "MEImage",
							dstBlendFunc = "771",
							height = "612",
							ignoreSize = "True",
							name = "img_bg",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							texturePath = "ui/mail/special_mail/panel_bg.png",
							touchAble = "False",
							UILayoutViewModel = 
							{
								PositionX = -22,
							},
							width = "968",
							ZOrder = "1",
							components = 
							{
								
								{
									controlID = "btn_close_img_bg_panel_root_Panel-SpecialMail_Layer1_mail_Game",
									UUID = "bfe1728c_7ca4_4741_8582_307b9941fc4e",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEButton",
									ClickHighLightEnabled = "True",
									dstBlendFunc = "771",
									flipX = "False",
									flipY = "False",
									height = "62",
									ignoreSize = "True",
									name = "btn_close",
									normal = "ui/mail/special_mail/close_btn.png",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "True",
									UILayoutViewModel = 
									{
										PositionX = 483,
										PositionY = 242,
									},
									UItype = "Button",
									width = "63",
									ZOrder = "1",
								},
								{
									controlID = "scroll_content_img_bg_panel_root_Panel-SpecialMail_Layer1_mail_Game",
									UUID = "fa8d03aa_5fdf_47ac_b93f_38d570c280a6",
									anchorPoint = "False",
									anchorPointX = "0",
									anchorPointY = "0",
									backGroundScale9Enable = "False",
									bgColorOpacity = "50",
									bIsOpenClipping = "True",
									bounceEnable = "False",
									classname = "MEScrollView",
									colorType = "0;SingleColor:#FFE6E6E6;GraduallyChangingColorStart:#FFFFFFFF;GraduallyChangingColorEnd:#FFFFFFFF;vectorX:0;vectorY:0",
									direction = "1",
									dstBlendFunc = "771",
									height = "240",
									ignoreSize = "False",
									innerHeight = "240",
									innerWidth = "670",
									name = "scroll_content",
									showScrollbar = "False",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "True",
									UILayoutViewModel = 
									{
										PositionX = -317,
										PositionY = -136,
									},
									uipanelviewmodel = 
									{
										Layout="Absolute",
										nType = "0"
									},
									width = "670",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "txt_content_scroll_content_img_bg_panel_root_Panel-SpecialMail_Layer1_mail_Game",
											UUID = "baf11f24_439d_44f1_aaf1_08bfb4abb48d",
											anchorPoint = "False",
											anchorPointX = "0",
											anchorPointY = "1",
											classname = "MELabel",
											compPath = "luacomponents.common.MEIconLabel",
											dstBlendFunc = "771",
											FontColor = "#FF000000",
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
												IsStroke = false,
												StrokeColor = "#FFE6E6E6",
												StrokeSize = 1,
											},
											height = "0",
											ignoreSize = "False",
											name = "txt_content",
											nTextAlign = "0",
											nTextHAlign = "0",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "770",
											text = "技能描述技能描述技能描述",
											touchAble = "False",
											touchScaleEnable = "False",
											UILayoutViewModel = 
											{
												PositionY = 234,
											},
											width = "670",
											ZOrder = "1",
										},
									},
								},
								{
									controlID = "txt_time_img_bg_panel_root_Panel-SpecialMail_Layer1_mail_Game",
									UUID = "c5ed5b55_b490_4a76_92e0_640820dea0f5",
									anchorPoint = "False",
									anchorPointX = "1",
									anchorPointY = "0.5",
									classname = "MELabel",
									ColorMixing = "#FFEB3569",
									compPath = "luacomponents.common.MEIconLabel",
									dstBlendFunc = "771",
									FontColor = "#FFC0C8D0",
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
									name = "txt_time",
									nTextAlign = "1",
									nTextHAlign = "1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "发邮件时间",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionX = 397,
										PositionY = -164,
									},
									width = "102",
									ZOrder = "1",
								},
								{
									controlID = "panel_reward_img_bg_panel_root_Panel-SpecialMail_Layer1_mail_Game",
									UUID = "c978452d_904c_4b9f_a038_e765f3df6e8b",
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
									height = "80",
									ignoreSize = "False",
									name = "panel_reward",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = -359,
										PositionY = -256,
									},
									uipanelviewmodel = 
									{
										Layout="Absolute",
										nType = "0"
									},
									width = "770",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "panel_list_panel_reward_img_bg_panel_root_Panel-SpecialMail_Layer1_mail_Game",
											UUID = "1d00afc0_bdd4_4db5_873f_3a25995596ad",
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
											height = "70",
											ignoreSize = "False",
											name = "panel_list",
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
											width = "500",
											ZOrder = "1",
										},
										{
											controlID = "btn_get_panel_reward_img_bg_panel_root_Panel-SpecialMail_Layer1_mail_Game",
											UUID = "03996a8b_b49c_4119_9035_94c64a7453b9",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											classname = "MEButton",
											ClickHighLightEnabled = "True",
											dstBlendFunc = "771",
											flipX = "False",
											flipY = "False",
											height = "62",
											ignoreSize = "True",
											name = "btn_get",
											normal = "ui/mail/special_mail/get_btn.png",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "True",
											UILayoutViewModel = 
											{
												PositionX = 668,
												PositionY = 36,
											},
											UItype = "Button",
											width = "195",
											ZOrder = "1",
										},
									},
								},
							},
						},
					},
				},
				{
					controlID = "panel_item_Panel-SpecialMail_Layer1_mail_Game",
					UUID = "95b573bb_ae1a_47b4_b7ad_2cd228e9dbb3",
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
					height = "68",
					ignoreSize = "False",
					name = "panel_item",
					sizepercentx = "0",
					sizepercenty = "0",
					sizeType = "0",
					srcBlendFunc = "1",
					touchAble = "False",
					UILayoutViewModel = 
					{
						PositionX = 297,
						PositionY = -227,
						LeftPositon = 297,
						TopPosition = 799,
						relativeToName = "Panel",
						nType = 3,
					},
					uipanelviewmodel = 
					{
						Layout="Absolute",
						nType = "0"
					},
					width = "64",
					ZOrder = "1",
					components = 
					{
						
						{
							controlID = "mail_item_panel_item_Panel-SpecialMail_Layer1_mail_Game",
							UUID = "14ea5d20_739e_44ea_b041_fcdb58e171cf",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							backGroundScale9Enable = "False",
							classname = "MEImage",
							dstBlendFunc = "771",
							height = "68",
							ignoreSize = "True",
							name = "mail_item",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							texturePath = "ui/mail/special_mail/item_bg.png",
							touchAble = "False",
							UILayoutViewModel = 
							{
								PositionX = 30,
								PositionY = 34,
								LeftPositon = 304,
								TopPosition = 802,
								relativeToName = "Panel",
							},
							width = "60",
							ZOrder = "1",
							components = 
							{
								
								{
									controlID = "img_icon_mail_item_panel_item_Panel-SpecialMail_Layer1_mail_Game",
									UUID = "39e88b3a_268d_4326_8dae_e0cf05f2b332",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "100",
									ignoreSize = "True",
									name = "img_icon",
									scaleX = "0.55",
									scaleY = "0.55",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "icon/item/goods/510104.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										
									},
									width = "100",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "txt_num_img_icon_mail_item_panel_item_Panel-SpecialMail_Layer1_mail_Game",
											UUID = "f3a7f565_6cbf_444a_bb0f_47d1c79585a4",
											anchorPoint = "False",
											anchorPointX = "1",
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
												IsStroke = true,
												StrokeColor = "#FF343434",
												StrokeSize = 2,
											},
											height = "29",
											ignoreSize = "True",
											name = "txt_num",
											nTextAlign = "1",
											nTextHAlign = "1",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "770",
											text = "999",
											touchAble = "False",
											touchScaleEnable = "False",
											UILayoutViewModel = 
											{
												PositionX = 43,
												PositionY = -31,
											},
											width = "40",
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
			"ui/mail/special_mail/panel_bg.png",
			"ui/mail/special_mail/close_btn.png",
			"ui/mail/special_mail/get_btn.png",
			"ui/mail/special_mail/item_bg.png",
			"icon/item/goods/510104.png",
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

