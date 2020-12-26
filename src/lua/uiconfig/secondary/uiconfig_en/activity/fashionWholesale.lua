local t = 
{
	version = 1,
	components = 
	{
		
		{
			controlID = "Panel-fashionWholesale_Layer1_activity_Game",
			UUID = "e0e8bae1_79e9_4a6c_a8f7_d7989604a1e6",
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
					controlID = "Panel_root_Panel-fashionWholesale_Layer1_activity_Game",
					UUID = "7e4cfe59_c644_4857_a1f2_7af43bb36280",
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
					width = "1136",
					ZOrder = "1",
					components = 
					{
						
						{
							controlID = "Image_bg_0_Panel_root_Panel-fashionWholesale_Layer1_activity_Game",
							UUID = "0b2b50ec_ef8c_4628_a77e_2bee496428cf",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							backGroundScale9Enable = "False",
							classname = "MEImage",
							dstBlendFunc = "771",
							height = "547",
							ignoreSize = "True",
							name = "Image_bg_0",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							texturePath = "ui/activity/fashionWeek/005.png",
							touchAble = "False",
							UILayoutViewModel = 
							{
								
							},
							width = "895",
							ZOrder = "1",
							components = 
							{
								
								{
									controlID = "Label_fashionNum_Image_bg_0_Panel_root_Panel-fashionWholesale_Layer1_activity_Game",
									UUID = "3aced55d_5d36_4a55_b4dc_d9944fb8abb3",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									classname = "MELabel",
									compPath = "luacomponents.common.MEIconLabel",
									dstBlendFunc = "771",
									FontColor = "#FFFDB2D4",
									fontName = "font/MFLiHei_Noncommercial.ttf",
									fontShadow = 
									{
										IsShadow = false,
										ShadowColor = "#FFFFFFFF",
										ShadowAlpha = 255,
										OffsetX = 0,
										OffsetY = 0,
									},
									fontSize = "21",
									fontStroke = 
									{
										IsStroke = true,
										StrokeColor = "#FFCD2E62",
										StrokeSize = 2,
									},
									height = "30",
									ignoreSize = "True",
									name = "Label_fashionNum",
									nTextAlign = "1",
									nTextHAlign = "1",
									rotation = "-5",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "3",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionX = -6,
										PositionY = 223,
									},
									width = "21",
									ZOrder = "1",
								},
								{
									controlID = "Label_discount_Image_bg_0_Panel_root_Panel-fashionWholesale_Layer1_activity_Game",
									UUID = "7d512fd3_c624_404a_9dfd_3a13e17c8ac0",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									classname = "MELabel",
									compPath = "luacomponents.common.MEIconLabel",
									dstBlendFunc = "771",
									FontColor = "#FFFDB2D4",
									fontName = "font/MFLiHei_Noncommercial.ttf",
									fontShadow = 
									{
										IsShadow = false,
										ShadowColor = "#FFFFFFFF",
										ShadowAlpha = 255,
										OffsetX = 0,
										OffsetY = 0,
									},
									fontSize = "31",
									fontStroke = 
									{
										IsStroke = true,
										StrokeColor = "#FFCD2E62",
										StrokeSize = 2,
									},
									height = "42",
									ignoreSize = "True",
									name = "Label_discount",
									nTextAlign = "1",
									nTextHAlign = "1",
									rotation = "-5",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "10% Off",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionX = 121,
										PositionY = 240,
									},
									width = "62",
									ZOrder = "1",
								},
							},
						},
						{
							controlID = "Image_bg_1_Panel_root_Panel-fashionWholesale_Layer1_activity_Game",
							UUID = "cda2dbb2_5d18_470d_b746_8c7d1222c36a",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							backGroundScale9Enable = "False",
							classname = "MEImage",
							dstBlendFunc = "771",
							height = "547",
							ignoreSize = "True",
							name = "Image_bg_1",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							texturePath = "ui/activity/fashionWeek/005_1.png",
							touchAble = "False",
							UILayoutViewModel = 
							{
								
							},
							width = "895",
							ZOrder = "1",
						},
						{
							controlID = "act_time_Panel_root_Panel-fashionWholesale_Layer1_activity_Game",
							UUID = "e0c84053_2a87_4f9d_8c51_b9ad2ccebc0c",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							classname = "MELabel",
							compPath = "luacomponents.common.MEIconLabel",
							dstBlendFunc = "771",
							FontColor = "#FFF6CBDA",
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
							name = "act_time",
							nTextAlign = "1",
							nTextHAlign = "1",
							rotation = "-8.34",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "770",
							text = "Event Time",
							touchAble = "False",
							touchScaleEnable = "False",
							UILayoutViewModel = 
							{
								PositionX = -356,
								PositionY = 249,
							},
							width = "90",
							ZOrder = "1",
							components = 
							{
								
								{
									controlID = "act_timeStart_act_time_Panel_root_Panel-fashionWholesale_Layer1_activity_Game",
									UUID = "5921dfc8_1aed_467e_bf23_bc088eff939d",
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
									fontSize = "18",
									fontStroke = 
									{
										IsStroke = false,
										StrokeColor = "#FFE6E6E6",
										StrokeSize = 1,
									},
									height = "22",
									ignoreSize = "True",
									name = "act_timeStart",
									nTextAlign = "1",
									nTextHAlign = "1",
									rotation = "-2",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "20200416",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionX = -66,
										PositionY = -24,
									},
									width = "118",
									ZOrder = "1",
								},
								{
									controlID = "act_timeEnd_act_time_Panel_root_Panel-fashionWholesale_Layer1_activity_Game",
									UUID = "5395a196_fe62_4d3e_80f9_6d6006fec655",
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
									fontSize = "18",
									fontStroke = 
									{
										IsStroke = false,
										StrokeColor = "#FFE6E6E6",
										StrokeSize = 1,
									},
									height = "22",
									ignoreSize = "True",
									name = "act_timeEnd",
									nTextAlign = "1",
									nTextHAlign = "1",
									rotation = "-2",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "20200416",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionX = -81,
										PositionY = -45,
									},
									width = "118",
									ZOrder = "1",
								},
							},
						},
						{
							controlID = "FashionArray_Panel_root_Panel-fashionWholesale_Layer1_activity_Game",
							UUID = "d1743fe1_58ed_4e3d_9be3_4e84ed8a0760",
							anchorPoint = "False",
							anchorPointX = "0",
							anchorPointY = "0",
							backGroundScale9Enable = "False",
							bgColorOpacity = "50",
							bIsOpenClipping = "True",
							bounceEnable = "False",
							classname = "MEScrollView",
							colorType = "0;SingleColor:#FF20B2AA;GraduallyChangingColorStart:#FFFFFFFF;GraduallyChangingColorEnd:#FFFFFFFF;vectorX:0;vectorY:0",
							direction = "2",
							dstBlendFunc = "771",
							height = "450",
							ignoreSize = "False",
							innerHeight = "450",
							innerWidth = "590",
							name = "FashionArray",
							showScrollbar = "False",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							touchAble = "True",
							UILayoutViewModel = 
							{
								PositionX = -205,
								PositionY = -259,
							},
							uipanelviewmodel = 
							{
								Layout="Absolute",
								nType = "0"
							},
							width = "590",
							ZOrder = "1",
						},
						{
							controlID = "Panel_prefab_Panel_root_Panel-fashionWholesale_Layer1_activity_Game",
							UUID = "63af9969_a173_405c_9240_ce328b8edf29",
							anchorPoint = "False",
							anchorPointX = "0",
							anchorPointY = "0",
							backGroundScale9Enable = "False",
							bgColorOpacity = "0",
							bIsOpenClipping = "True",
							classname = "MEPanel",
							colorType = "1;SingleColor:#FF0000FF;GraduallyChangingColorStart:#FFFFFFFF;GraduallyChangingColorEnd:#FFFFFFFF;vectorX:0;vectorY:0",
							DesignHeight = "640",
							DesignType = "0",
							DesignWidth = "960",
							dstBlendFunc = "771",
							height = "450",
							ignoreSize = "False",
							name = "Panel_prefab",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							touchAble = "False",
							UILayoutViewModel = 
							{
								PositionX = -317,
								PositionY = -1256,
							},
							uipanelviewmodel = 
							{
								Layout="Absolute",
								nType = "0"
							},
							width = "185",
							ZOrder = "1",
							components = 
							{
								
								{
									controlID = "FashionIconBg_Panel_prefab_Panel_root_Panel-fashionWholesale_Layer1_activity_Game",
									UUID = "07f8ea00_be20_4ba9_9e92_ccef1ea750ad",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "448",
									ignoreSize = "True",
									name = "FashionIconBg",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/activity/fashionWeek/004.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = 91,
										PositionY = 225,
										relativeToName = "Panel_prefab",
										nGravity = 6,
										nAlign = 5
									},
									width = "189",
									ZOrder = "1",
								},
								{
									controlID = "FashionIcon_Panel_prefab_Panel_root_Panel-fashionWholesale_Layer1_activity_Game",
									UUID = "3c720dbf_bdf7_4e91_8de0_631fd22cca3f",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "64",
									ignoreSize = "True",
									name = "FashionIcon",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = 90,
										PositionY = 283,
										relativeToName = "Panel_prefab",
										nGravity = 6,
										nAlign = 5
									},
									width = "64",
									ZOrder = "1",
								},
								{
									controlID = "nameBg_Panel_prefab_Panel_root_Panel-fashionWholesale_Layer1_activity_Game",
									UUID = "afbbfe02_7858_419d_923b_7d7bb2d7f772",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "91",
									ignoreSize = "True",
									name = "nameBg",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/activity/fashionWeek/002.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = 81,
										PositionY = 132,
										LeftPositon = 13,
										TopPosition = 252,
										relativeToName = "Panel_prefab",
									},
									width = "167",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "LabelName_nameBg_Panel_prefab_Panel_root_Panel-fashionWholesale_Layer1_activity_Game",
											UUID = "919700c0_8a72_4959_ad85_06883a49ab51",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											classname = "MELabel",
											compPath = "luacomponents.common.MEIconLabel",
											dstBlendFunc = "771",
											FontColor = "#FF3B5F8B",
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
											name = "LabelName",
											nTextAlign = "1",
											nTextHAlign = "1",
											rotation = "-15",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "770",
											text = "Crimson Nightmare",
											touchAble = "False",
											touchScaleEnable = "False",
											UILayoutViewModel = 
											{
												PositionX = -9,
												PositionY = 16,
												LeftPositon = 61,
												TopPosition = 20,
												relativeToName = "Panel_prefab",
											},
											width = "83",
											ZOrder = "1",
										},
									},
								},
								{
									controlID = "Detail_Panel_prefab_Panel_root_Panel-fashionWholesale_Layer1_activity_Game",
									UUID = "75d2cf1a_dbd5_4ee5_b9a0_368d40903d9e",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "55",
									ignoreSize = "True",
									name = "Detail",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/activity/fashionWeek/001.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = 146,
										PositionY = 122,
										LeftPositon = 115,
										TopPosition = 291,
										relativeToName = "Panel_prefab",
									},
									width = "69",
									ZOrder = "1",
								},
								{
									controlID = "ButtonPurchase_Panel_prefab_Panel_root_Panel-fashionWholesale_Layer1_activity_Game",
									UUID = "69a64a70_fd85_4420_8923_90663500e6c0",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEButton",
									ClickHighLightEnabled = "True",
									dstBlendFunc = "771",
									flipX = "False",
									flipY = "False",
									height = "108",
									ignoreSize = "True",
									name = "ButtonPurchase",
									normal = "ui/activity/fashionWeek/003.png",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "True",
									UILayoutViewModel = 
									{
										PositionX = 91,
										PositionY = 48,
										LeftPositon = 5,
										TopPosition = 344,
										relativeToName = "Panel_prefab",
									},
									UItype = "Button",
									width = "180",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "CostIcon_ButtonPurchase_Panel_prefab_Panel_root_Panel-fashionWholesale_Layer1_activity_Game",
											UUID = "c2114e0f_27e7_42b0_99b1_e5c4dab32991",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											classname = "MEImage",
											dstBlendFunc = "771",
											height = "100",
											ignoreSize = "True",
											name = "CostIcon",
											scaleX = "0.5",
											scaleY = "0.5",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											texturePath = "icon/system/003.png",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = -58,
												PositionY = -20,
											},
											width = "100",
											ZOrder = "1",
										},
										{
											controlID = "originPrice_ButtonPurchase_Panel_prefab_Panel_root_Panel-fashionWholesale_Layer1_activity_Game",
											UUID = "5f8fa03d_f4d0_469f_82ce_927fcbd0c2b9",
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
											name = "originPrice",
											nTextAlign = "1",
											nTextHAlign = "1",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "770",
											text = "588",
											touchAble = "False",
											touchScaleEnable = "False",
											UILayoutViewModel = 
											{
												PositionX = 48,
												PositionY = 12,
											},
											width = "53",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "deleteLine_originPrice_ButtonPurchase_Panel_prefab_Panel_root_Panel-fashionWholesale_Layer1_activity_Game",
													UUID = "65b4dc7b_dd4c_42a6_bd2d_b619f1410909",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0.5",
													backGroundScale9Enable = "False",
													classname = "MEImage",
													dstBlendFunc = "771",
													height = "2",
													ignoreSize = "True",
													name = "deleteLine",
													rotation = "-13",
													scaleX = "0.5",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "770",
													texturePath = "ui/recharge/tokenPopView/line.png",
													touchAble = "False",
													UILayoutViewModel = 
													{
														
													},
													width = "160",
													ZOrder = "1",
												},
											},
										},
										{
											controlID = "discountPrice_ButtonPurchase_Panel_prefab_Panel_root_Panel-fashionWholesale_Layer1_activity_Game",
											UUID = "904f90ac_3f34_4180_9471_e23923541045",
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
											name = "discountPrice",
											nTextAlign = "1",
											nTextHAlign = "1",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "770",
											text = "1000",
											touchAble = "False",
											touchScaleEnable = "False",
											UILayoutViewModel = 
											{
												PositionX = 20,
												PositionY = -24,
											},
											width = "80",
											ZOrder = "1",
										},
									},
								},
								{
									controlID = "ButtonOwn_Panel_prefab_Panel_root_Panel-fashionWholesale_Layer1_activity_Game",
									UUID = "8919226c_2870_41db_ae12_b79b877ebd27",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEButton",
									ClickHighLightEnabled = "True",
									dstBlendFunc = "771",
									flipX = "False",
									flipY = "False",
									height = "108",
									ignoreSize = "True",
									name = "ButtonOwn",
									normal = "ui/activity/fashionWeek/003_1.png",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "True",
									UILayoutViewModel = 
									{
										PositionX = 91,
										PositionY = 48,
										LeftPositon = 5,
										TopPosition = 344,
										relativeToName = "Panel_prefab",
									},
									UItype = "Button",
									width = "180",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "labelOwn_ButtonOwn_Panel_prefab_Panel_root_Panel-fashionWholesale_Layer1_activity_Game",
											UUID = "dd555bc1_42c1_4d5c_9a0e_99baf72f7eee",
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
											name = "labelOwn",
											nTextAlign = "1",
											nTextHAlign = "1",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "770",
											text = "Owned",
											touchAble = "False",
											touchScaleEnable = "False",
											UILayoutViewModel = 
											{
												PositionY = -17,
											},
											width = "76",
											ZOrder = "1",
										},
									},
								},
							},
						},
						{
							controlID = "Button_rule_Panel_root_Panel-fashionWholesale_Layer1_activity_Game",
							UUID = "fc660558_19e2_41f5_a6cd_13e359966112",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							backGroundScale9Enable = "False",
							classname = "MEButton",
							ClickHighLightEnabled = "True",
							dstBlendFunc = "771",
							flipX = "False",
							flipY = "False",
							height = "42",
							ignoreSize = "True",
							name = "Button_rule",
							normal = "ui/summon/002.png",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							touchAble = "True",
							UILayoutViewModel = 
							{
								PositionX = 406,
								PositionY = 242,
							},
							UItype = "Button",
							width = "46",
							ZOrder = "1",
						},
						{
							controlID = "Image_more_Panel_root_Panel-fashionWholesale_Layer1_activity_Game",
							UUID = "0491fd6f_f9c1_409c_abe1_73fba0f566f0",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							backGroundScale9Enable = "False",
							classname = "MEImage",
							dstBlendFunc = "771",
							height = "62",
							ignoreSize = "True",
							name = "Image_more",
							scaleX = "-1",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							texturePath = "ui/agora/level/btn_choose.png",
							touchAble = "False",
							UILayoutViewModel = 
							{
								PositionX = 409,
								PositionY = -6,
							},
							width = "48",
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
			"ui/activity/fashionWeek/005.png",
			"ui/activity/fashionWeek/005_1.png",
			"ui/activity/fashionWeek/004.png",
			"ui/activity/fashionWeek/002.png",
			"ui/activity/fashionWeek/001.png",
			"ui/activity/fashionWeek/003.png",
			"icon/system/003.png",
			"ui/recharge/tokenPopView/line.png",
			"ui/activity/fashionWeek/003_1.png",
			"ui/summon/002.png",
			"ui/agora/level/btn_choose.png",
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

