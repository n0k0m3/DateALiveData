local t = 
{
	version = 1,
	components = 
	{
		
		{
			controlID = "Panel-dfwAutumnStepRewardView_Layer3_dafuwong_Game",
			UUID = "3d32aaf4_19c9_4aa7_a8e3_39b708938e89",
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
					controlID = "Panel_root_Panel-dfwAutumnStepRewardView_Layer3_dafuwong_Game",
					UUID = "747e049d_d40f_4b58_a0b4_edd520b539f4",
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
							controlID = "Image_content_Panel_root_Panel-dfwAutumnStepRewardView_Layer3_dafuwong_Game",
							UUID = "a70f79c7_a277_4b70_92b8_8f6a663dc316",
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
									controlID = "Image_dfwStepRewardView_1_Image_content_Panel_root_Panel-dfwAutumnStepRewardView_Layer3_dafuwong_Game",
									UUID = "185705f8_0bcd_4696_9cb7_00908d30efab",
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
									controlID = "Button_close_Image_content_Panel_root_Panel-dfwAutumnStepRewardView_Layer3_dafuwong_Game",
									UUID = "94b14b11_8c63_4f48_a9a5_d53271a70c9f",
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
									controlID = "Label_name_Image_content_Panel_root_Panel-dfwAutumnStepRewardView_Layer3_dafuwong_Game",
									UUID = "efc389f8_0b01_424c_a630_3bbde0598240",
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
									text = "Hadiah Langkah",
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
									controlID = "Image_title_line_Image_content_Panel_root_Panel-dfwAutumnStepRewardView_Layer3_dafuwong_Game",
									UUID = "76802c18_c0bb_4ea6_8435_7a1f31aeaa79",
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
									controlID = "Label_englishName_Image_content_Panel_root_Panel-dfwAutumnStepRewardView_Layer3_dafuwong_Game",
									UUID = "b7da42f4_7cbb_4c1c_8550_f58adbcb6d4d",
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
									text = "Reward",
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
									controlID = "ScrollView_task_Image_content_Panel_root_Panel-dfwAutumnStepRewardView_Layer3_dafuwong_Game",
									UUID = "54f38d4a_f293_4720_b89e_38155983a660",
									anchorPoint = "False",
									anchorPointX = "0",
									anchorPointY = "0",
									backGroundScale9Enable = "False",
									bgColorOpacity = "50",
									bIsOpenClipping = "True",
									bounceEnable = "True",
									classname = "MEScrollView",
									colorType = "0;SingleColor:#FFFF0000;GraduallyChangingColorStart:#FFFFFFFF;GraduallyChangingColorEnd:#FFFFFFFF;vectorX:0;vectorY:0",
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
										PositionX = -355,
										PositionY = -194,
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
					controlID = "Panel_prefab_Panel-dfwAutumnStepRewardView_Layer3_dafuwong_Game",
					UUID = "bd620192_9138_4afa_a311_a59c87cd6f6b",
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
						PositionY = -369,
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
							controlID = "Panel_taskItem_Panel_prefab_Panel-dfwAutumnStepRewardView_Layer3_dafuwong_Game",
							UUID = "a189f534_a1d2_44a0_a1fc_9a791a845d3f",
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
								PositionX = 46,
								PositionY = -42,
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
									controlID = "Image_receive_bg_Panel_taskItem_Panel_prefab_Panel-dfwAutumnStepRewardView_Layer3_dafuwong_Game",
									UUID = "b4e91b05_8de3_4153_89ca_ef19d397835a",
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
											controlID = "Label_desc_Image_receive_bg_Panel_taskItem_Panel_prefab_Panel-dfwAutumnStepRewardView_Layer3_dafuwong_Game",
											UUID = "5915eb76_bedd_4d6a_8a2d_17533b579783",
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
											text = "Langkah Kumulatif",
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
											controlID = "Label_step_Image_receive_bg_Panel_taskItem_Panel_prefab_Panel-dfwAutumnStepRewardView_Layer3_dafuwong_Game",
											UUID = "a21d7f48_cce9_456c_ae22_be52bee6d064",
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
											text = "1000",
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
									controlID = "Image_geted_bg_Panel_taskItem_Panel_prefab_Panel-dfwAutumnStepRewardView_Layer3_dafuwong_Game",
									UUID = "86e24692_1eb2_4de3_b48e_f0e4d2469d8b",
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
											controlID = "Label_desc_complete_Image_geted_bg_Panel_taskItem_Panel_prefab_Panel-dfwAutumnStepRewardView_Layer3_dafuwong_Game",
											UUID = "564e7b41_bead_489b_84f5_45715f634d18",
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
											text = "Langkah Kumulatif",
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
											controlID = "Label_step_complete_Image_geted_bg_Panel_taskItem_Panel_prefab_Panel-dfwAutumnStepRewardView_Layer3_dafuwong_Game",
											UUID = "405e1528_95a1_4cd8_86d0_afdf06c9f958",
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
											text = "1000",
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
									controlID = "Image_receive_tag_Panel_taskItem_Panel_prefab_Panel-dfwAutumnStepRewardView_Layer3_dafuwong_Game",
									UUID = "aebd2db1_4b7a_4b2f_9705_bfef99cfcfc1",
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
									controlID = "Image_geted_tag_Panel_taskItem_Panel_prefab_Panel-dfwAutumnStepRewardView_Layer3_dafuwong_Game",
									UUID = "2ea67c71_82cc_4981_98f1_7671e71112f6",
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
									controlID = "Image_ing_tag_Panel_taskItem_Panel_prefab_Panel-dfwAutumnStepRewardView_Layer3_dafuwong_Game",
									UUID = "44513e09_f6dc_4535_8492_9c50c8567f1f",
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
									controlID = "Label_ing_Panel_taskItem_Panel_prefab_Panel-dfwAutumnStepRewardView_Layer3_dafuwong_Game",
									UUID = "d4e1d32d_60ea_4862_b3a6_f8695d981184",
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
									text = "Sedang berjalan",
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
									controlID = "Button_receive_Panel_taskItem_Panel_prefab_Panel-dfwAutumnStepRewardView_Layer3_dafuwong_Game",
									UUID = "63aa0830_41df_4ec9_973f_26ab57f20539",
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
											controlID = "Label_receive_Button_receive_Panel_taskItem_Panel_prefab_Panel-dfwAutumnStepRewardView_Layer3_dafuwong_Game",
											UUID = "4606954d_dc5a_4525_97a9_67df788a6242",
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
											text = "Klaim Hadiah",
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
									controlID = "Label_geted_Panel_taskItem_Panel_prefab_Panel-dfwAutumnStepRewardView_Layer3_dafuwong_Game",
									UUID = "93aabb96_c213_4ba6_be44_397f05e729ce",
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
									text = "Selesai",
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
									controlID = "ScrollView_reward_Panel_taskItem_Panel_prefab_Panel-dfwAutumnStepRewardView_Layer3_dafuwong_Game",
									UUID = "ca733886_8f6a_4dd1_8633_53586f705e68",
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

