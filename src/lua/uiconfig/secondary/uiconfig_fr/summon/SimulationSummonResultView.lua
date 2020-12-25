local t = 
{
	version = 1,
	components = 
	{
		
		{
			controlID = "Panel-SimulationSummonResultView_Simulation_summon_Game",
			UUID = "c714dd47_53df_41fe_8a29_fc9c7d2c3f87",
			anchorPoint = "False",
			anchorPointX = "0",
			anchorPointY = "0",
			backGroundScale9Enable = "False",
			bgColorOpacity = "50",
			bIsOpenClipping = "True",
			classname = "MEPanel",
			colorType = "0;SingleColor:#FFFFA07A;GraduallyChangingColorStart:#FFFFFFFF;GraduallyChangingColorEnd:#FFFFFFFF;vectorX:0;vectorY:0",
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
					controlID = "Panel_root_Panel-SimulationSummonResultView_Simulation_summon_Game",
					UUID = "12b01e48_2726_49da_9d5e_d94ded959411",
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
							controlID = "Panel_result_Panel_root_Panel-SimulationSummonResultView_Simulation_summon_Game",
							UUID = "730e48e7_9619_4f0c_9c17_2cd7b527eb33",
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
							name = "Panel_result",
							sizepercentx = "100",
							sizepercenty = "100",
							sizeType = "1",
							srcBlendFunc = "1",
							touchAble = "False",
							UILayoutViewModel = 
							{
								relativeToName = "Panel_root",
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
									controlID = "Image_bg_Panel_result_Panel_root_Panel-SimulationSummonResultView_Simulation_summon_Game",
									UUID = "081b0189_8da1_42c8_b551_2a847f702905",
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
									texturePath = "ui/summon/bg_result.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										LeftPositon = -125,
										BottomPosition = 651,
										relativeToName = "Panel_root",
										nGravity = 4,
										nAlign = 7
									},
									width = "1386",
									ZOrder = "1",
								},
								{
									controlID = "Spine_bgfoo_Panel_result_Panel_root_Panel-SimulationSummonResultView_Simulation_summon_Game",
									UUID = "52872a75_2f90_4ab2_8c30_9590d19dcdc3",
									classname = "MESpine",
									dstBlendFunc = "771",
									name = "Spine_bgfoo",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									spineModel = 
									{
										SpinePath = "effect/summon_show_jindu/summon_show_jindu",
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
										relativeToName = "Panel",
									},
									ZOrder = "1",
								},
								{
									controlID = "Spine_bg_Panel_result_Panel_root_Panel-SimulationSummonResultView_Simulation_summon_Game",
									UUID = "0e3201fa_af25_48ac_b3e3_7204bb3968e3",
									classname = "MESpine",
									dstBlendFunc = "771",
									name = "Spine_bg",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									spineModel = 
									{
										SpinePath = "effect/summon_show_jindu/summon_show_jindu",
										animationName = "jindu_10",
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
										relativeToName = "Panel",
									},
									ZOrder = "1",
								},
								{
									controlID = "ScrollView_result_Panel_result_Panel_root_Panel-SimulationSummonResultView_Simulation_summon_Game",
									UUID = "9b496c3a_fb1f_4863_b222_cc0e245edff0",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									bgColorOpacity = "50",
									bIsOpenClipping = "False",
									bounceEnable = "False",
									classname = "MEScrollView",
									colorType = "0;SingleColor:#FFE6E6E6;GraduallyChangingColorStart:#FFFFFFFF;GraduallyChangingColorEnd:#FFFFFFFF;vectorX:0;vectorY:0",
									direction = "1",
									dstBlendFunc = "771",
									height = "250",
									ignoreSize = "False",
									innerHeight = "250",
									innerWidth = "630",
									name = "ScrollView_result",
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
									width = "630",
									ZOrder = "1",
								},
								{
									controlID = "Panel_normalGoods_Panel_result_Panel_root_Panel-SimulationSummonResultView_Simulation_summon_Game",
									UUID = "e4c626cd_9ab2_437f_b3a4_1743c0c8a7e9",
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
									name = "Panel_normalGoods",
									sizepercentx = "100",
									sizepercenty = "100",
									sizeType = "1",
									srcBlendFunc = "1",
									touchAble = "False",
									UILayoutViewModel = 
									{
										relativeToName = "Panel_root",
										nGravity = 5,
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
											controlID = "Panel_showItem_Panel_normalGoods_Panel_result_Panel_root_Panel-SimulationSummonResultView_Simulation_summon_Game",
											UUID = "ccd5eb87_72da_4a27_ad68_f02a1c5e5267",
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
											height = "200",
											ignoreSize = "False",
											name = "Panel_showItem",
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
											width = "200",
											ZOrder = "1",
										},
									},
								},
								{
									controlID = "Label_continue_Panel_result_Panel_root_Panel-SimulationSummonResultView_Simulation_summon_Game",
									UUID = "2265a89b_a7de_471e_962e_1183a7c98ac7",
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
									name = "Label_continue",
									nTextAlign = "1",
									nTextHAlign = "1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "Appuyez pour continuer",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionY = -244,
										LeftPositon = 509,
										TopPosition = 543,
										relativeToName = "Panel_root",
									},
									width = "107",
									ZOrder = "1",
								},
								{
									controlID = "Panel_touch_Panel_result_Panel_root_Panel-SimulationSummonResultView_Simulation_summon_Game",
									UUID = "3d3040a6_efb3_4cbe_8413_9fd9bdf54bcc",
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
									name = "Panel_touch",
									sizepercentx = "100",
									sizepercenty = "100",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "True",
									UILayoutViewModel = 
									{
										relativeToName = "Panel",
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
									controlID = "Panel_reward_1_Panel_result_Panel_root_Panel-SimulationSummonResultView_Simulation_summon_Game",
									UUID = "3c825f99_69c2_4409_85f1_58767291499e",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									bgColorOpacity = "100",
									bIsOpenClipping = "False",
									classname = "MEPanel",
									colorType = "1;SingleColor:#FFFF4500;GraduallyChangingColorStart:#FFFFFFFF;GraduallyChangingColorEnd:#FFFFFFFF;vectorX:0;vectorY:0",
									DesignHeight = "640",
									DesignType = "0",
									DesignWidth = "960",
									dstBlendFunc = "771",
									height = "120",
									ignoreSize = "False",
									name = "Panel_reward_1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "True",
									UILayoutViewModel = 
									{
										PositionX = -438,
										PositionY = 175,
									},
									uipanelviewmodel = 
									{
										Layout="Absolute",
										nType = "0"
									},
									visible = "False",
									width = "120",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "Spine_effect_Panel_reward_1_Panel_result_Panel_root_Panel-SimulationSummonResultView_Simulation_summon_Game",
											UUID = "668dade4_f88b_4948_9877_e4109486e6fe",
											classname = "MESpine",
											dstBlendFunc = "771",
											name = "Spine_effect",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											spineModel = 
											{
												SpinePath = "effect/summon_show/summon_show",
												animationName = "huangsaoguang",
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
												PositionY = 3,
											},
											ZOrder = "1",
										},
										{
											controlID = "Spine_reward_Panel_reward_1_Panel_result_Panel_root_Panel-SimulationSummonResultView_Simulation_summon_Game",
											UUID = "ad897e51_b05d_4242_9408_2f0786edf994",
											classname = "MESpine",
											dstBlendFunc = "771",
											name = "Spine_reward",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											spineModel = 
											{
												SpinePath = "effect/summon_show/summon_show",
												animationName = "yellow_dynamic1",
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
												PositionY = 3,
											},
											ZOrder = "1",
										},
										{
											controlID = "Spine_saoguang_Panel_reward_1_Panel_result_Panel_root_Panel-SimulationSummonResultView_Simulation_summon_Game",
											UUID = "e506cb07_6f92_4396_8aac_9239a0503356",
											classname = "MESpine",
											dstBlendFunc = "771",
											name = "Spine_saoguang",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											spineModel = 
											{
												SpinePath = "effect/summon_show/summon_show",
												animationName = "yellow_dynamic1",
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
												PositionY = 3,
											},
											ZOrder = "1",
										},
									},
								},
								{
									controlID = "Panel_reward_2_Panel_result_Panel_root_Panel-SimulationSummonResultView_Simulation_summon_Game",
									UUID = "14a85a05_e580_45e6_90e9_b8a630ef2fad",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									bgColorOpacity = "100",
									bIsOpenClipping = "False",
									classname = "MEPanel",
									colorType = "1;SingleColor:#FFFF4500;GraduallyChangingColorStart:#FFFFFFFF;GraduallyChangingColorEnd:#FFFFFFFF;vectorX:0;vectorY:0",
									DesignHeight = "640",
									DesignType = "0",
									DesignWidth = "960",
									dstBlendFunc = "771",
									height = "120",
									ignoreSize = "False",
									name = "Panel_reward_2",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "True",
									UILayoutViewModel = 
									{
										PositionX = -353,
										PositionY = -20,
									},
									uipanelviewmodel = 
									{
										Layout="Absolute",
										nType = "0"
									},
									visible = "False",
									width = "120",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "Spine_effect_Panel_reward_2_Panel_result_Panel_root_Panel-SimulationSummonResultView_Simulation_summon_Game",
											UUID = "ed8f7346_0fda_4c54_9af4_4e55b0d62431",
											classname = "MESpine",
											dstBlendFunc = "771",
											name = "Spine_effect",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											spineModel = 
											{
												SpinePath = "effect/summon_show/summon_show",
												animationName = "lizixunhuan",
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
												PositionY = 3,
											},
											ZOrder = "1",
										},
										{
											controlID = "Spine_reward_Panel_reward_2_Panel_result_Panel_root_Panel-SimulationSummonResultView_Simulation_summon_Game",
											UUID = "20237c1f_6870_4d93_b15d_c4f3d04161f3",
											classname = "MESpine",
											dstBlendFunc = "771",
											name = "Spine_reward",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											spineModel = 
											{
												SpinePath = "effect/summon_show/summon_show",
												animationName = "blue_static2",
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
												PositionY = 3,
											},
											ZOrder = "1",
										},
										{
											controlID = "Spine_saoguang_Panel_reward_2_Panel_result_Panel_root_Panel-SimulationSummonResultView_Simulation_summon_Game",
											UUID = "e86692a9_75a2_40fc_8bfd_b2b7ff87e516",
											classname = "MESpine",
											dstBlendFunc = "771",
											name = "Spine_saoguang",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											spineModel = 
											{
												SpinePath = "effect/summon_show/summon_show",
												animationName = "yellow_dynamic1",
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
												PositionY = 3,
											},
											ZOrder = "1",
										},
									},
								},
								{
									controlID = "Panel_reward_3_Panel_result_Panel_root_Panel-SimulationSummonResultView_Simulation_summon_Game",
									UUID = "3240390e_866a_4b94_8556_044c16dd777d",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									bgColorOpacity = "100",
									bIsOpenClipping = "False",
									classname = "MEPanel",
									colorType = "1;SingleColor:#FFFF4500;GraduallyChangingColorStart:#FFFFFFFF;GraduallyChangingColorEnd:#FFFFFFFF;vectorX:0;vectorY:0",
									DesignHeight = "640",
									DesignType = "0",
									DesignWidth = "960",
									dstBlendFunc = "771",
									height = "120",
									ignoreSize = "False",
									name = "Panel_reward_3",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "True",
									UILayoutViewModel = 
									{
										PositionX = -212,
										PositionY = 125,
									},
									uipanelviewmodel = 
									{
										Layout="Absolute",
										nType = "0"
									},
									visible = "False",
									width = "120",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "Spine_effect_Panel_reward_3_Panel_result_Panel_root_Panel-SimulationSummonResultView_Simulation_summon_Game",
											UUID = "ed1b4eaa_19d5_4e74_99f3_c92757dd07c5",
											classname = "MESpine",
											dstBlendFunc = "771",
											name = "Spine_effect",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											spineModel = 
											{
												SpinePath = "effect/summon_show/summon_show",
												animationName = "blue_static6",
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
												PositionY = 3,
											},
											ZOrder = "1",
										},
										{
											controlID = "Spine_reward_Panel_reward_3_Panel_result_Panel_root_Panel-SimulationSummonResultView_Simulation_summon_Game",
											UUID = "e9baff1b_6329_49a9_97c8_f91693515cce",
											classname = "MESpine",
											dstBlendFunc = "771",
											name = "Spine_reward",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											spineModel = 
											{
												SpinePath = "effect/summon_show/summon_show",
												animationName = "blue_static2",
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
												PositionY = 3,
											},
											ZOrder = "1",
										},
										{
											controlID = "Spine_saoguang_Panel_reward_3_Panel_result_Panel_root_Panel-SimulationSummonResultView_Simulation_summon_Game",
											UUID = "1809ae47_2f37_4222_828e_1e51097b7247",
											classname = "MESpine",
											dstBlendFunc = "771",
											name = "Spine_saoguang",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											spineModel = 
											{
												SpinePath = "effect/summon_show/summon_show",
												animationName = "yellow_dynamic1",
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
												PositionY = 3,
											},
											ZOrder = "1",
										},
									},
								},
								{
									controlID = "Panel_reward_4_Panel_result_Panel_root_Panel-SimulationSummonResultView_Simulation_summon_Game",
									UUID = "f354dbdb_d8d6_4623_84e6_e9e3497e20be",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									bgColorOpacity = "100",
									bIsOpenClipping = "False",
									classname = "MEPanel",
									colorType = "1;SingleColor:#FFFF4500;GraduallyChangingColorStart:#FFFFFFFF;GraduallyChangingColorEnd:#FFFFFFFF;vectorX:0;vectorY:0",
									DesignHeight = "640",
									DesignType = "0",
									DesignWidth = "960",
									dstBlendFunc = "771",
									height = "120",
									ignoreSize = "False",
									name = "Panel_reward_4",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "True",
									UILayoutViewModel = 
									{
										PositionX = -158,
										PositionY = -109,
									},
									uipanelviewmodel = 
									{
										Layout="Absolute",
										nType = "0"
									},
									visible = "False",
									width = "120",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "Spine_effect_Panel_reward_4_Panel_result_Panel_root_Panel-SimulationSummonResultView_Simulation_summon_Game",
											UUID = "97a86e70_fbda_481f_ad50_139611695a79",
											classname = "MESpine",
											dstBlendFunc = "771",
											name = "Spine_effect",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											spineModel = 
											{
												SpinePath = "effect/summon_show/summon_show",
												animationName = "lizixunhuan",
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
												PositionY = 3,
											},
											ZOrder = "1",
										},
										{
											controlID = "Spine_reward_Panel_reward_4_Panel_result_Panel_root_Panel-SimulationSummonResultView_Simulation_summon_Game",
											UUID = "dd6dc620_3269_4e0f_adcf_5ca51bf2e0cc",
											classname = "MESpine",
											dstBlendFunc = "771",
											name = "Spine_reward",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											spineModel = 
											{
												SpinePath = "effect/summon_show/summon_show",
												animationName = "blue_static2",
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
												PositionY = 3,
											},
											ZOrder = "1",
										},
										{
											controlID = "Spine_saoguang_Panel_reward_4_Panel_result_Panel_root_Panel-SimulationSummonResultView_Simulation_summon_Game",
											UUID = "293f02c3_24d9_4f1a_8dd0_77b05caad9fa",
											classname = "MESpine",
											dstBlendFunc = "771",
											name = "Spine_saoguang",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											spineModel = 
											{
												SpinePath = "effect/summon_show/summon_show",
												animationName = "yellow_dynamic1",
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
												PositionY = 3,
											},
											ZOrder = "1",
										},
									},
								},
								{
									controlID = "Panel_reward_5_Panel_result_Panel_root_Panel-SimulationSummonResultView_Simulation_summon_Game",
									UUID = "0dbd2c34_9eb5_4ccf_9562_3f4f89370bab",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									bgColorOpacity = "100",
									bIsOpenClipping = "False",
									classname = "MEPanel",
									colorType = "1;SingleColor:#FFFF4500;GraduallyChangingColorStart:#FFFFFFFF;GraduallyChangingColorEnd:#FFFFFFFF;vectorX:0;vectorY:0",
									DesignHeight = "640",
									DesignType = "0",
									DesignWidth = "960",
									dstBlendFunc = "771",
									height = "120",
									ignoreSize = "False",
									name = "Panel_reward_5",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "True",
									UILayoutViewModel = 
									{
										PositionX = -40,
										PositionY = 199,
									},
									uipanelviewmodel = 
									{
										Layout="Absolute",
										nType = "0"
									},
									visible = "False",
									width = "120",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "Spine_effect_Panel_reward_5_Panel_result_Panel_root_Panel-SimulationSummonResultView_Simulation_summon_Game",
											UUID = "80f18f3a_5cc7_4fc5_9955_688d3ff2d720",
											classname = "MESpine",
											dstBlendFunc = "771",
											name = "Spine_effect",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											spineModel = 
											{
												SpinePath = "effect/summon_show/summon_show",
												animationName = "lizixunhuan",
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
												PositionY = 3,
											},
											ZOrder = "1",
										},
										{
											controlID = "Spine_reward_Panel_reward_5_Panel_result_Panel_root_Panel-SimulationSummonResultView_Simulation_summon_Game",
											UUID = "69fda134_ef45_4ac5_b564_5f03ebd72632",
											classname = "MESpine",
											dstBlendFunc = "771",
											name = "Spine_reward",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											spineModel = 
											{
												SpinePath = "effect/summon_show/summon_show",
												animationName = "blue_static2",
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
												PositionY = 3,
											},
											ZOrder = "1",
										},
										{
											controlID = "Spine_saoguang_Panel_reward_5_Panel_result_Panel_root_Panel-SimulationSummonResultView_Simulation_summon_Game",
											UUID = "8e14b89d_41da_4462_a6d5_13419569700a",
											classname = "MESpine",
											dstBlendFunc = "771",
											name = "Spine_saoguang",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											spineModel = 
											{
												SpinePath = "effect/summon_show/summon_show",
												animationName = "yellow_dynamic1",
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
												PositionY = 3,
											},
											ZOrder = "1",
										},
									},
								},
								{
									controlID = "Panel_reward_6_Panel_result_Panel_root_Panel-SimulationSummonResultView_Simulation_summon_Game",
									UUID = "a9932201_8f08_48d0_b7f5_f0c0285f0e3f",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									bgColorOpacity = "100",
									bIsOpenClipping = "False",
									classname = "MEPanel",
									colorType = "1;SingleColor:#FFFF4500;GraduallyChangingColorStart:#FFFFFFFF;GraduallyChangingColorEnd:#FFFFFFFF;vectorX:0;vectorY:0",
									DesignHeight = "640",
									DesignType = "0",
									DesignWidth = "960",
									dstBlendFunc = "771",
									height = "120",
									ignoreSize = "False",
									name = "Panel_reward_6",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "True",
									UILayoutViewModel = 
									{
										PositionX = 13,
										PositionY = 31,
									},
									uipanelviewmodel = 
									{
										Layout="Absolute",
										nType = "0"
									},
									visible = "False",
									width = "120",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "Spine_effect_Panel_reward_6_Panel_result_Panel_root_Panel-SimulationSummonResultView_Simulation_summon_Game",
											UUID = "e544ef9b_dcfe_4559_a9b9_018fbf36fd94",
											classname = "MESpine",
											dstBlendFunc = "771",
											name = "Spine_effect",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											spineModel = 
											{
												SpinePath = "effect/summon_show/summon_show",
												animationName = "lizixunhuan",
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
												PositionY = 3,
											},
											ZOrder = "1",
										},
										{
											controlID = "Spine_reward_Panel_reward_6_Panel_result_Panel_root_Panel-SimulationSummonResultView_Simulation_summon_Game",
											UUID = "89d11cfa_747f_4149_bdd2_9f1ee9a49055",
											classname = "MESpine",
											dstBlendFunc = "771",
											name = "Spine_reward",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											spineModel = 
											{
												SpinePath = "effect/summon_show/summon_show",
												animationName = "blue_static6",
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
												PositionY = 3,
											},
											ZOrder = "1",
										},
										{
											controlID = "Spine_saoguang_Panel_reward_6_Panel_result_Panel_root_Panel-SimulationSummonResultView_Simulation_summon_Game",
											UUID = "fe34d3b5_d022_42d2_bf6b_8db15075884f",
											classname = "MESpine",
											dstBlendFunc = "771",
											name = "Spine_saoguang",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											spineModel = 
											{
												SpinePath = "effect/summon_show/summon_show",
												animationName = "yellow_dynamic1",
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
												PositionY = 3,
											},
											ZOrder = "1",
										},
									},
								},
								{
									controlID = "Panel_reward_7_Panel_result_Panel_root_Panel-SimulationSummonResultView_Simulation_summon_Game",
									UUID = "d1eaadcb_82ec_4d3a_9a55_1fefa8a61c32",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									bgColorOpacity = "100",
									bIsOpenClipping = "False",
									classname = "MEPanel",
									colorType = "1;SingleColor:#FFFF4500;GraduallyChangingColorStart:#FFFFFFFF;GraduallyChangingColorEnd:#FFFFFFFF;vectorX:0;vectorY:0",
									DesignHeight = "640",
									DesignType = "0",
									DesignWidth = "960",
									dstBlendFunc = "771",
									height = "120",
									ignoreSize = "False",
									name = "Panel_reward_7",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "True",
									UILayoutViewModel = 
									{
										PositionX = 191,
										PositionY = 149,
									},
									uipanelviewmodel = 
									{
										Layout="Absolute",
										nType = "0"
									},
									visible = "False",
									width = "120",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "Spine_effect_Panel_reward_7_Panel_result_Panel_root_Panel-SimulationSummonResultView_Simulation_summon_Game",
											UUID = "5db09b94_47d8_47f4_b14a_7230e9ce1b9f",
											classname = "MESpine",
											dstBlendFunc = "771",
											name = "Spine_effect",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											spineModel = 
											{
												SpinePath = "effect/summon_show/summon_show",
												animationName = "lizixunhuan",
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
												PositionY = 3,
											},
											ZOrder = "1",
										},
										{
											controlID = "Spine_reward_Panel_reward_7_Panel_result_Panel_root_Panel-SimulationSummonResultView_Simulation_summon_Game",
											UUID = "f88681d5_3f06_464d_ab4b_aa870780f198",
											classname = "MESpine",
											dstBlendFunc = "771",
											name = "Spine_reward",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											spineModel = 
											{
												SpinePath = "effect/summon_show/summon_show",
												animationName = "blue_static2",
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
												PositionY = 3,
											},
											ZOrder = "1",
										},
										{
											controlID = "Spine_saoguang_Panel_reward_7_Panel_result_Panel_root_Panel-SimulationSummonResultView_Simulation_summon_Game",
											UUID = "2972b182_eeea_4b1a_af06_9663a0df63cf",
											classname = "MESpine",
											dstBlendFunc = "771",
											name = "Spine_saoguang",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											spineModel = 
											{
												SpinePath = "effect/summon_show/summon_show",
												animationName = "yellow_dynamic1",
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
												PositionY = 3,
											},
											ZOrder = "1",
										},
									},
								},
								{
									controlID = "Panel_reward_8_Panel_result_Panel_root_Panel-SimulationSummonResultView_Simulation_summon_Game",
									UUID = "5f3786fa_528a_4b07_9ff8_c0fc1fbc5eab",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									bgColorOpacity = "100",
									bIsOpenClipping = "False",
									classname = "MEPanel",
									colorType = "1;SingleColor:#FFFF4500;GraduallyChangingColorStart:#FFFFFFFF;GraduallyChangingColorEnd:#FFFFFFFF;vectorX:0;vectorY:0",
									DesignHeight = "640",
									DesignType = "0",
									DesignWidth = "960",
									dstBlendFunc = "771",
									height = "120",
									ignoreSize = "False",
									name = "Panel_reward_8",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "True",
									UILayoutViewModel = 
									{
										PositionX = 203,
										PositionY = -53,
									},
									uipanelviewmodel = 
									{
										Layout="Absolute",
										nType = "0"
									},
									visible = "False",
									width = "120",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "Spine_effect_Panel_reward_8_Panel_result_Panel_root_Panel-SimulationSummonResultView_Simulation_summon_Game",
											UUID = "59590321_0c26_45d2_929b_5b18d4895123",
											classname = "MESpine",
											dstBlendFunc = "771",
											name = "Spine_effect",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											spineModel = 
											{
												SpinePath = "effect/summon_show/summon_show",
												animationName = "lizixunhuan",
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
												PositionY = 3,
											},
											ZOrder = "1",
										},
										{
											controlID = "Spine_reward_Panel_reward_8_Panel_result_Panel_root_Panel-SimulationSummonResultView_Simulation_summon_Game",
											UUID = "8e9fbce2_9235_4134_a58c_36a5670cb346",
											classname = "MESpine",
											dstBlendFunc = "771",
											name = "Spine_reward",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											spineModel = 
											{
												SpinePath = "effect/summon_show/summon_show",
												animationName = "blue_static2",
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
												PositionY = 3,
											},
											ZOrder = "1",
										},
										{
											controlID = "Spine_saoguang_Panel_reward_8_Panel_result_Panel_root_Panel-SimulationSummonResultView_Simulation_summon_Game",
											UUID = "0c579b41_973d_484c_bcfb_c6051cccd878",
											classname = "MESpine",
											dstBlendFunc = "771",
											name = "Spine_saoguang",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											spineModel = 
											{
												SpinePath = "effect/summon_show/summon_show",
												animationName = "yellow_dynamic1",
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
												PositionY = 3,
											},
											ZOrder = "1",
										},
									},
								},
								{
									controlID = "Panel_reward_9_Panel_result_Panel_root_Panel-SimulationSummonResultView_Simulation_summon_Game",
									UUID = "a1d6961e_1f2f_408a_9325_85c08e1361c6",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									bgColorOpacity = "100",
									bIsOpenClipping = "False",
									classname = "MEPanel",
									colorType = "1;SingleColor:#FFFF4500;GraduallyChangingColorStart:#FFFFFFFF;GraduallyChangingColorEnd:#FFFFFFFF;vectorX:0;vectorY:0",
									DesignHeight = "640",
									DesignType = "0",
									DesignWidth = "960",
									dstBlendFunc = "771",
									height = "120",
									ignoreSize = "False",
									name = "Panel_reward_9",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "True",
									UILayoutViewModel = 
									{
										PositionX = 392,
										PositionY = 16,
									},
									uipanelviewmodel = 
									{
										Layout="Absolute",
										nType = "0"
									},
									visible = "False",
									width = "120",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "Spine_effect_Panel_reward_9_Panel_result_Panel_root_Panel-SimulationSummonResultView_Simulation_summon_Game",
											UUID = "8c5c9f86_1020_4612_a0f5_87f3fc89da9e",
											classname = "MESpine",
											dstBlendFunc = "771",
											name = "Spine_effect",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											spineModel = 
											{
												SpinePath = "effect/summon_show/summon_show",
												animationName = "lizixunhuan",
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
												PositionY = 3,
											},
											ZOrder = "1",
										},
										{
											controlID = "Spine_reward_Panel_reward_9_Panel_result_Panel_root_Panel-SimulationSummonResultView_Simulation_summon_Game",
											UUID = "fbc2229c_518e_4438_b125_bda7dd812d08",
											classname = "MESpine",
											dstBlendFunc = "771",
											name = "Spine_reward",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											spineModel = 
											{
												SpinePath = "effect/summon_show/summon_show",
												animationName = "blue_static2",
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
												PositionY = 3,
											},
											ZOrder = "1",
										},
										{
											controlID = "Spine_saoguang_Panel_reward_9_Panel_result_Panel_root_Panel-SimulationSummonResultView_Simulation_summon_Game",
											UUID = "d8ec682e_8d26_43bd_9b98_fc948148b844",
											classname = "MESpine",
											dstBlendFunc = "771",
											name = "Spine_saoguang",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											spineModel = 
											{
												SpinePath = "effect/summon_show/summon_show",
												animationName = "yellow_dynamic1",
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
												PositionY = 3,
											},
											ZOrder = "1",
										},
									},
								},
								{
									controlID = "Panel_reward_10_Panel_result_Panel_root_Panel-SimulationSummonResultView_Simulation_summon_Game",
									UUID = "be5b6702_e598_4017_a83e_6f1e6a78274c",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									bgColorOpacity = "100",
									bIsOpenClipping = "False",
									classname = "MEPanel",
									colorType = "1;SingleColor:#FFFF4500;GraduallyChangingColorStart:#FFFFFFFF;GraduallyChangingColorEnd:#FFFFFFFF;vectorX:0;vectorY:0",
									DesignHeight = "640",
									DesignType = "0",
									DesignWidth = "960",
									dstBlendFunc = "771",
									height = "120",
									ignoreSize = "False",
									name = "Panel_reward_10",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "True",
									UILayoutViewModel = 
									{
										PositionX = 438,
										PositionY = 174,
									},
									uipanelviewmodel = 
									{
										Layout="Absolute",
										nType = "0"
									},
									visible = "False",
									width = "120",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "Spine_effect_Panel_reward_10_Panel_result_Panel_root_Panel-SimulationSummonResultView_Simulation_summon_Game",
											UUID = "0731290c_d233_4a29_b600_075d07849c06",
											classname = "MESpine",
											dstBlendFunc = "771",
											name = "Spine_effect",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											spineModel = 
											{
												SpinePath = "effect/summon_show/summon_show",
												animationName = "lizixunhuan",
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
												PositionY = 3,
											},
											ZOrder = "1",
										},
										{
											controlID = "Spine_reward_Panel_reward_10_Panel_result_Panel_root_Panel-SimulationSummonResultView_Simulation_summon_Game",
											UUID = "cc64ee97_209d_43c0_a47b_f28a77aad56b",
											classname = "MESpine",
											dstBlendFunc = "771",
											name = "Spine_reward",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											spineModel = 
											{
												SpinePath = "effect/summon_show/summon_show",
												animationName = "blue_static2",
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
												PositionY = 3,
											},
											ZOrder = "1",
										},
										{
											controlID = "Spine_saoguang_Panel_reward_10_Panel_result_Panel_root_Panel-SimulationSummonResultView_Simulation_summon_Game",
											UUID = "32c3ea20_9e1c_48f3_8995_044d44bdb0ec",
											classname = "MESpine",
											dstBlendFunc = "771",
											name = "Spine_saoguang",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											spineModel = 
											{
												SpinePath = "effect/summon_show/summon_show",
												animationName = "yellow_dynamic1",
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
												PositionY = 3,
											},
											ZOrder = "1",
										},
									},
								},
								{
									controlID = "Panel_pos_1_Panel_result_Panel_root_Panel-SimulationSummonResultView_Simulation_summon_Game",
									UUID = "cbb1c04a_c9a8_4ab7_8c4b_884cd2c9a2ae",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									bgColorOpacity = "150",
									bIsOpenClipping = "False",
									classname = "MEPanel",
									colorType = "1;SingleColor:#FF800000;GraduallyChangingColorStart:#FFFFFFFF;GraduallyChangingColorEnd:#FFFFFFFF;vectorX:0;vectorY:0",
									DesignHeight = "640",
									DesignType = "0",
									DesignWidth = "960",
									dstBlendFunc = "771",
									height = "100",
									ignoreSize = "False",
									name = "Panel_pos_1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = -309,
										PositionY = 122,
									},
									uipanelviewmodel = 
									{
										Layout="Absolute",
										nType = "0"
									},
									visible = "False",
									width = "100",
									ZOrder = "1",
								},
								{
									controlID = "Panel_pos_2_Panel_result_Panel_root_Panel-SimulationSummonResultView_Simulation_summon_Game",
									UUID = "82bff92f_c118_48c5_b359_137f51b36d45",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									bgColorOpacity = "150",
									bIsOpenClipping = "False",
									classname = "MEPanel",
									colorType = "1;SingleColor:#FF800000;GraduallyChangingColorStart:#FFFFFFFF;GraduallyChangingColorEnd:#FFFFFFFF;vectorX:0;vectorY:0",
									DesignHeight = "640",
									DesignType = "0",
									DesignWidth = "960",
									dstBlendFunc = "771",
									height = "100",
									ignoreSize = "False",
									name = "Panel_pos_2",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = -251,
									},
									uipanelviewmodel = 
									{
										Layout="Absolute",
										nType = "0"
									},
									visible = "False",
									width = "100",
									ZOrder = "1",
								},
								{
									controlID = "Panel_pos_3_Panel_result_Panel_root_Panel-SimulationSummonResultView_Simulation_summon_Game",
									UUID = "36fdfac0_013b_4945_8bc7_5a80e9195160",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									bgColorOpacity = "150",
									bIsOpenClipping = "False",
									classname = "MEPanel",
									colorType = "1;SingleColor:#FF800000;GraduallyChangingColorStart:#FFFFFFFF;GraduallyChangingColorEnd:#FFFFFFFF;vectorX:0;vectorY:0",
									DesignHeight = "640",
									DesignType = "0",
									DesignWidth = "960",
									dstBlendFunc = "771",
									height = "100",
									ignoreSize = "False",
									name = "Panel_pos_3",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = -152,
										PositionY = 85,
									},
									uipanelviewmodel = 
									{
										Layout="Absolute",
										nType = "0"
									},
									visible = "False",
									width = "100",
									ZOrder = "1",
								},
								{
									controlID = "Panel_pos_4_Panel_result_Panel_root_Panel-SimulationSummonResultView_Simulation_summon_Game",
									UUID = "9edcf75f_29a4_4f93_8e4f_03ada1f8bc91",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									bgColorOpacity = "150",
									bIsOpenClipping = "False",
									classname = "MEPanel",
									colorType = "1;SingleColor:#FF800000;GraduallyChangingColorStart:#FFFFFFFF;GraduallyChangingColorEnd:#FFFFFFFF;vectorX:0;vectorY:0",
									DesignHeight = "640",
									DesignType = "0",
									DesignWidth = "960",
									dstBlendFunc = "771",
									height = "100",
									ignoreSize = "False",
									name = "Panel_pos_4",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = -117,
										PositionY = -24,
									},
									uipanelviewmodel = 
									{
										Layout="Absolute",
										nType = "0"
									},
									visible = "False",
									width = "100",
									ZOrder = "1",
								},
								{
									controlID = "Panel_pos_5_Panel_result_Panel_root_Panel-SimulationSummonResultView_Simulation_summon_Game",
									UUID = "63882ed3_f901_4bed_9d03_2ab6b00db36b",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									bgColorOpacity = "150",
									bIsOpenClipping = "False",
									classname = "MEPanel",
									colorType = "1;SingleColor:#FF800000;GraduallyChangingColorStart:#FFFFFFFF;GraduallyChangingColorEnd:#FFFFFFFF;vectorX:0;vectorY:0",
									DesignHeight = "640",
									DesignType = "0",
									DesignWidth = "960",
									dstBlendFunc = "771",
									height = "100",
									ignoreSize = "False",
									name = "Panel_pos_5",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = -20,
										PositionY = 147,
										LeftPositon = 1150,
										TopPosition = -547,
										relativeToName = "Panel",
									},
									uipanelviewmodel = 
									{
										Layout="Absolute",
										nType = "0"
									},
									visible = "False",
									width = "100",
									ZOrder = "1",
								},
								{
									controlID = "Panel_pos_6_Panel_result_Panel_root_Panel-SimulationSummonResultView_Simulation_summon_Game",
									UUID = "45d20d82_40af_4026_944b_5810fb2d28b6",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									bgColorOpacity = "150",
									bIsOpenClipping = "False",
									classname = "MEPanel",
									colorType = "1;SingleColor:#FF800000;GraduallyChangingColorStart:#FFFFFFFF;GraduallyChangingColorEnd:#FFFFFFFF;vectorX:0;vectorY:0",
									DesignHeight = "640",
									DesignType = "0",
									DesignWidth = "960",
									dstBlendFunc = "771",
									height = "100",
									ignoreSize = "False",
									name = "Panel_pos_6",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = 14,
										PositionY = 32,
										LeftPositon = 1150,
										TopPosition = -547,
										relativeToName = "Panel",
									},
									uipanelviewmodel = 
									{
										Layout="Absolute",
										nType = "0"
									},
									visible = "False",
									width = "100",
									ZOrder = "1",
								},
								{
									controlID = "Panel_pos_7_Panel_result_Panel_root_Panel-SimulationSummonResultView_Simulation_summon_Game",
									UUID = "6e8e5a4b_72c8_405c_9318_75134026ff4e",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									bgColorOpacity = "150",
									bIsOpenClipping = "False",
									classname = "MEPanel",
									colorType = "1;SingleColor:#FF800000;GraduallyChangingColorStart:#FFFFFFFF;GraduallyChangingColorEnd:#FFFFFFFF;vectorX:0;vectorY:0",
									DesignHeight = "640",
									DesignType = "0",
									DesignWidth = "960",
									dstBlendFunc = "771",
									height = "100",
									ignoreSize = "False",
									name = "Panel_pos_7",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = 133,
										PositionY = 105,
										LeftPositon = 1150,
										TopPosition = -547,
										relativeToName = "Panel",
									},
									uipanelviewmodel = 
									{
										Layout="Absolute",
										nType = "0"
									},
									visible = "False",
									width = "100",
									ZOrder = "1",
								},
								{
									controlID = "Panel_pos_8_Panel_result_Panel_root_Panel-SimulationSummonResultView_Simulation_summon_Game",
									UUID = "69c88e14_69dd_41d4_99d2_2444c80290c9",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									bgColorOpacity = "150",
									bIsOpenClipping = "False",
									classname = "MEPanel",
									colorType = "1;SingleColor:#FF800000;GraduallyChangingColorStart:#FFFFFFFF;GraduallyChangingColorEnd:#FFFFFFFF;vectorX:0;vectorY:0",
									DesignHeight = "640",
									DesignType = "0",
									DesignWidth = "960",
									dstBlendFunc = "771",
									height = "100",
									ignoreSize = "False",
									name = "Panel_pos_8",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = 138,
										PositionY = -7,
										LeftPositon = 1150,
										TopPosition = -547,
										relativeToName = "Panel",
									},
									uipanelviewmodel = 
									{
										Layout="Absolute",
										nType = "0"
									},
									visible = "False",
									width = "100",
									ZOrder = "1",
								},
								{
									controlID = "Panel_pos_9_Panel_result_Panel_root_Panel-SimulationSummonResultView_Simulation_summon_Game",
									UUID = "7693cf4f_e032_4967_ab3f_04f706d641f1",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									bgColorOpacity = "150",
									bIsOpenClipping = "False",
									classname = "MEPanel",
									colorType = "1;SingleColor:#FF800000;GraduallyChangingColorStart:#FFFFFFFF;GraduallyChangingColorEnd:#FFFFFFFF;vectorX:0;vectorY:0",
									DesignHeight = "640",
									DesignType = "0",
									DesignWidth = "960",
									dstBlendFunc = "771",
									height = "100",
									ignoreSize = "False",
									name = "Panel_pos_9",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = 281,
										PositionY = 35,
										LeftPositon = 1150,
										TopPosition = -547,
										relativeToName = "Panel",
									},
									uipanelviewmodel = 
									{
										Layout="Absolute",
										nType = "0"
									},
									visible = "False",
									width = "100",
									ZOrder = "1",
								},
								{
									controlID = "Panel_pos_10_Panel_result_Panel_root_Panel-SimulationSummonResultView_Simulation_summon_Game",
									UUID = "2513f602_d5d4_486b_aafb_6069c3bcbad5",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									bgColorOpacity = "150",
									bIsOpenClipping = "False",
									classname = "MEPanel",
									colorType = "1;SingleColor:#FF800000;GraduallyChangingColorStart:#FFFFFFFF;GraduallyChangingColorEnd:#FFFFFFFF;vectorX:0;vectorY:0",
									DesignHeight = "640",
									DesignType = "0",
									DesignWidth = "960",
									dstBlendFunc = "771",
									height = "100",
									ignoreSize = "False",
									name = "Panel_pos_10",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = 323,
										PositionY = 145,
										LeftPositon = 1150,
										TopPosition = -547,
										relativeToName = "Panel",
									},
									uipanelviewmodel = 
									{
										Layout="Absolute",
										nType = "0"
									},
									visible = "False",
									width = "100",
									ZOrder = "1",
								},
								{
									controlID = "Button_open_Panel_result_Panel_root_Panel-SimulationSummonResultView_Simulation_summon_Game",
									UUID = "75a40c56_ec98_4257_a745_fd4e1fdbfa93",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEButton",
									ClickHighLightEnabled = "True",
									dstBlendFunc = "771",
									flipX = "False",
									flipY = "False",
									height = "97",
									ignoreSize = "True",
									name = "Button_open",
									normal = "ui/summon/power/button.png",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "True",
									UILayoutViewModel = 
									{
										PositionX = 453,
										PositionY = -254,
									},
									UItype = "Button",
									width = "178",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "Label_open_Button_open_Panel_result_Panel_root_Panel-SimulationSummonResultView_Simulation_summon_Game",
											UUID = "46d3d576_b64c_4da4_9eda_769431dcc853",
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
											fontSize = "26",
											fontStroke = 
											{
												IsStroke = true,
												StrokeColor = "#FF901034",
												StrokeSize = 1,
											},
											height = "34",
											ignoreSize = "True",
											name = "Label_open",
											nTextAlign = "1",
											nTextHAlign = "1",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "770",
											text = "Ouverture rapide",
											touchAble = "False",
											touchScaleEnable = "False",
											UILayoutViewModel = 
											{
												PositionX = -8,
												PositionY = -3,
											},
											width = "107",
											ZOrder = "1",
										},
									},
								},
								{
									controlID = "Panel_mask_all_Panel_result_Panel_root_Panel-SimulationSummonResultView_Simulation_summon_Game",
									UUID = "be3f2a0f_ec86_476f_98e0_477bde47e806",
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
									name = "Panel_mask_all",
									sizepercentx = "100",
									sizepercenty = "100",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "True",
									UILayoutViewModel = 
									{
										relativeToName = "Panel",
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
									controlID = "Panel_mask_single_Panel_result_Panel_root_Panel-SimulationSummonResultView_Simulation_summon_Game",
									UUID = "1504a406_3a35_4d9e_9fb3_5e033ac9ee8e",
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
									name = "Panel_mask_single",
									sizepercentx = "100",
									sizepercenty = "100",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "True",
									UILayoutViewModel = 
									{
										relativeToName = "Panel",
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
									controlID = "Spine_result_effect_Panel_result_Panel_root_Panel-SimulationSummonResultView_Simulation_summon_Game",
									UUID = "172fb967_84dc_4ca8_912e_9d2fc59b4db6",
									classname = "MESpine",
									dstBlendFunc = "771",
									name = "Spine_result_effect",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									spineModel = 
									{
										SpinePath = "effect/angel_texiao_top/angel_texiao_top",
										animationName = "white",
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
										relativeToName = "Panel",
									},
									visible = "False",
									ZOrder = "1",
								},
								{
									controlID = "Button_giveup_Panel_result_Panel_root_Panel-SimulationSummonResultView_Simulation_summon_Game",
									UUID = "29767e26_5c32_4366_b518_0f7edbecd1e5",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEButton",
									ClickHighLightEnabled = "True",
									disabled = "ui/common/button_big_blue_n.png",
									dstBlendFunc = "771",
									flipX = "False",
									flipY = "False",
									height = "58",
									ignoreSize = "True",
									name = "Button_giveup",
									normal = "ui/common/button_big_blue_n.png",
									pressed = "ui/common/button_big_blue_n.png",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "True",
									UILayoutViewModel = 
									{
										PositionX = -197,
										PositionY = -257,
									},
									UItype = "Button",
									width = "134",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "Label_SimulationSummonExchangeView_1_Button_giveup_Panel_result_Panel_root_Panel-SimulationSummonResultView_Simulation_summon_Game",
											UUID = "2cc2dd3e_06ac_4f92_ad7d_adf91b8d3441",
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
											name = "Label_SimulationSummonExchangeView_1",
											nTextAlign = "1",
											nTextHAlign = "1",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "770",
											text = "Abandonner",
											touchAble = "False",
											touchScaleEnable = "False",
											UILayoutViewModel = 
											{
												
											},
											width = "63",
											ZOrder = "1",
										},
									},
								},
								{
									controlID = "Button_replace_Panel_result_Panel_root_Panel-SimulationSummonResultView_Simulation_summon_Game",
									UUID = "35415f56_aab5_4e38_94f7_7961fff1db54",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEButton",
									ClickHighLightEnabled = "True",
									disabled = "ui/common/button_big_n.png",
									dstBlendFunc = "771",
									flipX = "False",
									flipY = "False",
									height = "58",
									ignoreSize = "True",
									name = "Button_replace",
									normal = "ui/common/button_big_n.png",
									pressed = "ui/common/button_big_n.png",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "True",
									UILayoutViewModel = 
									{
										PositionX = 176,
										PositionY = -257,
									},
									UItype = "Button",
									width = "134",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "Label_SimulationSummonExchangeView_1_Button_replace_Panel_result_Panel_root_Panel-SimulationSummonResultView_Simulation_summon_Game",
											UUID = "bc2e8972_d764_4bba_8fa7_870b2069709f",
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
											name = "Label_SimulationSummonExchangeView_1",
											nTextAlign = "1",
											nTextHAlign = "1",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "770",
											text = "Remplacer",
											touchAble = "False",
											touchScaleEnable = "False",
											UILayoutViewModel = 
											{
												
											},
											width = "63",
											ZOrder = "1",
										},
									},
								},
								{
									controlID = "Button_ok_Panel_result_Panel_root_Panel-SimulationSummonResultView_Simulation_summon_Game",
									UUID = "2d229d84_3b19_45d5_8caf_2d635e9e420c",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEButton",
									ClickHighLightEnabled = "True",
									disabled = "ui/common/button_big_n.png",
									dstBlendFunc = "771",
									flipX = "False",
									flipY = "False",
									height = "58",
									ignoreSize = "True",
									name = "Button_ok",
									normal = "ui/common/button_big_n.png",
									pressed = "ui/common/button_big_n.png",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "True",
									UILayoutViewModel = 
									{
										PositionX = 4,
										PositionY = -257,
									},
									UItype = "Button",
									width = "134",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "Label_SimulationSummonExchangeView_1_Button_ok_Panel_result_Panel_root_Panel-SimulationSummonResultView_Simulation_summon_Game",
											UUID = "c4283327_c009_4ef5_8002_fb4d59facf51",
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
											name = "Label_SimulationSummonExchangeView_1",
											nTextAlign = "1",
											nTextHAlign = "1",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "770",
											text = "Enregistrer",
											touchAble = "False",
											touchScaleEnable = "False",
											UILayoutViewModel = 
											{
												
											},
											width = "63",
											ZOrder = "1",
										},
									},
								},
							},
						},
						{
							controlID = "Panel_effect_Panel_root_Panel-SimulationSummonResultView_Simulation_summon_Game",
							UUID = "4f076a9c_232f_4199_891e_e4933c3ef3ed",
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
							name = "Panel_effect",
							sizepercentx = "100",
							sizepercenty = "100",
							sizeType = "1",
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
									controlID = "Spine_texiao_bg_Panel_effect_Panel_root_Panel-SimulationSummonResultView_Simulation_summon_Game",
									UUID = "c5b524a5_8a50_4916_9a86_acbc483c4c56",
									classname = "MESpine",
									dstBlendFunc = "771",
									name = "Spine_texiao_bg",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									spineModel = 
									{
										SpinePath = "effect/angel_texiao_bg/angel_texiao_bg",
										animationName = "shouwei",
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
										PositionX = -15,
										relativeToName = "Panel",
									},
									ZOrder = "1",
								},
								{
									controlID = "Spine_dongzuo_Panel_effect_Panel_root_Panel-SimulationSummonResultView_Simulation_summon_Game",
									UUID = "ea60417e_7a9a_4b0f_9a17_1a44939a44bd",
									classname = "MESpine",
									dstBlendFunc = "771",
									name = "Spine_dongzuo",
									scaleX = "0.95",
									scaleY = "0.95",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									spineModel = 
									{
										SpinePath = "effect/angel_dongzuo/angel_dongzuo",
										animationName = "chuxian",
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
									controlID = "Spine_texiao_top_Panel_effect_Panel_root_Panel-SimulationSummonResultView_Simulation_summon_Game",
									UUID = "b16c6d0e_7934_4823_b825_393c959547b0",
									classname = "MESpine",
									dstBlendFunc = "771",
									name = "Spine_texiao_top",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									spineModel = 
									{
										SpinePath = "effect/angel_texiao_top/angel_texiao_top",
										animationName = "xunhuan",
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
										relativeToName = "Panel",
									},
									ZOrder = "1",
								},
								{
									controlID = "Button_power_Panel_effect_Panel_root_Panel-SimulationSummonResultView_Simulation_summon_Game",
									UUID = "931b8e6c_f620_41d3_963b_c18f983fcac3",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEButton",
									ClickHighLightEnabled = "True",
									dstBlendFunc = "771",
									flipX = "False",
									flipY = "False",
									height = "137",
									ignoreSize = "True",
									name = "Button_power",
									normal = "ui/summon/power/c1.png",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "True",
									UILayoutViewModel = 
									{
										PositionX = 479,
										PositionY = -198,
									},
									UItype = "Button",
									width = "137",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "Spine_summonResultView_1_Button_power_Panel_effect_Panel_root_Panel-SimulationSummonResultView_Simulation_summon_Game",
											UUID = "16c9a1d6_a7d7_4f4f_b7ce_acc2652e0978",
											classname = "MESpine",
											dstBlendFunc = "771",
											name = "Spine_summonResultView_1",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											spineModel = 
											{
												SpinePath = "effect/button/button",
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
									},
								},
								{
									controlID = "Panel_power_Panel_effect_Panel_root_Panel-SimulationSummonResultView_Simulation_summon_Game",
									UUID = "6e674eaf_cb29_4680_b4d4_f1a734e95561",
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
									height = "60",
									ignoreSize = "False",
									name = "Panel_power",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = -4,
										PositionY = -268,
									},
									uipanelviewmodel = 
									{
										Layout="Absolute",
										nType = "0"
									},
									width = "420",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "Spine_power_bottom_Panel_power_Panel_effect_Panel_root_Panel-SimulationSummonResultView_Simulation_summon_Game",
											UUID = "0705bc55_4cd5_4da1_8b2d_1f520e886c12",
											classname = "MESpine",
											dstBlendFunc = "771",
											name = "Spine_power_bottom",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											spineModel = 
											{
												SpinePath = "effect/summon_jindutiao/summon_jindutiao",
												animationName = "xunhuan",
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
												PositionX = 4,
												PositionY = -6,
											},
											ZOrder = "1",
										},
										{
											controlID = "Image_power_Panel_power_Panel_effect_Panel_root_Panel-SimulationSummonResultView_Simulation_summon_Game",
											UUID = "7b10cece_5eda_44d8_bbc5_ddf4019ffd6e",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											classname = "MEImage",
											dstBlendFunc = "771",
											height = "48",
											ignoreSize = "True",
											name = "Image_power",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											texturePath = "ui/summon/power/m11.png",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 4,
												PositionY = -6,
											},
											width = "411",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "Image_tag_select_Image_power_Panel_power_Panel_effect_Panel_root_Panel-SimulationSummonResultView_Simulation_summon_Game",
													UUID = "420d9553_679e_43d3_8c7e_b882ccf32418",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0.5",
													backGroundScale9Enable = "False",
													classname = "MEImage",
													dstBlendFunc = "771",
													height = "133",
													ignoreSize = "True",
													name = "Image_tag_select",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "1",
													texturePath = "ui/summon/power/c2.png",
													touchAble = "False",
													UILayoutViewModel = 
													{
														PositionX = 20,
														PositionY = 20,
													},
													width = "63",
													ZOrder = "1",
												},
												{
													controlID = "Image_tag_1_Image_power_Panel_power_Panel_effect_Panel_root_Panel-SimulationSummonResultView_Simulation_summon_Game",
													UUID = "78229049_556b_4341_830e_e3fdf3bc2ba1",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0.5",
													backGroundScale9Enable = "False",
													classname = "MEImage",
													dstBlendFunc = "771",
													height = "42",
													ignoreSize = "True",
													name = "Image_tag_1",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "1",
													texturePath = "ui/summon/power/m1.png",
													touchAble = "False",
													UILayoutViewModel = 
													{
														PositionX = -160,
														PositionY = 2,
													},
													width = "36",
													ZOrder = "1",
												},
												{
													controlID = "Image_tag_2_Image_power_Panel_power_Panel_effect_Panel_root_Panel-SimulationSummonResultView_Simulation_summon_Game",
													UUID = "a158e2df_7df0_4b77_ba53_6b7b358f1299",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0.5",
													backGroundScale9Enable = "False",
													classname = "MEImage",
													dstBlendFunc = "771",
													height = "42",
													ignoreSize = "True",
													name = "Image_tag_2",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "1",
													texturePath = "ui/summon/power/m2.png",
													touchAble = "False",
													UILayoutViewModel = 
													{
														PositionX = -125,
														PositionY = 2,
													},
													width = "36",
													ZOrder = "1",
												},
												{
													controlID = "Image_tag_3_Image_power_Panel_power_Panel_effect_Panel_root_Panel-SimulationSummonResultView_Simulation_summon_Game",
													UUID = "f29d31b5_bc57_4091_84a3_e1a45e50cefd",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0.5",
													backGroundScale9Enable = "False",
													classname = "MEImage",
													dstBlendFunc = "771",
													height = "42",
													ignoreSize = "True",
													name = "Image_tag_3",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "1",
													texturePath = "ui/summon/power/m3.png",
													touchAble = "False",
													UILayoutViewModel = 
													{
														PositionX = -90,
														PositionY = 2,
													},
													width = "36",
													ZOrder = "1",
												},
												{
													controlID = "Image_tag_4_Image_power_Panel_power_Panel_effect_Panel_root_Panel-SimulationSummonResultView_Simulation_summon_Game",
													UUID = "79261729_c3aa_4d54_a9d2_7d4232e2d355",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0.5",
													backGroundScale9Enable = "False",
													classname = "MEImage",
													dstBlendFunc = "771",
													height = "42",
													ignoreSize = "True",
													name = "Image_tag_4",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "1",
													texturePath = "ui/summon/power/m4.png",
													touchAble = "False",
													UILayoutViewModel = 
													{
														PositionX = -55,
														PositionY = 2,
													},
													width = "36",
													ZOrder = "1",
												},
												{
													controlID = "Image_tag_5_Image_power_Panel_power_Panel_effect_Panel_root_Panel-SimulationSummonResultView_Simulation_summon_Game",
													UUID = "a8d80586_9dd3_4b86_8c5b_e68bf69a4c9e",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0.5",
													backGroundScale9Enable = "False",
													classname = "MEImage",
													dstBlendFunc = "771",
													height = "42",
													ignoreSize = "True",
													name = "Image_tag_5",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "1",
													texturePath = "ui/summon/power/m5.png",
													touchAble = "False",
													UILayoutViewModel = 
													{
														PositionX = -20,
														PositionY = 2,
													},
													width = "36",
													ZOrder = "1",
												},
												{
													controlID = "Image_tag_6_Image_power_Panel_power_Panel_effect_Panel_root_Panel-SimulationSummonResultView_Simulation_summon_Game",
													UUID = "72c843b5_2f49_4176_b7f7_eb3cd487af1b",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0.5",
													backGroundScale9Enable = "False",
													classname = "MEImage",
													dstBlendFunc = "771",
													height = "42",
													ignoreSize = "True",
													name = "Image_tag_6",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "1",
													texturePath = "ui/summon/power/m6.png",
													touchAble = "False",
													UILayoutViewModel = 
													{
														PositionX = 15,
														PositionY = 2,
													},
													width = "36",
													ZOrder = "1",
												},
												{
													controlID = "Image_tag_7_Image_power_Panel_power_Panel_effect_Panel_root_Panel-SimulationSummonResultView_Simulation_summon_Game",
													UUID = "f85e61c1_cfd6_4105_a8d4_80544f7e0e38",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0.5",
													backGroundScale9Enable = "False",
													classname = "MEImage",
													dstBlendFunc = "771",
													height = "42",
													ignoreSize = "True",
													name = "Image_tag_7",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "1",
													texturePath = "ui/summon/power/m7.png",
													touchAble = "False",
													UILayoutViewModel = 
													{
														PositionX = 50,
														PositionY = 2,
													},
													width = "36",
													ZOrder = "1",
												},
												{
													controlID = "Image_tag_8_Image_power_Panel_power_Panel_effect_Panel_root_Panel-SimulationSummonResultView_Simulation_summon_Game",
													UUID = "d1401b68_3851_4b75_ae81_9e38d6fe69d4",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0.5",
													backGroundScale9Enable = "False",
													classname = "MEImage",
													dstBlendFunc = "771",
													height = "42",
													ignoreSize = "True",
													name = "Image_tag_8",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "1",
													texturePath = "ui/summon/power/m8.png",
													touchAble = "False",
													UILayoutViewModel = 
													{
														PositionX = 85,
														PositionY = 2,
													},
													width = "36",
													ZOrder = "1",
												},
												{
													controlID = "Image_tag_9_Image_power_Panel_power_Panel_effect_Panel_root_Panel-SimulationSummonResultView_Simulation_summon_Game",
													UUID = "7e90c434_0354_4f79_897a_7af86f7dceb3",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0.5",
													backGroundScale9Enable = "False",
													classname = "MEImage",
													dstBlendFunc = "771",
													height = "42",
													ignoreSize = "True",
													name = "Image_tag_9",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "1",
													texturePath = "ui/summon/power/m9.png",
													touchAble = "False",
													UILayoutViewModel = 
													{
														PositionX = 120,
														PositionY = 2,
													},
													width = "36",
													ZOrder = "1",
												},
												{
													controlID = "Image_tag_10_Image_power_Panel_power_Panel_effect_Panel_root_Panel-SimulationSummonResultView_Simulation_summon_Game",
													UUID = "f1aeee93_2f57_4c01_a202_eb0f8436013b",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0.5",
													backGroundScale9Enable = "False",
													classname = "MEImage",
													dstBlendFunc = "771",
													height = "42",
													ignoreSize = "True",
													name = "Image_tag_10",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "1",
													texturePath = "ui/summon/power/m10.png",
													touchAble = "False",
													UILayoutViewModel = 
													{
														PositionX = 155,
														PositionY = 2,
													},
													width = "36",
													ZOrder = "1",
												},
											},
										},
										{
											controlID = "Label_tips_Panel_power_Panel_effect_Panel_root_Panel-SimulationSummonResultView_Simulation_summon_Game",
											UUID = "575eabda_9390_411b_8a82_d035699a15fd",
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
											fontSize = "16",
											fontStroke = 
											{
												IsStroke = false,
												StrokeColor = "#FFE6E6E6",
												StrokeSize = 1,
											},
											height = "18",
											ignoreSize = "True",
											name = "Label_tips",
											nTextAlign = "1",
											nTextHAlign = "1",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "770",
											text = "Appuyez longuement pour injecter de l’énergie",
											touchAble = "False",
											touchScaleEnable = "False",
											UILayoutViewModel = 
											{
												PositionX = 539,
												PositionY = -27,
											},
											width = "99",
											ZOrder = "1",
										},
										{
											controlID = "Spine_power_top_Panel_power_Panel_effect_Panel_root_Panel-SimulationSummonResultView_Simulation_summon_Game",
											UUID = "56ef9733_d548_467f_b7b0_e9b423c64b1f",
											classname = "MESpine",
											dstBlendFunc = "771",
											name = "Spine_power_top",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											spineModel = 
											{
												SpinePath = "effect/summon_jindutiao/summon_jindutiao",
												animationName = "chuxian",
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
												PositionX = 9,
											},
											visible = "False",
											ZOrder = "1",
										},
									},
								},
							},
						},
					},
				},
				{
					controlID = "Panel_prefab_Panel-SimulationSummonResultView_Simulation_summon_Game",
					UUID = "14656a91_cb1f_4b90_8a5c_ded2bfb34e1b",
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
						PositionX = 1347,
						PositionY = -919,
						LeftPositon = 1347,
						TopPosition = 919,
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
							controlID = "Panel_resultItem_Panel_prefab_Panel-SimulationSummonResultView_Simulation_summon_Game",
							UUID = "eeebf669_ff2f_4b46_96d2_120c06e90e7a",
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
							height = "120",
							ignoreSize = "False",
							name = "Panel_resultItem",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							touchAble = "False",
							UILayoutViewModel = 
							{
								PositionX = 269,
								PositionY = 326,
							},
							uipanelviewmodel = 
							{
								Layout="Absolute",
								nType = "0"
							},
							width = "120",
							ZOrder = "1",
							components = 
							{
								
								{
									controlID = "Spine_down_Panel_resultItem_Panel_prefab_Panel-SimulationSummonResultView_Simulation_summon_Game",
									UUID = "396be6ec_2645_444d_a4e4_b6fc2e6b874b",
									classname = "MESpine",
									dstBlendFunc = "771",
									name = "Spine_down",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									spineModel = 
									{
										SpinePath = "effect/effect_ui_item/effect_ui_item",
										animationName = "effect_ui_item2_down",
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
								},
								{
									controlID = "Spine_up_Panel_resultItem_Panel_prefab_Panel-SimulationSummonResultView_Simulation_summon_Game",
									UUID = "5bffc4cb_4e94_4fbd_ac38_72c8fa42d614",
									classname = "MESpine",
									dstBlendFunc = "771",
									name = "Spine_up",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									spineModel = 
									{
										SpinePath = "effect/effect_ui_item/effect_ui_item",
										animationName = "effect_ui_item2_down",
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
									ZOrder = "2",
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
			"ui/summon/bg_result.png",
			"ui/summon/power/button.png",
			"ui/common/button_big_blue_n.png",
			"ui/common/button_big_n.png",
			"ui/summon/power/c1.png",
			"ui/summon/power/m11.png",
			"ui/summon/power/c2.png",
			"ui/summon/power/m1.png",
			"ui/summon/power/m2.png",
			"ui/summon/power/m3.png",
			"ui/summon/power/m4.png",
			"ui/summon/power/m5.png",
			"ui/summon/power/m6.png",
			"ui/summon/power/m7.png",
			"ui/summon/power/m8.png",
			"ui/summon/power/m9.png",
			"ui/summon/power/m10.png",
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

