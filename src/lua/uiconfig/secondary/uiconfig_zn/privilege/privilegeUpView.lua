local t = 
{
	version = 1,
	components = 
	{
		
		{
			controlID = "Panel-privilegeUpView_Layer1_privilege_Game",
			UUID = "83af39c7_6994_4c49_9c82_b0a701d49850",
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
			height = "450",
			ignoreSize = "False",
			name = "Panel",
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
			width = "900",
			ZOrder = "1",
			components = 
			{
				
				{
					controlID = "Panel_root_Panel-privilegeUpView_Layer1_privilege_Game",
					UUID = "fd0d9615_d426_4a8b_9a69_0b1f399d61cc",
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
					height = "450",
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
					width = "900",
					ZOrder = "1",
					components = 
					{
						
						{
							controlID = "ScrollView_priviledge_Panel_root_Panel-privilegeUpView_Layer1_privilege_Game",
							UUID = "aa0b8197_599e_4001_b3b2_b6d37b5c5cff",
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
							height = "370",
							ignoreSize = "False",
							innerHeight = "370",
							innerWidth = "894",
							name = "ScrollView_priviledge",
							showScrollbar = "False",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							touchAble = "True",
							UILayoutViewModel = 
							{
								PositionX = -448,
								PositionY = -146,
								LeftPositon = 130,
								TopPosition = 6,
								relativeToName = "Panel_root",
							},
							uipanelviewmodel = 
							{
								Layout="Absolute",
								nType = "0"
							},
							width = "894",
							ZOrder = "1",
						},
						{
							controlID = "Image_up_cost_Panel_root_Panel-privilegeUpView_Layer1_privilege_Game",
							UUID = "c47bc844_9e11_4e52_9d8b_fe6105fcf9eb",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							backGroundScale9Enable = "True;capInsetsX:0;capInsetsY:0;capInsetsWidth:0;capInsetsHeight:0",
							classname = "MEImage",
							dstBlendFunc = "771",
							height = "56",
							ignoreSize = "False",
							name = "Image_up_cost",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							texturePath = "ui/fuben/cost_diban.png",
							touchAble = "True",
							UILayoutViewModel = 
							{
								PositionX = 78,
								PositionY = -190,
								LeftPositon = 411,
								TopPosition = 402,
								relativeToName = "Panel_root",
							},
							width = "138",
							ZOrder = "1",
							components = 
							{
								
								{
									controlID = "Image_cost_icon_Image_up_cost_Panel_root_Panel-privilegeUpView_Layer1_privilege_Game",
									UUID = "8ab54d32_90b4_4ac1_92dc_8d4ad0073d46",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "100",
									ignoreSize = "True",
									name = "Image_cost_icon",
									scaleX = "0.4",
									scaleY = "0.4",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "icon/system/003.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = -46,
									},
									width = "100",
									ZOrder = "1",
								},
								{
									controlID = "Label_cost_num_Image_up_cost_Panel_root_Panel-privilegeUpView_Layer1_privilege_Game",
									UUID = "c6a134e1_ecb6_4fda_ad9e_491b24a64a7f",
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
									fontSize = "22",
									fontStroke = 
									{
										IsStroke = false,
										StrokeColor = "#FFE6E6E6",
										StrokeSize = 1,
									},
									height = "25",
									ignoreSize = "True",
									name = "Label_cost_num",
									nTextAlign = "1",
									nTextHAlign = "1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "100-1000",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionX = 63,
									},
									width = "92",
									ZOrder = "1",
								},
								{
									controlID = "Button_up_Image_up_cost_Panel_root_Panel-privilegeUpView_Layer1_privilege_Game",
									UUID = "0a5deb53_8f31_4cc3_b489_8902d843c4d9",
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
									name = "Button_up",
									normal = "ui/activity/znq_yly/privilege/008.png",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "True",
									UILayoutViewModel = 
									{
										PositionX = 149,
										PositionY = -2,
									},
									UItype = "Button",
									width = "137",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "Label_btn_Button_up_Image_up_cost_Panel_root_Panel-privilegeUpView_Layer1_privilege_Game",
											UUID = "60efe8d4_0041_4b7d_93f0_4b287bc9b63d",
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
											fontSize = "26",
											fontStroke = 
											{
												IsStroke = false,
												StrokeColor = "#FFE6E6E6",
												StrokeSize = 1,
											},
											height = "32",
											ignoreSize = "True",
											name = "Label_btn",
											nTextAlign = "1",
											nTextHAlign = "1",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "770",
											text = "升级",
											touchAble = "False",
											touchScaleEnable = "False",
											UILayoutViewModel = 
											{
												PositionY = -1,
											},
											width = "55",
											ZOrder = "1",
										},
									},
								},
								{
									controlID = "Button_check_Image_up_cost_Panel_root_Panel-privilegeUpView_Layer1_privilege_Game",
									UUID = "a9a9e376_7ac1_4304_8e14_571efe63462f",
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
									name = "Button_check",
									normal = "ui/activity/znq_yly/info/006.png",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "True",
									UILayoutViewModel = 
									{
										PositionX = 299,
										PositionY = -2,
										LeftPositon = 836,
										TopPosition = 392,
										relativeToName = "Panel_root",
									},
									UItype = "Button",
									width = "137",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "Label_privilegeUpView_1_Button_check_Image_up_cost_Panel_root_Panel-privilegeUpView_Layer1_privilege_Game",
											UUID = "94e4ed52_9218_46b7_b5b1_712b60bcf9ed",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											classname = "MELabel",
											compPath = "luacomponents.common.MEIconLabel",
											dstBlendFunc = "771",
											FontColor = "#FF737AC8",
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
											name = "Label_privilegeUpView_1",
											nTextAlign = "1",
											nTextHAlign = "1",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "770",
											text = "特权总览",
											touchAble = "False",
											touchScaleEnable = "False",
											UILayoutViewModel = 
											{
												
											},
											width = "107",
											ZOrder = "1",
										},
									},
								},
							},
						},
						{
							controlID = "Label_max_Panel_root_Panel-privilegeUpView_Layer1_privilege_Game",
							UUID = "fc0859ac_48a4_4fa3_8189_10203418ee08",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							classname = "MELabel",
							compPath = "luacomponents.common.MEIconLabel",
							dstBlendFunc = "771",
							FontColor = "#FF594E9E",
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
							name = "Label_max",
							nTextAlign = "1",
							nTextHAlign = "1",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "770",
							text = "已达到最大等级",
							touchAble = "False",
							touchScaleEnable = "False",
							UILayoutViewModel = 
							{
								PositionX = 344,
								PositionY = -192,
								LeftPositon = 656,
								TopPosition = 409,
								relativeToName = "Panel_root",
							},
							width = "172",
							ZOrder = "1",
						},
						{
							controlID = "Spine_level_up_tip_Panel_root_Panel-privilegeUpView_Layer1_privilege_Game",
							UUID = "c488c3cb_76c0_46d9_8a03_3b2093c51b12",
							classname = "MESpine",
							dstBlendFunc = "771",
							name = "Spine_level_up_tip",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							spineModel = 
							{
								SpinePath = "effect/effect_heroGrow_ui2/effect_heroGrow_ui2",
								animationName = "chuxian",
								IsLoop = false,
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
								PositionX = -31,
								PositionY = 57,
							},
							ZOrder = "10",
						},
					},
				},
				{
					controlID = "Panel_prefab_Panel-privilegeUpView_Layer1_privilege_Game",
					UUID = "75f7a177_c9b3_4714_aaab_f1bd36888ea6",
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
						PositionX = -894,
						PositionY = -1214,
						LeftPositon = -444,
						TopPosition = 989,
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
							controlID = "Panel_privilegeItem_Panel_prefab_Panel-privilegeUpView_Layer1_privilege_Game",
							UUID = "bdb9fdca_de7d_4ddf_9bce_2c785ee241cd",
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
							height = "69",
							ignoreSize = "False",
							name = "Panel_privilegeItem",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							touchAble = "False",
							UILayoutViewModel = 
							{
								PositionX = 450,
								PositionY = 299,
							},
							uipanelviewmodel = 
							{
								Layout="Absolute",
								nType = "0"
							},
							width = "894",
							ZOrder = "1",
							components = 
							{
								
								{
									controlID = "Image_cell_Panel_privilegeItem_Panel_prefab_Panel-privilegeUpView_Layer1_privilege_Game",
									UUID = "8ff5e3fc_71aa_4d7a_9bdf_b04b4210c6f2",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "69",
									ignoreSize = "False",
									name = "Image_cell",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/activity/znq_yly/privilege/005.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										
									},
									width = "894",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "Label_tip_Image_cell_Panel_privilegeItem_Panel_prefab_Panel-privilegeUpView_Layer1_privilege_Game",
											UUID = "55792cae_4c9f_4017_9cf2_0b107789ec4e",
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
											name = "Label_tip",
											nTextAlign = "1",
											nTextHAlign = "1",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "770",
											text = "已激活",
											touchAble = "False",
											touchScaleEnable = "False",
											UILayoutViewModel = 
											{
												PositionX = 392,
											},
											width = "75",
											ZOrder = "1",
										},
									},
								},
								{
									controlID = "Image_cell_bg_Panel_privilegeItem_Panel_prefab_Panel-privilegeUpView_Layer1_privilege_Game",
									UUID = "e4879ccc_1e5e_4c62_9694_81d165918547",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "69",
									ignoreSize = "True",
									name = "Image_cell_bg",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/activity/znq_yly/privilege/009.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										
									},
									width = "894",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "Label_tip_Image_cell_bg_Panel_privilegeItem_Panel_prefab_Panel-privilegeUpView_Layer1_privilege_Game",
											UUID = "f3bb8347_1cad_4b32_a27e_d8fa59bee3aa",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											classname = "MELabel",
											compPath = "luacomponents.common.MEIconLabel",
											dstBlendFunc = "771",
											FontColor = "#FF8DC8FF",
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
											name = "Label_tip",
											nTextAlign = "1",
											nTextHAlign = "1",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "770",
											text = "未激活",
											touchAble = "False",
											touchScaleEnable = "False",
											UILayoutViewModel = 
											{
												PositionX = 392,
											},
											width = "75",
											ZOrder = "1",
										},
									},
								},
								{
									controlID = "Label_info_Panel_privilegeItem_Panel_prefab_Panel-privilegeUpView_Layer1_privilege_Game",
									UUID = "9b75ae8b_9591_4cd6_a1ed_7cc42795e343",
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
									fontSize = "24",
									fontStroke = 
									{
										IsStroke = false,
										StrokeColor = "#FFE6E6E6",
										StrokeSize = 1,
									},
									height = "27",
									ignoreSize = "False",
									name = "Label_info",
									nTextAlign = "1",
									nTextHAlign = "0",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "TextLable",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionX = -254,
									},
									width = "490",
									ZOrder = "1",
								},
								{
									controlID = "Label_name_Panel_privilegeItem_Panel_prefab_Panel-privilegeUpView_Layer1_privilege_Game",
									UUID = "b9c660cf_a8ae_418b_80db_6e822c4cdcf6",
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
									fontSize = "24",
									fontStroke = 
									{
										IsStroke = false,
										StrokeColor = "#FFE6E6E6",
										StrokeSize = 1,
									},
									height = "27",
									ignoreSize = "True",
									name = "Label_name",
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
										PositionX = -429,
									},
									width = "95",
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
			"ui/fuben/cost_diban.png",
			"icon/system/003.png",
			"ui/activity/znq_yly/privilege/008.png",
			"ui/activity/znq_yly/info/006.png",
			"ui/activity/znq_yly/privilege/005.png",
			"ui/activity/znq_yly/privilege/009.png",
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

