local t = 
{
	version = 1,
	components = 
	{
		
		{
			controlID = "Panel-exploreBattleView_Layer1_summon_Game",
			UUID = "15218106_cae9_473d_ac6f_8e5e53771f33",
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
					controlID = "Panel_root_Panel-exploreBattleView_Layer1_summon_Game",
					UUID = "4a2f019a_3f2a_4a1c_b5da_da0295794cd7",
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
							controlID = "Panel_normal_bg_Panel_root_Panel-exploreBattleView_Layer1_summon_Game",
							UUID = "f7524997_ecfd_452f_a2cf_6e84cdfd621f",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							backGroundScale9Enable = "False",
							bgColorOpacity = "50",
							bIsOpenClipping = "False",
							classname = "MEPanel",
							colorType = "0;SingleColor:#FFFF0000;GraduallyChangingColorStart:#FFFFFFFF;GraduallyChangingColorEnd:#FFFFFFFF;vectorX:0;vectorY:0",
							DesignHeight = "640",
							DesignType = "0",
							DesignWidth = "960",
							dstBlendFunc = "771",
							height = "320",
							ignoreSize = "False",
							name = "Panel_normal_bg",
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
							controlID = "Panel_battle_bg_Panel_root_Panel-exploreBattleView_Layer1_summon_Game",
							UUID = "9eea12f7_0d1f_47a1_a595_bdbf2a0fdce5",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							backGroundScale9Enable = "False",
							bgColorOpacity = "50",
							bIsOpenClipping = "False",
							classname = "MEPanel",
							colorType = "0;SingleColor:#FFFF0000;GraduallyChangingColorStart:#FFFFFFFF;GraduallyChangingColorEnd:#FFFFFFFF;vectorX:0;vectorY:0",
							DesignHeight = "640",
							DesignType = "0",
							DesignWidth = "960",
							dstBlendFunc = "771",
							height = "320",
							ignoreSize = "False",
							name = "Panel_battle_bg",
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
							visible = "False",
							width = "1136",
							ZOrder = "1",
							components = 
							{
								
								{
									controlID = "LoadingBar_bg_Panel_battle_bg_Panel_root_Panel-exploreBattleView_Layer1_summon_Game",
									UUID = "c93284e1_8635_41c1_a9a7_370477be7113",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MELoadingBar",
									direction = "0",
									dstBlendFunc = "771",
									height = "320",
									ignoreSize = "True",
									name = "LoadingBar_bg",
									percent = "100",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texture = "ui/explore/explore/bg.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										
									},
									width = "1200",
									ZOrder = "1",
								},
								{
									controlID = "Spine_progress_Panel_battle_bg_Panel_root_Panel-exploreBattleView_Layer1_summon_Game",
									UUID = "f6184e14_843f_425f_bee4_236ad23a8543",
									classname = "MESpine",
									dstBlendFunc = "771",
									name = "Spine_progress",
									rotation = "90",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									spineModel = 
									{
										SpinePath = "effect/effect_10305_energy/effect_10305_energy",
										animationName = "animation",
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
										
									},
									ZOrder = "1",
								},
								{
									controlID = "Spine_start_Panel_battle_bg_Panel_root_Panel-exploreBattleView_Layer1_summon_Game",
									UUID = "484da065_0fb7_4a54_800e_281434d0d300",
									classname = "MESpine",
									dstBlendFunc = "771",
									name = "Spine_start",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									spineModel = 
									{
										SpinePath = "effect/battle_Start/battle_Start",
										animationName = "battle_Start",
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
										
									},
									ZOrder = "1",
								},
							},
						},
						{
							controlID = "Panel_content_Panel_root_Panel-exploreBattleView_Layer1_summon_Game",
							UUID = "367ce57b_8d6b_4be1_90e0_00cceb1092eb",
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
							height = "320",
							ignoreSize = "False",
							name = "Panel_content",
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
							visible = "False",
							width = "1136",
							ZOrder = "1",
							components = 
							{
								
								{
									controlID = "Panel_left_Panel_content_Panel_root_Panel-exploreBattleView_Layer1_summon_Game",
									UUID = "fd9b2cab_6057_465f_893d_7dbdb34df75c",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									bgColorOpacity = "100",
									bIsOpenClipping = "False",
									classname = "MEPanel",
									colorType = "0;SingleColor:#FF32CD32;GraduallyChangingColorStart:#FFFFFFFF;GraduallyChangingColorEnd:#FFFFFFFF;vectorX:0;vectorY:0",
									DesignHeight = "640",
									DesignType = "0",
									DesignWidth = "960",
									dstBlendFunc = "771",
									height = "320",
									ignoreSize = "False",
									name = "Panel_left",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = -300,
									},
									uipanelviewmodel = 
									{
										Layout="Absolute",
										nType = "0"
									},
									width = "500",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "Panel_role1_Panel_left_Panel_content_Panel_root_Panel-exploreBattleView_Layer1_summon_Game",
											UUID = "635c4e87_5d36_4a2d_9e74_1308e08f1588",
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
											height = "300",
											ignoreSize = "False",
											name = "Panel_role1",
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
											width = "300",
											ZOrder = "1",
										},
										{
											controlID = "Image_hp1_Panel_left_Panel_content_Panel_root_Panel-exploreBattleView_Layer1_summon_Game",
											UUID = "72fd3147_adb4_46ec_baef_888e7a65b4dc",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											classname = "MEImage",
											dstBlendFunc = "771",
											height = "12",
											ignoreSize = "False",
											name = "Image_hp1",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "770",
											texturePath = "ui/common/progress_03.png",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionY = -100,
											},
											width = "200",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "LoadingBar_hp1_Image_hp1_Panel_left_Panel_content_Panel_root_Panel-exploreBattleView_Layer1_summon_Game",
													UUID = "16d95861_d086_4331_93af_bb186dd94965",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0.5",
													backGroundScale9Enable = "False",
													classname = "MELoadingBar",
													direction = "0",
													dstBlendFunc = "771",
													height = "12",
													ignoreSize = "False",
													name = "LoadingBar_hp1",
													percent = "100",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "1",
													texture = "ui/common/progress_04.png",
													touchAble = "False",
													UILayoutViewModel = 
													{
														
													},
													width = "200",
													ZOrder = "1",
												},
											},
										},
									},
								},
								{
									controlID = "Panel_right_Panel_content_Panel_root_Panel-exploreBattleView_Layer1_summon_Game",
									UUID = "5021468c_92e0_4b70_96e8_bac907cd4091",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									bgColorOpacity = "100",
									bIsOpenClipping = "False",
									classname = "MEPanel",
									colorType = "0;SingleColor:#FFFFA500;GraduallyChangingColorStart:#FFFFFFFF;GraduallyChangingColorEnd:#FFFFFFFF;vectorX:0;vectorY:0",
									DesignHeight = "640",
									DesignType = "0",
									DesignWidth = "960",
									dstBlendFunc = "771",
									height = "320",
									ignoreSize = "False",
									name = "Panel_right",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = 300,
									},
									uipanelviewmodel = 
									{
										Layout="Absolute",
										nType = "0"
									},
									width = "500",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "Panel_role2_Panel_right_Panel_content_Panel_root_Panel-exploreBattleView_Layer1_summon_Game",
											UUID = "78c0882c_6699_4e02_9055_a266e80c3393",
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
											height = "300",
											ignoreSize = "False",
											name = "Panel_role2",
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
											width = "300",
											ZOrder = "1",
										},
										{
											controlID = "Image_hp2_Panel_right_Panel_content_Panel_root_Panel-exploreBattleView_Layer1_summon_Game",
											UUID = "1a6ea6cc_2f0e_4ca0_b67c_9eb597219a0e",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											classname = "MEImage",
											dstBlendFunc = "771",
											height = "12",
											ignoreSize = "False",
											name = "Image_hp2",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "770",
											texturePath = "ui/common/progress_03.png",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionY = -100,
											},
											width = "200",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "LoadingBar_hp2_Image_hp2_Panel_right_Panel_content_Panel_root_Panel-exploreBattleView_Layer1_summon_Game",
													UUID = "ad32b72a_aede_44cf_af5b_901d8c1840fa",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0.5",
													backGroundScale9Enable = "False",
													classname = "MELoadingBar",
													direction = "0",
													dstBlendFunc = "771",
													height = "12",
													ignoreSize = "False",
													name = "LoadingBar_hp2",
													percent = "100",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "1",
													texture = "ui/common/progress_04.png",
													touchAble = "False",
													UILayoutViewModel = 
													{
														
													},
													width = "200",
													ZOrder = "1",
												},
											},
										},
									},
								},
							},
						},
						{
							controlID = "Panel_effect_Panel_root_Panel-exploreBattleView_Layer1_summon_Game",
							UUID = "419b1791_c7df_4a67_a8dd_7a5a001cddb2",
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
							height = "320",
							ignoreSize = "False",
							name = "Panel_effect",
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
							controlID = "Button_left_Panel_root_Panel-exploreBattleView_Layer1_summon_Game",
							UUID = "03f95155_2b9b_44f0_8f99_4bd94f11c45b",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							backGroundScale9Enable = "True;capInsetsX:0;capInsetsY:0;capInsetsWidth:0;capInsetsHeight:0",
							classname = "MEButton",
							ClickHighLightEnabled = "True",
							dstBlendFunc = "771",
							flipX = "False",
							flipY = "False",
							height = "50",
							ignoreSize = "False",
							name = "Button_left",
							normal = "ui/common/button09.png",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							touchAble = "True",
							UILayoutViewModel = 
							{
								PositionX = -300,
								PositionY = 250,
							},
							UItype = "Button",
							width = "120",
							ZOrder = "1",
						},
						{
							controlID = "Button_right_Panel_root_Panel-exploreBattleView_Layer1_summon_Game",
							UUID = "7c8f837e_ad73_4bd1_8f9c_48feca60b035",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							backGroundScale9Enable = "True;capInsetsX:0;capInsetsY:0;capInsetsWidth:0;capInsetsHeight:0",
							classname = "MEButton",
							ClickHighLightEnabled = "True",
							dstBlendFunc = "771",
							flipX = "False",
							flipY = "False",
							height = "50",
							ignoreSize = "False",
							name = "Button_right",
							normal = "ui/common/button09.png",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							touchAble = "True",
							UILayoutViewModel = 
							{
								PositionX = 300,
								PositionY = 250,
							},
							UItype = "Button",
							width = "120",
							ZOrder = "1",
						},
					},
				},
				{
					controlID = "Panel_prefab_Panel-exploreBattleView_Layer1_summon_Game",
					UUID = "dd3de6b8_d0d1_4f07_97ae_e603ec8ec1dc",
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
					name = "Panel_prefab",
					sizepercentx = "35",
					sizepercenty = "62",
					sizeType = "0",
					srcBlendFunc = "1",
					touchAble = "False",
					UILayoutViewModel = 
					{
						PositionY = -900,
						TopPosition = 900,
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
							controlID = "Node_fangyu_Panel_prefab_Panel-exploreBattleView_Layer1_summon_Game",
							UUID = "11a89ed7_b70a_4dc2_9648_1bfc33f3f1a1",
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
							height = "100",
							ignoreSize = "False",
							name = "Node_fangyu",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							touchAble = "False",
							UILayoutViewModel = 
							{
								PositionX = 139,
								PositionY = 577,
								relativeToName = "Panel",
							},
							uipanelviewmodel = 
							{
								Layout="Absolute",
								nType = "0"
							},
							width = "100",
							ZOrder = "1",
							components = 
							{
								
								{
									controlID = "Label_font_Node_fangyu_Panel_prefab_Panel-exploreBattleView_Layer1_summon_Game",
									UUID = "3a0ca377_988d_4e13_ac8f_5d74ce38fef6",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									classname = "MELabel",
									compPath = "luacomponents.common.MEIconLabel",
									dstBlendFunc = "771",
									FontColor = "#FF5DCCFF",
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
										StrokeColor = "#FF30354A",
										StrokeSize = 1,
									},
									height = "32",
									ignoreSize = "True",
									name = "Label_font",
									nTextAlign = "1",
									nTextHAlign = "1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "123",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										relativeToName = "Panel",
									},
									width = "53",
									ZOrder = "1",
								},
								{
									controlID = "Image_sign_Node_fangyu_Panel_prefab_Panel-exploreBattleView_Layer1_summon_Game",
									UUID = "d853e027_32c9_4f19_bba2_143c88ed1344",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "30",
									ignoreSize = "True",
									name = "Image_sign",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/battle/sign_ruodian.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = -55,
									},
									width = "26",
									ZOrder = "1",
								},
							},
						},
						{
							controlID = "Node_yinran_Panel_prefab_Panel-exploreBattleView_Layer1_summon_Game",
							UUID = "4680d763_63a6_4b65_aa2e_65a39f3c2645",
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
							name = "Node_yinran",
							panelTexturePath = "ui/battle/bg_baoji.png",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							touchAble = "False",
							UILayoutViewModel = 
							{
								PositionX = 326,
								PositionY = 512,
								relativeToName = "Panel",
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
									controlID = "Label_font_Node_yinran_Panel_prefab_Panel-exploreBattleView_Layer1_summon_Game",
									UUID = "9acf335a_ab59_4547_85b5_b8cd13754cc1",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									classname = "MELabel",
									compPath = "luacomponents.common.MEIconLabel",
									dstBlendFunc = "771",
									FontColor = "#FFFF5050",
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
										StrokeColor = "#FF30354A",
										StrokeSize = 1,
									},
									height = "32",
									ignoreSize = "True",
									name = "Label_font",
									nTextAlign = "1",
									nTextHAlign = "1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "123",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										relativeToName = "Panel",
									},
									width = "53",
									ZOrder = "1",
								},
								{
									controlID = "Image_sign_Node_yinran_Panel_prefab_Panel-exploreBattleView_Layer1_summon_Game",
									UUID = "25e1035c_242a_4423_b17d_1f7a489db4ad",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "24",
									ignoreSize = "True",
									name = "Image_sign",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/battle/sign_baoji.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = -63,
									},
									width = "24",
									ZOrder = "1",
								},
							},
						},
						{
							controlID = "Node_putong_Panel_prefab_Panel-exploreBattleView_Layer1_summon_Game",
							UUID = "90b9b3a2_59ee_4974_bceb_3e47bb9793ec",
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
							height = "100",
							ignoreSize = "False",
							name = "Node_putong",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							touchAble = "False",
							UILayoutViewModel = 
							{
								PositionX = 449,
								PositionY = 546,
								relativeToName = "Panel",
							},
							uipanelviewmodel = 
							{
								Layout="Absolute",
								nType = "0"
							},
							width = "100",
							ZOrder = "1",
							components = 
							{
								
								{
									controlID = "Label_font_Node_putong_Panel_prefab_Panel-exploreBattleView_Layer1_summon_Game",
									UUID = "b8376784_03f9_4529_a2ba_080bca5bccda",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									classname = "MELabel",
									compPath = "luacomponents.common.MEIconLabel",
									dstBlendFunc = "771",
									FontColor = "#FFF0F3F8",
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
										StrokeColor = "#FF30354A",
										StrokeSize = 1,
									},
									height = "32",
									ignoreSize = "True",
									name = "Label_font",
									nTextAlign = "1",
									nTextHAlign = "1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "123",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										relativeToName = "Panel",
									},
									width = "53",
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
			"ui/explore/explore/bg.png",
			"ui/common/progress_03.png",
			"ui/common/progress_04.png",
			"ui/common/button09.png",
			"ui/battle/sign_ruodian.png",
			"ui/battle/bg_baoji.png",
			"ui/battle/sign_baoji.png",
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

