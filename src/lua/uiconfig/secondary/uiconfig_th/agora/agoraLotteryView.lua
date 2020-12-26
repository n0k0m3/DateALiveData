local t = 
{
	version = 1,
	components = 
	{
		
		{
			controlID = "Panel-agoraLotteryView_Layer1_agora_Game",
			UUID = "10a6be81_6597_4e63_9802_14ed1a39a683",
			anchorPoint = "False",
			anchorPointX = "0",
			anchorPointY = "0",
			backGroundScale9Enable = "False",
			bgColorOpacity = "50",
			bIsOpenClipping = "False",
			classname = "MEPanel",
			colorType = "0;SingleColor:#FFFF4500;GraduallyChangingColorStart:#FFFFFFFF;GraduallyChangingColorEnd:#FFFFFFFF;vectorX:0;vectorY:0",
			DesignHeight = "640",
			DesignType = "0",
			DesignWidth = "960",
			dstBlendFunc = "771",
			height = "640",
			ignoreSize = "False",
			name = "Panel",
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
					controlID = "Panel_root_Panel-agoraLotteryView_Layer1_agora_Game",
					UUID = "14229f51_04db_4a1c_a68a_c6c454009e44",
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
					touchAble = "False",
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
							controlID = "Image_diban_Panel_root_Panel-agoraLotteryView_Layer1_agora_Game",
							UUID = "ec5c2492_81da_45ee_ae7e_f13b0025dff3",
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
							texturePath = "ui/agora/summon/summon_bg.png",
							touchAble = "False",
							UILayoutViewModel = 
							{
								relativeToName = "Panel",
								nGravity = 6,
								nAlign = 5
							},
							width = "1386",
							ZOrder = "1",
						},
						{
							controlID = "Button_lottery1_Panel_root_Panel-agoraLotteryView_Layer1_agora_Game",
							UUID = "df3648ec_2601_42b2_ab36_fcf4007915b9",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							backGroundScale9Enable = "False",
							classname = "MEButton",
							ClickHighLightEnabled = "True",
							dstBlendFunc = "771",
							flipX = "False",
							flipY = "False",
							height = "88",
							ignoreSize = "True",
							name = "Button_lottery1",
							normal = "ui/agora/summon/btn_blue.png",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							touchAble = "True",
							UILayoutViewModel = 
							{
								PositionX = 397,
								PositionY = -51,
							},
							UItype = "Button",
							width = "268",
							ZOrder = "1",
							components = 
							{
								
								{
									controlID = "Label_btn_Button_lottery1_Panel_root_Panel-agoraLotteryView_Layer1_agora_Game",
									UUID = "0146ce1d_608c_4e4a_b7a7_8fea89bd6536",
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
										StrokeColor = "#FF4689B6",
										StrokeSize = 1,
									},
									height = "39",
									ignoreSize = "True",
									name = "Label_btn",
									nTextAlign = "1",
									nTextHAlign = "1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "สุ่ม x1",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										
									},
									width = "109",
									ZOrder = "1",
								},
								{
									controlID = "Image_cost_Button_lottery1_Panel_root_Panel-agoraLotteryView_Layer1_agora_Game",
									UUID = "9b64ee7b_36e4_415d_8777_1bd5d4af68f0",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "42",
									ignoreSize = "True",
									name = "Image_cost",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/agora/summon/text_bg.png",
									touchAble = "True",
									UILayoutViewModel = 
									{
										PositionY = -63,
									},
									width = "187",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "Label_num_Image_cost_Button_lottery1_Panel_root_Panel-agoraLotteryView_Layer1_agora_Game",
											UUID = "ccb9d859_afbd_4e22_a2f9_0f7f1e26d83a",
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
											fontSize = "24",
											fontStroke = 
											{
												IsStroke = false,
												StrokeColor = "#FFE6E6E6",
												StrokeSize = 1,
											},
											height = "27",
											ignoreSize = "True",
											name = "Label_num",
											nTextAlign = "1",
											nTextHAlign = "1",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "770",
											text = "465711111",
											touchAble = "False",
											touchScaleEnable = "False",
											UILayoutViewModel = 
											{
												PositionX = 56,
												PositionY = 1,
											},
											width = "93",
											ZOrder = "1",
										},
										{
											controlID = "Image_icon_Image_cost_Button_lottery1_Panel_root_Panel-agoraLotteryView_Layer1_agora_Game",
											UUID = "c4ee1422_940f_4594_82e1_e0aa1b6e2b2d",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											classname = "MEImage",
											dstBlendFunc = "771",
											height = "64",
											ignoreSize = "True",
											name = "Image_icon",
											scaleX = "0.5",
											scaleY = "0.5",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "770",
											texturePath = "icon/item/goods/510217.png",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = -47,
												PositionY = -4,
											},
											width = "64",
											ZOrder = "1",
										},
									},
								},
							},
						},
						{
							controlID = "Button_lottery2_Panel_root_Panel-agoraLotteryView_Layer1_agora_Game",
							UUID = "de088f9d_7866_4ab9_9533_6ed68ab31d62",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							backGroundScale9Enable = "False",
							classname = "MEButton",
							ClickHighLightEnabled = "True",
							dstBlendFunc = "771",
							flipX = "False",
							flipY = "False",
							height = "88",
							ignoreSize = "True",
							name = "Button_lottery2",
							normal = "ui/agora/summon/btn_red.png",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							touchAble = "True",
							UILayoutViewModel = 
							{
								PositionX = 397,
								PositionY = -201,
							},
							UItype = "Button",
							width = "268",
							ZOrder = "1",
							components = 
							{
								
								{
									controlID = "Label_btn_Button_lottery2_Panel_root_Panel-agoraLotteryView_Layer1_agora_Game",
									UUID = "ae504e04_3a46_4af8_8fee_4a4a65c3e816",
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
										StrokeColor = "#FF87374E",
										StrokeSize = 1,
									},
									height = "39",
									ignoreSize = "True",
									name = "Label_btn",
									nTextAlign = "1",
									nTextHAlign = "1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "เปิด x1",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										
									},
									width = "78",
									ZOrder = "1",
								},
								{
									controlID = "Image_cost_Button_lottery2_Panel_root_Panel-agoraLotteryView_Layer1_agora_Game",
									UUID = "b9c39894_0d58_4fdd_87b0_38c1810f4428",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "42",
									ignoreSize = "True",
									name = "Image_cost",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/agora/summon/text_bg.png",
									touchAble = "True",
									UILayoutViewModel = 
									{
										PositionY = -63,
									},
									width = "187",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "Label_num_Image_cost_Button_lottery2_Panel_root_Panel-agoraLotteryView_Layer1_agora_Game",
											UUID = "15e69a4d_d0bc_47e8_ba0c_3082c9519612",
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
											fontSize = "24",
											fontStroke = 
											{
												IsStroke = false,
												StrokeColor = "#FFE6E6E6",
												StrokeSize = 1,
											},
											height = "27",
											ignoreSize = "True",
											name = "Label_num",
											nTextAlign = "1",
											nTextHAlign = "1",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "770",
											text = "465711111",
											touchAble = "False",
											touchScaleEnable = "False",
											UILayoutViewModel = 
											{
												PositionX = 55,
												PositionY = 1,
											},
											width = "93",
											ZOrder = "1",
										},
										{
											controlID = "Image_icon_Image_cost_Button_lottery2_Panel_root_Panel-agoraLotteryView_Layer1_agora_Game",
											UUID = "7340dd48_ef67_4983_8d37_a58a17bb9679",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											classname = "MEImage",
											dstBlendFunc = "771",
											height = "64",
											ignoreSize = "True",
											name = "Image_icon",
											scaleX = "0.5",
											scaleY = "0.5",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "770",
											texturePath = "icon/item/goods/510217.png",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = -47,
												PositionY = -4,
											},
											width = "64",
											ZOrder = "1",
										},
									},
								},
							},
						},
						{
							controlID = "Image_preview_Panel_root_Panel-agoraLotteryView_Layer1_agora_Game",
							UUID = "bde9df45_b665_4521_82a8_3bbd5ea52eac",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							backGroundScale9Enable = "False",
							classname = "MEImage",
							dstBlendFunc = "771",
							height = "126",
							ignoreSize = "True",
							name = "Image_preview",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							texturePath = "ui/summon/022.png",
							touchAble = "False",
							UILayoutViewModel = 
							{
								PositionX = 524,
								PositionY = 203,
							},
							width = "126",
							ZOrder = "1",
							components = 
							{
								
								{
									controlID = "Button_preview_Image_preview_Panel_root_Panel-agoraLotteryView_Layer1_agora_Game",
									UUID = "b2c377ee_88f0_477c_a2c1_e91007e786e7",
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
									name = "Button_preview",
									normal = "ui/summon/002.png",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "True",
									UILayoutViewModel = 
									{
										
									},
									UItype = "Button",
									width = "46",
									ZOrder = "1",
								},
							},
						},
						{
							controlID = "Image_history_Panel_root_Panel-agoraLotteryView_Layer1_agora_Game",
							UUID = "69358d1d_c87d_48e4_812a_d24f13601c14",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							backGroundScale9Enable = "False",
							classname = "MEImage",
							dstBlendFunc = "771",
							height = "126",
							ignoreSize = "True",
							name = "Image_history",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							texturePath = "ui/summon/022.png",
							touchAble = "False",
							UILayoutViewModel = 
							{
								PositionX = 524,
								PositionY = 134,
							},
							width = "126",
							ZOrder = "1",
							components = 
							{
								
								{
									controlID = "Button_history_Image_history_Panel_root_Panel-agoraLotteryView_Layer1_agora_Game",
									UUID = "0c4bfc46_0a65_492e_8f5b_0fb7aa0c2bc3",
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
									name = "Button_history",
									normal = "ui/summon/001.png",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "True",
									UILayoutViewModel = 
									{
										PositionY = -3,
									},
									UItype = "Button",
									width = "46",
									ZOrder = "1",
								},
							},
						},
						{
							controlID = "Panel_tree_Panel_root_Panel-agoraLotteryView_Layer1_agora_Game",
							UUID = "35bf3793_411b_4041_ac83_58f64d0bf197",
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
							name = "Panel_tree",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							touchAble = "False",
							UILayoutViewModel = 
							{
								PositionX = -150,
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
									controlID = "Image_time_Panel_tree_Panel_root_Panel-agoraLotteryView_Layer1_agora_Game",
									UUID = "782031fb_61ec_4fcb_8b97_12a5601d00db",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "46",
									ignoreSize = "True",
									name = "Image_time",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/agora/compose/8.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionY = -271,
									},
									width = "274",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "Label_summon_cnt_Image_time_Panel_tree_Panel_root_Panel-agoraLotteryView_Layer1_agora_Game",
											UUID = "2da84464_905f_4814_8c44_39c80a229641",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											classname = "MELabel",
											compPath = "luacomponents.common.MEIconLabel",
											dstBlendFunc = "771",
											FontColor = "#FFF9DB45",
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
												StrokeColor = "#FF7B4426",
												StrokeSize = 1,
											},
											height = "29",
											ignoreSize = "True",
											name = "Label_summon_cnt",
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
												
											},
											width = "145",
											ZOrder = "1",
										},
									},
								},
								{
									controlID = "Image_flash_Panel_tree_Panel_root_Panel-agoraLotteryView_Layer1_agora_Game",
									UUID = "10c92e9a_8ee2_4a95_a3d2_85aa2a1d5904",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "183",
									ignoreSize = "True",
									name = "Image_flash",
									scaleX = "1.4",
									scaleY = "1.4",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/agora/summon/flash.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = 7,
										PositionY = 142,
									},
									width = "183",
									ZOrder = "1",
								},
								{
									controlID = "Panel_gift_1_Panel_tree_Panel_root_Panel-agoraLotteryView_Layer1_agora_Game",
									UUID = "a75800fd_3e63_4274_8111_a8ad43a9ef86",
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
									height = "121",
									ignoreSize = "False",
									name = "Panel_gift_1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = -3,
										PositionY = 143,
									},
									uipanelviewmodel = 
									{
										Layout="Absolute",
										nType = "0"
									},
									width = "136",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "Image_gift_bg_Panel_gift_1_Panel_tree_Panel_root_Panel-agoraLotteryView_Layer1_agora_Game",
											UUID = "2908c243_db19_4915_a29e_3f9660f19291",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											classname = "MEImage",
											dstBlendFunc = "771",
											height = "110",
											ignoreSize = "True",
											name = "Image_gift_bg",
											scaleX = "0.8",
											scaleY = "0.8",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											texturePath = "ui/common/frame_blue.png",
											touchAble = "True",
											UILayoutViewModel = 
											{
												
											},
											width = "110",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "Image_gift_item_Image_gift_bg_Panel_gift_1_Panel_tree_Panel_root_Panel-agoraLotteryView_Layer1_agora_Game",
													UUID = "9dab0238_34c0_4ec7_a677_42a7df27c515",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0.5",
													backGroundScale9Enable = "False",
													classname = "MEImage",
													dstBlendFunc = "771",
													height = "111",
													ignoreSize = "True",
													name = "Image_gift_item",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "1",
													texturePath = "icon/equipment/icon/192_166/icon3_jichu_1.png",
													touchAble = "False",
													UILayoutViewModel = 
													{
														
													},
													width = "126",
													ZOrder = "1",
												},
											},
										},
										{
											controlID = "Image_getted_Panel_gift_1_Panel_tree_Panel_root_Panel-agoraLotteryView_Layer1_agora_Game",
											UUID = "bdd0f51c_d99f_4dfa_996e_6ce5f789986f",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											classname = "MEImage",
											dstBlendFunc = "771",
											height = "71",
											ignoreSize = "True",
											name = "Image_getted",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											texturePath = "ui/agora/summon/geted_bg.png",
											touchAble = "False",
											UILayoutViewModel = 
											{
												
											},
											width = "71",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "Label_geted_Image_getted_Panel_gift_1_Panel_tree_Panel_root_Panel-agoraLotteryView_Layer1_agora_Game",
													UUID = "07bd50fe_6c68_4801_8687_84365eeabf61",
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
														IsStroke = true,
														StrokeColor = "#FF5C628E",
														StrokeSize = 2,
													},
													height = "29",
													ignoreSize = "True",
													name = "Label_geted",
													nTextAlign = "1",
													nTextHAlign = "1",
													rotation = "-30",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "770",
													text = "ได้รับ",
													touchAble = "False",
													touchScaleEnable = "False",
													UILayoutViewModel = 
													{
														
													},
													width = "65",
													ZOrder = "1",
												},
											},
										},
									},
								},
								{
									controlID = "Panel_gift_2_Panel_tree_Panel_root_Panel-agoraLotteryView_Layer1_agora_Game",
									UUID = "f565876f_4035_49e1_bc7b_b922c49e3544",
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
									height = "121",
									ignoreSize = "False",
									name = "Panel_gift_2",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = 98,
										PositionY = 47,
									},
									uipanelviewmodel = 
									{
										Layout="Absolute",
										nType = "0"
									},
									width = "136",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "Image_gift_bg_Panel_gift_2_Panel_tree_Panel_root_Panel-agoraLotteryView_Layer1_agora_Game",
											UUID = "90081bbb_a3b3_4496_b861_79d2e33f5475",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											classname = "MEImage",
											dstBlendFunc = "771",
											height = "121",
											ignoreSize = "True",
											name = "Image_gift_bg",
											scaleX = "0.8",
											scaleY = "0.8",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											texturePath = "ui/fairy_particle/6.png",
											touchAble = "True",
											UILayoutViewModel = 
											{
												
											},
											width = "136",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "Image_gift_item_Image_gift_bg_Panel_gift_2_Panel_tree_Panel_root_Panel-agoraLotteryView_Layer1_agora_Game",
													UUID = "1cb67ba6_dd89_4196_9f2c_cb01113ba8da",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0.5",
													backGroundScale9Enable = "False",
													classname = "MEImage",
													dstBlendFunc = "771",
													height = "111",
													ignoreSize = "True",
													name = "Image_gift_item",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "1",
													texturePath = "icon/equipment/icon/192_166/icon3_jichu_1.png",
													touchAble = "False",
													UILayoutViewModel = 
													{
														
													},
													width = "126",
													ZOrder = "1",
												},
											},
										},
										{
											controlID = "Image_getted_Panel_gift_2_Panel_tree_Panel_root_Panel-agoraLotteryView_Layer1_agora_Game",
											UUID = "84ce823b_59db_4e0d_a000_6d2c7afb39a7",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											classname = "MEImage",
											dstBlendFunc = "771",
											height = "71",
											ignoreSize = "True",
											name = "Image_getted",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											texturePath = "ui/agora/summon/geted_bg.png",
											touchAble = "False",
											UILayoutViewModel = 
											{
												
											},
											width = "71",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "Label_geted_Image_getted_Panel_gift_2_Panel_tree_Panel_root_Panel-agoraLotteryView_Layer1_agora_Game",
													UUID = "54357b31_ba21_4b72_8cdc_3a7720c232db",
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
														IsStroke = true,
														StrokeColor = "#FF5C628E",
														StrokeSize = 2,
													},
													height = "29",
													ignoreSize = "True",
													name = "Label_geted",
													nTextAlign = "1",
													nTextHAlign = "1",
													rotation = "-30",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "770",
													text = "ได้รับ",
													touchAble = "False",
													touchScaleEnable = "False",
													UILayoutViewModel = 
													{
														
													},
													width = "65",
													ZOrder = "1",
												},
											},
										},
									},
								},
								{
									controlID = "Panel_gift_3_Panel_tree_Panel_root_Panel-agoraLotteryView_Layer1_agora_Game",
									UUID = "d2834058_6dcd_40b6_87f5_49136a85b445",
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
									height = "121",
									ignoreSize = "False",
									name = "Panel_gift_3",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionY = -22,
									},
									uipanelviewmodel = 
									{
										Layout="Absolute",
										nType = "0"
									},
									width = "136",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "Image_gift_bg_Panel_gift_3_Panel_tree_Panel_root_Panel-agoraLotteryView_Layer1_agora_Game",
											UUID = "9fbc77a3_e21e_41fa_8bbb_2218abf65428",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											classname = "MEImage",
											dstBlendFunc = "771",
											height = "121",
											ignoreSize = "True",
											name = "Image_gift_bg",
											scaleX = "0.9",
											scaleY = "0.9",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											texturePath = "ui/fairy_particle/6.png",
											touchAble = "True",
											UILayoutViewModel = 
											{
												
											},
											width = "136",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "Image_gift_item_Image_gift_bg_Panel_gift_3_Panel_tree_Panel_root_Panel-agoraLotteryView_Layer1_agora_Game",
													UUID = "427785eb_39fe_44bc_9211_5a7fdf123ff3",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0.5",
													backGroundScale9Enable = "False",
													classname = "MEImage",
													dstBlendFunc = "771",
													height = "111",
													ignoreSize = "True",
													name = "Image_gift_item",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "1",
													texturePath = "icon/equipment/icon/192_166/icon3_jichu_1.png",
													touchAble = "False",
													UILayoutViewModel = 
													{
														
													},
													width = "126",
													ZOrder = "1",
												},
											},
										},
										{
											controlID = "Image_getted_Panel_gift_3_Panel_tree_Panel_root_Panel-agoraLotteryView_Layer1_agora_Game",
											UUID = "33a627e8_da88_4488_a5f8_6337a3c951dd",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											classname = "MEImage",
											dstBlendFunc = "771",
											height = "71",
											ignoreSize = "True",
											name = "Image_getted",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											texturePath = "ui/agora/summon/geted_bg.png",
											touchAble = "False",
											UILayoutViewModel = 
											{
												
											},
											width = "71",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "Label_geted_Image_getted_Panel_gift_3_Panel_tree_Panel_root_Panel-agoraLotteryView_Layer1_agora_Game",
													UUID = "ed06041b_8f1b_4715_9672_85bf0a5ff68f",
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
														IsStroke = true,
														StrokeColor = "#FF5C628E",
														StrokeSize = 2,
													},
													height = "29",
													ignoreSize = "True",
													name = "Label_geted",
													nTextAlign = "1",
													nTextHAlign = "1",
													rotation = "-30",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "770",
													text = "ได้รับ",
													touchAble = "False",
													touchScaleEnable = "False",
													UILayoutViewModel = 
													{
														
													},
													width = "65",
													ZOrder = "1",
												},
											},
										},
									},
								},
								{
									controlID = "Panel_gift_4_Panel_tree_Panel_root_Panel-agoraLotteryView_Layer1_agora_Game",
									UUID = "1204cae2_a6fd_4568_892a_b3af18d3315c",
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
									height = "121",
									ignoreSize = "False",
									name = "Panel_gift_4",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = -114,
										PositionY = 7,
									},
									uipanelviewmodel = 
									{
										Layout="Absolute",
										nType = "0"
									},
									width = "136",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "Image_gift_bg_Panel_gift_4_Panel_tree_Panel_root_Panel-agoraLotteryView_Layer1_agora_Game",
											UUID = "5e0f0040_e9d0_4e05_a084_2c45b6db5240",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											classname = "MEImage",
											dstBlendFunc = "771",
											height = "121",
											ignoreSize = "True",
											name = "Image_gift_bg",
											scaleX = "0.8",
											scaleY = "0.8",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											texturePath = "ui/fairy_particle/6.png",
											touchAble = "True",
											UILayoutViewModel = 
											{
												
											},
											width = "136",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "Image_gift_item_Image_gift_bg_Panel_gift_4_Panel_tree_Panel_root_Panel-agoraLotteryView_Layer1_agora_Game",
													UUID = "4a38f79a_d20c_40b5_a57c_372965aa8fd5",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0.5",
													backGroundScale9Enable = "False",
													classname = "MEImage",
													dstBlendFunc = "771",
													height = "111",
													ignoreSize = "True",
													name = "Image_gift_item",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "1",
													texturePath = "icon/equipment/icon/192_166/icon3_jichu_1.png",
													touchAble = "False",
													UILayoutViewModel = 
													{
														
													},
													width = "126",
													ZOrder = "1",
												},
											},
										},
										{
											controlID = "Image_getted_Panel_gift_4_Panel_tree_Panel_root_Panel-agoraLotteryView_Layer1_agora_Game",
											UUID = "23ac75a5_8883_432e_acb8_d9bf0d98996f",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											classname = "MEImage",
											dstBlendFunc = "771",
											height = "71",
											ignoreSize = "True",
											name = "Image_getted",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											texturePath = "ui/agora/summon/geted_bg.png",
											touchAble = "False",
											UILayoutViewModel = 
											{
												
											},
											width = "71",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "Label_geted_Image_getted_Panel_gift_4_Panel_tree_Panel_root_Panel-agoraLotteryView_Layer1_agora_Game",
													UUID = "fa81726a_beaa_478a_98f3_2b58d6d5d2e0",
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
														IsStroke = true,
														StrokeColor = "#FF5C628E",
														StrokeSize = 2,
													},
													height = "29",
													ignoreSize = "True",
													name = "Label_geted",
													nTextAlign = "1",
													nTextHAlign = "1",
													rotation = "-30",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "770",
													text = "ได้รับ",
													touchAble = "False",
													touchScaleEnable = "False",
													UILayoutViewModel = 
													{
														
													},
													width = "65",
													ZOrder = "1",
												},
											},
										},
									},
								},
								{
									controlID = "Panel_gift_5_Panel_tree_Panel_root_Panel-agoraLotteryView_Layer1_agora_Game",
									UUID = "abe9a5d8_e5a3_4c40_8d9a_19af4d21504b",
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
									height = "121",
									ignoreSize = "False",
									name = "Panel_gift_5",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = -64,
										PositionY = -152,
									},
									uipanelviewmodel = 
									{
										Layout="Absolute",
										nType = "0"
									},
									width = "136",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "Image_gift_bg_Panel_gift_5_Panel_tree_Panel_root_Panel-agoraLotteryView_Layer1_agora_Game",
											UUID = "951f65cc_310d_483b_9c0b_c042a4aa4aa1",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											classname = "MEImage",
											dstBlendFunc = "771",
											height = "121",
											ignoreSize = "True",
											name = "Image_gift_bg",
											scaleX = "0.8",
											scaleY = "0.8",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											texturePath = "ui/fairy_particle/6.png",
											touchAble = "True",
											UILayoutViewModel = 
											{
												
											},
											width = "136",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "Image_gift_item_Image_gift_bg_Panel_gift_5_Panel_tree_Panel_root_Panel-agoraLotteryView_Layer1_agora_Game",
													UUID = "64c5fae0_d790_40c2_98ff_8dd904525169",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0.5",
													backGroundScale9Enable = "False",
													classname = "MEImage",
													dstBlendFunc = "771",
													height = "111",
													ignoreSize = "True",
													name = "Image_gift_item",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "1",
													texturePath = "icon/equipment/icon/192_166/icon3_jichu_1.png",
													touchAble = "False",
													UILayoutViewModel = 
													{
														
													},
													width = "126",
													ZOrder = "1",
												},
											},
										},
										{
											controlID = "Image_getted_Panel_gift_5_Panel_tree_Panel_root_Panel-agoraLotteryView_Layer1_agora_Game",
											UUID = "5c018eae_cec1_4ccb_8aa3_4d4dfc8c3602",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											classname = "MEImage",
											dstBlendFunc = "771",
											height = "71",
											ignoreSize = "True",
											name = "Image_getted",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											texturePath = "ui/agora/summon/geted_bg.png",
											touchAble = "False",
											UILayoutViewModel = 
											{
												
											},
											width = "71",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "Label_geted_Image_getted_Panel_gift_5_Panel_tree_Panel_root_Panel-agoraLotteryView_Layer1_agora_Game",
													UUID = "84671ec1_8956_4862_a6e7_4d28da456ade",
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
														IsStroke = true,
														StrokeColor = "#FF5C628E",
														StrokeSize = 2,
													},
													height = "29",
													ignoreSize = "True",
													name = "Label_geted",
													nTextAlign = "1",
													nTextHAlign = "1",
													rotation = "-30",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "770",
													text = "ได้รับ",
													touchAble = "False",
													touchScaleEnable = "False",
													UILayoutViewModel = 
													{
														
													},
													width = "65",
													ZOrder = "1",
												},
											},
										},
									},
								},
								{
									controlID = "Panel_gift_6_Panel_tree_Panel_root_Panel-agoraLotteryView_Layer1_agora_Game",
									UUID = "b6fa431e_9b30_4bd7_b5ea_8e1dc87bc9c8",
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
									height = "121",
									ignoreSize = "False",
									name = "Panel_gift_6",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = 79,
										PositionY = -123,
									},
									uipanelviewmodel = 
									{
										Layout="Absolute",
										nType = "0"
									},
									width = "136",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "Image_gift_bg_Panel_gift_6_Panel_tree_Panel_root_Panel-agoraLotteryView_Layer1_agora_Game",
											UUID = "69b1f6d7_07c3_4c11_8299_b349b21b8692",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											classname = "MEImage",
											dstBlendFunc = "771",
											height = "121",
											ignoreSize = "True",
											name = "Image_gift_bg",
											scaleX = "0.8",
											scaleY = "0.8",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											texturePath = "ui/fairy_particle/6.png",
											touchAble = "True",
											UILayoutViewModel = 
											{
												
											},
											width = "136",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "Image_gift_item_Image_gift_bg_Panel_gift_6_Panel_tree_Panel_root_Panel-agoraLotteryView_Layer1_agora_Game",
													UUID = "76efafaa_f9af_4bf9_ae0c_f641acc7a1f5",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0.5",
													backGroundScale9Enable = "False",
													classname = "MEImage",
													dstBlendFunc = "771",
													height = "111",
													ignoreSize = "True",
													name = "Image_gift_item",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "1",
													texturePath = "icon/equipment/icon/192_166/icon3_jichu_1.png",
													touchAble = "False",
													UILayoutViewModel = 
													{
														
													},
													width = "126",
													ZOrder = "1",
												},
											},
										},
										{
											controlID = "Image_getted_Panel_gift_6_Panel_tree_Panel_root_Panel-agoraLotteryView_Layer1_agora_Game",
											UUID = "4a320f3d_1afa_4b90_9d4f_6b258820cad0",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											classname = "MEImage",
											dstBlendFunc = "771",
											height = "71",
											ignoreSize = "True",
											name = "Image_getted",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											texturePath = "ui/agora/summon/geted_bg.png",
											touchAble = "False",
											UILayoutViewModel = 
											{
												
											},
											width = "71",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "Label_geted_Image_getted_Panel_gift_6_Panel_tree_Panel_root_Panel-agoraLotteryView_Layer1_agora_Game",
													UUID = "041a4932_9605_4d48_9c09_2105a1489cbf",
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
														IsStroke = true,
														StrokeColor = "#FF5C628E",
														StrokeSize = 2,
													},
													height = "29",
													ignoreSize = "True",
													name = "Label_geted",
													nTextAlign = "1",
													nTextHAlign = "1",
													rotation = "-30",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "770",
													text = "ได้รับ",
													touchAble = "False",
													touchScaleEnable = "False",
													UILayoutViewModel = 
													{
														
													},
													width = "65",
													ZOrder = "1",
												},
											},
										},
									},
								},
							},
						},
						{
							controlID = "panel_effect_Panel_root_Panel-agoraLotteryView_Layer1_agora_Game",
							UUID = "5c2f2bf7_294d_4373_a9ff_b482f88bdd2c",
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
							name = "panel_effect",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							touchAble = "False",
							UILayoutViewModel = 
							{
								PositionX = -97,
								PositionY = -225,
								relativeToName = "Panel",
								nGravity = 6,
								nAlign = 5
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
									controlID = "Spine_snowflake_panel_effect_Panel_root_Panel-agoraLotteryView_Layer1_agora_Game",
									UUID = "1d7db853_e8db_4b34_9b35_c798a09abb94",
									classname = "MESpine",
									dstBlendFunc = "771",
									name = "Spine_snowflake",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									spineModel = 
									{
										SpinePath = "effect/effect_ui19_1/effect_ui19_1",
										animationName = "animation",
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
										PositionX = 159,
										PositionY = 129,
										LeftPositon = 661,
										TopPosition = 264,
										relativeToName = "Panel",
									},
									ZOrder = "1",
								},
								{
									controlID = "Spine_agoraLotteryView_1_panel_effect_Panel_root_Panel-agoraLotteryView_Layer1_agora_Game",
									UUID = "b6c49bb1_a5cf_4b23_98a4_82c65a093481",
									classname = "MESpine",
									dstBlendFunc = "771",
									name = "Spine_agoraLotteryView_1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									spineModel = 
									{
										SpinePath = "effect/effect_ui19/effect_ui19",
										animationName = "animation",
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
										PositionX = 241,
										PositionY = 296,
										relativeToName = "Panel",
									},
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
			"ui/agora/summon/summon_bg.png",
			"ui/agora/summon/btn_blue.png",
			"ui/agora/summon/text_bg.png",
			"icon/item/goods/510217.png",
			"ui/agora/summon/btn_red.png",
			"ui/summon/022.png",
			"ui/summon/002.png",
			"ui/summon/001.png",
			"ui/agora/compose/8.png",
			"ui/agora/summon/flash.png",
			"ui/common/frame_blue.png",
			"icon/equipment/icon/192_166/icon3_jichu_1.png",
			"ui/agora/summon/geted_bg.png",
			"ui/fairy_particle/6.png",
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

