local t = 
{
	version = 1,
	components = 
	{
		
		{
			controlID = "Panel-kabalaTreeStore_Layer1_kabalaTree_Game",
			UUID = "3d530f36_7d56_47d6_bfe7_884cdf4f2dc4",
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
					controlID = "Panel_root_Panel-kabalaTreeStore_Layer1_kabalaTree_Game",
					UUID = "da26a619_adae_441e_99bb_904d81234d13",
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
							controlID = "Panel_ItemBg_Panel_root_Panel-kabalaTreeStore_Layer1_kabalaTree_Game",
							UUID = "1fb88ba9_f845_48e1_8505_c219d8ef926d",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0",
							backGroundScale9Enable = "False",
							bgColorOpacity = "50",
							bIsOpenClipping = "False",
							classname = "MEPanel",
							colorType = "0;SingleColor:#FFFF0000;GraduallyChangingColorStart:#FFFFFFFF;GraduallyChangingColorEnd:#FFFFFFFF;vectorX:0;vectorY:0",
							DesignHeight = "640",
							DesignType = "0",
							DesignWidth = "960",
							dstBlendFunc = "771",
							height = "380",
							ignoreSize = "False",
							name = "Panel_ItemBg",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							touchAble = "False",
							UILayoutViewModel = 
							{
								PositionY = -747,
							},
							uipanelviewmodel = 
							{
								Layout="Absolute",
								nType = "0"
							},
							width = "220",
							ZOrder = "1",
							components = 
							{
								
								{
									controlID = "Image_storeItem_Panel_ItemBg_Panel_root_Panel-kabalaTreeStore_Layer1_kabalaTree_Game",
									UUID = "7d10c30c_4d2d_48aa_b28a_b696a476c136",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "356",
									ignoreSize = "True",
									name = "Image_storeItem",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/kabalatree/store_bg.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionY = 201,
									},
									width = "200",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "Label_remainCnt_Image_storeItem_Panel_ItemBg_Panel_root_Panel-kabalaTreeStore_Layer1_kabalaTree_Game",
											UUID = "a5021746_bf2d_445b_b027_d2917774affa",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
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
											fontSize = "20",
											fontStroke = 
											{
												IsStroke = false,
												StrokeColor = "#FFE6E6E6",
												StrokeSize = 1,
											},
											height = "23",
											ignoreSize = "True",
											name = "Label_remainCnt",
											nTextAlign = "1",
											nTextHAlign = "1",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "770",
											text = "剩餘0購買次數",
											touchAble = "False",
											touchScaleEnable = "False",
											UILayoutViewModel = 
											{
												PositionY = -62,
											},
											width = "134",
											ZOrder = "1",
										},
										{
											controlID = "Label_ItemName_Image_storeItem_Panel_ItemBg_Panel_root_Panel-kabalaTreeStore_Layer1_kabalaTree_Game",
											UUID = "66e1ddf8_9fa3_4a7c_90b8_018efe66a159",
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
											fontSize = "24",
											fontStroke = 
											{
												IsStroke = false,
												StrokeColor = "#FFE6E6E6",
												StrokeSize = 1,
											},
											height = "30",
											ignoreSize = "True",
											name = "Label_ItemName",
											nTextAlign = "1",
											nTextHAlign = "1",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "770",
											text = "獲得寶箱",
											touchAble = "False",
											touchScaleEnable = "False",
											UILayoutViewModel = 
											{
												PositionX = -95,
												PositionY = 159,
											},
											width = "99",
											ZOrder = "1",
										},
										{
											controlID = "Image_currencyBg_Image_storeItem_Panel_ItemBg_Panel_root_Panel-kabalaTreeStore_Layer1_kabalaTree_Game",
											UUID = "f451b9fc_e79d_4107_9c85_00a5143f2d9f",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											classname = "MEImage",
											dstBlendFunc = "771",
											height = "36",
											ignoreSize = "False",
											name = "Image_currencyBg",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											texturePath = "ui/kabalatree/title_bg.png",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionY = -107,
											},
											width = "196",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "Image_icon_Image_currencyBg_Image_storeItem_Panel_ItemBg_Panel_root_Panel-kabalaTreeStore_Layer1_kabalaTree_Game",
													UUID = "876d2037_a98f_410d_9851_b7fef62c6c22",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0.5",
													backGroundScale9Enable = "False",
													classname = "MEImage",
													dstBlendFunc = "771",
													height = "30",
													ignoreSize = "False",
													name = "Image_icon",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "1",
													texturePath = "icon/system/003.png",
													touchAble = "False",
													UILayoutViewModel = 
													{
														PositionX = -24,
													},
													width = "30",
													ZOrder = "1",
												},
												{
													controlID = "Label_price_Image_currencyBg_Image_storeItem_Panel_ItemBg_Panel_root_Panel-kabalaTreeStore_Layer1_kabalaTree_Game",
													UUID = "d8f9490c_4a6d_41b2_b23b_f664ffc43afe",
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
													name = "Label_price",
													nTextAlign = "1",
													nTextHAlign = "1",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "770",
													text = "200",
													touchAble = "False",
													touchScaleEnable = "False",
													UILayoutViewModel = 
													{
														PositionX = -7,
														PositionY = 2,
													},
													width = "36",
													ZOrder = "1",
												},
											},
										},
										{
											controlID = "Button_buy_Image_storeItem_Panel_ItemBg_Panel_root_Panel-kabalaTreeStore_Layer1_kabalaTree_Game",
											UUID = "a438e306_067c_4567_91da_ad3b0f75de0b",
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
											name = "Button_buy",
											normal = "ui/kabalatree/btn_3.png",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "True",
											UILayoutViewModel = 
											{
												PositionY = -174,
											},
											UItype = "Button",
											width = "114",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "Label_btn_Button_buy_Image_storeItem_Panel_ItemBg_Panel_root_Panel-kabalaTreeStore_Layer1_kabalaTree_Game",
													UUID = "f5b113ee_b574_4073_9ec6_43a4edae4b65",
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
													fontSize = "26",
													fontStroke = 
													{
														IsStroke = true,
														StrokeColor = "#FFB2475D",
														StrokeSize = 0.3,
													},
													height = "30",
													ignoreSize = "True",
													name = "Label_btn",
													nTextAlign = "1",
													nTextHAlign = "1",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "770",
													text = "傳  送",
													touchAble = "False",
													touchScaleEnable = "False",
													UILayoutViewModel = 
													{
														
													},
													width = "69",
													ZOrder = "1",
												},
											},
										},
										{
											controlID = "Label_buff_desc_Image_storeItem_Panel_ItemBg_Panel_root_Panel-kabalaTreeStore_Layer1_kabalaTree_Game",
											UUID = "bf20dbe5_a748_48a7_ae16_a16ac5d5da89",
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
											name = "Label_buff_desc",
											nTextAlign = "1",
											nTextHAlign = "1",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "770",
											text = "剩餘0購買次數",
											touchAble = "False",
											touchScaleEnable = "False",
											UILayoutViewModel = 
											{
												PositionY = -12,
											},
											width = "134",
											ZOrder = "1",
										},
									},
								},
							},
						},
						{
							controlID = "Image_bg_Panel_root_Panel-kabalaTreeStore_Layer1_kabalaTree_Game",
							UUID = "6090fb21_c7f2_4f92_a7db_a6f84f1a487f",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							backGroundScale9Enable = "True;capInsetsX:0;capInsetsY:0;capInsetsWidth:0;capInsetsHeight:0",
							classname = "MEImage",
							dstBlendFunc = "771",
							height = "522",
							ignoreSize = "False",
							name = "Image_bg",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							texturePath = "ui/common/pop_ui/pop_bg_01.png",
							touchAble = "False",
							UILayoutViewModel = 
							{
								PositionX = 568,
								PositionY = 320,
								IsPercent = true,
								PercentX = 50,
								PercentY = 50,
							},
							width = "1024",
							ZOrder = "1",
							components = 
							{
								
								{
									controlID = "Image_innerbg_Image_bg_Panel_root_Panel-kabalaTreeStore_Layer1_kabalaTree_Game",
									UUID = "a46b6062_8903_48b5_a1e9_bebc8ffcab0c",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "400",
									ignoreSize = "False",
									name = "Image_innerbg",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/common/pop_ui/pop_bg_02.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionY = 9,
									},
									width = "1008",
									ZOrder = "1",
								},
								{
									controlID = "Button_close_Image_bg_Panel_root_Panel-kabalaTreeStore_Layer1_kabalaTree_Game",
									UUID = "a6cc064b_3042_4a39_a48e_ca4a76eeb8fc",
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
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "True",
									UILayoutViewModel = 
									{
										PositionX = 483,
										PositionY = 231,
									},
									UItype = "Button",
									width = "60",
									ZOrder = "1",
								},
								{
									controlID = "Label_title_Image_bg_Panel_root_Panel-kabalaTreeStore_Layer1_kabalaTree_Game",
									UUID = "9755ad75_fbc3_4279_8fc8_7d97534613a1",
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
									fontSize = "28",
									fontStroke = 
									{
										IsStroke = false,
										StrokeColor = "#FFE6E6E6",
										StrokeSize = 1,
									},
									height = "35",
									ignoreSize = "True",
									name = "Label_title",
									nTextAlign = "1",
									nTextHAlign = "1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "艾薇字商店",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionX = -498,
										PositionY = 225,
									},
									width = "142",
									ZOrder = "1",
								},
								{
									controlID = "ScrollView_kabalaTreeStore_Image_bg_Panel_root_Panel-kabalaTreeStore_Layer1_kabalaTree_Game",
									UUID = "c77daf15_f0bf_48f4_8d3c_ece620be40ee",
									anchorPoint = "False",
									anchorPointX = "0",
									anchorPointY = "0",
									backGroundScale9Enable = "False",
									bgColorOpacity = "50",
									bIsOpenClipping = "True",
									bounceEnable = "True",
									classname = "MEScrollView",
									colorType = "0;SingleColor:#FFFF0000;GraduallyChangingColorStart:#FFFFFFFF;GraduallyChangingColorEnd:#FFFFFFFF;vectorX:0;vectorY:0",
									direction = "2",
									dstBlendFunc = "771",
									height = "383",
									ignoreSize = "False",
									innerHeight = "383",
									innerWidth = "700",
									name = "ScrollView_kabalaTreeStore",
									showScrollbar = "False",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "True",
									UILayoutViewModel = 
									{
										PositionX = -216,
										PositionY = -184,
									},
									uipanelviewmodel = 
									{
										Layout="Absolute",
										nType = "0"
									},
									width = "700",
									ZOrder = "1",
								},
								{
									controlID = "Image_coinbg_Image_bg_Panel_root_Panel-kabalaTreeStore_Layer1_kabalaTree_Game",
									UUID = "812931d9_25f4_4942_9388_89bb6da29add",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "36",
									ignoreSize = "True",
									name = "Image_coinbg",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/kabalatree/resource_bg.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = 393,
										PositionY = -222,
									},
									width = "150",
									ZOrder = "1",
								},
								{
									controlID = "Label_coin_Image_bg_Panel_root_Panel-kabalaTreeStore_Layer1_kabalaTree_Game",
									UUID = "d75b94dc_0614_41a1_a6bc_97be5b210086",
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
									fontSize = "24",
									fontStroke = 
									{
										IsStroke = false,
										StrokeColor = "#FFE6E6E6",
										StrokeSize = 1,
									},
									height = "27",
									ignoreSize = "True",
									name = "Label_coin",
									nTextAlign = "1",
									nTextHAlign = "1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "465711111",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionX = 347,
										PositionY = -221,
									},
									width = "93",
									ZOrder = "1",
								},
								{
									controlID = "Image_coin_Image_bg_Panel_root_Panel-kabalaTreeStore_Layer1_kabalaTree_Game",
									UUID = "52ac4bac_5e1a_417f_b3cb_48e29ad8689b",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "2",
									ignoreSize = "True",
									name = "Image_coin",
									scaleX = "0.7",
									scaleY = "0.7",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "icon/item/goods/510217.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = 320,
										PositionY = -220,
									},
									width = "2",
									ZOrder = "1",
								},
								{
									controlID = "Image_kabalaTreeMapInfo_2_Image_bg_Panel_root_Panel-kabalaTreeStore_Layer1_kabalaTree_Game",
									UUID = "e86b0fa5_eb67_4d57_9d2b_40f735fb4004",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "27",
									ignoreSize = "True",
									name = "Image_kabalaTreeMapInfo_2",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/common/image_title.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = -289,
										PositionY = 226,
									},
									width = "121",
									ZOrder = "1",
								},
								{
									controlID = "Label_timetip_Image_bg_Panel_root_Panel-kabalaTreeStore_Layer1_kabalaTree_Game",
									UUID = "ad3db458_b4e1_4519_a960_dc74aa7ff561",
									anchorPoint = "False",
									anchorPointX = "1",
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
									fontSize = "20",
									fontStroke = 
									{
										IsStroke = false,
										StrokeColor = "#FFE6E6E6",
										StrokeSize = 1,
									},
									height = "25",
									ignoreSize = "True",
									name = "Label_timetip",
									nTextAlign = "1",
									nTextHAlign = "1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "剩餘刷新時間：",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionX = 17,
										PositionY = -223,
									},
									width = "131",
									ZOrder = "1",
								},
								{
									controlID = "Label_time_Image_bg_Panel_root_Panel-kabalaTreeStore_Layer1_kabalaTree_Game",
									UUID = "3ee74202_4005_4baf_8d44_c05bbe4438c9",
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
									fontSize = "18",
									fontStroke = 
									{
										IsStroke = false,
										StrokeColor = "#FFE6E6E6",
										StrokeSize = 1,
									},
									height = "22",
									ignoreSize = "True",
									name = "Label_time",
									nTextAlign = "2",
									nTextHAlign = "1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "12:20:30",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionX = 26,
										PositionY = -222,
									},
									width = "95",
									ZOrder = "1",
								},
								{
									controlID = "Image_businessman_Image_bg_Panel_root_Panel-kabalaTreeStore_Layer1_kabalaTree_Game",
									UUID = "1772dfaa_4be6_4467_93ab_af1223ede5c4",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "415",
									ignoreSize = "True",
									name = "Image_businessman",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/kabalatree/girl.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = -342,
										PositionY = 18,
									},
									width = "324",
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
			"ui/kabalatree/store_bg.png",
			"ui/kabalatree/title_bg.png",
			"icon/system/003.png",
			"ui/kabalatree/btn_3.png",
			"ui/common/pop_ui/pop_bg_01.png",
			"ui/common/pop_ui/pop_bg_02.png",
			"ui/common/pop_ui/pop_btn_02.png",
			"ui/kabalatree/resource_bg.png",
			"icon/item/goods/510217.png",
			"ui/common/image_title.png",
			"ui/kabalatree/girl.png",
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

