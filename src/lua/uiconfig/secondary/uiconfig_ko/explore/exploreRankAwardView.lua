local t = 
{
	version = 1,
	components = 
	{
		
		{
			controlID = "Panel-exploreRankAwardView_Layer1_explore_Game",
			UUID = "334dfa7a_1140_4355_8a28_43872ba79925",
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
					controlID = "Panel_root_Panel-exploreRankAwardView_Layer1_explore_Game",
					UUID = "4259e596_1043_4db0_a972_00f9f220f527",
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
					name = "Panel_root",
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
							controlID = "imgBg_Panel_root_Panel-exploreRankAwardView_Layer1_explore_Game",
							UUID = "8c7cd9e8_d350_43f7_bd50_0b33a6e7c2bd",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							backGroundScale9Enable = "False",
							classname = "MEImage",
							dstBlendFunc = "771",
							height = "490",
							ignoreSize = "True",
							name = "imgBg",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							texturePath = "ui/explore/award/01.png",
							touchAble = "False",
							UILayoutViewModel = 
							{
								PositionX = 568,
								PositionY = 320,
								IsPercent = true,
								PercentX = 50,
								PercentY = 50,
							},
							width = "739",
							ZOrder = "1",
							components = 
							{
								
								{
									controlID = "ScrollView_info_imgBg_Panel_root_Panel-exploreRankAwardView_Layer1_explore_Game",
									UUID = "7d4174da_1824_4fb0_ba89_13d6f651094f",
									anchorPoint = "False",
									anchorPointX = "0",
									anchorPointY = "0",
									backGroundScale9Enable = "False",
									bgColorOpacity = "50",
									bIsOpenClipping = "True",
									bounceEnable = "False",
									classname = "MEScrollView",
									colorType = "0;SingleColor:#FFE6E6E6;GraduallyChangingColorStart:#FFFFFFFF;GraduallyChangingColorEnd:#FFFFFFFF;vectorX:0;vectorY:0",
									direction = "1",
									dstBlendFunc = "771",
									height = "400",
									ignoreSize = "False",
									innerHeight = "400",
									innerWidth = "710",
									name = "ScrollView_info",
									showScrollbar = "False",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "True",
									UILayoutViewModel = 
									{
										PositionX = -355,
										PositionY = -222,
									},
									uipanelviewmodel = 
									{
										Layout="Absolute",
										nType = "0"
									},
									width = "710",
									ZOrder = "1",
								},
								{
									controlID = "Image_split_imgBg_Panel_root_Panel-exploreRankAwardView_Layer1_explore_Game",
									UUID = "fb98885f_ec4b_46d3_93cf_3172e9af093e",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "26",
									ignoreSize = "True",
									name = "Image_split",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									texturePath = "ui/explore/award/07.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = -235,
										PositionY = 209,
									},
									width = "2",
									ZOrder = "1",
								},
								{
									controlID = "Label_title_en_imgBg_Panel_root_Panel-exploreRankAwardView_Layer1_explore_Game",
									UUID = "3a398108_eb28_4a96_9c67_2e45fc58e57b",
									anchorPoint = "False",
									anchorPointX = "0",
									anchorPointY = "0.5",
									classname = "MELabel",
									compPath = "luacomponents.common.MEIconLabel",
									dstBlendFunc = "771",
									FontColor = "#FF3E5B86",
									fontName = "font/fangzheng_zhunyuan.ttf",
									fontShadow = 
									{
										IsShadow = false,
										ShadowColor = "#FFFFFFFF",
										ShadowAlpha = 255,
										OffsetX = 0,
										OffsetY = 0,
									},
									fontSize = "15",
									fontStroke = 
									{
										IsStroke = false,
										StrokeColor = "#FFE6E6E6",
										StrokeSize = 1,
									},
									height = "17",
									ignoreSize = "True",
									name = "Label_title_en",
									nTextAlign = "1",
									nTextHAlign = "1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "Reward rules",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionX = -230,
										PositionY = 202,
									},
									width = "86",
									ZOrder = "1",
								},
								{
									controlID = "Label_title_imgBg_Panel_root_Panel-exploreRankAwardView_Layer1_explore_Game",
									UUID = "f3ba5dd4_d1bf_4b04_8788_c48eb05be982",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									classname = "MELabel",
									compPath = "luacomponents.common.MEIconLabel",
									dstBlendFunc = "771",
									FontColor = "#FF3E5B86",
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
									name = "Label_title",
									nTextAlign = "1",
									nTextHAlign = "1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "奖励规则",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionX = -299,
										PositionY = 208,
									},
									width = "114",
									ZOrder = "1",
								},
								{
									controlID = "Button_close_imgBg_Panel_root_Panel-exploreRankAwardView_Layer1_explore_Game",
									UUID = "5919fc12_8844_4db5_803a_e718fb0916d9",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEButton",
									ClickHighLightEnabled = "True",
									dstBlendFunc = "771",
									flipX = "False",
									flipY = "False",
									height = "31",
									ignoreSize = "True",
									name = "Button_close",
									normal = "ui/explore/rank/09.png",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "True",
									UILayoutViewModel = 
									{
										PositionX = 341,
										PositionY = 208,
									},
									UItype = "Button",
									width = "29",
									ZOrder = "1",
								},
								{
									controlID = "Label_tip_imgBg_Panel_root_Panel-exploreRankAwardView_Layer1_explore_Game",
									UUID = "ac61f12f_4696_490e_889b_a5b3ebbd9e37",
									anchorPoint = "False",
									anchorPointX = "1",
									anchorPointY = "0.5",
									classname = "MELabel",
									compPath = "luacomponents.common.MEIconLabel",
									dstBlendFunc = "771",
									FontColor = "#FF3E5B86",
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
									name = "Label_tip",
									nTextAlign = "1",
									nTextHAlign = "1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "TextLable",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionX = 322,
										PositionY = 206,
									},
									width = "80",
									ZOrder = "1",
								},
							},
						},
					},
				},
				{
					controlID = "Pannle_prefab_Panel-exploreRankAwardView_Layer1_explore_Game",
					UUID = "270b6174_4dbb_47b4_9543_208093394037",
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
					name = "Pannle_prefab",
					sizepercentx = "0",
					sizepercenty = "0",
					sizeType = "0",
					srcBlendFunc = "1",
					touchAble = "False",
					UILayoutViewModel = 
					{
						PositionX = 11,
						PositionY = -806,
						LeftPositon = 11,
						TopPosition = 806,
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
							controlID = "rank_item_Pannle_prefab_Panel-exploreRankAwardView_Layer1_explore_Game",
							UUID = "c8658bb1_802a_4380_af5a_c4fa9aa664be",
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
							height = "130",
							ignoreSize = "False",
							name = "rank_item",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							touchAble = "False",
							UILayoutViewModel = 
							{
								PositionX = 436,
								PositionY = 375,
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
									controlID = "Image_item_rank_item_Pannle_prefab_Panel-exploreRankAwardView_Layer1_explore_Game",
									UUID = "bc97aead_ceb6_4ed7_a50a_a4c2d4855c84",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "90",
									ignoreSize = "True",
									name = "Image_item",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/explore/award/02.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionY = -19,
									},
									width = "710",
									ZOrder = "1",
								},
								{
									controlID = "Label_tiltle_rank_item_Pannle_prefab_Panel-exploreRankAwardView_Layer1_explore_Game",
									UUID = "268148ee_dfe2_44f1_a9ed_d7ac122d199a",
									anchorPoint = "False",
									anchorPointX = "0",
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
										StrokeColor = "#FF1272C1",
										StrokeSize = 2,
									},
									height = "29",
									ignoreSize = "True",
									name = "Label_tiltle",
									nTextAlign = "1",
									nTextHAlign = "1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "第1名",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionX = -337,
										PositionY = 42,
									},
									width = "56",
									ZOrder = "1",
								},
								{
									controlID = "ScrollView_award_rank_item_Pannle_prefab_Panel-exploreRankAwardView_Layer1_explore_Game",
									UUID = "3f64d804_309a_49c4_a12a_6650f3d1a4d0",
									anchorPoint = "False",
									anchorPointX = "0",
									anchorPointY = "0",
									backGroundScale9Enable = "False",
									bgColorOpacity = "50",
									bIsOpenClipping = "True",
									bounceEnable = "False",
									classname = "MEScrollView",
									colorType = "1;SingleColor:#FFE6E6E6;GraduallyChangingColorStart:#FFFFFFFF;GraduallyChangingColorEnd:#FFFFFFFF;vectorX:0;vectorY:0",
									direction = "2",
									dstBlendFunc = "771",
									height = "66",
									ignoreSize = "False",
									innerHeight = "66",
									innerWidth = "300",
									name = "ScrollView_award",
									showScrollbar = "False",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "True",
									UILayoutViewModel = 
									{
										PositionX = 47,
										PositionY = -49,
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
									controlID = "Image_tip_rank_item_Pannle_prefab_Panel-exploreRankAwardView_Layer1_explore_Game",
									UUID = "4e5a99e4_7b4c_4b26_b2e8_b94c3032d730",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "30",
									ignoreSize = "True",
									name = "Image_tip",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/explore/award/06.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = -345,
										PositionY = 43,
									},
									width = "8",
									ZOrder = "1",
								},
								{
									controlID = "Image_tip2_rank_item_Pannle_prefab_Panel-exploreRankAwardView_Layer1_explore_Game",
									UUID = "ba2cb172_54a0_44c3_9c23_dc7a51c0bb6b",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "30",
									ignoreSize = "True",
									name = "Image_tip2",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/explore/award/06.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = 50,
										PositionY = 44,
									},
									width = "8",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "Label_tip_Image_tip2_rank_item_Pannle_prefab_Panel-exploreRankAwardView_Layer1_explore_Game",
											UUID = "6e4a7d0f_0844_4e1c_8272_c1cf5b8d4e19",
											anchorPoint = "False",
											anchorPointX = "0",
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
												StrokeColor = "#FF1272C1",
												StrokeSize = 2,
											},
											height = "29",
											ignoreSize = "True",
											name = "Label_tip",
											nTextAlign = "1",
											nTextHAlign = "1",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "770",
											text = "보상",
											touchAble = "False",
											touchScaleEnable = "False",
											UILayoutViewModel = 
											{
												PositionX = 9,
												PositionY = -2,
											},
											width = "45",
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
			"ui/explore/award/01.png",
			"ui/explore/award/07.png",
			"ui/explore/rank/09.png",
			"ui/explore/award/02.png",
			"ui/explore/award/06.png",
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

