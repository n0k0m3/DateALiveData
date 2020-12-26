local t = 
{
	version = 1,
	components = 
	{
		
		{
			controlID = "Panel-dlsReadyView_Layer1_dls_Game",
			UUID = "f23e623c_abca_48ac_81a9_8138f89b29ad",
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
					controlID = "Panel_root_Panel-dlsReadyView_Layer1_dls_Game",
					UUID = "b9cd0ce5_b72a_4960_bb99_beb9a01f91b5",
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
							controlID = "Image_content_Panel_root_Panel-dlsReadyView_Layer1_dls_Game",
							UUID = "b7c7b538_ffe5_4512_bcae_3f11f5dca484",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							backGroundScale9Enable = "True;capInsetsX:0;capInsetsY:0;capInsetsWidth:0;capInsetsHeight:0",
							classname = "MEImage",
							dstBlendFunc = "771",
							height = "430",
							ignoreSize = "False",
							name = "Image_content",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							texturePath = "ui/common/pop_ui/pop_bg_01.png",
							touchAble = "True",
							UILayoutViewModel = 
							{
								
							},
							width = "740",
							ZOrder = "1",
							components = 
							{
								
								{
									controlID = "Image_dlsReadyView_1_Image_content_Panel_root_Panel-dlsReadyView_Layer1_dls_Game",
									UUID = "c95ee74e_39cf_4dec_a148_ddd0db079c47",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "True;capInsetsX:0;capInsetsY:0;capInsetsWidth:0;capInsetsHeight:0",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "303",
									ignoreSize = "False",
									name = "Image_dlsReadyView_1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/common/pop_ui/pop_bg_02.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionY = 7,
									},
									width = "724",
									ZOrder = "1",
								},
								{
									controlID = "Button_close_Image_content_Panel_root_Panel-dlsReadyView_Layer1_dls_Game",
									UUID = "15a707ab_e989_4172_ba8c_59dd97a7e5ce",
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
										PositionX = 338,
										PositionY = 182,
									},
									UItype = "Button",
									width = "60",
									ZOrder = "1",
								},
								{
									controlID = "Label_name_Image_content_Panel_root_Panel-dlsReadyView_Layer1_dls_Game",
									UUID = "17647502_68b7_4ca6_a430_d7493aedafff",
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
									name = "Label_name",
									nTextAlign = "1",
									nTextHAlign = "1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "1-1",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionX = -353,
										PositionY = 182,
									},
									width = "45",
									ZOrder = "1",
								},
								{
									controlID = "Image_title_line_Image_content_Panel_root_Panel-dlsReadyView_Layer1_dls_Game",
									UUID = "8ca2ba98_493b_419a_bf2f_e48a7e2af11c",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "26",
									ignoreSize = "True",
									name = "Image_title_line",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/common/pop_ui/pop_ui_02.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = -302,
										PositionY = 184,
									},
									width = "2",
									ZOrder = "1",
								},
								{
									controlID = "Label_englishName_Image_content_Panel_root_Panel-dlsReadyView_Layer1_dls_Game",
									UUID = "8d9afc51_e748_4bc8_b5f3_a9df26319526",
									anchorPoint = "False",
									anchorPointX = "0",
									anchorPointY = "0.5",
									classname = "MELabel",
									compPath = "luacomponents.common.MEIconLabel",
									dstBlendFunc = "771",
									FontColor = "#FF30354A",
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
									name = "Label_englishName",
									nTextAlign = "1",
									nTextHAlign = "1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "Infomation Create",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionX = -296,
										PositionY = 177,
									},
									width = "141",
									ZOrder = "1",
								},
								{
									controlID = "Image_plate_Image_content_Panel_root_Panel-dlsReadyView_Layer1_dls_Game",
									UUID = "f87e93dd_b0dd_4b51_b8da_73e6d8ea8109",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "163",
									ignoreSize = "True",
									name = "Image_plate",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/dalmap/minimap/002.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = -103,
										PositionY = 67,
									},
									width = "496",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "Image_dlsReadyView_1(2)_Image_plate_Image_content_Panel_root_Panel-dlsReadyView_Layer1_dls_Game",
											UUID = "34d52d2a_6a34_4e7f_8cde_6e375e254c5a",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											classname = "MEImage",
											dstBlendFunc = "771",
											height = "163",
											ignoreSize = "True",
											name = "Image_dlsReadyView_1(2)",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											texturePath = "ui/dalmap/mainmap/017.png",
											touchAble = "False",
											UILayoutViewModel = 
											{
												
											},
											width = "496",
											ZOrder = "1",
										},
										{
											controlID = "Label_desc_Image_plate_Image_content_Panel_root_Panel-dlsReadyView_Layer1_dls_Game",
											UUID = "df955c96_5327_4aef_9df2_f65b8853d572",
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
											fontSize = "20",
											fontStroke = 
											{
												IsStroke = true,
												StrokeColor = "#FF455075",
												StrokeSize = 1,
											},
											height = "125",
											ignoreSize = "False",
											name = "Label_desc",
											nTextAlign = "0",
											nTextHAlign = "0",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "770",
											text = "Pengenalan Stage",
											touchAble = "False",
											touchScaleEnable = "False",
											UILayoutViewModel = 
											{
												PositionX = -14,
												PositionY = 11,
											},
											width = "450",
											ZOrder = "1",
										},
									},
								},
								{
									controlID = "Image_target_Image_content_Panel_root_Panel-dlsReadyView_Layer1_dls_Game",
									UUID = "f8ae8098_4b42_4c96_bfc2_07f14c47669c",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "36",
									ignoreSize = "True",
									name = "Image_target",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/fuben/fighting_title.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = -104,
										PositionY = -42,
									},
									width = "494",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "Label_targetTitle_Image_target_Image_content_Panel_root_Panel-dlsReadyView_Layer1_dls_Game",
											UUID = "e8802381_0e99_45dd_b651_441079bd7559",
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
											fontSize = "20",
											fontStroke = 
											{
												IsStroke = false,
												StrokeColor = "#FFE6E6E6",
												StrokeSize = 1,
											},
											height = "23",
											ignoreSize = "True",
											name = "Label_targetTitle",
											nTextAlign = "1",
											nTextHAlign = "1",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "770",
											text = "Target Quest",
											touchAble = "False",
											touchScaleEnable = "False",
											UILayoutViewModel = 
											{
												PositionX = -193,
												PositionY = -1,
											},
											width = "83",
											ZOrder = "1",
										},
										{
											controlID = "Label_targetTitle2_Image_target_Image_content_Panel_root_Panel-dlsReadyView_Layer1_dls_Game",
											UUID = "35e9d466_b7e4_4289_898b_d8d70c23346d",
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
											fontSize = "14",
											fontStroke = 
											{
												IsStroke = false,
												StrokeColor = "#FFE6E6E6",
												StrokeSize = 1,
											},
											height = "16",
											ignoreSize = "True",
											name = "Label_targetTitle2",
											nTextAlign = "1",
											nTextHAlign = "1",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "770",
											text = "Challenge Target",
											touchAble = "False",
											touchScaleEnable = "False",
											UILayoutViewModel = 
											{
												PositionX = -137,
												PositionY = -9,
											},
											width = "104",
											ZOrder = "1",
										},
										{
											controlID = "Label_target_Image_target_Image_content_Panel_root_Panel-dlsReadyView_Layer1_dls_Game",
											UUID = "df7c3055_4474_46e8_8262_e6d6bd3a8db3",
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
											height = "53",
											ignoreSize = "False",
											name = "Label_target",
											nTextAlign = "1",
											nTextHAlign = "0",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "770",
											text = "Narasi Utama Quest I",
											touchAble = "False",
											touchScaleEnable = "False",
											UILayoutViewModel = 
											{
												PositionX = -245,
												PositionY = -57,
											},
											width = "490",
											ZOrder = "1",
										},
									},
								},
								{
									controlID = "Image_fubenReadyView_1_Image_content_Panel_root_Panel-dlsReadyView_Layer1_dls_Game",
									UUID = "b7811b68_8ec4_420c_84e0_96f5e49f128f",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "264",
									ignoreSize = "True",
									name = "Image_fubenReadyView_1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/fuben/split.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = 156,
										PositionY = 5,
									},
									width = "10",
									ZOrder = "1",
								},
								{
									controlID = "Image_fubenReadyView_2_Image_content_Panel_root_Panel-dlsReadyView_Layer1_dls_Game",
									UUID = "0324c2ac_35bd_4af9_be57_5a9aa6f36170",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "8",
									ignoreSize = "True",
									name = "Image_fubenReadyView_2",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/fuben/reward_split.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = 256,
										PositionY = 111,
									},
									width = "146",
									ZOrder = "1",
								},
								{
									controlID = "Panel_reward_Image_content_Panel_root_Panel-dlsReadyView_Layer1_dls_Game",
									UUID = "91b4f21e_af10_4bb8_be8a_e3db7c02321f",
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
									height = "271",
									ignoreSize = "False",
									name = "Panel_reward",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = 257,
										PositionY = 20,
									},
									uipanelviewmodel = 
									{
										Layout="Absolute",
										nType = "0"
									},
									width = "200",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "ScrollView_reward_Panel_reward_Image_content_Panel_root_Panel-dlsReadyView_Layer1_dls_Game",
											UUID = "3787e44b_c692_4377_9787_91d3512e05ce",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											bgColorOpacity = "50",
											bIsOpenClipping = "True",
											bounceEnable = "True",
											classname = "MEScrollView",
											colorType = "0;SingleColor:#FFFF4500;GraduallyChangingColorStart:#FFFFFFFF;GraduallyChangingColorEnd:#FFFFFFFF;vectorX:0;vectorY:0",
											direction = "1",
											dstBlendFunc = "771",
											height = "240",
											ignoreSize = "False",
											innerHeight = "240",
											innerWidth = "155",
											name = "ScrollView_reward",
											showScrollbar = "False",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "True",
											UILayoutViewModel = 
											{
												PositionY = -39,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "155",
											ZOrder = "1",
										},
										{
											controlID = "Label_reward_Panel_reward_Image_content_Panel_root_Panel-dlsReadyView_Layer1_dls_Game",
											UUID = "426fba8d_d66a_42da_902a_a7edfecb2ff6",
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
											fontSize = "20",
											fontStroke = 
											{
												IsStroke = false,
												StrokeColor = "#FFE6E6E6",
												StrokeSize = 1,
											},
											height = "23",
											ignoreSize = "True",
											name = "Label_reward",
											nTextAlign = "1",
											nTextHAlign = "1",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "770",
											text = "Hadiah Stage",
											touchAble = "False",
											touchScaleEnable = "False",
											UILayoutViewModel = 
											{
												PositionX = -3,
												PositionY = 115,
											},
											width = "83",
											ZOrder = "1",
										},
									},
								},
								{
									controlID = "Button_unlock_Image_content_Panel_root_Panel-dlsReadyView_Layer1_dls_Game",
									UUID = "86d59528_6e87_479f_a485_ad6a7c965a38",
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
									name = "Button_unlock",
									normal = "ui/common/button_middle_n.png",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "True",
									UILayoutViewModel = 
									{
										PositionX = 294,
										PositionY = -174,
									},
									UItype = "Button",
									width = "124",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "Label_unlock_Button_unlock_Image_content_Panel_root_Panel-dlsReadyView_Layer1_dls_Game",
											UUID = "002745f1_f269_4031_8d1f_73765cd3fd06",
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
											name = "Label_unlock",
											nTextAlign = "1",
											nTextHAlign = "1",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "770",
											text = "Buka",
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
									controlID = "Button_enter_Image_content_Panel_root_Panel-dlsReadyView_Layer1_dls_Game",
									UUID = "7fe7766d_0c9a_4869_a08e_f0ea5719152c",
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
									name = "Button_enter",
									normal = "ui/common/button_middle_n.png",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "True",
									UILayoutViewModel = 
									{
										PositionX = 295,
										PositionY = -175,
									},
									UItype = "Button",
									width = "124",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "Label_enter_Button_enter_Image_content_Panel_root_Panel-dlsReadyView_Layer1_dls_Game",
											UUID = "872e411c_1ce6_4a42_9ef7_b864349c5332",
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
											name = "Label_enter",
											nTextAlign = "1",
											nTextHAlign = "1",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "770",
											text = "Masuk",
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
									controlID = "Button_cost_Image_content_Panel_root_Panel-dlsReadyView_Layer1_dls_Game",
									UUID = "795f8a48_b9d2_4e76_9006_ba4843d0a281",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEButton",
									ClickHighLightEnabled = "True",
									dstBlendFunc = "771",
									flipX = "False",
									flipY = "False",
									height = "50",
									ignoreSize = "True",
									name = "Button_cost",
									normal = "ui/fuben/cost_diban.png",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = 177,
										PositionY = -175,
									},
									UItype = "Button",
									width = "104",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "Label_costNum_Button_cost_Image_content_Panel_root_Panel-dlsReadyView_Layer1_dls_Game",
											UUID = "e843f766_a777_4495_a82b_3234c0eb580c",
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
											fontSize = "52",
											fontStroke = 
											{
												IsStroke = false,
												StrokeColor = "#FFE6E6E6",
												StrokeSize = 1,
											},
											height = "60",
											ignoreSize = "True",
											name = "Label_costNum",
											nTextAlign = "1",
											nTextHAlign = "1",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "770",
											text = "6",
											touchAble = "False",
											touchScaleEnable = "False",
											UILayoutViewModel = 
											{
												PositionX = -25,
												PositionY = -4,
											},
											width = "29",
											ZOrder = "1",
										},
										{
											controlID = "Image_costIcon_Button_cost_Image_content_Panel_root_Panel-dlsReadyView_Layer1_dls_Game",
											UUID = "54819312_1813_4ff3_8d19_890ab06b0d43",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											classname = "MEImage",
											dstBlendFunc = "771",
											height = "100",
											ignoreSize = "True",
											name = "Image_costIcon",
											scaleX = "0.25",
											scaleY = "0.25",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											texturePath = "icon/item/goods/510401.png",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 21,
												PositionY = 10,
											},
											width = "100",
											ZOrder = "1",
										},
										{
											controlID = "Label_cost_Button_cost_Image_content_Panel_root_Panel-dlsReadyView_Layer1_dls_Game",
											UUID = "2cea95c7_8032_4f57_bbc7_ed1f1a28303d",
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
											fontSize = "20",
											fontStroke = 
											{
												IsStroke = false,
												StrokeColor = "#FFE6E6E6",
												StrokeSize = 1,
											},
											height = "23",
											ignoreSize = "True",
											name = "Label_cost",
											nTextAlign = "1",
											nTextHAlign = "1",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "770",
											text = "Biaya",
											touchAble = "False",
											touchScaleEnable = "False",
											UILayoutViewModel = 
											{
												PositionX = 18,
												PositionY = -13,
											},
											width = "43",
											ZOrder = "1",
										},
									},
								},
							},
						},
					},
				},
				{
					controlID = "Panel_prefab_Panel-dlsReadyView_Layer1_dls_Game",
					UUID = "daff0abc_41d2_459b_b923_10f0685c461c",
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
						PositionX = 571,
						PositionY = -355,
						LeftPositon = 3,
						TopPosition = 675,
						relativeToName = "Panel",
						nType = 3,
						nGravity = 1,
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
			"ui/common/pop_ui/pop_bg_01.png",
			"ui/common/pop_ui/pop_bg_02.png",
			"ui/common/pop_ui/pop_btn_02.png",
			"ui/common/pop_ui/pop_ui_02.png",
			"ui/dalmap/minimap/002.png",
			"ui/dalmap/mainmap/017.png",
			"ui/fuben/fighting_title.png",
			"ui/fuben/split.png",
			"ui/fuben/reward_split.png",
			"ui/common/button_middle_n.png",
			"ui/fuben/cost_diban.png",
			"icon/item/goods/510401.png",
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

