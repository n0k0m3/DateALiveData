local t = 
{
	version = 1,
	components = 
	{
		
		{
			controlID = "Panel-taskActivityViewFanshi_fanshiAssist_activity_Game",
			UUID = "37fd91d2_e3d6_41a1_82f5_7efa812ff859",
			anchorPoint = "False",
			anchorPointX = "0.5",
			anchorPointY = "0.5",
			backGroundScale9Enable = "False",
			bgColorOpacity = "50",
			bIsOpenClipping = "False",
			classname = "MEPanel",
			colorType = "0;SingleColor:#FFFF4500;GraduallyChangingColorStart:#FFFFFFFF;GraduallyChangingColorEnd:#FFFFFFFF;vectorX:0;vectorY:0",
			DesignHeight = "640",
			DesignType = "0",
			DesignWidth = "960",
			dstBlendFunc = "771",
			height = "548",
			ignoreSize = "False",
			name = "Panel",
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
			width = "924",
			ZOrder = "1",
			components = 
			{
				
				{
					controlID = "Panel_root_Panel-taskActivityViewFanshi_fanshiAssist_activity_Game",
					UUID = "ff224a17_7dee_4885_a5d2_291996097ce4",
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
					height = "548",
					ignoreSize = "False",
					name = "Panel_root",
					sizepercentx = "100",
					sizepercenty = "100",
					sizeType = "1",
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
					width = "888",
					ZOrder = "1",
					components = 
					{
						
						{
							controlID = "Image_diban_Panel_root_Panel-taskActivityViewFanshi_fanshiAssist_activity_Game",
							UUID = "4a2ccc29_081f_439b_9d50_1dada18df95a",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							backGroundScale9Enable = "False",
							classname = "MEImage",
							dstBlendFunc = "771",
							height = "548",
							ignoreSize = "True",
							name = "Image_diban",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							texturePath = "ui/activity/001.png",
							touchAble = "False",
							UILayoutViewModel = 
							{
								relativeToName = "Panel",
								nGravity = 6,
								nAlign = 5
							},
							visible = "False",
							width = "888",
							ZOrder = "1",
						},
						{
							controlID = "Image_ad_Panel_root_Panel-taskActivityViewFanshi_fanshiAssist_activity_Game",
							UUID = "f9ede063_5705_4fa0_b69b_2d1d533b21ad",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							backGroundScale9Enable = "False",
							classname = "MEImage",
							dstBlendFunc = "771",
							height = "129",
							ignoreSize = "True",
							name = "Image_ad",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							texturePath = "ui/activity/fanshiAssist/taskActivity/bg.png",
							touchAble = "False",
							UILayoutViewModel = 
							{
								PositionY = 191,
							},
							width = "924",
							ZOrder = "1",
							components = 
							{
								
								{
									controlID = "Label_date_Image_ad_Panel_root_Panel-taskActivityViewFanshi_fanshiAssist_activity_Game",
									UUID = "657d7b2a_bb4e_41c1_ad42_5a8d748e5f3e",
									anchorPoint = "False",
									anchorPointX = "1",
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
									fontSize = "18",
									fontStroke = 
									{
										IsStroke = true,
										StrokeColor = "#FF000000",
										StrokeSize = 1,
									},
									height = "23",
									ignoreSize = "True",
									name = "Label_date",
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
										PositionX = 452,
										PositionY = -48,
									},
									width = "95",
									ZOrder = "1",
								},
								{
									controlID = "Label_timing_Image_ad_Panel_root_Panel-taskActivityViewFanshi_fanshiAssist_activity_Game",
									UUID = "eefdacc0_5881_4dce_b8ff_41ab91fae368",
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
										IsStroke = true,
										StrokeColor = "#FF000000",
										StrokeSize = 1,
									},
									height = "25",
									ignoreSize = "False",
									name = "Label_timing",
									nTextAlign = "1",
									nTextHAlign = "0",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "Se termine dans 48j 20 h",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionX = -459,
										PositionY = 78,
									},
									width = "350",
									ZOrder = "1",
								},
								{
									controlID = "Label_time_begin_Image_ad_Panel_root_Panel-taskActivityViewFanshi_fanshiAssist_activity_Game",
									UUID = "e63d339c_77b8_4f82_9227_9dba205bd1e6",
									anchorPoint = "False",
									anchorPointX = "0",
									anchorPointY = "1",
									classname = "MELabel",
									compPath = "luacomponents.common.MEIconLabel",
									dstBlendFunc = "771",
									FontColor = "#FFFFFFFF",
									fontName = "phanta.ttf",
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
										IsStroke = true,
										StrokeColor = "#FFC97CD4",
										StrokeSize = 2,
									},
									height = "27",
									ignoreSize = "True",
									name = "Label_time_begin",
									nTextAlign = "1",
									nTextHAlign = "1",
									rotation = "-14",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "TextLable",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionX = -435,
										PositionY = 11,
									},
									visible = "False",
									width = "82",
									ZOrder = "1",
								},
								{
									controlID = "Label_time_end_Image_ad_Panel_root_Panel-taskActivityViewFanshi_fanshiAssist_activity_Game",
									UUID = "b73d102f_501c_42b1_939b_632f60618fa4",
									anchorPoint = "False",
									anchorPointX = "0",
									anchorPointY = "1",
									classname = "MELabel",
									compPath = "luacomponents.common.MEIconLabel",
									dstBlendFunc = "771",
									FontColor = "#FFFFFFFF",
									fontName = "phanta.ttf",
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
										IsStroke = true,
										StrokeColor = "#FFC97CD4",
										StrokeSize = 2,
									},
									height = "27",
									ignoreSize = "True",
									name = "Label_time_end",
									nTextAlign = "1",
									nTextHAlign = "1",
									rotation = "-14",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "TextLable",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionX = -455,
										PositionY = -19,
									},
									visible = "False",
									width = "82",
									ZOrder = "1",
								},
								{
									controlID = "Label_time_tip_Image_ad_Panel_root_Panel-taskActivityViewFanshi_fanshiAssist_activity_Game",
									UUID = "507fddcd_ffd9_4007_b5ef_a6c688dd2c95",
									anchorPoint = "False",
									anchorPointX = "0",
									anchorPointY = "1",
									classname = "MELabel",
									compPath = "luacomponents.common.MEIconLabel",
									dstBlendFunc = "771",
									FontColor = "#FFFFFFFF",
									fontName = "phanta.ttf",
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
										IsStroke = true,
										StrokeColor = "#FFC97CD4",
										StrokeSize = 2,
									},
									height = "27",
									ignoreSize = "True",
									name = "Label_time_tip",
									nTextAlign = "0",
									nTextHAlign = "0",
									rotation = "-14",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "TextLable",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionX = -417,
										PositionY = 42,
									},
									visible = "False",
									width = "82",
									ZOrder = "1",
								},
							},
						},
						{
							controlID = "ScrollView_task_Panel_root_Panel-taskActivityViewFanshi_fanshiAssist_activity_Game",
							UUID = "7cc8c0fa_310b_4e04_a5dc_4f282f5e3b06",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							backGroundScale9Enable = "False",
							bgColorOpacity = "50",
							bIsOpenClipping = "True",
							bounceEnable = "True",
							classname = "MEScrollView",
							colorType = "0;SingleColor:#FFE6E6E6;GraduallyChangingColorStart:#FFFFFFFF;GraduallyChangingColorEnd:#FFFFFFFF;vectorX:0;vectorY:0",
							direction = "1",
							dstBlendFunc = "771",
							height = "410",
							ignoreSize = "False",
							innerHeight = "415",
							innerWidth = "924",
							name = "ScrollView_task",
							showScrollbar = "False",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							touchAble = "True",
							UILayoutViewModel = 
							{
								PositionX = -1,
								PositionY = -81,
							},
							uipanelviewmodel = 
							{
								Layout="Absolute",
								nType = "0"
							},
							width = "924",
							ZOrder = "1",
						},
					},
				},
				{
					controlID = "Panel_prefab_Panel-taskActivityViewFanshi_fanshiAssist_activity_Game",
					UUID = "bc502bc1_9378_4755_afd2_5db45dbd7ac9",
					anchorPoint = "False",
					anchorPointX = "0",
					anchorPointY = "0",
					backGroundScale9Enable = "False",
					bgColorOpacity = "50",
					bIsOpenClipping = "False",
					classname = "MEPanel",
					colorType = "1;SingleColor:#FFE6E6E6;GraduallyChangingColorStart:#FFFFFFFF;GraduallyChangingColorEnd:#FFFFFFFF;vectorX:0;vectorY:0",
					DesignHeight = "640",
					DesignType = "0",
					DesignWidth = "960",
					dstBlendFunc = "771",
					height = "548",
					ignoreSize = "False",
					name = "Panel_prefab",
					sizepercentx = "100",
					sizepercenty = "100",
					sizeType = "1",
					srcBlendFunc = "1",
					touchAble = "False",
					UILayoutViewModel = 
					{
						PositionX = 686,
						PositionY = -575,
						LeftPositon = 1148,
						TopPosition = 301,
						relativeToName = "Panel",
						nType = 3,
					},
					uipanelviewmodel = 
					{
						Layout="Absolute",
						nType = "0"
					},
					width = "888",
					ZOrder = "1",
					components = 
					{
						
						{
							controlID = "Panel_taskItem_Panel_prefab_Panel-taskActivityViewFanshi_fanshiAssist_activity_Game",
							UUID = "787cd1f8_e3dc_48d0_8955_8740a5a413a7",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							backGroundScale9Enable = "False",
							bgColorOpacity = "50",
							bIsOpenClipping = "False",
							classname = "MEPanel",
							colorType = "0;SingleColor:#FF000000;GraduallyChangingColorStart:#FFFFFFFF;GraduallyChangingColorEnd:#FFFFFFFF;vectorX:0;vectorY:0",
							DesignHeight = "640",
							DesignType = "0",
							DesignWidth = "960",
							dstBlendFunc = "771",
							height = "135",
							ignoreSize = "False",
							name = "Panel_taskItem",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							touchAble = "False",
							UILayoutViewModel = 
							{
								PositionX = 500,
								PositionY = 321,
							},
							uipanelviewmodel = 
							{
								Layout="Absolute",
								nType = "0"
							},
							width = "920",
							ZOrder = "1",
							components = 
							{
								
								{
									controlID = "Image_diban_Panel_taskItem_Panel_prefab_Panel-taskActivityViewFanshi_fanshiAssist_activity_Game",
									UUID = "b6301647_3954_4555_b44c_248cc508db72",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "126",
									ignoreSize = "True",
									name = "Image_diban",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/activity/fanshiAssist/taskActivity/01.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										
									},
									width = "919",
									ZOrder = "1",
								},
								{
									controlID = "Image_icon_Panel_taskItem_Panel_prefab_Panel-taskActivityViewFanshi_fanshiAssist_activity_Game",
									UUID = "e5315e35_f723_4d7a_8303_c44faaff3d31",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "130",
									ignoreSize = "True",
									name = "Image_icon",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/task/icon_5.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = -392,
										PositionY = -6,
									},
									width = "130",
									ZOrder = "1",
								},
								{
									controlID = "Label_desc_Panel_taskItem_Panel_prefab_Panel-taskActivityViewFanshi_fanshiAssist_activity_Game",
									UUID = "20140d7e_e7bd_415d_b318_162b076eed5a",
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
									height = "54",
									ignoreSize = "False",
									name = "Label_desc",
									nTextAlign = "0",
									nTextHAlign = "0",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "Contenu de la quête",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionX = -168,
										PositionY = 9,
									},
									width = "258",
									ZOrder = "1",
								},
								{
									controlID = "Image_activityMainView_1_Panel_taskItem_Panel_prefab_Panel-taskActivityViewFanshi_fanshiAssist_activity_Game",
									UUID = "2e761ee9_bd78_437e_98ff_cd9b05474823",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "2",
									ignoreSize = "True",
									name = "Image_activityMainView_1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/activity/013.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = -172,
										PositionY = -22,
									},
									visible = "False",
									width = "244",
									ZOrder = "1",
								},
								{
									controlID = "Label_progress_title_Panel_taskItem_Panel_prefab_Panel-taskActivityViewFanshi_fanshiAssist_activity_Game",
									UUID = "12d392d4_0a98_4b1b_956c_b7c3a03e1792",
									anchorPoint = "False",
									anchorPointX = "1",
									anchorPointY = "0.5",
									classname = "MELabel",
									compPath = "luacomponents.common.MEIconLabel",
									dstBlendFunc = "771",
									FontColor = "#FF3C0F53",
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
									name = "Label_progress_title",
									nTextAlign = "1",
									nTextHAlign = "1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "Progression quête",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionX = -32,
										PositionY = -29,
									},
									width = "130",
									ZOrder = "1",
								},
								{
									controlID = "Label_progress_Panel_taskItem_Panel_prefab_Panel-taskActivityViewFanshi_fanshiAssist_activity_Game",
									UUID = "e947e5c3_b62c_4bb5_96ab_b485ffa6e66b",
									anchorPoint = "False",
									anchorPointX = "1",
									anchorPointY = "0.5",
									classname = "MELabel",
									compPath = "luacomponents.common.MEIconLabel",
									dstBlendFunc = "771",
									FontColor = "#FF3C0F53",
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
									name = "Label_progress",
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
										PositionX = -32,
										PositionY = -48,
									},
									width = "74",
									ZOrder = "1",
								},
								{
									controlID = "Image_reward_1_Panel_taskItem_Panel_prefab_Panel-taskActivityViewFanshi_fanshiAssist_activity_Game",
									UUID = "afad4d43_d743_4c65_8096_a867344f01a5",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "82",
									ignoreSize = "True",
									name = "Image_reward_1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/task/reward_diban.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = 42,
										PositionY = -4,
									},
									width = "82",
									ZOrder = "1",
								},
								{
									controlID = "Image_reward_2_Panel_taskItem_Panel_prefab_Panel-taskActivityViewFanshi_fanshiAssist_activity_Game",
									UUID = "48d73956_aac9_466d_be07_71e4eb897931",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "82",
									ignoreSize = "True",
									name = "Image_reward_2",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/task/reward_diban.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = 141,
										PositionY = -4,
									},
									width = "82",
									ZOrder = "1",
								},
								{
									controlID = "Image_reward_3_Panel_taskItem_Panel_prefab_Panel-taskActivityViewFanshi_fanshiAssist_activity_Game",
									UUID = "a3f3ab9d_b011_400f_bcc1_2da525a15732",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "82",
									ignoreSize = "True",
									name = "Image_reward_3",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/task/reward_diban.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = 239,
										PositionY = -4,
									},
									width = "82",
									ZOrder = "1",
								},
								{
									controlID = "Button_receive_Panel_taskItem_Panel_prefab_Panel-taskActivityViewFanshi_fanshiAssist_activity_Game",
									UUID = "7a306db2_18de_49f8_ad17_b19f370e1e56",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEButton",
									ClickHighLightEnabled = "True",
									dstBlendFunc = "771",
									flipX = "False",
									flipY = "False",
									height = "64",
									ignoreSize = "True",
									name = "Button_receive",
									normal = "ui/activity/fanshiAssist/taskActivity/03.png",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "True",
									UILayoutViewModel = 
									{
										PositionX = 369,
										PositionY = -7,
									},
									UItype = "Button",
									width = "154",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "Label_receive_Button_receive_Panel_taskItem_Panel_prefab_Panel-taskActivityViewFanshi_fanshiAssist_activity_Game",
											UUID = "ba7f2094_4fb8_4056_b95a_13bc4ff41dea",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											classname = "MELabel",
											compPath = "luacomponents.common.MEIconLabel",
											dstBlendFunc = "771",
											FontColor = "#FF7D26CA",
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
											height = "0",
											ignoreSize = "False",
											name = "Label_receive",
											nTextAlign = "1",
											nTextHAlign = "1",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "770",
											text = "Récupérer",
											touchAble = "False",
											touchScaleEnable = "False",
											UILayoutViewModel = 
											{
												
											},
											width = "124",
											ZOrder = "1",
										},
									},
								},
								{
									controlID = "Label_geted_Panel_taskItem_Panel_prefab_Panel-taskActivityViewFanshi_fanshiAssist_activity_Game",
									UUID = "8ae69f6d_f386_4f91_ad4f_824c9a4c6295",
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
									fontSize = "26",
									fontStroke = 
									{
										IsStroke = false,
										StrokeColor = "#FFE6E6E6",
										StrokeSize = 1,
									},
									height = "30",
									ignoreSize = "True",
									name = "Label_geted",
									nTextAlign = "1",
									nTextHAlign = "1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "Récupéré",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionX = 369,
										PositionY = -7,
									},
									width = "132",
									ZOrder = "1",
								},
								{
									controlID = "Image_activityMainView_2_Panel_taskItem_Panel_prefab_Panel-taskActivityViewFanshi_fanshiAssist_activity_Game",
									UUID = "5cb571f8_e2a7_4aa7_a560_21f5058adbd6",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "48",
									ignoreSize = "True",
									name = "Image_activityMainView_2",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/task/split_1.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = -29,
										PositionY = -8,
									},
									visible = "False",
									width = "4",
									ZOrder = "1",
								},
								{
									controlID = "Label_reward_Panel_taskItem_Panel_prefab_Panel-taskActivityViewFanshi_fanshiAssist_activity_Game",
									UUID = "cfeddf57_76fe_498a_8154_1c30ae822179",
									anchorPoint = "False",
									anchorPointX = "0",
									anchorPointY = "0.5",
									classname = "MELabel",
									compPath = "luacomponents.common.MEIconLabel",
									dstBlendFunc = "771",
									FontColor = "#FF96A0C0",
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
									name = "Label_reward",
									nTextAlign = "1",
									nTextHAlign = "1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "Récompense quête",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionX = -25,
										PositionY = 52,
									},
									visible = "False",
									width = "135",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "Image_activityMainView_1_Label_reward_Panel_taskItem_Panel_prefab_Panel-taskActivityViewFanshi_fanshiAssist_activity_Game",
											UUID = "43cef4fe_14fe_495c_9821_a26b5353626e",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											classname = "MEImage",
											dstBlendFunc = "771",
											height = "18",
											ignoreSize = "True",
											name = "Image_activityMainView_1",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											texturePath = "ui/activity/014.png",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = -5,
												PositionY = 2,
											},
											width = "4",
											ZOrder = "1",
										},
									},
								},
								{
									controlID = "Button_goto_Panel_taskItem_Panel_prefab_Panel-taskActivityViewFanshi_fanshiAssist_activity_Game",
									UUID = "82846c69_5e24_45df_a9e7_5743b1c11c11",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEButton",
									ClickHighLightEnabled = "True",
									dstBlendFunc = "771",
									flipX = "False",
									flipY = "False",
									height = "64",
									ignoreSize = "True",
									name = "Button_goto",
									normal = "ui/activity/fanshiAssist/taskActivity/02.png",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "True",
									UILayoutViewModel = 
									{
										PositionX = 369,
										PositionY = -7,
									},
									UItype = "Button",
									width = "154",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "Label_goto_Button_goto_Panel_taskItem_Panel_prefab_Panel-taskActivityViewFanshi_fanshiAssist_activity_Game",
											UUID = "b0c00fce_5534_4aa2_a3ee_c30e2853bcd8",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											classname = "MELabel",
											compPath = "luacomponents.common.MEIconLabel",
											dstBlendFunc = "771",
											FontColor = "#FFF7D3FA",
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
											name = "Label_goto",
											nTextAlign = "1",
											nTextHAlign = "1",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "770",
											text = "Aller",
											touchAble = "False",
											touchScaleEnable = "False",
											UILayoutViewModel = 
											{
												
											},
											width = "64",
											ZOrder = "1",
										},
									},
								},
								{
									controlID = "Image_reset_Panel_taskItem_Panel_prefab_Panel-taskActivityViewFanshi_fanshiAssist_activity_Game",
									UUID = "d60ba85e_42ba_45a3_8275_7fff1ca00a4e",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "34",
									ignoreSize = "True",
									name = "Image_reset",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/activity/023.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = -395,
										PositionY = 40,
									},
									width = "122",
									ZOrder = "1",
								},
								{
									controlID = "Image_get_Panel_taskItem_Panel_prefab_Panel-taskActivityViewFanshi_fanshiAssist_activity_Game",
									UUID = "2cebe0c1_6540_4afe_9319_6abacf0d6987",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "True;capInsetsX:0;capInsetsY:0;capInsetsWidth:0;capInsetsHeight:0",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "160",
									ignoreSize = "False",
									name = "Image_get",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/activity/fanshiAssist/taskActivity/04.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										
									},
									width = "952",
									ZOrder = "1",
								},
								{
									controlID = "Image_getted_Panel_taskItem_Panel_prefab_Panel-taskActivityViewFanshi_fanshiAssist_activity_Game",
									UUID = "7d93702b_da58_438a_8942_1240bbb7ef6e",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "True;capInsetsX:0;capInsetsY:0;capInsetsWidth:0;capInsetsHeight:0",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "128",
									ignoreSize = "False",
									name = "Image_getted",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/activity/fanshiAssist/taskActivity/05.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										
									},
									width = "920",
									ZOrder = "1",
								},
								{
									controlID = "Image_lock_Panel_taskItem_Panel_prefab_Panel-taskActivityViewFanshi_fanshiAssist_activity_Game",
									UUID = "04ae5d0c_ee50_466b_b972_d85879ce9fe9",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "129",
									ignoreSize = "True",
									name = "Image_lock",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/activity/activityStyle/taskActivity/styleCur/lock.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = 1,
										relativeToName = "Panel",
									},
									width = "919",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "Label_lock_Image_lock_Panel_taskItem_Panel_prefab_Panel-taskActivityViewFanshi_fanshiAssist_activity_Game",
											UUID = "6586476c_c307_4e6b_ab7d_cae630e78784",
											anchorPoint = "False",
											anchorPointX = "0",
											anchorPointY = "0.5",
											classname = "MELabel",
											compPath = "luacomponents.common.MEIconLabel",
											dstBlendFunc = "771",
											FontColor = "#FFFFFFFF",
											fontName = "phanta.ttf",
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
											name = "Label_lock",
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
												PositionX = -449,
												PositionY = 46,
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
		},
	},
	actions = 
	{
		
	},
	respaths = 
	{
		textures = 
		{
			"ui/activity/001.png",
			"ui/activity/fanshiAssist/taskActivity/bg.png",
			"ui/activity/fanshiAssist/taskActivity/01.png",
			"ui/task/icon_5.png",
			"ui/activity/013.png",
			"ui/task/reward_diban.png",
			"ui/activity/fanshiAssist/taskActivity/03.png",
			"ui/task/split_1.png",
			"ui/activity/014.png",
			"ui/activity/fanshiAssist/taskActivity/02.png",
			"ui/activity/023.png",
			"ui/activity/fanshiAssist/taskActivity/04.png",
			"ui/activity/fanshiAssist/taskActivity/05.png",
			"ui/activity/activityStyle/taskActivity/styleCur/lock.png",
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

