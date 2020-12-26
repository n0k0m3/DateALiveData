local t = 
{
	version = 1,
	components = 
	{
		
		{
			controlID = "Panel-cardGame_Layer1_NewYear_Game",
			UUID = "63912886_a74d_48ea_8fc2_372bd768b37f",
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
					controlID = "Panel_root_Panel-cardGame_Layer1_NewYear_Game",
					UUID = "2ce02aae_a524_41eb_b8da_e2b3630640d9",
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
						PositionX = 480,
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
							controlID = "Image_bg_Panel_root_Panel-cardGame_Layer1_NewYear_Game",
							UUID = "e6ea5d80_e20b_4ef2_b9fa_cd06b8e60c29",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							backGroundScale9Enable = "False",
							classname = "MEImage",
							dstBlendFunc = "771",
							height = "768",
							ignoreSize = "True",
							name = "Image_bg",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							texturePath = "scene/bg/bg_wanoudian2.png",
							touchAble = "False",
							UILayoutViewModel = 
							{
								
							},
							width = "1663",
							ZOrder = "1",
						},
						{
							controlID = "Image_live2d_Panel_root_Panel-cardGame_Layer1_NewYear_Game",
							UUID = "8b9a1e67_9ed7_40dd_8a93_a37c87bf41a3",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							backGroundScale9Enable = "False",
							classname = "MEImage",
							dstBlendFunc = "771",
							height = "64",
							ignoreSize = "True",
							name = "Image_live2d",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							touchAble = "False",
							UILayoutViewModel = 
							{
								PositionX = -384,
								PositionY = -16,
							},
							width = "64",
							ZOrder = "1",
						},
						{
							controlID = "dialog_Panel_root_Panel-cardGame_Layer1_NewYear_Game",
							UUID = "a4409a14_b4b6_48c6_91cc_bf2354a046a5",
							anchorPoint = "False",
							anchorPointX = "0",
							anchorPointY = "0",
							backGroundScale9Enable = "True;capInsetsX:50;capInsetsY:40;capInsetsWidth:113;capInsetsHeight:29",
							classname = "MEImage",
							dstBlendFunc = "771",
							height = "100",
							ignoreSize = "False",
							name = "dialog",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							texturePath = "ui/activity/concoctDrinks/dialogBg.png",
							touchAble = "False",
							UILayoutViewModel = 
							{
								PositionX = -289,
								PositionY = -5,
							},
							width = "280",
							ZOrder = "1",
							components = 
							{
								
								{
									controlID = "raw_dialog_Panel_root_Panel-cardGame_Layer1_NewYear_Game",
									UUID = "ca81916b_6c1c_44c0_bdb2_cd4c03a628b4",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "11",
									ignoreSize = "True",
									name = "raw",
									rotation = "90",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/activity/concoctDrinks/dialogDirection.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = -3,
										PositionY = 52,
									},
									width = "21",
									ZOrder = "1",
								},
								{
									controlID = "Label_tip_dialog_Panel_root_Panel-cardGame_Layer1_NewYear_Game",
									UUID = "604f5ba3_0bd2_40e3_86b1_e68bb03d487d",
									anchorPoint = "False",
									anchorPointX = "0",
									anchorPointY = "1",
									classname = "MELabel",
									compPath = "luacomponents.common.MEIconLabel",
									dstBlendFunc = "771",
									FontColor = "#FF000000",
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
									height = "50",
									ignoreSize = "False",
									name = "Label_tip",
									nTextAlign = "0",
									nTextHAlign = "0",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "可以任意抽取三张卡牌进行占卜",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionX = 32,
										PositionY = 78,
									},
									width = "220",
									ZOrder = "1",
								},
							},
						},
						{
							controlID = "Panel_cards_Panel_root_Panel-cardGame_Layer1_NewYear_Game",
							UUID = "6c1f3137_cde4_40cf_8e26_c83cbab8705b",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							backGroundScale9Enable = "False",
							bgColorOpacity = "50",
							bIsOpenClipping = "False",
							classname = "MEPanel",
							colorType = "0;SingleColor:#FF008000;GraduallyChangingColorStart:#FFFFFFFF;GraduallyChangingColorEnd:#FFFFFFFF;vectorX:0;vectorY:0",
							DesignHeight = "640",
							DesignType = "0",
							DesignWidth = "960",
							dstBlendFunc = "771",
							height = "288",
							ignoreSize = "False",
							name = "Panel_cards",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							touchAble = "False",
							UILayoutViewModel = 
							{
								PositionY = -174,
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
									controlID = "Panel_lucky_pos1_Panel_cards_Panel_root_Panel-cardGame_Layer1_NewYear_Game",
									UUID = "7c47e0a3_20c5_4bc4_860b_ae18d5a24c19",
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
									height = "180",
									ignoreSize = "False",
									name = "Panel_lucky_pos1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "True",
									UILayoutViewModel = 
									{
										PositionX = -212,
										PositionY = 321,
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
											controlID = "Spine_card_Panel_lucky_pos1_Panel_cards_Panel_root_Panel-cardGame_Layer1_NewYear_Game",
											UUID = "5bf45974_437d_4b75_a161_c8a7a6b9de3c",
											classname = "MESpine",
											dstBlendFunc = "771",
											name = "Spine_card",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											spineModel = 
											{
												SpinePath = "effect/MJtaluopai/MJtaluopai",
												animationName = "animation2",
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
											controlID = "Panel_center_Panel_lucky_pos1_Panel_cards_Panel_root_Panel-cardGame_Layer1_NewYear_Game",
											UUID = "ec391f11_d3e4_4ce8_b3af_4a33978ddda9",
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
											height = "1",
											ignoreSize = "False",
											name = "Panel_center",
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
											width = "1",
											ZOrder = "1",
										},
									},
								},
								{
									controlID = "Panel_lucky_pos2_Panel_cards_Panel_root_Panel-cardGame_Layer1_NewYear_Game",
									UUID = "b442674e_90fa_4ee3_aea3_f3f476a708a5",
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
									height = "180",
									ignoreSize = "False",
									name = "Panel_lucky_pos2",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "True",
									UILayoutViewModel = 
									{
										PositionY = 321,
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
											controlID = "Spine_card_Panel_lucky_pos2_Panel_cards_Panel_root_Panel-cardGame_Layer1_NewYear_Game",
											UUID = "854abc12_66c9_4631_8c4a_e3e141f2eed3",
											classname = "MESpine",
											dstBlendFunc = "771",
											name = "Spine_card",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											spineModel = 
											{
												SpinePath = "effect/MJtaluopai/MJtaluopai",
												animationName = "animation2",
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
												PositionY = -1,
											},
											ZOrder = "1",
										},
										{
											controlID = "Panel_center_Panel_lucky_pos2_Panel_cards_Panel_root_Panel-cardGame_Layer1_NewYear_Game",
											UUID = "7f748671_8008_4344_9a5f_aaf5509cb5ad",
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
											height = "1",
											ignoreSize = "False",
											name = "Panel_center",
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
											width = "1",
											ZOrder = "1",
										},
									},
								},
								{
									controlID = "Panel_lucky_pos3_Panel_cards_Panel_root_Panel-cardGame_Layer1_NewYear_Game",
									UUID = "0333c402_963a_4cc2_bd55_61df62ada1f4",
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
									height = "180",
									ignoreSize = "False",
									name = "Panel_lucky_pos3",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "True",
									UILayoutViewModel = 
									{
										PositionX = 212,
										PositionY = 321,
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
											controlID = "Spine_card_Panel_lucky_pos3_Panel_cards_Panel_root_Panel-cardGame_Layer1_NewYear_Game",
											UUID = "c8fdc5a0_a950_43c9_8db3_568d47910692",
											classname = "MESpine",
											dstBlendFunc = "771",
											name = "Spine_card",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											spineModel = 
											{
												SpinePath = "effect/MJtaluopai/MJtaluopai",
												animationName = "animation2",
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
											controlID = "Panel_center_Panel_lucky_pos3_Panel_cards_Panel_root_Panel-cardGame_Layer1_NewYear_Game",
											UUID = "4f09ec66_cb7c_4947_939d_c84061243626",
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
											height = "1",
											ignoreSize = "False",
											name = "Panel_center",
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
											width = "1",
											ZOrder = "1",
										},
									},
								},
							},
						},
						{
							controlID = "Spine_center_Panel_root_Panel-cardGame_Layer1_NewYear_Game",
							UUID = "e7a12aa6_f0ab_434f_9909_acfc6a407904",
							classname = "MESpine",
							dstBlendFunc = "771",
							name = "Spine_center",
							scaleX = "0.4",
							scaleY = "0.4",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							spineModel = 
							{
								SpinePath = "effect/MJtaluopai/MJtaluopai",
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
								PositionY = -60,
								relativeToName = "Panel",
							},
							ZOrder = "1",
						},
						{
							controlID = "Panel_touch_Panel_root_Panel-cardGame_Layer1_NewYear_Game",
							UUID = "06fc0b07_c4dd_4373_a510_86b48c52a0b4",
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
							name = "Panel_touch",
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
							width = "400",
							ZOrder = "1",
						},
					},
				},
				{
					controlID = "Panel_prefab_Panel-cardGame_Layer1_NewYear_Game",
					UUID = "72c5ad9c_e364_4963_9d15_db8fbdf0ef70",
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
						PositionX = 568,
						PositionY = -442,
						TopPosition = 762,
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
							controlID = "Panel_card_Panel_prefab_Panel-cardGame_Layer1_NewYear_Game",
							UUID = "0090c01f_d995_4afe_a51c_b42f161787df",
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
							height = "180",
							ignoreSize = "False",
							name = "Panel_card",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							touchAble = "True",
							UILayoutViewModel = 
							{
								PositionX = -70,
								PositionY = 101,
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
									controlID = "Image_card_Panel_card_Panel_prefab_Panel-cardGame_Layer1_NewYear_Game",
									UUID = "c27bc404_8fa5_4858_9fee_2bc7cc34ca27",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "315",
									ignoreSize = "True",
									name = "Image_card",
									scaleX = "0.6",
									scaleY = "0.6",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/newyear/cardGame/back.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										
									},
									width = "224",
									ZOrder = "1",
								},
								{
									controlID = "Image_front_Panel_card_Panel_prefab_Panel-cardGame_Layer1_NewYear_Game",
									UUID = "c31c0b4c_274f_4ad0_9650_b382b25110d8",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "315",
									ignoreSize = "True",
									name = "Image_front",
									scaleX = "0.6",
									scaleY = "0.6",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/newyear/cardGame/front.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										
									},
									width = "224",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "Image_icon_Image_front_Panel_card_Panel_prefab_Panel-cardGame_Layer1_NewYear_Game",
											UUID = "3fe8cce5_5d36_4558_acba_d4840fa7efa6",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											classname = "MEImage",
											dstBlendFunc = "771",
											height = "140",
											ignoreSize = "True",
											name = "Image_icon",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											texturePath = "ui/newyear/cardGame/baiyang.png",
											touchAble = "False",
											UILayoutViewModel = 
											{
												
											},
											width = "140",
											ZOrder = "1",
										},
									},
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
			"scene/bg/bg_wanoudian2.png",
			"ui/activity/concoctDrinks/dialogBg.png",
			"ui/activity/concoctDrinks/dialogDirection.png",
			"ui/newyear/cardGame/back.png",
			"ui/newyear/cardGame/front.png",
			"ui/newyear/cardGame/baiyang.png",
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

