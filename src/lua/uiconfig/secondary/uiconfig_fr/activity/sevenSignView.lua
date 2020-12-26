local t = 
{
	version = 1,
	components = 
	{
		
		{
			controlID = "Panel-sevenSignView_Layer1_activity_Game",
			UUID = "555f2b06_8b75_4225_b08e_0ae49b4793c9",
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
					controlID = "Panel_root_Panel-sevenSignView_Layer1_activity_Game",
					UUID = "191cee83_4765_4cea_889e_836adb0881ad",
					anchorPoint = "False",
					anchorPointX = "0.5",
					anchorPointY = "0.5",
					backGroundScale9Enable = "False",
					bgColorOpacity = "50",
					bIsOpenClipping = "False",
					classname = "MEPanel",
					colorType = "0;SingleColor:#FFFF0000;GraduallyChangingColorStart:#FFFFFFFF;GraduallyChangingColorEnd:#FFFFFFFF;vectorX:0;vectorY:0",
					DesignHeight = "640",
					DesignType = "0",
					DesignWidth = "960",
					dstBlendFunc = "771",
					height = "640",
					ignoreSize = "False",
					name = "Panel_root",
					sizepercentx = "100",
					sizepercenty = "100",
					sizeType = "1",
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
							controlID = "Image_content_Panel_root_Panel-sevenSignView_Layer1_activity_Game",
							UUID = "5036f7da_ba92_4582_8f0e_c521bfbcaff3",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							backGroundScale9Enable = "False",
							classname = "MEImage",
							dstBlendFunc = "771",
							height = "538",
							ignoreSize = "True",
							name = "Image_content",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							texturePath = "ui/fuli/seven_sign/001.png",
							touchAble = "True",
							UILayoutViewModel = 
							{
								
							},
							width = "1006",
							ZOrder = "1",
							components = 
							{
								
								{
									controlID = "ScrollView_reward_Image_content_Panel_root_Panel-sevenSignView_Layer1_activity_Game",
									UUID = "3ee86138_58f7_4f79_9d94_7fab3e7a02b6",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									bgColorOpacity = "50",
									bIsOpenClipping = "False",
									bounceEnable = "False",
									classname = "MEScrollView",
									colorType = "0;SingleColor:#FF0000FF;GraduallyChangingColorStart:#FFFFFFFF;GraduallyChangingColorEnd:#FFFFFFFF;vectorX:0;vectorY:0",
									direction = "2",
									dstBlendFunc = "771",
									height = "80",
									ignoreSize = "False",
									innerHeight = "80",
									innerWidth = "760",
									name = "ScrollView_reward",
									showScrollbar = "False",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = -98,
										PositionY = -180,
									},
									uipanelviewmodel = 
									{
										Layout="Absolute",
										nType = "0"
									},
									width = "760",
									ZOrder = "1",
								},
								{
									controlID = "Button_sevenReceive_Image_content_Panel_root_Panel-sevenSignView_Layer1_activity_Game",
									UUID = "ee5fe353_19f7_4422_8c37_fade5b53984d",
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
									name = "Button_sevenReceive",
									normal = "ui/common/button_middle_n.png",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "True",
									UILayoutViewModel = 
									{
										PositionX = 394,
										PositionY = -196,
									},
									UItype = "Button",
									width = "124",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "Label_signInReceive_Button_sevenReceive_Image_content_Panel_root_Panel-sevenSignView_Layer1_activity_Game",
											UUID = "e9e54870_b898_499d_ad23_a91d292da539",
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
											height = "23",
											ignoreSize = "True",
											name = "Label_signInReceive",
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
											width = "101",
											ZOrder = "1",
										},
									},
								},
								{
									controlID = "Button_seven_raiders_left_Image_content_Panel_root_Panel-sevenSignView_Layer1_activity_Game",
									UUID = "26851aeb_4975_4e1a_9750_e08d28ba68df",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEButton",
									ClickHighLightEnabled = "True",
									dstBlendFunc = "771",
									flipX = "False",
									flipY = "False",
									height = "72",
									ignoreSize = "True",
									name = "Button_seven_raiders_left",
									normal = "ui/fuli/seven_sign/002.png",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "True",
									UILayoutViewModel = 
									{
										PositionX = -450,
										PositionY = 1,
									},
									UItype = "Button",
									width = "64",
									ZOrder = "1",
								},
								{
									controlID = "Button_seven_raiders_right_Image_content_Panel_root_Panel-sevenSignView_Layer1_activity_Game",
									UUID = "fd5e89c2_8364_4739_af67_162dd513e01e",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEButton",
									ClickHighLightEnabled = "True",
									dstBlendFunc = "771",
									flipX = "False",
									flipY = "False",
									height = "72",
									ignoreSize = "True",
									name = "Button_seven_raiders_right",
									normal = "ui/fuli/seven_sign/002.png",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "True",
									UILayoutViewModel = 
									{
										PositionX = 420,
										PositionY = 2,
									},
									UItype = "Button",
									width = "64",
									ZOrder = "1",
								},
								{
									controlID = "Button_close_Image_content_Panel_root_Panel-sevenSignView_Layer1_activity_Game",
									UUID = "080ddcc9_3279_4c19_811f_d2fd70092750",
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
										PositionX = 449,
										PositionY = 237,
									},
									UItype = "Button",
									width = "60",
									ZOrder = "1",
								},
							},
						},
					},
				},
				{
					controlID = "Panel_prefab_Panel-sevenSignView_Layer1_activity_Game",
					UUID = "4a02c86a_1e9c_4dd4_bf2e_f7df631e61ab",
					anchorPoint = "False",
					anchorPointX = "0.5",
					anchorPointY = "0.5",
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
					sizepercentx = "0",
					sizepercenty = "0",
					sizeType = "0",
					srcBlendFunc = "1",
					touchAble = "False",
					UILayoutViewModel = 
					{
						PositionX = 560,
						PositionY = -425,
						LeftPositon = -8,
						TopPosition = 745,
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
							controlID = "Panel_sevenItem_Panel_prefab_Panel-sevenSignView_Layer1_activity_Game",
							UUID = "0bba9b12_45e1_47ba_b0ed_7c4bc021eb72",
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
							height = "77",
							ignoreSize = "False",
							name = "Panel_sevenItem",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							touchAble = "False",
							UILayoutViewModel = 
							{
								PositionX = -286,
								PositionY = 176,
							},
							uipanelviewmodel = 
							{
								Layout="Absolute",
								nType = "0"
							},
							width = "77",
							ZOrder = "1",
							components = 
							{
								
								{
									controlID = "Panel_reward_Panel_sevenItem_Panel_prefab_Panel-sevenSignView_Layer1_activity_Game",
									UUID = "f577e4da_aabe_49b6_ae32_4ad576ea2898",
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
									height = "77",
									ignoreSize = "False",
									name = "Panel_reward",
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
									width = "77",
									ZOrder = "1",
								},
								{
									controlID = "Image_cur_day_Panel_sevenItem_Panel_prefab_Panel-sevenSignView_Layer1_activity_Game",
									UUID = "8660a12c_0d7d_45a3_8686_29c7e891c64a",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "32",
									ignoreSize = "True",
									name = "Image_cur_day",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/activity/recharge/LXCZ_baoxiang_4.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = 3,
										PositionY = -60,
									},
									width = "66",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "Label_cur_day_Image_cur_day_Panel_sevenItem_Panel_prefab_Panel-sevenSignView_Layer1_activity_Game",
											UUID = "40ecad3e_ae25_4b72_a1a3_20563fcc6349",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											classname = "MELabel",
											compPath = "luacomponents.common.MEIconLabel",
											dstBlendFunc = "771",
											FontColor = "#FF4A5680",
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
											name = "Label_cur_day",
											nTextAlign = "1",
											nTextHAlign = "1",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "770",
											text = "Day1",
											touchAble = "False",
											touchScaleEnable = "False",
											UILayoutViewModel = 
											{
												PositionY = -2,
											},
											width = "37",
											ZOrder = "1",
										},
									},
								},
								{
									controlID = "Label_day_Panel_sevenItem_Panel_prefab_Panel-sevenSignView_Layer1_activity_Game",
									UUID = "3d75c3da_6377_4675_bf57_8f97f371bb4c",
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
									fontSize = "18",
									fontStroke = 
									{
										IsStroke = false,
										StrokeColor = "#FFE6E6E6",
										StrokeSize = 1,
									},
									height = "21",
									ignoreSize = "True",
									name = "Label_day",
									nTextAlign = "1",
									nTextHAlign = "1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "Day1",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionX = 2,
										PositionY = -62,
									},
									width = "37",
									ZOrder = "1",
								},
								{
									controlID = "Image_gray_Panel_sevenItem_Panel_prefab_Panel-sevenSignView_Layer1_activity_Game",
									UUID = "42728d7e_d24c_45b7_b3b7_b32c5bc0aa7d",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "True;capInsetsX:0;capInsetsY:0;capInsetsWidth:0;capInsetsHeight:0",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "77",
									ignoreSize = "False",
									name = "Image_gray",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/fuli/item_gray.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										
									},
									width = "77",
									ZOrder = "1",
								},
								{
									controlID = "Image_gou_Panel_sevenItem_Panel_prefab_Panel-sevenSignView_Layer1_activity_Game",
									UUID = "bb3b4806_2630_4876_bdf7_909ac44a3b1c",
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
										
									},
									width = "54",
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
			"ui/fuli/seven_sign/001.png",
			"ui/common/button_middle_n.png",
			"ui/fuli/seven_sign/002.png",
			"ui/common/pop_ui/pop_btn_02.png",
			"ui/activity/recharge/LXCZ_baoxiang_4.png",
			"ui/fuli/item_gray.png",
			"ui/fuli/item_gou.png",
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

