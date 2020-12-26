local t = 
{
	version = 1,
	components = 
	{
		
		{
			controlID = "Panel-leagueRedPacketDetailView_Layer1_league_Game",
			UUID = "261019aa_7b0e_49ab_82f0_16ae459de148",
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
					controlID = "Panel_base_Panel-leagueRedPacketDetailView_Layer1_league_Game",
					UUID = "e20ddc78_b549_46c4_9255_c3fd675e2226",
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
							controlID = "Image_bg_Panel_base_Panel-leagueRedPacketDetailView_Layer1_league_Game",
							UUID = "fe378e96_3f3d_4afd_a6a0_36261c316761",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							backGroundScale9Enable = "False",
							classname = "MEImage",
							dstBlendFunc = "771",
							height = "496",
							ignoreSize = "True",
							name = "Image_bg",
							sizepercentx = "100",
							sizepercenty = "100",
							sizeType = "0",
							srcBlendFunc = "1",
							texturePath = "ui/league/ui_06.png",
							touchAble = "True",
							UILayoutViewModel = 
							{
								PositionX = 569,
								PositionY = 320,
								LeftPositon = 118,
								TopPosition = 70,
							},
							width = "279",
							ZOrder = "1",
						},
						{
							controlID = "Panel_content_Panel_base_Panel-leagueRedPacketDetailView_Layer1_league_Game",
							UUID = "5b06ef6b_d42f_4aa3_aa63_694f5e51b350",
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
							height = "500",
							ignoreSize = "False",
							name = "Panel_content",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							touchAble = "False",
							UILayoutViewModel = 
							{
								PositionX = 568,
								PositionY = 320,
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
									controlID = "Button_send_Panel_content_Panel_base_Panel-leagueRedPacketDetailView_Layer1_league_Game",
									UUID = "591af8b5_1d0e_46f8_a197_7e20b1b3c453",
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
									name = "Button_send",
									normal = "ui/common/button09.png",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "True",
									UILayoutViewModel = 
									{
										PositionY = -203,
									},
									UItype = "Button",
									width = "130",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "Label_check_Button_send_Panel_content_Panel_base_Panel-leagueRedPacketDetailView_Layer1_league_Game",
											UUID = "2622b9c4_55f5_48c7_baa1_1c4e86090f1f",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											classname = "MELabel",
											compPath = "luacomponents.common.MEIconLabel",
											dstBlendFunc = "771",
											FontColor = "#FFFFFFFF",
											fontName = "phanta.ttf",
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
											name = "Label_check",
											nTextAlign = "1",
											nTextHAlign = "1",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "770",
											text = "Noch einen senden",
											touchAble = "False",
											touchScaleEnable = "False",
											UILayoutViewModel = 
											{
												
											},
											width = "91",
											ZOrder = "1",
										},
									},
								},
								{
									controlID = "Image_head_bg_Panel_content_Panel_base_Panel-leagueRedPacketDetailView_Layer1_league_Game",
									UUID = "e3ac1b13_d861_46be_829a_fda4927d55dc",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "104",
									ignoreSize = "True",
									name = "Image_head_bg",
									scaleX = "0.6",
									scaleY = "0.6",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/playerInfo/avatar/TXBK_moren_0.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionY = 166,
									},
									width = "104",
									ZOrder = "1",
								},
								{
									controlID = "Image_head_Panel_content_Panel_base_Panel-leagueRedPacketDetailView_Layer1_league_Game",
									UUID = "d731ed7c_fa0b_48f3_b71c_29be80c67b95",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "98",
									ignoreSize = "True",
									name = "Image_head",
									scaleX = "0.6",
									scaleY = "0.6",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "icon/hero/name/1101011.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionY = 166,
									},
									width = "98",
									ZOrder = "1",
								},
								{
									controlID = "Image_head_frame_Panel_content_Panel_base_Panel-leagueRedPacketDetailView_Layer1_league_Game",
									UUID = "94e26240_3803_4590_be02_117f16d06f0d",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "104",
									ignoreSize = "True",
									name = "Image_head_frame",
									scaleX = "0.6",
									scaleY = "0.6",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/playerInfo/avatar/TXBK_moren_1.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionY = 166,
									},
									width = "104",
									ZOrder = "1",
								},
								{
									controlID = "Image_head_frame_cover_Panel_content_Panel_base_Panel-leagueRedPacketDetailView_Layer1_league_Game",
									UUID = "57d2adf4_e398_4318_820d_8c369b728cf7",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "140",
									ignoreSize = "True",
									name = "Image_head_frame_cover",
									scaleX = "0.6",
									scaleY = "0.6",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/playerInfo/avatar/TXBK_1.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionY = 166,
									},
									width = "140",
									ZOrder = "1",
								},
								{
									controlID = "Label_player_name_Panel_content_Panel_base_Panel-leagueRedPacketDetailView_Layer1_league_Game",
									UUID = "262a7534_2d36_453b_82a3_f3dd3839763e",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									classname = "MELabel",
									compPath = "luacomponents.common.MEIconLabel",
									dstBlendFunc = "771",
									FontColor = "#FFDE094C",
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
									name = "Label_player_name",
									nTextAlign = "1",
									nTextHAlign = "1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "Spielername 16 Zeichen",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionY = 114,
									},
									width = "143",
									ZOrder = "1",
								},
								{
									controlID = "Label_get_Panel_content_Panel_base_Panel-leagueRedPacketDetailView_Layer1_league_Game",
									UUID = "ae2e7ec5_510c_4c3b_9c88_58cfa90d806b",
									anchorPoint = "False",
									anchorPointX = "0",
									anchorPointY = "0.5",
									classname = "MELabel",
									compPath = "luacomponents.common.MEIconLabel",
									dstBlendFunc = "771",
									FontColor = "#FF49557F",
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
									name = "Label_get",
									nTextAlign = "1",
									nTextHAlign = "1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "Abholen",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionX = -123,
										PositionY = 73,
									},
									width = "43",
									ZOrder = "1",
								},
								{
									controlID = "Label_get_num_Panel_content_Panel_base_Panel-leagueRedPacketDetailView_Layer1_league_Game",
									UUID = "20992985_c568_49c9_84b7_3ba4849747bc",
									anchorPoint = "False",
									anchorPointX = "1",
									anchorPointY = "0.5",
									classname = "MELabel",
									compPath = "luacomponents.common.MEIconLabel",
									dstBlendFunc = "771",
									FontColor = "#FF49557F",
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
									name = "Label_get_num",
									nTextAlign = "1",
									nTextHAlign = "1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "2 99",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionX = 124,
										PositionY = 73,
									},
									width = "40",
									ZOrder = "1",
								},
								{
									controlID = "ScrollView_list_Panel_content_Panel_base_Panel-leagueRedPacketDetailView_Layer1_league_Game",
									UUID = "a16c8952_8871_496b_8ef6_69e93ee9b261",
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
									height = "226",
									ignoreSize = "False",
									innerHeight = "226",
									innerWidth = "252",
									name = "ScrollView_list",
									showScrollbar = "False",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "True",
									UILayoutViewModel = 
									{
										PositionX = -128,
										PositionY = -169,
									},
									uipanelviewmodel = 
									{
										Layout="Absolute",
										nType = "0"
									},
									width = "252",
									ZOrder = "1",
								},
								{
									controlID = "Image_scrollBar_Panel_content_Panel_base_Panel-leagueRedPacketDetailView_Layer1_league_Game",
									UUID = "a18d9d6b_d2dd_4459_89f1_6e8b2c31eec0",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0",
									backGroundScale9Enable = "True;capInsetsX:0;capInsetsY:0;capInsetsWidth:0;capInsetsHeight:0",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "226",
									ignoreSize = "False",
									name = "Image_scrollBar",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/common/scroll_bar_01.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = 127,
										PositionY = -169,
									},
									width = "6",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "Image_scrollBarInner_Image_scrollBar_Panel_content_Panel_base_Panel-leagueRedPacketDetailView_Layer1_league_Game",
											UUID = "0a3bb02c_db8d_4d65_ba61_272e9da6737b",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "True;capInsetsX:0;capInsetsY:0;capInsetsWidth:0;capInsetsHeight:0",
											classname = "MEImage",
											dstBlendFunc = "771",
											height = "226",
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
												PositionY = 113,
											},
											width = "6",
											ZOrder = "1",
										},
									},
								},
							},
						},
						{
							controlID = "Panel_get_item_Panel_base_Panel-leagueRedPacketDetailView_Layer1_league_Game",
							UUID = "af997289_e6e4_4ec1_ac64_22e56b8f5999",
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
							height = "77",
							ignoreSize = "False",
							name = "Panel_get_item",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							touchAble = "False",
							UILayoutViewModel = 
							{
								PositionX = 441,
								PositionY = -300,
							},
							uipanelviewmodel = 
							{
								Layout="Absolute",
								nType = "0"
							},
							width = "252",
							ZOrder = "1",
							components = 
							{
								
								{
									controlID = "Image_head_Panel_get_item_Panel_base_Panel-leagueRedPacketDetailView_Layer1_league_Game",
									UUID = "23614eb9_46e7_445c_9d7a_fa3a27a31e4e",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "98",
									ignoreSize = "True",
									name = "Image_head",
									scaleX = "0.5",
									scaleY = "0.5",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "icon/hero/name/1101011.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = 30,
										PositionY = 44,
									},
									width = "98",
									ZOrder = "1",
								},
								{
									controlID = "Image_head_frame_Panel_get_item_Panel_base_Panel-leagueRedPacketDetailView_Layer1_league_Game",
									UUID = "a683167a_14cb_4c28_9fbc_d4c8b803b270",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "104",
									ignoreSize = "True",
									name = "Image_head_frame",
									scaleX = "0.5",
									scaleY = "0.5",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/playerInfo/avatar/TXBK_moren_1.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = 30,
										PositionY = 44,
									},
									width = "104",
									ZOrder = "1",
								},
								{
									controlID = "Label_player_name_Panel_get_item_Panel_base_Panel-leagueRedPacketDetailView_Layer1_league_Game",
									UUID = "ca462f7c_a812_42e5_9281_ab21b27b7dec",
									anchorPoint = "False",
									anchorPointX = "0",
									anchorPointY = "0.5",
									classname = "MELabel",
									compPath = "luacomponents.common.MEIconLabel",
									dstBlendFunc = "771",
									FontColor = "#FFFF5E87",
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
									name = "Label_player_name",
									nTextAlign = "1",
									nTextHAlign = "1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "Spielername 16 Zeichen",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionX = 60,
										PositionY = 62,
									},
									width = "115",
									ZOrder = "1",
								},
								{
									controlID = "Image_head_frame_cover_Panel_get_item_Panel_base_Panel-leagueRedPacketDetailView_Layer1_league_Game",
									UUID = "2c90d38a_1180_47f8_9642_a8376fbf0cb9",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "140",
									ignoreSize = "True",
									name = "Image_head_frame_cover",
									scaleX = "0.48",
									scaleY = "0.48",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/playerInfo/avatar/TXBK_1.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = 30,
										PositionY = 44,
									},
									width = "140",
									ZOrder = "1",
								},
								{
									controlID = "Label_get_time_Panel_get_item_Panel_base_Panel-leagueRedPacketDetailView_Layer1_league_Game",
									UUID = "d0dc4105_b7ab_4056_af7e_c574ad487168",
									anchorPoint = "False",
									anchorPointX = "0",
									anchorPointY = "0.5",
									classname = "MELabel",
									compPath = "luacomponents.common.MEIconLabel",
									dstBlendFunc = "771",
									FontColor = "#FFFF5E87",
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
									name = "Label_get_time",
									nTextAlign = "1",
									nTextHAlign = "1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "2019 2 5 19:00:00",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionX = 60,
										PositionY = 29,
									},
									width = "125",
									ZOrder = "1",
								},
								{
									controlID = "Image_res_Panel_get_item_Panel_base_Panel-leagueRedPacketDetailView_Layer1_league_Game",
									UUID = "a1a397cf_256a_479e_81b2_e13e4e8a7ac8",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "100",
									ignoreSize = "True",
									name = "Image_res",
									scaleX = "0.4",
									scaleY = "0.4",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "icon/system/003.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = 231,
										PositionY = 56,
									},
									width = "100",
									ZOrder = "1",
								},
								{
									controlID = "Label_get_num_Panel_get_item_Panel_base_Panel-leagueRedPacketDetailView_Layer1_league_Game",
									UUID = "50517e2c_bd1b_46c4_9ef8_c8dce3e0f30a",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									classname = "MELabel",
									compPath = "luacomponents.common.MEIconLabel",
									dstBlendFunc = "771",
									FontColor = "#FFE57F9C",
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
									name = "Label_get_num",
									nTextAlign = "1",
									nTextHAlign = "1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "9999",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionX = 228,
										PositionY = 29,
									},
									width = "38",
									ZOrder = "1",
								},
								{
									controlID = "Image_line_Panel_get_item_Panel_base_Panel-leagueRedPacketDetailView_Layer1_league_Game",
									UUID = "91bc3289_135a_4cdb_863c_df3e3ce0d4b7",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "10",
									ignoreSize = "True",
									name = "Image_line",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/league/ui_14.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = 126,
										PositionY = 8,
									},
									width = "236",
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
			"ui/league/ui_06.png",
			"ui/common/button09.png",
			"ui/playerInfo/avatar/TXBK_moren_0.png",
			"icon/hero/name/1101011.png",
			"ui/playerInfo/avatar/TXBK_moren_1.png",
			"ui/playerInfo/avatar/TXBK_1.png",
			"ui/common/scroll_bar_01.png",
			"ui/common/scroll_bar_02.png",
			"icon/system/003.png",
			"ui/league/ui_14.png",
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

