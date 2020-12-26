local t = 
{
	version = 1,
	components = 
	{
		
		{
			controlID = "Panel-BlackAndWhiteTaskView_Layer1_blackAndWhite_Game",
			UUID = "dc4f8263_f86b_45f0_8665_53b22f3f1c25",
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
			sizeType = "1",
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
					controlID = "Panel_base_Panel-BlackAndWhiteTaskView_Layer1_blackAndWhite_Game",
					UUID = "cb3c6290_bbc6_46d8_a4c1_ae8fea9b9b27",
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
					touchAble = "True",
					UILayoutViewModel = 
					{
						PositionX = -58,
						PositionY = 34,
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
							controlID = "Image_bg_Panel_base_Panel-BlackAndWhiteTaskView_Layer1_blackAndWhite_Game",
							UUID = "a5fed900_99be_49b4_bfcb_9dd963a8236a",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							backGroundScale9Enable = "True;capInsetsX:0;capInsetsY:0;capInsetsWidth:0;capInsetsHeight:0",
							classname = "MEImage",
							dstBlendFunc = "771",
							height = "477",
							ignoreSize = "False",
							name = "Image_bg",
							sizepercentx = "100",
							sizepercenty = "100",
							sizeType = "0",
							srcBlendFunc = "1",
							texturePath = "ui/common/pop_ui/pop_bg_01.png",
							touchAble = "True",
							UILayoutViewModel = 
							{
								PositionX = 572,
								PositionY = 335,
								IsPercent = true,
								PercentX = 50.36,
								PercentY = 52.47,
								LeftPositon = 118,
								TopPosition = 70,
							},
							width = "950",
							ZOrder = "1",
							components = 
							{
								
								{
									controlID = "Label_tittle_Image_bg_Panel_base_Panel-BlackAndWhiteTaskView_Layer1_blackAndWhite_Game",
									UUID = "8d40aca5_2331_4ddb_ac20_ab2d9dd11f8a",
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
									name = "Label_tittle",
									nTextAlign = "1",
									nTextHAlign = "1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "Ordre de bataille",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionX = -464,
										PositionY = 205,
									},
									width = "116",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "Image_line_Label_tittle_Image_bg_Panel_base_Panel-BlackAndWhiteTaskView_Layer1_blackAndWhite_Game",
											UUID = "c64222ca_4108_4210_98b9_c82654906dec",
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
												PositionX = 121,
												PositionY = 3,
												IsPercent = true,
												PercentX = 104.55,
												PercentY = 7.51,
											},
											width = "2",
											ZOrder = "1",
										},
										{
											controlID = "Label_tip_Label_tittle_Image_bg_Panel_base_Panel-BlackAndWhiteTaskView_Layer1_blackAndWhite_Game",
											UUID = "16749d74_738e_40ac_b424_ed38829f5553",
											anchorPoint = "False",
											anchorPointX = "0",
											anchorPointY = "0.5",
											classname = "MELabel",
											compPath = "luacomponents.common.MEIconLabel",
											dstBlendFunc = "771",
											FontColor = "#FF101117",
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
											name = "Label_tip",
											nTextAlign = "1",
											nTextHAlign = "1",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "770",
											text = "Mission",
											touchAble = "False",
											touchScaleEnable = "False",
											UILayoutViewModel = 
											{
												PositionX = 126,
												PositionY = -5,
												IsPercent = true,
												PercentX = 108.45,
												PercentY = -14.31,
											},
											width = "61",
											ZOrder = "1",
										},
									},
								},
								{
									controlID = "Button_close_Image_bg_Panel_base_Panel-BlackAndWhiteTaskView_Layer1_blackAndWhite_Game",
									UUID = "fc18f3bb_be09_4544_8f86_09430751a29e",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEButton",
									ClickHighLightEnabled = "True",
									dstBlendFunc = "771",
									flipX = "False",
									flipY = "False",
									height = "48",
									ignoreSize = "False",
									name = "Button_close",
									normal = "ui/common/pop_ui/pop_btn_02.png",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "True",
									UILayoutViewModel = 
									{
										PositionX = 441,
										PositionY = 209,
									},
									UItype = "Button",
									width = "48",
									ZOrder = "1",
								},
								{
									controlID = "Image_infoBg_Image_bg_Panel_base_Panel-BlackAndWhiteTaskView_Layer1_blackAndWhite_Game",
									UUID = "d8a552a3_5de8_4973_973f_fbadb77a8e83",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "370",
									ignoreSize = "False",
									name = "Image_infoBg",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/common/pop_ui/pop_bg_02.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionY = -6,
									},
									width = "928",
									ZOrder = "1",
								},
								{
									controlID = "ScrollView_task_Image_bg_Panel_base_Panel-BlackAndWhiteTaskView_Layer1_blackAndWhite_Game",
									UUID = "0fc0c9cb_f55e_4319_a553_4ae6836c7084",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									bgColorOpacity = "50",
									bIsOpenClipping = "True",
									bounceEnable = "True",
									classname = "MEScrollView",
									colorType = "0;SingleColor:#FFE6E6E6;GraduallyChangingColorStart:#FFFFFFFF;GraduallyChangingColorEnd:#FFFFFFFF;vectorX:0;vectorY:0",
									direction = "2",
									dstBlendFunc = "771",
									height = "350",
									ignoreSize = "False",
									innerHeight = "350",
									innerWidth = "990",
									name = "ScrollView_task",
									showScrollbar = "False",
									sizepercentx = "98",
									sizepercenty = "100",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "True",
									UILayoutViewModel = 
									{
										PositionY = -7,
										LeftPositon = 13,
										TopPosition = 7,
										relativeToName = "Panel_bagInfo",
									},
									uipanelviewmodel = 
									{
										Layout="Absolute",
										nType = "0"
									},
									width = "910",
									ZOrder = "1",
								},
							},
						},
						{
							controlID = "Panel_task_item_Panel_base_Panel-BlackAndWhiteTaskView_Layer1_blackAndWhite_Game",
							UUID = "77cf3f18_1e6d_4bcc_ad1e_1bfd4a20cdbe",
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
							height = "350",
							ignoreSize = "False",
							name = "Panel_task_item",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							touchAble = "False",
							UILayoutViewModel = 
							{
								PositionX = 408,
								PositionY = -394,
							},
							uipanelviewmodel = 
							{
								Layout="Absolute",
								nType = "0"
							},
							width = "300",
							ZOrder = "1",
							components = 
							{
								
								{
									controlID = "Image_bg_Panel_task_item_Panel_base_Panel-BlackAndWhiteTaskView_Layer1_blackAndWhite_Game",
									UUID = "2c7803fc_86d5_4cac_8454_962fcf150cf3",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "360",
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
										PositionX = 150,
										PositionY = 175,
										relativeToName = "Panel_rank_item",
										nGravity = 6,
										nAlign = 5
									},
									width = "300",
									ZOrder = "1",
								},
								{
									controlID = "Image_Tips_Panel_task_item_Panel_base_Panel-BlackAndWhiteTaskView_Layer1_blackAndWhite_Game",
									UUID = "f1e49e6b_f94e_46ec_8955_8d1a6bd9647c",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "42",
									ignoreSize = "False",
									name = "Image_Tips",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/common/news_big.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = -272,
										PositionY = 519,
										relativeToName = "Panel_rank_item",
										nGravity = 6,
										nAlign = 5
									},
									width = "42",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "Label_Desc_Image_Tips_Panel_task_item_Panel_base_Panel-BlackAndWhiteTaskView_Layer1_blackAndWhite_Game",
											UUID = "c310cbea_0b03_4ad2_bd32_983de45a0875",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											classname = "MELabel",
											compPath = "luacomponents.common.MEIconLabel",
											dstBlendFunc = "771",
											FontColor = "#FF46527A",
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
											name = "Label_Desc",
											nTextAlign = "1",
											nTextHAlign = "1",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "770",
											text = "Les quêtes ne peuvent être terminées que lors de l'événement Bataille finale.",
											touchAble = "False",
											touchScaleEnable = "False",
											UILayoutViewModel = 
											{
												PositionX = 175,
											},
											width = "283",
											ZOrder = "1",
										},
									},
								},
								{
									controlID = "Image_bg1_Panel_task_item_Panel_base_Panel-BlackAndWhiteTaskView_Layer1_blackAndWhite_Game",
									UUID = "8d1c2f73_b858_4db8_9a7d_4b5b9dbfc23e",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "48",
									ignoreSize = "True",
									name = "Image_bg1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/BlackAndWhite/009.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = 150,
										PositionY = 319,
									},
									width = "272",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "Label_BlackAndWhiteTaskView_1_Image_bg1_Panel_task_item_Panel_base_Panel-BlackAndWhiteTaskView_Layer1_blackAndWhite_Game",
											UUID = "a68769fc_2483_41f7_b6fa_88cabf704bd3",
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
												IsStroke = true,
												StrokeColor = "#FF5B6DAC",
												StrokeSize = 1,
											},
											height = "29",
											ignoreSize = "True",
											name = "Label_BlackAndWhiteTaskView_1",
											nTextAlign = "1",
											nTextHAlign = "1",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "770",
											text = "Nom quête Nom quête",
											touchAble = "False",
											touchScaleEnable = "False",
											UILayoutViewModel = 
											{
												
											},
											width = "268",
											ZOrder = "1",
										},
									},
								},
								{
									controlID = "Label_desc_Panel_task_item_Panel_base_Panel-BlackAndWhiteTaskView_Layer1_blackAndWhite_Game",
									UUID = "c5905c81_d637_4dcf_81b3_cd05dccbb312",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									classname = "MELabel",
									compPath = "luacomponents.common.MEIconLabel",
									dstBlendFunc = "771",
									FontColor = "#FF46527A",
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
									height = "50",
									ignoreSize = "False",
									name = "Label_desc",
									nTextAlign = "0",
									nTextHAlign = "1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "Description quête",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionX = 147,
										PositionY = 241,
									},
									width = "260",
									ZOrder = "1",
								},
								{
									controlID = "Image_progress_Panel_task_item_Panel_base_Panel-BlackAndWhiteTaskView_Layer1_blackAndWhite_Game",
									UUID = "8d232a4b_277c_4505_a7f0_9424a0ad63a2",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "20",
									ignoreSize = "False",
									name = "Image_progress",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/osd/task/005.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = 150,
										PositionY = 171,
									},
									width = "280",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "LoadingBar_progress_Image_progress_Panel_task_item_Panel_base_Panel-BlackAndWhiteTaskView_Layer1_blackAndWhite_Game",
											UUID = "49cca206_364e_483d_b7dd_66055bb01592",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											classname = "MELoadingBar",
											direction = "0",
											dstBlendFunc = "771",
											height = "20",
											ignoreSize = "False",
											name = "LoadingBar_progress",
											percent = "100",
											sizepercentx = "100",
											sizepercenty = "100",
											sizeType = "1",
											srcBlendFunc = "1",
											texture = "ui/osd/task/006.png",
											touchAble = "False",
											UILayoutViewModel = 
											{
												
											},
											width = "290",
											ZOrder = "1",
										},
									},
								},
								{
									controlID = "Label_progress_Panel_task_item_Panel_base_Panel-BlackAndWhiteTaskView_Layer1_blackAndWhite_Game",
									UUID = "e22df6fe_0399_4846_ac3a_389683321ab9",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									classname = "MELabel",
									compPath = "luacomponents.common.MEIconLabel",
									dstBlendFunc = "771",
									FontColor = "#FF46527A",
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
									name = "Label_progress",
									nTextAlign = "1",
									nTextHAlign = "1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "177.0",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionX = 144,
										PositionY = 200,
									},
									width = "54",
									ZOrder = "1",
								},
								{
									controlID = "Label_progress1_Panel_task_item_Panel_base_Panel-BlackAndWhiteTaskView_Layer1_blackAndWhite_Game",
									UUID = "1275c0d0_ade5_43cc_ba1d_d75411e9332d",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									classname = "MELabel",
									compPath = "luacomponents.common.MEIconLabel",
									dstBlendFunc = "771",
									FontColor = "#FFC0C2D2",
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
									name = "Label_progress1",
									nTextAlign = "1",
									nTextHAlign = "1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "Progression",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionX = 265,
										PositionY = 200,
									},
									width = "43",
									ZOrder = "1",
								},
								{
									controlID = "Label_Conduct_Panel_task_item_Panel_base_Panel-BlackAndWhiteTaskView_Layer1_blackAndWhite_Game",
									UUID = "6b70a721_10cf_4577_8ba1_1fad68069517",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									classname = "MELabel",
									compPath = "luacomponents.common.MEIconLabel",
									dstBlendFunc = "771",
									FontColor = "#FF49557F",
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
									name = "Label_Conduct",
									nTextAlign = "1",
									nTextHAlign = "1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "En cours",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionX = 148,
										PositionY = 34,
									},
									width = "69",
									ZOrder = "1",
								},
								{
									controlID = "Button_Receive_Panel_task_item_Panel_base_Panel-BlackAndWhiteTaskView_Layer1_blackAndWhite_Game",
									UUID = "e42b46d6_8ea9_49ef_9cfc_1e4e1394207c",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEButton",
									ClickHighLightEnabled = "True",
									disabled = "ui/common/button_middle_n.png",
									dstBlendFunc = "771",
									flipX = "False",
									flipY = "False",
									height = "54",
									ignoreSize = "True",
									name = "Button_Receive",
									normal = "ui/common/button_middle_n.png",
									pressed = "ui/common/button_middle_n.png",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "True",
									UILayoutViewModel = 
									{
										PositionX = 148,
										PositionY = 36,
									},
									UItype = "Button",
									width = "124",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "Label_BlackAndWhiteTaskView_1_Button_Receive_Panel_task_item_Panel_base_Panel-BlackAndWhiteTaskView_Layer1_blackAndWhite_Game",
											UUID = "379a6163_f664_4407_86bb_38a98ff18afb",
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
											name = "Label_BlackAndWhiteTaskView_1",
											nTextAlign = "1",
											nTextHAlign = "1",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "770",
											text = "Obtenir récompense",
											touchAble = "False",
											touchScaleEnable = "False",
											UILayoutViewModel = 
											{
												
											},
											width = "83",
											ZOrder = "1",
										},
									},
								},
								{
									controlID = "Label_Geted_Panel_task_item_Panel_base_Panel-BlackAndWhiteTaskView_Layer1_blackAndWhite_Game",
									UUID = "35ee86a5_291b_47d6_8ef9_19c6f64734f2",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									classname = "MELabel",
									compPath = "luacomponents.common.MEIconLabel",
									dstBlendFunc = "771",
									FontColor = "#FF46527A",
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
									name = "Label_Geted",
									nTextAlign = "1",
									nTextHAlign = "1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "Terminé",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionX = 148,
										PositionY = 34,
									},
									width = "69",
									ZOrder = "1",
								},
								{
									controlID = "Panel_reward_Panel_task_item_Panel_base_Panel-BlackAndWhiteTaskView_Layer1_blackAndWhite_Game",
									UUID = "64402a9b_464b_49dc_ab75_4ea858134f9a",
									anchorPoint = "False",
									anchorPointX = "0",
									anchorPointY = "0",
									backGroundScale9Enable = "False",
									bgColorOpacity = "50",
									bIsOpenClipping = "True",
									classname = "MEPanel",
									colorType = "0;SingleColor:#FFE6E6E6;GraduallyChangingColorStart:#FFFFFFFF;GraduallyChangingColorEnd:#FFFFFFFF;vectorX:0;vectorY:0",
									DesignHeight = "640",
									DesignType = "0",
									DesignWidth = "960",
									dstBlendFunc = "771",
									height = "90",
									ignoreSize = "False",
									name = "Panel_reward",
									panelTexturePath = "ui/osd/task/001.png",
									sizepercentx = "93",
									sizepercenty = "22",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = 9,
										PositionY = 66,
									},
									uipanelviewmodel = 
									{
										Layout="Absolute",
										nType = "0"
									},
									width = "280",
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
			"ui/common/pop_ui/pop_ui_02.png",
			"ui/common/pop_ui/pop_btn_02.png",
			"ui/common/pop_ui/pop_bg_02.png",
			"ui/common/news_big.png",
			"ui/BlackAndWhite/009.png",
			"ui/osd/task/005.png",
			"ui/osd/task/006.png",
			"ui/common/button_middle_n.png",
			"ui/osd/task/001.png",
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

