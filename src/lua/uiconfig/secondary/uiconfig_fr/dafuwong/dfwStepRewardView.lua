local t = 
{
	version = 1,
	components = 
	{
		
		{
			controlID = "Panel-dfwStepRewardView_Layer1_dafuwong_Game",
			UUID = "3f769d13_3ae3_4335_aa2c_2fecd69143c2",
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
					controlID = "Panel_root_Panel-dfwStepRewardView_Layer1_dafuwong_Game",
					UUID = "eedfa4dc_0990_41b8_8d65_fbdc1e386209",
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
							controlID = "Image_content_Panel_root_Panel-dfwStepRewardView_Layer1_dafuwong_Game",
							UUID = "55304a3b_9fc5_4dfa_bf13_e68ccc3f3a66",
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
							texturePath = "ui/common/mini_pop/9.png",
							touchAble = "True",
							UILayoutViewModel = 
							{
								PositionX = -3,
								PositionY = -3,
							},
							width = "740",
							ZOrder = "1",
							components = 
							{
								
								{
									controlID = "Image_dfwStepRewardView_1_Image_content_Panel_root_Panel-dfwStepRewardView_Layer1_dafuwong_Game",
									UUID = "68948720_2e51_41d8_a7cb_9d9c1970e68e",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "True;capInsetsX:0;capInsetsY:0;capInsetsWidth:0;capInsetsHeight:0",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "360",
									ignoreSize = "False",
									name = "Image_dfwStepRewardView_1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/common/pop_ui/pop_head_bg.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = -1,
										PositionY = -17,
									},
									width = "721",
									ZOrder = "1",
								},
								{
									controlID = "Button_close_Image_content_Panel_root_Panel-dfwStepRewardView_Layer1_dafuwong_Game",
									UUID = "c4e0393d_c607_4788_9429_0d4d01a11852",
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
										PositionX = 336,
										PositionY = 181,
									},
									UItype = "Button",
									width = "60",
									ZOrder = "1",
								},
								{
									controlID = "Label_name_Image_content_Panel_root_Panel-dfwStepRewardView_Layer1_dafuwong_Game",
									UUID = "b76c219f_6c6d_4c74_b1a6_b8a5cf7a7bb9",
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
									text = "Récompense étapes",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionX = -356,
										PositionY = 181,
									},
									width = "114",
									ZOrder = "1",
								},
								{
									controlID = "Image_title_line_Image_content_Panel_root_Panel-dfwStepRewardView_Layer1_dafuwong_Game",
									UUID = "98cb9a05_3f0b_4218_b3a1_0c23c1814190",
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
										PositionX = -232,
										PositionY = 184,
									},
									width = "2",
									ZOrder = "1",
								},
								{
									controlID = "Label_englishName_Image_content_Panel_root_Panel-dfwStepRewardView_Layer1_dafuwong_Game",
									UUID = "dc133ac1_5e75_4095_912e_c51a715d8503",
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
									fontSize = "14",
									fontStroke = 
									{
										IsStroke = false,
										StrokeColor = "#FFE6E6E6",
										StrokeSize = 1,
									},
									height = "16",
									ignoreSize = "True",
									name = "Label_englishName",
									nTextAlign = "1",
									nTextHAlign = "1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "Récompense",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionX = -229,
										PositionY = 176,
									},
									width = "46",
									ZOrder = "1",
								},
								{
									controlID = "ScrollView_task_Image_content_Panel_root_Panel-dfwStepRewardView_Layer1_dafuwong_Game",
									UUID = "8ee6fbfc_3011_4348_b13d_96653ac36e05",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									bgColorOpacity = "50",
									bIsOpenClipping = "True",
									bounceEnable = "True",
									classname = "MEScrollView",
									colorType = "0;SingleColor:#FFE6E6E6;GraduallyChangingColorStart:#FFFFFFFF;GraduallyChangingColorEnd:#FFFFFFFF;vectorX:0;vectorY:0",
									direction = "1",
									dstBlendFunc = "771",
									height = "353",
									ignoreSize = "False",
									innerHeight = "353",
									innerWidth = "713",
									name = "ScrollView_task",
									showScrollbar = "False",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "True",
									UILayoutViewModel = 
									{
										PositionX = -2,
										PositionY = -18,
									},
									uipanelviewmodel = 
									{
										Layout="Absolute",
										nType = "0"
									},
									width = "713",
									ZOrder = "1",
								},
							},
						},
					},
				},
				{
					controlID = "Panel_prefab_Panel-dfwStepRewardView_Layer1_dafuwong_Game",
					UUID = "ff6c3baf_86ee_4eb7_9850_3a43a34b91c0",
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
						PositionX = 506,
						PositionY = -438,
						LeftPositon = -62,
						TopPosition = 758,
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
							controlID = "Panel_taskItem_Panel_prefab_Panel-dfwStepRewardView_Layer1_dafuwong_Game",
							UUID = "5f6b315f_9fe6_4914_bd49_961bf5254f51",
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
							height = "95",
							ignoreSize = "False",
							name = "Panel_taskItem",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							touchAble = "False",
							UILayoutViewModel = 
							{
								PositionX = 56,
								PositionY = 866,
							},
							uipanelviewmodel = 
							{
								Layout="Absolute",
								nType = "0"
							},
							width = "710",
							ZOrder = "1",
							components = 
							{
								
								{
									controlID = "Image_receive_bg_Panel_taskItem_Panel_prefab_Panel-dfwStepRewardView_Layer1_dafuwong_Game",
									UUID = "2baf4810_156c_40c6_a620_ffb64b1c5cbe",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "88",
									ignoreSize = "True",
									name = "Image_receive_bg",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/agora/task/cell_bg1.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										
									},
									width = "710",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "Label_desc_Image_receive_bg_Panel_taskItem_Panel_prefab_Panel-dfwStepRewardView_Layer1_dafuwong_Game",
											UUID = "9a29fc81_5a00_42a9_8703_a6eb73716701",
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
											name = "Label_desc",
											nTextAlign = "1",
											nTextHAlign = "1",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "770",
											text = "Total d'étapes",
											touchAble = "False",
											touchScaleEnable = "False",
											UILayoutViewModel = 
											{
												PositionX = -301,
												PositionY = 10,
											},
											width = "99",
											ZOrder = "1",
										},
										{
											controlID = "Label_step_Image_receive_bg_Panel_taskItem_Panel_prefab_Panel-dfwStepRewardView_Layer1_dafuwong_Game",
											UUID = "2e0fac4c_bf6f_428a_9cda_a4223b4f0ad8",
											anchorPoint = "False",
											anchorPointX = "0",
											anchorPointY = "0.5",
											classname = "MELabel",
											compPath = "luacomponents.common.MEIconLabel",
											dstBlendFunc = "771",
											FontColor = "#FFE3E4F0",
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
											height = "25",
											ignoreSize = "True",
											name = "Label_step",
											nTextAlign = "1",
											nTextHAlign = "1",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "770",
											text = "1000.0",
											touchAble = "False",
											touchScaleEnable = "False",
											UILayoutViewModel = 
											{
												PositionX = -301,
												PositionY = -24,
											},
											width = "66",
											ZOrder = "1",
										},
									},
								},
								{
									controlID = "Image_geted_bg_Panel_taskItem_Panel_prefab_Panel-dfwStepRewardView_Layer1_dafuwong_Game",
									UUID = "a2681e31_ca05_4617_8554_a589e55ef484",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "88",
									ignoreSize = "True",
									name = "Image_geted_bg",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/agora/task/cell_bg.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										
									},
									visible = "False",
									width = "710",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "Label_desc_complete_Image_geted_bg_Panel_taskItem_Panel_prefab_Panel-dfwStepRewardView_Layer1_dafuwong_Game",
											UUID = "05a825e8_f41c_4cb3_9b33_486e901e4826",
											anchorPoint = "False",
											anchorPointX = "0",
											anchorPointY = "0.5",
											classname = "MELabel",
											compPath = "luacomponents.common.MEIconLabel",
											dstBlendFunc = "771",
											FontColor = "#FFA2A4C8",
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
											name = "Label_desc_complete",
											nTextAlign = "1",
											nTextHAlign = "1",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "770",
											text = "Total d'étapes",
											touchAble = "False",
											touchScaleEnable = "False",
											UILayoutViewModel = 
											{
												PositionX = -301,
												PositionY = 10,
											},
											width = "99",
											ZOrder = "1",
										},
										{
											controlID = "Label_step_complete_Image_geted_bg_Panel_taskItem_Panel_prefab_Panel-dfwStepRewardView_Layer1_dafuwong_Game",
											UUID = "061dd15a_6b9d_4c20_988b_c0acad37b135",
											anchorPoint = "False",
											anchorPointX = "0",
											anchorPointY = "0.5",
											classname = "MELabel",
											compPath = "luacomponents.common.MEIconLabel",
											dstBlendFunc = "771",
											FontColor = "#FFA2A4C8",
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
											height = "25",
											ignoreSize = "True",
											name = "Label_step_complete",
											nTextAlign = "1",
											nTextHAlign = "1",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "770",
											text = "1000.0",
											touchAble = "False",
											touchScaleEnable = "False",
											UILayoutViewModel = 
											{
												PositionX = -301,
												PositionY = -24,
											},
											width = "66",
											ZOrder = "1",
										},
									},
								},
								{
									controlID = "Image_receive_tag_Panel_taskItem_Panel_prefab_Panel-dfwStepRewardView_Layer1_dafuwong_Game",
									UUID = "3bff156d_b223_4376_a9de_9b2215e346af",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "50",
									ignoreSize = "True",
									name = "Image_receive_tag",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/agora/task/icon_2.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = -326,
										PositionY = 1,
									},
									visible = "False",
									width = "50",
									ZOrder = "1",
								},
								{
									controlID = "Image_geted_tag_Panel_taskItem_Panel_prefab_Panel-dfwStepRewardView_Layer1_dafuwong_Game",
									UUID = "3e1f8ae5_b463_46fe_9dcd_f10dc67244ad",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "50",
									ignoreSize = "True",
									name = "Image_geted_tag",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/agora/task/icon_1.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = -326,
										PositionY = 1,
									},
									visible = "False",
									width = "50",
									ZOrder = "1",
								},
								{
									controlID = "Image_ing_tag_Panel_taskItem_Panel_prefab_Panel-dfwStepRewardView_Layer1_dafuwong_Game",
									UUID = "7a85fc6c_2e05_45cc_bf70_90914c44a799",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "50",
									ignoreSize = "True",
									name = "Image_ing_tag",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/agora/task/icon_0.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = -326,
										PositionY = 1,
									},
									width = "50",
									ZOrder = "1",
								},
								{
									controlID = "Label_ing_Panel_taskItem_Panel_prefab_Panel-dfwStepRewardView_Layer1_dafuwong_Game",
									UUID = "a288e43e_31f7_45dd_9b5f_fc2d9bbd721f",
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
									name = "Label_ing",
									nTextAlign = "1",
									nTextHAlign = "1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "En cours",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionX = 271,
										PositionY = -5,
									},
									width = "80",
									ZOrder = "1",
								},
								{
									controlID = "Button_receive_Panel_taskItem_Panel_prefab_Panel-dfwStepRewardView_Layer1_dafuwong_Game",
									UUID = "2420b692_9e64_4037_ba94_4f26c09f1f21",
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
										PositionX = 272,
									},
									UItype = "Button",
									width = "124",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "Label_receive_Button_receive_Panel_taskItem_Panel_prefab_Panel-dfwStepRewardView_Layer1_dafuwong_Game",
											UUID = "4fe252e3_ef55_47aa_b257_e13d8a198b1a",
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
											text = "Obtenir récompense",
											touchAble = "False",
											touchScaleEnable = "False",
											UILayoutViewModel = 
											{
												
											},
											width = "98",
											ZOrder = "1",
										},
									},
								},
								{
									controlID = "Label_geted_Panel_taskItem_Panel_prefab_Panel-dfwStepRewardView_Layer1_dafuwong_Game",
									UUID = "3b0b9356_ba52_415d_9d1c_98f688c82f72",
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
									name = "Label_geted",
									nTextAlign = "1",
									nTextHAlign = "1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "Terminé",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionX = 271,
										PositionY = -5,
									},
									width = "81",
									ZOrder = "1",
								},
								{
									controlID = "ScrollView_reward_Panel_taskItem_Panel_prefab_Panel-dfwStepRewardView_Layer1_dafuwong_Game",
									UUID = "8ad159d6_670a_46ca_af4d_b7ec7761b8f7",
									anchorPoint = "False",
									anchorPointX = "0",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									bgColorOpacity = "50",
									bIsOpenClipping = "True",
									bounceEnable = "False",
									classname = "MEScrollView",
									colorType = "0;SingleColor:#FFE6E6E6;GraduallyChangingColorStart:#FFFFFFFF;GraduallyChangingColorEnd:#FFFFFFFF;vectorX:0;vectorY:0",
									direction = "2",
									dstBlendFunc = "771",
									height = "75",
									ignoreSize = "False",
									innerHeight = "75",
									innerWidth = "243",
									name = "ScrollView_reward",
									showScrollbar = "False",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "True",
									UILayoutViewModel = 
									{
										PositionX = -45,
									},
									uipanelviewmodel = 
									{
										Layout="Absolute",
										nType = "0"
									},
									width = "243",
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
			"ui/common/mini_pop/9.png",
			"ui/common/pop_ui/pop_head_bg.png",
			"ui/common/pop_ui/pop_btn_02.png",
			"ui/common/pop_ui/pop_ui_02.png",
			"ui/agora/task/cell_bg1.png",
			"ui/agora/task/cell_bg.png",
			"ui/agora/task/icon_2.png",
			"ui/agora/task/icon_1.png",
			"ui/agora/task/icon_0.png",
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

