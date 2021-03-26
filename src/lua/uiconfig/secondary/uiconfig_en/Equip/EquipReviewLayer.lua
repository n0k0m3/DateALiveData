local t = 
{
	version = 1,
	components = 
	{
		
		{
			controlID = "Panel-EquipReviewLayer_Layer1_Equip_Game",
			UUID = "248e8f19_f73b_4395_b4a0_5a1ad5d0155d",
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
					controlID = "Panel_base_Panel-EquipReviewLayer_Layer1_Equip_Game",
					UUID = "c0347a2b_5c77_449c_b177_b2196aa36b5e",
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
							controlID = "background_Panel_base_Panel-EquipReviewLayer_Layer1_Equip_Game",
							UUID = "1e2b2171_45dd_4f43_b290_766fec80e7f5",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							backGroundScale9Enable = "False",
							classname = "MEImage",
							dstBlendFunc = "771",
							height = "640",
							ignoreSize = "False",
							name = "background",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "770",
							texturePath = "scene/bg/bg_common.png",
							touchAble = "False",
							UILayoutViewModel = 
							{
								PositionX = 568,
								PositionY = 320,
								IsPercent = true,
								PercentX = 50,
								PercentY = 50,
							},
							width = "1386",
							ZOrder = "1",
							components = 
							{
								
								{
									controlID = "Image_b2_background_Panel_base_Panel-EquipReviewLayer_Layer1_Equip_Game",
									UUID = "318f0cd4_7450_4540_8b73_7733ecdebc44",
									anchorPoint = "False",
									anchorPointX = "0",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "640",
									ignoreSize = "True",
									name = "Image_b2",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/fairy/new_ui/new_bg_04.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = -693,
										IsPercent = true,
										PercentX = -50,
									},
									width = "1386",
									ZOrder = "1",
								},
								{
									controlID = "Image_EquipReviewLayer_1_background_Panel_base_Panel-EquipReviewLayer_Layer1_Equip_Game",
									UUID = "78ff7d54_3a90_4c92_8144_f38879128555",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "640",
									ignoreSize = "True",
									name = "Image_EquipReviewLayer_1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									texturePath = "ui/Equipment/new_ui/shaixuan/0保存跳转界面效果重命名.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										
									},
									width = "1386",
									ZOrder = "1",
								},
							},
						},
						{
							controlID = "ScrollView_suit_Panel_base_Panel-EquipReviewLayer_Layer1_Equip_Game",
							UUID = "c573150e_b292_4be1_9776_48ca353a9e84",
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
							height = "448",
							ignoreSize = "False",
							innerHeight = "448",
							innerWidth = "1110",
							name = "ScrollView_suit",
							showScrollbar = "False",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							touchAble = "True",
							UILayoutViewModel = 
							{
								PositionX = 10,
								PositionY = 102,
							},
							uipanelviewmodel = 
							{
								Layout="Absolute",
								nType = "0"
							},
							width = "1110",
							ZOrder = "1",
						},
						{
							controlID = "Panel_di_Panel_base_Panel-EquipReviewLayer_Layer1_Equip_Game",
							UUID = "961cc82c_f415_4a79_95d8_b667f9529eab",
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
							name = "Panel_di",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							touchAble = "False",
							UILayoutViewModel = 
							{
								PositionX = 605,
								PositionY = 18,
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
									controlID = "Button_save_Panel_di_Panel_base_Panel-EquipReviewLayer_Layer1_Equip_Game",
									UUID = "24115b00_79d6_462e_9438_92dac7f35168",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEButton",
									ClickHighLightEnabled = "True",
									dstBlendFunc = "771",
									flipX = "False",
									flipY = "False",
									height = "58",
									HitType = 
									{
										nHitType = 3,
									},
									ignoreSize = "True",
									name = "Button_save",
									normal = "ui/fairy/new_ui/new_12.png",
									pressed = "ui/fairy/new_ui/new_12.png",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "True",
									UILayoutViewModel = 
									{
										PositionX = 434,
										PositionY = 40,
									},
									UItype = "Button",
									width = "134",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "Label_save_Button_save_Panel_di_Panel_base_Panel-EquipReviewLayer_Layer1_Equip_Game",
											UUID = "aa459414_33f7_4567_8ac5_4d5fcd28bce5",
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
											height = "0",
											ignoreSize = "False",
											name = "Label_save",
											nTextAlign = "1",
											nTextHAlign = "1",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "770",
											text = "Save",
											touchAble = "False",
											touchScaleEnable = "False",
											UILayoutViewModel = 
											{
												
											},
											width = "120",
											ZOrder = "1",
										},
									},
								},
								{
									controlID = "Button_use_Panel_di_Panel_base_Panel-EquipReviewLayer_Layer1_Equip_Game",
									UUID = "0c9eb5a5_5174_4402_8cdf_5d33b90756dd",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEButton",
									ClickHighLightEnabled = "True",
									dstBlendFunc = "771",
									flipX = "False",
									flipY = "False",
									height = "58",
									HitType = 
									{
										nHitType = 3,
									},
									ignoreSize = "True",
									name = "Button_use",
									normal = "ui/fairy/new_ui/new_12.png",
									pressed = "ui/fairy/new_ui/new_12.png",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "True",
									UILayoutViewModel = 
									{
										PositionX = 434,
										PositionY = 40,
									},
									UItype = "Button",
									width = "134",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "Label_use_Button_use_Panel_di_Panel_base_Panel-EquipReviewLayer_Layer1_Equip_Game",
											UUID = "9d030bdd_dedb_4e6c_8f37_664c3448d329",
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
											height = "0",
											ignoreSize = "False",
											name = "Label_use",
											nTextAlign = "1",
											nTextHAlign = "1",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "770",
											text = "Use",
											touchAble = "False",
											touchScaleEnable = "False",
											UILayoutViewModel = 
											{
												
											},
											width = "120",
											ZOrder = "1",
										},
									},
								},
								{
									controlID = "Button_rename_Panel_di_Panel_base_Panel-EquipReviewLayer_Layer1_Equip_Game",
									UUID = "c842fbcb_1b23_4fe1_935e_a6c24b79711b",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEButton",
									ClickHighLightEnabled = "True",
									dstBlendFunc = "771",
									flipX = "False",
									flipY = "False",
									height = "58",
									HitType = 
									{
										nHitType = 3,
									},
									ignoreSize = "True",
									name = "Button_rename",
									normal = "ui/common/button_big_blue_n.png",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "True",
									UILayoutViewModel = 
									{
										PositionX = 288,
										PositionY = 40,
									},
									UItype = "Button",
									width = "134",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "Label_rename_Button_rename_Panel_di_Panel_base_Panel-EquipReviewLayer_Layer1_Equip_Game",
											UUID = "f60d3300_656d_4795_a582_153f09bfbd44",
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
											height = "0",
											ignoreSize = "False",
											name = "Label_rename",
											nTextAlign = "1",
											nTextHAlign = "1",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "770",
											text = "Rename",
											touchAble = "False",
											touchScaleEnable = "False",
											UILayoutViewModel = 
											{
												
											},
											width = "120",
											ZOrder = "1",
										},
									},
								},
							},
						},
						{
							controlID = "Panel_equip_model_Panel_base_Panel-EquipReviewLayer_Layer1_Equip_Game",
							UUID = "48143c32_15c6_402d_99c0_c3303da9b286",
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
							height = "204",
							ignoreSize = "False",
							name = "Panel_equip_model",
							scaleX = "0.8",
							scaleY = "0.8",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							touchAble = "False",
							UILayoutViewModel = 
							{
								PositionX = 500,
								PositionY = -300,
							},
							uipanelviewmodel = 
							{
								Layout="Absolute",
								nType = "0"
							},
							width = "142",
							ZOrder = "1",
							components = 
							{
								
								{
									controlID = "Image_equip_back_Panel_equip_model_Panel_base_Panel-EquipReviewLayer_Layer1_Equip_Game",
									UUID = "71ecbe01_1efd_48e7_b902_92dd8de0bc5d",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "205",
									ignoreSize = "True",
									name = "Image_equip_back",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/Equipment/new_ui/bg_blue.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										
									},
									width = "142",
									ZOrder = "1",
								},
								{
									controlID = "Image_icon_Panel_equip_model_Panel_base_Panel-EquipReviewLayer_Layer1_Equip_Game",
									UUID = "ecf6efe8_556f_4223_896a_e7440494f108",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "208",
									ignoreSize = "False",
									name = "Image_icon",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "icon/equipment/icon/170_214/icon2_lijie_3.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										
									},
									width = "146",
									ZOrder = "1",
								},
								{
									controlID = "Image_frame_Panel_equip_model_Panel_base_Panel-EquipReviewLayer_Layer1_Equip_Game",
									UUID = "0ea10424_1f1f_467a_a71e_4849baddade6",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "203",
									ignoreSize = "True",
									name = "Image_frame",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/Equipment/new_ui/frame_blue.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										
									},
									width = "140",
									ZOrder = "1",
								},
								{
									controlID = "Label_levelTitle_Panel_equip_model_Panel_base_Panel-EquipReviewLayer_Layer1_Equip_Game",
									UUID = "5829e63d_2025_42a3_a1dc_2b93c0bf1d76",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0",
									classname = "MELabel",
									compPath = "luacomponents.common.MEIconLabel",
									dstBlendFunc = "771",
									FontColor = "#FF2C2E50",
									fontName = "font/MFLiHei_Noncommercial.ttf",
									fontShadow = 
									{
										IsShadow = false,
										ShadowColor = "#FFFFFFFF",
										ShadowAlpha = 255,
										OffsetX = 0,
										OffsetY = 0,
									},
									fontSize = "12",
									fontStroke = 
									{
										IsStroke = false,
										StrokeColor = "#FFE6E6E6",
										StrokeSize = 1,
									},
									height = "14",
									ignoreSize = "True",
									name = "Label_levelTitle",
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
										PositionX = -25,
										PositionY = 77,
									},
									width = "64",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "Label_level_Label_levelTitle_Panel_equip_model_Panel_base_Panel-EquipReviewLayer_Layer1_Equip_Game",
											UUID = "6e73ceda_5d0f_41cf_bf2d_913a4fd805fe",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0",
											classname = "MELabel",
											compPath = "luacomponents.common.MEIconLabel",
											dstBlendFunc = "771",
											FontColor = "#FF2C2E50",
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
											height = "21",
											ignoreSize = "True",
											name = "Label_level",
											nTextAlign = "1",
											nTextHAlign = "1",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "770",
											text = "20",
											touchAble = "False",
											touchScaleEnable = "False",
											UILayoutViewModel = 
											{
												PositionX = 27,
											},
											width = "23",
											ZOrder = "1",
										},
									},
								},
								{
									controlID = "Label_cost_Panel_equip_model_Panel_base_Panel-EquipReviewLayer_Layer1_Equip_Game",
									UUID = "a194a162_da97_4ed7_ab79_8221457af347",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									classname = "MELabel",
									compPath = "luacomponents.common.MEIconLabel",
									dstBlendFunc = "771",
									FontColor = "#FFD9F4FF",
									fontName = "font/MFLiHei_Noncommercial.ttf",
									fontShadow = 
									{
										IsShadow = false,
										ShadowColor = "#FFFFFFFF",
										ShadowAlpha = 255,
										OffsetX = 0,
										OffsetY = 0,
									},
									fontSize = "16",
									fontStroke = 
									{
										IsStroke = false,
										StrokeColor = "#FFE6E6E6",
										StrokeSize = 1,
									},
									height = "18",
									ignoreSize = "True",
									name = "Label_cost",
									nTextAlign = "1",
									nTextHAlign = "1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "25",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionX = 54,
										PositionY = -80,
									},
									width = "21",
									ZOrder = "1",
								},
								{
									controlID = "Label_costDesc_Panel_equip_model_Panel_base_Panel-EquipReviewLayer_Layer1_Equip_Game",
									UUID = "b37170b8_9bce_4a37_bdcc_a23ce8651b50",
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
									fontSize = "12",
									fontStroke = 
									{
										IsStroke = false,
										StrokeColor = "#FFE6E6E6",
										StrokeSize = 1,
									},
									height = "14",
									ignoreSize = "True",
									name = "Label_costDesc",
									nTextAlign = "1",
									nTextHAlign = "1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "Cost",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionX = 54,
										PositionY = -94,
									},
									width = "25",
									ZOrder = "1",
								},
								{
									controlID = "Image_star_1_Panel_equip_model_Panel_base_Panel-EquipReviewLayer_Layer1_Equip_Game",
									UUID = "b723a9ce_50bf_47f5_81df_20f3e798b977",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "20",
									ignoreSize = "True",
									name = "Image_star_1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/Equipment/new_ui/star.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = -57,
										PositionY = -88,
									},
									width = "19",
									ZOrder = "1",
								},
								{
									controlID = "Image_star_2_Panel_equip_model_Panel_base_Panel-EquipReviewLayer_Layer1_Equip_Game",
									UUID = "80f8c7d2_f77b_42f8_a11b_ff73fd17cda2",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "20",
									ignoreSize = "True",
									name = "Image_star_2",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/Equipment/new_ui/star.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = -37,
										PositionY = -88,
									},
									width = "19",
									ZOrder = "1",
								},
								{
									controlID = "Image_star_3_Panel_equip_model_Panel_base_Panel-EquipReviewLayer_Layer1_Equip_Game",
									UUID = "02245070_8dcc_43bc_a74f_8db801598ed9",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "20",
									ignoreSize = "True",
									name = "Image_star_3",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/Equipment/new_ui/star.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = -17,
										PositionY = -88,
									},
									width = "19",
									ZOrder = "1",
								},
								{
									controlID = "Image_star_4_Panel_equip_model_Panel_base_Panel-EquipReviewLayer_Layer1_Equip_Game",
									UUID = "e0c2ffe6_2638_477b_b9d7_fbfd30a26faa",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "20",
									ignoreSize = "True",
									name = "Image_star_4",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/Equipment/new_ui/star.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = 3,
										PositionY = -88,
									},
									width = "19",
									ZOrder = "1",
								},
								{
									controlID = "Image_star_5_Panel_equip_model_Panel_base_Panel-EquipReviewLayer_Layer1_Equip_Game",
									UUID = "6c30a1e2_6d4d_4bc9_9618_901392aafa93",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "20",
									ignoreSize = "True",
									name = "Image_star_5",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/Equipment/new_ui/star.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = 23,
										PositionY = -88,
									},
									width = "19",
									ZOrder = "1",
								},
								{
									controlID = "Image_type_Panel_equip_model_Panel_base_Panel-EquipReviewLayer_Layer1_Equip_Game",
									UUID = "63cf02d9_1331_487a_bd10_f4f795255c73",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "24",
									ignoreSize = "True",
									name = "Image_type",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "icon/equipment/type_bag/Chokhmah.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = -56,
										PositionY = 89,
									},
									width = "24",
									ZOrder = "1",
								},
							},
						},
						{
							controlID = "Panel_suit_model_Panel_base_Panel-EquipReviewLayer_Layer1_Equip_Game",
							UUID = "ebdc1c90_6735_4f52_a9ff_a4c0498505f3",
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
							height = "232",
							ignoreSize = "False",
							name = "Panel_suit_model",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							touchAble = "False",
							UILayoutViewModel = 
							{
								PositionX = -1,
								PositionY = -400,
							},
							uipanelviewmodel = 
							{
								Layout="Absolute",
								nType = "0"
							},
							width = "378",
							ZOrder = "1",
							components = 
							{
								
								{
									controlID = "Image_model_bg_Panel_suit_model_Panel_base_Panel-EquipReviewLayer_Layer1_Equip_Game",
									UUID = "d6e1bc29_9894_47ed_ae1b_820c5fffba83",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "209",
									ignoreSize = "True",
									name = "Image_model_bg",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/Equipment/new_ui/shaixuan/ui_002.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = 189,
										PositionY = 116,
									},
									width = "356",
									ZOrder = "1",
								},
								{
									controlID = "Label_tips_Panel_suit_model_Panel_base_Panel-EquipReviewLayer_Layer1_Equip_Game",
									UUID = "8878a1f9_fc53_417c_9530_459fc96827b3",
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
									fontSize = "24",
									fontStroke = 
									{
										IsStroke = false,
										StrokeColor = "#FFE6E6E6",
										StrokeSize = 1,
									},
									height = "28",
									ignoreSize = "True",
									name = "Label_tips",
									nTextAlign = "1",
									nTextHAlign = "1",
									opacity = "80",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "Add Here",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionX = 189,
										PositionY = 116,
									},
									width = "121",
									ZOrder = "1",
								},
								{
									controlID = "Panel_info_Panel_suit_model_Panel_base_Panel-EquipReviewLayer_Layer1_Equip_Game",
									UUID = "684900f1_0412_4b4b_a542_9bd127ce5be2",
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
									height = "205",
									ignoreSize = "False",
									name = "Panel_info",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = 14,
										PositionY = 14,
									},
									uipanelviewmodel = 
									{
										Layout="Absolute",
										nType = "0"
									},
									width = "350",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "Label_suit_name_Panel_info_Panel_suit_model_Panel_base_Panel-EquipReviewLayer_Layer1_Equip_Game",
											UUID = "34fa2a3d_4ef4_4e56_a769_2e8f1db63bd3",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											classname = "MELabel",
											compPath = "luacomponents.common.MEIconLabel",
											dstBlendFunc = "771",
											FontColor = "#FF49557F",
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
											height = "23",
											ignoreSize = "True",
											name = "Label_suit_name",
											nTextAlign = "1",
											nTextHAlign = "1",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "770",
											text = "Preset 1",
											touchAble = "False",
											touchScaleEnable = "False",
											UILayoutViewModel = 
											{
												PositionX = 170,
												PositionY = 187,
											},
											width = "83",
											ZOrder = "1",
										},
										{
											controlID = "Image_pos1_Panel_info_Panel_suit_model_Panel_base_Panel-EquipReviewLayer_Layer1_Equip_Game",
											UUID = "2bf7db9c_2e89_4237_8666_e11b1d573f0a",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											classname = "MEImage",
											dstBlendFunc = "771",
											height = "160",
											ignoreSize = "False",
											name = "Image_pos1",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											texturePath = "ui/Equipment/new_ui/shaixuan/ui_006.png",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 58,
												PositionY = 85,
											},
											width = "110",
											ZOrder = "1",
										},
										{
											controlID = "Image_pos2_Panel_info_Panel_suit_model_Panel_base_Panel-EquipReviewLayer_Layer1_Equip_Game",
											UUID = "4aca1d35_e8fd_4faa_b125_bfa96c4b428e",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											classname = "MEImage",
											dstBlendFunc = "771",
											height = "160",
											ignoreSize = "False",
											name = "Image_pos2",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											texturePath = "ui/Equipment/new_ui/shaixuan/ui_006.png",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 175,
												PositionY = 85,
											},
											width = "110",
											ZOrder = "1",
										},
										{
											controlID = "Image_pos3_Panel_info_Panel_suit_model_Panel_base_Panel-EquipReviewLayer_Layer1_Equip_Game",
											UUID = "d8ed21fe_931c_4f87_8c08_f06b7f2bc31b",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											classname = "MEImage",
											dstBlendFunc = "771",
											height = "160",
											ignoreSize = "False",
											name = "Image_pos3",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											texturePath = "ui/Equipment/new_ui/shaixuan/ui_006.png",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 292,
												PositionY = 85,
											},
											width = "110",
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
			"scene/bg/bg_common.png",
			"ui/fairy/new_ui/new_bg_04.png",
			"ui/Equipment/new_ui/shaixuan/0保存跳转界面效果重命名.png",
			"ui/fairy/new_ui/new_12.png",
			"ui/common/button_big_blue_n.png",
			"ui/Equipment/new_ui/bg_blue.png",
			"icon/equipment/icon/170_214/icon2_lijie_3.png",
			"ui/Equipment/new_ui/frame_blue.png",
			"ui/Equipment/new_ui/star.png",
			"icon/equipment/type_bag/Chokhmah.png",
			"ui/Equipment/new_ui/shaixuan/ui_002.png",
			"ui/Equipment/new_ui/shaixuan/ui_006.png",
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

