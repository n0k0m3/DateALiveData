local t = 
{
	version = 1,
	components = 
	{
		
		{
			controlID = "Panel-sxBirthdayRewardView_Layer1_activity_Game",
			UUID = "3304c289_1905_4903_8230_d29042d973e5",
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
					controlID = "Panel_root_Panel-sxBirthdayRewardView_Layer1_activity_Game",
					UUID = "a701749a_86bd_47d2_becf_055a7bd671cf",
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
						PositionX = 480,
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
							controlID = "Image_bg_Panel_root_Panel-sxBirthdayRewardView_Layer1_activity_Game",
							UUID = "5481dcfd_a6a7_42bf_9eea_75b76c2363b4",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							backGroundScale9Enable = "False",
							classname = "MEImage",
							dstBlendFunc = "771",
							height = "496",
							ignoreSize = "True",
							name = "Image_bg",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							texturePath = "ui/activity/sx_birthday/wheel/5.png",
							touchAble = "False",
							UILayoutViewModel = 
							{
								LeftPositon = 927,
								TopPosition = -32,
								relativeToName = "Panel",
							},
							width = "378",
							ZOrder = "1",
						},
						{
							controlID = "Image_content_Panel_root_Panel-sxBirthdayRewardView_Layer1_activity_Game",
							UUID = "8768dab7_4011_40d8_b379_dc30e69eccff",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							backGroundScale9Enable = "False",
							classname = "MEImage",
							dstBlendFunc = "771",
							height = "357",
							ignoreSize = "True",
							name = "Image_content",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "770",
							texturePath = "ui/activity/sx_birthday/wheel/4-1.png",
							touchAble = "True",
							UILayoutViewModel = 
							{
								PositionY = 18,
							},
							width = "356",
							ZOrder = "1",
							components = 
							{
								
								{
									controlID = "Button_close_Image_content_Panel_root_Panel-sxBirthdayRewardView_Layer1_activity_Game",
									UUID = "2590c85b_6396_447a_b915_1d2d51911f4c",
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
										PositionY = 202,
									},
									UItype = "Button",
									width = "60",
									ZOrder = "1",
								},
								{
									controlID = "Label_title_Image_content_Panel_root_Panel-sxBirthdayRewardView_Layer1_activity_Game",
									UUID = "a3b671a3_d2fd_4dfc_ae97_f6a9375eba4f",
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
									text = "事件名称文字",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionX = -174,
										PositionY = 200,
									},
									width = "169",
									ZOrder = "1",
								},
								{
									controlID = "Image_head_Image_content_Panel_root_Panel-sxBirthdayRewardView_Layer1_activity_Game",
									UUID = "6a054430_35f6_45dd_8095_5d29d6adbbbc",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "146",
									ignoreSize = "True",
									name = "Image_head",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/activity/sx_birthday/wheel/4-3.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionY = 91,
									},
									width = "147",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "Image_icon_Image_head_Image_content_Panel_root_Panel-sxBirthdayRewardView_Layer1_activity_Game",
											UUID = "9e547274_37ab_45b5_a2fc_51f5d3cd5a42",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											classname = "MEImage",
											dstBlendFunc = "771",
											height = "64",
											ignoreSize = "True",
											name = "Image_icon",
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
									},
								},
								{
									controlID = "Label_desc_Image_content_Panel_root_Panel-sxBirthdayRewardView_Layer1_activity_Game",
									UUID = "70313671_e7fc_48f1_aa2a_cfae616bfeef",
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
									text = "事件说明",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionY = -27,
									},
									width = "312",
									ZOrder = "1",
								},
								{
									controlID = "Image_reward_Image_content_Panel_root_Panel-sxBirthdayRewardView_Layer1_activity_Game",
									UUID = "da628546_7b98_49fb_b22b_d3e433bb4510",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "92",
									ignoreSize = "True",
									name = "Image_reward",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/activity/sx_birthday/wheel/4-2.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionY = -122,
									},
									width = "335",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "ScrollView_reward_Image_reward_Image_content_Panel_root_Panel-sxBirthdayRewardView_Layer1_activity_Game",
											UUID = "28febaaf_3915_4a53_80f6_982209bbe3d8",
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
								{
									controlID = "Button_receive_Image_content_Panel_root_Panel-sxBirthdayRewardView_Layer1_activity_Game",
									UUID = "3ddde2b1_6788_4031_b6f6_421e713c83c5",
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
										PositionY = -223,
									},
									UItype = "Button",
									width = "124",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "Label_receive_Button_receive_Image_content_Panel_root_Panel-sxBirthdayRewardView_Layer1_activity_Game",
											UUID = "3bbf9590_09ff_4d72_b767_05ee48cedb1c",
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
											fontSize = "26",
											fontStroke = 
											{
												IsStroke = false,
												StrokeColor = "#FFE6E6E6",
												StrokeSize = 1,
											},
											height = "30",
											ignoreSize = "True",
											name = "Label_receive",
											nTextAlign = "1",
											nTextHAlign = "1",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "770",
											text = "领取",
											touchAble = "False",
											touchScaleEnable = "False",
											UILayoutViewModel = 
											{
												
											},
											width = "55",
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
			"ui/activity/sx_birthday/wheel/5.png",
			"ui/activity/sx_birthday/wheel/4-1.png",
			"ui/common/pop_ui/pop_btn_02.png",
			"ui/activity/sx_birthday/wheel/4-3.png",
			"ui/activity/sx_birthday/wheel/4-2.png",
			"ui/common/button_middle_n.png",
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

