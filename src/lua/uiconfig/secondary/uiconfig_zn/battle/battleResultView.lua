local t = 
{
	version = 1,
	components = 
	{
		
		{
			controlID = "Panel-battleResultView_ui_battle_Game",
			UUID = "3b520693_847f_47d5_9503_77000096596a",
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
					controlID = "Panel_touch_Panel-battleResultView_ui_battle_Game",
					UUID = "c9034422_0a17_41e6_bb50_c2b789971e58",
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
					controlID = "Panel_root_Panel-battleResultView_ui_battle_Game",
					UUID = "45ffac24_98c5_4a8b_a3ad_4bfa2657c711",
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
					touchAble = "True",
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
							controlID = "Image_battleResul_bg_Panel_root_Panel-battleResultView_ui_battle_Game",
							UUID = "085f7c9a_9e51_4bf6_be56_cabb285c8fed",
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
							controlID = "Image_battleResultView_4_Panel_root_Panel-battleResultView_ui_battle_Game",
							UUID = "0c357a5e_455f_49b0_85b9_ff944fec5ec8",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							backGroundScale9Enable = "False",
							classname = "MEImage",
							dstBlendFunc = "771",
							height = "2",
							ignoreSize = "True",
							name = "Image_battleResultView_4",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "770",
							texturePath = "ui/battle/result/ttrrrrrrr.png",
							touchAble = "False",
							UILayoutViewModel = 
							{
								
							},
							visible = "False",
							width = "2",
							ZOrder = "1",
						},
						{
							controlID = "Image_battleResult_role_mirror_Panel_root_Panel-battleResultView_ui_battle_Game",
							UUID = "582d9d39_8d4d_494c_b05a_432aa38d8ab9",
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
							controlID = "Spine_battleResult_splash_Panel_root_Panel-battleResultView_ui_battle_Game",
							UUID = "f976ce01_66e9_4f0f_bdb4_a05dd0681fce",
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
							controlID = "Spine_battleResult_dian_Panel_root_Panel-battleResultView_ui_battle_Game",
							UUID = "d20e2b7a_1ab4_41c8_90cc_9f74ad542e83",
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
							controlID = "Image_battleResult_hero_Panel_root_Panel-battleResultView_ui_battle_Game",
							UUID = "d7679392_ac16_4fa2_864f_1b7c263576c4",
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
								PositionX = -300,
								LeftPositon = 734,
								TopPosition = -32,
								relativeToName = "Panel",
							},
							width = "64",
							ZOrder = "1",
						},
						{
							controlID = "Panel_reward_Panel_root_Panel-battleResultView_ui_battle_Game",
							UUID = "d719bdb1_bd86_41df_ab93_a06481c4269e",
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
							height = "400",
							ignoreSize = "False",
							name = "Panel_reward",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							touchAble = "False",
							UILayoutViewModel = 
							{
								PositionX = 281,
							},
							uipanelviewmodel = 
							{
								Layout="Absolute",
								nType = "0"
							},
							visible = "False",
							width = "558",
							ZOrder = "1",
							components = 
							{
								
								{
									controlID = "ClippingNode_mask_Panel_reward_Panel_root_Panel-battleResultView_ui_battle_Game",
									UUID = "30538dc2_6638_466c_afad_0636447a3b51",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									classname = "MEClippingNode",
									clipNodeX = "0",
									clipNodeY = "0",
									dstBlendFunc = "771",
									height = "0",
									ignoreSize = "False",
									name = "ClippingNode_mask",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									stencilPath = "ui/head_mask1.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = -150,
										PositionY = 129,
										relativeToName = "Panel",
									},
									visible = "False",
									width = "0",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "Image_playerIcon_ClippingNode_mask_Panel_reward_Panel_root_Panel-battleResultView_ui_battle_Game",
											UUID = "4d84d8c8_0f7e_41a4_b351_90adbc4353f7",
											anchorPoint = "False",
											anchorPointX = "1",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											classname = "MEImage",
											dstBlendFunc = "771",
											height = "92",
											ignoreSize = "True",
											name = "Image_playerIcon",
											scaleX = "0.9",
											scaleY = "0.9",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											texturePath = "icon/hero/face/1101011.png",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 46,
											},
											width = "156",
											ZOrder = "1",
										},
									},
								},
								{
									controlID = "Label_playerName_Panel_reward_Panel_root_Panel-battleResultView_ui_battle_Game",
									UUID = "e58e27ce_be55_4a0e_9d5d_9a39d03a87a4",
									anchorPoint = "False",
									anchorPointX = "0",
									anchorPointY = "0.5",
									classname = "MELabel",
									compPath = "luacomponents.common.MEIconLabel",
									dstBlendFunc = "771",
									FontColor = "#FFFFDC73",
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
									name = "Label_playerName",
									nTextAlign = "1",
									nTextHAlign = "1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "商商商商商商商商",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionX = -89,
										PositionY = 138,
									},
									visible = "False",
									width = "163",
									ZOrder = "1",
								},
								{
									controlID = "Label_playerLevel_Panel_reward_Panel_root_Panel-battleResultView_ui_battle_Game",
									UUID = "bad1e7fa_8f1a_4c07_9d5f_dd1309c9c283",
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
									fontSize = "26",
									fontStroke = 
									{
										IsStroke = false,
										StrokeColor = "#FFE6E6E6",
										StrokeSize = 1,
									},
									height = "30",
									ignoreSize = "True",
									name = "Label_playerLevel",
									nTextAlign = "1",
									nTextHAlign = "1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "Lv24",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionX = 50,
										PositionY = 139,
									},
									visible = "False",
									width = "52",
									ZOrder = "1",
								},
								{
									controlID = "Image_role_bg_Panel_reward_Panel_root_Panel-battleResultView_ui_battle_Game",
									UUID = "6ebfcd7b_1b66_4192_89dc_44e36bb945b0",
									anchorPoint = "False",
									anchorPointX = "1",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "40",
									ignoreSize = "True",
									name = "Image_role_bg",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/battle/result/ui_06.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = 270,
										PositionY = 50,
									},
									width = "148",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "Label_role_exp_title_Image_role_bg_Panel_reward_Panel_root_Panel-battleResultView_ui_battle_Game",
											UUID = "5a700ade_c7e4_4f23_bc28_16a80d696f41",
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
											name = "Label_role_exp_title",
											nTextAlign = "1",
											nTextHAlign = "1",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "770",
											text = "精灵经验",
											touchAble = "False",
											touchScaleEnable = "False",
											UILayoutViewModel = 
											{
												PositionX = -6,
												PositionY = 5,
											},
											width = "91",
											ZOrder = "1",
										},
										{
											controlID = "Label_role_exp_flag_Image_role_bg_Panel_reward_Panel_root_Panel-battleResultView_ui_battle_Game",
											UUID = "b3a4b25a_463f_43a6_8b3e_a0e5dc6f8b13",
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
											name = "Label_role_exp_flag",
											nTextAlign = "1",
											nTextHAlign = "1",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "770",
											text = "Experience",
											touchAble = "False",
											touchScaleEnable = "False",
											UILayoutViewModel = 
											{
												PositionX = -11,
												PositionY = -11,
											},
											width = "65",
											ZOrder = "1",
										},
										{
											controlID = "Panel_role_exps_Image_role_bg_Panel_reward_Panel_root_Panel-battleResultView_ui_battle_Game",
											UUID = "bf1a15ce_eaf1_4a0e_bd4a_df867d6834ee",
											anchorPoint = "False",
											anchorPointX = "1",
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
											height = "110",
											ignoreSize = "False",
											name = "Panel_role_exps",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionY = -139,
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
									controlID = "Image_reward_Panel_reward_Panel_root_Panel-battleResultView_ui_battle_Game",
									UUID = "2baab100_84d1_4323_a74c_914bea05586e",
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
									texturePath = "ui/battle/result/ui_06.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = 270,
										PositionY = -119,
									},
									width = "148",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "Label_reward_title_Image_reward_Panel_reward_Panel_root_Panel-battleResultView_ui_battle_Game",
											UUID = "5889103a_c58f_44bb_9f83_37dfcec5dcc2",
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
											text = "获得奖励",
											touchAble = "False",
											touchScaleEnable = "False",
											UILayoutViewModel = 
											{
												PositionX = -6,
												PositionY = 5,
											},
											width = "90",
											ZOrder = "1",
										},
										{
											controlID = "Label_reward_flag_Image_reward_Panel_reward_Panel_root_Panel-battleResultView_ui_battle_Game",
											UUID = "8f927a52_36dd_4292_93ec_c840a0f55bd8",
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
											name = "Label_reward_flag",
											nTextAlign = "1",
											nTextHAlign = "1",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "770",
											text = "Rewards",
											touchAble = "False",
											touchScaleEnable = "False",
											UILayoutViewModel = 
											{
												PositionX = -11,
												PositionY = -11,
											},
											width = "53",
											ZOrder = "1",
										},
										{
											controlID = "Button_rightArrow_Image_reward_Panel_reward_Panel_root_Panel-battleResultView_ui_battle_Game",
											UUID = "c12c22a3_aca6_4b93_be8c_50dcd815fb7f",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											classname = "MEButton",
											ClickHighLightEnabled = "True",
											dstBlendFunc = "771",
											flipX = "False",
											flipY = "False",
											height = "34",
											ignoreSize = "True",
											name = "Button_rightArrow",
											normal = "ui/battle/n208.png",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "True",
											UILayoutViewModel = 
											{
												PositionX = 180,
												PositionY = -134,
											},
											UItype = "Button",
											visible = "False",
											width = "20",
											ZOrder = "1",
										},
										{
											controlID = "Button_leftArrow_Image_reward_Panel_reward_Panel_root_Panel-battleResultView_ui_battle_Game",
											UUID = "0ce3b6cc_6ca6_4dfc_b696_c361457ec1ab",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											classname = "MEButton",
											ClickHighLightEnabled = "True",
											dstBlendFunc = "771",
											flipX = "True",
											flipY = "False",
											height = "34",
											ignoreSize = "True",
											name = "Button_leftArrow",
											normal = "ui/battle/n208.png",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "True",
											UILayoutViewModel = 
											{
												PositionX = -216,
												PositionY = -133,
											},
											UItype = "Button",
											visible = "False",
											width = "20",
											ZOrder = "1",
										},
										{
											controlID = "ScrollView_reward_Image_reward_Panel_reward_Panel_root_Panel-battleResultView_ui_battle_Game",
											UUID = "8190c6a0_8d20_43db_bad8_68a18183c818",
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
											height = "100",
											ignoreSize = "False",
											innerHeight = "100",
											innerWidth = "480",
											name = "ScrollView_reward",
											showScrollbar = "False",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionY = -72,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "480",
											ZOrder = "1",
										},
										{
											controlID = "Image_mass_sign_Image_reward_Panel_reward_Panel_root_Panel-battleResultView_ui_battle_Game",
											UUID = "80ccadcf_ebab_4b94_99fa_ff184a4bb1cc",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											classname = "MEImage",
											dstBlendFunc = "771",
											height = "32",
											ignoreSize = "True",
											name = "Image_mass_sign",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											texturePath = "ui/fight_result/reward_rise.png",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = -190,
											},
											visible = "False",
											width = "118",
											ZOrder = "1",
										},
									},
								},
								{
									controlID = "PageView_reward_Panel_reward_Panel_root_Panel-battleResultView_ui_battle_Game",
									UUID = "facaeb0a_c51f_40b1_87b7_a3f2e3dc1e1d",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									bgColorOpacity = "50",
									bIsOpenClipping = "True",
									bounceEnable = "False",
									classname = "MEPageView",
									colorType = "0;SingleColor:#FFE6E6E6;GraduallyChangingColorStart:#FFFFFFFF;GraduallyChangingColorEnd:#FFFFFFFF;vectorX:0;vectorY:0",
									DesignHeight = "640",
									DesignType = "0",
									DesignWidth = "960",
									dstBlendFunc = "771",
									height = "100",
									ignoreSize = "False",
									name = "PageView_reward",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = 33,
										PositionY = -191,
									},
									uipanelviewmodel = 
									{
										Layout="Absolute",
										nType = "0"
									},
									width = "480",
									ZOrder = "1",
								},
								{
									controlID = "Panel_extend_Panel_reward_Panel_root_Panel-battleResultView_ui_battle_Game",
									UUID = "b0e67341_6eac_4e5c_9be1_838c6b373db1",
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
									height = "0",
									ignoreSize = "False",
									name = "Panel_extend",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = 270,
										PositionY = 139,
									},
									uipanelviewmodel = 
									{
										Layout="Absolute",
										nType = "0"
									},
									width = "0",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "Image_exp_bg_Panel_extend_Panel_reward_Panel_root_Panel-battleResultView_ui_battle_Game",
											UUID = "916b4e28_416a_44d5_9aca_81c9e45a8b39",
											anchorPoint = "False",
											anchorPointX = "1",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											classname = "MEImage",
											dstBlendFunc = "771",
											height = "40",
											ignoreSize = "True",
											name = "Image_exp_bg",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											texturePath = "ui/battle/result/ui_08.png",
											touchAble = "False",
											UILayoutViewModel = 
											{
												
											},
											width = "210",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "Label_exp_title_Image_exp_bg_Panel_extend_Panel_reward_Panel_root_Panel-battleResultView_ui_battle_Game",
													UUID = "c949d7ce_d33a_4bc3_806a_1746ddbb5b25",
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
													name = "Label_exp_title",
													nTextAlign = "1",
													nTextHAlign = "1",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "770",
													text = "个人经验",
													touchAble = "False",
													touchScaleEnable = "False",
													UILayoutViewModel = 
													{
														PositionX = -6,
														PositionY = 5,
													},
													width = "91",
													ZOrder = "1",
												},
												{
													controlID = "Label_exp_title_flag_Image_exp_bg_Panel_extend_Panel_reward_Panel_root_Panel-battleResultView_ui_battle_Game",
													UUID = "772f372f_38c0_4219_b99d_ddf3559e5220",
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
													name = "Label_exp_title_flag",
													nTextAlign = "1",
													nTextHAlign = "1",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "770",
													text = "Experience",
													touchAble = "False",
													touchScaleEnable = "False",
													UILayoutViewModel = 
													{
														PositionX = -11,
														PositionY = -11,
													},
													width = "65",
													ZOrder = "1",
												},
												{
													controlID = "Image_playerExp_Image_exp_bg_Panel_extend_Panel_reward_Panel_root_Panel-battleResultView_ui_battle_Game",
													UUID = "e2e54696_74ae_47de_9c20_d97e09501045",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0.5",
													backGroundScale9Enable = "True;capInsetsX:0;capInsetsY:0;capInsetsWidth:0;capInsetsHeight:0",
													classname = "MEImage",
													dstBlendFunc = "771",
													height = "14",
													ignoreSize = "False",
													name = "Image_playerExp",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "1",
													texturePath = "ui/common/progress_01.png",
													touchAble = "False",
													UILayoutViewModel = 
													{
														PositionX = -101,
														PositionY = -33,
													},
													width = "200",
													ZOrder = "1",
													components = 
													{
														
														{
															controlID = "LoadingBar_playerExp_Image_playerExp_Image_exp_bg_Panel_extend_Panel_reward_Panel_root_Panel-battleResultView_ui_battle_Game",
															UUID = "2e515962_d438_4727_9a0b_b230265ec5a1",
															anchorPoint = "False",
															anchorPointX = "0.5",
															anchorPointY = "0.5",
															backGroundScale9Enable = "True;capInsetsX:0;capInsetsY:0;capInsetsWidth:0;capInsetsHeight:0",
															classname = "MELoadingBar",
															direction = "0",
															dstBlendFunc = "771",
															height = "10",
															ignoreSize = "False",
															name = "LoadingBar_playerExp",
															percent = "100",
															sizepercentx = "0",
															sizepercenty = "0",
															sizeType = "0",
															srcBlendFunc = "1",
															texture = "ui/common/progress_02.png",
															touchAble = "False",
															UILayoutViewModel = 
															{
																
															},
															width = "200",
															ZOrder = "1",
														},
													},
												},
												{
													controlID = "Label_playerExp_Image_exp_bg_Panel_extend_Panel_reward_Panel_root_Panel-battleResultView_ui_battle_Game",
													UUID = "d060914d_3d4d_4053_b6c8_c0d35928eea7",
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
														IsStroke = false,
														StrokeColor = "#FFE6E6E6",
														StrokeSize = 1,
													},
													height = "23",
													ignoreSize = "True",
													name = "Label_playerExp",
													nTextAlign = "1",
													nTextHAlign = "1",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "770",
													text = "+30000",
													touchAble = "False",
													touchScaleEnable = "False",
													UILayoutViewModel = 
													{
														PositionX = 2,
														PositionY = -53,
													},
													width = "70",
													ZOrder = "1",
												},
											},
										},
										{
											controlID = "Image_extend_Panel_extend_Panel_reward_Panel_root_Panel-battleResultView_ui_battle_Game",
											UUID = "968580b0_cd7c_44a1_8996_dbbe184d3dd1",
											anchorPoint = "False",
											anchorPointX = "1",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											classname = "MEImage",
											dstBlendFunc = "771",
											height = "40",
											ignoreSize = "True",
											name = "Image_extend",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											texturePath = "ui/battle/result/ui_06.png",
											touchAble = "False",
											UILayoutViewModel = 
											{
												
											},
											width = "148",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "Label_extend_title_Image_extend_Panel_extend_Panel_reward_Panel_root_Panel-battleResultView_ui_battle_Game",
													UUID = "d57f24cc_28ab_4a52_b9f8_79da30df4290",
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
													name = "Label_extend_title",
													nTextAlign = "1",
													nTextHAlign = "1",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "770",
													text = "贡献度",
													touchAble = "False",
													touchScaleEnable = "False",
													UILayoutViewModel = 
													{
														PositionX = -6,
														PositionY = 5,
													},
													width = "69",
													ZOrder = "1",
												},
												{
													controlID = "Label_extend_title_en_Image_extend_Panel_extend_Panel_reward_Panel_root_Panel-battleResultView_ui_battle_Game",
													UUID = "44677245_940f_4653_8026_7e8d10f0dd31",
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
													name = "Label_extend_title_en",
													nTextAlign = "1",
													nTextHAlign = "1",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "770",
													text = "Contribution",
													touchAble = "False",
													touchScaleEnable = "False",
													UILayoutViewModel = 
													{
														PositionX = -11,
														PositionY = -11,
													},
													width = "76",
													ZOrder = "1",
												},
												{
													controlID = "Label_extend_value_Image_extend_Panel_extend_Panel_reward_Panel_root_Panel-battleResultView_ui_battle_Game",
													UUID = "d309de0b_2bb4_45d3_9bc4_4163fb9897fd",
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
														IsStroke = false,
														StrokeColor = "#FFE6E6E6",
														StrokeSize = 1,
													},
													height = "23",
													ignoreSize = "True",
													name = "Label_extend_value",
													nTextAlign = "1",
													nTextHAlign = "1",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "770",
													text = "+0",
													touchAble = "False",
													touchScaleEnable = "False",
													UILayoutViewModel = 
													{
														PositionX = 2,
														PositionY = -42,
													},
													width = "26",
													ZOrder = "1",
												},
											},
										},
									},
								},
							},
						},
						{
							controlID = "Panel_evaluation_Panel_root_Panel-battleResultView_ui_battle_Game",
							UUID = "b7e1da82_f9e0_49a6_9116_2196ab7e211e",
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
							height = "400",
							ignoreSize = "False",
							name = "Panel_evaluation",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							touchAble = "False",
							UILayoutViewModel = 
							{
								PositionX = 285,
							},
							uipanelviewmodel = 
							{
								Layout="Absolute",
								nType = "0"
							},
							width = "558",
							ZOrder = "1",
							components = 
							{
								
								{
									controlID = "Image_pass_time_Panel_evaluation_Panel_root_Panel-battleResultView_ui_battle_Game",
									UUID = "46356c88_4a40_4a31_b152_578792a67dec",
									anchorPoint = "False",
									anchorPointX = "1",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "40",
									ignoreSize = "True",
									name = "Image_pass_time",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/battle/result/ui_08.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = 266,
										PositionY = 139,
									},
									width = "210",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "Label_time_title_Image_pass_time_Panel_evaluation_Panel_root_Panel-battleResultView_ui_battle_Game",
											UUID = "d43a155a_6de3_4a43_9ff8_1a1ffa4aae7b",
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
											name = "Label_time_title",
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
											controlID = "Label_time_title_flag_Image_pass_time_Panel_evaluation_Panel_root_Panel-battleResultView_ui_battle_Game",
											UUID = "6b99f5ba_edce_4ff3_a5ab_5d7f2e6a66ca",
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
											text = "Time",
											touchAble = "False",
											touchScaleEnable = "False",
											UILayoutViewModel = 
											{
												PositionX = -7,
												PositionY = -12,
											},
											width = "31",
											ZOrder = "1",
										},
										{
											controlID = "Label_pass_time_Image_pass_time_Panel_evaluation_Panel_root_Panel-battleResultView_ui_battle_Game",
											UUID = "f86071c8_f3b9_4982_a174_1bb94f2c1e20",
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
											fontSize = "30",
											fontStroke = 
											{
												IsStroke = false,
												StrokeColor = "#FFE6E6E6",
												StrokeSize = 1,
											},
											height = "34",
											ignoreSize = "True",
											name = "Label_pass_time",
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
												PositionX = -43,
												PositionY = -48,
											},
											width = "69",
											ZOrder = "1",
										},
									},
								},
								{
									controlID = "Image_battleResultView_2(3)_Panel_evaluation_Panel_root_Panel-battleResultView_ui_battle_Game",
									UUID = "5be8c796_276a_4cce_97d7_160ce7365b4d",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "38",
									ignoreSize = "True",
									name = "Image_battleResultView_2(3)",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/fight_result/xiaoguo.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = -64,
										PositionY = -65,
									},
									visible = "False",
									width = "314",
									ZOrder = "1",
								},
								{
									controlID = "Image_battleResultView_2(2)_Panel_evaluation_Panel_root_Panel-battleResultView_ui_battle_Game",
									UUID = "6c37db6f_d61a_4b88_9aa9_5d47d508ec4f",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "38",
									ignoreSize = "True",
									name = "Image_battleResultView_2(2)",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/fight_result/xiaoguo.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = -75,
										PositionY = -106,
									},
									visible = "False",
									width = "314",
									ZOrder = "1",
								},
								{
									controlID = "Image_battleResultView_2_Panel_evaluation_Panel_root_Panel-battleResultView_ui_battle_Game",
									UUID = "e3740f51_fcc7_49ae_9f6e_8abddf4ed215",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "38",
									ignoreSize = "True",
									name = "Image_battleResultView_2",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/fight_result/xiaoguo.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = -86,
										PositionY = -149,
									},
									visible = "False",
									width = "314",
									ZOrder = "1",
								},
								{
									controlID = "Image_pass_review_Panel_evaluation_Panel_root_Panel-battleResultView_ui_battle_Game",
									UUID = "64ea8e6c_e272_4afa_b49c_18e8a7c25296",
									anchorPoint = "False",
									anchorPointX = "1",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "40",
									ignoreSize = "True",
									name = "Image_pass_review",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/battle/result/ui_06.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = 266,
										PositionY = 50,
									},
									visible = "False",
									width = "148",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "Label_review_title_Image_pass_review_Panel_evaluation_Panel_root_Panel-battleResultView_ui_battle_Game",
											UUID = "2b8f50ee_7b43_4ce2_b795_339ae1de9f2b",
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
											name = "Label_review_title",
											nTextAlign = "1",
											nTextHAlign = "1",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "770",
											text = "评价",
											touchAble = "False",
											touchScaleEnable = "False",
											UILayoutViewModel = 
											{
												PositionX = -6,
												PositionY = 4,
											},
											width = "47",
											ZOrder = "1",
										},
										{
											controlID = "Label_review_title_flag_Image_pass_review_Panel_evaluation_Panel_root_Panel-battleResultView_ui_battle_Game",
											UUID = "94900590_0433_41d4_a3d2_f1714251aaf3",
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
											name = "Label_review_title_flag",
											nTextAlign = "1",
											nTextHAlign = "1",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "770",
											text = "Estimate",
											touchAble = "False",
											touchScaleEnable = "False",
											UILayoutViewModel = 
											{
												PositionX = -6,
												PositionY = -13,
											},
											width = "53",
											ZOrder = "1",
										},
										{
											controlID = "Panel_target_1_Image_pass_review_Panel_evaluation_Panel_root_Panel-battleResultView_ui_battle_Game",
											UUID = "0cf1bb9e_4697_4968_bb63_51c5f5653465",
											anchorPoint = "False",
											anchorPointX = "1",
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
											height = "30",
											ignoreSize = "False",
											name = "Panel_target_1",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionY = -57,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "300",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "Image_star_Panel_target_1_Image_pass_review_Panel_evaluation_Panel_root_Panel-battleResultView_ui_battle_Game",
													UUID = "fa792bc0_0f0f_4865_9fae_dbf179de3415",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0.5",
													backGroundScale9Enable = "False",
													classname = "MEImage",
													dstBlendFunc = "771",
													height = "30",
													ignoreSize = "True",
													name = "Image_star",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "1",
													texturePath = "ui/fuben/fightingStar.png",
													touchAble = "False",
													UILayoutViewModel = 
													{
														PositionX = -15,
													},
													width = "28",
													ZOrder = "1",
												},
												{
													controlID = "Image_star_gray_Panel_target_1_Image_pass_review_Panel_evaluation_Panel_root_Panel-battleResultView_ui_battle_Game",
													UUID = "d7949c70_7a45_4fdd_b6c1_c4e9aaa4844c",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0.5",
													backGroundScale9Enable = "False",
													classname = "MEImage",
													dstBlendFunc = "771",
													height = "30",
													ignoreSize = "True",
													name = "Image_star_gray",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "1",
													texturePath = "ui/fuben/fightStar_gray.png",
													touchAble = "False",
													UILayoutViewModel = 
													{
														PositionX = -15,
													},
													width = "28",
													ZOrder = "1",
												},
												{
													controlID = "Label_target_Panel_target_1_Image_pass_review_Panel_evaluation_Panel_root_Panel-battleResultView_ui_battle_Game",
													UUID = "3f79e1e0_0004_47f8_9e37_87f3c78ca615",
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
													name = "Label_target",
													nTextAlign = "1",
													nTextHAlign = "1",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "770",
													text = "血量高于80%",
													touchAble = "False",
													touchScaleEnable = "False",
													UILayoutViewModel = 
													{
														PositionX = -39,
													},
													width = "131",
													ZOrder = "1",
												},
												{
													controlID = "Label_target_gray_Panel_target_1_Image_pass_review_Panel_evaluation_Panel_root_Panel-battleResultView_ui_battle_Game",
													UUID = "e5e0c0c6_0515_4e41_b3f8_6970b0f35573",
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
													name = "Label_target_gray",
													nTextAlign = "1",
													nTextHAlign = "1",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "770",
													text = "血量大于80%",
													touchAble = "False",
													touchScaleEnable = "False",
													UILayoutViewModel = 
													{
														PositionX = -39,
													},
													width = "131",
													ZOrder = "1",
												},
											},
										},
										{
											controlID = "Panel_target_2_Image_pass_review_Panel_evaluation_Panel_root_Panel-battleResultView_ui_battle_Game",
											UUID = "fe3c9998_0ece_4046_b7c4_4ce2ff8f9be9",
											anchorPoint = "False",
											anchorPointX = "1",
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
											height = "30",
											ignoreSize = "False",
											name = "Panel_target_2",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionY = -107,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "300",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "Image_star_Panel_target_2_Image_pass_review_Panel_evaluation_Panel_root_Panel-battleResultView_ui_battle_Game",
													UUID = "be5cd4c0_dd67_4f1f_9406_fea8662c0db8",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0.5",
													backGroundScale9Enable = "False",
													classname = "MEImage",
													dstBlendFunc = "771",
													height = "30",
													ignoreSize = "True",
													name = "Image_star",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "1",
													texturePath = "ui/fuben/fightingStar.png",
													touchAble = "False",
													UILayoutViewModel = 
													{
														PositionX = -15,
													},
													width = "28",
													ZOrder = "1",
												},
												{
													controlID = "Image_star_gray_Panel_target_2_Image_pass_review_Panel_evaluation_Panel_root_Panel-battleResultView_ui_battle_Game",
													UUID = "d356f47f_b0e0_4e03_b3cb_0527ce996b9c",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0.5",
													backGroundScale9Enable = "False",
													classname = "MEImage",
													dstBlendFunc = "771",
													height = "30",
													ignoreSize = "True",
													name = "Image_star_gray",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "1",
													texturePath = "ui/fuben/fightStar_gray.png",
													touchAble = "False",
													UILayoutViewModel = 
													{
														PositionX = -15,
													},
													width = "28",
													ZOrder = "1",
												},
												{
													controlID = "Label_target_Panel_target_2_Image_pass_review_Panel_evaluation_Panel_root_Panel-battleResultView_ui_battle_Game",
													UUID = "743493ca_11b1_4866_9f01_36f812dad8ba",
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
													name = "Label_target",
													nTextAlign = "1",
													nTextHAlign = "1",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "770",
													text = "血量大于80%",
													touchAble = "False",
													touchScaleEnable = "False",
													UILayoutViewModel = 
													{
														PositionX = -39,
													},
													width = "131",
													ZOrder = "1",
												},
												{
													controlID = "Label_target_gray_Panel_target_2_Image_pass_review_Panel_evaluation_Panel_root_Panel-battleResultView_ui_battle_Game",
													UUID = "23584742_f1a0_42f9_aef6_191b648375e3",
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
													name = "Label_target_gray",
													nTextAlign = "1",
													nTextHAlign = "1",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "770",
													text = "血量大于80%",
													touchAble = "False",
													touchScaleEnable = "False",
													UILayoutViewModel = 
													{
														PositionX = -39,
													},
													width = "131",
													ZOrder = "1",
												},
											},
										},
										{
											controlID = "Panel_target_3_Image_pass_review_Panel_evaluation_Panel_root_Panel-battleResultView_ui_battle_Game",
											UUID = "84b9d4ba_2e3a_4ac7_8908_c328646c4ce9",
											anchorPoint = "False",
											anchorPointX = "1",
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
											height = "30",
											ignoreSize = "False",
											name = "Panel_target_3",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionY = -154,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "300",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "Image_star_Panel_target_3_Image_pass_review_Panel_evaluation_Panel_root_Panel-battleResultView_ui_battle_Game",
													UUID = "77a4c561_c660_491a_8de9_0993d20a29bf",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0.5",
													backGroundScale9Enable = "False",
													classname = "MEImage",
													dstBlendFunc = "771",
													height = "30",
													ignoreSize = "True",
													name = "Image_star",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "1",
													texturePath = "ui/fuben/fightingStar.png",
													touchAble = "False",
													UILayoutViewModel = 
													{
														PositionX = -15,
													},
													width = "28",
													ZOrder = "1",
												},
												{
													controlID = "Image_star_gray_Panel_target_3_Image_pass_review_Panel_evaluation_Panel_root_Panel-battleResultView_ui_battle_Game",
													UUID = "a09fa172_c72a_4637_9cbb_ba5e250580e7",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0.5",
													backGroundScale9Enable = "False",
													classname = "MEImage",
													dstBlendFunc = "771",
													height = "30",
													ignoreSize = "True",
													name = "Image_star_gray",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "1",
													texturePath = "ui/fuben/fightStar_gray.png",
													touchAble = "False",
													UILayoutViewModel = 
													{
														PositionX = -15,
													},
													width = "28",
													ZOrder = "1",
												},
												{
													controlID = "Label_target_Panel_target_3_Image_pass_review_Panel_evaluation_Panel_root_Panel-battleResultView_ui_battle_Game",
													UUID = "902dc9f2_f1fe_4a4b_9b24_8b31444b1a13",
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
													name = "Label_target",
													nTextAlign = "1",
													nTextHAlign = "1",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "770",
													text = "血量大于80%",
													touchAble = "False",
													touchScaleEnable = "False",
													UILayoutViewModel = 
													{
														PositionX = -39,
													},
													width = "131",
													ZOrder = "1",
												},
												{
													controlID = "Label_target_gray_Panel_target_3_Image_pass_review_Panel_evaluation_Panel_root_Panel-battleResultView_ui_battle_Game",
													UUID = "fab980af_1d45_4b29_a5b4_9a357f76699e",
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
													name = "Label_target_gray",
													nTextAlign = "1",
													nTextHAlign = "1",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "770",
													text = "血量大于80%",
													touchAble = "False",
													touchScaleEnable = "False",
													UILayoutViewModel = 
													{
														PositionX = -39,
													},
													width = "131",
													ZOrder = "1",
												},
											},
										},
									},
								},
								{
									controlID = "Image_endless_Panel_evaluation_Panel_root_Panel-battleResultView_ui_battle_Game",
									UUID = "0298da60_cb9c_48e5_8a03_013d15d5dc9e",
									anchorPoint = "False",
									anchorPointX = "1",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "40",
									ignoreSize = "True",
									name = "Image_endless",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/battle/result/ui_06.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = 266,
										PositionY = 50,
									},
									visible = "False",
									width = "148",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "Label_endless_title_Image_endless_Panel_evaluation_Panel_root_Panel-battleResultView_ui_battle_Game",
											UUID = "eac30a1f_94b6_4348_8ad1_f7c22b171ad4",
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
											fontSize = "24",
											fontStroke = 
											{
												IsStroke = false,
												StrokeColor = "#FFE6E6E6",
												StrokeSize = 1,
											},
											height = "27",
											ignoreSize = "True",
											name = "Label_endless_title",
											nTextAlign = "1",
											nTextHAlign = "1",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "770",
											text = "最高层数",
											touchAble = "False",
											touchScaleEnable = "False",
											UILayoutViewModel = 
											{
												PositionX = -6,
												PositionY = 4,
												LeftPositon = 1188,
												TopPosition = -22,
												relativeToName = "Panel",
											},
											width = "99",
											ZOrder = "1",
										},
										{
											controlID = "Label_endless_title_flag_Image_endless_Panel_evaluation_Panel_root_Panel-battleResultView_ui_battle_Game",
											UUID = "ae6756dc_c75a_4120_9641_1d78e8a1e429",
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
											name = "Label_endless_title_flag",
											nTextAlign = "1",
											nTextHAlign = "1",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "770",
											text = "Max floor",
											touchAble = "False",
											touchScaleEnable = "False",
											UILayoutViewModel = 
											{
												PositionX = -6,
												PositionY = -13,
											},
											width = "61",
											ZOrder = "1",
										},
										{
											controlID = "Label_endless_level_Image_endless_Panel_evaluation_Panel_root_Panel-battleResultView_ui_battle_Game",
											UUID = "a409b500_8242_4032_8b32_7d31b4be1273",
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
											fontSize = "32",
											fontStroke = 
											{
												IsStroke = false,
												StrokeColor = "#FFE6E6E6",
												StrokeSize = 1,
											},
											height = "37",
											ignoreSize = "True",
											name = "Label_endless_level",
											nTextAlign = "1",
											nTextHAlign = "1",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "770",
											text = "43层",
											touchAble = "False",
											touchScaleEnable = "False",
											UILayoutViewModel = 
											{
												PositionX = -7,
												PositionY = -50,
											},
											width = "68",
											ZOrder = "1",
										},
									},
								},
								{
									controlID = "Image_lingbo_Panel_evaluation_Panel_root_Panel-battleResultView_ui_battle_Game",
									UUID = "9a8044ca_74af_4988_a4e9_955ff48c6420",
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
										PositionX = 266,
										PositionY = -155,
									},
									visible = "False",
									width = "210",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "Label_lingbo_title_Image_lingbo_Panel_evaluation_Panel_root_Panel-battleResultView_ui_battle_Game",
											UUID = "4776be19_b160_4399_8110_d57ec18ce896",
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
											text = "灵波值",
											touchAble = "False",
											touchScaleEnable = "False",
											UILayoutViewModel = 
											{
												PositionX = -9,
												PositionY = 6,
											},
											width = "69",
											ZOrder = "1",
										},
										{
											controlID = "Label_time_title_flag_Image_lingbo_Panel_evaluation_Panel_root_Panel-battleResultView_ui_battle_Game",
											UUID = "c5d04af5_4623_42d8_a0fe_2230979d32ce",
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
											controlID = "Label_lingbo_progress_Image_lingbo_Panel_evaluation_Panel_root_Panel-battleResultView_ui_battle_Game",
											UUID = "72c4fcf4_626b_47dc_8e82_2ce5c3656523",
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
									controlID = "Image_contribution_Panel_evaluation_Panel_root_Panel-battleResultView_ui_battle_Game",
									UUID = "c3531fdf_0aae_472e_b862_4be63aa3cfec",
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
										PositionX = 266,
										PositionY = 139,
									},
									visible = "False",
									width = "210",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "Label_contribution_title_Image_contribution_Panel_evaluation_Panel_root_Panel-battleResultView_ui_battle_Game",
											UUID = "83e1380a_dce6_4b46_8934_940d055aaa89",
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
											text = "个人贡献度",
											touchAble = "False",
											touchScaleEnable = "False",
											UILayoutViewModel = 
											{
												PositionX = -9,
												PositionY = 6,
											},
											width = "113",
											ZOrder = "1",
										},
										{
											controlID = "Label_time_title_flag_Image_contribution_Panel_evaluation_Panel_root_Panel-battleResultView_ui_battle_Game",
											UUID = "b55064c6_707b_4afb_93c5_8679bab87783",
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
											text = "Contribution",
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
											controlID = "Label_contribution_Image_contribution_Panel_evaluation_Panel_root_Panel-battleResultView_ui_battle_Game",
											UUID = "8e60cbe5_7fbc_44c0_887b_4eee86edcbdb",
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
											name = "Label_contribution",
											nTextAlign = "1",
											nTextHAlign = "1",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "770",
											text = "+30000",
											touchAble = "False",
											touchScaleEnable = "False",
											UILayoutViewModel = 
											{
												PositionY = -48,
											},
											width = "101",
											ZOrder = "1",
										},
									},
								},
								{
									controlID = "Image_skyladder_fight_Panel_evaluation_Panel_root_Panel-battleResultView_ui_battle_Game",
									UUID = "2cb202bb_dfc9_4569_bedd_0b5236cd2f99",
									anchorPoint = "False",
									anchorPointX = "1",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "40",
									ignoreSize = "True",
									name = "Image_skyladder_fight",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/battle/result/ui_06.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = 266,
										PositionY = 50,
									},
									visible = "False",
									width = "148",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "Label_ladder_fight_title_Image_skyladder_fight_Panel_evaluation_Panel_root_Panel-battleResultView_ui_battle_Game",
											UUID = "aa3e6eb6_91ae_4a6c_be3b_b99aed7be612",
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
											fontSize = "24",
											fontStroke = 
											{
												IsStroke = false,
												StrokeColor = "#FFE6E6E6",
												StrokeSize = 1,
											},
											height = "27",
											ignoreSize = "True",
											name = "Label_ladder_fight_title",
											nTextAlign = "1",
											nTextHAlign = "1",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "770",
											text = "作战评分",
											touchAble = "False",
											touchScaleEnable = "False",
											UILayoutViewModel = 
											{
												PositionX = -6,
												PositionY = 4,
												LeftPositon = 1188,
												TopPosition = -22,
												relativeToName = "Panel",
											},
											width = "99",
											ZOrder = "1",
										},
										{
											controlID = "Label_ladder_fight_title_en_Image_skyladder_fight_Panel_evaluation_Panel_root_Panel-battleResultView_ui_battle_Game",
											UUID = "b967bc15_a993_4f28_b4b4_ef29b4cd6ebc",
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
											name = "Label_ladder_fight_title_en",
											nTextAlign = "1",
											nTextHAlign = "1",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "770",
											text = "Basic Rate",
											touchAble = "False",
											touchScaleEnable = "False",
											UILayoutViewModel = 
											{
												PositionX = -6,
												PositionY = -13,
											},
											width = "64",
											ZOrder = "1",
										},
										{
											controlID = "Label_ladder_fight_core_Image_skyladder_fight_Panel_evaluation_Panel_root_Panel-battleResultView_ui_battle_Game",
											UUID = "0ebd190e_85ff_456a_963a_2592ef82cf7d",
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
											fontSize = "32",
											fontStroke = 
											{
												IsStroke = false,
												StrokeColor = "#FFE6E6E6",
												StrokeSize = 1,
											},
											height = "37",
											ignoreSize = "True",
											name = "Label_ladder_fight_core",
											nTextAlign = "1",
											nTextHAlign = "1",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "770",
											text = "43层",
											touchAble = "False",
											touchScaleEnable = "False",
											UILayoutViewModel = 
											{
												PositionX = -7,
												PositionY = -43,
											},
											width = "68",
											ZOrder = "1",
										},
									},
								},
								{
									controlID = "Image_skyladder_time_Panel_evaluation_Panel_root_Panel-battleResultView_ui_battle_Game",
									UUID = "8205884c_8950_4a67_bd94_172b981179e1",
									anchorPoint = "False",
									anchorPointX = "1",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "40",
									ignoreSize = "True",
									name = "Image_skyladder_time",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/battle/result/ui_06.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = 266,
										PositionY = -39,
									},
									visible = "False",
									width = "148",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "Label_skyladder_time_title_Image_skyladder_time_Panel_evaluation_Panel_root_Panel-battleResultView_ui_battle_Game",
											UUID = "8eef9083_8a53_4716_8f93_b44fe5f43c8b",
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
											fontSize = "24",
											fontStroke = 
											{
												IsStroke = false,
												StrokeColor = "#FFE6E6E6",
												StrokeSize = 1,
											},
											height = "27",
											ignoreSize = "True",
											name = "Label_skyladder_time_title",
											nTextAlign = "1",
											nTextHAlign = "1",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "770",
											text = "时间评分",
											touchAble = "False",
											touchScaleEnable = "False",
											UILayoutViewModel = 
											{
												PositionX = -6,
												PositionY = 4,
												LeftPositon = 1188,
												TopPosition = -22,
												relativeToName = "Panel",
											},
											width = "99",
											ZOrder = "1",
										},
										{
											controlID = "Label_skyladder_time_title_en_Image_skyladder_time_Panel_evaluation_Panel_root_Panel-battleResultView_ui_battle_Game",
											UUID = "d69694d3_52c2_48f6_8e96_2fb741681b37",
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
											name = "Label_skyladder_time_title_en",
											nTextAlign = "1",
											nTextHAlign = "1",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "770",
											text = "Time Rate",
											touchAble = "False",
											touchScaleEnable = "False",
											UILayoutViewModel = 
											{
												PositionX = -6,
												PositionY = -13,
											},
											width = "61",
											ZOrder = "1",
										},
										{
											controlID = "Label_skyladder_time_score_Image_skyladder_time_Panel_evaluation_Panel_root_Panel-battleResultView_ui_battle_Game",
											UUID = "2a8444f8_2f20_4243_aff3_22862ffcd2a7",
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
											fontSize = "32",
											fontStroke = 
											{
												IsStroke = false,
												StrokeColor = "#FFE6E6E6",
												StrokeSize = 1,
											},
											height = "37",
											ignoreSize = "True",
											name = "Label_skyladder_time_score",
											nTextAlign = "1",
											nTextHAlign = "1",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "770",
											text = "43层",
											touchAble = "False",
											touchScaleEnable = "False",
											UILayoutViewModel = 
											{
												PositionX = -7,
												PositionY = -43,
											},
											width = "68",
											ZOrder = "1",
										},
									},
								},
								{
									controlID = "Panel_simlationTrial_Panel_evaluation_Panel_root_Panel-battleResultView_ui_battle_Game",
									UUID = "10ae7c76_d90d_497b_ad69_9f04cf2a421c",
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
									height = "500",
									ignoreSize = "False",
									name = "Panel_simlationTrial",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = -334,
										PositionY = -319,
									},
									uipanelviewmodel = 
									{
										Layout="Absolute",
										nType = "0"
									},
									visible = "False",
									width = "600",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "Image_reward1_Panel_simlationTrial_Panel_evaluation_Panel_root_Panel-battleResultView_ui_battle_Game",
											UUID = "94ee9f8b_b25d_44dd_b0b4_5295a258f020",
											anchorPoint = "False",
											anchorPointX = "1",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											classname = "MEImage",
											dstBlendFunc = "771",
											height = "40",
											ignoreSize = "True",
											name = "Image_reward1",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											texturePath = "ui/battle/result/ui_06.png",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 600,
												PositionY = 448,
												relativeToName = "Panel",
											},
											width = "148",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "Label_extend_title_Image_reward1_Panel_simlationTrial_Panel_evaluation_Panel_root_Panel-battleResultView_ui_battle_Game",
													UUID = "57ebb088_00db_4d0d_9ffa_ae354ca57ef6",
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
													name = "Label_extend_title",
													nTextAlign = "1",
													nTextHAlign = "1",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "770",
													text = "赏金激活",
													touchAble = "False",
													touchScaleEnable = "False",
													UILayoutViewModel = 
													{
														PositionX = -6,
														PositionY = 5,
													},
													width = "91",
													ZOrder = "1",
												},
												{
													controlID = "Label_extend_title_en_Image_reward1_Panel_simlationTrial_Panel_evaluation_Panel_root_Panel-battleResultView_ui_battle_Game",
													UUID = "a427414b_e848_42b6_addc_b2d95f590fa2",
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
													name = "Label_extend_title_en",
													nTextAlign = "1",
													nTextHAlign = "1",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "770",
													text = "Rewards",
													touchAble = "False",
													touchScaleEnable = "False",
													UILayoutViewModel = 
													{
														PositionX = -11,
														PositionY = -11,
													},
													width = "53",
													ZOrder = "1",
												},
												{
													controlID = "Image_con_reward_1_Image_reward1_Panel_simlationTrial_Panel_evaluation_Panel_root_Panel-battleResultView_ui_battle_Game",
													UUID = "1e562ed1_250a_40a4_8104_671d24264c6c",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0.5",
													backGroundScale9Enable = "False",
													classname = "MEImage",
													dstBlendFunc = "771",
													height = "176",
													ignoreSize = "True",
													name = "Image_con_reward_1",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "1",
													texturePath = "ui/simulation_trial5/result/rewardBg.png",
													touchAble = "False",
													UILayoutViewModel = 
													{
														PositionX = -335,
														PositionY = -139,
													},
													width = "198",
													ZOrder = "1",
													components = 
													{
														
														{
															controlID = "Image_con_box1_Image_con_reward_1_Image_reward1_Panel_simlationTrial_Panel_evaluation_Panel_root_Panel-battleResultView_ui_battle_Game",
															UUID = "6dbb267f_6eb7_40ef_8dca_198e53469b94",
															anchorPoint = "False",
															anchorPointX = "0.5",
															anchorPointY = "0.5",
															backGroundScale9Enable = "False",
															classname = "MEImage",
															dstBlendFunc = "771",
															height = "150",
															ignoreSize = "True",
															name = "Image_con_box1",
															sizepercentx = "0",
															sizepercenty = "0",
															sizeType = "0",
															srcBlendFunc = "1",
															texturePath = "ui/battle/result/0003.png",
															touchAble = "False",
															UILayoutViewModel = 
															{
																
															},
															width = "150",
															ZOrder = "1",
														},
														{
															controlID = "Label_con_reward_name1_Image_con_reward_1_Image_reward1_Panel_simlationTrial_Panel_evaluation_Panel_root_Panel-battleResultView_ui_battle_Game",
															UUID = "c9de3156_12b6_4137_86f8_1139e433e8c2",
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
																IsStroke = true,
																StrokeColor = "#FF2C4998",
																StrokeSize = 2,
															},
															height = "31",
															ignoreSize = "True",
															name = "Label_con_reward_name1",
															nTextAlign = "1",
															nTextHAlign = "1",
															sizepercentx = "0",
															sizepercenty = "0",
															sizeType = "0",
															srcBlendFunc = "770",
															text = "普通赏金",
															touchAble = "False",
															touchScaleEnable = "False",
															UILayoutViewModel = 
															{
																PositionY = -66,
															},
															width = "93",
															ZOrder = "1",
														},
													},
												},
												{
													controlID = "Image_con_reward_2_Image_reward1_Panel_simlationTrial_Panel_evaluation_Panel_root_Panel-battleResultView_ui_battle_Game",
													UUID = "ce951649_71f1_464d_8611_6ca35ddb06e1",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0.5",
													backGroundScale9Enable = "False",
													classname = "MEImage",
													dstBlendFunc = "771",
													height = "176",
													ignoreSize = "True",
													name = "Image_con_reward_2",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "1",
													texturePath = "ui/simulation_trial5/result/rewardBg.png",
													touchAble = "False",
													UILayoutViewModel = 
													{
														PositionX = -117,
														PositionY = -139,
													},
													width = "198",
													ZOrder = "1",
													components = 
													{
														
														{
															controlID = "Image_con_box2_Image_con_reward_2_Image_reward1_Panel_simlationTrial_Panel_evaluation_Panel_root_Panel-battleResultView_ui_battle_Game",
															UUID = "7aa27fdf_93b1_4b5e_aac7_2062a9d419c0",
															anchorPoint = "False",
															anchorPointX = "0.5",
															anchorPointY = "0.5",
															backGroundScale9Enable = "False",
															classname = "MEImage",
															dstBlendFunc = "771",
															height = "150",
															ignoreSize = "True",
															name = "Image_con_box2",
															sizepercentx = "0",
															sizepercenty = "0",
															sizeType = "0",
															srcBlendFunc = "1",
															texturePath = "ui/battle/result/0004.png",
															touchAble = "False",
															UILayoutViewModel = 
															{
																
															},
															width = "150",
															ZOrder = "1",
														},
														{
															controlID = "Image_con_lock_Image_con_reward_2_Image_reward1_Panel_simlationTrial_Panel_evaluation_Panel_root_Panel-battleResultView_ui_battle_Game",
															UUID = "22d57368_04bc_443c_8e3e_4fdf5b58ac1a",
															anchorPoint = "False",
															anchorPointX = "0.5",
															anchorPointY = "0.5",
															backGroundScale9Enable = "False",
															classname = "MEImage",
															dstBlendFunc = "771",
															height = "158",
															ignoreSize = "True",
															name = "Image_con_lock",
															sizepercentx = "0",
															sizepercenty = "0",
															sizeType = "0",
															srcBlendFunc = "1",
															texturePath = "ui/battle/result/0002.png",
															touchAble = "False",
															UILayoutViewModel = 
															{
																
															},
															width = "182",
															ZOrder = "1",
															components = 
															{
																
																{
																	controlID = "Label_con_tip_Image_con_lock_Image_con_reward_2_Image_reward1_Panel_simlationTrial_Panel_evaluation_Panel_root_Panel-battleResultView_ui_battle_Game",
																	UUID = "c90d56f5_a034_45d5_be8b_27cecc6483bb",
																	anchorPoint = "False",
																	anchorPointX = "0.5",
																	anchorPointY = "0.5",
																	classname = "MELabel",
																	compPath = "luacomponents.common.MEIconLabel",
																	dstBlendFunc = "771",
																	FontColor = "#FFE3DE36",
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
																	name = "Label_con_tip",
																	nTextAlign = "1",
																	nTextHAlign = "1",
																	sizepercentx = "0",
																	sizepercenty = "0",
																	sizeType = "0",
																	srcBlendFunc = "770",
																	text = "获得「猩红梦魇」后获得",
																	touchAble = "False",
																	touchScaleEnable = "False",
																	UILayoutViewModel = 
																	{
																		PositionY = -95,
																	},
																	width = "245",
																	ZOrder = "1",
																},
															},
														},
														{
															controlID = "Label_con_reward_name2_Image_con_reward_2_Image_reward1_Panel_simlationTrial_Panel_evaluation_Panel_root_Panel-battleResultView_ui_battle_Game",
															UUID = "46d16182_417f_4c30_a18f_3e250b788b10",
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
																IsStroke = true,
																StrokeColor = "#FF2C4998",
																StrokeSize = 2,
															},
															height = "31",
															ignoreSize = "True",
															name = "Label_con_reward_name2",
															nTextAlign = "1",
															nTextHAlign = "1",
															sizepercentx = "0",
															sizepercenty = "0",
															sizeType = "0",
															srcBlendFunc = "770",
															text = "进阶赏金",
															touchAble = "False",
															touchScaleEnable = "False",
															UILayoutViewModel = 
															{
																PositionY = -66,
															},
															width = "93",
															ZOrder = "1",
														},
													},
												},
											},
										},
										{
											controlID = "Image_reward2_Panel_simlationTrial_Panel_evaluation_Panel_root_Panel-battleResultView_ui_battle_Game",
											UUID = "217212d3_cec6_4b4a_b943_59bbb68707eb",
											anchorPoint = "False",
											anchorPointX = "1",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											classname = "MEImage",
											dstBlendFunc = "771",
											height = "40",
											ignoreSize = "True",
											name = "Image_reward2",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											texturePath = "ui/battle/result/ui_06.png",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 602,
												PositionY = 169,
											},
											width = "148",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "Label_reward_title_Image_reward2_Panel_simlationTrial_Panel_evaluation_Panel_root_Panel-battleResultView_ui_battle_Game",
													UUID = "da11602f_3196_4fe4_83ac_2e62a5363391",
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
													text = "精灵装备",
													touchAble = "False",
													touchScaleEnable = "False",
													UILayoutViewModel = 
													{
														PositionX = -6,
														PositionY = 5,
													},
													width = "91",
													ZOrder = "1",
												},
												{
													controlID = "Label_reward_flag_Image_reward2_Panel_simlationTrial_Panel_evaluation_Panel_root_Panel-battleResultView_ui_battle_Game",
													UUID = "54455e43_182c_404c_9110_de90a006e367",
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
													name = "Label_reward_flag",
													nTextAlign = "1",
													nTextHAlign = "1",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "770",
													text = "Equipment",
													touchAble = "False",
													touchScaleEnable = "False",
													UILayoutViewModel = 
													{
														PositionX = -11,
														PositionY = -11,
													},
													width = "67",
													ZOrder = "1",
												},
												{
													controlID = "ScrollView_reward_Image_reward2_Panel_simlationTrial_Panel_evaluation_Panel_root_Panel-battleResultView_ui_battle_Game",
													UUID = "4830c3e6_3f53_4b8a_ad9a_f93fa7f0bc84",
													anchorPoint = "False",
													anchorPointX = "1",
													anchorPointY = "0.5",
													backGroundScale9Enable = "False",
													bgColorOpacity = "50",
													bIsOpenClipping = "True",
													bounceEnable = "False",
													classname = "MEScrollView",
													colorType = "0;SingleColor:#FFFF0000;GraduallyChangingColorStart:#FFFFFFFF;GraduallyChangingColorEnd:#FFFFFFFF;vectorX:0;vectorY:0",
													direction = "2",
													dstBlendFunc = "771",
													height = "100",
													ignoreSize = "False",
													innerHeight = "100",
													innerWidth = "480",
													name = "ScrollView_reward",
													showScrollbar = "False",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "1",
													touchAble = "False",
													UILayoutViewModel = 
													{
														PositionX = -4,
														PositionY = -75,
													},
													uipanelviewmodel = 
													{
														Layout="Absolute",
														nType = "0"
													},
													width = "480",
													ZOrder = "1",
												},
											},
										},
									},
								},
								{
									controlID = "Image_score_Panel_evaluation_Panel_root_Panel-battleResultView_ui_battle_Game",
									UUID = "ce6ce1e3_7b39_4be5_9e8e_74c9bee1b1c3",
									anchorPoint = "False",
									anchorPointX = "1",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "40",
									ignoreSize = "True",
									name = "Image_score",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/battle/result/ui_06.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = 266,
										PositionY = 50,
									},
									visible = "False",
									width = "148",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "Label_score_title_Image_score_Panel_evaluation_Panel_root_Panel-battleResultView_ui_battle_Game",
											UUID = "25e61a0f_0de1_4f47_9d1d_2508cb32e229",
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
											fontSize = "24",
											fontStroke = 
											{
												IsStroke = false,
												StrokeColor = "#FFE6E6E6",
												StrokeSize = 1,
											},
											height = "27",
											ignoreSize = "True",
											name = "Label_score_title",
											nTextAlign = "1",
											nTextHAlign = "1",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "770",
											text = "作战评分",
											touchAble = "False",
											touchScaleEnable = "False",
											UILayoutViewModel = 
											{
												PositionX = -6,
												PositionY = 4,
												LeftPositon = 1188,
												TopPosition = -22,
												relativeToName = "Panel",
											},
											width = "99",
											ZOrder = "1",
										},
										{
											controlID = "Label_score_title_flag_Image_score_Panel_evaluation_Panel_root_Panel-battleResultView_ui_battle_Game",
											UUID = "35418192_b530_4cdc_8ad6_db6389e02550",
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
											name = "Label_score_title_flag",
											nTextAlign = "1",
											nTextHAlign = "1",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "770",
											text = "Basic Rate",
											touchAble = "False",
											touchScaleEnable = "False",
											UILayoutViewModel = 
											{
												PositionX = -6,
												PositionY = -13,
											},
											width = "64",
											ZOrder = "1",
										},
										{
											controlID = "Label_score_Image_score_Panel_evaluation_Panel_root_Panel-battleResultView_ui_battle_Game",
											UUID = "db83b8e1_ac97_4d87_a1ee_11be7678f015",
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
											fontSize = "32",
											fontStroke = 
											{
												IsStroke = false,
												StrokeColor = "#FFE6E6E6",
												StrokeSize = 1,
											},
											height = "37",
											ignoreSize = "True",
											name = "Label_score",
											nTextAlign = "1",
											nTextHAlign = "1",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "770",
											text = "99999",
											touchAble = "False",
											touchScaleEnable = "False",
											UILayoutViewModel = 
											{
												PositionX = -7,
												PositionY = -50,
											},
											width = "87",
											ZOrder = "1",
										},
									},
								},
								{
									controlID = "Image_monster_score_Panel_evaluation_Panel_root_Panel-battleResultView_ui_battle_Game",
									UUID = "c3ed54f6_7193_4de7_9fe4_448db929174a",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "64",
									ignoreSize = "True",
									name = "Image_monster_score",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = 180,
										PositionY = 13,
									},
									visible = "False",
									width = "64",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "Image_1_Image_monster_score_Panel_evaluation_Panel_root_Panel-battleResultView_ui_battle_Game",
											UUID = "c8aaebb0_a515_4446_96b1_21a9d43d4cff",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											classname = "MEImage",
											dstBlendFunc = "771",
											height = "40",
											ignoreSize = "True",
											name = "Image_1",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											texturePath = "ui/battle/result/ui_06.png",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 11,
												PositionY = 35,
											},
											width = "148",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "Label_cur_score_Image_1_Image_monster_score_Panel_evaluation_Panel_root_Panel-battleResultView_ui_battle_Game",
													UUID = "3246aae3_ee44_45b3_89af_1e62dbaf43fc",
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
													fontSize = "24",
													fontStroke = 
													{
														IsStroke = false,
														StrokeColor = "#FFE6E6E6",
														StrokeSize = 1,
													},
													height = "27",
													ignoreSize = "True",
													name = "Label_cur_score",
													nTextAlign = "1",
													nTextHAlign = "1",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "770",
													text = "本次得分",
													touchAble = "False",
													touchScaleEnable = "False",
													UILayoutViewModel = 
													{
														PositionX = 70,
														PositionY = 3,
													},
													width = "99",
													ZOrder = "1",
												},
											},
										},
										{
											controlID = "Image_2_Image_monster_score_Panel_evaluation_Panel_root_Panel-battleResultView_ui_battle_Game",
											UUID = "66210b18_793d_4752_ac8d_6416398bf8eb",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											classname = "MEImage",
											dstBlendFunc = "771",
											height = "40",
											ignoreSize = "True",
											name = "Image_2",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											texturePath = "ui/battle/result/ui_06.png",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 11,
												PositionY = -50,
											},
											width = "148",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "Label_history_score_Image_2_Image_monster_score_Panel_evaluation_Panel_root_Panel-battleResultView_ui_battle_Game",
													UUID = "f01f8c7a_fa92_484c_8069_8148b5e69526",
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
													fontSize = "24",
													fontStroke = 
													{
														IsStroke = false,
														StrokeColor = "#FFE6E6E6",
														StrokeSize = 1,
													},
													height = "27",
													ignoreSize = "True",
													name = "Label_history_score",
													nTextAlign = "1",
													nTextHAlign = "1",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "770",
													text = "历史最佳",
													touchAble = "False",
													touchScaleEnable = "False",
													UILayoutViewModel = 
													{
														PositionX = 65,
													},
													width = "99",
													ZOrder = "1",
												},
											},
										},
										{
											controlID = "Image_3_Image_monster_score_Panel_evaluation_Panel_root_Panel-battleResultView_ui_battle_Game",
											UUID = "515bbbb7_a1ff_4213_acab_d9fce29842be",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											classname = "MEImage",
											dstBlendFunc = "771",
											height = "40",
											ignoreSize = "True",
											name = "Image_3",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											texturePath = "ui/battle/result/ui_06.png",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 10,
												PositionY = -129,
											},
											width = "148",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "Label_max_score_Image_3_Image_monster_score_Panel_evaluation_Panel_root_Panel-battleResultView_ui_battle_Game",
													UUID = "c1714ef3_923c_40a2_b098_aa0125cbed73",
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
													fontSize = "24",
													fontStroke = 
													{
														IsStroke = false,
														StrokeColor = "#FFE6E6E6",
														StrokeSize = 1,
													},
													height = "27",
													ignoreSize = "True",
													name = "Label_max_score",
													nTextAlign = "1",
													nTextHAlign = "1",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "770",
													text = "最高积分",
													touchAble = "False",
													touchScaleEnable = "False",
													UILayoutViewModel = 
													{
														PositionX = 69,
													},
													width = "99",
													ZOrder = "1",
												},
											},
										},
										{
											controlID = "score_cur_Image_monster_score_Panel_evaluation_Panel_root_Panel-battleResultView_ui_battle_Game",
											UUID = "7bb6a8d9_29e9_4d8d_80aa_d7c90edc9e9b",
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
											name = "score_cur",
											nTextAlign = "1",
											nTextHAlign = "1",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "770",
											text = "2400",
											touchAble = "False",
											touchScaleEnable = "False",
											UILayoutViewModel = 
											{
												PositionX = 78,
												PositionY = -3,
											},
											width = "67",
											ZOrder = "1",
										},
										{
											controlID = "score_history_Image_monster_score_Panel_evaluation_Panel_root_Panel-battleResultView_ui_battle_Game",
											UUID = "af39c987_a98b_4559_950a_07b85a22e7b6",
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
											name = "score_history",
											nTextAlign = "1",
											nTextHAlign = "1",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "770",
											text = "2400",
											touchAble = "False",
											touchScaleEnable = "False",
											UILayoutViewModel = 
											{
												PositionX = 78,
												PositionY = -89,
											},
											width = "67",
											ZOrder = "1",
										},
										{
											controlID = "score_max_Image_monster_score_Panel_evaluation_Panel_root_Panel-battleResultView_ui_battle_Game",
											UUID = "bbbfb295_b9a1_4f50_9347_e8bf2bed7f61",
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
											name = "score_max",
											nTextAlign = "1",
											nTextHAlign = "1",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "770",
											text = "2400",
											touchAble = "False",
											touchScaleEnable = "False",
											UILayoutViewModel = 
											{
												PositionX = 76,
												PositionY = -167,
											},
											width = "67",
											ZOrder = "1",
										},
									},
								},
								{
									controlID = "Image_attackNum_Panel_evaluation_Panel_root_Panel-battleResultView_ui_battle_Game",
									UUID = "281f5572_e461_4072_ad54_71781b182b12",
									anchorPoint = "False",
									anchorPointX = "1",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "40",
									ignoreSize = "True",
									name = "Image_attackNum",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/battle/result/ui_06.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = 266,
										PositionY = 45,
									},
									width = "148",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "Label_endless_title_Image_attackNum_Panel_evaluation_Panel_root_Panel-battleResultView_ui_battle_Game",
											UUID = "2ca1998f_e62a_46f6_ab30_84d893b4e8e5",
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
											fontSize = "24",
											fontStroke = 
											{
												IsStroke = false,
												StrokeColor = "#FFE6E6E6",
												StrokeSize = 1,
											},
											height = "27",
											ignoreSize = "True",
											name = "Label_endless_title",
											nTextAlign = "1",
											nTextHAlign = "1",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "770",
											text = "造成伤害",
											touchAble = "False",
											touchScaleEnable = "False",
											UILayoutViewModel = 
											{
												PositionX = -6,
												PositionY = 4,
												LeftPositon = 1188,
												TopPosition = -22,
												relativeToName = "Panel",
											},
											width = "100",
											ZOrder = "1",
										},
										{
											controlID = "Label_endless_title_flag_Image_attackNum_Panel_evaluation_Panel_root_Panel-battleResultView_ui_battle_Game",
											UUID = "293ef430_e599_493a_9e7d_504e924a1e6a",
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
											name = "Label_endless_title_flag",
											nTextAlign = "1",
											nTextHAlign = "1",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "770",
											text = "Attack",
											touchAble = "False",
											touchScaleEnable = "False",
											UILayoutViewModel = 
											{
												PositionX = -6,
												PositionY = -13,
											},
											width = "41",
											ZOrder = "1",
										},
										{
											controlID = "Label_attackNum_Image_attackNum_Panel_evaluation_Panel_root_Panel-battleResultView_ui_battle_Game",
											UUID = "d1b93c0f_27a6_41f1_a4a6_ec4381f82502",
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
											fontSize = "32",
											fontStroke = 
											{
												IsStroke = false,
												StrokeColor = "#FFE6E6E6",
												StrokeSize = 1,
											},
											height = "37",
											ignoreSize = "True",
											name = "Label_attackNum",
											nTextAlign = "1",
											nTextHAlign = "1",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "770",
											text = "56565",
											touchAble = "False",
											touchScaleEnable = "False",
											UILayoutViewModel = 
											{
												PositionX = -7,
												PositionY = -50,
											},
											width = "87",
											ZOrder = "1",
										},
									},
								},
							},
						},
						{
							controlID = "Panel_team_Attack_Panel_root_Panel-battleResultView_ui_battle_Game",
							UUID = "d7a9b96f_fc22_4867_99ef_f29840d15758",
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
							name = "Panel_team_Attack",
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
							components = 
							{
								
								{
									controlID = "Panel_item_1_Panel_team_Attack_Panel_root_Panel-battleResultView_ui_battle_Game",
									UUID = "37879e38_bfc1_48aa_9de7_82c9cf3b89e2",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0",
									backGroundScale9Enable = "False",
									bgColorOpacity = "50",
									bIsOpenClipping = "False",
									classname = "MEPanel",
									colorType = "0;SingleColor:#FFFF0000;GraduallyChangingColorStart:#FFFFFFFF;GraduallyChangingColorEnd:#FFFFFFFF;vectorX:0;vectorY:0",
									DesignHeight = "640",
									DesignType = "0",
									DesignWidth = "960",
									dstBlendFunc = "771",
									height = "477",
									ignoreSize = "False",
									name = "Panel_item_1",
									scaleX = "0.75",
									scaleY = "0.75",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = -103,
										PositionY = -204,
									},
									uipanelviewmodel = 
									{
										Layout="Absolute",
										nType = "0"
									},
									width = "280",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "Panel_reward_Panel_item_1_Panel_team_Attack_Panel_root_Panel-battleResultView_ui_battle_Game",
											UUID = "081f40cf_db93_4751_8c78_79d0cd57552d",
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
											height = "96",
											ignoreSize = "False",
											name = "Panel_reward",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = -140,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "278",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "Image_bg1_Panel_reward_Panel_item_1_Panel_team_Attack_Panel_root_Panel-battleResultView_ui_battle_Game",
													UUID = "7bda5200_7555_4c11_8b62_e968248d6f9b",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0",
													backGroundScale9Enable = "False",
													classname = "MEImage",
													dstBlendFunc = "771",
													height = "96",
													ignoreSize = "True",
													name = "Image_bg1",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "1",
													texturePath = "ui/battle/result/003.png",
													touchAble = "False",
													UILayoutViewModel = 
													{
														PositionX = 139,
														IsPercent = true,
														PercentX = 50,
													},
													width = "278",
													ZOrder = "1",
												},
												{
													controlID = "Image_bg2_Panel_reward_Panel_item_1_Panel_team_Attack_Panel_root_Panel-battleResultView_ui_battle_Game",
													UUID = "c626a151_495c_44b9_8978_553cc7cb13ed",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0",
													backGroundScale9Enable = "False",
													classname = "MEImage",
													dstBlendFunc = "771",
													height = "85",
													ignoreSize = "True",
													name = "Image_bg2",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "1",
													texturePath = "ui/battle/result/004.png",
													touchAble = "False",
													UILayoutViewModel = 
													{
														PositionX = 139,
														IsPercent = true,
														PercentX = 50,
													},
													visible = "False",
													width = "278",
													ZOrder = "1",
												},
												{
													controlID = "Image_bg3_Panel_reward_Panel_item_1_Panel_team_Attack_Panel_root_Panel-battleResultView_ui_battle_Game",
													UUID = "bf3a1d99_5caf_4062_beb3_67bec81b4599",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0",
													backGroundScale9Enable = "False",
													classname = "MEImage",
													dstBlendFunc = "771",
													height = "96",
													ignoreSize = "True",
													name = "Image_bg3",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "1",
													texturePath = "ui/battle/result/0020.png",
													touchAble = "False",
													UILayoutViewModel = 
													{
														PositionX = 139,
														IsPercent = true,
														PercentX = 50,
													},
													width = "278",
													ZOrder = "1",
												},
												{
													controlID = "Image_bg4_Panel_reward_Panel_item_1_Panel_team_Attack_Panel_root_Panel-battleResultView_ui_battle_Game",
													UUID = "9dab0a55_7dd7_4499_b101_3d33a65a213f",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0.5",
													backGroundScale9Enable = "False",
													classname = "MEImage",
													dstBlendFunc = "771",
													height = "20",
													ignoreSize = "True",
													name = "Image_bg4",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "1",
													texturePath = "ui/battle/result/006.png",
													touchAble = "False",
													UILayoutViewModel = 
													{
														PositionX = 164,
														PositionY = 14,
													},
													width = "220",
													ZOrder = "1",
												},
												{
													controlID = "ScrollView_role_reward_Panel_reward_Panel_item_1_Panel_team_Attack_Panel_root_Panel-battleResultView_ui_battle_Game",
													UUID = "14195513_24e8_4332_9bb8_0408e9619851",
													anchorPoint = "False",
													anchorPointX = "0",
													anchorPointY = "0",
													backGroundScale9Enable = "False",
													bgColorOpacity = "50",
													bIsOpenClipping = "True",
													bounceEnable = "False",
													classname = "MEScrollView",
													colorType = "0;SingleColor:#FFE6E6E6;GraduallyChangingColorStart:#FFFFFFFF;GraduallyChangingColorEnd:#FFFFFFFF;vectorX:0;vectorY:0",
													direction = "2",
													dstBlendFunc = "771",
													height = "85",
													ignoreSize = "False",
													innerHeight = "85",
													innerWidth = "278",
													name = "ScrollView_role_reward",
													showScrollbar = "False",
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
													width = "278",
													ZOrder = "1",
												},
												{
													controlID = "Image_syts_Panel_reward_Panel_item_1_Panel_team_Attack_Panel_root_Panel-battleResultView_ui_battle_Game",
													UUID = "6be3828c_25f3_4cdc_b73f_7886ef7ba909",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0.5",
													backGroundScale9Enable = "False",
													classname = "MEImage",
													dstBlendFunc = "771",
													height = "49",
													ignoreSize = "True",
													name = "Image_syts",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "1",
													texturePath = "ui/battle/result/001.png",
													touchAble = "False",
													UILayoutViewModel = 
													{
														PositionX = 212,
														PositionY = 13,
													},
													visible = "False",
													width = "169",
													ZOrder = "1",
													components = 
													{
														
														{
															controlID = "Image_font_syts_Image_syts_Panel_reward_Panel_item_1_Panel_team_Attack_Panel_root_Panel-battleResultView_ui_battle_Game",
															UUID = "35519608_2af1_4f30_99c4_4fc7a8354325",
															anchorPoint = "False",
															anchorPointX = "0.5",
															anchorPointY = "0.5",
															backGroundScale9Enable = "False",
															classname = "MEImage",
															dstBlendFunc = "771",
															height = "32",
															ignoreSize = "True",
															name = "Image_font_syts",
															sizepercentx = "0",
															sizepercenty = "0",
															sizeType = "0",
															srcBlendFunc = "1",
															texturePath = "ui/fight_result/reward_rise.png",
															touchAble = "False",
															UILayoutViewModel = 
															{
																
															},
															width = "118",
															ZOrder = "1",
														},
													},
												},
											},
										},
										{
											controlID = "Panel_item_Panel_item_1_Panel_team_Attack_Panel_root_Panel-battleResultView_ui_battle_Game",
											UUID = "487f8dbb_2e29_440b_9f65_10894caa0476",
											anchorPoint = "False",
											anchorPointX = "0.5",
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
											height = "470",
											ignoreSize = "False",
											name = "Panel_item",
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
											width = "280",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "Image_bg_Panel_item_Panel_item_1_Panel_team_Attack_Panel_root_Panel-battleResultView_ui_battle_Game",
													UUID = "d71d3c75_1a1f_440d_b68c_938877caa701",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0.5",
													backGroundScale9Enable = "False",
													classname = "MEImage",
													dstBlendFunc = "771",
													height = "414",
													ignoreSize = "True",
													name = "Image_bg",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "1",
													texturePath = "ui/onlineteam/member_bg.png",
													touchAble = "False",
													UILayoutViewModel = 
													{
														PositionY = 205,
													},
													width = "280",
													ZOrder = "1",
												},
												{
													controlID = "Panel_hero_Panel_item_Panel_item_1_Panel_team_Attack_Panel_root_Panel-battleResultView_ui_battle_Game",
													UUID = "28ce2529_fbdf_4819_802b_d32f65d6b295",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0",
													backGroundScale9Enable = "False",
													bgColorOpacity = "50",
													bIsOpenClipping = "True",
													classname = "MEPanel",
													colorType = "0;SingleColor:#FFE6E6E6;GraduallyChangingColorStart:#FFFFFFFF;GraduallyChangingColorEnd:#FFFFFFFF;vectorX:0;vectorY:0",
													DesignHeight = "640",
													DesignType = "0",
													DesignWidth = "960",
													dstBlendFunc = "771",
													height = "370",
													ignoreSize = "False",
													name = "Panel_hero",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "1",
													touchAble = "False",
													UILayoutViewModel = 
													{
														PositionY = 7,
													},
													uipanelviewmodel = 
													{
														Layout="Absolute",
														nType = "0"
													},
													width = "275",
													ZOrder = "1",
													components = 
													{
														
														{
															controlID = "Image_role_bg_Panel_hero_Panel_item_Panel_item_1_Panel_team_Attack_Panel_root_Panel-battleResultView_ui_battle_Game",
															UUID = "59d0d3ea_e6a8_489f_b5f1_9fb83e5afa3e",
															anchorPoint = "False",
															anchorPointX = "0.5",
															anchorPointY = "0.5",
															backGroundScale9Enable = "False",
															classname = "MEImage",
															dstBlendFunc = "771",
															height = "500",
															ignoreSize = "True",
															name = "Image_role_bg",
															sizepercentx = "0",
															sizepercenty = "0",
															sizeType = "0",
															srcBlendFunc = "1",
															texturePath = "icon/hero/backdrop/10101.png",
															touchAble = "False",
															UILayoutViewModel = 
															{
																PositionY = 200,
															},
															width = "300",
															ZOrder = "1",
														},
														{
															controlID = "Panel_role_Panel_hero_Panel_item_Panel_item_1_Panel_team_Attack_Panel_root_Panel-battleResultView_ui_battle_Game",
															UUID = "5d4e3de5_905c_4915_9d61_d82d4728a0c4",
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
															height = "0",
															ignoreSize = "False",
															name = "Panel_role",
															sizepercentx = "0",
															sizepercenty = "0",
															sizeType = "0",
															srcBlendFunc = "1",
															touchAble = "False",
															UILayoutViewModel = 
															{
																PositionY = 185,
															},
															uipanelviewmodel = 
															{
																Layout="Absolute",
																nType = "0"
															},
															width = "0",
															ZOrder = "1",
														},
													},
												},
												{
													controlID = "Image_front_Panel_item_Panel_item_1_Panel_team_Attack_Panel_root_Panel-battleResultView_ui_battle_Game",
													UUID = "5b0dfa06_c0e4_4770_9083_238db2efaa58",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0.5",
													backGroundScale9Enable = "False",
													classname = "MEImage",
													dstBlendFunc = "771",
													height = "408",
													ignoreSize = "True",
													name = "Image_front",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "1",
													texturePath = "ui/onlineteam/member_front.png",
													touchAble = "False",
													UILayoutViewModel = 
													{
														PositionY = 205,
													},
													width = "278",
													ZOrder = "1",
												},
												{
													controlID = "Panel_info_Panel_item_Panel_item_1_Panel_team_Attack_Panel_root_Panel-battleResultView_ui_battle_Game",
													UUID = "f9ec7b40_1dfc_4f8b_8ba1_f3793f9082ef",
													anchorPoint = "False",
													anchorPointX = "0.5",
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
													height = "470",
													ignoreSize = "False",
													name = "Panel_info",
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
													width = "280",
													ZOrder = "1",
													components = 
													{
														
														{
															controlID = "Image_captain_bg_Panel_info_Panel_item_Panel_item_1_Panel_team_Attack_Panel_root_Panel-battleResultView_ui_battle_Game",
															UUID = "d17a70fa_bc36_4e4a_a318_c8ca08d1a8e7",
															anchorPoint = "False",
															anchorPointX = "0.5",
															anchorPointY = "0.5",
															backGroundScale9Enable = "False",
															classname = "MEImage",
															dstBlendFunc = "771",
															height = "44",
															ignoreSize = "True",
															name = "Image_captain_bg",
															sizepercentx = "0",
															sizepercenty = "0",
															sizeType = "0",
															srcBlendFunc = "1",
															texturePath = "ui/onlineteam/captain_name_bg.png",
															touchAble = "False",
															UILayoutViewModel = 
															{
																PositionY = 390,
															},
															width = "278",
															ZOrder = "1",
														},
														{
															controlID = "Label_name_Panel_info_Panel_item_Panel_item_1_Panel_team_Attack_Panel_root_Panel-battleResultView_ui_battle_Game",
															UUID = "119d21b4_2206_4180_9b24_b370591eb6d6",
															anchorPoint = "False",
															anchorPointX = "0.5",
															anchorPointY = "0.5",
															classname = "MELabel",
															compPath = "luacomponents.common.MEIconLabel",
															dstBlendFunc = "771",
															FontColor = "#FF101117",
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
															text = "小四",
															touchAble = "False",
															touchScaleEnable = "False",
															UILayoutViewModel = 
															{
																PositionX = 1,
																PositionY = 395,
															},
															width = "51",
															ZOrder = "1",
														},
														{
															controlID = "Image_pinzhi_Panel_info_Panel_item_Panel_item_1_Panel_team_Attack_Panel_root_Panel-battleResultView_ui_battle_Game",
															UUID = "8823023a_13f7_41b0_8f83_5bd61a04ff4b",
															anchorPoint = "False",
															anchorPointX = "1",
															anchorPointY = "0.5",
															backGroundScale9Enable = "False",
															classname = "MEImage",
															dstBlendFunc = "771",
															height = "159",
															ignoreSize = "True",
															name = "Image_pinzhi",
															scaleX = "0.24",
															scaleY = "0.24",
															sizepercentx = "0",
															sizepercenty = "0",
															sizeType = "0",
															srcBlendFunc = "1",
															texturePath = "ui/common/hero/quality_aa.png",
															touchAble = "False",
															UILayoutViewModel = 
															{
																PositionX = 130,
																PositionY = 350,
															},
															width = "225",
															ZOrder = "1",
														},
													},
												},
												{
													controlID = "Panel_mvp_Panel_item_Panel_item_1_Panel_team_Attack_Panel_root_Panel-battleResultView_ui_battle_Game",
													UUID = "d7f0383c_2c11_4d5d_865c_ae4a76d546af",
													anchorPoint = "False",
													anchorPointX = "0.5",
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
													height = "470",
													ignoreSize = "False",
													name = "Panel_mvp",
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
													width = "280",
													ZOrder = "1",
												},
												{
													controlID = "Panel_ctrl_Panel_item_Panel_item_1_Panel_team_Attack_Panel_root_Panel-battleResultView_ui_battle_Game",
													UUID = "3cc09a9c_9d8c_4881_8083_96524f3c948d",
													anchorPoint = "False",
													anchorPointX = "0.5",
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
													height = "470",
													ignoreSize = "False",
													name = "Panel_ctrl",
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
													width = "280",
													ZOrder = "1",
													components = 
													{
														
														{
															controlID = "Image_ctrl_bg_Panel_ctrl_Panel_item_Panel_item_1_Panel_team_Attack_Panel_root_Panel-battleResultView_ui_battle_Game",
															UUID = "a35d8bb6_6afa_4592_b36a_0033acb7503e",
															anchorPoint = "False",
															anchorPointX = "0.5",
															anchorPointY = "0",
															backGroundScale9Enable = "False",
															classname = "MEImage",
															dstBlendFunc = "771",
															height = "190",
															ignoreSize = "True",
															name = "Image_ctrl_bg",
															sizepercentx = "0",
															sizepercenty = "0",
															sizeType = "0",
															srcBlendFunc = "1",
															texturePath = "ui/fight_result/lianji_ditu_1.png",
															touchAble = "True",
															UILayoutViewModel = 
															{
																
															},
															width = "278",
															ZOrder = "1",
														},
														{
															controlID = "Button_add_friend_Panel_ctrl_Panel_item_Panel_item_1_Panel_team_Attack_Panel_root_Panel-battleResultView_ui_battle_Game",
															UUID = "cb43bf3f_7326_449f_9196_13b1400fcf53",
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
															name = "Button_add_friend",
															normal = "ui/fight_result/add_friend.png",
															sizepercentx = "0",
															sizepercenty = "0",
															sizeType = "0",
															srcBlendFunc = "1",
															touchAble = "True",
															UILayoutViewModel = 
															{
																PositionX = -80,
																PositionY = 45,
															},
															UItype = "Button",
															width = "62",
															ZOrder = "1",
														},
														{
															controlID = "Button_thumb_Panel_ctrl_Panel_item_Panel_item_1_Panel_team_Attack_Panel_root_Panel-battleResultView_ui_battle_Game",
															UUID = "d6b5065c_6e42_4781_94cd_c595da34ee47",
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
															name = "Button_thumb",
															normal = "ui/fight_result/like_1.png",
															sizepercentx = "0",
															sizepercenty = "0",
															sizeType = "0",
															srcBlendFunc = "1",
															touchAble = "True",
															UILayoutViewModel = 
															{
																PositionY = 45,
															},
															UItype = "Button",
															width = "62",
															ZOrder = "1",
														},
														{
															controlID = "Button_inform_Panel_ctrl_Panel_item_Panel_item_1_Panel_team_Attack_Panel_root_Panel-battleResultView_ui_battle_Game",
															UUID = "ae5acf22_11e7_4f14_9b40_32bcb45b21cf",
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
															name = "Button_inform",
															normal = "ui/fight_result/inform_1.png",
															sizepercentx = "0",
															sizepercenty = "0",
															sizeType = "0",
															srcBlendFunc = "1",
															touchAble = "True",
															UILayoutViewModel = 
															{
																PositionX = 80,
																PositionY = 45,
															},
															UItype = "Button",
															width = "62",
															ZOrder = "1",
															components = 
															{
																
																{
																	controlID = "Label_title_Button_inform_Panel_ctrl_Panel_item_Panel_item_1_Panel_team_Attack_Panel_root_Panel-battleResultView_ui_battle_Game",
																	UUID = "56e0fd8a_d1d1_4ee9_80a7_5e51a6f84063",
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
																		IsStroke = true,
																		StrokeColor = "#FFF06481",
																		StrokeSize = 1,
																	},
																	height = "23",
																	ignoreSize = "True",
																	name = "Label_title",
																	nTextAlign = "1",
																	nTextHAlign = "1",
																	sizepercentx = "0",
																	sizepercenty = "0",
																	sizeType = "0",
																	srcBlendFunc = "770",
																	text = "举报",
																	touchAble = "False",
																	touchScaleEnable = "False",
																	UILayoutViewModel = 
																	{
																		PositionY = -30,
																	},
																	width = "40",
																	ZOrder = "1",
																},
															},
														},
													},
												},
												{
													controlID = "Panel_fight_Panel_item_Panel_item_1_Panel_team_Attack_Panel_root_Panel-battleResultView_ui_battle_Game",
													UUID = "d0675266_2690_4324_b668_cf775bc757bd",
													anchorPoint = "False",
													anchorPointX = "0.5",
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
													height = "470",
													ignoreSize = "False",
													name = "Panel_fight",
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
													width = "280",
													ZOrder = "1",
													components = 
													{
														
														{
															controlID = "Image_num_bg_Panel_fight_Panel_item_Panel_item_1_Panel_team_Attack_Panel_root_Panel-battleResultView_ui_battle_Game",
															UUID = "cc6dee72_e436_4784_8eea_638e027a486d",
															anchorPoint = "False",
															anchorPointX = "0.5",
															anchorPointY = "0.5",
															backGroundScale9Enable = "False",
															classname = "MEImage",
															dstBlendFunc = "771",
															height = "74",
															ignoreSize = "True",
															name = "Image_num_bg",
															sizepercentx = "0",
															sizepercenty = "0",
															sizeType = "0",
															srcBlendFunc = "1",
															texturePath = "ui/fight_result/number_2.png",
															touchAble = "False",
															UILayoutViewModel = 
															{
																PositionY = 140,
															},
															width = "254",
															ZOrder = "1",
														},
														{
															controlID = "Label_fight_percent_Panel_fight_Panel_item_Panel_item_1_Panel_team_Attack_Panel_root_Panel-battleResultView_ui_battle_Game",
															UUID = "9e65e8ec_466d_4ff5_bc11_c90c4640e4b2",
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
															fontSize = "20",
															fontStroke = 
															{
																IsStroke = true,
																StrokeColor = "#FF30354A",
																StrokeSize = 1,
															},
															height = "27",
															ignoreSize = "True",
															name = "Label_fight_percent",
															nTextAlign = "1",
															nTextHAlign = "1",
															sizepercentx = "0",
															sizepercenty = "0",
															sizeType = "0",
															srcBlendFunc = "770",
															text = "50%",
															touchAble = "False",
															touchScaleEnable = "False",
															UILayoutViewModel = 
															{
																PositionY = 146,
															},
															width = "58",
															ZOrder = "1",
														},
														{
															controlID = "Label_fight_num_Panel_fight_Panel_item_Panel_item_1_Panel_team_Attack_Panel_root_Panel-battleResultView_ui_battle_Game",
															UUID = "d6485f79_47a8_4198_af8d_054973e86f9c",
															anchorPoint = "False",
															anchorPointX = "0.5",
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
															fontSize = "20",
															fontStroke = 
															{
																IsStroke = false,
																StrokeColor = "#FFE6E6E6",
																StrokeSize = 1,
															},
															height = "25",
															ignoreSize = "True",
															name = "Label_fight_num",
															nTextAlign = "1",
															nTextHAlign = "1",
															sizepercentx = "0",
															sizepercenty = "0",
															sizeType = "0",
															srcBlendFunc = "770",
															text = "99999",
															touchAble = "False",
															touchScaleEnable = "False",
															UILayoutViewModel = 
															{
																PositionY = 120,
															},
															width = "87",
															ZOrder = "1",
														},
														{
															controlID = "Image_fight_logo_Panel_fight_Panel_item_Panel_item_1_Panel_team_Attack_Panel_root_Panel-battleResultView_ui_battle_Game",
															UUID = "df0c79f3_5fb2_448e_ae0a_077b5ddc29c7",
															anchorPoint = "False",
															anchorPointX = "0.5",
															anchorPointY = "0.5",
															backGroundScale9Enable = "False",
															classname = "MEImage",
															dstBlendFunc = "771",
															height = "88",
															ignoreSize = "True",
															name = "Image_fight_logo",
															sizepercentx = "0",
															sizepercenty = "0",
															sizeType = "0",
															srcBlendFunc = "1",
															texturePath = "ui/fight_result/value.png",
															touchAble = "False",
															UILayoutViewModel = 
															{
																PositionY = 175,
															},
															width = "88",
															ZOrder = "1",
														},
													},
												},
											},
										},
									},
								},
								{
									controlID = "Label_passtime_Panel_team_Attack_Panel_root_Panel-battleResultView_ui_battle_Game",
									UUID = "6d30381c_789d_41bb_8348_ca796d08f906",
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
									fontSize = "22",
									fontStroke = 
									{
										IsStroke = false,
										StrokeColor = "#FFE6E6E6",
										StrokeSize = 1,
									},
									height = "25",
									ignoreSize = "True",
									name = "Label_passtime",
									nTextAlign = "1",
									nTextHAlign = "1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "通过时间",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionX = -466,
										PositionY = -290,
									},
									visible = "False",
									width = "90",
									ZOrder = "1",
								},
								{
									controlID = "Label_passtime_value_Panel_team_Attack_Panel_root_Panel-battleResultView_ui_battle_Game",
									UUID = "6c4850ba_a495_4b10_b262_990b0511b530",
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
									fontSize = "22",
									fontStroke = 
									{
										IsStroke = false,
										StrokeColor = "#FFE6E6E6",
										StrokeSize = 1,
									},
									height = "25",
									ignoreSize = "True",
									name = "Label_passtime_value",
									nTextAlign = "1",
									nTextHAlign = "1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "00:00",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionX = -360,
										PositionY = -290,
									},
									visible = "False",
									width = "57",
									ZOrder = "1",
								},
								{
									controlID = "Panel_flags_Panel_team_Attack_Panel_root_Panel-battleResultView_ui_battle_Game",
									UUID = "2f7bd72a_18ea_4bc0_800c_a4053cc76776",
									anchorPoint = "False",
									anchorPointX = "1",
									anchorPointY = "1",
									backGroundScale9Enable = "False",
									bgColorOpacity = "50",
									bIsOpenClipping = "False",
									classname = "MEPanel",
									colorType = "0;SingleColor:#FFE6E6E6;GraduallyChangingColorStart:#FFFFFFFF;GraduallyChangingColorEnd:#FFFFFFFF;vectorX:0;vectorY:0",
									DesignHeight = "640",
									DesignType = "0",
									DesignWidth = "960",
									dstBlendFunc = "771",
									height = "400",
									ignoreSize = "False",
									name = "Panel_flags",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = 568,
										PositionY = 96,
										IsPercent = true,
										PercentX = 50,
										PercentY = 15,
									},
									uipanelviewmodel = 
									{
										Layout="Absolute",
										nType = "0"
									},
									width = "400",
									ZOrder = "1",
								},
								{
									controlID = "Image_team_pass_time_Panel_team_Attack_Panel_root_Panel-battleResultView_ui_battle_Game",
									UUID = "64f19701_c05a_46f4_8dc7_a43aaa9d7f13",
									anchorPoint = "False",
									anchorPointX = "1",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "40",
									ignoreSize = "True",
									name = "Image_team_pass_time",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/battle/result/ui_08.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = 562,
										PositionY = 139,
										IsPercent = true,
										PercentX = 49.5,
										PercentY = 21.72,
									},
									width = "210",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "Label_time_title_Image_team_pass_time_Panel_team_Attack_Panel_root_Panel-battleResultView_ui_battle_Game",
											UUID = "4716b457_e397_4438_96cb_8998ddd29f74",
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
											name = "Label_time_title",
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
											controlID = "Label_time_title_flag_Image_team_pass_time_Panel_team_Attack_Panel_root_Panel-battleResultView_ui_battle_Game",
											UUID = "d39f8d8e_f06c_42e9_aa7e_ba071505f588",
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
											text = "Time",
											touchAble = "False",
											touchScaleEnable = "False",
											UILayoutViewModel = 
											{
												PositionX = -7,
												PositionY = -12,
											},
											width = "31",
											ZOrder = "1",
										},
										{
											controlID = "Label_team_pass_time_Image_team_pass_time_Panel_team_Attack_Panel_root_Panel-battleResultView_ui_battle_Game",
											UUID = "12143c37_c4bd_483d_9e0f_b5d136a0fbfa",
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
											name = "Label_team_pass_time",
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
												PositionX = -3,
												PositionY = -48,
											},
											width = "69",
											ZOrder = "1",
										},
									},
								},
							},
						},
						{
							controlID = "Image_battleResultView_3_Panel_root_Panel-battleResultView_ui_battle_Game",
							UUID = "c3bed25f_c37a_4f93_9363_ed603e727099",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							backGroundScale9Enable = "False",
							classname = "MEImage",
							dstBlendFunc = "771",
							height = "150",
							ignoreSize = "True",
							name = "Image_battleResultView_3",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							texturePath = "ui/fight_result/success.png",
							touchAble = "False",
							UILayoutViewModel = 
							{
								PositionX = 299,
								PositionY = 229,
							},
							visible = "False",
							width = "762",
							ZOrder = "1",
						},
						{
							controlID = "Spine_battleResult_title_Panel_root_Panel-battleResultView_ui_battle_Game",
							UUID = "cf51a343_e464_4f78_8930_e2ae589e5a81",
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
							controlID = "Label_continue_Panel_root_Panel-battleResultView_ui_battle_Game",
							UUID = "8338ba49_5e28_459d_b71e_582351f4452b",
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
							controlID = "Button_share_Panel_root_Panel-battleResultView_ui_battle_Game",
							UUID = "29a1ad85_4fe3_4635_844c_6c5107070bfe",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							backGroundScale9Enable = "False",
							classname = "MEButton",
							ClickHighLightEnabled = "True",
							dstBlendFunc = "771",
							flipX = "False",
							flipY = "False",
							height = "59",
							ignoreSize = "True",
							name = "Button_share",
							normal = "ui/common/btn_share.png",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							touchAble = "True",
							UILayoutViewModel = 
							{
								PositionX = -511,
								PositionY = -275,
								IsPercent = true,
								PercentX = -45,
								PercentY = -43,
							},
							UItype = "Button",
							width = "59",
							ZOrder = "1",
						},
					},
				},
				{
					controlID = "Button_battleResultView_1_Panel-battleResultView_ui_battle_Game",
					UUID = "d40cf076_efd6_42fe_bf58_0f1e3f3a3f65",
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
					name = "Button_battleResultView_1",
					normal = "ui/common/pop_ui/pop_btn_01.png",
					sizepercentx = "0",
					sizepercenty = "0",
					sizeType = "0",
					srcBlendFunc = "1",
					touchAble = "True",
					UILayoutViewModel = 
					{
						PositionX = 1051,
						PositionY = 569,
						LeftPositon = 989,
						TopPosition = 44,
						relativeToName = "Panel",
						nType = 3,
					},
					UItype = "Button",
					width = "124",
					ZOrder = "1",
				},
				{
					controlID = "Panel_prefab_Panel-battleResultView_ui_battle_Game",
					UUID = "09219d62_31a7_40c6_97e5_5bf0c586e426",
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
						PositionX = -9,
						PositionY = -741,
						LeftPositon = -9,
						TopPosition = 741,
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
							controlID = "Panel_rewardItem_Panel_prefab_Panel-battleResultView_ui_battle_Game",
							UUID = "3acb6b3b_fd7e_4a58_a019_0b4ffd7f189d",
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
							name = "Panel_rewardItem",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							touchAble = "False",
							UILayoutViewModel = 
							{
								PositionX = 436,
								PositionY = 290,
							},
							uipanelviewmodel = 
							{
								Layout="Absolute",
								nType = "0"
							},
							width = "480",
							ZOrder = "1",
							components = 
							{
								
								{
									controlID = "ScrollView_reward_Panel_rewardItem_Panel_prefab_Panel-battleResultView_ui_battle_Game",
									UUID = "157af8db_cc95_4b07_a876_85ca5f0a98b7",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									bgColorOpacity = "50",
									bIsOpenClipping = "True",
									bounceEnable = "False",
									classname = "MEScrollView",
									colorType = "0;SingleColor:#FFE6E6E6;GraduallyChangingColorStart:#FFFFFFFF;GraduallyChangingColorEnd:#FFFFFFFF;vectorX:0;vectorY:0",
									direction = "1",
									dstBlendFunc = "771",
									height = "100",
									ignoreSize = "False",
									innerHeight = "100",
									innerWidth = "480",
									name = "ScrollView_reward",
									showScrollbar = "False",
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
									width = "480",
									ZOrder = "1",
								},
							},
						},
						{
							controlID = "Panel_role_exp_item_Panel_prefab_Panel-battleResultView_ui_battle_Game",
							UUID = "9deafd1e_82ab_48f9_adb5_ce0f74c1bcda",
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
							height = "110",
							ignoreSize = "False",
							name = "Panel_role_exp_item",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							touchAble = "False",
							UILayoutViewModel = 
							{
								PositionX = 200,
								PositionY = 200,
							},
							uipanelviewmodel = 
							{
								Layout="Absolute",
								nType = "0"
							},
							width = "80",
							ZOrder = "1",
							components = 
							{
								
								{
									controlID = "Panel_role_Panel_role_exp_item_Panel_prefab_Panel-battleResultView_ui_battle_Game",
									UUID = "6004356e_acbc_4fe2_94a8_bd6996995ce9",
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
									height = "80",
									ignoreSize = "False",
									name = "Panel_role",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionY = 14,
									},
									uipanelviewmodel = 
									{
										Layout="Absolute",
										nType = "0"
									},
									width = "80",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "Image_quality_Panel_role_Panel_role_exp_item_Panel_prefab_Panel-battleResultView_ui_battle_Game",
											UUID = "f47e95bf_76b7_4754_ad03_93d177498ee2",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											classname = "MEImage",
											dstBlendFunc = "771",
											height = "80",
											ignoreSize = "False",
											name = "Image_quality",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											texturePath = "ui/common/frame_purp.png",
											touchAble = "False",
											UILayoutViewModel = 
											{
												
											},
											width = "80",
											ZOrder = "1",
										},
										{
											controlID = "ClippingNode_mask_Panel_role_Panel_role_exp_item_Panel_prefab_Panel-battleResultView_ui_battle_Game",
											UUID = "73163dd6_40fb_4a3d_9baa_f17f530e65dc",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											classname = "MEClippingNode",
											clipNodeX = "0",
											clipNodeY = "0",
											dstBlendFunc = "771",
											height = "0",
											ignoreSize = "False",
											name = "ClippingNode_mask",
											scaleX = "0.8",
											scaleY = "0.8",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											stencilPath = "ui/head_mask1.png",
											touchAble = "False",
											UILayoutViewModel = 
											{
												relativeToName = "Panel",
											},
											width = "0",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "Image_playerIcon_ClippingNode_mask_Panel_role_Panel_role_exp_item_Panel_prefab_Panel-battleResultView_ui_battle_Game",
													UUID = "5f760523_bc15_4870_bc59_1b28f1d7ee87",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0.5",
													backGroundScale9Enable = "False",
													classname = "MEImage",
													dstBlendFunc = "771",
													height = "92",
													ignoreSize = "True",
													name = "Image_playerIcon",
													scaleX = "0.9",
													scaleY = "0.9",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "1",
													texturePath = "icon/hero/face/1101011.png",
													touchAble = "False",
													UILayoutViewModel = 
													{
														PositionX = -24,
													},
													width = "156",
													ZOrder = "1",
												},
											},
										},
										{
											controlID = "Image_level_bg_Panel_role_Panel_role_exp_item_Panel_prefab_Panel-battleResultView_ui_battle_Game",
											UUID = "1d93bfb4_b4c1_4c62_ae49_7b88d6d37c95",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											classname = "MEImage",
											dstBlendFunc = "771",
											height = "18",
											ignoreSize = "False",
											name = "Image_level_bg",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											texturePath = "ui/common/level_bg.png",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionY = 27,
											},
											width = "72",
											ZOrder = "1",
										},
										{
											controlID = "Label_level_Panel_role_Panel_role_exp_item_Panel_prefab_Panel-battleResultView_ui_battle_Game",
											UUID = "56da5eb6_2877_4520_b90c_cf200ff22b9e",
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
											name = "Label_level",
											nTextAlign = "1",
											nTextHAlign = "1",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "770",
											text = "Lv 10",
											touchAble = "False",
											touchScaleEnable = "False",
											UILayoutViewModel = 
											{
												PositionX = -37,
												PositionY = 27,
											},
											width = "39",
											ZOrder = "1",
										},
										{
											controlID = "Image_pinzhi_Panel_role_Panel_role_exp_item_Panel_prefab_Panel-battleResultView_ui_battle_Game",
											UUID = "4b9bf788_2d05_4f65_b2c1_abe38d388ee3",
											anchorPoint = "False",
											anchorPointX = "0",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											classname = "MEImage",
											dstBlendFunc = "771",
											height = "159",
											ignoreSize = "True",
											name = "Image_pinzhi",
											scaleX = "0.15",
											scaleY = "0.15",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											texturePath = "ui/common/hero/quality_ss.png",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = -35,
												PositionY = -21,
											},
											width = "262",
											ZOrder = "1",
										},
									},
								},
								{
									controlID = "Image_roleExp_Panel_role_exp_item_Panel_prefab_Panel-battleResultView_ui_battle_Game",
									UUID = "1601babf_52a2_40b8_9489_17c10834c30e",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "8",
									ignoreSize = "True",
									name = "Image_roleExp",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/battle/result/ui_05.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionY = -30,
									},
									width = "73",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "LoadingBar_roleExp_Image_roleExp_Panel_role_exp_item_Panel_prefab_Panel-battleResultView_ui_battle_Game",
											UUID = "f7ce6cf2_8530_48a0_a7d8_0bb59bcf2b72",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											classname = "MELoadingBar",
											direction = "0",
											dstBlendFunc = "771",
											height = "6",
											ignoreSize = "True",
											name = "LoadingBar_roleExp",
											percent = "100",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											texture = "ui/battle/result/ui_04.png",
											touchAble = "False",
											UILayoutViewModel = 
											{
												
											},
											width = "71",
											ZOrder = "1",
										},
									},
								},
								{
									controlID = "Label_exp_Panel_role_exp_item_Panel_prefab_Panel-battleResultView_ui_battle_Game",
									UUID = "7ba26608_7678_41c1_99d3_9c03c69794f4",
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
									name = "Label_exp",
									nTextAlign = "1",
									nTextHAlign = "1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "+2000",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionY = -45,
									},
									width = "59",
									ZOrder = "1",
								},
							},
						},
						{
							controlID = "Panel_flag_item_Panel_prefab_Panel-battleResultView_ui_battle_Game",
							UUID = "8815f24e_7c70_4a6f_960f_4e70f50885cd",
							anchorPoint = "False",
							anchorPointX = "1",
							anchorPointY = "1",
							backGroundScale9Enable = "False",
							bgColorOpacity = "50",
							bIsOpenClipping = "False",
							classname = "MEPanel",
							colorType = "0;SingleColor:#FFE6E6E6;GraduallyChangingColorStart:#FFFFFFFF;GraduallyChangingColorEnd:#FFFFFFFF;vectorX:0;vectorY:0",
							DesignHeight = "640",
							DesignType = "0",
							DesignWidth = "960",
							dstBlendFunc = "771",
							height = "80",
							ignoreSize = "False",
							name = "Panel_flag_item",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							touchAble = "False",
							UILayoutViewModel = 
							{
								PositionX = 1145,
								PositionY = 200,
							},
							uipanelviewmodel = 
							{
								Layout="Absolute",
								nType = "0"
							},
							width = "400",
							ZOrder = "1",
							components = 
							{
								
								{
									controlID = "Image_icon_Panel_flag_item_Panel_prefab_Panel-battleResultView_ui_battle_Game",
									UUID = "d9f923c5_dda9_4c5f_87af_5eedfa48c271",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "100",
									ignoreSize = "True",
									name = "Image_icon",
									scaleX = "0.5",
									scaleY = "0.5",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "icon/system/005.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = -385,
										PositionY = -40,
									},
									width = "100",
									ZOrder = "1",
								},
								{
									controlID = "Label_desc_Panel_flag_item_Panel_prefab_Panel-battleResultView_ui_battle_Game",
									UUID = "3bb6710f_1f87_4f57_861e_cd35465a2b78",
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
									nTextAlign = "1",
									nTextHAlign = "0",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "通关队伍中包含火焰属性和雷达属性伤害的精灵",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionX = -358,
										PositionY = -40,
									},
									width = "330",
									ZOrder = "1",
								},
								{
									controlID = "Image_state_Panel_flag_item_Panel_prefab_Panel-battleResultView_ui_battle_Game",
									UUID = "d6bd2c5d_6871_41a4_9ebc_f51860fc9214",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "66",
									ignoreSize = "True",
									name = "Image_state",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/fuben/boss_challege/03.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = -20,
										PositionY = -40,
									},
									width = "66",
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
		Action0 = 
		{
			name = "Action0",
			FPS = 30,
			duration = 0.7,
			looptimes = 1,
			autoplay = false,
			{
				id = "Image_battleResultView_3_Panel_root_Panel-battleResultView_ui_battle_Game",
				name = "Panel.Panel_root.Image_battleResultView_3",
				frames = 
				{
					
					{
						alpha = 0,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 0,
						percentenable = false,
						perposition = 
						{
							x=0,
							y=0,
						},
						position = 
						{
							x=195,
							y=229,
						},
						rotate = 0,
						scale = 
						{
							x=1,
							y=1,
						},
						srcBlendFunc = 1,
						tweenToNext = true,
						visible = true,
					},
					{
						alpha = 0,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 8,
						percentenable = false,
						perposition = 
						{
							x=0,
							y=0,
						},
						position = 
						{
							x=195,
							y=229,
						},
						rotate = 0,
						scale = 
						{
							x=1,
							y=1,
						},
						srcBlendFunc = 1,
						tweenToNext = true,
						visible = true,
					},
					{
						alpha = 255,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 11,
						percentenable = false,
						perposition = 
						{
							x=0,
							y=0,
						},
						position = 
						{
							x=310,
							y=229,
						},
						rotate = 0,
						scale = 
						{
							x=1,
							y=1,
						},
						srcBlendFunc = 1,
						tweenToNext = true,
						visible = true,
					},
					{
						alpha = 255,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 15,
						percentenable = false,
						perposition = 
						{
							x=0,
							y=0,
						},
						position = 
						{
							x=299,
							y=229,
						},
						rotate = 0,
						scale = 
						{
							x=1,
							y=1,
						},
						srcBlendFunc = 1,
						tweenToNext = true,
						visible = true,
					},
				},
			},
			{
				id = "Image_pass_time_Panel_evaluation_Panel_root_Panel-battleResultView_ui_battle_Game",
				name = "Panel.Panel_root.Panel_evaluation.Image_pass_time",
				frames = 
				{
					
					{
						alpha = 0,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 0,
						percentenable = false,
						perposition = 
						{
							x=-14.52,
							y=38.5,
						},
						position = 
						{
							x=-40,
							y=154,
						},
						rotate = 0,
						scale = 
						{
							x=1,
							y=1,
						},
						srcBlendFunc = 1,
						tweenToNext = true,
						visible = true,
					},
					{
						alpha = 0,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 8,
						percentenable = false,
						perposition = 
						{
							x=0,
							y=0,
						},
						position = 
						{
							x=-40,
							y=154,
						},
						rotate = 0,
						scale = 
						{
							x=1,
							y=1,
						},
						srcBlendFunc = 1,
						tweenToNext = true,
						visible = true,
					},
					{
						alpha = 255,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 11,
						percentenable = false,
						perposition = 
						{
							x=0,
							y=0,
						},
						position = 
						{
							x=-88,
							y=154,
						},
						rotate = 0,
						scale = 
						{
							x=1,
							y=1,
						},
						srcBlendFunc = 1,
						tweenToNext = true,
						visible = true,
					},
					{
						alpha = 255,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 14,
						percentenable = false,
						perposition = 
						{
							x=0,
							y=0,
						},
						position = 
						{
							x=-85,
							y=154,
						},
						rotate = 0,
						scale = 
						{
							x=1,
							y=1,
						},
						srcBlendFunc = 1,
						tweenToNext = true,
						visible = true,
					},
				},
			},
			{
				id = "Image_pass_review_Panel_evaluation_Panel_root_Panel-battleResultView_ui_battle_Game",
				name = "Panel.Panel_root.Panel_evaluation.Image_pass_review",
				frames = 
				{
					
					{
						alpha = 0,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 0,
						percentenable = false,
						perposition = 
						{
							x=0,
							y=0,
						},
						position = 
						{
							x=-90,
							y=7,
						},
						rotate = 0,
						scale = 
						{
							x=1,
							y=1,
						},
						srcBlendFunc = 1,
						tweenToNext = true,
						visible = true,
					},
					{
						alpha = 0,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 9,
						percentenable = false,
						perposition = 
						{
							x=-22.04,
							y=1.75,
						},
						position = 
						{
							x=-90,
							y=7,
						},
						rotate = 0,
						scale = 
						{
							x=1,
							y=1,
						},
						srcBlendFunc = 1,
						tweenToNext = true,
						visible = true,
					},
					{
						alpha = 255,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 12,
						percentenable = false,
						perposition = 
						{
							x=0,
							y=0,
						},
						position = 
						{
							x=-130,
							y=7,
						},
						rotate = 0,
						scale = 
						{
							x=1,
							y=1,
						},
						srcBlendFunc = 1,
						tweenToNext = true,
						visible = true,
					},
					{
						alpha = 255,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 15,
						percentenable = false,
						perposition = 
						{
							x=0,
							y=0,
						},
						position = 
						{
							x=-125,
							y=7,
						},
						rotate = 0,
						scale = 
						{
							x=1,
							y=1,
						},
						srcBlendFunc = 1,
						tweenToNext = true,
						visible = true,
					},
				},
			},
			{
				id = "Image_battleResultView_2(3)_Panel_evaluation_Panel_root_Panel-battleResultView_ui_battle_Game",
				name = "Panel.Panel_root.Panel_evaluation.Image_battleResultView_2(3)",
				frames = 
				{
					
					{
						alpha = 0,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 0,
						percentenable = false,
						perposition = 
						{
							x=0,
							y=0,
						},
						position = 
						{
							x=0,
							y=-65,
						},
						rotate = 0,
						scale = 
						{
							x=1,
							y=1,
						},
						srcBlendFunc = 1,
						tweenToNext = true,
						visible = true,
					},
					{
						alpha = 0,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 9,
						percentenable = false,
						perposition = 
						{
							x=0,
							y=0,
						},
						position = 
						{
							x=20,
							y=-65,
						},
						rotate = 0,
						scale = 
						{
							x=1,
							y=1,
						},
						srcBlendFunc = 1,
						tweenToNext = true,
						visible = true,
					},
					{
						alpha = 255,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 11,
						percentenable = false,
						perposition = 
						{
							x=0,
							y=0,
						},
						position = 
						{
							x=-64,
							y=-65,
						},
						rotate = 0,
						scale = 
						{
							x=1,
							y=1,
						},
						srcBlendFunc = 1,
						tweenToNext = true,
						visible = true,
					},
					{
						alpha = 0,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 17,
						percentenable = false,
						perposition = 
						{
							x=0,
							y=0,
						},
						position = 
						{
							x=-64,
							y=-65,
						},
						rotate = 0,
						scale = 
						{
							x=1,
							y=1,
						},
						srcBlendFunc = 1,
						tweenToNext = true,
						visible = true,
					},
				},
			},
			{
				id = "Image_battleResultView_2(2)_Panel_evaluation_Panel_root_Panel-battleResultView_ui_battle_Game",
				name = "Panel.Panel_root.Panel_evaluation.Image_battleResultView_2(2)",
				frames = 
				{
					
					{
						alpha = 0,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 0,
						percentenable = false,
						perposition = 
						{
							x=0,
							y=0,
						},
						position = 
						{
							x=-10,
							y=-106,
						},
						rotate = 0,
						scale = 
						{
							x=1,
							y=1,
						},
						srcBlendFunc = 1,
						tweenToNext = true,
						visible = true,
					},
					{
						alpha = 0,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 11,
						percentenable = false,
						perposition = 
						{
							x=0,
							y=0,
						},
						position = 
						{
							x=10,
							y=-106,
						},
						rotate = 0,
						scale = 
						{
							x=1,
							y=1,
						},
						srcBlendFunc = 1,
						tweenToNext = true,
						visible = true,
					},
					{
						alpha = 255,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 13,
						percentenable = false,
						perposition = 
						{
							x=0,
							y=0,
						},
						position = 
						{
							x=-75,
							y=-106,
						},
						rotate = 0,
						scale = 
						{
							x=1,
							y=1,
						},
						srcBlendFunc = 1,
						tweenToNext = true,
						visible = true,
					},
					{
						alpha = 0,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 19,
						percentenable = false,
						perposition = 
						{
							x=0,
							y=0,
						},
						position = 
						{
							x=-75,
							y=-106,
						},
						rotate = 0,
						scale = 
						{
							x=1,
							y=1,
						},
						srcBlendFunc = 1,
						tweenToNext = true,
						visible = true,
					},
				},
			},
			{
				id = "Image_battleResultView_2_Panel_evaluation_Panel_root_Panel-battleResultView_ui_battle_Game",
				name = "Panel.Panel_root.Panel_evaluation.Image_battleResultView_2",
				frames = 
				{
					
					{
						alpha = 0,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 0,
						percentenable = false,
						perposition = 
						{
							x=0,
							y=0,
						},
						position = 
						{
							x=-20,
							y=-149,
						},
						rotate = 0,
						scale = 
						{
							x=1,
							y=1,
						},
						srcBlendFunc = 1,
						tweenToNext = true,
						visible = true,
					},
					{
						alpha = 0,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 13,
						percentenable = false,
						perposition = 
						{
							x=0,
							y=0,
						},
						position = 
						{
							x=0,
							y=-149,
						},
						rotate = 0,
						scale = 
						{
							x=1,
							y=1,
						},
						srcBlendFunc = 1,
						tweenToNext = true,
						visible = true,
					},
					{
						alpha = 255,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 15,
						percentenable = false,
						perposition = 
						{
							x=0,
							y=0,
						},
						position = 
						{
							x=-86,
							y=-149,
						},
						rotate = 0,
						scale = 
						{
							x=1,
							y=1,
						},
						srcBlendFunc = 1,
						tweenToNext = true,
						visible = true,
					},
					{
						alpha = 0,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 21,
						percentenable = false,
						perposition = 
						{
							x=0,
							y=0,
						},
						position = 
						{
							x=-86,
							y=-149,
						},
						rotate = 0,
						scale = 
						{
							x=1,
							y=1,
						},
						srcBlendFunc = 1,
						tweenToNext = true,
						visible = true,
					},
				},
			},
			{
				id = "Panel_target_1_Image_pass_review_Panel_evaluation_Panel_root_Panel-battleResultView_ui_battle_Game",
				name = "Panel.Panel_root.Panel_evaluation.Image_pass_review.Panel_target_1",
				frames = 
				{
					
					{
						alpha = 0,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 0,
						percentenable = false,
						perposition = 
						{
							x=-32.08,
							y=-17,
						},
						position = 
						{
							x=-130,
							y=-68,
						},
						rotate = 0,
						scale = 
						{
							x=1,
							y=1,
						},
						srcBlendFunc = 1,
						tweenToNext = true,
						visible = true,
					},
					{
						alpha = 0,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 12,
						percentenable = false,
						perposition = 
						{
							x=-32.08,
							y=-17,
						},
						position = 
						{
							x=-150,
							y=-68,
						},
						rotate = 0,
						scale = 
						{
							x=1,
							y=1,
						},
						srcBlendFunc = 1,
						tweenToNext = true,
						visible = true,
					},
					{
						alpha = 255,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 16,
						percentenable = false,
						perposition = 
						{
							x=-32.08,
							y=-17,
						},
						position = 
						{
							x=-179,
							y=-68,
						},
						rotate = 0,
						scale = 
						{
							x=1,
							y=1,
						},
						srcBlendFunc = 1,
						tweenToNext = true,
						visible = true,
					},
				},
			},
			{
				id = "Panel_target_2_Image_pass_review_Panel_evaluation_Panel_root_Panel-battleResultView_ui_battle_Game",
				name = "Panel.Panel_root.Panel_evaluation.Image_pass_review.Panel_target_2",
				frames = 
				{
					
					{
						alpha = 0,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 0,
						percentenable = false,
						perposition = 
						{
							x=-34.23,
							y=-27.25,
						},
						position = 
						{
							x=-140,
							y=-109,
						},
						rotate = 0,
						scale = 
						{
							x=1,
							y=1,
						},
						srcBlendFunc = 1,
						tweenToNext = true,
						visible = true,
					},
					{
						alpha = 0,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 14,
						percentenable = false,
						perposition = 
						{
							x=-34.23,
							y=-27.25,
						},
						position = 
						{
							x=-160,
							y=-109,
						},
						rotate = 0,
						scale = 
						{
							x=1,
							y=1,
						},
						srcBlendFunc = 1,
						tweenToNext = true,
						visible = true,
					},
					{
						alpha = 255,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 18,
						percentenable = false,
						perposition = 
						{
							x=-34.23,
							y=-27.25,
						},
						position = 
						{
							x=-191,
							y=-109,
						},
						rotate = 0,
						scale = 
						{
							x=1,
							y=1,
						},
						srcBlendFunc = 1,
						tweenToNext = true,
						visible = true,
					},
				},
			},
			{
				id = "Panel_target_3_Image_pass_review_Panel_evaluation_Panel_root_Panel-battleResultView_ui_battle_Game",
				name = "Panel.Panel_root.Panel_evaluation.Image_pass_review.Panel_target_3",
				frames = 
				{
					
					{
						alpha = 0,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 0,
						percentenable = false,
						perposition = 
						{
							x=-36.2,
							y=-37.75,
						},
						position = 
						{
							x=-150,
							y=-151,
						},
						rotate = 0,
						scale = 
						{
							x=1,
							y=1,
						},
						srcBlendFunc = 1,
						tweenToNext = true,
						visible = true,
					},
					{
						alpha = 0,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 16,
						percentenable = false,
						perposition = 
						{
							x=-36.2,
							y=-37.75,
						},
						position = 
						{
							x=-170,
							y=-151,
						},
						rotate = 0,
						scale = 
						{
							x=1,
							y=1,
						},
						srcBlendFunc = 1,
						tweenToNext = true,
						visible = true,
					},
					{
						alpha = 255,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 20,
						percentenable = false,
						perposition = 
						{
							x=-36.2,
							y=-37.75,
						},
						position = 
						{
							x=-202,
							y=-151,
						},
						rotate = 0,
						scale = 
						{
							x=1,
							y=1,
						},
						srcBlendFunc = 1,
						tweenToNext = true,
						visible = true,
					},
				},
			},
			{
				id = "Label_continue_Panel_root_Panel-battleResultView_ui_battle_Game",
				name = "Panel.Panel_root.Label_continue",
				frames = 
				{
					
					{
						alpha = 0,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 0,
						percentenable = false,
						perposition = 
						{
							x=0,
							y=-40,
						},
						position = 
						{
							x=0,
							y=-256,
						},
						rotate = 0,
						scale = 
						{
							x=1,
							y=1,
						},
						srcBlendFunc = 770,
						tweenToNext = true,
						visible = true,
					},
					{
						alpha = 0,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 16,
						percentenable = false,
						perposition = 
						{
							x=0,
							y=-40,
						},
						position = 
						{
							x=0,
							y=-256,
						},
						rotate = 0,
						scale = 
						{
							x=1,
							y=1,
						},
						srcBlendFunc = 770,
						tweenToNext = true,
						visible = true,
					},
					{
						alpha = 255,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 20,
						percentenable = false,
						perposition = 
						{
							x=0,
							y=-40,
						},
						position = 
						{
							x=0,
							y=-256,
						},
						rotate = 0,
						scale = 
						{
							x=1,
							y=1,
						},
						srcBlendFunc = 770,
						tweenToNext = true,
						visible = true,
					},
				},
			},
			{
				id = "Image_endless_Panel_evaluation_Panel_root_Panel-battleResultView_ui_battle_Game",
				name = "Panel.Panel_root.Panel_evaluation.Image_endless",
				frames = 
				{
					
					{
						alpha = 0,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 0,
						percentenable = false,
						perposition = 
						{
							x=0,
							y=0,
						},
						position = 
						{
							x=-103,
							y=5,
						},
						rotate = 0,
						scale = 
						{
							x=1,
							y=1,
						},
						srcBlendFunc = 1,
						tweenToNext = true,
						visible = true,
					},
					{
						alpha = 0,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 9,
						percentenable = false,
						perposition = 
						{
							x=0,
							y=0,
						},
						position = 
						{
							x=-103,
							y=5,
						},
						rotate = 0,
						scale = 
						{
							x=1,
							y=1,
						},
						srcBlendFunc = 1,
						tweenToNext = true,
						visible = true,
					},
					{
						alpha = 255,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 12,
						percentenable = false,
						perposition = 
						{
							x=0,
							y=0,
						},
						position = 
						{
							x=-133,
							y=5,
						},
						rotate = 0,
						scale = 
						{
							x=1,
							y=1,
						},
						srcBlendFunc = 1,
						tweenToNext = true,
						visible = true,
					},
					{
						alpha = 255,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 16,
						percentenable = false,
						perposition = 
						{
							x=0,
							y=0,
						},
						position = 
						{
							x=-123,
							y=5,
						},
						rotate = 0,
						scale = 
						{
							x=1,
							y=1,
						},
						srcBlendFunc = 1,
						tweenToNext = true,
						visible = true,
					},
				},
			},
		},
		Action1 = 
		{
			name = "Action1",
			FPS = 30,
			duration = 0.7,
			looptimes = 1,
			autoplay = false,
			{
				id = "Image_battleResultView_3_Panel_root_Panel-battleResultView_ui_battle_Game",
				name = "Panel.Panel_root.Image_battleResultView_3",
				frames = 
				{
					
					{
						alpha = 0,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 0,
						percentenable = false,
						perposition = 
						{
							x=0,
							y=0,
						},
						position = 
						{
							x=250,
							y=229,
						},
						rotate = 0,
						scale = 
						{
							x=1,
							y=1,
						},
						srcBlendFunc = 1,
						tweenToNext = true,
						visible = true,
					},
					{
						alpha = 0,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 6,
						percentenable = false,
						perposition = 
						{
							x=0,
							y=0,
						},
						position = 
						{
							x=250,
							y=229,
						},
						rotate = 0,
						scale = 
						{
							x=1,
							y=1,
						},
						srcBlendFunc = 1,
						tweenToNext = true,
						visible = true,
					},
					{
						alpha = 255,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 10,
						percentenable = false,
						perposition = 
						{
							x=0,
							y=0,
						},
						position = 
						{
							x=305,
							y=229,
						},
						rotate = 0,
						scale = 
						{
							x=1,
							y=1,
						},
						srcBlendFunc = 1,
						tweenToNext = true,
						visible = true,
					},
					{
						alpha = 255,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 13,
						percentenable = false,
						perposition = 
						{
							x=0,
							y=0,
						},
						position = 
						{
							x=299,
							y=229,
						},
						rotate = 0,
						scale = 
						{
							x=1,
							y=1,
						},
						srcBlendFunc = 1,
						tweenToNext = true,
						visible = true,
					},
				},
			},
			{
				id = "Image_pass_time_Panel_evaluation_Panel_root_Panel-battleResultView_ui_battle_Game",
				name = "Panel.Panel_root.Panel_evaluation.Image_pass_time",
				frames = 
				{
					
					{
						alpha = 0,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 0,
						percentenable = false,
						perposition = 
						{
							x=0,
							y=0,
						},
						position = 
						{
							x=-60,
							y=154,
						},
						rotate = 0,
						scale = 
						{
							x=1,
							y=1,
						},
						srcBlendFunc = 1,
						tweenToNext = true,
						visible = true,
					},
					{
						alpha = 0,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 9,
						percentenable = false,
						perposition = 
						{
							x=0,
							y=0,
						},
						position = 
						{
							x=-60,
							y=154,
						},
						rotate = 0,
						scale = 
						{
							x=1,
							y=1,
						},
						srcBlendFunc = 1,
						tweenToNext = true,
						visible = true,
					},
					{
						alpha = 255,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 12,
						percentenable = false,
						perposition = 
						{
							x=0,
							y=0,
						},
						position = 
						{
							x=-88,
							y=154,
						},
						rotate = 0,
						scale = 
						{
							x=1,
							y=1,
						},
						srcBlendFunc = 1,
						tweenToNext = true,
						visible = true,
					},
					{
						alpha = 255,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 15,
						percentenable = false,
						perposition = 
						{
							x=0,
							y=0,
						},
						position = 
						{
							x=-85,
							y=154,
						},
						rotate = 0,
						scale = 
						{
							x=1,
							y=1,
						},
						srcBlendFunc = 1,
						tweenToNext = true,
						visible = true,
					},
				},
			},
			{
				id = "Image_pass_review_Panel_evaluation_Panel_root_Panel-battleResultView_ui_battle_Game",
				name = "Panel.Panel_root.Panel_evaluation.Image_pass_review",
				frames = 
				{
					
					{
						alpha = 0,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 0,
						percentenable = false,
						perposition = 
						{
							x=0,
							y=0,
						},
						position = 
						{
							x=-90,
							y=7,
						},
						rotate = 0,
						scale = 
						{
							x=1,
							y=1,
						},
						srcBlendFunc = 1,
						tweenToNext = true,
						visible = true,
					},
					{
						alpha = 0,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 11,
						percentenable = false,
						perposition = 
						{
							x=0,
							y=0,
						},
						position = 
						{
							x=-90,
							y=7,
						},
						rotate = 0,
						scale = 
						{
							x=1,
							y=1,
						},
						srcBlendFunc = 1,
						tweenToNext = true,
						visible = true,
					},
					{
						alpha = 255,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 14,
						percentenable = false,
						perposition = 
						{
							x=0,
							y=0,
						},
						position = 
						{
							x=-131,
							y=7,
						},
						rotate = 0,
						scale = 
						{
							x=1,
							y=1,
						},
						srcBlendFunc = 1,
						tweenToNext = true,
						visible = true,
					},
					{
						alpha = 255,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 17,
						percentenable = false,
						perposition = 
						{
							x=0,
							y=0,
						},
						position = 
						{
							x=-123,
							y=7,
						},
						rotate = 0,
						scale = 
						{
							x=1,
							y=1,
						},
						srcBlendFunc = 1,
						tweenToNext = true,
						visible = true,
					},
				},
			},
			{
				id = "Image_battleResultView_2(3)_Panel_evaluation_Panel_root_Panel-battleResultView_ui_battle_Game",
				name = "Panel.Panel_root.Panel_evaluation.Image_battleResultView_2(3)",
				frames = 
				{
					
					{
						alpha = 0,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 0,
						percentenable = false,
						perposition = 
						{
							x=0,
							y=0,
						},
						position = 
						{
							x=20,
							y=-65,
						},
						rotate = 0,
						scale = 
						{
							x=1,
							y=1,
						},
						srcBlendFunc = 1,
						tweenToNext = true,
						visible = true,
					},
					{
						alpha = 0,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 11,
						percentenable = false,
						perposition = 
						{
							x=0,
							y=0,
						},
						position = 
						{
							x=20,
							y=-65,
						},
						rotate = 0,
						scale = 
						{
							x=1,
							y=1,
						},
						srcBlendFunc = 1,
						tweenToNext = true,
						visible = true,
					},
					{
						alpha = 255,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 13,
						percentenable = false,
						perposition = 
						{
							x=0,
							y=0,
						},
						position = 
						{
							x=-64,
							y=-65,
						},
						rotate = 0,
						scale = 
						{
							x=1,
							y=1,
						},
						srcBlendFunc = 1,
						tweenToNext = true,
						visible = true,
					},
					{
						alpha = 0,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 17,
						percentenable = false,
						perposition = 
						{
							x=0,
							y=0,
						},
						position = 
						{
							x=-70,
							y=-65,
						},
						rotate = 0,
						scale = 
						{
							x=1,
							y=1,
						},
						srcBlendFunc = 1,
						tweenToNext = true,
						visible = true,
					},
				},
			},
			{
				id = "Image_battleResultView_2(2)_Panel_evaluation_Panel_root_Panel-battleResultView_ui_battle_Game",
				name = "Panel.Panel_root.Panel_evaluation.Image_battleResultView_2(2)",
				frames = 
				{
					
					{
						alpha = 0,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 0,
						percentenable = false,
						perposition = 
						{
							x=0,
							y=0,
						},
						position = 
						{
							x=10,
							y=-106,
						},
						rotate = 0,
						scale = 
						{
							x=1,
							y=1,
						},
						srcBlendFunc = 1,
						tweenToNext = true,
						visible = true,
					},
					{
						alpha = 0,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 13,
						percentenable = false,
						perposition = 
						{
							x=0,
							y=0,
						},
						position = 
						{
							x=10,
							y=-106,
						},
						rotate = 0,
						scale = 
						{
							x=1,
							y=1,
						},
						srcBlendFunc = 1,
						tweenToNext = true,
						visible = true,
					},
					{
						alpha = 255,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 15,
						percentenable = false,
						perposition = 
						{
							x=0,
							y=0,
						},
						position = 
						{
							x=-75,
							y=-106,
						},
						rotate = 0,
						scale = 
						{
							x=1,
							y=1,
						},
						srcBlendFunc = 1,
						tweenToNext = true,
						visible = true,
					},
					{
						alpha = 0,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 18,
						percentenable = false,
						perposition = 
						{
							x=0,
							y=0,
						},
						position = 
						{
							x=-80,
							y=-106,
						},
						rotate = 0,
						scale = 
						{
							x=1,
							y=1,
						},
						srcBlendFunc = 1,
						tweenToNext = true,
						visible = true,
					},
				},
			},
			{
				id = "Image_battleResultView_2_Panel_evaluation_Panel_root_Panel-battleResultView_ui_battle_Game",
				name = "Panel.Panel_root.Panel_evaluation.Image_battleResultView_2",
				frames = 
				{
					
					{
						alpha = 0,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 0,
						percentenable = false,
						perposition = 
						{
							x=0,
							y=0,
						},
						position = 
						{
							x=0,
							y=-149,
						},
						rotate = 0,
						scale = 
						{
							x=1,
							y=1,
						},
						srcBlendFunc = 1,
						tweenToNext = true,
						visible = true,
					},
					{
						alpha = 0,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 15,
						percentenable = false,
						perposition = 
						{
							x=0,
							y=0,
						},
						position = 
						{
							x=0,
							y=-149,
						},
						rotate = 0,
						scale = 
						{
							x=1,
							y=1,
						},
						srcBlendFunc = 1,
						tweenToNext = true,
						visible = true,
					},
					{
						alpha = 255,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 17,
						percentenable = false,
						perposition = 
						{
							x=0,
							y=0,
						},
						position = 
						{
							x=-86,
							y=-149,
						},
						rotate = 0,
						scale = 
						{
							x=1,
							y=1,
						},
						srcBlendFunc = 1,
						tweenToNext = true,
						visible = true,
					},
					{
						alpha = 0,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 20,
						percentenable = false,
						perposition = 
						{
							x=0,
							y=0,
						},
						position = 
						{
							x=-90,
							y=-149,
						},
						rotate = 0,
						scale = 
						{
							x=1,
							y=1,
						},
						srcBlendFunc = 1,
						tweenToNext = true,
						visible = true,
					},
				},
			},
			{
				id = "Panel_target_1_Image_pass_review_Panel_evaluation_Panel_root_Panel-battleResultView_ui_battle_Game",
				name = "Panel.Panel_root.Panel_evaluation.Image_pass_review.Panel_target_1",
				frames = 
				{
					
					{
						alpha = 0,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 0,
						percentenable = false,
						perposition = 
						{
							x=-32.08,
							y=-17,
						},
						position = 
						{
							x=-160,
							y=-68,
						},
						rotate = 0,
						scale = 
						{
							x=1,
							y=1,
						},
						srcBlendFunc = 1,
						tweenToNext = true,
						visible = true,
					},
					{
						alpha = 0,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 12,
						percentenable = false,
						perposition = 
						{
							x=-32.08,
							y=-17,
						},
						position = 
						{
							x=-160,
							y=-68,
						},
						rotate = 0,
						scale = 
						{
							x=1,
							y=1,
						},
						srcBlendFunc = 1,
						tweenToNext = true,
						visible = true,
					},
					{
						alpha = 255,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 17,
						percentenable = false,
						perposition = 
						{
							x=-32.08,
							y=-17,
						},
						position = 
						{
							x=-179,
							y=-68,
						},
						rotate = 0,
						scale = 
						{
							x=1,
							y=1,
						},
						srcBlendFunc = 1,
						tweenToNext = true,
						visible = true,
					},
				},
			},
			{
				id = "Panel_target_2_Image_pass_review_Panel_evaluation_Panel_root_Panel-battleResultView_ui_battle_Game",
				name = "Panel.Panel_root.Panel_evaluation.Image_pass_review.Panel_target_2",
				frames = 
				{
					
					{
						alpha = 0,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 0,
						percentenable = false,
						perposition = 
						{
							x=-34.23,
							y=-27.25,
						},
						position = 
						{
							x=-170,
							y=-109,
						},
						rotate = 0,
						scale = 
						{
							x=1,
							y=1,
						},
						srcBlendFunc = 1,
						tweenToNext = true,
						visible = true,
					},
					{
						alpha = 0,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 14,
						percentenable = false,
						perposition = 
						{
							x=-34.23,
							y=-27.25,
						},
						position = 
						{
							x=-170,
							y=-109,
						},
						rotate = 0,
						scale = 
						{
							x=1,
							y=1,
						},
						srcBlendFunc = 1,
						tweenToNext = true,
						visible = true,
					},
					{
						alpha = 255,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 19,
						percentenable = false,
						perposition = 
						{
							x=-34.23,
							y=-27.25,
						},
						position = 
						{
							x=-191,
							y=-109,
						},
						rotate = 0,
						scale = 
						{
							x=1,
							y=1,
						},
						srcBlendFunc = 1,
						tweenToNext = true,
						visible = true,
					},
				},
			},
			{
				id = "Panel_target_3_Image_pass_review_Panel_evaluation_Panel_root_Panel-battleResultView_ui_battle_Game",
				name = "Panel.Panel_root.Panel_evaluation.Image_pass_review.Panel_target_3",
				frames = 
				{
					
					{
						alpha = 0,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 0,
						percentenable = false,
						perposition = 
						{
							x=-36.2,
							y=-37.75,
						},
						position = 
						{
							x=-180,
							y=-151,
						},
						rotate = 0,
						scale = 
						{
							x=1,
							y=1,
						},
						srcBlendFunc = 1,
						tweenToNext = true,
						visible = true,
					},
					{
						alpha = 0,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 16,
						percentenable = false,
						perposition = 
						{
							x=-36.2,
							y=-37.75,
						},
						position = 
						{
							x=-180,
							y=-151,
						},
						rotate = 0,
						scale = 
						{
							x=1,
							y=1,
						},
						srcBlendFunc = 1,
						tweenToNext = true,
						visible = true,
					},
					{
						alpha = 255,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 21,
						percentenable = false,
						perposition = 
						{
							x=-36.2,
							y=-37.75,
						},
						position = 
						{
							x=-202,
							y=-151,
						},
						rotate = 0,
						scale = 
						{
							x=1,
							y=1,
						},
						srcBlendFunc = 1,
						tweenToNext = true,
						visible = true,
					},
				},
			},
			{
				id = "Label_continue_Panel_root_Panel-battleResultView_ui_battle_Game",
				name = "Panel.Panel_root.Label_continue",
				frames = 
				{
					
					{
						alpha = 0,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 0,
						percentenable = false,
						perposition = 
						{
							x=0,
							y=-40,
						},
						position = 
						{
							x=0,
							y=-256,
						},
						rotate = 0,
						scale = 
						{
							x=1,
							y=1,
						},
						srcBlendFunc = 770,
						tweenToNext = true,
						visible = true,
					},
					{
						alpha = 0,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 16,
						percentenable = false,
						perposition = 
						{
							x=0,
							y=-40,
						},
						position = 
						{
							x=0,
							y=-256,
						},
						rotate = 0,
						scale = 
						{
							x=1,
							y=1,
						},
						srcBlendFunc = 770,
						tweenToNext = true,
						visible = true,
					},
					{
						alpha = 255,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 21,
						percentenable = false,
						perposition = 
						{
							x=0,
							y=-40,
						},
						position = 
						{
							x=0,
							y=-256,
						},
						rotate = 0,
						scale = 
						{
							x=1,
							y=1,
						},
						srcBlendFunc = 770,
						tweenToNext = true,
						visible = true,
					},
				},
			},
			{
				id = "Image_endless_Panel_evaluation_Panel_root_Panel-battleResultView_ui_battle_Game",
				name = "Panel.Panel_root.Panel_evaluation.Image_endless",
				frames = 
				{
					
					{
						alpha = 0,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 0,
						percentenable = false,
						perposition = 
						{
							x=0,
							y=0,
						},
						position = 
						{
							x=-103,
							y=5,
						},
						rotate = 0,
						scale = 
						{
							x=1,
							y=1,
						},
						srcBlendFunc = 1,
						tweenToNext = true,
						visible = true,
					},
					{
						alpha = 0,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 11,
						percentenable = false,
						perposition = 
						{
							x=0,
							y=0,
						},
						position = 
						{
							x=-113,
							y=5,
						},
						rotate = 0,
						scale = 
						{
							x=1,
							y=1,
						},
						srcBlendFunc = 1,
						tweenToNext = true,
						visible = true,
					},
					{
						alpha = 255,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 14,
						percentenable = false,
						perposition = 
						{
							x=0,
							y=0,
						},
						position = 
						{
							x=-133,
							y=5,
						},
						rotate = 0,
						scale = 
						{
							x=1,
							y=1,
						},
						srcBlendFunc = 1,
						tweenToNext = true,
						visible = true,
					},
					{
						alpha = 255,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 17,
						percentenable = false,
						perposition = 
						{
							x=0,
							y=0,
						},
						position = 
						{
							x=-123,
							y=5,
						},
						rotate = 0,
						scale = 
						{
							x=1,
							y=1,
						},
						srcBlendFunc = 1,
						tweenToNext = true,
						visible = true,
					},
				},
			},
		},
		Action2 = 
		{
			name = "Action2",
			FPS = 30,
			duration = 0.3,
			looptimes = 1,
			autoplay = false,
			{
				id = "Image_pass_time_Panel_evaluation_Panel_root_Panel-battleResultView_ui_battle_Game",
				name = "Panel.Panel_root.Panel_evaluation.Image_pass_time",
				frames = 
				{
					
					{
						alpha = 255,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 0,
						percentenable = false,
						perposition = 
						{
							x=0,
							y=0,
						},
						position = 
						{
							x=-81,
							y=154,
						},
						rotate = 0,
						scale = 
						{
							x=1,
							y=1,
						},
						srcBlendFunc = 1,
						tweenToNext = true,
						visible = true,
					},
					{
						alpha = 0,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 5,
						percentenable = false,
						perposition = 
						{
							x=0,
							y=0,
						},
						position = 
						{
							x=-100,
							y=154,
						},
						rotate = 0,
						scale = 
						{
							x=1,
							y=1,
						},
						srcBlendFunc = 1,
						tweenToNext = true,
						visible = true,
					},
				},
			},
			{
				id = "Image_pass_review_Panel_evaluation_Panel_root_Panel-battleResultView_ui_battle_Game",
				name = "Panel.Panel_root.Panel_evaluation.Image_pass_review",
				frames = 
				{
					
					{
						alpha = 255,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 0,
						percentenable = false,
						perposition = 
						{
							x=0,
							y=0,
						},
						position = 
						{
							x=-123,
							y=7,
						},
						rotate = 0,
						scale = 
						{
							x=1,
							y=1,
						},
						srcBlendFunc = 1,
						tweenToNext = true,
						visible = true,
					},
					{
						alpha = 0,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 6,
						percentenable = false,
						perposition = 
						{
							x=0,
							y=0,
						},
						position = 
						{
							x=-140,
							y=7,
						},
						rotate = 0,
						scale = 
						{
							x=1,
							y=1,
						},
						srcBlendFunc = 1,
						tweenToNext = true,
						visible = true,
					},
				},
			},
			{
				id = "Panel_target_1_Image_pass_review_Panel_evaluation_Panel_root_Panel-battleResultView_ui_battle_Game",
				name = "Panel.Panel_root.Panel_evaluation.Image_pass_review.Panel_target_1",
				frames = 
				{
					
					{
						alpha = 255,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 0,
						percentenable = false,
						perposition = 
						{
							x=-32.08,
							y=-17,
						},
						position = 
						{
							x=-179,
							y=-68,
						},
						rotate = 0,
						scale = 
						{
							x=1,
							y=1,
						},
						srcBlendFunc = 1,
						tweenToNext = true,
						visible = true,
					},
					{
						alpha = 255,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 1,
						percentenable = false,
						perposition = 
						{
							x=-33.72,
							y=-17,
						},
						position = 
						{
							x=-179,
							y=-68,
						},
						rotate = 0,
						scale = 
						{
							x=1,
							y=1,
						},
						srcBlendFunc = 1,
						tweenToNext = true,
						visible = true,
					},
					{
						alpha = 0,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 7,
						percentenable = false,
						perposition = 
						{
							x=-32.08,
							y=-17,
						},
						position = 
						{
							x=-195,
							y=-68,
						},
						rotate = 0,
						scale = 
						{
							x=1,
							y=1,
						},
						srcBlendFunc = 1,
						tweenToNext = true,
						visible = true,
					},
				},
			},
			{
				id = "Panel_target_2_Image_pass_review_Panel_evaluation_Panel_root_Panel-battleResultView_ui_battle_Game",
				name = "Panel.Panel_root.Panel_evaluation.Image_pass_review.Panel_target_2",
				frames = 
				{
					
					{
						alpha = 255,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 0,
						percentenable = false,
						perposition = 
						{
							x=-34.23,
							y=-27.25,
						},
						position = 
						{
							x=-191,
							y=-109,
						},
						rotate = 0,
						scale = 
						{
							x=1,
							y=1,
						},
						srcBlendFunc = 1,
						tweenToNext = true,
						visible = true,
					},
					{
						alpha = 255,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 2,
						percentenable = false,
						perposition = 
						{
							x=-36.18,
							y=-27.25,
						},
						position = 
						{
							x=-191,
							y=-109,
						},
						rotate = 0,
						scale = 
						{
							x=1,
							y=1,
						},
						srcBlendFunc = 1,
						tweenToNext = true,
						visible = true,
					},
					{
						alpha = 0,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 8,
						percentenable = false,
						perposition = 
						{
							x=-34.23,
							y=-27.25,
						},
						position = 
						{
							x=-210,
							y=-109,
						},
						rotate = 0,
						scale = 
						{
							x=1,
							y=1,
						},
						srcBlendFunc = 1,
						tweenToNext = true,
						visible = true,
					},
				},
			},
			{
				id = "Panel_target_3_Image_pass_review_Panel_evaluation_Panel_root_Panel-battleResultView_ui_battle_Game",
				name = "Panel.Panel_root.Panel_evaluation.Image_pass_review.Panel_target_3",
				frames = 
				{
					
					{
						alpha = 255,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 0,
						percentenable = false,
						perposition = 
						{
							x=-36.2,
							y=-37.75,
						},
						position = 
						{
							x=-202,
							y=-151,
						},
						rotate = 0,
						scale = 
						{
							x=1,
							y=1,
						},
						srcBlendFunc = 1,
						tweenToNext = true,
						visible = true,
					},
					{
						alpha = 255,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 3,
						percentenable = false,
						perposition = 
						{
							x=-38.04,
							y=-37.75,
						},
						position = 
						{
							x=-202,
							y=-151,
						},
						rotate = 0,
						scale = 
						{
							x=1,
							y=1,
						},
						srcBlendFunc = 1,
						tweenToNext = true,
						visible = true,
					},
					{
						alpha = 0,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 9,
						percentenable = false,
						perposition = 
						{
							x=-36.2,
							y=-37.75,
						},
						position = 
						{
							x=-220,
							y=-151,
						},
						rotate = 0,
						scale = 
						{
							x=1,
							y=1,
						},
						srcBlendFunc = 1,
						tweenToNext = true,
						visible = true,
					},
				},
			},
			{
				id = "ClippingNode_mask_Panel_reward_Panel_root_Panel-battleResultView_ui_battle_Game",
				name = "Panel.Panel_root.Panel_reward.ClippingNode_mask",
				frames = 
				{
					
					{
						alpha = 0,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 0,
						percentenable = false,
						perposition = 
						{
							x=-26.88,
							y=32.25,
						},
						position = 
						{
							x=-130,
							y=129,
						},
						rotate = 0,
						scale = 
						{
							x=1,
							y=1,
						},
						srcBlendFunc = 1,
						tweenToNext = true,
						visible = true,
					},
					{
						alpha = 0,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 3,
						percentenable = false,
						perposition = 
						{
							x=-24.64,
							y=32.25,
						},
						position = 
						{
							x=-130,
							y=129,
						},
						rotate = 0,
						scale = 
						{
							x=1,
							y=1,
						},
						srcBlendFunc = 1,
						tweenToNext = true,
						visible = true,
					},
					{
						alpha = 255,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 7,
						percentenable = false,
						perposition = 
						{
							x=-26.88,
							y=32.25,
						},
						position = 
						{
							x=-150,
							y=129,
						},
						rotate = 0,
						scale = 
						{
							x=1,
							y=1,
						},
						srcBlendFunc = 1,
						tweenToNext = true,
						visible = true,
					},
				},
			},
			{
				id = "Label_playerName_Panel_reward_Panel_root_Panel-battleResultView_ui_battle_Game",
				name = "Panel.Panel_root.Panel_reward.Label_playerName",
				frames = 
				{
					
					{
						alpha = 0,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 0,
						percentenable = false,
						perposition = 
						{
							x=-15.95,
							y=34.5,
						},
						position = 
						{
							x=-70,
							y=138,
						},
						rotate = 0,
						scale = 
						{
							x=1,
							y=1,
						},
						srcBlendFunc = 770,
						tweenToNext = true,
						visible = true,
					},
					{
						alpha = 0,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 3,
						percentenable = false,
						perposition = 
						{
							x=-13.82,
							y=34.5,
						},
						position = 
						{
							x=-70,
							y=138,
						},
						rotate = 0,
						scale = 
						{
							x=1,
							y=1,
						},
						srcBlendFunc = 770,
						tweenToNext = true,
						visible = true,
					},
					{
						alpha = 255,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 7,
						percentenable = false,
						perposition = 
						{
							x=-15.95,
							y=34.5,
						},
						position = 
						{
							x=-89,
							y=138,
						},
						rotate = 0,
						scale = 
						{
							x=1,
							y=1,
						},
						srcBlendFunc = 770,
						tweenToNext = true,
						visible = true,
					},
				},
			},
			{
				id = "Label_playerLevel_Panel_reward_Panel_root_Panel-battleResultView_ui_battle_Game",
				name = "Panel.Panel_root.Panel_reward.Label_playerLevel",
				frames = 
				{
					
					{
						alpha = 0,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 0,
						percentenable = false,
						perposition = 
						{
							x=13.26,
							y=34.75,
						},
						position = 
						{
							x=160,
							y=139,
						},
						rotate = 0,
						scale = 
						{
							x=1,
							y=1,
						},
						srcBlendFunc = 770,
						tweenToNext = true,
						visible = true,
					},
					{
						alpha = 0,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 3,
						percentenable = false,
						perposition = 
						{
							x=15.5,
							y=34.75,
						},
						position = 
						{
							x=150,
							y=139,
						},
						rotate = 0,
						scale = 
						{
							x=1,
							y=1,
						},
						srcBlendFunc = 770,
						tweenToNext = true,
						visible = true,
					},
					{
						alpha = 255,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 7,
						percentenable = false,
						perposition = 
						{
							x=13.26,
							y=34.75,
						},
						position = 
						{
							x=139,
							y=139,
						},
						rotate = 0,
						scale = 
						{
							x=1,
							y=1,
						},
						srcBlendFunc = 770,
						tweenToNext = true,
						visible = true,
					},
				},
			},
			{
				id = "Label_playerExp_Image_exp_bg_Panel_extend_Panel_reward_Panel_root_Panel-battleResultView_ui_battle_Game",
				name = "Panel.Panel_root.Panel_reward.Panel_extend.Image_exp_bg.Label_playerExp",
				frames = 
				{
					
					{
						alpha = 0,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 0,
						percentenable = false,
						perposition = 
						{
							x=24.91,
							y=29,
						},
						position = 
						{
							x=159,
							y=116,
						},
						rotate = 0,
						scale = 
						{
							x=1,
							y=1,
						},
						srcBlendFunc = 770,
						tweenToNext = true,
						visible = true,
					},
					{
						alpha = 0,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 3,
						percentenable = false,
						perposition = 
						{
							x=27.15,
							y=29,
						},
						position = 
						{
							x=159,
							y=116,
						},
						rotate = 0,
						scale = 
						{
							x=1,
							y=1,
						},
						srcBlendFunc = 770,
						tweenToNext = true,
						visible = true,
					},
					{
						alpha = 255,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 7,
						percentenable = false,
						perposition = 
						{
							x=24.91,
							y=29,
						},
						position = 
						{
							x=139,
							y=116,
						},
						rotate = 0,
						scale = 
						{
							x=1,
							y=1,
						},
						srcBlendFunc = 770,
						tweenToNext = true,
						visible = true,
					},
				},
			},
			{
				id = "Image_playerExp_Image_exp_bg_Panel_extend_Panel_reward_Panel_root_Panel-battleResultView_ui_battle_Game",
				name = "Panel.Panel_root.Panel_reward.Panel_extend.Image_exp_bg.Image_playerExp",
				frames = 
				{
					
					{
						alpha = 0,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 0,
						percentenable = false,
						perposition = 
						{
							x=0,
							y=0,
						},
						position = 
						{
							x=40,
							y=94,
						},
						rotate = 0,
						scale = 
						{
							x=1,
							y=1,
						},
						srcBlendFunc = 1,
						tweenToNext = true,
						visible = true,
					},
					{
						alpha = 0,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 3,
						percentenable = false,
						perposition = 
						{
							x=0,
							y=0,
						},
						position = 
						{
							x=40,
							y=94,
						},
						rotate = 0,
						scale = 
						{
							x=1,
							y=1,
						},
						srcBlendFunc = 1,
						tweenToNext = true,
						visible = true,
					},
					{
						alpha = 255,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 7,
						percentenable = false,
						perposition = 
						{
							x=0,
							y=0,
						},
						position = 
						{
							x=28,
							y=94,
						},
						rotate = 0,
						scale = 
						{
							x=1,
							y=1,
						},
						srcBlendFunc = 1,
						tweenToNext = true,
						visible = true,
					},
				},
			},
			{
				id = "Image_reward_Panel_reward_Panel_root_Panel-battleResultView_ui_battle_Game",
				name = "Panel.Panel_root.Panel_reward.Image_reward",
				frames = 
				{
					
					{
						alpha = 0,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 0,
						percentenable = false,
						perposition = 
						{
							x=0,
							y=0,
						},
						position = 
						{
							x=-90,
							y=39,
						},
						rotate = 0,
						scale = 
						{
							x=1,
							y=1,
						},
						srcBlendFunc = 1,
						tweenToNext = true,
						visible = true,
					},
					{
						alpha = 0,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 4,
						percentenable = false,
						perposition = 
						{
							x=0,
							y=0,
						},
						position = 
						{
							x=-90,
							y=39,
						},
						rotate = 0,
						scale = 
						{
							x=1,
							y=1,
						},
						srcBlendFunc = 1,
						tweenToNext = true,
						visible = true,
					},
					{
						alpha = 255,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 8,
						percentenable = false,
						perposition = 
						{
							x=0,
							y=0,
						},
						position = 
						{
							x=-111,
							y=39,
						},
						rotate = 0,
						scale = 
						{
							x=1,
							y=1,
						},
						srcBlendFunc = 1,
						tweenToNext = true,
						visible = true,
					},
				},
			},
		},
	},
	respaths = 
	{
		textures = 
		{
			"ui/battle/result/bg.png",
			"ui/battle/result/ttrrrrrrr.png",
			"icon/hero/face/1101011.png",
			"ui/battle/result/ui_06.png",
			"ui/battle/n208.png",
			"ui/fight_result/reward_rise.png",
			"ui/battle/result/ui_08.png",
			"ui/common/progress_01.png",
			"ui/common/progress_02.png",
			"ui/fight_result/xiaoguo.png",
			"ui/fuben/fightingStar.png",
			"ui/fuben/fightStar_gray.png",
			"ui/simulation_trial5/result/rewardBg.png",
			"ui/battle/result/0003.png",
			"ui/battle/result/0004.png",
			"ui/battle/result/0002.png",
			"ui/battle/result/003.png",
			"ui/battle/result/004.png",
			"ui/battle/result/0020.png",
			"ui/battle/result/006.png",
			"ui/battle/result/001.png",
			"ui/onlineteam/member_bg.png",
			"icon/hero/backdrop/10101.png",
			"ui/onlineteam/member_front.png",
			"ui/onlineteam/captain_name_bg.png",
			"ui/common/hero/quality_aa.png",
			"ui/fight_result/lianji_ditu_1.png",
			"ui/fight_result/add_friend.png",
			"ui/fight_result/like_1.png",
			"ui/fight_result/inform_1.png",
			"ui/fight_result/number_2.png",
			"ui/fight_result/value.png",
			"ui/fight_result/success.png",
			"ui/common/btn_share.png",
			"ui/common/pop_ui/pop_btn_01.png",
			"ui/common/frame_purp.png",
			"ui/common/level_bg.png",
			"ui/common/hero/quality_ss.png",
			"ui/battle/result/ui_05.png",
			"ui/battle/result/ui_04.png",
			"icon/system/005.png",
			"ui/fuben/boss_challege/03.png",
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

