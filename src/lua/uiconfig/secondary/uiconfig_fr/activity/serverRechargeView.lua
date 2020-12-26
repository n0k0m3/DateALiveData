local t = 
{
	version = 1,
	components = 
	{
		
		{
			controlID = "Panel-serverRechargeView_Layer1_activity_Game",
			UUID = "86069880_449c_4caa_9fac_ce7f3774574b",
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
			height = "719",
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
			width = "1020",
			ZOrder = "1",
			components = 
			{
				
				{
					controlID = "Panel_base_Panel-serverRechargeView_Layer1_activity_Game",
					UUID = "9aee4dc4_7f2c_4223_a81f_d2fedf9a6683",
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
							controlID = "bg_Panel_base_Panel-serverRechargeView_Layer1_activity_Game",
							UUID = "3e4f0652_a5e8_4133_a16f_1146aae1c287",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							backGroundScale9Enable = "False",
							classname = "MEImage",
							dstBlendFunc = "771",
							height = "640",
							ignoreSize = "True",
							name = "bg",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							texturePath = "ui/activity/allServer_recharge/main/bg.png",
							touchAble = "False",
							UILayoutViewModel = 
							{
								PositionX = 568,
								PositionY = 320,
							},
							width = "1386",
							ZOrder = "1",
						},
						{
							controlID = "Image_title_Panel_base_Panel-serverRechargeView_Layer1_activity_Game",
							UUID = "e28b0f36_5b03_4078_8405_ce9766a5784d",
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
								PositionX = 307,
								PositionY = 415,
							},
							width = "600",
							ZOrder = "1",
						},
						{
							controlID = "label_time_Panel_base_Panel-serverRechargeView_Layer1_activity_Game",
							UUID = "2eb1afd0_24ef_4359_9aaf_e661810a6415",
							anchorPoint = "False",
							anchorPointX = "0",
							anchorPointY = "0.5",
							classname = "MELabel",
							compPath = "luacomponents.common.MEIconLabel",
							dstBlendFunc = "771",
							FontColor = "#FFFFB80F",
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
							name = "label_time",
							nTextAlign = "1",
							nTextHAlign = "1",
							rotation = "-10",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "770",
							text = "TextLable",
							touchAble = "False",
							touchScaleEnable = "False",
							UILayoutViewModel = 
							{
								PositionX = 345,
								PositionY = 503,
							},
							width = "144",
							ZOrder = "1",
						},
						{
							controlID = "label_des_Panel_base_Panel-serverRechargeView_Layer1_activity_Game",
							UUID = "8a7b877c_dddb_4cd9_9fa1_ef8b56b3d623",
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
							fontSize = "22",
							fontStroke = 
							{
								IsStroke = true,
								StrokeColor = "#FF4D49AD",
								StrokeSize = 2,
							},
							height = "31",
							ignoreSize = "True",
							name = "label_des",
							nTextAlign = "1",
							nTextHAlign = "1",
							rotation = "-9",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "770",
							text = "TextLable",
							touchAble = "False",
							touchScaleEnable = "False",
							UILayoutViewModel = 
							{
								PositionX = 111,
								PositionY = 313,
							},
							width = "146",
							ZOrder = "1",
						},
						{
							controlID = "panel_ItemParent_Panel_base_Panel-serverRechargeView_Layer1_activity_Game",
							UUID = "e972f789_c383_40ba_aa7a_7d6def797f26",
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
							controlID = "label_tip1_Panel_base_Panel-serverRechargeView_Layer1_activity_Game",
							UUID = "f3418fe7_a54c_4643_be69_2904acf248c0",
							anchorPoint = "False",
							anchorPointX = "0",
							anchorPointY = "0.5",
							classname = "MELabel",
							compPath = "luacomponents.common.MEIconLabel",
							dstBlendFunc = "771",
							FontColor = "#FFA6A2FA",
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
							name = "label_tip1",
							nTextAlign = "1",
							nTextHAlign = "1",
							rotation = "-10",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "770",
							text = "Achat actuel",
							touchAble = "False",
							touchScaleEnable = "False",
							UILayoutViewModel = 
							{
								PositionX = 5,
								PositionY = 80,
							},
							width = "132",
							ZOrder = "1",
						},
						{
							controlID = "label_number_Panel_base_Panel-serverRechargeView_Layer1_activity_Game",
							UUID = "853f546a_12c2_4a61_bdfe_aa9c156d65fe",
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
							fontSize = "32",
							fontStroke = 
							{
								IsStroke = false,
								StrokeColor = "#FFE6E6E6",
								StrokeSize = 1,
							},
							height = "40",
							ignoreSize = "True",
							name = "label_number",
							nTextAlign = "1",
							nTextHAlign = "1",
							rotation = "-11",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "770",
							text = "3000.0",
							touchAble = "False",
							touchScaleEnable = "False",
							UILayoutViewModel = 
							{
								PositionX = 78,
								PositionY = 46,
							},
							width = "114",
							ZOrder = "1",
						},
						{
							controlID = "Image1_Panel_base_Panel-serverRechargeView_Layer1_activity_Game",
							UUID = "34104b33_4a93_4e78_a31f_ec017a10b6ec",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							backGroundScale9Enable = "False",
							classname = "MEImage",
							dstBlendFunc = "771",
							height = "166",
							ignoreSize = "True",
							name = "Image1",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							texturePath = "ui/activity/allServer_recharge/main/004.png",
							touchAble = "False",
							UILayoutViewModel = 
							{
								PositionX = 945,
								PositionY = 81,
							},
							width = "188",
							ZOrder = "1",
						},
						{
							controlID = "Button_goShop_Panel_base_Panel-serverRechargeView_Layer1_activity_Game",
							UUID = "7c42b2a1_3a52_458b_b0d3_17fe39da9004",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							backGroundScale9Enable = "False",
							classname = "MEButton",
							ClickHighLightEnabled = "True",
							dstBlendFunc = "771",
							flipX = "False",
							flipY = "False",
							height = "174",
							ignoreSize = "True",
							name = "Button_goShop",
							normal = "ui/activity/allServer_recharge/main/005.png",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							touchAble = "True",
							UILayoutViewModel = 
							{
								PositionX = 920,
								PositionY = 102,
							},
							UItype = "Button",
							width = "186",
							ZOrder = "1",
							components = 
							{
								
								{
									controlID = "Label_serverRechargeView_1_Button_goShop_Panel_base_Panel-serverRechargeView_Layer1_activity_Game",
									UUID = "3b286a15_61bf_4976_8008_a50fdd00e248",
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
									fontSize = "32",
									fontStroke = 
									{
										IsStroke = false,
										StrokeColor = "#FFE6E6E6",
										StrokeSize = 1,
									},
									height = "79",
									ignoreSize = "False",
									name = "Label_serverRechargeView_1",
									nTextAlign = "1",
									nTextHAlign = "1",
									rotation = "-10",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "Acheter pack",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionX = -1,
										PositionY = -3,
									},
									width = "79",
									ZOrder = "1",
								},
							},
						},
					},
				},
				{
					controlID = "Panel_prefab_Panel-serverRechargeView_Layer1_activity_Game",
					UUID = "f066dcd9_9a8d_4152_a8f4_bb1c69cc80e0",
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
						PositionY = -740,
						BottomPosition = -740,
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
					width = "1136",
					ZOrder = "1",
					components = 
					{
						
						{
							controlID = "Panel_Item_Panel_prefab_Panel-serverRechargeView_Layer1_activity_Game",
							UUID = "9024a8a8_d89f_412b_903d_480a3776344f",
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
									controlID = "Panel_geted_Panel_Item_Panel_prefab_Panel-serverRechargeView_Layer1_activity_Game",
									UUID = "01dc214c_6dca_49e9_a15a_e3222696d642",
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
											controlID = "Image_bg_Panel_geted_Panel_Item_Panel_prefab_Panel-serverRechargeView_Layer1_activity_Game",
											UUID = "e162204f_ccc5_4480_b6eb_7da0d277564c",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											classname = "MEImage",
											dstBlendFunc = "771",
											height = "206",
											ignoreSize = "True",
											name = "Image_bg",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											texturePath = "ui/activity/allServer_recharge/main/001.png",
											touchAble = "False",
											UILayoutViewModel = 
											{
												
											},
											width = "216",
											ZOrder = "1",
										},
										{
											controlID = "Image_box_Panel_geted_Panel_Item_Panel_prefab_Panel-serverRechargeView_Layer1_activity_Game",
											UUID = "99f56419_8e29_4e8b_a400_cb2ecae8b307",
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
											texturePath = "ui/task/box_3.png",
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
											controlID = "Image_gou_Panel_geted_Panel_Item_Panel_prefab_Panel-serverRechargeView_Layer1_activity_Game",
											UUID = "c743201c_412f_4d14_ba94_3461a44b60fe",
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
											controlID = "Image2_Panel_geted_Panel_Item_Panel_prefab_Panel-serverRechargeView_Layer1_activity_Game",
											UUID = "fec31961_7a48_4682_8b96_6722e4ef1ebf",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											classname = "MEImage",
											dstBlendFunc = "771",
											height = "64",
											ignoreSize = "True",
											name = "Image2",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											texturePath = "ui/activity/allServer_recharge/main/002.png",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 9,
												PositionY = -71,
											},
											width = "154",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "Label_num_Image2_Panel_geted_Panel_Item_Panel_prefab_Panel-serverRechargeView_Layer1_activity_Game",
													UUID = "5b750541_8115_47bc_ac80_c2ecde0ebc9d",
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
													height = "35",
													ignoreSize = "True",
													name = "Label_num",
													nTextAlign = "1",
													nTextHAlign = "1",
													rotation = "-10",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "770",
													text = "100.0",
													touchAble = "False",
													touchScaleEnable = "False",
													UILayoutViewModel = 
													{
														PositionX = 6,
														PositionY = -3,
													},
													width = "66",
													ZOrder = "1",
												},
											},
										},
									},
								},
								{
									controlID = "Panel_get_Panel_Item_Panel_prefab_Panel-serverRechargeView_Layer1_activity_Game",
									UUID = "43054ca9_b091_4343_a79f_823c3239e18a",
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
									width = "10",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "Image_bg_Panel_get_Panel_Item_Panel_prefab_Panel-serverRechargeView_Layer1_activity_Game",
											UUID = "6e561399_cc26_4f53_ba25_af5a7907ac98",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											classname = "MEImage",
											dstBlendFunc = "771",
											height = "206",
											ignoreSize = "True",
											name = "Image_bg",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											texturePath = "ui/activity/allServer_recharge/main/003.png",
											touchAble = "False",
											UILayoutViewModel = 
											{
												
											},
											width = "216",
											ZOrder = "1",
										},
										{
											controlID = "Image_box_Panel_get_Panel_Item_Panel_prefab_Panel-serverRechargeView_Layer1_activity_Game",
											UUID = "36214aaf_0140_4d29_9570_56418299154b",
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
											texturePath = "ui/task/box_2.png",
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
											controlID = "Image2_Panel_get_Panel_Item_Panel_prefab_Panel-serverRechargeView_Layer1_activity_Game",
											UUID = "2fb32050_eea4_407a_9cf1_1a530829edd6",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											classname = "MEImage",
											dstBlendFunc = "771",
											height = "64",
											ignoreSize = "True",
											name = "Image2",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											texturePath = "ui/activity/allServer_recharge/main/002.png",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 9,
												PositionY = -71,
											},
											width = "154",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "Label_num_Image2_Panel_get_Panel_Item_Panel_prefab_Panel-serverRechargeView_Layer1_activity_Game",
													UUID = "f1236b01_2136_4a72_b797_dead85bad458",
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
													height = "35",
													ignoreSize = "True",
													name = "Label_num",
													nTextAlign = "1",
													nTextHAlign = "1",
													rotation = "-10",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "770",
													text = "100.0",
													touchAble = "False",
													touchScaleEnable = "False",
													UILayoutViewModel = 
													{
														PositionX = 6,
														PositionY = -3,
													},
													width = "66",
													ZOrder = "1",
												},
											},
										},
										{
											controlID = "Spine_effect_Panel_get_Panel_Item_Panel_prefab_Panel-serverRechargeView_Layer1_activity_Game",
											UUID = "63db923a_d124_4181_881c_f15fdb223515",
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
									controlID = "Panel_ing_Panel_Item_Panel_prefab_Panel-serverRechargeView_Layer1_activity_Game",
									UUID = "61277be5_6ceb_4d15_b296_2a80d286d9cf",
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
									width = "10",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "Image_bg_Panel_ing_Panel_Item_Panel_prefab_Panel-serverRechargeView_Layer1_activity_Game",
											UUID = "fff47b04_3755_49be_bcf0_1ac10b66d44e",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											classname = "MEImage",
											dstBlendFunc = "771",
											height = "206",
											ignoreSize = "True",
											name = "Image_bg",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											texturePath = "ui/activity/allServer_recharge/main/001.png",
											touchAble = "False",
											UILayoutViewModel = 
											{
												
											},
											width = "216",
											ZOrder = "1",
										},
										{
											controlID = "Image_box_Panel_ing_Panel_Item_Panel_prefab_Panel-serverRechargeView_Layer1_activity_Game",
											UUID = "ceba3dea_2f75_49ef_b0b3_838d811e179b",
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
											texturePath = "ui/task/box_1.png",
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
											controlID = "Image2_Panel_ing_Panel_Item_Panel_prefab_Panel-serverRechargeView_Layer1_activity_Game",
											UUID = "ea164c0d_8d08_4ab4_99ce_3b97c01ce712",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											classname = "MEImage",
											dstBlendFunc = "771",
											height = "64",
											ignoreSize = "True",
											name = "Image2",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											texturePath = "ui/activity/allServer_recharge/main/002.png",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 9,
												PositionY = -71,
											},
											width = "154",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "Label_num_Image2_Panel_ing_Panel_Item_Panel_prefab_Panel-serverRechargeView_Layer1_activity_Game",
													UUID = "4d52a915_5c62_4723_a7ce_007f9e6e73c5",
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
													height = "35",
													ignoreSize = "True",
													name = "Label_num",
													nTextAlign = "1",
													nTextHAlign = "1",
													rotation = "-10",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "770",
													text = "100.0",
													touchAble = "False",
													touchScaleEnable = "False",
													UILayoutViewModel = 
													{
														PositionX = 6,
														PositionY = -3,
													},
													width = "66",
													ZOrder = "1",
												},
											},
										},
										{
											controlID = "Image_buyFlag_Panel_ing_Panel_Item_Panel_prefab_Panel-serverRechargeView_Layer1_activity_Game",
											UUID = "223bf8ff_2af3_4aef_b3a4_660fe417c491",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											classname = "MEImage",
											dstBlendFunc = "771",
											height = "112",
											ignoreSize = "True",
											name = "Image_buyFlag",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											texturePath = "ui/activity/allServer_recharge/main/007.png",
											touchAble = "False",
											UILayoutViewModel = 
											{
												
											},
											width = "222",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "Label_serverRechargeView_1_Image_buyFlag_Panel_ing_Panel_Item_Panel_prefab_Panel-serverRechargeView_Layer1_activity_Game",
													UUID = "990832e8_36ab_4daa_a9e4_490fa740c58e",
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
													height = "41",
													ignoreSize = "True",
													name = "Label_serverRechargeView_1",
													nTextAlign = "1",
													nTextHAlign = "1",
													rotation = "-11",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "770",
													text = "Achetez pour obtenir",
													touchAble = "False",
													touchScaleEnable = "False",
													UILayoutViewModel = 
													{
														
													},
													width = "155",
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
			"ui/activity/allServer_recharge/main/bg.png",
			"ui/activity/allServer_recharge/main/006.png",
			"ui/activity/allServer_recharge/main/004.png",
			"ui/activity/allServer_recharge/main/005.png",
			"ui/activity/allServer_recharge/main/001.png",
			"ui/task/box_3.png",
			"ui/fuli/item_gou.png",
			"ui/activity/allServer_recharge/main/002.png",
			"ui/activity/allServer_recharge/main/003.png",
			"ui/task/box_2.png",
			"ui/task/box_1.png",
			"ui/activity/allServer_recharge/main/007.png",
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

