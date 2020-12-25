local t = 
{
	version = 1,
	components = 
	{
		
		{
			controlID = "Panel-summonResultView_Layer1_summon_Game",
			UUID = "a54597bc_9d36_4282_9432_6029248859fd",
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
					controlID = "Panel_root_Panel-summonResultView_Layer1_summon_Game",
					UUID = "7e304313_2e60_4f00_a015_435513c12fec",
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
							controlID = "Panel_result_Panel_root_Panel-summonResultView_Layer1_summon_Game",
							UUID = "4dcf3c82_9608_4460_9b6e_ee9899e62240",
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
									controlID = "Image_bg_Panel_result_Panel_root_Panel-summonResultView_Layer1_summon_Game",
									UUID = "505db851_37a3_47dd_8572_d39d03e7ae61",
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
									controlID = "Spine_bgfoo_Panel_result_Panel_root_Panel-summonResultView_Layer1_summon_Game",
									UUID = "e1e2041e_e036_4f00_9fac_3344930d9378",
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
									controlID = "Spine_bg_Panel_result_Panel_root_Panel-summonResultView_Layer1_summon_Game",
									UUID = "fee16463_a8da_4bde_b530_446119f749e2",
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
									controlID = "ScrollView_result_Panel_result_Panel_root_Panel-summonResultView_Layer1_summon_Game",
									UUID = "15866526_8315_4ac5_ab81_65dbb5370705",
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
									controlID = "Panel_normalGoods_Panel_result_Panel_root_Panel-summonResultView_Layer1_summon_Game",
									UUID = "82c405e3_1ce5_407a_ad78_9f0fa556fe9a",
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
											controlID = "Panel_showItem_Panel_normalGoods_Panel_result_Panel_root_Panel-summonResultView_Layer1_summon_Game",
											UUID = "c80a26be_4de1_4b70_8bc0_8ad71fc4b222",
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
									controlID = "Label_continue_Panel_result_Panel_root_Panel-summonResultView_Layer1_summon_Game",
									UUID = "02d9e58e_cb19_48c4_a547_0dcaa955b80d",
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
									text = "คลิกเพื่อดำเนินการต่อ",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionY = -244,
										LeftPositon = 509,
										TopPosition = 543,
										relativeToName = "Panel_root",
									},
									width = "200",
									ZOrder = "1",
								},
								{
									controlID = "Panel_touch_Panel_result_Panel_root_Panel-summonResultView_Layer1_summon_Game",
									UUID = "77700364_f9ad_487f_88c0_3615714a6095",
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
									controlID = "Panel_reward_1_Panel_result_Panel_root_Panel-summonResultView_Layer1_summon_Game",
									UUID = "260b06d3_f4db_4cf7_93de_6ad11aec9602",
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
											controlID = "Spine_effect_Panel_reward_1_Panel_result_Panel_root_Panel-summonResultView_Layer1_summon_Game",
											UUID = "f0ac0f14_c1e7_4fb4_a985_43f932177b0f",
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
											controlID = "Spine_reward_Panel_reward_1_Panel_result_Panel_root_Panel-summonResultView_Layer1_summon_Game",
											UUID = "ef09d9b7_3d99_49a5_9908_3c256598d6e9",
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
											controlID = "Spine_saoguang_Panel_reward_1_Panel_result_Panel_root_Panel-summonResultView_Layer1_summon_Game",
											UUID = "76266526_da2c_4a14_a36e_175d1991c099",
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
									controlID = "Panel_reward_2_Panel_result_Panel_root_Panel-summonResultView_Layer1_summon_Game",
									UUID = "40f4129d_88da_4848_b248_629a0ff139d7",
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
											controlID = "Spine_effect_Panel_reward_2_Panel_result_Panel_root_Panel-summonResultView_Layer1_summon_Game",
											UUID = "7ec9e913_8373_4968_8055_7e7cf7a9b8d1",
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
											controlID = "Spine_reward_Panel_reward_2_Panel_result_Panel_root_Panel-summonResultView_Layer1_summon_Game",
											UUID = "8d6854df_a86a_4ec6_bc77_b08a61c2df7f",
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
											controlID = "Spine_saoguang_Panel_reward_2_Panel_result_Panel_root_Panel-summonResultView_Layer1_summon_Game",
											UUID = "a23b6970_5d24_40bd_834f_f8314de83e1b",
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
									controlID = "Panel_reward_3_Panel_result_Panel_root_Panel-summonResultView_Layer1_summon_Game",
									UUID = "d1eeb57c_46b0_4056_aef8_9d94c7f106b5",
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
											controlID = "Spine_effect_Panel_reward_3_Panel_result_Panel_root_Panel-summonResultView_Layer1_summon_Game",
											UUID = "835a451e_5eb1_423b_a6d3_13e129807ac5",
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
											controlID = "Spine_reward_Panel_reward_3_Panel_result_Panel_root_Panel-summonResultView_Layer1_summon_Game",
											UUID = "add3d4d9_d544_424a_b93b_0b7f06a1a536",
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
											controlID = "Spine_saoguang_Panel_reward_3_Panel_result_Panel_root_Panel-summonResultView_Layer1_summon_Game",
											UUID = "b0a7361b_4b20_412b_afc9_eac1a3ce9330",
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
									controlID = "Panel_reward_4_Panel_result_Panel_root_Panel-summonResultView_Layer1_summon_Game",
									UUID = "be9829d6_4039_4213_b539_232c8f352841",
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
											controlID = "Spine_effect_Panel_reward_4_Panel_result_Panel_root_Panel-summonResultView_Layer1_summon_Game",
											UUID = "ba447d57_c396_4fbc_8232_43848be6ec1b",
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
											controlID = "Spine_reward_Panel_reward_4_Panel_result_Panel_root_Panel-summonResultView_Layer1_summon_Game",
											UUID = "629f7181_4413_41ed_9a7f_90b447ac4b85",
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
											controlID = "Spine_saoguang_Panel_reward_4_Panel_result_Panel_root_Panel-summonResultView_Layer1_summon_Game",
											UUID = "8fb03e20_1709_468a_b09e_f16638a55236",
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
									controlID = "Panel_reward_5_Panel_result_Panel_root_Panel-summonResultView_Layer1_summon_Game",
									UUID = "a0ade6ed_5e33_4ccf_aa83_9f857a589851",
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
											controlID = "Spine_effect_Panel_reward_5_Panel_result_Panel_root_Panel-summonResultView_Layer1_summon_Game",
											UUID = "28783987_22cc_4480_b9ae_cfd1b6cc8b9a",
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
											controlID = "Spine_reward_Panel_reward_5_Panel_result_Panel_root_Panel-summonResultView_Layer1_summon_Game",
											UUID = "7b1c6cba_c6ad_4b1a_9632_632e53a14f98",
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
											controlID = "Spine_saoguang_Panel_reward_5_Panel_result_Panel_root_Panel-summonResultView_Layer1_summon_Game",
											UUID = "c4404da9_fb57_44dd_a09d_55dfa2ce5a97",
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
									controlID = "Panel_reward_6_Panel_result_Panel_root_Panel-summonResultView_Layer1_summon_Game",
									UUID = "0e911601_b24d_46ea_a724_b9243d87786d",
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
											controlID = "Spine_effect_Panel_reward_6_Panel_result_Panel_root_Panel-summonResultView_Layer1_summon_Game",
											UUID = "e1bef9d5_789b_4a70_b0bc_834caa6c4240",
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
											controlID = "Spine_reward_Panel_reward_6_Panel_result_Panel_root_Panel-summonResultView_Layer1_summon_Game",
											UUID = "ba915e01_108d_474a_9d42_5dcc7b722237",
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
											controlID = "Spine_saoguang_Panel_reward_6_Panel_result_Panel_root_Panel-summonResultView_Layer1_summon_Game",
											UUID = "efef07fa_27c3_4d18_be91_e49285d7c38f",
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
									controlID = "Panel_reward_7_Panel_result_Panel_root_Panel-summonResultView_Layer1_summon_Game",
									UUID = "d64e8feb_910b_49fd_a3d4_1137d1cbdda3",
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
											controlID = "Spine_effect_Panel_reward_7_Panel_result_Panel_root_Panel-summonResultView_Layer1_summon_Game",
											UUID = "5f748454_f81c_440d_a60a_08b8b27d2d43",
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
											controlID = "Spine_reward_Panel_reward_7_Panel_result_Panel_root_Panel-summonResultView_Layer1_summon_Game",
											UUID = "431ccfab_ca38_4696_97bc_560d872d956a",
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
											controlID = "Spine_saoguang_Panel_reward_7_Panel_result_Panel_root_Panel-summonResultView_Layer1_summon_Game",
											UUID = "0b214b0d_ff13_4c7c_80c7_564b2bec92a3",
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
									controlID = "Panel_reward_8_Panel_result_Panel_root_Panel-summonResultView_Layer1_summon_Game",
									UUID = "46e1e4b9_0087_462e_9bfa_9c281d619147",
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
											controlID = "Spine_effect_Panel_reward_8_Panel_result_Panel_root_Panel-summonResultView_Layer1_summon_Game",
											UUID = "e66cc2a0_6dc2_479c_aceb_df02af338ad5",
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
											controlID = "Spine_reward_Panel_reward_8_Panel_result_Panel_root_Panel-summonResultView_Layer1_summon_Game",
											UUID = "86a3df70_84ae_4266_9995_a05b2512c3d2",
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
											controlID = "Spine_saoguang_Panel_reward_8_Panel_result_Panel_root_Panel-summonResultView_Layer1_summon_Game",
											UUID = "212a6d04_a889_4012_89bc_d8683c7fc8b0",
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
									controlID = "Panel_reward_9_Panel_result_Panel_root_Panel-summonResultView_Layer1_summon_Game",
									UUID = "3a7897d4_6275_451d_bf7b_1983313080bb",
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
											controlID = "Spine_effect_Panel_reward_9_Panel_result_Panel_root_Panel-summonResultView_Layer1_summon_Game",
											UUID = "ac25577b_cb3e_42ae_a76a_e8fc9a1caeb5",
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
											controlID = "Spine_reward_Panel_reward_9_Panel_result_Panel_root_Panel-summonResultView_Layer1_summon_Game",
											UUID = "606f6c03_4b28_47fe_967e_2e97c86d394c",
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
											controlID = "Spine_saoguang_Panel_reward_9_Panel_result_Panel_root_Panel-summonResultView_Layer1_summon_Game",
											UUID = "0fd0b708_7281_451e_83e2_67c425a83bee",
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
									controlID = "Panel_reward_10_Panel_result_Panel_root_Panel-summonResultView_Layer1_summon_Game",
									UUID = "6d860456_ca4d_4ec5_a249_a768e03f1321",
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
											controlID = "Spine_effect_Panel_reward_10_Panel_result_Panel_root_Panel-summonResultView_Layer1_summon_Game",
											UUID = "0e79e92a_d50d_417e_b156_547462c99e41",
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
											controlID = "Spine_reward_Panel_reward_10_Panel_result_Panel_root_Panel-summonResultView_Layer1_summon_Game",
											UUID = "ee91d8b9_6cad_4dfe_ba1d_06e21f76855a",
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
											controlID = "Spine_saoguang_Panel_reward_10_Panel_result_Panel_root_Panel-summonResultView_Layer1_summon_Game",
											UUID = "0869d70b_5225_411a_a629_de9229d294dc",
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
									controlID = "Panel_pos_1_Panel_result_Panel_root_Panel-summonResultView_Layer1_summon_Game",
									UUID = "404d7493_c797_45a6_b072_49c92ee9dcd3",
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
									controlID = "Panel_pos_2_Panel_result_Panel_root_Panel-summonResultView_Layer1_summon_Game",
									UUID = "b25202ff_3da6_4f35_9e97_a7470b8263ba",
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
									controlID = "Panel_pos_3_Panel_result_Panel_root_Panel-summonResultView_Layer1_summon_Game",
									UUID = "9c3c0d7e_b593_4f45_9249_2fe4e0338e08",
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
									controlID = "Panel_pos_4_Panel_result_Panel_root_Panel-summonResultView_Layer1_summon_Game",
									UUID = "ebe63759_52b7_45dd_b065_7a96f42bea33",
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
									controlID = "Panel_pos_5_Panel_result_Panel_root_Panel-summonResultView_Layer1_summon_Game",
									UUID = "adf9ca15_78fc_4035_ae0e_73da73bf3fa2",
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
									controlID = "Panel_pos_6_Panel_result_Panel_root_Panel-summonResultView_Layer1_summon_Game",
									UUID = "873b9d3a_2015_4c21_b342_a14ebd62a135",
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
									controlID = "Panel_pos_7_Panel_result_Panel_root_Panel-summonResultView_Layer1_summon_Game",
									UUID = "443f4159_f991_4775_931b_21ea1aa48b65",
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
									controlID = "Panel_pos_8_Panel_result_Panel_root_Panel-summonResultView_Layer1_summon_Game",
									UUID = "7543ccdb_67f0_43f9_98bc_5c4a3768a0a6",
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
									controlID = "Panel_pos_9_Panel_result_Panel_root_Panel-summonResultView_Layer1_summon_Game",
									UUID = "34e4cb90_96af_4802_acdc_d17f93470bc9",
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
									controlID = "Panel_pos_10_Panel_result_Panel_root_Panel-summonResultView_Layer1_summon_Game",
									UUID = "5b0c2aca_731e_4e0d_9205_5f56009900cc",
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
									controlID = "Button_open_Panel_result_Panel_root_Panel-summonResultView_Layer1_summon_Game",
									UUID = "718636c0_2fb2_4814_8843_fec77ac8b91d",
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
											controlID = "Label_open_Button_open_Panel_result_Panel_root_Panel-summonResultView_Layer1_summon_Game",
											UUID = "b5c14502_76c9_4cb4_a531_e6d895c7536d",
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
											height = "32",
											ignoreSize = "True",
											name = "Label_open",
											nTextAlign = "1",
											nTextHAlign = "1",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "770",
											text = "เปิดทั้งหมด",
											touchAble = "False",
											touchScaleEnable = "False",
											UILayoutViewModel = 
											{
												PositionX = -8,
												PositionY = -3,
											},
											width = "104",
											ZOrder = "1",
										},
									},
								},
								{
									controlID = "Panel_mask_all_Panel_result_Panel_root_Panel-summonResultView_Layer1_summon_Game",
									UUID = "35938345_29cd_42e9_818e_ab813fced5ce",
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
									controlID = "Panel_mask_single_Panel_result_Panel_root_Panel-summonResultView_Layer1_summon_Game",
									UUID = "8b10c44a_8579_46a6_9e4b_bf39506d1b6f",
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
									controlID = "Spine_result_effect_Panel_result_Panel_root_Panel-summonResultView_Layer1_summon_Game",
									UUID = "2c48e14d_3062_438a_91c6_b34912363fdf",
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
							},
						},
						{
							controlID = "Panel_effect_Panel_root_Panel-summonResultView_Layer1_summon_Game",
							UUID = "68a1c8fc_edec_403e_8ced_4d7fd29939f9",
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
									controlID = "Spine_texiao_bg_Panel_effect_Panel_root_Panel-summonResultView_Layer1_summon_Game",
									UUID = "22b3a16b_3622_449b_b2d4_940825449e7e",
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
									controlID = "Spine_dongzuo_Panel_effect_Panel_root_Panel-summonResultView_Layer1_summon_Game",
									UUID = "cbc98780_7688_43d2_9e67_894b314bfbe1",
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
									controlID = "Spine_texiao_top_Panel_effect_Panel_root_Panel-summonResultView_Layer1_summon_Game",
									UUID = "82143937_e6b2_4b55_8a2f_934e1baba0ac",
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
									controlID = "Button_power_Panel_effect_Panel_root_Panel-summonResultView_Layer1_summon_Game",
									UUID = "4b4b10b0_e839_46f0_9667_7c3ee0619aca",
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
											controlID = "Spine_summonResultView_1_Button_power_Panel_effect_Panel_root_Panel-summonResultView_Layer1_summon_Game",
											UUID = "7e08b777_b964_479b_9c84_b83e352ddd03",
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
									controlID = "Panel_power_Panel_effect_Panel_root_Panel-summonResultView_Layer1_summon_Game",
									UUID = "8eeb04ad_896e_41ae_b392_6953fce9ef23",
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
											controlID = "Spine_power_bottom_Panel_power_Panel_effect_Panel_root_Panel-summonResultView_Layer1_summon_Game",
											UUID = "9e834e44_4cd1_4af0_a0a5_f443bd1737c2",
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
											controlID = "Image_power_Panel_power_Panel_effect_Panel_root_Panel-summonResultView_Layer1_summon_Game",
											UUID = "15738b0b_4cdd_4333_b08b_1cff8dffe951",
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
													controlID = "Image_tag_select_Image_power_Panel_power_Panel_effect_Panel_root_Panel-summonResultView_Layer1_summon_Game",
													UUID = "36a79cb3_5a66_4d3e_b5f9_c942f71541ee",
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
													controlID = "Image_tag_1_Image_power_Panel_power_Panel_effect_Panel_root_Panel-summonResultView_Layer1_summon_Game",
													UUID = "22dfc6aa_16bc_414b_b93b_ca25b9f66dd9",
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
													controlID = "Image_tag_2_Image_power_Panel_power_Panel_effect_Panel_root_Panel-summonResultView_Layer1_summon_Game",
													UUID = "adbd7154_7042_4f78_87fd_ded594cd9902",
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
													controlID = "Image_tag_3_Image_power_Panel_power_Panel_effect_Panel_root_Panel-summonResultView_Layer1_summon_Game",
													UUID = "00bebe74_3d02_4e28_9597_b763771b98de",
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
													controlID = "Image_tag_4_Image_power_Panel_power_Panel_effect_Panel_root_Panel-summonResultView_Layer1_summon_Game",
													UUID = "2776337c_b291_4db8_94c6_9ae76c3b5cf8",
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
													controlID = "Image_tag_5_Image_power_Panel_power_Panel_effect_Panel_root_Panel-summonResultView_Layer1_summon_Game",
													UUID = "369203f0_4348_471c_a79f_b7831bd3b2fe",
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
													controlID = "Image_tag_6_Image_power_Panel_power_Panel_effect_Panel_root_Panel-summonResultView_Layer1_summon_Game",
													UUID = "186048f3_eca8_464e_b48c_8ddd3d73b09d",
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
													controlID = "Image_tag_7_Image_power_Panel_power_Panel_effect_Panel_root_Panel-summonResultView_Layer1_summon_Game",
													UUID = "d24fdaf6_d3b0_4d2d_af9e_9a95ea3f412b",
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
													controlID = "Image_tag_8_Image_power_Panel_power_Panel_effect_Panel_root_Panel-summonResultView_Layer1_summon_Game",
													UUID = "f9b98be6_d040_4a77_ba66_cc9cb5cad922",
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
													controlID = "Image_tag_9_Image_power_Panel_power_Panel_effect_Panel_root_Panel-summonResultView_Layer1_summon_Game",
													UUID = "8955c05a_4940_43d4_8763_fbc100108db1",
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
													controlID = "Image_tag_10_Image_power_Panel_power_Panel_effect_Panel_root_Panel-summonResultView_Layer1_summon_Game",
													UUID = "7cb60bee_28bc_4e8f_8c86_68436685dfb9",
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
											controlID = "Label_tips_Panel_power_Panel_effect_Panel_root_Panel-summonResultView_Layer1_summon_Game",
											UUID = "b53c2859_a3ae_49e6_a821_b877af6bf95c",
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
											text = "กดค้างเพื่อสูบฉีดพลังงาน",
											touchAble = "False",
											touchScaleEnable = "False",
											UILayoutViewModel = 
											{
												PositionX = 539,
												PositionY = -27,
											},
											width = "140",
											ZOrder = "1",
										},
										{
											controlID = "Spine_power_top_Panel_power_Panel_effect_Panel_root_Panel-summonResultView_Layer1_summon_Game",
											UUID = "c379c738_5e15_41a4_86de_875713bf44b0",
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
					controlID = "Panel_prefab_Panel-summonResultView_Layer1_summon_Game",
					UUID = "2b5dc47f_b35c_40f3_8520_b11bc244fb43",
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
							controlID = "Panel_resultItem_Panel_prefab_Panel-summonResultView_Layer1_summon_Game",
							UUID = "892c855d_fbd1_47a7_ac77_7e05b95937aa",
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
									controlID = "Spine_down_Panel_resultItem_Panel_prefab_Panel-summonResultView_Layer1_summon_Game",
									UUID = "7b1c2f11_69fe_4174_85ca_b30c0abdc2b6",
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
									controlID = "Spine_up_Panel_resultItem_Panel_prefab_Panel-summonResultView_Layer1_summon_Game",
									UUID = "9a382301_7654_4055_bd64_65799c7e176d",
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

