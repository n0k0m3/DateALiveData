local t = 
{
	version = 1,
	components = 
	{
		
		{
			controlID = "Panel-summonPointView_Layer1_summon_Game",
			UUID = "15be4488_e4ef_4182_9667_b0814448a03a",
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
					controlID = "Panel_root_Panel-summonPointView_Layer1_summon_Game",
					UUID = "92d4cbb8_b6a6_4f28_97e2_ebfe4cc49ce6",
					anchorPoint = "False",
					anchorPointX = "0.5",
					anchorPointY = "0.5",
					backGroundScale9Enable = "False",
					bgColorOpacity = "50",
					bIsOpenClipping = "False",
					classname = "MEPanel",
					colorType = "0;SingleColor:#FF800080;GraduallyChangingColorStart:#FFFFFFFF;GraduallyChangingColorEnd:#FFFFFFFF;vectorX:0;vectorY:0",
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
							controlID = "Image_bg_Panel_root_Panel-summonPointView_Layer1_summon_Game",
							UUID = "717ceb4e_7982_44a3_b69d_7f6dd636f5ab",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							backGroundScale9Enable = "False",
							classname = "MEImage",
							dstBlendFunc = "771",
							height = "640",
							ignoreSize = "True",
							name = "Image_bg",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							texturePath = "ui/summon/bg.png",
							touchAble = "False",
							UILayoutViewModel = 
							{
								relativeToName = "Panel_root",
								nGravity = 6,
								nAlign = 5
							},
							width = "1386",
							ZOrder = "1",
						},
						{
							controlID = "Image_ad_Panel_root_Panel-summonPointView_Layer1_summon_Game",
							UUID = "0de519da_d680_4d55_8a9d_73b2cb0a3dec",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							backGroundScale9Enable = "False",
							classname = "MEImage",
							dstBlendFunc = "771",
							height = "564",
							ignoreSize = "True",
							name = "Image_ad",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							texturePath = "ui/summon/exchange/equip_7.png",
							touchAble = "False",
							UILayoutViewModel = 
							{
								PositionY = -29,
							},
							width = "1020",
							ZOrder = "1",
							components = 
							{
								
								{
									controlID = "Image_equipPaint_Image_ad_Panel_root_Panel-summonPointView_Layer1_summon_Game",
									UUID = "174346af_b007_464a_9f5e_ca85c76daec7",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "64",
									ignoreSize = "True",
									name = "Image_equipPaint",
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
									controlID = "Image_inner_Image_ad_Panel_root_Panel-summonPointView_Layer1_summon_Game",
									UUID = "0f040aa9_12e4_4150_a096_3bd3d54eecda",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "564",
									ignoreSize = "True",
									name = "Image_inner",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/summon/exchange/equip_8.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										
									},
									width = "1020",
									ZOrder = "1",
								},
								{
									controlID = "Label_view_Image_ad_Panel_root_Panel-summonPointView_Layer1_summon_Game",
									UUID = "ad7fbc29_0109_42d0_9cc7_076163b60ede",
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
									height = "25",
									ignoreSize = "True",
									name = "Label_view",
									nTextAlign = "1",
									nTextHAlign = "1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "Vorschau",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionY = -24,
									},
									width = "111",
									ZOrder = "1",
								},
								{
									controlID = "Button_view_Image_ad_Panel_root_Panel-summonPointView_Layer1_summon_Game",
									UUID = "1c5b893d_61e6_49cf_a1c2_89c3845770bc",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEButton",
									ClickHighLightEnabled = "True",
									dstBlendFunc = "771",
									flipX = "False",
									flipY = "False",
									height = "130",
									ignoreSize = "True",
									name = "Button_view",
									normal = "ui/summon/exchange/equip_9.png",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "True",
									UILayoutViewModel = 
									{
										PositionX = -1,
										PositionY = 14,
									},
									UItype = "Button",
									width = "130",
									ZOrder = "1",
								},
							},
						},
						{
							controlID = "ScrollView_item_Panel_root_Panel-summonPointView_Layer1_summon_Game",
							UUID = "0e0e5090_57cc_4b07_b109_4cbba101cd99",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							backGroundScale9Enable = "False",
							bgColorOpacity = "100",
							bIsOpenClipping = "True",
							bounceEnable = "True",
							classname = "MEScrollView",
							colorType = "0;SingleColor:#FFE6E6E6;GraduallyChangingColorStart:#FFFFFFFF;GraduallyChangingColorEnd:#FFFFFFFF;vectorX:0;vectorY:0",
							direction = "1",
							dstBlendFunc = "771",
							height = "349",
							ignoreSize = "False",
							innerHeight = "349",
							innerWidth = "271",
							name = "ScrollView_item",
							showScrollbar = "False",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							touchAble = "True",
							UILayoutViewModel = 
							{
								PositionX = 337,
								PositionY = -19,
							},
							uipanelviewmodel = 
							{
								Layout="Absolute",
								nType = "0"
							},
							width = "271",
							ZOrder = "1",
						},
						{
							controlID = "Image_scrollBarModel_Panel_root_Panel-summonPointView_Layer1_summon_Game",
							UUID = "f98d34d9_daec_4e02_a2e3_1e94c786af4f",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0",
							backGroundScale9Enable = "True;capInsetsX:0;capInsetsY:0;capInsetsWidth:0;capInsetsHeight:0",
							classname = "MEImage",
							dstBlendFunc = "771",
							height = "349",
							ignoreSize = "False",
							name = "Image_scrollBarModel",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							texturePath = "ui/common/scroll_bar_01.png",
							touchAble = "False",
							UILayoutViewModel = 
							{
								PositionX = 475,
								PositionY = -194,
							},
							width = "6",
							ZOrder = "1",
							components = 
							{
								
								{
									controlID = "Image_scrollBarInner_Image_scrollBarModel_Panel_root_Panel-summonPointView_Layer1_summon_Game",
									UUID = "772524f8_3794_4b44_82f4_b1069c204ff4",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0",
									backGroundScale9Enable = "True;capInsetsX:0;capInsetsY:0;capInsetsWidth:0;capInsetsHeight:0",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "349",
									ignoreSize = "False",
									name = "Image_scrollBarInner",
									sizepercentx = "100",
									sizepercenty = "100",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/common/scroll_bar_02.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										
									},
									width = "6",
									ZOrder = "1",
								},
							},
						},
						{
							controlID = "Button_exchange_Panel_root_Panel-summonPointView_Layer1_summon_Game",
							UUID = "3648b815_c5da_433f_bd75_155cc80b7c7c",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							backGroundScale9Enable = "False",
							classname = "MEButton",
							ClickHighLightEnabled = "True",
							dstBlendFunc = "771",
							flipX = "False",
							flipY = "False",
							height = "68",
							ignoreSize = "False",
							name = "Button_exchange",
							normal = "ui/summon/exchange/equip_3.png",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							touchAble = "True",
							UILayoutViewModel = 
							{
								PositionY = -231,
								LeftPositon = 275,
								TopPosition = 544,
								relativeToName = "Panel_root",
							},
							UItype = "Button",
							width = "297",
							ZOrder = "1",
							components = 
							{
								
								{
									controlID = "Label_exchange_Button_exchange_Panel_root_Panel-summonPointView_Layer1_summon_Game",
									UUID = "70547505_c926_48a5_8642_8afbdc73e3f4",
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
									fontSize = "24",
									fontStroke = 
									{
										IsStroke = true,
										StrokeColor = "#FFE37393",
										StrokeSize = 2,
									},
									height = "32",
									ignoreSize = "True",
									name = "Label_exchange",
									nTextAlign = "1",
									nTextHAlign = "1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "Sephira tauschen",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										
									},
									width = "220",
									ZOrder = "1",
								},
							},
						},
						{
							controlID = "Button_check_Panel_root_Panel-summonPointView_Layer1_summon_Game",
							UUID = "723d05a3_bceb_4be7_bdbe_89972adf0714",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							backGroundScale9Enable = "False",
							classname = "MEButton",
							ClickHighLightEnabled = "True",
							dstBlendFunc = "771",
							flipX = "False",
							flipY = "False",
							height = "58",
							ignoreSize = "True",
							name = "Button_check",
							normal = "ui/summon/exchange/equip_1.png",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							touchAble = "True",
							UILayoutViewModel = 
							{
								PositionX = 350,
								PositionY = -236,
								LeftPositon = 275,
								TopPosition = 544,
								relativeToName = "Panel_root",
							},
							UItype = "Button",
							width = "166",
							ZOrder = "1",
							components = 
							{
								
								{
									controlID = "Label_check_Button_check_Panel_root_Panel-summonPointView_Layer1_summon_Game",
									UUID = "792a0fef_0868_4520_abc1_d55c92cb1fb8",
									anchorPoint = "False",
									anchorPointX = "0",
									anchorPointY = "0.5",
									classname = "MELabel",
									compPath = "luacomponents.common.MEIconLabel",
									dstBlendFunc = "771",
									FontColor = "#FF49557F",
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
									height = "0",
									ignoreSize = "False",
									name = "Label_check",
									nTextAlign = "1",
									nTextHAlign = "1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "Details anzeigen",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionX = -35,
									},
									width = "111",
									ZOrder = "1",
								},
								{
									controlID = "Image_icon_Button_check_Panel_root_Panel-summonPointView_Layer1_summon_Game",
									UUID = "16f0374b_8f68_4933_aad8_a22104c8007d",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "26",
									ignoreSize = "True",
									name = "Image_icon",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/summon/exchange/equip_2.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = -49,
									},
									width = "26",
									ZOrder = "1",
								},
							},
						},
						{
							controlID = "Label_tip1_Panel_root_Panel-summonPointView_Layer1_summon_Game",
							UUID = "fee4bf37_2b74_4baf_9dae_ee6b0d756152",
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
							fontSize = "30",
							fontStroke = 
							{
								IsStroke = true,
								StrokeColor = "#FF3A4260",
								StrokeSize = 2,
							},
							height = "38",
							ignoreSize = "True",
							name = "Label_tip1",
							nTextAlign = "1",
							nTextHAlign = "1",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "770",
							text = "Deine Sephira",
							touchAble = "False",
							touchScaleEnable = "False",
							UILayoutViewModel = 
							{
								PositionX = 347,
								PositionY = 194,
							},
							width = "225",
							ZOrder = "1",
						},
						{
							controlID = "Label_tip2_Panel_root_Panel-summonPointView_Layer1_summon_Game",
							UUID = "793341b2_31f5_4585_a562_51854daedb1a",
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
							fontSize = "30",
							fontStroke = 
							{
								IsStroke = true,
								StrokeColor = "#FF3A4260",
								StrokeSize = 2,
							},
							height = "38",
							ignoreSize = "True",
							name = "Label_tip2",
							nTextAlign = "1",
							nTextHAlign = "1",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "770",
							text = "Sephira tauschen",
							touchAble = "False",
							touchScaleEnable = "False",
							UILayoutViewModel = 
							{
								PositionX = -348,
								PositionY = -234,
							},
							width = "273",
							ZOrder = "1",
						},
						{
							controlID = "Image_descbg_Panel_root_Panel-summonPointView_Layer1_summon_Game",
							UUID = "271b54fe_1fcf_4eff_83c5_5b167321b846",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							backGroundScale9Enable = "False",
							classname = "MEImage",
							dstBlendFunc = "771",
							height = "72",
							ignoreSize = "True",
							name = "Image_descbg",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							texturePath = "ui/summon/exchange/equip_4.png",
							touchAble = "False",
							UILayoutViewModel = 
							{
								PositionY = -152,
							},
							width = "306",
							ZOrder = "1",
							components = 
							{
								
								{
									controlID = "Label_desc_Image_descbg_Panel_root_Panel-summonPointView_Layer1_summon_Game",
									UUID = "228bb655_5e39_4c1b_a63e_2e8959c9029b",
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
									height = "60",
									ignoreSize = "False",
									name = "Label_desc",
									nTextAlign = "1",
									nTextHAlign = "0",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "Sephira Sephira Sephira pro pro Sekunde Sekunde Sekunde",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										
									},
									width = "250",
									ZOrder = "1",
								},
							},
						},
						{
							controlID = "Panel_target_Panel_root_Panel-summonPointView_Layer1_summon_Game",
							UUID = "28e7fcdf_8259_4dd1_8b3f_df475993a5b0",
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
							height = "460",
							ignoreSize = "False",
							name = "Panel_target",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							touchAble = "False",
							UILayoutViewModel = 
							{
								PositionX = -491,
								PositionY = -264,
							},
							uipanelviewmodel = 
							{
								Layout="Absolute",
								nType = "0"
							},
							width = "400",
							ZOrder = "1",
						},
					},
				},
				{
					controlID = "Panel_prefab_Panel-summonPointView_Layer1_summon_Game",
					UUID = "7af7ac6d_ab99_4a14_b33d_655948ad0f73",
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
					sizepercentx = "0",
					sizepercenty = "0",
					sizeType = "0",
					srcBlendFunc = "1",
					touchAble = "False",
					UILayoutViewModel = 
					{
						PositionX = -57,
						PositionY = -706,
						LeftPositon = -57,
						TopPosition = 706,
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
					components = 
					{
						
						{
							controlID = "Panel_CloneItem_Panel_prefab_Panel-summonPointView_Layer1_summon_Game",
							UUID = "f0ce4cb4_62c2_4511_90dc_a71fb39c7ccd",
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
							height = "100",
							ignoreSize = "False",
							name = "Panel_CloneItem",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							touchAble = "False",
							UILayoutViewModel = 
							{
								PositionY = -97,
							},
							uipanelviewmodel = 
							{
								Layout="Absolute",
								nType = "0"
							},
							width = "85",
							ZOrder = "1",
							components = 
							{
								
								{
									controlID = "Panel_head_Panel_CloneItem_Panel_prefab_Panel-summonPointView_Layer1_summon_Game",
									UUID = "62f125a9_20e2_41c9_85ca_2dc93c3d2ffe",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									bgColorOpacity = "50",
									bIsOpenClipping = "False",
									classname = "MEPanel",
									colorType = "0;SingleColor:#FFFF4500;GraduallyChangingColorStart:#FFFFFFFF;GraduallyChangingColorEnd:#FFFFFFFF;vectorX:0;vectorY:0",
									DesignHeight = "640",
									DesignType = "0",
									DesignWidth = "960",
									dstBlendFunc = "771",
									height = "110",
									ignoreSize = "False",
									name = "Panel_head",
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
									width = "110",
									ZOrder = "1",
								},
								{
									controlID = "Image_carry_Panel_CloneItem_Panel_prefab_Panel-summonPointView_Layer1_summon_Game",
									UUID = "a1b5b517_84d2_473e_877c_725fbc8482d2",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "46",
									ignoreSize = "True",
									name = "Image_carry",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/bag/new_ui/new_10.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionY = -48,
									},
									width = "86",
									ZOrder = "1",
								},
								{
									controlID = "Image_select_Panel_CloneItem_Panel_prefab_Panel-summonPointView_Layer1_summon_Game",
									UUID = "129a5bbe_5d99_4738_9624_5f4e3f06232d",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "100",
									ignoreSize = "False",
									name = "Image_select",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/common/select.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										
									},
									width = "100",
									ZOrder = "1",
								},
								{
									controlID = "Image_lock_Panel_CloneItem_Panel_prefab_Panel-summonPointView_Layer1_summon_Game",
									UUID = "75eeb130_d900_4869_b09f_01149da0bd18",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "136",
									ignoreSize = "True",
									name = "Image_lock",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/common/lock.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										
									},
									width = "136",
									ZOrder = "1",
								},
								{
									controlID = "Image_selected_Panel_CloneItem_Panel_prefab_Panel-summonPointView_Layer1_summon_Game",
									UUID = "aa8f3ee4_79b2_47fb_b271_3aa1e102d8c5",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "54",
									ignoreSize = "True",
									name = "Image_selected",
									scaleX = "0.8",
									scaleY = "0.8",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/common/selected.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = 31,
										PositionY = 28,
									},
									width = "54",
									ZOrder = "1",
								},
							},
						},
						{
							controlID = "Image_cloneStar_Panel_prefab_Panel-summonPointView_Layer1_summon_Game",
							UUID = "06551315_30a8_44a8_ac1b_7f5a1bfc7820",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							backGroundScale9Enable = "False",
							classname = "MEImage",
							dstBlendFunc = "771",
							height = "20",
							ignoreSize = "True",
							name = "Image_cloneStar",
							scaleX = "0.8",
							scaleY = "0.8",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							texturePath = "ui/common/star.png",
							touchAble = "False",
							UILayoutViewModel = 
							{
								PositionX = -69,
								PositionY = 109,
							},
							width = "19",
							ZOrder = "1",
						},
						{
							controlID = "Panel_targetItem_Panel_prefab_Panel-summonPointView_Layer1_summon_Game",
							UUID = "f5bb8bf4_fb51_4bb3_b048_22b2acc672c9",
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
							name = "Panel_targetItem",
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
							width = "154",
							ZOrder = "1",
							components = 
							{
								
								{
									controlID = "Panel_head_Panel_targetItem_Panel_prefab_Panel-summonPointView_Layer1_summon_Game",
									UUID = "07dc701f_eec1_4098_84bc_7491ea5769ee",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									bgColorOpacity = "50",
									bIsOpenClipping = "False",
									classname = "MEPanel",
									colorType = "0;SingleColor:#FFFF4500;GraduallyChangingColorStart:#FFFFFFFF;GraduallyChangingColorEnd:#FFFFFFFF;vectorX:0;vectorY:0",
									DesignHeight = "640",
									DesignType = "0",
									DesignWidth = "960",
									dstBlendFunc = "771",
									height = "150",
									ignoreSize = "False",
									name = "Panel_head",
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
									width = "154",
									ZOrder = "1",
								},
								{
									controlID = "Image_select_Panel_targetItem_Panel_prefab_Panel-summonPointView_Layer1_summon_Game",
									UUID = "194998ac_c5f4_4748_96da_c20b5afeb45d",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "164",
									ignoreSize = "True",
									name = "Image_select",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/summon/exchange/equip_5.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										
									},
									width = "154",
									ZOrder = "1",
								},
								{
									controlID = "Image_itembg_Panel_targetItem_Panel_prefab_Panel-summonPointView_Layer1_summon_Game",
									UUID = "86f5d5cc_da15_4373_b2e6_1d5ee22ef583",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "121",
									ignoreSize = "True",
									name = "Image_itembg",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/fairy_particle/6.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										
									},
									width = "136",
									ZOrder = "1",
								},
								{
									controlID = "Image_icon_Panel_targetItem_Panel_prefab_Panel-summonPointView_Layer1_summon_Game",
									UUID = "ad5e26cf_8854_4bca_a703_b37bfff8994f",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "111",
									ignoreSize = "True",
									name = "Image_icon",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "icon/equipment/icon/192_166/icon3_guanghui_1.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										
									},
									width = "126",
									ZOrder = "1",
								},
								{
									controlID = "Image_textbg_Panel_targetItem_Panel_prefab_Panel-summonPointView_Layer1_summon_Game",
									UUID = "00deff4e_0500_4695_bb21_c8e60a0f0089",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "True;capInsetsX:0;capInsetsY:0;capInsetsWidth:0;capInsetsHeight:0",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "30",
									ignoreSize = "False",
									name = "Image_textbg",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/summon/exchange/equip_6.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionY = -92,
									},
									width = "158",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "Label_num_Image_textbg_Panel_targetItem_Panel_prefab_Panel-summonPointView_Layer1_summon_Game",
											UUID = "fd1a9c26_78dc_4022_bb67_0f83869d7d41",
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
											name = "Label_num",
											nTextAlign = "1",
											nTextHAlign = "1",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "770",
											text = "100",
											touchAble = "False",
											touchScaleEnable = "False",
											UILayoutViewModel = 
											{
												
											},
											width = "38",
											ZOrder = "1",
										},
									},
								},
								{
									controlID = "ScrollView_star_Panel_targetItem_Panel_prefab_Panel-summonPointView_Layer1_summon_Game",
									UUID = "655f55b7_f631_44d3_bfa6_c0acfa23a987",
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
									height = "20",
									ignoreSize = "False",
									innerHeight = "20",
									innerWidth = "50",
									name = "ScrollView_star",
									showScrollbar = "False",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionY = -48,
									},
									uipanelviewmodel = 
									{
										Layout="Absolute",
										nType = "0"
									},
									width = "50",
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
			"ui/summon/bg.png",
			"ui/summon/exchange/equip_7.png",
			"ui/summon/exchange/equip_8.png",
			"ui/summon/exchange/equip_9.png",
			"ui/common/scroll_bar_01.png",
			"ui/common/scroll_bar_02.png",
			"ui/summon/exchange/equip_3.png",
			"ui/summon/exchange/equip_1.png",
			"ui/summon/exchange/equip_2.png",
			"ui/summon/exchange/equip_4.png",
			"ui/bag/new_ui/new_10.png",
			"ui/common/select.png",
			"ui/common/lock.png",
			"ui/common/selected.png",
			"ui/common/star.png",
			"ui/summon/exchange/equip_5.png",
			"ui/fairy_particle/6.png",
			"icon/equipment/icon/192_166/icon3_guanghui_1.png",
			"ui/summon/exchange/equip_6.png",
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

