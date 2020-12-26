local t = 
{
	version = 1,
	components = 
	{
		
		{
			controlID = "Panel-duanwuPop3_duanwu_activity_activity_Game",
			UUID = "1ead28ab_f1ee_44fb_abc6_c0956ef36a68",
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
			width = "1136",
			ZOrder = "1",
			components = 
			{
				
				{
					controlID = "Panel_base_Panel-duanwuPop3_duanwu_activity_activity_Game",
					UUID = "a3a36bce_2d36_4232_85f6_03e0e705a043",
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
							controlID = "Image_bg_Panel_base_Panel-duanwuPop3_duanwu_activity_activity_Game",
							UUID = "a08c300c_dc76_441f_a078_ad06ad8db314",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							backGroundScale9Enable = "False",
							classname = "MEImage",
							dstBlendFunc = "771",
							height = "321",
							ignoreSize = "True",
							name = "Image_bg",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							texturePath = "ui/activity/duanwu_mfdzz/pop/bg.png",
							touchAble = "True",
							UILayoutViewModel = 
							{
								PositionX = 578,
								PositionY = 321,
							},
							width = "537",
							ZOrder = "1",
						},
						{
							controlID = "Label_title_Panel_base_Panel-duanwuPop3_duanwu_activity_activity_Game",
							UUID = "7e008680_3bb4_4bd8_8bd3_51c9032ae224",
							anchorPoint = "False",
							anchorPointX = "0",
							anchorPointY = "0.5",
							classname = "MELabel",
							compPath = "luacomponents.common.MEIconLabel",
							dstBlendFunc = "771",
							FontColor = "#FF912325",
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
								IsStroke = false,
								StrokeColor = "#FFE6E6E6",
								StrokeSize = 1,
							},
							height = "37",
							ignoreSize = "True",
							name = "Label_title",
							nTextAlign = "1",
							nTextHAlign = "1",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "770",
							text = "Reminder",
							touchAble = "False",
							touchScaleEnable = "False",
							UILayoutViewModel = 
							{
								PositionX = 322,
								PositionY = 449,
							},
							width = "62",
							ZOrder = "1",
						},
						{
							controlID = "Button_close_Panel_base_Panel-duanwuPop3_duanwu_activity_activity_Game",
							UUID = "cf823a44_609a_44f8_9133_da11dbc31f1a",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							backGroundScale9Enable = "False",
							classname = "MEButton",
							ClickHighLightEnabled = "True",
							dstBlendFunc = "771",
							flipX = "False",
							flipY = "False",
							height = "28",
							ignoreSize = "True",
							name = "Button_close",
							normal = "ui/activity/duanwu_mfdzz/fortReady/close.png",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							touchAble = "True",
							UILayoutViewModel = 
							{
								PositionX = 816,
								PositionY = 453,
							},
							UItype = "Button",
							width = "28",
							ZOrder = "1",
						},
						{
							controlID = "Label_1_Panel_base_Panel-duanwuPop3_duanwu_activity_activity_Game",
							UUID = "35894e41_d7f7_49cf_812b_c150e91b57f1",
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
							fontSize = "22",
							fontStroke = 
							{
								IsStroke = false,
								StrokeColor = "#FFE6E6E6",
								StrokeSize = 1,
							},
							height = "51",
							ignoreSize = "False",
							name = "Label_1",
							nTextAlign = "0",
							nTextHAlign = "0",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "770",
							text = "Are you sure you want to borrow the support character of 　　　　　?",
							touchAble = "False",
							touchScaleEnable = "False",
							UILayoutViewModel = 
							{
								PositionX = 638,
								PositionY = 364,
							},
							width = "334",
							ZOrder = "1",
						},
						{
							controlID = "Label_2_Panel_base_Panel-duanwuPop3_duanwu_activity_activity_Game",
							UUID = "e97b2b19_48a7_4646_a596_8757af35cd39",
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
							fontSize = "22",
							fontStroke = 
							{
								IsStroke = false,
								StrokeColor = "#FFE6E6E6",
								StrokeSize = 1,
							},
							height = "25",
							ignoreSize = "True",
							name = "Label_2",
							nTextAlign = "0",
							nTextHAlign = "0",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "770",
							text = "Remaining support times",
							touchAble = "False",
							touchScaleEnable = "False",
							UILayoutViewModel = 
							{
								PositionX = 542,
								PositionY = 298,
							},
							width = "143",
							ZOrder = "1",
						},
						{
							controlID = "Label_player_Panel_base_Panel-duanwuPop3_duanwu_activity_activity_Game",
							UUID = "a2848aa1_bad6_40dc_8c6a_24fa49d6bf5c",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							classname = "MELabel",
							compPath = "luacomponents.common.MEIconLabel",
							dstBlendFunc = "771",
							FontColor = "#FFE79B17",
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
							name = "Label_player",
							nTextAlign = "1",
							nTextHAlign = "1",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "770",
							text = "Support character can be normal",
							touchAble = "False",
							touchScaleEnable = "False",
							UILayoutViewModel = 
							{
								PositionX = 680,
								PositionY = 376,
							},
							width = "157",
							ZOrder = "1",
						},
						{
							controlID = "Label_count_Panel_base_Panel-duanwuPop3_duanwu_activity_activity_Game",
							UUID = "ba8ff880_5f61_4011_9556_00180e4a1ecb",
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
							fontSize = "22",
							fontStroke = 
							{
								IsStroke = false,
								StrokeColor = "#FFE6E6E6",
								StrokeSize = 1,
							},
							height = "25",
							ignoreSize = "True",
							name = "Label_count",
							nTextAlign = "0",
							nTextHAlign = "0",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "770",
							text = "1 3",
							touchAble = "False",
							touchScaleEnable = "False",
							UILayoutViewModel = 
							{
								PositionX = 645,
								PositionY = 298,
							},
							width = "28",
							ZOrder = "1",
						},
						{
							controlID = "Button_cancel_Panel_base_Panel-duanwuPop3_duanwu_activity_activity_Game",
							UUID = "5541bc81_193e_478c_b9ac_292b6cf7b6f7",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							backGroundScale9Enable = "False",
							classname = "MEButton",
							ClickHighLightEnabled = "True",
							dstBlendFunc = "771",
							flipX = "False",
							flipY = "False",
							height = "63",
							ignoreSize = "True",
							name = "Button_cancel",
							normal = "ui/activity/duanwu_mfdzz/fortReady/button.png",
							scaleX = "0.8",
							scaleY = "0.8",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							touchAble = "True",
							UILayoutViewModel = 
							{
								PositionX = 389,
								PositionY = 199,
							},
							UItype = "Button",
							width = "139",
							ZOrder = "1",
							components = 
							{
								
								{
									controlID = "Label_btn_Button_cancel_Panel_base_Panel-duanwuPop3_duanwu_activity_activity_Game",
									UUID = "2d16dcfc_8b53_4cec_ae4c_341466667921",
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
									name = "Label_btn",
									nTextAlign = "1",
									nTextHAlign = "1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "Cancel",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										
									},
									width = "50",
									ZOrder = "1",
								},
							},
						},
						{
							controlID = "Button_sure_Panel_base_Panel-duanwuPop3_duanwu_activity_activity_Game",
							UUID = "13af67e7_acce_4969_8d6a_319e85ac45a5",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							backGroundScale9Enable = "False",
							classname = "MEButton",
							ClickHighLightEnabled = "True",
							dstBlendFunc = "771",
							flipX = "False",
							flipY = "False",
							height = "63",
							ignoreSize = "True",
							name = "Button_sure",
							normal = "ui/activity/duanwu_mfdzz/fortReady/button.png",
							scaleX = "0.8",
							scaleY = "0.8",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							touchAble = "True",
							UILayoutViewModel = 
							{
								PositionX = 770,
								PositionY = 198,
							},
							UItype = "Button",
							width = "139",
							ZOrder = "1",
							components = 
							{
								
								{
									controlID = "Label_btn_Button_sure_Panel_base_Panel-duanwuPop3_duanwu_activity_activity_Game",
									UUID = "a0b4c735_7e48_46ed_9638_4d62bc07d4b7",
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
									name = "Label_btn",
									nTextAlign = "1",
									nTextHAlign = "1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "Confirm",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										
									},
									width = "51",
									ZOrder = "1",
								},
							},
						},
						{
							controlID = "Image_4_Panel_base_Panel-duanwuPop3_duanwu_activity_activity_Game",
							UUID = "bee85788_923b_456c_a1fe_1f50f7c51680",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							backGroundScale9Enable = "True;capInsetsX:0;capInsetsY:0;capInsetsWidth:0;capInsetsHeight:0",
							classname = "MEImage",
							dstBlendFunc = "771",
							height = "53",
							ignoreSize = "False",
							name = "Image_4",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							texturePath = "ui/fuben/cost_diban.png",
							touchAble = "False",
							UILayoutViewModel = 
							{
								PositionX = 651,
								PositionY = 197,
							},
							width = "118",
							ZOrder = "1",
						},
						{
							controlID = "Label_3_Panel_base_Panel-duanwuPop3_duanwu_activity_activity_Game",
							UUID = "fc044805_e95c_41a4_8294_5c407a076ef0",
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
							name = "Label_3",
							nTextAlign = "1",
							nTextHAlign = "1",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "770",
							text = "Cost",
							touchAble = "False",
							touchScaleEnable = "False",
							UILayoutViewModel = 
							{
								PositionX = 674,
								PositionY = 208,
							},
							width = "39",
							ZOrder = "1",
						},
						{
							controlID = "Image_icon_Panel_base_Panel-duanwuPop3_duanwu_activity_activity_Game",
							UUID = "ddeac8ca_d8cd_43c8_bb7d_ee3a8be6735d",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							backGroundScale9Enable = "False",
							classname = "MEImage",
							dstBlendFunc = "771",
							height = "100",
							ignoreSize = "True",
							name = "Image_icon",
							scaleX = "0.35",
							scaleY = "0.35",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							texturePath = "icon/item/goods/510201.png",
							touchAble = "False",
							UILayoutViewModel = 
							{
								PositionX = 626,
								PositionY = 186,
							},
							width = "100",
							ZOrder = "1",
						},
						{
							controlID = "Label_number_Panel_base_Panel-duanwuPop3_duanwu_activity_activity_Game",
							UUID = "0a111622_8a55_4981_9779_98f5777ec5a6",
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
							fontSize = "20",
							fontStroke = 
							{
								IsStroke = false,
								StrokeColor = "#FFE6E6E6",
								StrokeSize = 1,
							},
							height = "23",
							ignoreSize = "True",
							name = "Label_number",
							nTextAlign = "1",
							nTextHAlign = "1",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "770",
							text = "88888",
							touchAble = "False",
							touchScaleEnable = "False",
							UILayoutViewModel = 
							{
								PositionX = 639,
								PositionY = 185,
							},
							width = "57",
							ZOrder = "1",
						},
						{
							controlID = "Panel_role_Panel_base_Panel-duanwuPop3_duanwu_activity_activity_Game",
							UUID = "40f579f2_2cd6_479a_9c12_bcda3f9ac90f",
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
							height = "89",
							ignoreSize = "False",
							name = "Panel_role",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							touchAble = "False",
							UILayoutViewModel = 
							{
								PositionX = 361,
								PositionY = 293,
							},
							uipanelviewmodel = 
							{
								Layout="Absolute",
								nType = "0"
							},
							width = "89",
							ZOrder = "1",
							components = 
							{
								
								{
									controlID = "Image_headBg_Panel_role_Panel_base_Panel-duanwuPop3_duanwu_activity_activity_Game",
									UUID = "c0edfb7f_61ff_44ea_9b0d_f648883f5643",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "110",
									ignoreSize = "True",
									name = "Image_headBg",
									scaleX = "0.8",
									scaleY = "0.8",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/common/frame_normal.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = 45,
										PositionY = 44,
									},
									width = "110",
									ZOrder = "1",
								},
								{
									controlID = "ClippingNode_head_Panel_role_Panel_base_Panel-duanwuPop3_duanwu_activity_activity_Game",
									UUID = "405b87e5_7532_4184_8ee7_9bce85492e2a",
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
									scaleX = "0.9",
									scaleY = "0.9",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									stencilPath = "icon/hero/mask/01.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = 45,
										PositionY = 44,
										relativeToName = "Panel",
									},
									width = "100",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "Image_icon_ClippingNode_head_Panel_role_Panel_base_Panel-duanwuPop3_duanwu_activity_activity_Game",
											UUID = "19896910_e28d_4534_9d5e_38ba49a81cd0",
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
			"ui/activity/duanwu_mfdzz/pop/bg.png",
			"ui/activity/duanwu_mfdzz/fortReady/close.png",
			"ui/activity/duanwu_mfdzz/fortReady/button.png",
			"ui/fuben/cost_diban.png",
			"icon/item/goods/510201.png",
			"ui/common/frame_normal.png",
			"icon/hero/face/1104011.png",
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

