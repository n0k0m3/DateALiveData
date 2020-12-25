local t = 
{
	version = 1,
	components = 
	{
		
		{
			controlID = "Panel-txjzResultView_ui_battle_Game",
			UUID = "ee3ce72c_2c5e_4739_b1a0_2bdaab21b461",
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
			height = "542",
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
			width = "886",
			ZOrder = "1",
			components = 
			{
				
				{
					controlID = "Panel_touch_Panel-txjzResultView_ui_battle_Game",
					UUID = "83f7a614_d10d_4db4_80f6_06e34f2f6bf7",
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
					name = "Panel_touch",
					sizepercentx = "100",
					sizepercenty = "100",
					sizeType = "1",
					srcBlendFunc = "1",
					touchAble = "True",
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
				},
				{
					controlID = "Panel_root_Panel-txjzResultView_ui_battle_Game",
					UUID = "f863c776_24a0_4b71_a0a2_7e18717a2724",
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
						PositionX = 443,
						PositionY = 271,
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
							controlID = "Image_battleResul_bg_Panel_root_Panel-txjzResultView_ui_battle_Game",
							UUID = "013e6dca_2fb4_428d_9288_31237e9fc177",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							backGroundScale9Enable = "False",
							classname = "MEImage",
							dstBlendFunc = "771",
							height = "640",
							ignoreSize = "True",
							name = "Image_battleResul_bg",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "770",
							texturePath = "ui/battle/result/bg.png",
							touchAble = "False",
							UILayoutViewModel = 
							{
								
							},
							width = "1386",
							ZOrder = "1",
						},
						{
							controlID = "Image_battleResult_role_mirror_Panel_root_Panel-txjzResultView_ui_battle_Game",
							UUID = "1b8523cf_1206_468b_8ddf_e21b22523ee7",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							backGroundScale9Enable = "False",
							classname = "MEImage",
							dstBlendFunc = "771",
							height = "64",
							ignoreSize = "True",
							name = "Image_battleResult_role_mirror",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							touchAble = "False",
							UILayoutViewModel = 
							{
								PositionX = -300,
							},
							width = "64",
							ZOrder = "1",
						},
						{
							controlID = "Spine_battleResult_splash_Panel_root_Panel-txjzResultView_ui_battle_Game",
							UUID = "2681140d_f8a0_466c_b389_c241264af2d8",
							classname = "MESpine",
							dstBlendFunc = "771",
							name = "Spine_battleResult_splash",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							spineModel = 
							{
								SpinePath = "effect/battle_end_win_02/out/battle_end_win_02",
								animationName = "loop",
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
								PositionX = 10,
							},
							visible = "False",
							ZOrder = "1",
						},
						{
							controlID = "Spine_battleResult_dian_Panel_root_Panel-txjzResultView_ui_battle_Game",
							UUID = "eb307e09_d876_4ffc_8357_377abccf0987",
							classname = "MESpine",
							dstBlendFunc = "771",
							name = "Spine_battleResult_dian",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							spineModel = 
							{
								SpinePath = "effect/battle_end_win_02/out/battle_end_win_01lizi",
								animationName = "animation",
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
								PositionX = 296,
								PositionY = 256,
							},
							ZOrder = "1",
						},
						{
							controlID = "Spine_battleResult_title_Panel_root_Panel-txjzResultView_ui_battle_Game",
							UUID = "a9980866_1048_43c1_aa46_dea6d0ba304e",
							classname = "MESpine",
							dstBlendFunc = "771",
							name = "Spine_battleResult_title",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							spineModel = 
							{
								SpinePath = "effect/battle_end_win_02/out/battle_end_win_01",
								animationName = "battle_end_win1",
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
								PositionX = 296,
								PositionY = 256,
							},
							ZOrder = "1",
						},
						{
							controlID = "Image_battleResult_hero_Panel_root_Panel-txjzResultView_ui_battle_Game",
							UUID = "fc127e68_5f3b_4b66_b6d5_079a7f1662d8",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							backGroundScale9Enable = "False",
							classname = "MEImage",
							dstBlendFunc = "771",
							height = "64",
							ignoreSize = "True",
							name = "Image_battleResult_hero",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							touchAble = "False",
							UILayoutViewModel = 
							{
								PositionX = -280,
								LeftPositon = 734,
								TopPosition = -32,
								relativeToName = "Panel",
							},
							width = "64",
							ZOrder = "1",
						},
						{
							controlID = "Label_continue_Panel_root_Panel-txjzResultView_ui_battle_Game",
							UUID = "19f6da81_d540_4209_b4ee_313ede892ff4",
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
							fontSize = "30",
							fontStroke = 
							{
								IsStroke = false,
								StrokeColor = "#FFE6E6E6",
								StrokeSize = 1,
							},
							height = "34",
							ignoreSize = "True",
							name = "Label_continue",
							nTextAlign = "1",
							nTextHAlign = "1",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "770",
							text = "Toca en cualquier lugar para continuar",
							touchAble = "False",
							touchScaleEnable = "False",
							UILayoutViewModel = 
							{
								PositionX = 549,
								PositionY = -293,
							},
							width = "183",
							ZOrder = "1",
						},
						{
							controlID = "Image_contribution_Panel_root_Panel-txjzResultView_ui_battle_Game",
							UUID = "c82bab6f_728e_4f7e_9309_3e43eb1a5e0f",
							anchorPoint = "False",
							anchorPointX = "1",
							anchorPointY = "0.5",
							backGroundScale9Enable = "False",
							classname = "MEImage",
							dstBlendFunc = "771",
							height = "40",
							ignoreSize = "True",
							name = "Image_contribution",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							texturePath = "ui/battle/result/ui_08.png",
							touchAble = "False",
							UILayoutViewModel = 
							{
								PositionX = 553,
								PositionY = 99,
							},
							width = "210",
							ZOrder = "1",
							components = 
							{
								
								{
									controlID = "Label_contribution_title_Image_contribution_Panel_root_Panel-txjzResultView_ui_battle_Game",
									UUID = "4ccc1855_a631_40f5_b6e7_1b1452225dca",
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
									name = "Label_contribution_title",
									nTextAlign = "1",
									nTextHAlign = "1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "Clasificación",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionX = -9,
										PositionY = 6,
									},
									width = "91",
									ZOrder = "1",
								},
								{
									controlID = "Label_time_title_flag_Image_contribution_Panel_root_Panel-txjzResultView_ui_battle_Game",
									UUID = "eaf0b7e6_2667_4568_922d_4f0e0dca4932",
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
									fontSize = "14",
									fontStroke = 
									{
										IsStroke = false,
										StrokeColor = "#FFE6E6E6",
										StrokeSize = 1,
									},
									height = "16",
									ignoreSize = "True",
									name = "Label_time_title_flag",
									nTextAlign = "1",
									nTextHAlign = "1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "Contribución",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionX = -7,
										PositionY = -12,
									},
									width = "76",
									ZOrder = "1",
								},
								{
									controlID = "Spine_cjtx_score_Image_contribution_Panel_root_Panel-txjzResultView_ui_battle_Game",
									UUID = "3e1c0e00_2e6e_4045_af02_b5971af65d18",
									classname = "MESpine",
									dstBlendFunc = "771",
									name = "Spine_cjtx_score",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									spineModel = 
									{
										SpinePath = "effect/effects_st_grade/effects_st_grade",
										animationName = "s_loop",
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
										PositionX = -59,
										PositionY = -84,
									},
									ZOrder = "1",
								},
							},
						},
						{
							controlID = "Image_hurt_Panel_root_Panel-txjzResultView_ui_battle_Game",
							UUID = "b697eb46_288f_4612_b9fe_420bbfd5922b",
							anchorPoint = "False",
							anchorPointX = "1",
							anchorPointY = "0.5",
							backGroundScale9Enable = "False",
							classname = "MEImage",
							dstBlendFunc = "771",
							height = "40",
							ignoreSize = "True",
							name = "Image_hurt",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							texturePath = "ui/battle/result/ui_08.png",
							touchAble = "False",
							UILayoutViewModel = 
							{
								PositionX = 553,
								PositionY = -72,
							},
							width = "210",
							ZOrder = "1",
							components = 
							{
								
								{
									controlID = "Label_hurt_title_Image_hurt_Panel_root_Panel-txjzResultView_ui_battle_Game",
									UUID = "cf132a53_b811_44ca_83e6_3e7c46e592d8",
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
									name = "Label_hurt_title",
									nTextAlign = "1",
									nTextHAlign = "1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "Clasificación de liquidación",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionX = -9,
										PositionY = 6,
									},
									width = "91",
									ZOrder = "1",
								},
								{
									controlID = "Label_time_title_flag_Image_hurt_Panel_root_Panel-txjzResultView_ui_battle_Game",
									UUID = "e4bb0eb6_f455_40f4_86b5_43b38d080315",
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
									fontSize = "14",
									fontStroke = 
									{
										IsStroke = false,
										StrokeColor = "#FFE6E6E6",
										StrokeSize = 1,
									},
									height = "16",
									ignoreSize = "True",
									name = "Label_time_title_flag",
									nTextAlign = "1",
									nTextHAlign = "1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "Estimado",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionX = -7,
										PositionY = -12,
									},
									width = "53",
									ZOrder = "1",
								},
								{
									controlID = "Label_hurt_Image_hurt_Panel_root_Panel-txjzResultView_ui_battle_Game",
									UUID = "5777c6f1_dbb2_421f_8576_b807e90ab92d",
									anchorPoint = "False",
									anchorPointX = "1",
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
									height = "25",
									ignoreSize = "True",
									name = "Label_hurt",
									nTextAlign = "1",
									nTextHAlign = "1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "544",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionY = -46,
									},
									width = "56",
									ZOrder = "1",
								},
							},
						},
						{
							controlID = "Image_reward_Panel_root_Panel-txjzResultView_ui_battle_Game",
							UUID = "1698940e_6eea_4214_919f_d52b03cc2f87",
							anchorPoint = "False",
							anchorPointX = "1",
							anchorPointY = "0.5",
							backGroundScale9Enable = "False",
							classname = "MEImage",
							dstBlendFunc = "771",
							height = "40",
							ignoreSize = "True",
							name = "Image_reward",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							texturePath = "ui/battle/result/ui_08.png",
							touchAble = "False",
							UILayoutViewModel = 
							{
								PositionX = 554,
								PositionY = -160,
							},
							width = "210",
							ZOrder = "1",
							components = 
							{
								
								{
									controlID = "Label_reward_title_Image_reward_Panel_root_Panel-txjzResultView_ui_battle_Game",
									UUID = "47e9ec65_1f7f_41ec_8baf_92254454eea9",
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
									name = "Label_reward_title",
									nTextAlign = "1",
									nTextHAlign = "1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "Conseguir objeto",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionX = -9,
										PositionY = 6,
									},
									width = "90",
									ZOrder = "1",
								},
								{
									controlID = "Label_time_title_flag_Image_reward_Panel_root_Panel-txjzResultView_ui_battle_Game",
									UUID = "16e7126c_5d18_4ab1_b656_9d3eb980598d",
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
									fontSize = "14",
									fontStroke = 
									{
										IsStroke = false,
										StrokeColor = "#FFE6E6E6",
										StrokeSize = 1,
									},
									height = "16",
									ignoreSize = "True",
									name = "Label_time_title_flag",
									nTextAlign = "1",
									nTextHAlign = "1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "Experiencia",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionX = -7,
										PositionY = -12,
									},
									width = "62",
									ZOrder = "1",
								},
								{
									controlID = "ScrollView_reward_Image_reward_Panel_root_Panel-txjzResultView_ui_battle_Game",
									UUID = "1fefa87a_f7ea_40af_a0bb_1406f177247e",
									anchorPoint = "False",
									anchorPointX = "1",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									bgColorOpacity = "50",
									bIsOpenClipping = "False",
									bounceEnable = "False",
									classname = "MEScrollView",
									colorType = "0;SingleColor:#FFE6E6E6;GraduallyChangingColorStart:#FFFFFFFF;GraduallyChangingColorEnd:#FFFFFFFF;vectorX:0;vectorY:0",
									direction = "2",
									dstBlendFunc = "771",
									height = "100",
									ignoreSize = "False",
									innerHeight = "100",
									innerWidth = "50",
									name = "ScrollView_reward",
									showScrollbar = "False",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = -2,
										PositionY = -24,
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
			"ui/battle/result/bg.png",
			"ui/battle/result/ui_08.png",
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

