local t = 
{
	version = 1,
	components = 
	{
		
		{
			controlID = "Panel-dfwAutumnCardView_Layer3_dafuwong_Game",
			UUID = "483ba535_8673_4073_aad1_a2bc3208a396",
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
					controlID = "Panel_root_Panel-dfwAutumnCardView_Layer3_dafuwong_Game",
					UUID = "30745a83_36b7_4eed_8435_56c945ad4727",
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
						PositionX = 510,
						PositionY = 354,
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
							controlID = "Panel_card_1_Panel_root_Panel-dfwAutumnCardView_Layer3_dafuwong_Game",
							UUID = "266c27fe_f590_420a_bf1a_669e3ddc73b0",
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
							height = "397",
							ignoreSize = "False",
							name = "Panel_card_1",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							touchAble = "False",
							UILayoutViewModel = 
							{
								PositionX = -360,
								PositionY = 18,
							},
							uipanelviewmodel = 
							{
								Layout="Absolute",
								nType = "0"
							},
							width = "276",
							ZOrder = "1",
							components = 
							{
								
								{
									controlID = "Spine_down_Panel_card_1_Panel_root_Panel-dfwAutumnCardView_Layer3_dafuwong_Game",
									UUID = "149b424f_3835_4cc6_990b_d7998cdc18f1",
									classname = "MESpine",
									dstBlendFunc = "771",
									name = "Spine_down",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									spineModel = 
									{
										SpinePath = "effect/effect_QRJ_kapai/effect_QRJ_kapai",
										animationName = "effect_QRJ_kapai_down",
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
										PositionX = -9,
										PositionY = -4,
										relativeToName = "Panel",
									},
									ZOrder = "1",
								},
								{
									controlID = "Button_card_Panel_card_1_Panel_root_Panel-dfwAutumnCardView_Layer3_dafuwong_Game",
									UUID = "68e7e71c_e3fe_4334_a6ba_c9e382e96ba4",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEButton",
									ClickHighLightEnabled = "True",
									dstBlendFunc = "771",
									flipX = "False",
									flipY = "False",
									height = "388",
									ignoreSize = "True",
									name = "Button_card",
									normal = "ui/dfwautumn/card/002.png",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "True",
									UILayoutViewModel = 
									{
										
									},
									UItype = "Button",
									width = "282",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "Label_title_Button_card_Panel_card_1_Panel_root_Panel-dfwAutumnCardView_Layer3_dafuwong_Game",
											UUID = "8df8db82_1844_480b_98cd_df145f84affa",
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
											height = "140",
											ignoreSize = "False",
											name = "Label_title",
											nTextAlign = "1",
											nTextHAlign = "1",
											rotation = "-9",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "770",
											text = "标题标题",
											touchAble = "False",
											touchScaleEnable = "False",
											UILayoutViewModel = 
											{
												PositionX = 91,
												PositionY = 86,
											},
											width = "32",
											ZOrder = "1",
										},
									},
								},
								{
									controlID = "Spine_select_Panel_card_1_Panel_root_Panel-dfwAutumnCardView_Layer3_dafuwong_Game",
									UUID = "de6385e0_0622_4f88_b547_bb81c983bf4e",
									classname = "MESpine",
									dstBlendFunc = "771",
									name = "Spine_select",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									spineModel = 
									{
										SpinePath = "effect/effect_QRJ_kapai/effect_QRJ_kapai",
										animationName = "effect_QRJ_kapai_up",
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
										PositionX = -9,
										PositionY = -4,
									},
									ZOrder = "1",
								},
								{
									controlID = "Label_desc_Panel_card_1_Panel_root_Panel-dfwAutumnCardView_Layer3_dafuwong_Game",
									UUID = "f5b1ff35_a7df_40b0_acb6_213f2492ce4f",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									classname = "MELabel",
									compPath = "luacomponents.common.MEIconLabel",
									dstBlendFunc = "771",
									FontColor = "#FF9F3C3C",
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
									height = "50",
									ignoreSize = "False",
									name = "Label_desc",
									nTextAlign = "0",
									nTextHAlign = "0",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "下一次色子步数 +3",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionX = -9,
										PositionY = -105,
									},
									width = "234",
									ZOrder = "1",
								},
								{
									controlID = "Button_use_Panel_card_1_Panel_root_Panel-dfwAutumnCardView_Layer3_dafuwong_Game",
									UUID = "dc204433_491c_409f_8400_baea6c979e85",
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
									name = "Button_use",
									normal = "ui/common/button_small_blue.png",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "True",
									UILayoutViewModel = 
									{
										PositionX = -19,
										PositionY = -230,
									},
									UItype = "Button",
									width = "124",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "Label_use_Button_use_Panel_card_1_Panel_root_Panel-dfwAutumnCardView_Layer3_dafuwong_Game",
											UUID = "de5492a8_412f_4992_9150_ddb9217700b7",
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
											name = "Label_use",
											nTextAlign = "1",
											nTextHAlign = "1",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "770",
											text = "使用",
											touchAble = "False",
											touchScaleEnable = "False",
											UILayoutViewModel = 
											{
												PositionY = -3,
											},
											width = "53",
											ZOrder = "1",
										},
									},
								},
								{
									controlID = "Image_effect_Panel_card_1_Panel_root_Panel-dfwAutumnCardView_Layer3_dafuwong_Game",
									UUID = "d7a88684_1eef_410c_8b7a_e5cd7be4e778",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "80",
									ignoreSize = "True",
									name = "Image_effect",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/dfwautumn/card/006.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = -19,
										PositionY = -291,
									},
									width = "278",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "Label_effect_Image_effect_Panel_card_1_Panel_root_Panel-dfwAutumnCardView_Layer3_dafuwong_Game",
											UUID = "90b6c9a8_b286_47eb_835d_7daa4b4e87f1",
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
											name = "Label_effect",
											nTextAlign = "1",
											nTextHAlign = "1",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "770",
											text = "当前正处于该BUFF下",
											touchAble = "False",
											touchScaleEnable = "False",
											UILayoutViewModel = 
											{
												
											},
											width = "202",
											ZOrder = "1",
										},
									},
								},
								{
									controlID = "Image_num_bg_Panel_card_1_Panel_root_Panel-dfwAutumnCardView_Layer3_dafuwong_Game",
									UUID = "90bbb4de_d509_4c00_8586_a33ab7358cb6",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "28",
									ignoreSize = "True",
									name = "Image_num_bg",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/dfwautumn/card/007.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = -15,
										PositionY = -144,
									},
									width = "198",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "Label_num_Image_num_bg_Panel_card_1_Panel_root_Panel-dfwAutumnCardView_Layer3_dafuwong_Game",
											UUID = "78b13360_82b0_4f3e_9ad6_203251a5cd30",
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
											fontSize = "22",
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
											text = "5-6",
											touchAble = "False",
											touchScaleEnable = "False",
											UILayoutViewModel = 
											{
												PositionY = -3,
											},
											width = "49",
											ZOrder = "1",
										},
									},
								},
							},
						},
						{
							controlID = "Panel_card_2_Panel_root_Panel-dfwAutumnCardView_Layer3_dafuwong_Game",
							UUID = "cdb74d01_8ca8_4ab4_ab05_03586f19ba4c",
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
							height = "397",
							ignoreSize = "False",
							name = "Panel_card_2",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							touchAble = "False",
							UILayoutViewModel = 
							{
								PositionX = -26,
								PositionY = 18,
							},
							uipanelviewmodel = 
							{
								Layout="Absolute",
								nType = "0"
							},
							width = "276",
							ZOrder = "1",
							components = 
							{
								
								{
									controlID = "Spine_down_Panel_card_2_Panel_root_Panel-dfwAutumnCardView_Layer3_dafuwong_Game",
									UUID = "8ad0a23c_e4bb_488a_9001_ea4f101fe869",
									classname = "MESpine",
									dstBlendFunc = "771",
									name = "Spine_down",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									spineModel = 
									{
										SpinePath = "effect/effect_QRJ_kapai/effect_QRJ_kapai",
										animationName = "effect_QRJ_kapai_down",
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
										PositionX = -9,
										PositionY = -4,
										relativeToName = "Panel",
									},
									ZOrder = "1",
								},
								{
									controlID = "Button_card_Panel_card_2_Panel_root_Panel-dfwAutumnCardView_Layer3_dafuwong_Game",
									UUID = "b72da8cd_025f_49ff_a898_017ec0a2544c",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEButton",
									ClickHighLightEnabled = "True",
									dstBlendFunc = "771",
									flipX = "False",
									flipY = "False",
									height = "388",
									ignoreSize = "True",
									name = "Button_card",
									normal = "ui/dfwautumn/card/003.png",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "True",
									UILayoutViewModel = 
									{
										
									},
									UItype = "Button",
									width = "282",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "Label_title_Button_card_Panel_card_2_Panel_root_Panel-dfwAutumnCardView_Layer3_dafuwong_Game",
											UUID = "f19e7b59_d4cb_4798_8ab2_7cffb8cae923",
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
											height = "140",
											ignoreSize = "False",
											name = "Label_title",
											nTextAlign = "1",
											nTextHAlign = "1",
											rotation = "-9",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "770",
											text = "标题标题",
											touchAble = "False",
											touchScaleEnable = "False",
											UILayoutViewModel = 
											{
												PositionX = 91,
												PositionY = 86,
											},
											width = "32",
											ZOrder = "1",
										},
									},
								},
								{
									controlID = "Spine_select_Panel_card_2_Panel_root_Panel-dfwAutumnCardView_Layer3_dafuwong_Game",
									UUID = "ed46afc0_a0cb_4060_90b3_bd79b8f9fbcb",
									classname = "MESpine",
									dstBlendFunc = "771",
									name = "Spine_select",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									spineModel = 
									{
										SpinePath = "effect/effect_QRJ_kapai/effect_QRJ_kapai",
										animationName = "effect_QRJ_kapai_up",
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
										PositionX = -9,
										PositionY = -4,
									},
									ZOrder = "1",
								},
								{
									controlID = "Label_desc_Panel_card_2_Panel_root_Panel-dfwAutumnCardView_Layer3_dafuwong_Game",
									UUID = "a353ccbd_1f8e_4f2b_8197_9067c928e238",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									classname = "MELabel",
									compPath = "luacomponents.common.MEIconLabel",
									dstBlendFunc = "771",
									FontColor = "#FF9F3C3C",
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
									height = "50",
									ignoreSize = "False",
									name = "Label_desc",
									nTextAlign = "0",
									nTextHAlign = "0",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "下一次色子步数 +3",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionX = -9,
										PositionY = -102,
									},
									width = "234",
									ZOrder = "1",
								},
								{
									controlID = "Button_use_Panel_card_2_Panel_root_Panel-dfwAutumnCardView_Layer3_dafuwong_Game",
									UUID = "a357116d_0314_464f_8364_ce56afc1e53f",
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
									name = "Button_use",
									normal = "ui/common/button_small_blue.png",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "True",
									UILayoutViewModel = 
									{
										PositionX = -19,
										PositionY = -230,
									},
									UItype = "Button",
									width = "124",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "Label_use_Button_use_Panel_card_2_Panel_root_Panel-dfwAutumnCardView_Layer3_dafuwong_Game",
											UUID = "ac920f1b_d028_49a2_9875_23bb3d432bfb",
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
											name = "Label_use",
											nTextAlign = "1",
											nTextHAlign = "1",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "770",
											text = "使用",
											touchAble = "False",
											touchScaleEnable = "False",
											UILayoutViewModel = 
											{
												PositionY = -3,
											},
											width = "53",
											ZOrder = "1",
										},
									},
								},
								{
									controlID = "Image_effect_Panel_card_2_Panel_root_Panel-dfwAutumnCardView_Layer3_dafuwong_Game",
									UUID = "ed0175a5_bee2_4620_ae69_4abce9799f36",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "80",
									ignoreSize = "True",
									name = "Image_effect",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/dfwautumn/card/006.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = -19,
										PositionY = -291,
									},
									width = "278",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "Label_effect_Image_effect_Panel_card_2_Panel_root_Panel-dfwAutumnCardView_Layer3_dafuwong_Game",
											UUID = "3c8246e1_cd87_42b2_a52b_4a9be98e0b25",
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
											name = "Label_effect",
											nTextAlign = "1",
											nTextHAlign = "1",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "770",
											text = "当前正处于该BUFF下",
											touchAble = "False",
											touchScaleEnable = "False",
											UILayoutViewModel = 
											{
												
											},
											width = "202",
											ZOrder = "1",
										},
									},
								},
								{
									controlID = "Image_num_bg_Panel_card_2_Panel_root_Panel-dfwAutumnCardView_Layer3_dafuwong_Game",
									UUID = "1292a115_a07c_462b_a70d_cd6036bee77a",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "28",
									ignoreSize = "True",
									name = "Image_num_bg",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/dfwautumn/card/007.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = -16,
										PositionY = -145,
									},
									width = "198",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "Label_num_Image_num_bg_Panel_card_2_Panel_root_Panel-dfwAutumnCardView_Layer3_dafuwong_Game",
											UUID = "b7bb9495_8a67_467e_8113_0dfbf3b10a9a",
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
											fontSize = "22",
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
											text = "5-6",
											touchAble = "False",
											touchScaleEnable = "False",
											UILayoutViewModel = 
											{
												PositionY = -3,
											},
											width = "49",
											ZOrder = "1",
										},
									},
								},
							},
						},
						{
							controlID = "Panel_card_3_Panel_root_Panel-dfwAutumnCardView_Layer3_dafuwong_Game",
							UUID = "fb57934d_7949_4241_baad_5a0029cf2d02",
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
							height = "397",
							ignoreSize = "False",
							name = "Panel_card_3",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							touchAble = "False",
							UILayoutViewModel = 
							{
								PositionX = 308,
								PositionY = 18,
							},
							uipanelviewmodel = 
							{
								Layout="Absolute",
								nType = "0"
							},
							width = "276",
							ZOrder = "1",
							components = 
							{
								
								{
									controlID = "Spine_down_Panel_card_3_Panel_root_Panel-dfwAutumnCardView_Layer3_dafuwong_Game",
									UUID = "d23d0a43_6343_4cab_a245_203729f5c17f",
									classname = "MESpine",
									dstBlendFunc = "771",
									name = "Spine_down",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									spineModel = 
									{
										SpinePath = "effect/effect_QRJ_kapai/effect_QRJ_kapai",
										animationName = "effect_QRJ_kapai_down",
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
										PositionX = -9,
										PositionY = -4,
										relativeToName = "Panel",
									},
									ZOrder = "1",
								},
								{
									controlID = "Button_card_Panel_card_3_Panel_root_Panel-dfwAutumnCardView_Layer3_dafuwong_Game",
									UUID = "474b1e33_f031_4450_ad97_2fa6eae3ddf3",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEButton",
									ClickHighLightEnabled = "True",
									dstBlendFunc = "771",
									flipX = "False",
									flipY = "False",
									height = "388",
									ignoreSize = "True",
									name = "Button_card",
									normal = "ui/dfwautumn/card/004.png",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "True",
									UILayoutViewModel = 
									{
										
									},
									UItype = "Button",
									width = "282",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "Label_title_Button_card_Panel_card_3_Panel_root_Panel-dfwAutumnCardView_Layer3_dafuwong_Game",
											UUID = "a477f8da_0dbc_40fd_b3fe_abb7dd62805f",
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
											height = "140",
											ignoreSize = "False",
											name = "Label_title",
											nTextAlign = "1",
											nTextHAlign = "1",
											rotation = "-9",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "770",
											text = "标题标题",
											touchAble = "False",
											touchScaleEnable = "False",
											UILayoutViewModel = 
											{
												PositionX = 91,
												PositionY = 86,
											},
											width = "32",
											ZOrder = "1",
										},
									},
								},
								{
									controlID = "Spine_select_Panel_card_3_Panel_root_Panel-dfwAutumnCardView_Layer3_dafuwong_Game",
									UUID = "7ede5f38_c878_4310_b4bc_cadb15f16802",
									classname = "MESpine",
									dstBlendFunc = "771",
									name = "Spine_select",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									spineModel = 
									{
										SpinePath = "effect/effect_QRJ_kapai/effect_QRJ_kapai",
										animationName = "effect_QRJ_kapai_up",
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
										PositionX = -9,
										PositionY = -4,
									},
									ZOrder = "1",
								},
								{
									controlID = "Label_desc_Panel_card_3_Panel_root_Panel-dfwAutumnCardView_Layer3_dafuwong_Game",
									UUID = "5d987db9_26ca_4dd6_8c57_0412926cb10f",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									classname = "MELabel",
									compPath = "luacomponents.common.MEIconLabel",
									dstBlendFunc = "771",
									FontColor = "#FF9F3C3C",
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
									height = "50",
									ignoreSize = "False",
									name = "Label_desc",
									nTextAlign = "0",
									nTextHAlign = "0",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "下一次色子步数 +3",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionX = -9,
										PositionY = -102,
									},
									width = "234",
									ZOrder = "1",
								},
								{
									controlID = "Button_use_Panel_card_3_Panel_root_Panel-dfwAutumnCardView_Layer3_dafuwong_Game",
									UUID = "bcce1dc9_38f2_42f4_847a_70377da15d54",
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
									name = "Button_use",
									normal = "ui/common/button_small_blue.png",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "True",
									UILayoutViewModel = 
									{
										PositionX = -19,
										PositionY = -230,
									},
									UItype = "Button",
									width = "124",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "Label_use_Button_use_Panel_card_3_Panel_root_Panel-dfwAutumnCardView_Layer3_dafuwong_Game",
											UUID = "90bb5176_23f5_47e8_b07b_088dae5ebffe",
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
											name = "Label_use",
											nTextAlign = "1",
											nTextHAlign = "1",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "770",
											text = "使用",
											touchAble = "False",
											touchScaleEnable = "False",
											UILayoutViewModel = 
											{
												PositionY = -3,
											},
											width = "53",
											ZOrder = "1",
										},
									},
								},
								{
									controlID = "Image_effect_Panel_card_3_Panel_root_Panel-dfwAutumnCardView_Layer3_dafuwong_Game",
									UUID = "7f21fa2a_125b_46ee_9ea0_7c3c58331bf8",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "80",
									ignoreSize = "True",
									name = "Image_effect",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/dfwautumn/card/006.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = -19,
										PositionY = -291,
									},
									width = "278",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "Label_effect_Image_effect_Panel_card_3_Panel_root_Panel-dfwAutumnCardView_Layer3_dafuwong_Game",
											UUID = "3fa31f73_89f4_4e9e_8dbe_2e1bc82ef8da",
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
											name = "Label_effect",
											nTextAlign = "1",
											nTextHAlign = "1",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "770",
											text = "当前正处于该BUFF下",
											touchAble = "False",
											touchScaleEnable = "False",
											UILayoutViewModel = 
											{
												
											},
											width = "202",
											ZOrder = "1",
										},
									},
								},
								{
									controlID = "Image_num_bg_Panel_card_3_Panel_root_Panel-dfwAutumnCardView_Layer3_dafuwong_Game",
									UUID = "1e9a8413_e772_46ef_a742_978da2352521",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "28",
									ignoreSize = "True",
									name = "Image_num_bg",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/dfwautumn/card/007.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = -16,
										PositionY = -145,
									},
									width = "198",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "Label_num_Image_num_bg_Panel_card_3_Panel_root_Panel-dfwAutumnCardView_Layer3_dafuwong_Game",
											UUID = "873c8d68_6c27_4d33_be3c_4fe46d7b0a0d",
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
											fontSize = "22",
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
											text = "5-6",
											touchAble = "False",
											touchScaleEnable = "False",
											UILayoutViewModel = 
											{
												PositionY = -3,
											},
											width = "49",
											ZOrder = "1",
										},
									},
								},
							},
						},
					},
				},
				{
					controlID = "Panel_prefab_Panel-dfwAutumnCardView_Layer3_dafuwong_Game",
					UUID = "d82df8cf_69c2_42cc_9e01_499ed2c3477e",
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
						PositionX = 692,
						PositionY = -516,
						LeftPositon = 124,
						TopPosition = 905,
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
			"ui/dfwautumn/card/002.png",
			"ui/common/button_small_blue.png",
			"ui/dfwautumn/card/006.png",
			"ui/dfwautumn/card/007.png",
			"ui/dfwautumn/card/003.png",
			"ui/dfwautumn/card/004.png",
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

