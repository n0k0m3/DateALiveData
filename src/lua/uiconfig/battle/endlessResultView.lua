local t = 
{
	version = 1,
	components = 
	{
		
		{
			controlID = "Panel-endlessResultView_ui_battle_Game",
			UUID = "4da9a8cb_58a8_41b8_9362_81d2f1d3c8cd",
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
					controlID = "Panel_root_Panel-endlessResultView_ui_battle_Game",
					UUID = "8ba1478f_d4b3_4258_895a_e68daed017ce",
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
					height = "640",
					ignoreSize = "False",
					name = "Panel_root",
					sizepercentx = "100",
					sizepercenty = "100",
					sizeType = "0",
					srcBlendFunc = "1",
					touchAble = "True",
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
					width = "1136",
					ZOrder = "1",
					components = 
					{
						
						{
							controlID = "Image_bg_Panel_root_Panel-endlessResultView_ui_battle_Game",
							UUID = "628d8f60_77ff_437e_883c_b785d6158adf",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							backGroundScale9Enable = "False",
							classname = "MEImage",
							dstBlendFunc = "771",
							height = "106",
							ignoreSize = "True",
							name = "Image_bg",
							scaleX = "6",
							scaleY = "6",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							texturePath = "scene/bg/bg_fuben_caochang.png",
							touchAble = "False",
							UILayoutViewModel = 
							{
								relativeToName = "Panel",
								nGravity = 6,
								nAlign = 5
							},
							width = "230",
							ZOrder = "1",
						},
						{
							controlID = "Image_endlessResultView_1_Panel_root_Panel-endlessResultView_ui_battle_Game",
							UUID = "46fe686e_80b7_4ef4_aa3e_05715604d1b0",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							backGroundScale9Enable = "False",
							classname = "MEImage",
							dstBlendFunc = "771",
							height = "640",
							ignoreSize = "True",
							name = "Image_endlessResultView_1",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							texturePath = "wzui/y001.png",
							touchAble = "False",
							UILayoutViewModel = 
							{
								PositionX = 125,
								relativeToName = "Panel_root",
								nGravity = 1,
							},
							width = "1386",
							ZOrder = "1",
						},
						{
							controlID = "ScrollView_hero_Panel_root_Panel-endlessResultView_ui_battle_Game",
							UUID = "12358985_479f_490b_8c5a_de19af2ed6ae",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							backGroundScale9Enable = "False",
							bgColorOpacity = "50",
							bIsOpenClipping = "False",
							bounceEnable = "False",
							classname = "MEScrollView",
							colorType = "0;SingleColor:#FFE6E6E6;GraduallyChangingColorStart:#FFFFFFFF;GraduallyChangingColorEnd:#FFFFFFFF;vectorX:0;vectorY:0",
							direction = "2",
							dstBlendFunc = "771",
							height = "640",
							ignoreSize = "False",
							innerHeight = "640",
							innerWidth = "100",
							name = "ScrollView_hero",
							showScrollbar = "False",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							touchAble = "False",
							UILayoutViewModel = 
							{
								PositionX = -137,
								LeftPositon = 381,
								relativeToName = "Panel_root",
								nGravity = 5,
								nAlign = 4
							},
							uipanelviewmodel = 
							{
								Layout="Absolute",
								nType = "0"
							},
							width = "100",
							ZOrder = "1",
						},
						{
							controlID = "Image_title_Panel_root_Panel-endlessResultView_ui_battle_Game",
							UUID = "372e6ca3_f220_4563_b5c2_04bd802437c7",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							backGroundScale9Enable = "False",
							classname = "MEImage",
							dstBlendFunc = "771",
							height = "216",
							ignoreSize = "True",
							name = "Image_title",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							texturePath = "ui/634.png",
							touchAble = "False",
							UILayoutViewModel = 
							{
								PositionX = -477,
								PositionY = 212,
								LeftPositon = -47,
								relativeToName = "Panel_root",
							},
							width = "276",
							ZOrder = "1",
							components = 
							{
								
								{
									controlID = "Label_title_Image_title_Panel_root_Panel-endlessResultView_ui_battle_Game",
									UUID = "1ed69e10_c984_4627_91cf_d4791f5377a1",
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
									fontSize = "40",
									fontStroke = 
									{
										IsStroke = false,
										StrokeColor = "#FFE6E6E6",
										StrokeSize = 1,
									},
									height = "57",
									ignoreSize = "True",
									name = "Label_title",
									nTextAlign = "1",
									nTextHAlign = "1",
									rotation = "-45",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "作战成功",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionX = -21,
										PositionY = 24,
									},
									width = "162",
									ZOrder = "1",
								},
							},
						},
						{
							controlID = "Panel_dropReward_Panel_root_Panel-endlessResultView_ui_battle_Game",
							UUID = "27e76278_89d1_4473_b715_0d23966164de",
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
							height = "640",
							ignoreSize = "False",
							name = "Panel_dropReward",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							touchAble = "False",
							UILayoutViewModel = 
							{
								PositionX = 398,
								RightPosition = 5,
								relativeToName = "Panel_root",
								nGravity = 3,
								nAlign = 9
							},
							uipanelviewmodel = 
							{
								Layout="Absolute",
								nType = "0"
							},
							visible = "False",
							width = "330",
							ZOrder = "1",
							components = 
							{
								
								{
									controlID = "Image_battleResultView_1_Panel_dropReward_Panel_root_Panel-endlessResultView_ui_battle_Game",
									UUID = "58f89f9a_f74a_4642_b0ba_5ac401bf4fca",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "34",
									ignoreSize = "True",
									name = "Image_battleResultView_1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/625.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = 106,
										PositionY = -28,
									},
									width = "258",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "Label_battleResultView_1_Image_battleResultView_1_Panel_dropReward_Panel_root_Panel-endlessResultView_ui_battle_Game",
											UUID = "fdea4909_3f9f_445e_b1ff_3c4472274bc5",
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
											height = "29",
											ignoreSize = "True",
											name = "Label_battleResultView_1",
											nTextAlign = "1",
											nTextHAlign = "1",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "770",
											text = "战利品",
											touchAble = "False",
											touchScaleEnable = "False",
											UILayoutViewModel = 
											{
												PositionX = -42,
											},
											width = "63",
											ZOrder = "1",
										},
									},
								},
								{
									controlID = "ScrollView_reward_Panel_dropReward_Panel_root_Panel-endlessResultView_ui_battle_Game",
									UUID = "65e220c5_a32a_4ebc_b78f_60489d972243",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									bgColorOpacity = "50",
									bIsOpenClipping = "True",
									bounceEnable = "False",
									classname = "MEScrollView",
									colorType = "0;SingleColor:#FFFF4500;GraduallyChangingColorStart:#FFFFFFFF;GraduallyChangingColorEnd:#FFFFFFFF;vectorX:0;vectorY:0",
									direction = "1",
									dstBlendFunc = "771",
									height = "176",
									ignoreSize = "False",
									innerHeight = "176",
									innerWidth = "310",
									name = "ScrollView_reward",
									showScrollbar = "False",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "True",
									UILayoutViewModel = 
									{
										PositionX = 5,
										PositionY = -148,
									},
									uipanelviewmodel = 
									{
										Layout="Absolute",
										nType = "0"
									},
									width = "310",
									ZOrder = "1",
								},
							},
						},
						{
							controlID = "Panel_battleInfo_Panel_root_Panel-endlessResultView_ui_battle_Game",
							UUID = "421b5b68_0a57_4662_b673_49725276d174",
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
							height = "640",
							ignoreSize = "False",
							name = "Panel_battleInfo",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							touchAble = "False",
							UILayoutViewModel = 
							{
								PositionX = 367,
								LeftPositon = 735,
								relativeToName = "Panel_root",
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
									controlID = "Image_costTime_Panel_battleInfo_Panel_root_Panel-endlessResultView_ui_battle_Game",
									UUID = "4ef7e0f5_bdad_4550_acc2_bf3e7d93411d",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "32",
									ignoreSize = "True",
									name = "Image_costTime",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/xj093.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = 124,
										PositionY = 68,
									},
									width = "238",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "Label_costTimeTitle_Image_costTime_Panel_battleInfo_Panel_root_Panel-endlessResultView_ui_battle_Game",
											UUID = "24c8985f_5b55_4503_b563_ecdcc95ec208",
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
											height = "29",
											ignoreSize = "True",
											name = "Label_costTimeTitle",
											nTextAlign = "1",
											nTextHAlign = "1",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "770",
											text = "作战耗时",
											touchAble = "False",
											touchScaleEnable = "False",
											UILayoutViewModel = 
											{
												PositionX = -40,
											},
											width = "83",
											ZOrder = "1",
										},
										{
											controlID = "Label_costTime_Image_costTime_Panel_battleInfo_Panel_root_Panel-endlessResultView_ui_battle_Game",
											UUID = "4296bd7c_d7e4_4a31_a62e_ea5869672d3d",
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
											fontSize = "55",
											fontStroke = 
											{
												IsStroke = true,
												StrokeColor = "#FFF0376C",
												StrokeSize = 1,
											},
											height = "81",
											ignoreSize = "True",
											name = "Label_costTime",
											nTextAlign = "1",
											nTextHAlign = "1",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "770",
											text = "12:45",
											touchAble = "False",
											touchScaleEnable = "False",
											UILayoutViewModel = 
											{
												PositionX = -33,
												PositionY = -64,
											},
											width = "154",
											ZOrder = "1",
										},
									},
								},
								{
									controlID = "Image_highestLevel_Panel_battleInfo_Panel_root_Panel-endlessResultView_ui_battle_Game",
									UUID = "fea97784_0c90_4b73_afb0_82200d90661c",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "32",
									ignoreSize = "True",
									name = "Image_highestLevel",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/xj093.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = 124,
										PositionY = -71,
									},
									width = "238",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "Label_highestLevelTitle_Image_highestLevel_Panel_battleInfo_Panel_root_Panel-endlessResultView_ui_battle_Game",
											UUID = "112fc398_9cf3_4de7_835b_0372f2f67fef",
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
											height = "29",
											ignoreSize = "True",
											name = "Label_highestLevelTitle",
											nTextAlign = "1",
											nTextHAlign = "1",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "770",
											text = "最高层数",
											touchAble = "False",
											touchScaleEnable = "False",
											UILayoutViewModel = 
											{
												PositionX = -40,
											},
											width = "83",
											ZOrder = "1",
										},
										{
											controlID = "Label_highestLevel_Image_highestLevel_Panel_battleInfo_Panel_root_Panel-endlessResultView_ui_battle_Game",
											UUID = "31fb3eed_6247_418b_bb29_4fce697573e6",
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
											fontSize = "55",
											fontStroke = 
											{
												IsStroke = true,
												StrokeColor = "#FFF0376C",
												StrokeSize = 1,
											},
											height = "81",
											ignoreSize = "True",
											name = "Label_highestLevel",
											nTextAlign = "1",
											nTextHAlign = "1",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "770",
											text = "32层",
											touchAble = "False",
											touchScaleEnable = "False",
											UILayoutViewModel = 
											{
												PositionX = -33,
												PositionY = -77,
											},
											width = "127",
											ZOrder = "1",
										},
									},
								},
							},
						},
					},
				},
				{
					controlID = "Panel_prefab_Panel-endlessResultView_ui_battle_Game",
					UUID = "7c8e8de8_0077_405b_9b55_abac8f139371",
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
					height = "640",
					ignoreSize = "False",
					name = "Panel_prefab",
					sizepercentx = "100",
					sizepercenty = "100",
					sizeType = "1",
					srcBlendFunc = "1",
					touchAble = "False",
					UILayoutViewModel = 
					{
						PositionX = 6,
						PositionY = -732,
						LeftPositon = 6,
						TopPosition = 732,
						relativeToName = "Panel",
						nType = 3,
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
							controlID = "Panel_heroItem_Panel_prefab_Panel-endlessResultView_ui_battle_Game",
							UUID = "122c14b2_f7c2_4161_898d_b322f3ced560",
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
							height = "640",
							ignoreSize = "False",
							name = "Panel_heroItem",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							touchAble = "False",
							UILayoutViewModel = 
							{
								PositionX = 751,
								PositionY = 320,
								LeftPositon = 196,
								relativeToName = "Panel_root",
								nGravity = 5,
								nAlign = 4
							},
							uipanelviewmodel = 
							{
								Layout="Absolute",
								nType = "0"
							},
							width = "232",
							ZOrder = "1",
							components = 
							{
								
								{
									controlID = "Image_diban_Panel_heroItem_Panel_prefab_Panel-endlessResultView_ui_battle_Game",
									UUID = "06b82e5f_73c7_4218_87a2_419125a31484",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "640",
									ignoreSize = "True",
									name = "Image_diban",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/628.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										
									},
									width = "232",
									ZOrder = "1",
								},
								{
									controlID = "Panel_mask_Panel_heroItem_Panel_prefab_Panel-endlessResultView_ui_battle_Game",
									UUID = "38db52e5_ec92_4478_bb0b_e670887c775b",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									bgColorOpacity = "50",
									bIsOpenClipping = "True",
									classname = "MEPanel",
									colorType = "0;SingleColor:#FFE6E6E6;GraduallyChangingColorStart:#FFFFFFFF;GraduallyChangingColorEnd:#FFFFFFFF;vectorX:0;vectorY:0",
									DesignHeight = "640",
									DesignType = "0",
									DesignWidth = "960",
									dstBlendFunc = "771",
									height = "640",
									ignoreSize = "False",
									name = "Panel_mask",
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
									width = "217",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "Panel_heroShadowModel_Panel_mask_Panel_heroItem_Panel_prefab_Panel-endlessResultView_ui_battle_Game",
											UUID = "ea7ad0e1_1443_40aa_90fe_eed882b6554f",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0",
											backGroundScale9Enable = "False",
											bgColorOpacity = "255",
											bIsOpenClipping = "False",
											classname = "MEPanel",
											colorType = "0;SingleColor:#FFFF4500;GraduallyChangingColorStart:#FFFFFFFF;GraduallyChangingColorEnd:#FFFFFFFF;vectorX:0;vectorY:0",
											DesignHeight = "640",
											DesignType = "0",
											DesignWidth = "960",
											dstBlendFunc = "771",
											height = "100",
											ignoreSize = "False",
											name = "Panel_heroShadowModel",
											opacity = "125",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = -133,
												PositionY = 1,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "100",
											ZOrder = "1",
										},
										{
											controlID = "Panel_heroModel_Panel_mask_Panel_heroItem_Panel_prefab_Panel-endlessResultView_ui_battle_Game",
											UUID = "8edcbcb5_b946_4813_a6c9_710d3f835d0e",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0",
											backGroundScale9Enable = "False",
											bgColorOpacity = "255",
											bIsOpenClipping = "False",
											classname = "MEPanel",
											colorType = "0;SingleColor:#FFFF4500;GraduallyChangingColorStart:#FFFFFFFF;GraduallyChangingColorEnd:#FFFFFFFF;vectorX:0;vectorY:0",
											DesignHeight = "640",
											DesignType = "0",
											DesignWidth = "960",
											dstBlendFunc = "771",
											height = "100",
											ignoreSize = "False",
											name = "Panel_heroModel",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = -111,
												PositionY = -3,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "100",
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
			"scene/bg/bg_fuben_caochang.png",
			"wzui/y001.png",
			"ui/634.png",
			"ui/625.png",
			"ui/xj093.png",
			"ui/628.png",
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

