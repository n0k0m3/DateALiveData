local t = 
{
	version = 1,
	components = 
	{
		
		{
			controlID = "Panel-chronoCrossConfirmView_Layer1_chronoCross_Game",
			UUID = "d4911d75_e2ff_4604_869b_d35803c73dfb",
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
					controlID = "Panel_root_Panel-chronoCrossConfirmView_Layer1_chronoCross_Game",
					UUID = "3765e95e_a7b3_4e46_84f3_57e1d6af293f",
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
							controlID = "Image_content_Panel_root_Panel-chronoCrossConfirmView_Layer1_chronoCross_Game",
							UUID = "fdbe8cfc_3fcf_497b_a138_81e6dec20dac",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							backGroundScale9Enable = "True;capInsetsX:0;capInsetsY:0;capInsetsWidth:0;capInsetsHeight:0",
							classname = "MEImage",
							dstBlendFunc = "771",
							height = "497",
							ignoreSize = "False",
							name = "Image_content",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							texturePath = "ui/common/pop_ui/pop_bg_01.png",
							touchAble = "False",
							UILayoutViewModel = 
							{
								PositionY = -18,
							},
							width = "378",
							ZOrder = "1",
							components = 
							{
								
								{
									controlID = "Image_dfwEventView_1_Image_content_Panel_root_Panel-chronoCrossConfirmView_Layer1_chronoCross_Game",
									UUID = "ecc454e9_83f2_4394_8141_d5955d55234c",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "374",
									ignoreSize = "True",
									name = "Image_dfwEventView_1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/ChronoCros/confirm/a2.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionY = 11,
									},
									width = "362",
									ZOrder = "1",
								},
								{
									controlID = "Button_receive_Image_content_Panel_root_Panel-chronoCrossConfirmView_Layer1_chronoCross_Game",
									UUID = "a48364e8_83d1_46c6_9126_e0c8cada2bda",
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
										PositionX = 100,
										PositionY = -198,
									},
									UItype = "Button",
									width = "124",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "Label_receive_Button_receive_Image_content_Panel_root_Panel-chronoCrossConfirmView_Layer1_chronoCross_Game",
											UUID = "a769943d_2502_4b08_b71e_49f0546f0451",
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
											fontSize = "24",
											fontStroke = 
											{
												IsStroke = false,
												StrokeColor = "#FFE6E6E6",
												StrokeSize = 1,
											},
											height = "27",
											ignoreSize = "True",
											name = "Label_receive",
											nTextAlign = "1",
											nTextHAlign = "1",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "770",
											text = "確認洗練將消耗洗練材料，並返還90%材料",
											touchAble = "False",
											touchScaleEnable = "False",
											UILayoutViewModel = 
											{
												
											},
											width = "95",
											ZOrder = "1",
										},
									},
								},
								{
									controlID = "Button_close_Image_content_Panel_root_Panel-chronoCrossConfirmView_Layer1_chronoCross_Game",
									UUID = "aec81f0b_0f6f_4712_8039_606c4e411c85",
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
										PositionX = 155,
										PositionY = 220,
									},
									UItype = "Button",
									width = "60",
									ZOrder = "1",
								},
								{
									controlID = "Label_title_Image_content_Panel_root_Panel-chronoCrossConfirmView_Layer1_chronoCross_Game",
									UUID = "8e3454c8_c1b7_470f_8f5b_a196e0b8697a",
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
									text = "事件名稱文字",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionX = -174,
										PositionY = 218,
									},
									width = "169",
									ZOrder = "1",
								},
								{
									controlID = "Image_dating_bg_Image_content_Panel_root_Panel-chronoCrossConfirmView_Layer1_chronoCross_Game",
									UUID = "e8311910_35db_456a_8df6_74e79f621beb",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "196",
									ignoreSize = "True",
									name = "Image_dating_bg",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/ChronoCros/confirm/024.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionY = 101,
									},
									visible = "False",
									width = "284",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "Image_dating_Image_dating_bg_Image_content_Panel_root_Panel-chronoCrossConfirmView_Layer1_chronoCross_Game",
											UUID = "6d533351_6fe8_4da9_acba_1102ec6d5adc",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											classname = "MEImage",
											dstBlendFunc = "771",
											height = "64",
											ignoreSize = "True",
											name = "Image_dating",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "False",
											UILayoutViewModel = 
											{
												
											},
											width = "64",
											ZOrder = "1",
										},
										{
											controlID = "Image_up_Image_dating_bg_Image_content_Panel_root_Panel-chronoCrossConfirmView_Layer1_chronoCross_Game",
											UUID = "586af2e8_8d5b_4748_977a_2349c4769185",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											classname = "MEImage",
											dstBlendFunc = "771",
											height = "170",
											ignoreSize = "True",
											name = "Image_up",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											texturePath = "ui/ChronoCros/confirm/023.png",
											touchAble = "False",
											UILayoutViewModel = 
											{
												
											},
											width = "262",
											ZOrder = "1",
										},
										{
											controlID = "Label_dating_desc_Image_dating_bg_Image_content_Panel_root_Panel-chronoCrossConfirmView_Layer1_chronoCross_Game",
											UUID = "198489be_adaf_45ce_9718_9945686a7449",
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
											height = "80",
											ignoreSize = "False",
											name = "Label_dating_desc",
											nTextAlign = "0",
											nTextHAlign = "0",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "770",
											text = "事件說明",
											touchAble = "False",
											touchScaleEnable = "False",
											UILayoutViewModel = 
											{
												PositionY = -143,
											},
											width = "312",
											ZOrder = "1",
										},
									},
								},
								{
									controlID = "Image_sepcial_Image_content_Panel_root_Panel-chronoCrossConfirmView_Layer1_chronoCross_Game",
									UUID = "094ecfe1_1539_4bf6_976b_615f53954943",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "174",
									ignoreSize = "True",
									name = "Image_sepcial",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/ChronoCros/confirm/a1.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionY = 112,
									},
									width = "174",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "Label_desc_Image_sepcial_Image_content_Panel_root_Panel-chronoCrossConfirmView_Layer1_chronoCross_Game",
											UUID = "e0531298_498d_4f68_9a6e_3b2d792a528a",
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
											height = "80",
											ignoreSize = "False",
											name = "Label_desc",
											nTextAlign = "0",
											nTextHAlign = "0",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "770",
											text = "事件說明",
											touchAble = "False",
											touchScaleEnable = "False",
											UILayoutViewModel = 
											{
												PositionY = -128,
											},
											width = "312",
											ZOrder = "1",
										},
										{
											controlID = "ClippingNode_player_Image_sepcial_Image_content_Panel_root_Panel-chronoCrossConfirmView_Layer1_chronoCross_Game",
											UUID = "5a91914a_40ee_47bb_82e4_70937300e84b",
											alphaThreshold = "0.65",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											classname = "MEClippingNode",
											clipNodeX = "0",
											clipNodeY = "0",
											dstBlendFunc = "771",
											height = "0",
											ignoreSize = "False",
											name = "ClippingNode_player",
											scaleX = "0.85",
											scaleY = "0.85",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											stencilPath = "ui/iphoneX/new/011.png",
											touchAble = "False",
											UILayoutViewModel = 
											{
												
											},
											width = "0",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "Image_icon_ClippingNode_player_Image_sepcial_Image_content_Panel_root_Panel-chronoCrossConfirmView_Layer1_chronoCross_Game",
													UUID = "a084be06_7df3_4700_8348_fea598e8bb9a",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0.5",
													backGroundScale9Enable = "False",
													classname = "MEImage",
													dstBlendFunc = "771",
													height = "106",
													ignoreSize = "True",
													name = "Image_icon",
													scaleX = "1.3",
													scaleY = "1.3",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "1",
													texturePath = "icon/equipment/icon/106_106/icon1_yange_3.png",
													touchAble = "False",
													UILayoutViewModel = 
													{
														
													},
													width = "106",
													ZOrder = "1",
												},
											},
										},
									},
								},
								{
									controlID = "Image_reward_Image_content_Panel_root_Panel-chronoCrossConfirmView_Layer1_chronoCross_Game",
									UUID = "2fab25b6_a7ce_41f2_a80f_751e3ec9aa29",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "97",
									ignoreSize = "True",
									name = "Image_reward",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/dawuwong/event/DFW_TK_bg3.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionY = -111,
									},
									width = "323",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "ScrollView_reward_Image_reward_Image_content_Panel_root_Panel-chronoCrossConfirmView_Layer1_chronoCross_Game",
											UUID = "9a193f64_b5ea_4ffa_8efa_b506428c9aa2",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											bgColorOpacity = "50",
											bIsOpenClipping = "True",
											bounceEnable = "False",
											classname = "MEScrollView",
											colorType = "0;SingleColor:#FFE6E6E6;GraduallyChangingColorStart:#FFFFFFFF;GraduallyChangingColorEnd:#FFFFFFFF;vectorX:0;vectorY:0",
											direction = "2",
											dstBlendFunc = "771",
											height = "90",
											ignoreSize = "False",
											innerHeight = "90",
											innerWidth = "270",
											name = "ScrollView_reward",
											showScrollbar = "False",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "True",
											UILayoutViewModel = 
											{
												
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "270",
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
			"ui/common/pop_ui/pop_bg_01.png",
			"ui/ChronoCros/confirm/a2.png",
			"ui/common/button_middle_n.png",
			"ui/common/pop_ui/pop_btn_02.png",
			"ui/ChronoCros/confirm/024.png",
			"ui/ChronoCros/confirm/023.png",
			"ui/ChronoCros/confirm/a1.png",
			"icon/equipment/icon/106_106/icon1_yange_3.png",
			"ui/dawuwong/event/DFW_TK_bg3.png",
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

