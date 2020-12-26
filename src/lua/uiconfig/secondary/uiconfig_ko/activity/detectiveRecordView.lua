local t = 
{
	version = 1,
	components = 
	{
		
		{
			controlID = "Panel-detectiveRecordView_detective_activity_Game",
			UUID = "82b241d0_cf1f_4cb0_be86_04b3af46d5bf",
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
					controlID = "Panel_base_Panel-detectiveRecordView_detective_activity_Game",
					UUID = "f79085ec_5d5c_45ee_b2e7_8756414fd0dd",
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
							controlID = "Image_detectiveRecordView_1_Panel_base_Panel-detectiveRecordView_detective_activity_Game",
							UUID = "a3130343_c4af_49b5_aeb3_d4bd7202c766",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							backGroundScale9Enable = "False",
							classname = "MEImage",
							dstBlendFunc = "771",
							height = "640",
							ignoreSize = "True",
							name = "Image_detectiveRecordView_1",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "770",
							texturePath = "ui/activity/detective/main/档案.png",
							touchAble = "False",
							UILayoutViewModel = 
							{
								PositionX = 568,
								PositionY = 320,
								IsPercent = true,
								PercentX = 50,
								PercentY = 50,
								LeftPositon = -125,
								relativeToName = "Panel",
							},
							width = "1386",
							ZOrder = "1",
						},
						{
							controlID = "Image_bg_Panel_base_Panel-detectiveRecordView_detective_activity_Game",
							UUID = "c4fa2198_f3b4_41e2_8d8b_27bf2a5b99fc",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							backGroundScale9Enable = "False",
							classname = "MEImage",
							dstBlendFunc = "771",
							height = "543",
							ignoreSize = "True",
							name = "Image_bg",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							texturePath = "ui/activity/detective/main/011.png",
							touchAble = "False",
							UILayoutViewModel = 
							{
								PositionX = 568,
								PositionY = 320,
								IsPercent = true,
								PercentX = 50,
								PercentY = 50,
							},
							width = "935",
							ZOrder = "1",
							components = 
							{
								
								{
									controlID = "Image_info_bg_Image_bg_Panel_base_Panel-detectiveRecordView_detective_activity_Game",
									UUID = "bcefc434_02ab_464e_92a9_8b82c988d357",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "564",
									ignoreSize = "True",
									name = "Image_info_bg",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/activity/detective/main/016.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = 236,
									},
									width = "465",
									ZOrder = "1",
								},
								{
									controlID = "Image_info_hero_Image_bg_Panel_base_Panel-detectiveRecordView_detective_activity_Game",
									UUID = "773027a8_8bf9_4aeb_84d5_1042d01f7cc5",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "517",
									ignoreSize = "True",
									name = "Image_info_hero",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/activity/detective/main/11.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = -220,
									},
									width = "473",
									ZOrder = "1",
								},
								{
									controlID = "Button_close_Image_bg_Panel_base_Panel-detectiveRecordView_detective_activity_Game",
									UUID = "84c1fa39_dfab_4dc9_bdc1_4af4cb66e251",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEButton",
									ClickHighLightEnabled = "True",
									dstBlendFunc = "771",
									flipX = "False",
									flipY = "False",
									height = "89",
									ignoreSize = "True",
									name = "Button_close",
									normal = "ui/activity/detective/main/010.png",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "True",
									UILayoutViewModel = 
									{
										PositionX = -528,
										PositionY = 276,
									},
									UItype = "Button",
									width = "79",
									ZOrder = "1",
								},
								{
									controlID = "Label_title_Image_bg_Panel_base_Panel-detectiveRecordView_detective_activity_Game",
									UUID = "367df53d_e2c9_4efe_9697_b013096d695c",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									classname = "MELabel",
									compPath = "luacomponents.common.MEIconLabel",
									dstBlendFunc = "771",
									FontColor = "#FF1E2749",
									fontName = "font/MFLiHei_Noncommercial.ttf",
									fontShadow = 
									{
										IsShadow = false,
										ShadowColor = "#FFFFFFFF",
										ShadowAlpha = 255,
										OffsetX = 0,
										OffsetY = 0,
									},
									fontSize = "32",
									fontStroke = 
									{
										IsStroke = false,
										StrokeColor = "#FFE6E6E6",
										StrokeSize = 1,
									},
									height = "40",
									ignoreSize = "True",
									name = "Label_title",
									nTextAlign = "1",
									nTextHAlign = "1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "퀘스트 목표",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionX = 237,
										PositionY = 191,
									},
									width = "132",
									ZOrder = "1",
								},
								{
									controlID = "ScrollView_target_Image_bg_Panel_base_Panel-detectiveRecordView_detective_activity_Game",
									UUID = "b60fa30c_97aa_4bbc_8811_1bbdb6752de1",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									bgColorOpacity = "50",
									bIsOpenClipping = "True",
									bounceEnable = "True",
									classname = "MEScrollView",
									colorType = "0;SingleColor:#FFFF0000;GraduallyChangingColorStart:#FFFFFFFF;GraduallyChangingColorEnd:#FFFFFFFF;vectorX:0;vectorY:0",
									direction = "1",
									dstBlendFunc = "771",
									height = "400",
									ignoreSize = "False",
									innerHeight = "400",
									innerWidth = "382",
									name = "ScrollView_target",
									showScrollbar = "False",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "True",
									UILayoutViewModel = 
									{
										PositionX = 232,
										PositionY = -49,
									},
									uipanelviewmodel = 
									{
										Layout="Absolute",
										nType = "0"
									},
									width = "382",
									ZOrder = "1",
								},
								{
									controlID = "ScrollView_info_Image_bg_Panel_base_Panel-detectiveRecordView_detective_activity_Game",
									UUID = "8c224102_bd79_4e2a_9c78_75cbc94f9671",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									bgColorOpacity = "50",
									bIsOpenClipping = "True",
									bounceEnable = "True",
									classname = "MEScrollView",
									colorType = "0;SingleColor:#FFFF0000;GraduallyChangingColorStart:#FFFFFFFF;GraduallyChangingColorEnd:#FFFFFFFF;vectorX:0;vectorY:0",
									direction = "1",
									dstBlendFunc = "771",
									height = "400",
									ignoreSize = "False",
									innerHeight = "400",
									innerWidth = "382",
									name = "ScrollView_info",
									showScrollbar = "False",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "True",
									UILayoutViewModel = 
									{
										PositionX = 232,
										PositionY = -49,
									},
									uipanelviewmodel = 
									{
										Layout="Absolute",
										nType = "0"
									},
									width = "382",
									ZOrder = "1",
								},
								{
									controlID = "Panel_1_Image_bg_Panel_base_Panel-detectiveRecordView_detective_activity_Game",
									UUID = "d8964b21_4efc_41a1_8dc6_f8e071a4fb72",
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
									height = "135",
									ignoreSize = "False",
									name = "Panel_1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "True",
									UILayoutViewModel = 
									{
										PositionX = 450,
										PositionY = -107,
									},
									uipanelviewmodel = 
									{
										Layout="Absolute",
										nType = "0"
									},
									width = "94",
									ZOrder = "2",
									components = 
									{
										
										{
											controlID = "Image_normal_Panel_1_Image_bg_Panel_base_Panel-detectiveRecordView_detective_activity_Game",
											UUID = "b1609ba0_5e03_424f_b1e6_fa9b303b8c8e",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											classname = "MEImage",
											dstBlendFunc = "771",
											height = "135",
											ignoreSize = "True",
											name = "Image_normal",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											texturePath = "ui/activity/detective/main/022.png",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 2,
											},
											visible = "False",
											width = "52",
											ZOrder = "1",
										},
										{
											controlID = "Button_select_Panel_1_Image_bg_Panel_base_Panel-detectiveRecordView_detective_activity_Game",
											UUID = "a76eef05_f5f5_4088_bb2f_bf7de4e95685",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											classname = "MEButton",
											ClickHighLightEnabled = "True",
											dstBlendFunc = "771",
											flipX = "False",
											flipY = "False",
											height = "135",
											ignoreSize = "True",
											name = "Button_select",
											normal = "ui/activity/detective/main/021.png",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "True",
											UILayoutViewModel = 
											{
												PositionX = -2,
											},
											UItype = "Button",
											width = "62",
											ZOrder = "1",
										},
									},
								},
								{
									controlID = "Panel_2_Image_bg_Panel_base_Panel-detectiveRecordView_detective_activity_Game",
									UUID = "cc2ea1eb_4fde_4c9c_9693_942e2065e706",
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
									height = "135",
									ignoreSize = "False",
									name = "Panel_2",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "True",
									UILayoutViewModel = 
									{
										PositionX = 450,
										PositionY = -173,
									},
									uipanelviewmodel = 
									{
										Layout="Absolute",
										nType = "0"
									},
									width = "94",
									ZOrder = "2",
									components = 
									{
										
										{
											controlID = "Image_normal_Panel_2_Image_bg_Panel_base_Panel-detectiveRecordView_detective_activity_Game",
											UUID = "5eff030d_6131_48c4_b03f_bd53a49fdbd5",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											classname = "MEImage",
											dstBlendFunc = "771",
											height = "135",
											ignoreSize = "True",
											name = "Image_normal",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											texturePath = "ui/activity/detective/main/020.png",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 2,
											},
											width = "52",
											ZOrder = "1",
										},
										{
											controlID = "Button_select_Panel_2_Image_bg_Panel_base_Panel-detectiveRecordView_detective_activity_Game",
											UUID = "00bfce80_be78_4f5a_9880_59847b9dfbd4",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											classname = "MEButton",
											ClickHighLightEnabled = "True",
											dstBlendFunc = "771",
											flipX = "False",
											flipY = "False",
											height = "135",
											ignoreSize = "True",
											name = "Button_select",
											normal = "ui/activity/detective/main/019.png",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "True",
											UILayoutViewModel = 
											{
												PositionX = -2,
											},
											UItype = "Button",
											visible = "False",
											width = "62",
											ZOrder = "1",
										},
									},
								},
								{
									controlID = "Panel_hero_show_Image_bg_Panel_base_Panel-detectiveRecordView_detective_activity_Game",
									UUID = "be39a930_b4e2_4938_b457_e59311e4739d",
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
									height = "486",
									ignoreSize = "False",
									name = "Panel_hero_show",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = -440,
										PositionY = -243,
									},
									uipanelviewmodel = 
									{
										Layout="Absolute",
										nType = "0"
									},
									width = "435",
									ZOrder = "1",
								},
							},
						},
						{
							controlID = "Panel_item_Panel_base_Panel-detectiveRecordView_detective_activity_Game",
							UUID = "3e4bb06a_888e_4209_a758_95d9c0a2fee2",
							anchorPoint = "False",
							anchorPointX = "0",
							anchorPointY = "1",
							backGroundScale9Enable = "False",
							bgColorOpacity = "50",
							bIsOpenClipping = "False",
							classname = "MEPanel",
							colorType = "0;SingleColor:#FFE6E6E6;GraduallyChangingColorStart:#FFFFFFFF;GraduallyChangingColorEnd:#FFFFFFFF;vectorX:0;vectorY:0",
							DesignHeight = "640",
							DesignType = "0",
							DesignWidth = "960",
							dstBlendFunc = "771",
							height = "132",
							ignoreSize = "False",
							name = "Panel_item",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							touchAble = "False",
							UILayoutViewModel = 
							{
								PositionX = 610,
								PositionY = -200,
							},
							uipanelviewmodel = 
							{
								Layout="Absolute",
								nType = "0"
							},
							width = "382",
							ZOrder = "1",
							components = 
							{
								
								{
									controlID = "Image_icon_Panel_item_Panel_base_Panel-detectiveRecordView_detective_activity_Game",
									UUID = "6f3187a8_c7d1_47e9_9ff9_70de66b44c27",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "44",
									ignoreSize = "True",
									name = "Image_icon",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/activity/detective/main/017.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = 94,
										PositionY = -24,
									},
									width = "193",
									ZOrder = "1",
								},
								{
									controlID = "Label_title_Panel_item_Panel_base_Panel-detectiveRecordView_detective_activity_Game",
									UUID = "462ca3fa_37d9_4c4b_af60_22034769daf4",
									anchorPoint = "False",
									anchorPointX = "0",
									anchorPointY = "0.5",
									classname = "MELabel",
									compPath = "luacomponents.common.MEIconLabel",
									dstBlendFunc = "771",
									FontColor = "#FFC33F94",
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
									name = "Label_title",
									nTextAlign = "1",
									nTextHAlign = "1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "主线目标",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionX = 18,
										PositionY = -22,
									},
									width = "84",
									ZOrder = "1",
								},
								{
									controlID = "Label_info_Panel_item_Panel_base_Panel-detectiveRecordView_detective_activity_Game",
									UUID = "04a61b2f_c422_4cb9_bea4_d500f7a1f8f6",
									anchorPoint = "False",
									anchorPointX = "0",
									anchorPointY = "1",
									classname = "MELabel",
									compPath = "luacomponents.common.MEIconLabel",
									dstBlendFunc = "771",
									FontColor = "#FFCAECF5",
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
									height = "85",
									ignoreSize = "False",
									name = "Label_info",
									nTextAlign = "0",
									nTextHAlign = "0",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "目标描述目标描述目标描述目标",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionX = 22,
										PositionY = -49,
									},
									width = "350",
									ZOrder = "1",
								},
							},
						},
						{
							controlID = "Panel_item1_Panel_base_Panel-detectiveRecordView_detective_activity_Game",
							UUID = "72254ebf_1041_49c7_8ba8_11a31fbe9850",
							anchorPoint = "False",
							anchorPointX = "0",
							anchorPointY = "1",
							backGroundScale9Enable = "False",
							bgColorOpacity = "50",
							bIsOpenClipping = "False",
							classname = "MEPanel",
							colorType = "0;SingleColor:#FFE6E6E6;GraduallyChangingColorStart:#FFFFFFFF;GraduallyChangingColorEnd:#FFFFFFFF;vectorX:0;vectorY:0",
							DesignHeight = "640",
							DesignType = "0",
							DesignWidth = "960",
							dstBlendFunc = "771",
							height = "142",
							ignoreSize = "False",
							name = "Panel_item1",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							touchAble = "False",
							UILayoutViewModel = 
							{
								PositionX = 610,
								PositionY = -300,
							},
							uipanelviewmodel = 
							{
								Layout="Absolute",
								nType = "0"
							},
							width = "382",
							ZOrder = "1",
							components = 
							{
								
								{
									controlID = "Image_icon_Panel_item1_Panel_base_Panel-detectiveRecordView_detective_activity_Game",
									UUID = "6c491ad7_9130_4d15_9769_c3a93908b637",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "35",
									ignoreSize = "True",
									name = "Image_icon",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/activity/detective/main/018.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = 81,
										PositionY = -24,
									},
									width = "139",
									ZOrder = "1",
								},
								{
									controlID = "Label_title_Panel_item1_Panel_base_Panel-detectiveRecordView_detective_activity_Game",
									UUID = "06d65cd0_9801_4d52_952e_dfa6deb95927",
									anchorPoint = "False",
									anchorPointX = "0",
									anchorPointY = "0.5",
									classname = "MELabel",
									compPath = "luacomponents.common.MEIconLabel",
									dstBlendFunc = "771",
									FontColor = "#FFCAECF5",
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
									name = "Label_title",
									nTextAlign = "1",
									nTextHAlign = "1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "剧情回顾",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionX = 20,
										PositionY = -22,
									},
									width = "83",
									ZOrder = "1",
								},
								{
									controlID = "Label_info_Panel_item1_Panel_base_Panel-detectiveRecordView_detective_activity_Game",
									UUID = "3483b156_e377_42b2_9d67_f4a8cff9a388",
									anchorPoint = "False",
									anchorPointX = "0",
									anchorPointY = "1",
									classname = "MELabel",
									compPath = "luacomponents.common.MEIconLabel",
									dstBlendFunc = "771",
									FontColor = "#FFCAECF5",
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
									height = "106",
									ignoreSize = "False",
									name = "Label_info",
									nTextAlign = "0",
									nTextHAlign = "0",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "目标描述目标描述目标描述目标",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionX = 22,
										PositionY = -49,
									},
									width = "350",
									ZOrder = "1",
								},
							},
						},
						{
							controlID = "Panel_hero_item_Panel_base_Panel-detectiveRecordView_detective_activity_Game",
							UUID = "d8e65cbe_18ce_41d0_b0b3_f8efca364cd5",
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
							height = "112",
							ignoreSize = "False",
							name = "Panel_hero_item",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							touchAble = "False",
							UILayoutViewModel = 
							{
								PositionX = 200,
								PositionY = -200,
							},
							uipanelviewmodel = 
							{
								Layout="Absolute",
								nType = "0"
							},
							width = "120",
							ZOrder = "1",
							components = 
							{
								
								{
									controlID = "Image_icon_bg_Panel_hero_item_Panel_base_Panel-detectiveRecordView_detective_activity_Game",
									UUID = "8b38675d_f6f7_4974_b1f9_37086c83f671",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "108",
									ignoreSize = "True",
									name = "Image_icon_bg",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/activity/detective/main/012.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										
									},
									width = "108",
									ZOrder = "1",
								},
								{
									controlID = "Image_icon_Panel_hero_item_Panel_base_Panel-detectiveRecordView_detective_activity_Game",
									UUID = "916b6736_35e1_419b_a08f_1532d9c50c9f",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "110",
									ignoreSize = "True",
									name = "Image_icon",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "icon/hero/battle/10102.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										
									},
									width = "128",
									ZOrder = "1",
								},
								{
									controlID = "Image_select_Panel_hero_item_Panel_base_Panel-detectiveRecordView_detective_activity_Game",
									UUID = "5b718fdc_9f14_4416_bc5d_f9944a06fd41",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "112",
									ignoreSize = "True",
									name = "Image_select",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/activity/detective/main/013.png",
									touchAble = "False",
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
			"ui/activity/detective/main/档案.png",
			"ui/activity/detective/main/011.png",
			"ui/activity/detective/main/016.png",
			"ui/activity/detective/main/11.png",
			"ui/activity/detective/main/010.png",
			"ui/activity/detective/main/022.png",
			"ui/activity/detective/main/021.png",
			"ui/activity/detective/main/020.png",
			"ui/activity/detective/main/019.png",
			"ui/activity/detective/main/017.png",
			"ui/activity/detective/main/018.png",
			"ui/activity/detective/main/012.png",
			"icon/hero/battle/10102.png",
			"ui/activity/detective/main/013.png",
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

