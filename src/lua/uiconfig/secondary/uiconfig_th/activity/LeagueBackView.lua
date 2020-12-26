local t = 
{
	version = 1,
	components = 
	{
		
		{
			controlID = "Panel-LeagueBackView_leagueBack_activity_Game",
			UUID = "7fb1eca4_49cf_4f4d_9ddb_d005f28b93d4",
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
			height = "709",
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
				
			},
			uipanelviewmodel = 
			{
				Layout="Absolute",
				nType = "0"
			},
			width = "1108",
			ZOrder = "1",
			components = 
			{
				
				{
					controlID = "panel_root_Panel-LeagueBackView_leagueBack_activity_Game",
					UUID = "88816f3d_e0cf_40b9_a8d6_074447509a25",
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
					height = "640",
					ignoreSize = "False",
					name = "panel_root",
					sizepercentx = "0",
					sizepercenty = "0",
					sizeType = "0",
					srcBlendFunc = "1",
					touchAble = "False",
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
					width = "960",
					ZOrder = "1",
					components = 
					{
						
						{
							controlID = "img_bg_panel_root_Panel-LeagueBackView_leagueBack_activity_Game",
							UUID = "86ee0afc_cc6d_4bac_a576_932ec5882495",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							backGroundScale9Enable = "False",
							classname = "MEImage",
							dstBlendFunc = "771",
							height = "547",
							ignoreSize = "True",
							name = "img_bg",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							texturePath = "ui/activity/league_back/img_bg.png",
							touchAble = "False",
							UILayoutViewModel = 
							{
								
							},
							width = "891",
							ZOrder = "1",
							components = 
							{
								
								{
									controlID = "btn_help_img_bg_panel_root_Panel-LeagueBackView_leagueBack_activity_Game",
									UUID = "b32675fa_b458_4f13_be74_d84286f6d9d9",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEButton",
									ClickHighLightEnabled = "True",
									dstBlendFunc = "771",
									flipX = "False",
									flipY = "False",
									height = "42",
									ignoreSize = "True",
									name = "btn_help",
									normal = "ui/summon/002.png",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "True",
									UILayoutViewModel = 
									{
										PositionX = 404,
										PositionY = 244,
									},
									UItype = "Button",
									width = "46",
									ZOrder = "4",
								},
								{
									controlID = "panel_time_img_bg_panel_root_Panel-LeagueBackView_leagueBack_activity_Game",
									UUID = "89274944_f959_491e_a24e_af668d9c04c4",
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
									name = "panel_time",
									rotation = "-10",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = -344,
										PositionY = 172,
									},
									uipanelviewmodel = 
									{
										Layout="Absolute",
										nType = "0"
									},
									width = "200",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "label_time_panel_time_img_bg_panel_root_Panel-LeagueBackView_leagueBack_activity_Game",
											UUID = "c999fdaf_3612_4ac4_bb40_79de2298a241",
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
											fontSize = "18",
											fontStroke = 
											{
												IsStroke = true,
												StrokeColor = "#FF474577",
												StrokeSize = 1,
											},
											height = "24",
											ignoreSize = "True",
											name = "label_time",
											nTextAlign = "1",
											nTextHAlign = "1",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "770",
											text = "เวลากิจกรรม",
											touchAble = "False",
											touchScaleEnable = "False",
											UILayoutViewModel = 
											{
												PositionX = -9,
												PositionY = 78,
											},
											width = "75",
											ZOrder = "4",
										},
										{
											controlID = "time_time_panel_time_img_bg_panel_root_Panel-LeagueBackView_leagueBack_activity_Game",
											UUID = "caea24d0_cb70_4362_91c2_78eaf556ee1b",
											anchorPoint = "False",
											anchorPointX = "0",
											anchorPointY = "1",
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
											fontSize = "18",
											fontStroke = 
											{
												IsStroke = true,
												StrokeColor = "#FF474577",
												StrokeSize = 1,
											},
											height = "0",
											ignoreSize = "False",
											name = "time_time",
											nTextAlign = "1",
											nTextHAlign = "1",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "770",
											text = "2020-05-20",
											touchAble = "False",
											touchScaleEnable = "False",
											UILayoutViewModel = 
											{
												PositionX = -74,
												PositionY = 67,
											},
											width = "150",
											ZOrder = "4",
										},
										{
											controlID = "time_time_end_panel_time_img_bg_panel_root_Panel-LeagueBackView_leagueBack_activity_Game",
											UUID = "a29240d1_5bd3_46b8_818c_fc8a0ee5bf87",
											anchorPoint = "False",
											anchorPointX = "0",
											anchorPointY = "1",
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
											fontSize = "18",
											fontStroke = 
											{
												IsStroke = true,
												StrokeColor = "#FF474577",
												StrokeSize = 1,
											},
											height = "0",
											ignoreSize = "False",
											name = "time_time_end",
											nTextAlign = "1",
											nTextHAlign = "1",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "770",
											text = "2020-05-20",
											touchAble = "False",
											touchScaleEnable = "False",
											UILayoutViewModel = 
											{
												PositionX = -93,
												PositionY = 44,
											},
											width = "150",
											ZOrder = "4",
										},
									},
								},
								{
									controlID = "txt_desc_img_bg_panel_root_Panel-LeagueBackView_leagueBack_activity_Game",
									UUID = "4e436898_e9ba_432b_b6aa_ba295fcb2fcd",
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
									fontSize = "20",
									fontStroke = 
									{
										IsStroke = false,
										StrokeColor = "#FFE6E6E6",
										StrokeSize = 1,
									},
									height = "23",
									ignoreSize = "True",
									name = "txt_desc",
									nTextAlign = "1",
									nTextHAlign = "1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "成功绑定召回社团",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionX = -4,
										PositionY = 256,
									},
									width = "162",
									ZOrder = "1",
								},
								{
									controlID = "panel_reward_img_bg_panel_root_Panel-LeagueBackView_leagueBack_activity_Game",
									UUID = "ae1ae89e_fbbe_4ca2_9c82_037d6b949cf1",
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
									name = "panel_reward",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = 179,
										PositionY = -43,
									},
									uipanelviewmodel = 
									{
										Layout="Absolute",
										nType = "0"
									},
									width = "470",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "panel_item1_panel_reward_img_bg_panel_root_Panel-LeagueBackView_leagueBack_activity_Game",
											UUID = "5f743cff_505f_4c9a_b611_c20376924ce7",
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
											name = "panel_item1",
											scaleX = "0.75",
											scaleY = "0.75",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = -181,
												PositionY = -36,
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
													controlID = "img_get_panel_item1_panel_reward_img_bg_panel_root_Panel-LeagueBackView_leagueBack_activity_Game",
													UUID = "0fdb7261_8095_4a67_abc1_7cd457ceb19a",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0.5",
													backGroundScale9Enable = "False",
													classname = "MEImage",
													dstBlendFunc = "771",
													height = "34",
													ignoreSize = "True",
													name = "img_get",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "1",
													texturePath = "ui/activity/league_back/img_get.png",
													touchAble = "False",
													UILayoutViewModel = 
													{
														
													},
													width = "107",
													ZOrder = "10",
												},
												{
													controlID = "img_got_panel_item1_panel_reward_img_bg_panel_root_Panel-LeagueBackView_leagueBack_activity_Game",
													UUID = "d891a345_5258_4e82_8315_3607b311ca29",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0.5",
													backGroundScale9Enable = "False",
													classname = "MEImage",
													dstBlendFunc = "771",
													height = "34",
													ignoreSize = "True",
													name = "img_got",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "1",
													texturePath = "ui/activity/league_back/img_got.png",
													touchAble = "False",
													UILayoutViewModel = 
													{
														
													},
													width = "107",
													ZOrder = "10",
												},
											},
										},
										{
											controlID = "panel_item2_panel_reward_img_bg_panel_root_Panel-LeagueBackView_leagueBack_activity_Game",
											UUID = "0eca6489_7ff6_4d50_bac0_5b585a139e19",
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
											name = "panel_item2",
											scaleX = "0.75",
											scaleY = "0.75",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = -65,
												PositionY = 30,
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
													controlID = "img_get_panel_item2_panel_reward_img_bg_panel_root_Panel-LeagueBackView_leagueBack_activity_Game",
													UUID = "ebb2c304_a507_4335_8d28_918a69324d04",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0.5",
													backGroundScale9Enable = "False",
													classname = "MEImage",
													dstBlendFunc = "771",
													height = "34",
													ignoreSize = "True",
													name = "img_get",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "1",
													texturePath = "ui/activity/league_back/img_get.png",
													touchAble = "False",
													UILayoutViewModel = 
													{
														
													},
													width = "107",
													ZOrder = "10",
												},
												{
													controlID = "img_got_panel_item2_panel_reward_img_bg_panel_root_Panel-LeagueBackView_leagueBack_activity_Game",
													UUID = "6d319504_24ae_4352_9283_a85d9ec2cd75",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0.5",
													backGroundScale9Enable = "False",
													classname = "MEImage",
													dstBlendFunc = "771",
													height = "34",
													ignoreSize = "True",
													name = "img_got",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "1",
													texturePath = "ui/activity/league_back/img_got.png",
													touchAble = "False",
													UILayoutViewModel = 
													{
														
													},
													width = "107",
													ZOrder = "10",
												},
											},
										},
										{
											controlID = "panel_item3_panel_reward_img_bg_panel_root_Panel-LeagueBackView_leagueBack_activity_Game",
											UUID = "e5db2ec9_04a6_4ab0_9597_0ebd200eeb8d",
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
											name = "panel_item3",
											scaleX = "0.75",
											scaleY = "0.75",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 58,
												PositionY = -36,
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
													controlID = "img_get_panel_item3_panel_reward_img_bg_panel_root_Panel-LeagueBackView_leagueBack_activity_Game",
													UUID = "858dbe4e_6609_4c41_80a9_171e7f8f1d4e",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0.5",
													backGroundScale9Enable = "False",
													classname = "MEImage",
													dstBlendFunc = "771",
													height = "34",
													ignoreSize = "True",
													name = "img_get",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "1",
													texturePath = "ui/activity/league_back/img_get.png",
													touchAble = "False",
													UILayoutViewModel = 
													{
														
													},
													width = "107",
													ZOrder = "10",
												},
												{
													controlID = "img_got_panel_item3_panel_reward_img_bg_panel_root_Panel-LeagueBackView_leagueBack_activity_Game",
													UUID = "2f705e67_ea88_43e2_9b77_91bcaf4bbb01",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0.5",
													backGroundScale9Enable = "False",
													classname = "MEImage",
													dstBlendFunc = "771",
													height = "34",
													ignoreSize = "True",
													name = "img_got",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "1",
													texturePath = "ui/activity/league_back/img_got.png",
													touchAble = "False",
													UILayoutViewModel = 
													{
														
													},
													width = "107",
													ZOrder = "10",
												},
											},
										},
										{
											controlID = "panel_item4_panel_reward_img_bg_panel_root_Panel-LeagueBackView_leagueBack_activity_Game",
											UUID = "64f4af3a_2129_4e98_a687_f891e97cfeb9",
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
											name = "panel_item4",
											scaleX = "0.75",
											scaleY = "0.75",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 177,
												PositionY = 30,
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
													controlID = "img_get_panel_item4_panel_reward_img_bg_panel_root_Panel-LeagueBackView_leagueBack_activity_Game",
													UUID = "f42323c4_4559_4029_9d46_9bf9312e6b35",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0.5",
													backGroundScale9Enable = "False",
													classname = "MEImage",
													dstBlendFunc = "771",
													height = "34",
													ignoreSize = "True",
													name = "img_get",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "1",
													texturePath = "ui/activity/league_back/img_get.png",
													touchAble = "False",
													UILayoutViewModel = 
													{
														
													},
													width = "107",
													ZOrder = "10",
												},
												{
													controlID = "img_got_panel_item4_panel_reward_img_bg_panel_root_Panel-LeagueBackView_leagueBack_activity_Game",
													UUID = "845e29a9_359b_49fb_b4fb_b9ddc014e226",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0.5",
													backGroundScale9Enable = "False",
													classname = "MEImage",
													dstBlendFunc = "771",
													height = "34",
													ignoreSize = "True",
													name = "img_got",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "1",
													texturePath = "ui/activity/league_back/img_got.png",
													touchAble = "False",
													UILayoutViewModel = 
													{
														
													},
													width = "107",
													ZOrder = "10",
												},
											},
										},
										{
											controlID = "panel_get_panel_reward_img_bg_panel_root_Panel-LeagueBackView_leagueBack_activity_Game",
											UUID = "5d6893be_ebac_4b83_a85e_063ceb2e6666",
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
											height = "200",
											ignoreSize = "False",
											name = "panel_get",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionY = -2,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "490",
											ZOrder = "10",
										},
									},
								},
								{
									controlID = "panel_input_img_bg_panel_root_Panel-LeagueBackView_leagueBack_activity_Game",
									UUID = "0646360c_331c_456a_a462_5c12367899c2",
									anchorPoint = "False",
									anchorPointX = "0",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									bgColorOpacity = "100",
									bIsOpenClipping = "False",
									classname = "MEPanel",
									colorType = "0;SingleColor:#FFFFF0F5;GraduallyChangingColorStart:#FFFFFFFF;GraduallyChangingColorEnd:#FFFFFFFF;vectorX:0;vectorY:0",
									DesignHeight = "640",
									DesignType = "0",
									DesignWidth = "960",
									dstBlendFunc = "771",
									height = "40",
									ignoreSize = "False",
									name = "panel_input",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = -329,
										PositionY = -225,
										LeftPositon = 182,
										TopPosition = 28,
										relativeToName = "Panel_quick",
									},
									uipanelviewmodel = 
									{
										Layout="Absolute",
										nType = "0"
									},
									width = "580",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "textfield_input_panel_input_img_bg_panel_root_Panel-LeagueBackView_leagueBack_activity_Game",
											UUID = "b8965dbe_f28d_46be_a3be_54ee76c031c5",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											classname = "METextField",
											CursorEnabled = "False",
											dstBlendFunc = "771",
											fontName = "font/fangzheng_zhunyuan.ttf",
											fontSize = "28",
											hAlignment = "0",
											height = "40",
											ignoreSize = "False",
											KeyBoradType = "1",
											maxLengthEnable = "False",
											name = "textfield_input",
											outlineColor = "#FFFFA500",
											outlineSize = "1",
											passwordEnable = "False",
											placeHolder = " ",
											shadowColor = "#FF000000",
											shadowHeight = "0",
											shadowWidth = "0",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "770",
											text = "  ",
											touchAble = "True",
											UILayoutViewModel = 
											{
												PositionX = 290,
												LeftPositon = 242,
												TopPosition = 30,
												relativeToName = "Panel_quick",
											},
											useOutline = "False",
											useShadow = "False",
											vAlignment = "1",
											width = "580",
											ZOrder = "1",
										},
										{
											controlID = "label_input_panel_input_img_bg_panel_root_Panel-LeagueBackView_leagueBack_activity_Game",
											UUID = "0e971bf8_4cf4_4dab_b1cd_0db004c85615",
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
											fontSize = "28",
											fontStroke = 
											{
												IsStroke = false,
												StrokeColor = "#FFE6E6E6",
												StrokeSize = 1,
											},
											height = "32",
											ignoreSize = "True",
											name = "label_input",
											nTextAlign = "1",
											nTextHAlign = "1",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "770",
											text = "输入召回社团ID",
											touchAble = "False",
											touchScaleEnable = "False",
											UILayoutViewModel = 
											{
												
											},
											width = "194",
											ZOrder = "1",
										},
										{
											controlID = "img_state_panel_input_img_bg_panel_root_Panel-LeagueBackView_leagueBack_activity_Game",
											UUID = "7202c5ab_7233_430e_9d74_5301126c006c",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											classname = "MELabel",
											compPath = "luacomponents.common.MEIconLabel",
											dstBlendFunc = "771",
											FontColor = "#FFF26B9D",
											fontName = "font/MFLiHei_Noncommercial.ttf",
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
												IsStroke = true,
												StrokeColor = "#FFFFFFFF",
												StrokeSize = 2,
											},
											height = "41",
											ignoreSize = "True",
											name = "img_state",
											nTextAlign = "1",
											nTextHAlign = "1",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "770",
											text = "已提交",
											touchAble = "False",
											touchScaleEnable = "False",
											UILayoutViewModel = 
											{
												PositionX = 684,
											},
											width = "95",
											ZOrder = "1",
										},
										{
											controlID = "btn_commit_panel_input_img_bg_panel_root_Panel-LeagueBackView_leagueBack_activity_Game",
											UUID = "4ac0ad48_207f_4c6b_ae85_ce55fc049f4c",
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
											name = "btn_commit",
											normal = "ui/common/pop_ui/pop_btn_01.png",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "True",
											UILayoutViewModel = 
											{
												PositionX = 684,
											},
											UItype = "Button",
											width = "124",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "btn_label_btn_commit_panel_input_img_bg_panel_root_Panel-LeagueBackView_leagueBack_activity_Game",
													UUID = "f7a3b61f_560c_43d9_b8f9_c92670b05601",
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
													fontSize = "24",
													fontStroke = 
													{
														IsStroke = false,
														StrokeColor = "#FFE6E6E6",
														StrokeSize = 1,
													},
													height = "30",
													ignoreSize = "True",
													name = "btn_label",
													nTextAlign = "1",
													nTextHAlign = "1",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "770",
													text = "提  交",
													touchAble = "False",
													touchScaleEnable = "False",
													UILayoutViewModel = 
													{
														PositionY = -2,
													},
													width = "61",
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
		},
	},
	actions = 
	{
		
	},
	respaths = 
	{
		textures = 
		{
			"ui/activity/league_back/img_bg.png",
			"ui/summon/002.png",
			"ui/activity/league_back/img_get.png",
			"ui/activity/league_back/img_got.png",
			"ui/common/pop_ui/pop_btn_01.png",
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

