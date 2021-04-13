local t = 
{
	version = 1,
	components = 
	{
		
		{
			controlID = "Panel-overduePromptView_Layer1_bag_Game",
			UUID = "9d608edc_1122_4de4_ace3_82f0bd0ff373",
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
					controlID = "Panel_base_Panel-overduePromptView_Layer1_bag_Game",
					UUID = "a5438372_0396_41e7_a8d2_d5d048994699",
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
						PositionX = -88,
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
							controlID = "panel_back_Panel_base_Panel-overduePromptView_Layer1_bag_Game",
							UUID = "93bd611c_120d_4a22_a250_bb3d5c4aaa7d",
							anchorPoint = "False",
							anchorPointX = "0",
							anchorPointY = "0",
							backGroundScale9Enable = "False",
							bgColorOpacity = "50",
							bIsOpenClipping = "False",
							classname = "MEPanel",
							colorType = "0;SingleColor:#FF000000;GraduallyChangingColorStart:#FFFFFFFF;GraduallyChangingColorEnd:#FFFFFFFF;vectorX:0;vectorY:0",
							DesignHeight = "640",
							DesignType = "0",
							DesignWidth = "960",
							dstBlendFunc = "771",
							height = "640",
							ignoreSize = "False",
							name = "panel_back",
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
							width = "1136",
							ZOrder = "1",
						},
						{
							controlID = "background_Panel_base_Panel-overduePromptView_Layer1_bag_Game",
							UUID = "99d91f14_7782_4305_a3de_5ac749f6adaf",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							backGroundScale9Enable = "True;capInsetsX:0;capInsetsY:0;capInsetsWidth:0;capInsetsHeight:0",
							classname = "MEImage",
							dstBlendFunc = "771",
							height = "501",
							ignoreSize = "False",
							name = "background",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							texturePath = "ui/common/pop_ui/pop_bg_01.png",
							touchAble = "True",
							UILayoutViewModel = 
							{
								PositionX = 568,
								PositionY = 320,
								IsPercent = true,
								PercentX = 50,
								PercentY = 50,
							},
							width = "742",
							ZOrder = "1",
							components = 
							{
								
								{
									controlID = "Image_bg1_background_Panel_base_Panel-overduePromptView_Layer1_bag_Game",
									UUID = "9c16d9af_0275_4659_9f27_8668f38f4dd8",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "382",
									ignoreSize = "False",
									name = "Image_bg1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/common/pop_ui/pop_bg_02.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionY = 9,
									},
									width = "717",
									ZOrder = "1",
								},
							},
						},
						{
							controlID = "Label_title_Panel_base_Panel-overduePromptView_Layer1_bag_Game",
							UUID = "99bd66f0_9b20_4d70_9a88_cbb5c60fcaf7",
							anchorPoint = "False",
							anchorPointX = "0",
							anchorPointY = "0.5",
							classname = "MELabel",
							ColorMixing = "#FFC0C8D0",
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
							height = "32",
							ignoreSize = "True",
							name = "Label_title",
							nTextAlign = "1",
							nTextHAlign = "1",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "770",
							text = "Notifikasi Item kadaluarsa",
							touchAble = "False",
							touchScaleEnable = "False",
							UILayoutViewModel = 
							{
								PositionX = 212,
								PositionY = 537,
							},
							width = "393",
							ZOrder = "1",
						},
						{
							controlID = "Image_line_Panel_base_Panel-overduePromptView_Layer1_bag_Game",
							UUID = "392124f9_1d74_4229_9f32_328f20713316",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							backGroundScale9Enable = "False",
							classname = "MEImage",
							dstBlendFunc = "771",
							height = "26",
							ignoreSize = "True",
							name = "Image_line",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							texturePath = "ui/common/pop_ui/pop_ui_02.png",
							touchAble = "False",
							UILayoutViewModel = 
							{
								PositionX = 334,
								PositionY = 537,
							},
							visible = "False",
							width = "2",
							ZOrder = "1",
						},
						{
							controlID = "Label_title_en_Panel_base_Panel-overduePromptView_Layer1_bag_Game",
							UUID = "921d4ea2_53d7_496c_99fb_d122d4972ab8",
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
							fontSize = "16",
							fontStroke = 
							{
								IsStroke = false,
								StrokeColor = "#FFE6E6E6",
								StrokeSize = 1,
							},
							height = "18",
							ignoreSize = "True",
							name = "Label_title_en",
							nTextAlign = "2",
							nTextHAlign = "0",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "770",
							text = "Recycling Items",
							touchAble = "False",
							touchScaleEnable = "False",
							UILayoutViewModel = 
							{
								PositionX = 338,
								PositionY = 531,
							},
							visible = "False",
							width = "103",
							ZOrder = "1",
						},
						{
							controlID = "Button_close_Panel_base_Panel-overduePromptView_Layer1_bag_Game",
							UUID = "4866f844_4e87_44bf_9f2e_4f545b6e2a12",
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
								PositionX = 908,
								PositionY = 541,
							},
							UItype = "Button",
							width = "60",
							ZOrder = "1",
						},
						{
							controlID = "ScrollView_Recycle_Panel_base_Panel-overduePromptView_Layer1_bag_Game",
							UUID = "6d88fd72_7155_4185_8228_2d30c246ed4c",
							anchorPoint = "False",
							anchorPointX = "0",
							anchorPointY = "0",
							backGroundScale9Enable = "False",
							bgColorOpacity = "50",
							bIsOpenClipping = "True",
							bounceEnable = "True",
							classname = "MEScrollView",
							colorType = "0;SingleColor:#FFE6E6E6;GraduallyChangingColorStart:#FFFFFFFF;GraduallyChangingColorEnd:#FFFFFFFF;vectorX:0;vectorY:0",
							direction = "1",
							dstBlendFunc = "771",
							height = "145",
							ignoreSize = "False",
							innerHeight = "400",
							innerWidth = "682",
							name = "ScrollView_Recycle",
							showScrollbar = "False",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							touchAble = "True",
							UILayoutViewModel = 
							{
								PositionX = 225,
								PositionY = 323,
							},
							uipanelviewmodel = 
							{
								Layout="Absolute",
								nType = "0"
							},
							width = "682",
							ZOrder = "1",
						},
						{
							controlID = "ScrollView_Return_Panel_base_Panel-overduePromptView_Layer1_bag_Game",
							UUID = "4d856902_cc48_4ff8_b52c_ff1c04fd9804",
							anchorPoint = "False",
							anchorPointX = "0",
							anchorPointY = "0",
							backGroundScale9Enable = "False",
							bgColorOpacity = "50",
							bIsOpenClipping = "True",
							bounceEnable = "True",
							classname = "MEScrollView",
							colorType = "0;SingleColor:#FFE6E6E6;GraduallyChangingColorStart:#FFFFFFFF;GraduallyChangingColorEnd:#FFFFFFFF;vectorX:0;vectorY:0",
							direction = "1",
							dstBlendFunc = "771",
							height = "125",
							ignoreSize = "False",
							innerHeight = "400",
							innerWidth = "682",
							name = "ScrollView_Return",
							showScrollbar = "False",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							touchAble = "True",
							UILayoutViewModel = 
							{
								PositionX = 225,
								PositionY = 142,
							},
							uipanelviewmodel = 
							{
								Layout="Absolute",
								nType = "0"
							},
							width = "682",
							ZOrder = "1",
						},
						{
							controlID = "Image_title_bg1_Panel_base_Panel-overduePromptView_Layer1_bag_Game",
							UUID = "139663c0_3e11_41e2_803c_e1d103fe8617",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							backGroundScale9Enable = "False",
							classname = "MEImage",
							dstBlendFunc = "771",
							height = "44",
							ignoreSize = "True",
							name = "Image_title_bg1",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "770",
							texturePath = "ui/task/training/ui_022.png",
							touchAble = "False",
							UILayoutViewModel = 
							{
								PositionX = 568,
								PositionY = 498,
							},
							width = "718",
							ZOrder = "1",
						},
						{
							controlID = "Label_desc_Panel_base_Panel-overduePromptView_Layer1_bag_Game",
							UUID = "77215720_061c_4f93_a9c1_28379e86cf5a",
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
							name = "Label_desc",
							nTextAlign = "1",
							nTextHAlign = "1",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "770",
							text = "Item berikut akan kadaluarsa dalam 1 hari",
							touchAble = "False",
							touchScaleEnable = "False",
							UILayoutViewModel = 
							{
								PositionX = 568,
								PositionY = 498,
							},
							width = "400",
							ZOrder = "1",
						},
						{
							controlID = "Image_title_bg2_Panel_base_Panel-overduePromptView_Layer1_bag_Game",
							UUID = "334c4f44_3a65_40f0_bfe5_826ca2fe2a1a",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							backGroundScale9Enable = "False",
							classname = "MEImage",
							dstBlendFunc = "771",
							height = "44",
							ignoreSize = "True",
							name = "Image_title_bg2",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "770",
							texturePath = "ui/task/training/ui_022.png",
							touchAble = "False",
							UILayoutViewModel = 
							{
								PositionX = 568,
								PositionY = 296,
							},
							width = "718",
							ZOrder = "1",
						},
						{
							controlID = "Label_tips_Panel_base_Panel-overduePromptView_Layer1_bag_Game",
							UUID = "910c6347_2697_432c_abaf_bb91dc51b437",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							classname = "MELabel",
							compPath = "luacomponents.common.MEIconLabel",
							dstBlendFunc = "771",
							FontColor = "#FFE0E4EF",
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
							name = "Label_tips",
							nTextAlign = "1",
							nTextHAlign = "1",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "770",
							text = "Item berikut akan kadaluarsa dalam 3 hari ",
							touchAble = "False",
							touchScaleEnable = "False",
							UILayoutViewModel = 
							{
								PositionX = 569,
								PositionY = 296,
							},
							width = "400",
							ZOrder = "1",
						},
						{
							controlID = "Button_Confirm_Panel_base_Panel-overduePromptView_Layer1_bag_Game",
							UUID = "fbc5fde8_d714_4994_baf1_7d6ab79ed869",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							backGroundScale9Enable = "True;capInsetsX:0;capInsetsY:0;capInsetsWidth:0;capInsetsHeight:0",
							classname = "MEButton",
							ClickHighLightEnabled = "True",
							dstBlendFunc = "771",
							flipX = "False",
							flipY = "False",
							height = "56",
							ignoreSize = "False",
							name = "Button_Confirm",
							normal = "ui/common/button09.png",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							touchAble = "True",
							UILayoutViewModel = 
							{
								PositionX = 854,
								PositionY = 109,
							},
							UItype = "Button",
							width = "130",
							ZOrder = "1",
							components = 
							{
								
								{
									controlID = "Label_comfirm_Button_Confirm_Panel_base_Panel-overduePromptView_Layer1_bag_Game",
									UUID = "8eecd511_46ba_4964_a0c0_7b4c6a30f001",
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
									name = "Label_comfirm",
									nTextAlign = "1",
									nTextHAlign = "1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "OK",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionX = -1,
										PositionY = -1,
									},
									width = "37",
									ZOrder = "1",
								},
							},
						},
						{
							controlID = "Label_tips-Copy1_Panel_base_Panel-overduePromptView_Layer1_bag_Game",
							UUID = "82170636_c2e9_48b4_a1cc_c11103fbde34",
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
							fontSize = "21",
							fontStroke = 
							{
								IsStroke = false,
								StrokeColor = "#FFE6E6E6",
								StrokeSize = 1,
							},
							height = "0",
							ignoreSize = "False",
							name = "Label_tips-Copy1",
							nTextAlign = "1",
							nTextHAlign = "0",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "770",
							text = "Mohon gunakan secepatknya, Item kadaluarsa akan otomatis hilang",
							touchAble = "False",
							touchScaleEnable = "False",
							UILayoutViewModel = 
							{
								PositionX = 220,
								PositionY = 106,
							},
							width = "550",
							ZOrder = "1",
						},
					},
				},
				{
					controlID = "Panel_list_Panel-overduePromptView_Layer1_bag_Game",
					UUID = "94de768e_09ee_4401_aa32_fa1fc6873a58",
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
					height = "150",
					ignoreSize = "False",
					name = "Panel_list",
					sizepercentx = "0",
					sizepercenty = "0",
					sizeType = "0",
					srcBlendFunc = "1",
					touchAble = "False",
					UILayoutViewModel = 
					{
						PositionX = 125,
						PositionY = -225,
						LeftPositon = 125,
						TopPosition = 715,
						relativeToName = "Panel",
						nType = 3,
					},
					uipanelviewmodel = 
					{
						Layout="Absolute",
						nType = "0"
					},
					visible = "False",
					width = "682",
					ZOrder = "1",
				},
				{
					controlID = "Panel_item_Panel-overduePromptView_Layer1_bag_Game",
					UUID = "2eb678ac_e013_4639_b51c_0d11e3e857ae",
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
					height = "150",
					ignoreSize = "False",
					name = "Panel_item",
					sizepercentx = "0",
					sizepercenty = "0",
					sizeType = "0",
					srcBlendFunc = "1",
					touchAble = "True",
					UILayoutViewModel = 
					{
						PositionX = 191,
						PositionY = -193,
						LeftPositon = 126,
						TopPosition = 758,
						relativeToName = "Panel",
						nType = 3,
					},
					uipanelviewmodel = 
					{
						Layout="Absolute",
						nType = "0"
					},
					width = "130",
					ZOrder = "1",
					components = 
					{
						
						{
							controlID = "Spine_qualityEffect_bg_Panel_item_Panel-overduePromptView_Layer1_bag_Game",
							UUID = "dc6bafca_5548_47e0_810b_19db552bf286",
							classname = "MESpine",
							dstBlendFunc = "771",
							name = "Spine_qualityEffect_bg",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							spineModel = 
							{
								SpinePath = "effect/effect_props/effect_props",
								animationName = "effect_props_purple_down",
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
								PositionY = 20,
							},
							ZOrder = "1",
						},
						{
							controlID = "Image_frame_Panel_item_Panel-overduePromptView_Layer1_bag_Game",
							UUID = "b958c1c6_6096_45bd_b83b_f8378ce9984a",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							backGroundScale9Enable = "False",
							classname = "MEImage",
							dstBlendFunc = "771",
							height = "110",
							ignoreSize = "True",
							name = "Image_frame",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							texturePath = "ui/common/frame_red.png",
							touchAble = "False",
							UILayoutViewModel = 
							{
								PositionY = 20,
							},
							width = "110",
							ZOrder = "1",
						},
						{
							controlID = "Image_icon_Panel_item_Panel-overduePromptView_Layer1_bag_Game",
							UUID = "5c8c2421_da80_4937_a776_c3d4d3f6d352",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							backGroundScale9Enable = "False",
							classname = "MEImage",
							dstBlendFunc = "771",
							height = "100",
							ignoreSize = "True",
							name = "Image_icon",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							texturePath = "icon/item/goods/510106.png",
							touchAble = "False",
							UILayoutViewModel = 
							{
								PositionY = 20,
							},
							width = "100",
							ZOrder = "1",
						},
						{
							controlID = "Spine_qualityEffect_up_Panel_item_Panel-overduePromptView_Layer1_bag_Game",
							UUID = "f759401e_2cff_4c6d_ba11_157843eed18a",
							classname = "MESpine",
							dstBlendFunc = "771",
							name = "Spine_qualityEffect_up",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							spineModel = 
							{
								SpinePath = "effect/effect_props/effect_props",
								animationName = "effect_props_purple_up",
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
								PositionY = 20,
							},
							ZOrder = "1",
						},
						{
							controlID = "Spine_qualityEffect_up2_Panel_item_Panel-overduePromptView_Layer1_bag_Game",
							UUID = "fe2d97cd_86f4_46ac_b154_98d6b87ac07d",
							classname = "MESpine",
							dstBlendFunc = "771",
							name = "Spine_qualityEffect_up2",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							spineModel = 
							{
								SpinePath = "effect/effect_props/effect_props",
								animationName = "effect_props_purple_up2",
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
								PositionY = 20,
							},
							ZOrder = "1",
						},
						{
							controlID = "Image_outtime_Panel_item_Panel-overduePromptView_Layer1_bag_Game",
							UUID = "569e4e50_6c68_4fa2_9595_4497c3d24148",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							backGroundScale9Enable = "False",
							classname = "MEImage",
							dstBlendFunc = "771",
							height = "24",
							ignoreSize = "True",
							name = "Image_outtime",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							texturePath = "ui/common/level_red.png",
							touchAble = "False",
							UILayoutViewModel = 
							{
								PositionX = -14,
								PositionY = 58,
							},
							width = "76",
							ZOrder = "1",
							components = 
							{
								
								{
									controlID = "Label_outtime_Image_outtime_Panel_item_Panel-overduePromptView_Layer1_bag_Game",
									UUID = "3111f035_8021_4ee0_be25_40cfa7a28931",
									anchorPoint = "False",
									anchorPointX = "0",
									anchorPointY = "0.5",
									classname = "MELabel",
									compPath = "luacomponents.common.MEIconLabel",
									dstBlendFunc = "771",
									FontColor = "#FFDC143C",
									fontName = "font/MFLiHei_Noncommercial.ttf",
									fontShadow = 
									{
										IsShadow = false,
										ShadowColor = "#FFFFFFFF",
										ShadowAlpha = 255,
										OffsetX = 0,
										OffsetY = 0,
									},
									fontSize = "13",
									fontStroke = 
									{
										IsStroke = false,
										StrokeColor = "#FFE6E6E6",
										StrokeSize = 1,
									},
									height = "0",
									ignoreSize = "False",
									name = "Label_outtime",
									nTextAlign = "1",
									nTextHAlign = "1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "Timed",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionX = -43,
										PositionY = 1,
									},
									width = "79",
									ZOrder = "1",
								},
							},
						},
						{
							controlID = "Label_count_Panel_item_Panel-overduePromptView_Layer1_bag_Game",
							UUID = "03c53581_6ce3_4e79_ba14_289cb48cad77",
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
							fontSize = "20",
							fontStroke = 
							{
								IsStroke = true,
								StrokeColor = "#FF000000",
								StrokeSize = 1,
							},
							height = "25",
							ignoreSize = "True",
							name = "Label_count",
							nTextAlign = "1",
							nTextHAlign = "2",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "770",
							text = "50",
							touchAble = "False",
							touchScaleEnable = "False",
							UILayoutViewModel = 
							{
								PositionX = 48,
								PositionY = 57,
							},
							width = "25",
							ZOrder = "1",
						},
						{
							controlID = "label_outTime_Panel_item_Panel-overduePromptView_Layer1_bag_Game",
							UUID = "ddec9506_e16c_43c0_a92a_be90913602bd",
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
							name = "label_outTime",
							nTextAlign = "1",
							nTextHAlign = "1",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "770",
							text = "88d:88h:88m",
							touchAble = "False",
							touchScaleEnable = "False",
							UILayoutViewModel = 
							{
								PositionY = -50,
							},
							width = "113",
							ZOrder = "1",
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
			"ui/common/pop_ui/pop_bg_02.png",
			"ui/common/pop_ui/pop_ui_02.png",
			"ui/common/pop_ui/pop_btn_02.png",
			"ui/task/training/ui_022.png",
			"ui/common/button09.png",
			"ui/common/frame_red.png",
			"icon/item/goods/510106.png",
			"ui/common/level_red.png",
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

