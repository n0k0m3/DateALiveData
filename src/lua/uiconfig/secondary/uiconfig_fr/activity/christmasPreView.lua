local t = 
{
	version = 1,
	components = 
	{
		
		{
			controlID = "Panel-christmasPreView_Layer1_activity_Game",
			UUID = "df59e36f_456c_4b00_96cb_28f112ec7e32",
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
				
			},
			uipanelviewmodel = 
			{
				Layout="Absolute",
				nType = "0"
			},
			width = "960",
			ZOrder = "1",
			components = 
			{
				
				{
					controlID = "Panel_base_Panel-christmasPreView_Layer1_activity_Game",
					UUID = "ce1ed50e_9ffa_4626_84e7_1d79779d3bf9",
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
					height = "534",
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
							controlID = "bg_Panel_base_Panel-christmasPreView_Layer1_activity_Game",
							UUID = "bc5fe7fb_a096_4988_b475_183451553710",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							backGroundScale9Enable = "False",
							classname = "MEImage",
							dstBlendFunc = "771",
							height = "546",
							ignoreSize = "True",
							name = "bg",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "770",
							texturePath = "ui/activity/christmas_pre/bg.png",
							touchAble = "False",
							UILayoutViewModel = 
							{
								PositionX = -2,
							},
							width = "890",
							ZOrder = "1",
							components = 
							{
								
								{
									controlID = "Image_title_bg_Panel_base_Panel-christmasPreView_Layer1_activity_Game",
									UUID = "696dedd3_d6af_4aab_9651_6cc709af199a",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "80",
									ignoreSize = "True",
									name = "Image_title",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/activity/christmas_pre/t1.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = -43,
										PositionY = 64,
									},
									width = "258",
									ZOrder = "1",
								},
							},
						},
						{
							controlID = "label_time_Panel_base_Panel-christmasPreView_Layer1_activity_Game",
							UUID = "dbfd6dfd_9647_48f0_b48e_5e950e3985e9",
							anchorPoint = "False",
							anchorPointX = "0",
							anchorPointY = "0.5",
							classname = "MELabel",
							compPath = "luacomponents.common.MEIconLabel",
							dstBlendFunc = "771",
							FontColor = "#FF737594",
							fontName = "font/fangzheng_zhunyuan.ttf",
							fontShadow = 
							{
								IsShadow = false,
								ShadowColor = "#FFFFFFFF",
								ShadowAlpha = 255,
								OffsetX = 0,
								OffsetY = 0,
							},
							fontSize = "15",
							fontStroke = 
							{
								IsStroke = false,
								StrokeColor = "#FFE6E6E6",
								StrokeSize = 1,
							},
							height = "17",
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
								PositionX = -443,
								PositionY = 256,
							},
							width = "62",
							ZOrder = "1",
						},
						{
							controlID = "label_des_Panel_base_Panel-christmasPreView_Layer1_activity_Game",
							UUID = "c8113851_4339_43c0_8bff_814927c264dc",
							anchorPoint = "False",
							anchorPointX = "0",
							anchorPointY = "1",
							classname = "MELabel",
							compPath = "luacomponents.common.MEIconLabel",
							dstBlendFunc = "771",
							FontColor = "#FF737594",
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
							height = "21",
							ignoreSize = "True",
							name = "label_des",
							nTextAlign = "1",
							nTextHAlign = "0",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "770",
							text = "Les participants avec précommande peuvent profiter de l’offre spéciale, et les autres devront l’acheter au prix plein.",
							touchAble = "False",
							touchScaleEnable = "False",
							UILayoutViewModel = 
							{
								PositionX = -441,
								PositionY = -238,
							},
							width = "505",
							ZOrder = "1",
						},
						{
							controlID = "label_number_Panel_base_Panel-christmasPreView_Layer1_activity_Game",
							UUID = "5a70b79b_1563_4b58_88b4_638e16fa8598",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							classname = "MELabel",
							compPath = "luacomponents.common.MEIconLabel",
							dstBlendFunc = "771",
							FontColor = "#FFED3931",
							fontName = "font/MFLiHei_Noncommercial.ttf",
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
							height = "25",
							ignoreSize = "True",
							name = "label_number",
							nTextAlign = "1",
							nTextHAlign = "1",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "770",
							text = "3000.0",
							touchAble = "False",
							touchScaleEnable = "False",
							UILayoutViewModel = 
							{
								PositionX = 173,
								PositionY = -243,
							},
							width = "72",
							ZOrder = "1",
						},
						{
							controlID = "label_tip2_Panel_base_Panel-christmasPreView_Layer1_activity_Game",
							UUID = "ed8dd252_9e2b_4b3a_a731_01b20122cc77",
							anchorPoint = "False",
							anchorPointX = "1",
							anchorPointY = "0.5",
							classname = "MELabel",
							compPath = "luacomponents.common.MEIconLabel",
							dstBlendFunc = "771",
							FontColor = "#FF737594",
							fontName = "font/MFLiHei_Noncommercial.ttf",
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
							height = "25",
							ignoreSize = "True",
							name = "label_tip2",
							nTextAlign = "1",
							nTextHAlign = "1",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "770",
							text = "当前累计付费",
							touchAble = "False",
							touchScaleEnable = "False",
							UILayoutViewModel = 
							{
								PositionX = 234,
								PositionY = -209,
							},
							width = "124",
							ZOrder = "1",
						},
						{
							controlID = "Button_pre_Panel_base_Panel-christmasPreView_Layer1_activity_Game",
							UUID = "b3b5a1b2_8451_41ed_9c21_e844f2842e89",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							backGroundScale9Enable = "False",
							classname = "MEButton",
							ClickHighLightEnabled = "True",
							dstBlendFunc = "771",
							flipX = "False",
							flipY = "False",
							height = "72",
							ignoreSize = "True",
							name = "Button_pre",
							normal = "ui/activity/christmas_pre/a1.png",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							touchAble = "True",
							UILayoutViewModel = 
							{
								PositionX = 334,
								PositionY = -228,
							},
							UItype = "Button",
							visible = "False",
							width = "200",
							ZOrder = "1",
							components = 
							{
								
								{
									controlID = "Image_icon_Button_pre_Panel_base_Panel-christmasPreView_Layer1_activity_Game",
									UUID = "729453ea_c63d_4ed6_a34c_186d13f0f3ab",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "100",
									ignoreSize = "True",
									name = "Image_icon",
									scaleX = "0.5",
									scaleY = "0.5",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "icon/item/goods/500096.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = 13,
										PositionY = -1,
									},
									width = "100",
									ZOrder = "1",
								},
								{
									controlID = "Label_btn_Button_pre_Panel_base_Panel-christmasPreView_Layer1_activity_Game",
									UUID = "4214f4d1_de06_4eb0_aec7_39616f7115d1",
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
									fontSize = "28",
									fontStroke = 
									{
										IsStroke = true,
										StrokeColor = "#FF76310C",
										StrokeSize = 2,
									},
									height = "39",
									ignoreSize = "True",
									name = "Label_btn",
									nTextAlign = "1",
									nTextHAlign = "1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "Pré-commander",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionX = -42,
										PositionY = -3,
									},
									width = "61",
									ZOrder = "1",
								},
								{
									controlID = "Label_price_Button_pre_Panel_base_Panel-christmasPreView_Layer1_activity_Game",
									UUID = "a4fdb6fc_a40f_42e0_92cf_5cea64d5b97a",
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
										StrokeColor = "#FF76310C",
										StrokeSize = 2,
									},
									height = "36",
									ignoreSize = "True",
									name = "Label_price",
									nTextAlign = "1",
									nTextHAlign = "1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "999.0",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionX = 60,
										PositionY = -1,
									},
									width = "49",
									ZOrder = "1",
								},
							},
						},
						{
							controlID = "Button_sell_Panel_base_Panel-christmasPreView_Layer1_activity_Game",
							UUID = "1a2a000c_6855_4906_bd6b_dcd98596209b",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							backGroundScale9Enable = "False",
							classname = "MEButton",
							ClickHighLightEnabled = "True",
							dstBlendFunc = "771",
							flipX = "False",
							flipY = "False",
							height = "72",
							ignoreSize = "True",
							name = "Button_sell",
							normal = "ui/activity/christmas_pre/a1.png",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							touchAble = "True",
							UILayoutViewModel = 
							{
								PositionX = 334,
								PositionY = -226,
							},
							UItype = "Button",
							width = "200",
							ZOrder = "1",
							components = 
							{
								
								{
									controlID = "Image_icon_Button_sell_Panel_base_Panel-christmasPreView_Layer1_activity_Game",
									UUID = "058cb340_a1c1_4011_9bcd_298a46f4e6f6",
									anchorPoint = "False",
									anchorPointX = "1",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "100",
									ignoreSize = "True",
									name = "Image_icon",
									scaleX = "0.5",
									scaleY = "0.5",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "icon/item/goods/510101.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionY = 1,
									},
									width = "100",
									ZOrder = "1",
								},
								{
									controlID = "Label_price_Button_sell_Panel_base_Panel-christmasPreView_Layer1_activity_Game",
									UUID = "e5e9edde_6f45_4f7f_9547_3b0bd845d6f8",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									classname = "MELabel",
									compPath = "luacomponents.common.MEIconLabel",
									dstBlendFunc = "771",
									FontColor = "#FFFFC1BE",
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
										IsStroke = true,
										StrokeColor = "#FF851913",
										StrokeSize = 2,
									},
									height = "31",
									ignoreSize = "True",
									name = "Label_price",
									nTextAlign = "1",
									nTextHAlign = "1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "9999.0",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										
									},
									width = "56",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "Image_dis_Label_price_Button_sell_Panel_base_Panel-christmasPreView_Layer1_activity_Game",
											UUID = "78ec33a6_366f_4d9b_88bf_847d37f7dea3",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											classname = "MEImage",
											dstBlendFunc = "771",
											height = "2",
											ignoreSize = "True",
											name = "Image_dis",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											texturePath = "ui/activity/christmas_pre/a4.png",
											touchAble = "False",
											UILayoutViewModel = 
											{
												
											},
											width = "50",
											ZOrder = "1",
										},
									},
								},
								{
									controlID = "Label_cur_price_Button_sell_Panel_base_Panel-christmasPreView_Layer1_activity_Game",
									UUID = "c33172c0_fbc7_4476_9678_736833075426",
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
									fontSize = "24",
									fontStroke = 
									{
										IsStroke = true,
										StrokeColor = "#FF851913",
										StrokeSize = 2,
									},
									height = "31",
									ignoreSize = "True",
									name = "Label_cur_price",
									nTextAlign = "1",
									nTextHAlign = "1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "32000.0",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionX = 25,
									},
									width = "70",
									ZOrder = "1",
								},
							},
						},
						{
							controlID = "Image_bar_Panel_base_Panel-christmasPreView_Layer1_activity_Game",
							UUID = "47719ec8_5df1_4735_a446_792d31a0e82e",
							anchorPoint = "False",
							anchorPointX = "0",
							anchorPointY = "0.5",
							backGroundScale9Enable = "False",
							classname = "MEImage",
							dstBlendFunc = "771",
							height = "18",
							ignoreSize = "True",
							name = "Image_bar",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							texturePath = "ui/activity/christmas_pre/a5.png",
							touchAble = "False",
							UILayoutViewModel = 
							{
								PositionX = -433,
								PositionY = -218,
							},
							width = "472",
							ZOrder = "1",
							components = 
							{
								
								{
									controlID = "LoadingBar_Image_bar_Panel_base_Panel-christmasPreView_Layer1_activity_Game",
									UUID = "9acb6c8b_9381_4288_bc81_d67efa616189",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MELoadingBar",
									direction = "0",
									dstBlendFunc = "771",
									height = "22",
									ignoreSize = "True",
									name = "LoadingBar",
									percent = "100",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texture = "ui/activity/christmas_pre/a6.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = 236,
										PositionY = -6,
										IsPercent = true,
										PercentX = 50.05,
										PercentY = -33.28,
									},
									width = "464",
									ZOrder = "1",
								},
								{
									controlID = "Panel_items_Image_bar_Panel_base_Panel-christmasPreView_Layer1_activity_Game",
									UUID = "77a65c7c_915a_42df_bde1_d0bee8fa5ad4",
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
									height = "214",
									ignoreSize = "False",
									name = "Panel_items",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = 113,
										PositionY = 75,
									},
									uipanelviewmodel = 
									{
										Layout="Absolute",
										nType = "0"
									},
									visible = "False",
									width = "200",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "Image_goodbg_Panel_items_Image_bar_Panel_base_Panel-christmasPreView_Layer1_activity_Game",
											UUID = "8ebff456_f159_4ea6_83a3_5b9da23968a4",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											classname = "MEImage",
											dstBlendFunc = "771",
											height = "120",
											ignoreSize = "True",
											name = "Image_goodbg",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											texturePath = "ui/activity/christmas_pre/m1.png",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = -2,
												PositionY = -25,
											},
											width = "106",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "Image_geted_Image_goodbg_Panel_items_Image_bar_Panel_base_Panel-christmasPreView_Layer1_activity_Game",
													UUID = "d8e8695d_02be_4bd9_8eb6_2301d73a5dc6",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0.5",
													backGroundScale9Enable = "False",
													classname = "MEImage",
													dstBlendFunc = "771",
													height = "120",
													ignoreSize = "True",
													name = "Image_geted",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "1",
													texturePath = "ui/activity/christmas_pre/m2.png",
													touchAble = "False",
													UILayoutViewModel = 
													{
														PositionY = -1,
													},
													visible = "False",
													width = "106",
													ZOrder = "1",
													components = 
													{
														
														{
															controlID = "Label_get_num_Image_geted_Image_goodbg_Panel_items_Image_bar_Panel_base_Panel-christmasPreView_Layer1_activity_Game",
															UUID = "2598d79c_0c76_45e3_a216_75cfc8b01a37",
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
															fontSize = "22",
															fontStroke = 
															{
																IsStroke = false,
																StrokeColor = "#FFE6E6E6",
																StrokeSize = 1,
															},
															height = "27",
															ignoreSize = "True",
															name = "Label_get_num",
															nTextAlign = "1",
															nTextHAlign = "1",
															rotation = "-30",
															sizepercentx = "0",
															sizepercenty = "0",
															sizeType = "0",
															srcBlendFunc = "770",
															text = "Réussi",
															touchAble = "False",
															touchScaleEnable = "False",
															UILayoutViewModel = 
															{
																PositionY = 11,
															},
															width = "68",
															ZOrder = "1",
														},
													},
												},
												{
													controlID = "Image_ing_Image_goodbg_Panel_items_Image_bar_Panel_base_Panel-christmasPreView_Layer1_activity_Game",
													UUID = "cb119cd8_5a7e_4800_bcf0_cb7536b01082",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0.5",
													backGroundScale9Enable = "False",
													classname = "MEImage",
													dstBlendFunc = "771",
													height = "120",
													ignoreSize = "True",
													name = "Image_ing",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "1",
													texturePath = "ui/activity/christmas_pre/m1.png",
													touchAble = "False",
													UILayoutViewModel = 
													{
														PositionY = -1,
													},
													width = "106",
													ZOrder = "1",
													components = 
													{
														
														{
															controlID = "Label_ing_num_Image_ing_Image_goodbg_Panel_items_Image_bar_Panel_base_Panel-christmasPreView_Layer1_activity_Game",
															UUID = "a54fc5e8_fc98_441c_bd72_76f4a3e26d8f",
															anchorPoint = "False",
															anchorPointX = "0.5",
															anchorPointY = "0.5",
															classname = "MELabel",
															compPath = "luacomponents.common.MEIconLabel",
															dstBlendFunc = "771",
															FontColor = "#FF737594",
															fontName = "font/MFLiHei_Noncommercial.ttf",
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
															height = "27",
															ignoreSize = "True",
															name = "Label_ing_num",
															nTextAlign = "1",
															nTextHAlign = "1",
															rotation = "-30",
															sizepercentx = "0",
															sizepercenty = "0",
															sizeType = "0",
															srcBlendFunc = "770",
															text = "8折",
															touchAble = "False",
															touchScaleEnable = "False",
															UILayoutViewModel = 
															{
																PositionY = 11,
															},
															width = "44",
															ZOrder = "1",
														},
													},
												},
											},
										},
										{
											controlID = "Label_personNum_Panel_items_Image_bar_Panel_base_Panel-christmasPreView_Layer1_activity_Game",
											UUID = "4ad3c738_ea3b_47c3_afcc_4e04dd679100",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											classname = "MELabel",
											compPath = "luacomponents.common.MEIconLabel",
											dstBlendFunc = "771",
											FontColor = "#FFFAF4F8",
											fontName = "font/MFLiHei_Noncommercial.ttf",
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
												StrokeColor = "#FF30354A",
												StrokeSize = 1,
											},
											height = "24",
											ignoreSize = "True",
											name = "Label_personNum",
											nTextAlign = "1",
											nTextHAlign = "1",
											rotation = "-30",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "770",
											text = "500.0",
											touchAble = "False",
											touchScaleEnable = "False",
											UILayoutViewModel = 
											{
												PositionX = 15,
												PositionY = -44,
											},
											width = "69",
											ZOrder = "1",
										},
									},
								},
							},
						},
						{
							controlID = "Image_bought_Panel_base_Panel-christmasPreView_Layer1_activity_Game",
							UUID = "2314c27e_e118_449c_9b85_e8910079dd35",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							backGroundScale9Enable = "False",
							classname = "MEImage",
							dstBlendFunc = "771",
							height = "72",
							ignoreSize = "True",
							name = "Image_bought",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							texturePath = "ui/activity/christmas_pre/a1.png",
							touchAble = "True",
							UILayoutViewModel = 
							{
								PositionX = 334,
								PositionY = -226,
							},
							visible = "False",
							width = "200",
							ZOrder = "1",
							components = 
							{
								
								{
									controlID = "Label_tip_Image_bought_Panel_base_Panel-christmasPreView_Layer1_activity_Game",
									UUID = "6a700bdb_d567_4d28_b1f9_2238ac699e23",
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
									fontSize = "30",
									fontStroke = 
									{
										IsStroke = true,
										StrokeColor = "#FF76310C",
										StrokeSize = 2,
									},
									height = "41",
									ignoreSize = "True",
									name = "Label_tip",
									nTextAlign = "1",
									nTextHAlign = "1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "Acheté",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										
									},
									width = "95",
									ZOrder = "1",
								},
							},
						},
						{
							controlID = "Image_discount_Panel_base_Panel-christmasPreView_Layer1_activity_Game",
							UUID = "2143a114_31f3_4ed0_89db_c4417374a3ce",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							backGroundScale9Enable = "False",
							classname = "MEImage",
							dstBlendFunc = "771",
							height = "121",
							ignoreSize = "True",
							name = "Image_discount",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							texturePath = "ui/activity/christmas_pre/z1.png",
							touchAble = "False",
							UILayoutViewModel = 
							{
								PositionX = 57,
								PositionY = -187,
							},
							width = "125",
							ZOrder = "1",
						},
						{
							controlID = "label_des_ex_Panel_base_Panel-christmasPreView_Layer1_activity_Game",
							UUID = "b962648f_4328_4730_9543_f62b02ed58ef",
							anchorPoint = "False",
							anchorPointX = "0",
							anchorPointY = "1",
							classname = "MELabel",
							compPath = "luacomponents.common.MEIconLabel",
							dstBlendFunc = "771",
							FontColor = "#FF737594",
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
							height = "21",
							ignoreSize = "True",
							name = "label_des_ex",
							nTextAlign = "1",
							nTextHAlign = "0",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "770",
							text = "Description",
							touchAble = "False",
							touchScaleEnable = "False",
							UILayoutViewModel = 
							{
								PositionX = -231,
								PositionY = 267,
							},
							width = "39",
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
			"ui/activity/christmas_pre/bg.png",
			"ui/activity/christmas_pre/t1.png",
			"ui/activity/christmas_pre/a1.png",
			"icon/item/goods/500096.png",
			"icon/item/goods/510101.png",
			"ui/activity/christmas_pre/a4.png",
			"ui/activity/christmas_pre/a5.png",
			"ui/activity/christmas_pre/a6.png",
			"ui/activity/christmas_pre/m1.png",
			"ui/activity/christmas_pre/m2.png",
			"ui/activity/christmas_pre/z1.png",
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

