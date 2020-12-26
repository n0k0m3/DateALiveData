local t = 
{
	version = 1,
	components = 
	{
		
		{
			controlID = "Panel-leagueDelateInfoView_Layer1_league_Game",
			UUID = "4e0bddfe_e001_431e_b2b9_1418fd8795db",
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
					controlID = "Panel_base_Panel-leagueDelateInfoView_Layer1_league_Game",
					UUID = "1467b3a6_d32b_4dee_b6b5_83b287185bef",
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
							controlID = "Image_bg_Panel_base_Panel-leagueDelateInfoView_Layer1_league_Game",
							UUID = "41e5fb39_671f_43a7_a492_5deaebe22f7e",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							backGroundScale9Enable = "True;capInsetsX:0;capInsetsY:0;capInsetsWidth:0;capInsetsHeight:0",
							classname = "MEImage",
							dstBlendFunc = "771",
							height = "547",
							ignoreSize = "False",
							name = "Image_bg",
							sizepercentx = "100",
							sizepercenty = "100",
							sizeType = "0",
							srcBlendFunc = "1",
							texturePath = "ui/common/pop_ui/pop_bg_01.png",
							touchAble = "True",
							UILayoutViewModel = 
							{
								PositionX = 568,
								PositionY = 320,
								IsPercent = true,
								PercentX = 50,
								PercentY = 50,
								LeftPositon = 118,
								TopPosition = 70,
							},
							width = "958",
							ZOrder = "1",
							components = 
							{
								
								{
									controlID = "Label_tittle_Image_bg_Panel_base_Panel-leagueDelateInfoView_Layer1_league_Game",
									UUID = "65c9fb7f_a9c8_4bb4_8e7b_57d81f859363",
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
									fontSize = "24",
									fontStroke = 
									{
										IsStroke = false,
										StrokeColor = "#FFE6E6E6",
										StrokeSize = 1,
									},
									height = "30",
									ignoreSize = "True",
									name = "Label_tittle",
									nTextAlign = "1",
									nTextHAlign = "1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "彈劾列表",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionX = -414,
										PositionY = 241,
									},
									width = "100",
									ZOrder = "1",
								},
								{
									controlID = "Button_close_Image_bg_Panel_base_Panel-leagueDelateInfoView_Layer1_league_Game",
									UUID = "884b78c6_f339_46dc_86fe_c14536bf88d2",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEButton",
									ClickHighLightEnabled = "True",
									dstBlendFunc = "771",
									flipX = "False",
									flipY = "False",
									height = "60",
									ignoreSize = "True",
									name = "Button_close",
									normal = "ui/common/pop_ui/pop_btn_02.png",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "True",
									UILayoutViewModel = 
									{
										PositionX = 452,
										PositionY = 245,
									},
									UItype = "Button",
									width = "60",
									ZOrder = "1",
								},
								{
									controlID = "Image_leagueDelateInfoView_1_Image_bg_Panel_base_Panel-leagueDelateInfoView_Layer1_league_Game",
									UUID = "8821c46b_da1b_4614_8bb8_1c6e3afe1e35",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "True;capInsetsX:0;capInsetsY:0;capInsetsWidth:0;capInsetsHeight:0",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "420",
									ignoreSize = "False",
									name = "Image_leagueDelateInfoView_1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/common/pop_ui/pop_bg_02.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionY = 11,
									},
									width = "932",
								},
								{
									controlID = "ScrollView_members_Image_bg_Panel_base_Panel-leagueDelateInfoView_Layer1_league_Game",
									UUID = "21339f30_bb2b_40c0_b1a8_dc32e7a06bbc",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									bgColorOpacity = "50",
									bIsOpenClipping = "True",
									bounceEnable = "True",
									classname = "MEScrollView",
									colorType = "0;SingleColor:#FFE6E6E6;GraduallyChangingColorStart:#FFFFFFFF;GraduallyChangingColorEnd:#FFFFFFFF;vectorX:0;vectorY:0",
									direction = "1",
									dstBlendFunc = "771",
									height = "360",
									ignoreSize = "False",
									innerHeight = "360",
									innerWidth = "922",
									name = "ScrollView_members",
									showScrollbar = "False",
									sizepercentx = "98",
									sizepercenty = "100",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "True",
									UILayoutViewModel = 
									{
										PositionX = -3,
										PositionY = -11,
										LeftPositon = 13,
										TopPosition = 7,
										relativeToName = "Panel_bagInfo",
									},
									uipanelviewmodel = 
									{
										Layout="Absolute",
										nType = "0"
									},
									width = "922",
									ZOrder = "2",
								},
								{
									controlID = "Image_scrollBar_Image_bg_Panel_base_Panel-leagueDelateInfoView_Layer1_league_Game",
									UUID = "e0dce9e5_410e_4cdd_b3bb_f1af63012231",
									anchorPoint = "False",
									anchorPointX = "0",
									anchorPointY = "0",
									backGroundScale9Enable = "True;capInsetsX:0;capInsetsY:0;capInsetsWidth:0;capInsetsHeight:0",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "360",
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
										PositionX = 460,
										PositionY = -194,
									},
									width = "6",
									ZOrder = "2",
									components = 
									{
										
										{
											controlID = "Image_innerScrollBar_Image_scrollBar_Image_bg_Panel_base_Panel-leagueDelateInfoView_Layer1_league_Game",
											UUID = "09879d16_fff5_46fd_9503_abdc8d4ab721",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "True;capInsetsX:0;capInsetsY:0;capInsetsWidth:0;capInsetsHeight:0",
											classname = "MEImage",
											dstBlendFunc = "771",
											height = "360",
											ignoreSize = "False",
											name = "Image_innerScrollBar",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											texturePath = "ui/common/scroll_bar_02.png",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 3,
												PositionY = 180,
											},
											width = "6",
											ZOrder = "1",
										},
									},
								},
								{
									controlID = "Button_join_Image_bg_Panel_base_Panel-leagueDelateInfoView_Layer1_league_Game",
									UUID = "737dd6e7_4fc8_44a5_846f_90ff7541d4eb",
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
									name = "Button_join",
									normal = "ui/common/button09.png",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "True",
									UILayoutViewModel = 
									{
										PositionX = 400,
										PositionY = -231,
									},
									UItype = "Button",
									width = "120",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "Label_join_Button_join_Image_bg_Panel_base_Panel-leagueDelateInfoView_Layer1_league_Game",
											UUID = "27f82afc_181e_4e73_983d_32468427841a",
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
											fontSize = "24",
											fontStroke = 
											{
												IsStroke = false,
												StrokeColor = "#FFE6E6E6",
												StrokeSize = 1,
											},
											height = "27",
											ignoreSize = "True",
											name = "Label_join",
											nTextAlign = "1",
											nTextHAlign = "1",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "770",
											text = "我要參與",
											touchAble = "False",
											touchScaleEnable = "False",
											UILayoutViewModel = 
											{
												
											},
											width = "98",
											ZOrder = "1",
										},
									},
								},
								{
									controlID = "Label_top_tips_Image_bg_Panel_base_Panel-leagueDelateInfoView_Layer1_league_Game",
									UUID = "c4ef66f5_c74d_481a_a2f6_21d9dcd00aa5",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									classname = "MELabel",
									compPath = "luacomponents.common.MEIconLabel",
									dstBlendFunc = "771",
									FontColor = "#FFF9DB47",
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
									name = "Label_top_tips",
									nTextAlign = "1",
									nTextHAlign = "1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "以下成員正在角逐下一任團長",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionY = 193,
									},
									width = "289",
									ZOrder = "1",
								},
								{
									controlID = "Label_bottum_tips_Image_bg_Panel_base_Panel-leagueDelateInfoView_Layer1_league_Game",
									UUID = "13c7bcc5_51bd_449a_8984_2406b31e519f",
									anchorPoint = "False",
									anchorPointX = "0",
									anchorPointY = "0.5",
									classname = "MELabel",
									compPath = "luacomponents.common.MEIconLabel",
									dstBlendFunc = "771",
									FontColor = "#FF2E3652",
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
									name = "Label_bottum_tips",
									nTextAlign = "1",
									nTextHAlign = "1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "本周貢獻最高成員成為下一任團長",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionX = -452,
										PositionY = -231,
									},
									width = "333",
									ZOrder = "1",
								},
							},
						},
						{
							controlID = "Panel_member_item_Panel_base_Panel-leagueDelateInfoView_Layer1_league_Game",
							UUID = "26edce5a_70fe_4b3b_8bd3_880396b003b3",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							backGroundScale9Enable = "False",
							bgColorOpacity = "50",
							bIsOpenClipping = "False",
							classname = "MEPanel",
							colorType = "0;SingleColor:#FF000000;GraduallyChangingColorStart:#FFFFFFFF;GraduallyChangingColorEnd:#FFFFFFFF;vectorX:0;vectorY:0",
							DesignHeight = "640",
							DesignType = "0",
							DesignWidth = "960",
							dstBlendFunc = "771",
							height = "105",
							ignoreSize = "False",
							name = "Panel_member_item",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							touchAble = "False",
							UILayoutViewModel = 
							{
								PositionX = 568,
								PositionY = -300,
							},
							uipanelviewmodel = 
							{
								Layout="Absolute",
								nType = "0"
							},
							width = "920",
							ZOrder = "1",
							components = 
							{
								
								{
									controlID = "Image_bg_Panel_member_item_Panel_base_Panel-leagueDelateInfoView_Layer1_league_Game",
									UUID = "d2816767_2a53_42d6_bd41_4e7b388eb987",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "True;capInsetsX:0;capInsetsY:0;capInsetsWidth:0;capInsetsHeight:0",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "105",
									ignoreSize = "False",
									name = "Image_bg",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/league/ui_52.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										
									},
									width = "920",
									ZOrder = "1",
								},
								{
									controlID = "Label_name_title_Panel_member_item_Panel_base_Panel-leagueDelateInfoView_Layer1_league_Game",
									UUID = "78f49fc0_0a91_419d_a85d_4ab3cdffe7b6",
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
									name = "Label_name_title",
									nTextAlign = "1",
									nTextHAlign = "1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "姓名",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionX = -305,
										PositionY = 30,
									},
									width = "46",
									ZOrder = "1",
								},
								{
									controlID = "Label_name_Panel_member_item_Panel_base_Panel-leagueDelateInfoView_Layer1_league_Game",
									UUID = "855446d9_bce0_4343_9aa0_f83d17b085f8",
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
									name = "Label_name",
									nTextAlign = "1",
									nTextHAlign = "1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "玩家名字八個字",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionX = -246,
										PositionY = 30,
									},
									width = "157",
									ZOrder = "1",
								},
								{
									controlID = "Label_power_title_Panel_member_item_Panel_base_Panel-leagueDelateInfoView_Layer1_league_Game",
									UUID = "52f3a35a_1dc1_4ac2_9932_2fd209833921",
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
									name = "Label_power_title",
									nTextAlign = "1",
									nTextHAlign = "1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "戰鬥力",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionX = -305,
										PositionY = -30,
									},
									width = "68",
									ZOrder = "1",
								},
								{
									controlID = "Label_power_Panel_member_item_Panel_base_Panel-leagueDelateInfoView_Layer1_league_Game",
									UUID = "a8057504_e6c8_42e3_8337_6f94ed8ff722",
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
									name = "Label_power",
									nTextAlign = "1",
									nTextHAlign = "1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "999999",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionX = -233,
										PositionY = -30,
									},
									width = "74",
									ZOrder = "1",
								},
								{
									controlID = "Label_last_login_Panel_member_item_Panel_base_Panel-leagueDelateInfoView_Layer1_league_Game",
									UUID = "dc973035_541a_43c7_8dec_b7bc31cb093a",
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
									name = "Label_last_login",
									nTextAlign = "1",
									nTextHAlign = "1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "最後登錄時間：1天前",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionX = 10,
										PositionY = -30,
									},
									width = "209",
									ZOrder = "1",
								},
								{
									controlID = "Label_level_Panel_member_item_Panel_base_Panel-leagueDelateInfoView_Layer1_league_Game",
									UUID = "e6b864c2_a588_4567_8bf8_e014960b9d91",
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
									name = "Label_level",
									nTextAlign = "1",
									nTextHAlign = "1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "lv 99",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionX = 10,
										PositionY = 30,
									},
									width = "50",
									ZOrder = "1",
								},
								{
									controlID = "Image_head_Panel_member_item_Panel_base_Panel-leagueDelateInfoView_Layer1_league_Game",
									UUID = "dc7a31c7_9875_4825_91f3_c71915b2edf1",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "98",
									ignoreSize = "True",
									name = "Image_head",
									scaleX = "0.8",
									scaleY = "0.8",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "icon/hero/name/1101011.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = -404,
									},
									width = "98",
									ZOrder = "1",
								},
								{
									controlID = "Image_head_frame_Panel_member_item_Panel_base_Panel-leagueDelateInfoView_Layer1_league_Game",
									UUID = "48fc90fc_411c_406c_80ff_114d910e27c2",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "104",
									ignoreSize = "True",
									name = "Image_head_frame",
									scaleX = "0.8",
									scaleY = "0.8",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/playerInfo/avatar/TXBK_moren_1.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = -404,
									},
									width = "104",
									ZOrder = "1",
								},
								{
									controlID = "Image_head_frame_cover_Panel_member_item_Panel_base_Panel-leagueDelateInfoView_Layer1_league_Game",
									UUID = "4ad222c7_ff82_4b3e_b65b_2ffe5a610797",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "140",
									ignoreSize = "True",
									name = "Image_head_frame_cover",
									scaleX = "0.8",
									scaleY = "0.8",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/playerInfo/avatar/TXBK_1.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = -404,
									},
									width = "140",
									ZOrder = "1",
								},
								{
									controlID = "Label_active_Panel_member_item_Panel_base_Panel-leagueDelateInfoView_Layer1_league_Game",
									UUID = "711c4cad_27bb_477f_8ff5_8070228ab36e",
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
									name = "Label_active",
									nTextAlign = "1",
									nTextHAlign = "1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "競選貢獻：",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionX = 250,
									},
									width = "99",
									ZOrder = "1",
								},
								{
									controlID = "Label_active_value_Panel_member_item_Panel_base_Panel-leagueDelateInfoView_Layer1_league_Game",
									UUID = "e5ed9565_75cc_41ee_a72d_d924e2b87a20",
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
									name = "Label_active_value",
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
										PositionX = 352,
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
			"ui/common/pop_ui/pop_bg_01.png",
			"ui/common/pop_ui/pop_btn_02.png",
			"ui/common/pop_ui/pop_bg_02.png",
			"ui/common/scroll_bar_01.png",
			"ui/common/scroll_bar_02.png",
			"ui/common/button09.png",
			"ui/league/ui_52.png",
			"icon/hero/name/1101011.png",
			"ui/playerInfo/avatar/TXBK_moren_1.png",
			"ui/playerInfo/avatar/TXBK_1.png",
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

