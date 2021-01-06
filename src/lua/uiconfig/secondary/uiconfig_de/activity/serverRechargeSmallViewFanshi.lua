local t = 
{
	version = 1,
	components = 
	{
		
		{
			controlID = "Panel-serverRechargeSmallViewFanshi_fanshiAssist_activity_Game",
			UUID = "e61aafa1_6cf4_45b2_b6ae_76e570ffca80",
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
			name = "Panel",
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
			width = "924",
			ZOrder = "1",
			components = 
			{
				
				{
					controlID = "Panel_base_Panel-serverRechargeSmallViewFanshi_fanshiAssist_activity_Game",
					UUID = "ea87333a_0dd3_484f_867d_14d5d3c531a1",
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
							controlID = "bg_Panel_base_Panel-serverRechargeSmallViewFanshi_fanshiAssist_activity_Game",
							UUID = "688640ee_b17e_45b8_9ad0_4b9c5f6d8764",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							backGroundScale9Enable = "False",
							classname = "MEImage",
							dstBlendFunc = "771",
							height = "534",
							ignoreSize = "True",
							name = "bg",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							texturePath = "ui/activity/fanshiAssist/severRechargeSmall/bg.png",
							touchAble = "False",
							UILayoutViewModel = 
							{
								
							},
							width = "924",
							ZOrder = "1",
						},
						{
							controlID = "Image_title_Panel_base_Panel-serverRechargeSmallViewFanshi_fanshiAssist_activity_Game",
							UUID = "ed733dd1_7262_4398_8b20_d275c8470e90",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							backGroundScale9Enable = "False",
							classname = "MEImage",
							dstBlendFunc = "771",
							height = "190",
							ignoreSize = "True",
							name = "Image_title",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							texturePath = "ui/activity/allServer_recharge/main/006.png",
							touchAble = "False",
							UILayoutViewModel = 
							{
								PositionX = -261,
								PositionY = 95,
							},
							visible = "False",
							width = "600",
							ZOrder = "1",
						},
						{
							controlID = "label_time_Panel_base_Panel-serverRechargeSmallViewFanshi_fanshiAssist_activity_Game",
							UUID = "a806aa9a_29be_40c1_a1d9_ad4833776721",
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
							fontSize = "20",
							fontStroke = 
							{
								IsStroke = true,
								StrokeColor = "#FF3A1316",
								StrokeSize = 1,
							},
							height = "25",
							ignoreSize = "True",
							name = "label_time",
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
								PositionY = 162,
							},
							width = "107",
							ZOrder = "1",
						},
						{
							controlID = "label_des_Panel_base_Panel-serverRechargeSmallViewFanshi_fanshiAssist_activity_Game",
							UUID = "c76afb56_0bf9_4d6f_aec7_e15029fecbac",
							anchorPoint = "False",
							anchorPointX = "0",
							anchorPointY = "0.5",
							classname = "MELabel",
							compPath = "luacomponents.common.MEIconLabel",
							dstBlendFunc = "771",
							FontColor = "#FFFFCA58",
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
								IsStroke = true,
								StrokeColor = "#FF000000",
								StrokeSize = 1,
							},
							height = "27",
							ignoreSize = "True",
							name = "label_des",
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
								PositionX = -287,
								PositionY = 243,
							},
							width = "90",
							ZOrder = "1",
						},
						{
							controlID = "panel_ItemParent_Panel_base_Panel-serverRechargeSmallViewFanshi_fanshiAssist_activity_Game",
							UUID = "0d4f4c04_e6d1_4338_8c84_c365ffb14505",
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
							name = "panel_ItemParent",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							touchAble = "False",
							UILayoutViewModel = 
							{
								PositionX = -459,
								PositionY = -263,
								TopPosition = 240,
								relativeToName = "Panel",
							},
							uipanelviewmodel = 
							{
								Layout="Absolute",
								nType = "0"
							},
							width = "400",
							ZOrder = "1",
						},
						{
							controlID = "label_tip1_Panel_base_Panel-serverRechargeSmallViewFanshi_fanshiAssist_activity_Game",
							UUID = "359bbe4c_229e_4716_a00d_0e95f9c01b80",
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
							fontSize = "26",
							fontStroke = 
							{
								IsStroke = false,
								StrokeColor = "#FFE6E6E6",
								StrokeSize = 1,
							},
							height = "0",
							ignoreSize = "False",
							name = "label_tip1",
							nTextAlign = "1",
							nTextHAlign = "1",
							rotation = "-16",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "770",
							text = "Aktuell gekauft",
							touchAble = "False",
							touchScaleEnable = "False",
							UILayoutViewModel = 
							{
								PositionX = -453,
								PositionY = -19,
							},
							width = "159",
							ZOrder = "1",
						},
						{
							controlID = "label_number_Panel_base_Panel-serverRechargeSmallViewFanshi_fanshiAssist_activity_Game",
							UUID = "d4d52b62_7276_407e_bc2d_d6b6ad64c3d0",
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
							fontSize = "36",
							fontStroke = 
							{
								IsStroke = true,
								StrokeColor = "#FF453505",
								StrokeSize = 1,
							},
							height = "43",
							ignoreSize = "True",
							name = "label_number",
							nTextAlign = "1",
							nTextHAlign = "1",
							rotation = "-11",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "770",
							text = "3000",
							touchAble = "False",
							touchScaleEnable = "False",
							UILayoutViewModel = 
							{
								PositionX = -378,
								PositionY = -50,
							},
							width = "82",
							ZOrder = "1",
						},
						{
							controlID = "Image1_Panel_base_Panel-serverRechargeSmallViewFanshi_fanshiAssist_activity_Game",
							UUID = "9e247f5e_30d4_4374_90ad_b9cf5d283335",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							backGroundScale9Enable = "False",
							classname = "MEImage",
							dstBlendFunc = "771",
							height = "172",
							ignoreSize = "True",
							name = "Image1",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							texturePath = "ui/activity/allServer_recharge/v2/001.png",
							touchAble = "False",
							UILayoutViewModel = 
							{
								PositionX = 377,
								PositionY = -239,
							},
							visible = "False",
							width = "240",
							ZOrder = "1",
						},
						{
							controlID = "Button_goShop_Panel_base_Panel-serverRechargeSmallViewFanshi_fanshiAssist_activity_Game",
							UUID = "62ac4233_c5d1_4e29_a375_1d6664b871b7",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							backGroundScale9Enable = "False",
							classname = "MEButton",
							ClickHighLightEnabled = "True",
							dstBlendFunc = "771",
							flipX = "False",
							flipY = "False",
							height = "194",
							ignoreSize = "True",
							name = "Button_goShop",
							normal = "ui/activity/fanshiAssist/severRechargeSmall/01.png",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							touchAble = "True",
							UILayoutViewModel = 
							{
								PositionX = 343,
								PositionY = -150,
							},
							UItype = "Button",
							width = "194",
							ZOrder = "1",
						},
					},
				},
				{
					controlID = "Panel_prefab_Panel-serverRechargeSmallViewFanshi_fanshiAssist_activity_Game",
					UUID = "e1d239da_5ce8_42fb_be67_bf82a682022d",
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
					name = "Panel_prefab",
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
						PositionX = 228,
						PositionY = -1137,
						BottomPosition = -740,
						relativeToName = "Panel",
						nGravity = 4,
						nAlign = 7
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
							controlID = "Panel_Item_Panel_prefab_Panel-serverRechargeSmallViewFanshi_fanshiAssist_activity_Game",
							UUID = "87fe5d85_35d1_4a4f_8f7a_09fcc7c595a3",
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
							name = "Panel_Item",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							touchAble = "False",
							UILayoutViewModel = 
							{
								PositionX = 170,
								PositionY = 86,
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
									controlID = "Panel_geted_Panel_Item_Panel_prefab_Panel-serverRechargeSmallViewFanshi_fanshiAssist_activity_Game",
									UUID = "20e7e295_f257_4ae0_9992_d1a96df179ca",
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
									height = "10",
									ignoreSize = "False",
									name = "Panel_geted",
									opacity = "125",
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
									width = "10",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "Image_bg_Panel_geted_Panel_Item_Panel_prefab_Panel-serverRechargeSmallViewFanshi_fanshiAssist_activity_Game",
											UUID = "288b2eb8_ece7_4df4_8e5d_93f67a0df5b3",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											classname = "MEImage",
											dstBlendFunc = "771",
											height = "134",
											ignoreSize = "True",
											name = "Image_bg",
											scaleX = "1.6",
											scaleY = "1.6",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											texturePath = "ui/activity/fanshiAssist/severRechargeSmall/03.png",
											touchAble = "False",
											UILayoutViewModel = 
											{
												
											},
											width = "142",
											ZOrder = "1",
										},
										{
											controlID = "Image_box_Panel_geted_Panel_Item_Panel_prefab_Panel-serverRechargeSmallViewFanshi_fanshiAssist_activity_Game",
											UUID = "b066f392_1b5d_4323_afb2_7c0f1dbf23d9",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											classname = "MEImage",
											dstBlendFunc = "771",
											height = "400",
											ignoreSize = "True",
											name = "Image_box",
											scaleX = "0.45",
											scaleY = "0.45",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											texturePath = "ui/activity/fanshiAssist/severRechargeSmall/002.png",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = -2,
												PositionY = 21,
											},
											width = "400",
											ZOrder = "1",
										},
										{
											controlID = "Image_gou_Panel_geted_Panel_Item_Panel_prefab_Panel-serverRechargeSmallViewFanshi_fanshiAssist_activity_Game",
											UUID = "fd4285d6_e7a4_4a68_a9f8_9eeb41aa3e55",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											classname = "MEImage",
											dstBlendFunc = "771",
											height = "54",
											ignoreSize = "True",
											name = "Image_gou",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											texturePath = "ui/fuli/item_gou.png",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 30,
												PositionY = 78,
											},
											width = "54",
											ZOrder = "1",
										},
										{
											controlID = "Label_num_Panel_geted_Panel_Item_Panel_prefab_Panel-serverRechargeSmallViewFanshi_fanshiAssist_activity_Game",
											UUID = "3ae61aff_5cfa_42fb_99dc_2c18acefe0c9",
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
											fontSize = "35",
											fontStroke = 
											{
												IsStroke = false,
												StrokeColor = "#FFE6E6E6",
												StrokeSize = 1,
											},
											height = "40",
											ignoreSize = "True",
											name = "Label_num",
											nTextAlign = "1",
											nTextHAlign = "1",
											rotation = "-15",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "770",
											text = "100",
											touchAble = "False",
											touchScaleEnable = "False",
											UILayoutViewModel = 
											{
												PositionX = 15,
												PositionY = -74,
											},
											width = "59",
											ZOrder = "1",
										},
									},
								},
								{
									controlID = "Panel_get_Panel_Item_Panel_prefab_Panel-serverRechargeSmallViewFanshi_fanshiAssist_activity_Game",
									UUID = "8f7dc102_eb8e_47df_adc2_fa5b4effd428",
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
									height = "10",
									ignoreSize = "False",
									name = "Panel_get",
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
									visible = "False",
									width = "10",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "Image_bg_Panel_get_Panel_Item_Panel_prefab_Panel-serverRechargeSmallViewFanshi_fanshiAssist_activity_Game",
											UUID = "96d624d4_2032_4445_aa74_498abd98ade8",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											classname = "MEImage",
											dstBlendFunc = "771",
											height = "134",
											ignoreSize = "True",
											name = "Image_bg",
											scaleX = "1.6",
											scaleY = "1.6",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											texturePath = "ui/activity/fanshiAssist/severRechargeSmall/02.png",
											touchAble = "False",
											UILayoutViewModel = 
											{
												
											},
											width = "142",
											ZOrder = "1",
										},
										{
											controlID = "Image_box_Panel_get_Panel_Item_Panel_prefab_Panel-serverRechargeSmallViewFanshi_fanshiAssist_activity_Game",
											UUID = "6cb9550e_3185_435d_8fd4_66099b63ef23",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											classname = "MEImage",
											dstBlendFunc = "771",
											height = "400",
											ignoreSize = "True",
											name = "Image_box",
											scaleX = "0.45",
											scaleY = "0.45",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											texturePath = "ui/activity/fanshiAssist/severRechargeSmall/003.png",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = -1,
												PositionY = 18,
											},
											width = "400",
											ZOrder = "1",
										},
										{
											controlID = "Label_num_Panel_get_Panel_Item_Panel_prefab_Panel-serverRechargeSmallViewFanshi_fanshiAssist_activity_Game",
											UUID = "08cbd451_7278_42cf_a489_dd3105ef06f0",
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
												IsStroke = false,
												StrokeColor = "#FFE6E6E6",
												StrokeSize = 1,
											},
											height = "32",
											ignoreSize = "True",
											name = "Label_num",
											nTextAlign = "1",
											nTextHAlign = "1",
											rotation = "-15",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "770",
											text = "100",
											touchAble = "False",
											touchScaleEnable = "False",
											UILayoutViewModel = 
											{
												PositionX = 15,
												PositionY = -74,
											},
											width = "48",
											ZOrder = "1",
										},
										{
											controlID = "Spine_effect_Panel_get_Panel_Item_Panel_prefab_Panel-serverRechargeSmallViewFanshi_fanshiAssist_activity_Game",
											UUID = "52f412b2_5661_4b1e_9ec2_5b140b30351d",
											classname = "MESpine",
											dstBlendFunc = "771",
											name = "Spine_effect",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											spineModel = 
											{
												SpinePath = "effect/dailingqu_ui/dailingqu_ui",
												animationName = "play",
												IsLoop = true,
												IsPlay = true,
												IsUseQueue = false,
												AnimationQueue = 
												{
													
												},
											},
											srcBlendFunc = "1",
											touchAble = "False",
											UILayoutViewModel = 
											{
												
											},
											ZOrder = "1",
										},
									},
								},
								{
									controlID = "Panel_ing_Panel_Item_Panel_prefab_Panel-serverRechargeSmallViewFanshi_fanshiAssist_activity_Game",
									UUID = "491fbf0d_e5bf_4b11_ab2c_9a34149cbf0c",
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
									height = "10",
									ignoreSize = "False",
									name = "Panel_ing",
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
									visible = "False",
									width = "10",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "Image_bg_Panel_ing_Panel_Item_Panel_prefab_Panel-serverRechargeSmallViewFanshi_fanshiAssist_activity_Game",
											UUID = "1a6f93bc_8c36_40e7_8e55_3bbbdc0902c2",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											classname = "MEImage",
											dstBlendFunc = "771",
											height = "134",
											ignoreSize = "True",
											name = "Image_bg",
											scaleX = "1.6",
											scaleY = "1.6",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											texturePath = "ui/activity/fanshiAssist/severRechargeSmall/03.png",
											touchAble = "False",
											UILayoutViewModel = 
											{
												
											},
											width = "142",
											ZOrder = "1",
										},
										{
											controlID = "Image_box_Panel_ing_Panel_Item_Panel_prefab_Panel-serverRechargeSmallViewFanshi_fanshiAssist_activity_Game",
											UUID = "956b9f05_126b_40dd_b683_38bd04910aec",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											classname = "MEImage",
											dstBlendFunc = "771",
											height = "400",
											ignoreSize = "True",
											name = "Image_box",
											scaleX = "0.45",
											scaleY = "0.45",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											texturePath = "ui/activity/fanshiAssist/severRechargeSmall/001.png",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = -1,
												PositionY = 18,
											},
											width = "400",
											ZOrder = "1",
										},
										{
											controlID = "Label_num_Panel_ing_Panel_Item_Panel_prefab_Panel-serverRechargeSmallViewFanshi_fanshiAssist_activity_Game",
											UUID = "201809e3_10df_43f3_b54f_fd61184d4846",
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
												IsStroke = false,
												StrokeColor = "#FFE6E6E6",
												StrokeSize = 1,
											},
											height = "32",
											ignoreSize = "True",
											name = "Label_num",
											nTextAlign = "1",
											nTextHAlign = "1",
											rotation = "-15",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "770",
											text = "100",
											touchAble = "False",
											touchScaleEnable = "False",
											UILayoutViewModel = 
											{
												PositionX = 15,
												PositionY = -74,
											},
											width = "48",
											ZOrder = "1",
										},
										{
											controlID = "Image_buyFlag_Panel_ing_Panel_Item_Panel_prefab_Panel-serverRechargeSmallViewFanshi_fanshiAssist_activity_Game",
											UUID = "bbb29b8d_d958_4863_8266_f6947587ad93",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											classname = "MEImage",
											dstBlendFunc = "771",
											height = "87",
											ignoreSize = "True",
											name = "Image_buyFlag",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											texturePath = "ui/activity/fanshiAssist/severRechargeSmall/04.png",
											touchAble = "False",
											UILayoutViewModel = 
											{
												
											},
											width = "154",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "Label_serverRechargeView_1_Image_buyFlag_Panel_ing_Panel_Item_Panel_prefab_Panel-serverRechargeSmallViewFanshi_fanshiAssist_activity_Game",
													UUID = "3442992a_94d0_4ed2_a8b4_bbbf3f254ad7",
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
														StrokeColor = "#FF4D49AD",
														StrokeSize = 2,
													},
													height = "0",
													ignoreSize = "False",
													name = "Label_serverRechargeView_1",
													nTextAlign = "1",
													nTextHAlign = "1",
													rotation = "-15",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "770",
													text = "Kaufe und erhalte",
													touchAble = "False",
													touchScaleEnable = "False",
													UILayoutViewModel = 
													{
														PositionX = 1,
														PositionY = -2,
													},
													width = "186",
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
		},
	},
	actions = 
	{
		
	},
	respaths = 
	{
		textures = 
		{
			"ui/activity/fanshiAssist/severRechargeSmall/bg.png",
			"ui/activity/allServer_recharge/main/006.png",
			"ui/activity/allServer_recharge/v2/001.png",
			"ui/activity/fanshiAssist/severRechargeSmall/01.png",
			"ui/activity/fanshiAssist/severRechargeSmall/03.png",
			"ui/activity/fanshiAssist/severRechargeSmall/002.png",
			"ui/fuli/item_gou.png",
			"ui/activity/fanshiAssist/severRechargeSmall/02.png",
			"ui/activity/fanshiAssist/severRechargeSmall/003.png",
			"ui/activity/fanshiAssist/severRechargeSmall/001.png",
			"ui/activity/fanshiAssist/severRechargeSmall/04.png",
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

