local t = 
{
	version = 1,
	components = 
	{
		
		{
			controlID = "Panel-onkeyActionTaskView_flyShipGrowUp_explore_Game",
			UUID = "91593618_4e53_47d7_a5f8_ef3489d51984",
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
			width = "960",
			ZOrder = "1",
			components = 
			{
				
				{
					controlID = "Panel_base_Panel-onkeyActionTaskView_flyShipGrowUp_explore_Game",
					UUID = "0060c57f_1f97_4f0f_b6aa_7bb7d833e068",
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
						PositionX = -88,
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
							controlID = "Image_bg_Panel_base_Panel-onkeyActionTaskView_flyShipGrowUp_explore_Game",
							UUID = "ec2f4422_f15d_44e5_9a18_648d2849fec6",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							backGroundScale9Enable = "False",
							classname = "MEImage",
							dstBlendFunc = "771",
							height = "519",
							ignoreSize = "True",
							name = "Image_bg",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							texturePath = "ui/explore/growup/command/task/pop.png",
							touchAble = "False",
							UILayoutViewModel = 
							{
								PositionX = 569,
								PositionY = 320,
							},
							width = "1018",
							ZOrder = "1",
						},
						{
							controlID = "ScrollView_task_Panel_base_Panel-onkeyActionTaskView_flyShipGrowUp_explore_Game",
							UUID = "e147f361_54ce_471d_92cd_c39123571bdd",
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
							height = "390",
							ignoreSize = "False",
							innerHeight = "390",
							innerWidth = "998",
							name = "ScrollView_task",
							showScrollbar = "False",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							touchAble = "True",
							UILayoutViewModel = 
							{
								PositionX = 69,
								PositionY = 133,
							},
							uipanelviewmodel = 
							{
								Layout="Absolute",
								nType = "0"
							},
							width = "998",
							ZOrder = "1",
						},
						{
							controlID = "Button_sure_Panel_base_Panel-onkeyActionTaskView_flyShipGrowUp_explore_Game",
							UUID = "62a0f8df_96e7_4028_b275_8b887b9ac24e",
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
							name = "Button_sure",
							normal = "ui/common/button_middle_n.png",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							touchAble = "True",
							UILayoutViewModel = 
							{
								PositionX = 1000,
								PositionY = 103,
							},
							UItype = "Button",
							width = "124",
							ZOrder = "1",
							components = 
							{
								
								{
									controlID = "Label_sure_Button_sure_Panel_base_Panel-onkeyActionTaskView_flyShipGrowUp_explore_Game",
									UUID = "5c0b9fe9_160c_4999_837a_d0a0787b8e38",
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
									height = "30",
									ignoreSize = "True",
									name = "Label_sure",
									nTextAlign = "1",
									nTextHAlign = "1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "ยืนยัน",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionY = -2,
									},
									width = "51",
									ZOrder = "1",
								},
							},
						},
						{
							controlID = "Label_title_Panel_base_Panel-onkeyActionTaskView_flyShipGrowUp_explore_Game",
							UUID = "9f900aac_0f7f_463e_9b78_06dc7799d6f6",
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
							text = "派遣确认",
							touchAble = "False",
							touchScaleEnable = "False",
							UILayoutViewModel = 
							{
								PositionX = 74,
								PositionY = 547,
							},
							width = "115",
							ZOrder = "1",
							components = 
							{
								
								{
									controlID = "Image_flag_Label_title_Panel_base_Panel-onkeyActionTaskView_flyShipGrowUp_explore_Game",
									UUID = "c61e258b_678a_4074_b477_a68b13413196",
									anchorPoint = "False",
									anchorPointX = "0",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "27",
									ignoreSize = "True",
									name = "Image_flag",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/common/image_title.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = 118,
										PositionY = 1,
										IsPercent = true,
										PercentX = 101,
										PercentY = 2.86,
									},
									width = "121",
									ZOrder = "1",
								},
							},
						},
						{
							controlID = "Button_close_Panel_base_Panel-onkeyActionTaskView_flyShipGrowUp_explore_Game",
							UUID = "8aabb357_bed7_48c9_a2b6_cc978b639c4b",
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
								PositionX = 1046,
								PositionY = 546,
							},
							UItype = "Button",
							width = "60",
							ZOrder = "1",
						},
					},
				},
				{
					controlID = "Panel_prefab_Panel-onkeyActionTaskView_flyShipGrowUp_explore_Game",
					UUID = "6a48c837_2f57_460f_927c_5328971ebb13",
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
					height = "400",
					ignoreSize = "False",
					name = "Panel_prefab",
					sizepercentx = "0",
					sizepercenty = "0",
					sizeType = "0",
					srcBlendFunc = "1",
					touchAble = "False",
					UILayoutViewModel = 
					{
						PositionY = -640,
						BottomPosition = -640,
						relativeToName = "Panel",
						nType = 3,
						nGravity = 4,
						nAlign = 7
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
							controlID = "Panel_item_Panel_prefab_Panel-onkeyActionTaskView_flyShipGrowUp_explore_Game",
							UUID = "3286835b_dd20_4e8b_bd1a_44d31224e743",
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
							height = "135",
							ignoreSize = "False",
							name = "Panel_item",
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
							width = "984",
							ZOrder = "1",
							components = 
							{
								
								{
									controlID = "Image_1_Panel_item_Panel_prefab_Panel-onkeyActionTaskView_flyShipGrowUp_explore_Game",
									UUID = "6fa2773a_16ba_4e68_b02c_9c50883826d5",
									anchorPoint = "False",
									anchorPointX = "0",
									anchorPointY = "0",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "135",
									ignoreSize = "True",
									name = "Image_1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/explore/growup/command/task/item.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										
									},
									width = "984",
									ZOrder = "1",
								},
								{
									controlID = "Label_taskName_Panel_item_Panel_prefab_Panel-onkeyActionTaskView_flyShipGrowUp_explore_Game",
									UUID = "ae21520c_bcd6_4013_8981_93b03e4bec3d",
									anchorPoint = "False",
									anchorPointX = "0",
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
									height = "30",
									ignoreSize = "True",
									name = "Label_taskName",
									nTextAlign = "1",
									nTextHAlign = "1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "ป้ายข้อความ",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionX = 9,
										PositionY = 114,
									},
									width = "159",
									ZOrder = "1",
								},
								{
									controlID = "Label_tip1_Panel_item_Panel_prefab_Panel-onkeyActionTaskView_flyShipGrowUp_explore_Game",
									UUID = "0ffefee4_df52_4aac_9d2d_8bc06745aef7",
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
									fontSize = "22",
									fontStroke = 
									{
										IsStroke = false,
										StrokeColor = "#FFE6E6E6",
										StrokeSize = 1,
									},
									height = "25",
									ignoreSize = "True",
									name = "Label_tip1",
									nTextAlign = "1",
									nTextHAlign = "1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "概率奖励",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionX = 399,
										PositionY = 114,
									},
									width = "90",
									ZOrder = "1",
								},
								{
									controlID = "Label_tip2_Panel_item_Panel_prefab_Panel-onkeyActionTaskView_flyShipGrowUp_explore_Game",
									UUID = "87aa8587_68c8_4825_a11a_7ea9cc1b173c",
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
									fontSize = "22",
									fontStroke = 
									{
										IsStroke = false,
										StrokeColor = "#FFE6E6E6",
										StrokeSize = 1,
									},
									height = "25",
									ignoreSize = "True",
									name = "Label_tip2",
									nTextAlign = "1",
									nTextHAlign = "1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "额外奖励",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionX = 705,
										PositionY = 114,
									},
									width = "90",
									ZOrder = "1",
								},
								{
									controlID = "Image_quality_Panel_item_Panel_prefab_Panel-onkeyActionTaskView_flyShipGrowUp_explore_Game",
									UUID = "dfd26d1f_503d_429a_87ea_2ff013513ae8",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "153",
									ignoreSize = "True",
									name = "Image_quality",
									scaleX = "0.2",
									scaleY = "0.2",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/common/hero/quality_d.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = 334,
										PositionY = 114,
									},
									width = "158",
									ZOrder = "1",
								},
								{
									controlID = "ScrollView_sit_Panel_item_Panel_prefab_Panel-onkeyActionTaskView_flyShipGrowUp_explore_Game",
									UUID = "c960b849_33d2_4d2f_a2c3_1b9c68a3682a",
									anchorPoint = "False",
									anchorPointX = "0",
									anchorPointY = "0",
									backGroundScale9Enable = "False",
									bgColorOpacity = "50",
									bIsOpenClipping = "True",
									bounceEnable = "False",
									classname = "MEScrollView",
									colorType = "0;SingleColor:#FFE6E6E6;GraduallyChangingColorStart:#FFFFFFFF;GraduallyChangingColorEnd:#FFFFFFFF;vectorX:0;vectorY:0",
									direction = "2",
									dstBlendFunc = "771",
									height = "81",
									ignoreSize = "False",
									innerHeight = "81",
									innerWidth = "370",
									name = "ScrollView_sit",
									showScrollbar = "False",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "True",
									UILayoutViewModel = 
									{
										PositionX = 7,
										PositionY = 10,
									},
									uipanelviewmodel = 
									{
										Layout="Absolute",
										nType = "0"
									},
									width = "369",
									ZOrder = "1",
								},
								{
									controlID = "ScrollView_reward_Panel_item_Panel_prefab_Panel-onkeyActionTaskView_flyShipGrowUp_explore_Game",
									UUID = "5435274b_8de9_4544_a819_09c8241c4f55",
									anchorPoint = "False",
									anchorPointX = "0",
									anchorPointY = "0",
									backGroundScale9Enable = "False",
									bgColorOpacity = "50",
									bIsOpenClipping = "True",
									bounceEnable = "False",
									classname = "MEScrollView",
									colorType = "0;SingleColor:#FFE6E6E6;GraduallyChangingColorStart:#FFFFFFFF;GraduallyChangingColorEnd:#FFFFFFFF;vectorX:0;vectorY:0",
									direction = "2",
									dstBlendFunc = "771",
									height = "81",
									ignoreSize = "False",
									innerHeight = "81",
									innerWidth = "288",
									name = "ScrollView_reward",
									showScrollbar = "False",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "True",
									UILayoutViewModel = 
									{
										PositionX = 395,
										PositionY = 10,
									},
									uipanelviewmodel = 
									{
										Layout="Absolute",
										nType = "0"
									},
									width = "288",
									ZOrder = "1",
								},
								{
									controlID = "ScrollView_exReward_Panel_item_Panel_prefab_Panel-onkeyActionTaskView_flyShipGrowUp_explore_Game",
									UUID = "5d0a0193_7778_4c25_ba0e_01f610aa57e3",
									anchorPoint = "False",
									anchorPointX = "0",
									anchorPointY = "0",
									backGroundScale9Enable = "False",
									bgColorOpacity = "50",
									bIsOpenClipping = "True",
									bounceEnable = "False",
									classname = "MEScrollView",
									colorType = "0;SingleColor:#FFE6E6E6;GraduallyChangingColorStart:#FFFFFFFF;GraduallyChangingColorEnd:#FFFFFFFF;vectorX:0;vectorY:0",
									direction = "2",
									dstBlendFunc = "771",
									height = "81",
									ignoreSize = "False",
									innerHeight = "81",
									innerWidth = "144",
									name = "ScrollView_exReward",
									showScrollbar = "False",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "True",
									UILayoutViewModel = 
									{
										PositionX = 698,
										PositionY = 10,
									},
									uipanelviewmodel = 
									{
										Layout="Absolute",
										nType = "0"
									},
									width = "144",
									ZOrder = "1",
								},
								{
									controlID = "Button_select_Panel_item_Panel_prefab_Panel-onkeyActionTaskView_flyShipGrowUp_explore_Game",
									UUID = "ad5e38ff_0e12_42c7_b1b4_3bbb564446c4",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEButton",
									ClickHighLightEnabled = "True",
									dstBlendFunc = "771",
									flipX = "False",
									flipY = "False",
									height = "61",
									ignoreSize = "True",
									name = "Button_select",
									normal = "ui/explore/growup/command/task/dark_gou.png",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "True",
									UILayoutViewModel = 
									{
										PositionX = 918,
										PositionY = 51,
									},
									UItype = "Button",
									width = "61",
									ZOrder = "1",
								},
							},
						},
						{
							controlID = "Panel_roleItem_Panel_prefab_Panel-onkeyActionTaskView_flyShipGrowUp_explore_Game",
							UUID = "1b8f7899_bfff_454d_a0e7_2c43a7e1fda7",
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
							height = "107",
							ignoreSize = "False",
							name = "Panel_roleItem",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							touchAble = "False",
							UILayoutViewModel = 
							{
								PositionY = -162,
							},
							uipanelviewmodel = 
							{
								Layout="Absolute",
								nType = "0"
							},
							width = "115",
							ZOrder = "1",
							components = 
							{
								
								{
									controlID = "Image_border_Panel_roleItem_Panel_prefab_Panel-onkeyActionTaskView_flyShipGrowUp_explore_Game",
									UUID = "ab8fe77f_b024_4d7e_bd7c_6ca4c76baaf1",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "102",
									ignoreSize = "True",
									name = "Image_border",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/explore/growup/common/021.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = 59,
										PositionY = 48,
									},
									width = "98",
									ZOrder = "1",
								},
								{
									controlID = "ClippingNode_head_Panel_roleItem_Panel_prefab_Panel-onkeyActionTaskView_flyShipGrowUp_explore_Game",
									UUID = "13cc15c1_a67e_45ce_9619_f38f7604e06c",
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
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									stencilPath = "icon/hero/mask/01.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = 56,
										PositionY = 51,
										relativeToName = "Panel",
									},
									width = "100",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "Image_icon_ClippingNode_head_Panel_roleItem_Panel_prefab_Panel-onkeyActionTaskView_flyShipGrowUp_explore_Game",
											UUID = "3047e8ad_2d62_4e21_8faa_6d61875c0078",
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
								{
									controlID = "Image_cur_Panel_roleItem_Panel_prefab_Panel-onkeyActionTaskView_flyShipGrowUp_explore_Game",
									UUID = "016ae50e_fbeb_49be_a2ef_5409e91616af",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "52",
									ignoreSize = "True",
									name = "Image_cur",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/explore/growup/common/020.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = 57,
										PositionY = 20,
									},
									width = "120",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "Label_cur_Image_cur_Panel_roleItem_Panel_prefab_Panel-onkeyActionTaskView_flyShipGrowUp_explore_Game",
											UUID = "a6a9c2bc_5d16_4dd4_a5c2_ff66679d524f",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											classname = "MELabel",
											compPath = "luacomponents.common.MEIconLabel",
											dstBlendFunc = "771",
											FontColor = "#FF9E5D40",
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
											name = "Label_cur",
											nTextAlign = "1",
											nTextHAlign = "1",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "770",
											text = "当前精灵",
											touchAble = "False",
											touchScaleEnable = "False",
											UILayoutViewModel = 
											{
												PositionY = -1,
											},
											width = "85",
											ZOrder = "1",
										},
									},
								},
								{
									controlID = "Image_working_Panel_roleItem_Panel_prefab_Panel-onkeyActionTaskView_flyShipGrowUp_explore_Game",
									UUID = "fe464c70_0153_48a0_bac1_54f8b7274bf5",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "52",
									ignoreSize = "True",
									name = "Image_working",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/explore/growup/common/022.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = 57,
										PositionY = 20,
									},
									visible = "False",
									width = "120",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "Label_working_Image_working_Panel_roleItem_Panel_prefab_Panel-onkeyActionTaskView_flyShipGrowUp_explore_Game",
											UUID = "3f457fd4_ab9b_46a1_b287_9f267a27b550",
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
											fontSize = "20",
											fontStroke = 
											{
												IsStroke = false,
												StrokeColor = "#FFE6E6E6",
												StrokeSize = 1,
											},
											height = "25",
											ignoreSize = "True",
											name = "Label_working",
											nTextAlign = "1",
											nTextHAlign = "1",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "770",
											text = "派遣中",
											touchAble = "False",
											touchScaleEnable = "False",
											UILayoutViewModel = 
											{
												PositionY = -1,
											},
											width = "63",
											ZOrder = "1",
										},
									},
								},
								{
									controlID = "Image_select_Panel_roleItem_Panel_prefab_Panel-onkeyActionTaskView_flyShipGrowUp_explore_Game",
									UUID = "6a921741_68d6_4396_b6b6_4f301aa090b7",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "132",
									ignoreSize = "True",
									name = "Image_select",
									scaleX = "0.9",
									scaleY = "0.9",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/common/select.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = 57,
										PositionY = 53,
									},
									width = "132",
									ZOrder = "1",
								},
								{
									controlID = "Image_11_Panel_roleItem_Panel_prefab_Panel-onkeyActionTaskView_flyShipGrowUp_explore_Game",
									UUID = "63450b6e_5787_497e_81de_8d50efba1195",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "30",
									ignoreSize = "True",
									name = "Image_11",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/explore/growup/command/task/023.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = 79,
										PositionY = 84,
									},
									width = "52",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "Image_quality_Image_11_Panel_roleItem_Panel_prefab_Panel-onkeyActionTaskView_flyShipGrowUp_explore_Game",
											UUID = "004d0344_2ae6_404b_bcde_a4e4eed8c500",
											anchorPoint = "False",
											anchorPointX = "1",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											classname = "MEImage",
											dstBlendFunc = "771",
											height = "159",
											ignoreSize = "True",
											name = "Image_quality",
											scaleX = "0.13",
											scaleY = "0.13",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											texturePath = "ui/common/hero/quality_sss.png",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 21,
												PositionY = 2,
											},
											width = "235",
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
			"ui/explore/growup/command/task/pop.png",
			"ui/common/button_middle_n.png",
			"ui/common/image_title.png",
			"ui/common/pop_ui/pop_btn_02.png",
			"ui/explore/growup/command/task/item.png",
			"ui/common/hero/quality_d.png",
			"ui/explore/growup/command/task/dark_gou.png",
			"ui/explore/growup/common/021.png",
			"icon/hero/face/1104011.png",
			"ui/explore/growup/common/020.png",
			"ui/explore/growup/common/022.png",
			"ui/common/select.png",
			"ui/explore/growup/command/task/023.png",
			"ui/common/hero/quality_sss.png",
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

