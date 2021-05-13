local t = 
{
	version = 1,
	components = 
	{
		
		{
			controlID = "Panel-taskActivityView_Layer1_activity_Game",
			UUID = "bb31b2e6_d136_41de_af09_b01619a6e08d",
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
			width = "888",
			ZOrder = "1",
			components = 
			{
				
				{
					controlID = "Panel_root_Panel-taskActivityView_Layer1_activity_Game",
					UUID = "fab09116_ae91_4dc7_8f78_6ca011e35a6e",
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
							controlID = "Image_diban_Panel_root_Panel-taskActivityView_Layer1_activity_Game",
							UUID = "1e425a55_dd8b_495a_bd7a_ee76c1aa5d5a",
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
							width = "888",
							ZOrder = "1",
						},
						{
							controlID = "Image_ad_Panel_root_Panel-taskActivityView_Layer1_activity_Game",
							UUID = "808d10a1_b9f2_42ab_bd0b_2e57a263d584",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							backGroundScale9Enable = "False",
							classname = "MEImage",
							dstBlendFunc = "771",
							height = "140",
							ignoreSize = "True",
							name = "Image_ad",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							texturePath = "ui/activity/ad2.png",
							touchAble = "False",
							UILayoutViewModel = 
							{
								PositionY = 191,
							},
							width = "856",
							ZOrder = "1",
							components = 
							{
								
								{
									controlID = "Label_date_Image_ad_Panel_root_Panel-taskActivityView_Layer1_activity_Game",
									UUID = "96786355_e5d6_4563_923f_a0419ea3c144",
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
									fontSize = "20",
									fontStroke = 
									{
										IsStroke = true,
										StrokeColor = "#FF000000",
										StrokeSize = 1,
									},
									height = "25",
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
										PositionX = 417,
										PositionY = -51,
									},
									width = "82",
									ZOrder = "1",
								},
								{
									controlID = "Label_timing_Image_ad_Panel_root_Panel-taskActivityView_Layer1_activity_Game",
									UUID = "f3655dcb_5519_449f_8510_90fffd8dd8a5",
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
									text = "Berakhir dalam 48 hari 20 jam",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionX = -417,
										PositionY = 75,
									},
									width = "350",
									ZOrder = "1",
								},
								{
									controlID = "Label_time_end_Image_ad_Panel_root_Panel-taskActivityView_Layer1_activity_Game",
									UUID = "d5ffe040_bbca_4e4d_bf0c_2128f90069f3",
									anchorPoint = "False",
									anchorPointX = "0",
									anchorPointY = "1",
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
									nTextAlign = "0",
									nTextHAlign = "0",
									rotation = "-14",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "Waktu Event",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionX = -455,
										PositionY = -19,
									},
									visible = "False",
									width = "140",
									ZOrder = "1",
								},
								{
									controlID = "Image_time_Image_ad_Panel_root_Panel-taskActivityView_Layer1_activity_Game",
									UUID = "31df6701_7086_402e_96e0_ec3985a6e9d6",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "59",
									ignoreSize = "True",
									name = "Image_time",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/activity/fashionStore/1/004.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = -393,
										PositionY = 36,
									},
									visible = "False",
									width = "140",
									ZOrder = "1",
								},
								{
									controlID = "Label_time_begin_Image_ad_Panel_root_Panel-taskActivityView_Layer1_activity_Game",
									UUID = "ff48761b_6664_4f01_bc3b_b183ecb0c419",
									anchorPoint = "False",
									anchorPointX = "0",
									anchorPointY = "1",
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
									nTextAlign = "0",
									nTextHAlign = "0",
									rotation = "-14",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "Waktu Event",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionX = -435,
										PositionY = 11,
									},
									visible = "False",
									width = "140",
									ZOrder = "1",
								},
								{
									controlID = "Label_time_tip_Image_ad_Panel_root_Panel-taskActivityView_Layer1_activity_Game",
									UUID = "fd62fcef_0737_4368_9ee4_7e74a7db5c37",
									anchorPoint = "False",
									anchorPointX = "0",
									anchorPointY = "1",
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
									text = "Waktu Event",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionX = -417,
										PositionY = 42,
									},
									visible = "False",
									width = "140",
									ZOrder = "1",
								},
							},
						},
						{
							controlID = "ScrollView_task_Panel_root_Panel-taskActivityView_Layer1_activity_Game",
							UUID = "777a0dd3_8036_476e_a876_03c282db12ad",
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
							height = "380",
							ignoreSize = "False",
							innerHeight = "380",
							innerWidth = "850",
							name = "ScrollView_task",
							showScrollbar = "False",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							touchAble = "True",
							UILayoutViewModel = 
							{
								PositionY = -69,
							},
							uipanelviewmodel = 
							{
								Layout="Absolute",
								nType = "0"
							},
							width = "850",
							ZOrder = "1",
						},
					},
				},
				{
					controlID = "Panel_prefab_Panel-taskActivityView_Layer1_activity_Game",
					UUID = "3befaf70_6f4d_4515_9b50_88261b8d548a",
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
						PositionX = 704,
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
							controlID = "Panel_taskItem_Panel_prefab_Panel-taskActivityView_Layer1_activity_Game",
							UUID = "fa3a2a69_c959_4a39_b44d_770a36d5f89f",
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
							height = "130",
							ignoreSize = "False",
							name = "Panel_taskItem",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							touchAble = "False",
							UILayoutViewModel = 
							{
								PositionX = 469,
								PositionY = 321,
							},
							uipanelviewmodel = 
							{
								Layout="Absolute",
								nType = "0"
							},
							width = "844",
							ZOrder = "1",
							components = 
							{
								
								{
									controlID = "Image_diban_Panel_taskItem_Panel_prefab_Panel-taskActivityView_Layer1_activity_Game",
									UUID = "7c54f100_4bea_49d0_9a43_2f876c8dd819",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "130",
									ignoreSize = "True",
									name = "Image_diban",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/activity/012.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										
									},
									width = "844",
									ZOrder = "1",
								},
								{
									controlID = "Image_icon_Panel_taskItem_Panel_prefab_Panel-taskActivityView_Layer1_activity_Game",
									UUID = "1865266f_c916_46d1_ba74_2e9b89f12603",
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
										PositionX = -357,
										PositionY = -6,
									},
									width = "130",
									ZOrder = "1",
								},
								{
									controlID = "Label_desc_Panel_taskItem_Panel_prefab_Panel-taskActivityView_Layer1_activity_Game",
									UUID = "a3f7aeea_3996_41f9_a6aa_6df6950ec176",
									anchorPoint = "False",
									anchorPointX = "0.5",
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
									fontSize = "20",
									fontStroke = 
									{
										IsStroke = false,
										StrokeColor = "#FFE6E6E6",
										StrokeSize = 1,
									},
									height = "0",
									ignoreSize = "False",
									name = "Label_desc",
									nTextAlign = "0",
									nTextHAlign = "0",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "Konten Quest",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionX = -168,
										PositionY = 9,
									},
									width = "266",
									ZOrder = "1",
								},
								{
									controlID = "Image_activityMainView_1_Panel_taskItem_Panel_prefab_Panel-taskActivityView_Layer1_activity_Game",
									UUID = "cf47dcca_f568_45d2_b100_a313a149ff28",
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
									width = "244",
									ZOrder = "1",
								},
								{
									controlID = "Label_progress_title_Panel_taskItem_Panel_prefab_Panel-taskActivityView_Layer1_activity_Game",
									UUID = "8f7201f3_f33f_44cc_a770_8e06a367dcf8",
									anchorPoint = "False",
									anchorPointX = "0",
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
									text = "Progres Quest",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionX = -296,
										PositionY = -39,
									},
									width = "105",
									ZOrder = "1",
								},
								{
									controlID = "Label_progress_Panel_taskItem_Panel_prefab_Panel-taskActivityView_Layer1_activity_Game",
									UUID = "80dcb361_2001_4e2f_875e_576e369be052",
									anchorPoint = "False",
									anchorPointX = "1",
									anchorPointY = "0.5",
									classname = "MELabel",
									compPath = "luacomponents.common.MEIconLabel",
									dstBlendFunc = "771",
									FontColor = "#FFFD3870",
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
										PositionX = -51,
										PositionY = -39,
									},
									width = "80",
									ZOrder = "1",
								},
								{
									controlID = "Image_reward_1_Panel_taskItem_Panel_prefab_Panel-taskActivityView_Layer1_activity_Game",
									UUID = "f8c21d39_2303_4cca_8987_afb7f053ceb8",
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
										PositionX = 30,
										PositionY = -7,
									},
									width = "82",
									ZOrder = "1",
								},
								{
									controlID = "Image_reward_2_Panel_taskItem_Panel_prefab_Panel-taskActivityView_Layer1_activity_Game",
									UUID = "c3687b63_8938_4b8f_bea2_af457b99cb26",
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
										PositionX = 118,
										PositionY = -7,
									},
									width = "82",
									ZOrder = "1",
								},
								{
									controlID = "Image_reward_3_Panel_taskItem_Panel_prefab_Panel-taskActivityView_Layer1_activity_Game",
									UUID = "f3f4884e_3240_446c_871c_2f33a5a476fc",
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
										PositionX = 210,
										PositionY = -7,
									},
									width = "82",
									ZOrder = "1",
								},
								{
									controlID = "Button_receive_Panel_taskItem_Panel_prefab_Panel-taskActivityView_Layer1_activity_Game",
									UUID = "91e97ce2_3791_435d_9b9c_6ca5f8e84be1",
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
									name = "Button_receive",
									normal = "ui/common/button_middle_n.png",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "True",
									UILayoutViewModel = 
									{
										PositionX = 339,
										PositionY = -21,
									},
									UItype = "Button",
									width = "124",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "Label_receive_Button_receive_Panel_taskItem_Panel_prefab_Panel-taskActivityView_Layer1_activity_Game",
											UUID = "2db50413_cdeb_406c_b44f_cda20c44cddd",
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
											name = "Label_receive",
											nTextAlign = "1",
											nTextHAlign = "1",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "770",
											text = "Klaim Hadiah",
											touchAble = "False",
											touchScaleEnable = "False",
											UILayoutViewModel = 
											{
												
											},
											width = "123",
											ZOrder = "1",
										},
									},
								},
								{
									controlID = "Label_geted_Panel_taskItem_Panel_prefab_Panel-taskActivityView_Layer1_activity_Game",
									UUID = "0f5c0bfb_521a_40e1_88c9_4c948a055693",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									classname = "MELabel",
									compPath = "luacomponents.common.MEIconLabel",
									dstBlendFunc = "771",
									FontColor = "#FF3E4474",
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
									name = "Label_geted",
									nTextAlign = "1",
									nTextHAlign = "1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "Sudah diklaim",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionX = 342,
										PositionY = -23,
									},
									width = "128",
									ZOrder = "1",
								},
								{
									controlID = "Image_activityMainView_2_Panel_taskItem_Panel_prefab_Panel-taskActivityView_Layer1_activity_Game",
									UUID = "78bd279f_0d6e_40bb_a3db_81b537aa4409",
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
									width = "4",
									ZOrder = "1",
								},
								{
									controlID = "Label_reward_Panel_taskItem_Panel_prefab_Panel-taskActivityView_Layer1_activity_Game",
									UUID = "98700e5f_8be8_4869_a83a_de406e86811c",
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
									text = "Hadiah Quest",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionX = -25,
										PositionY = 52,
									},
									width = "102",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "Image_activityMainView_1_Label_reward_Panel_taskItem_Panel_prefab_Panel-taskActivityView_Layer1_activity_Game",
											UUID = "1d3217c0_3d6d_4bb7_bb11_6f9e84f777cb",
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
									controlID = "Button_goto_Panel_taskItem_Panel_prefab_Panel-taskActivityView_Layer1_activity_Game",
									UUID = "e155a3d0_e06e_468a_a34e_bbd30a31fb0f",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "True;capInsetsX:0;capInsetsY:0;capInsetsWidth:0;capInsetsHeight:0",
									classname = "MEButton",
									ClickHighLightEnabled = "True",
									dstBlendFunc = "771",
									flipX = "False",
									flipY = "False",
									height = "54",
									ignoreSize = "False",
									name = "Button_goto",
									normal = "ui/task/1101.png",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "True",
									UILayoutViewModel = 
									{
										PositionX = 339,
										PositionY = -21,
									},
									UItype = "Button",
									width = "124",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "Label_goto_Button_goto_Panel_taskItem_Panel_prefab_Panel-taskActivityView_Layer1_activity_Game",
											UUID = "d7246394_7fa0_4f2c_8b2b_e06ce36b26ba",
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
											name = "Label_goto",
											nTextAlign = "1",
											nTextHAlign = "1",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "770",
											text = "Maju",
											touchAble = "False",
											touchScaleEnable = "False",
											UILayoutViewModel = 
											{
												
											},
											width = "48",
											ZOrder = "1",
										},
									},
								},
								{
									controlID = "Image_reset_Panel_taskItem_Panel_prefab_Panel-taskActivityView_Layer1_activity_Game",
									UUID = "1ace2abe_22cc_41f6_aa3e_6730382283fc",
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
										PositionX = -361,
										PositionY = 48,
									},
									width = "122",
									ZOrder = "1",
								},
								{
									controlID = "Image_lock_Panel_taskItem_Panel_prefab_Panel-taskActivityView_Layer1_activity_Game",
									UUID = "48dbb0e2_1567_4ad6_bce7_d3bffa3a3cfd",
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
									touchAble = "True",
									UILayoutViewModel = 
									{
										
									},
									visible = "False",
									width = "919",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "Label_lock_Image_lock_Panel_taskItem_Panel_prefab_Panel-taskActivityView_Layer1_activity_Game",
											UUID = "ed1c9f18_f53d_4870_96cf_e1c13db70c93",
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
			"ui/activity/ad2.png",
			"ui/activity/fashionStore/1/004.png",
			"ui/activity/012.png",
			"ui/task/icon_5.png",
			"ui/activity/013.png",
			"ui/task/reward_diban.png",
			"ui/common/button_middle_n.png",
			"ui/task/split_1.png",
			"ui/activity/014.png",
			"ui/task/1101.png",
			"ui/activity/023.png",
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

