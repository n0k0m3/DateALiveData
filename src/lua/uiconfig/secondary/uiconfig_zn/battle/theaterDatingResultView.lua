local t = 
{
	version = 1,
	components = 
	{
		
		{
			controlID = "Panel-theaterDatingResultView_ui_battle_Game",
			UUID = "c97967f0_8e90_4da5_8786_6b84a0cc2d40",
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
			height = "750",
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
			width = "958",
			ZOrder = "1",
			components = 
			{
				
				{
					controlID = "Panel_touch_Panel-theaterDatingResultView_ui_battle_Game",
					UUID = "5e36769b_aa74_4134_8f3a_3c2da74b3201",
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
					controlID = "Panel_root_Panel-theaterDatingResultView_ui_battle_Game",
					UUID = "c22bbfe5_f48a_49b3_84da_48b74d4dcb6e",
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
							controlID = "Image_battleResul_bg_Panel_root_Panel-theaterDatingResultView_ui_battle_Game",
							UUID = "6b0374f3_5ba5_4d62_9aba_0020bbf6e9f2",
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
							controlID = "Image_battleResult_role_mirror_Panel_root_Panel-theaterDatingResultView_ui_battle_Game",
							UUID = "6d0a3f2e_679c_4034_969c_ee275886b245",
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
							controlID = "Spine_battleResult_splash_Panel_root_Panel-theaterDatingResultView_ui_battle_Game",
							UUID = "e1c0d826_512b_40f6_a130_5b9cc7c8bc0b",
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
							controlID = "Spine_battleResult_dian_Panel_root_Panel-theaterDatingResultView_ui_battle_Game",
							UUID = "27139b64_9780_4059_a788_ba49931b0ded",
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
							controlID = "Spine_battleResult_title_Panel_root_Panel-theaterDatingResultView_ui_battle_Game",
							UUID = "96999f03_95a0_42c7_964d_352c5bd9f91e",
							classname = "MESpine",
							dstBlendFunc = "771",
							name = "Spine_battleResult_title",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							spineModel = 
							{
								SpinePath = "effect/battle_end_win_02/out/battle_end_win_03",
								animationName = "battle_end_win3",
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
							visible = "False",
							ZOrder = "1",
						},
						{
							controlID = "Image_battleResult_hero_Panel_root_Panel-theaterDatingResultView_ui_battle_Game",
							UUID = "692a77b5_b9db_4088_bbe7_6a02dd42e1f5",
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
							controlID = "Label_continue_Panel_root_Panel-theaterDatingResultView_ui_battle_Game",
							UUID = "bd59ad1e_0a13_48de_86eb_8e375042db16",
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
							text = "点击屏幕继续",
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
							controlID = "Image_lingbo_Panel_root_Panel-theaterDatingResultView_ui_battle_Game",
							UUID = "b646e16d_2321_4400_8876_93689cbeff2f",
							anchorPoint = "False",
							anchorPointX = "1",
							anchorPointY = "0.5",
							backGroundScale9Enable = "False",
							classname = "MEImage",
							dstBlendFunc = "771",
							height = "40",
							ignoreSize = "True",
							name = "Image_lingbo",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							texturePath = "ui/battle/result/ui_08.png",
							touchAble = "False",
							UILayoutViewModel = 
							{
								PositionX = 551,
								PositionY = 139,
							},
							width = "210",
							ZOrder = "1",
							components = 
							{
								
								{
									controlID = "Label_lingbo_title_Image_lingbo_Panel_root_Panel-theaterDatingResultView_ui_battle_Game",
									UUID = "255a46df_7e51_4511_bab6_628659bd94f6",
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
									name = "Label_lingbo_title",
									nTextAlign = "1",
									nTextHAlign = "1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "通关时间",
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
									controlID = "Label_time_title_flag_Image_lingbo_Panel_root_Panel-theaterDatingResultView_ui_battle_Game",
									UUID = "57aac2a8_645a_4e60_aef4_4286bab4fb80",
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
									text = "Spirit",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionX = -7,
										PositionY = -12,
									},
									width = "32",
									ZOrder = "1",
								},
								{
									controlID = "Label_lingbo_progress_Image_lingbo_Panel_root_Panel-theaterDatingResultView_ui_battle_Game",
									UUID = "d9f2eb7e_966b_48ba_9edf_af2e19a29806",
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
									name = "Label_lingbo_progress",
									nTextAlign = "1",
									nTextHAlign = "1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "01:36",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionX = -5,
										PositionY = -48,
									},
									width = "69",
									ZOrder = "1",
								},
							},
						},
						{
							controlID = "Image_reward_Panel_root_Panel-theaterDatingResultView_ui_battle_Game",
							UUID = "7e3955a5_01e6_4f00_82c0_b93a9c86b44a",
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
								PositionX = 551,
								PositionY = -115,
							},
							width = "210",
							ZOrder = "1",
							components = 
							{
								
								{
									controlID = "Label_reward_title_Image_reward_Panel_root_Panel-theaterDatingResultView_ui_battle_Game",
									UUID = "07bffafb_fcc3_42bf_8d5e_a49ccfa3b495",
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
									text = "获得物品",
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
									controlID = "Label_time_title_flag_Image_reward_Panel_root_Panel-theaterDatingResultView_ui_battle_Game",
									UUID = "245145aa_2c5d_4cc5_9f43_afb72617d588",
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
									text = "Reward",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionX = -7,
										PositionY = -12,
									},
									width = "46",
									ZOrder = "1",
								},
								{
									controlID = "ScrollView_reward_Image_reward_Panel_root_Panel-theaterDatingResultView_ui_battle_Game",
									UUID = "8d563f9f_2364_440a_879e_81e8a614aaf2",
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

