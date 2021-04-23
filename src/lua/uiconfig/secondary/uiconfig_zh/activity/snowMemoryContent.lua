local t = 
{
	version = 1,
	components = 
	{
		
		{
			controlID = "Panel-snowMemoryContent_iceSnowDay_activity_Game",
			UUID = "092dae1e_1391_4434_9208_9c6248bbd367",
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
			sizepercentx = "89",
			sizepercenty = "110",
			sizeType = "0",
			srcBlendFunc = "1",
			touchAble = "True",
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
					controlID = "Panel_root_Panel-snowMemoryContent_iceSnowDay_activity_Game",
					UUID = "0b0e5c02_1152_4331_b108_645bebf5b7a2",
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
						PositionX = 480,
						PositionY = 320,
						relativeToName = "Panel",
						nType = 3,
						nGravity = 6,
						nAlign = 5
					},
					uipanelviewmodel = 
					{
						Layout="Relative",
						nType = "3"
					},
					width = "960",
					ZOrder = "1",
					components = 
					{
						
						{
							controlID = "Image_bg_Panel_root_Panel-snowMemoryContent_iceSnowDay_activity_Game",
							UUID = "22de58da_03f2_4e3b_9f93_2a06a87ef5a8",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							backGroundScale9Enable = "False",
							classname = "MEImage",
							dstBlendFunc = "771",
							height = "634",
							ignoreSize = "True",
							name = "Image_bg",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "770",
							texturePath = "ui/activity/2020SnowDay/memory/bg.png",
							touchAble = "False",
							UILayoutViewModel = 
							{
								relativeToName = "Panel_root",
								nType = 3,
								nGravity = 6,
								nAlign = 5
							},
							width = "1386",
							ZOrder = "1",
							components = 
							{
								
								{
									controlID = "Spine_snowMemoryContent_1_Image_bg_Panel_root_Panel-snowMemoryContent_iceSnowDay_activity_Game",
									UUID = "ae50c02a_230b_4855_8b21_eee35a113314",
									classname = "MESpine",
									dstBlendFunc = "771",
									name = "Spine_snowMemoryContent_1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									spineModel = 
									{
										SpinePath = "effect/activity_snowFes/snowFes_main1/snowFes_main1",
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
							controlID = "Image_mask_Panel_root_Panel-snowMemoryContent_iceSnowDay_activity_Game",
							UUID = "b759a2b4_5073_4dfc_9c0f_d12601fe2234",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							backGroundScale9Enable = "False",
							classname = "MEImage",
							dstBlendFunc = "771",
							height = "634",
							ignoreSize = "True",
							name = "Image_mask",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							texturePath = "ui/activity/2020SnowDay/memory/bg_mask.png",
							touchAble = "False",
							UILayoutViewModel = 
							{
								relativeToName = "Panel_root",
								nType = 3,
								nGravity = 6,
								nAlign = 5
							},
							visible = "False",
							width = "1386",
							ZOrder = "1",
						},
						{
							controlID = "Memory_list1_Panel_root_Panel-snowMemoryContent_iceSnowDay_activity_Game",
							UUID = "673f5e1c_9ef6_4388_9545_7da64563caac",
							anchorPoint = "False",
							anchorPointX = "0",
							anchorPointY = "0",
							backGroundScale9Enable = "False",
							bgColorOpacity = "50",
							bIsOpenClipping = "False",
							bounceEnable = "False",
							classname = "MEScrollView",
							colorType = "0;SingleColor:#FFE6E6E6;GraduallyChangingColorStart:#FFFFFFFF;GraduallyChangingColorEnd:#FFFFFFFF;vectorX:0;vectorY:0",
							direction = "3",
							dstBlendFunc = "771",
							height = "572",
							ignoreSize = "False",
							innerHeight = "2100",
							innerWidth = "1900",
							name = "Memory_list1",
							showScrollbar = "False",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							touchAble = "True",
							UILayoutViewModel = 
							{
								PositionX = -480,
								PositionY = -317,
								BottomPosition = 3,
								relativeToName = "Panel",
								nType = 3,
								nGravity = 4,
								nAlign = 7
							},
							uipanelviewmodel = 
							{
								Layout="Absolute",
								nType = "0"
							},
							visible = "False",
							width = "1250",
							ZOrder = "1",
							components = 
							{
								
								{
									controlID = "Panel_Level_Memory_list1_Panel_root_Panel-snowMemoryContent_iceSnowDay_activity_Game",
									UUID = "a33b6c1b_0bd2_4d9a_8163_40cf02f5eca6",
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
									height = "1900",
									ignoreSize = "False",
									name = "Panel_Level",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = 115,
										PositionY = 83,
									},
									uipanelviewmodel = 
									{
										Layout="Absolute",
										nType = "0"
									},
									width = "1800",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "Memory1_Panel_Level_Memory_list1_Panel_root_Panel-snowMemoryContent_iceSnowDay_activity_Game",
											UUID = "490e9c03_d57b_4b0e_9bcf_a43c8f00c65c",
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
											DiyPropertyViewModel = 
											{
												cfg_Id = "190034"
											},
											dstBlendFunc = "771",
											height = "142",
											ignoreSize = "False",
											name = "Memory1",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "True",
											UILayoutViewModel = 
											{
												PositionX = 1006,
												PositionY = 696,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "142",
											ZOrder = "1",
										},
										{
											controlID = "Memory2_Panel_Level_Memory_list1_Panel_root_Panel-snowMemoryContent_iceSnowDay_activity_Game",
											UUID = "9fc0a2ed_725f_412c_9d63_580b89f04989",
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
											DiyPropertyViewModel = 
											{
												cfg_Id = "190020"
											},
											dstBlendFunc = "771",
											height = "142",
											ignoreSize = "False",
											name = "Memory2",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "True",
											UILayoutViewModel = 
											{
												PositionX = 793,
												PositionY = 697,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "142",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "link_Memory2_Panel_Level_Memory_list1_Panel_root_Panel-snowMemoryContent_iceSnowDay_activity_Game",
													UUID = "6f484eba_a788_4cf2_ae32_eafc3faf9411",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0.5",
													backGroundScale9Enable = "False",
													classname = "MEImage",
													dstBlendFunc = "771",
													height = "54",
													ignoreSize = "True",
													name = "link",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "1",
													texturePath = "ui/activity/2020SnowDay/memory/level/021.png",
													touchAble = "False",
													UILayoutViewModel = 
													{
														PositionX = 93,
														PositionY = -2,
													},
													width = "123",
													ZOrder = "1",
												},
											},
										},
										{
											controlID = "Memory3_Panel_Level_Memory_list1_Panel_root_Panel-snowMemoryContent_iceSnowDay_activity_Game",
											UUID = "3756b7e8_b93f_44c8_9956_30e3f799220a",
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
											DiyPropertyViewModel = 
											{
												cfg_Id = "190024"
											},
											dstBlendFunc = "771",
											height = "142",
											ignoreSize = "False",
											name = "Memory3",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "True",
											UILayoutViewModel = 
											{
												PositionX = 1006,
												PositionY = 917,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "142",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "link_Memory3_Panel_Level_Memory_list1_Panel_root_Panel-snowMemoryContent_iceSnowDay_activity_Game",
													UUID = "02c40c69_c3cf_4aa5_a219_4e68714352f1",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0.5",
													backGroundScale9Enable = "False",
													classname = "MEImage",
													dstBlendFunc = "771",
													height = "123",
													ignoreSize = "True",
													name = "link",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "1",
													texturePath = "ui/activity/2020SnowDay/memory/level/016.png",
													touchAble = "False",
													UILayoutViewModel = 
													{
														PositionY = -101,
													},
													width = "54",
													ZOrder = "1",
												},
											},
										},
										{
											controlID = "Memory4_Panel_Level_Memory_list1_Panel_root_Panel-snowMemoryContent_iceSnowDay_activity_Game",
											UUID = "f8c4e59c_1878_4293_8c5f_5cb7c48bae55",
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
											DiyPropertyViewModel = 
											{
												cfg_Id = "190028"
											},
											dstBlendFunc = "771",
											height = "142",
											ignoreSize = "False",
											name = "Memory4",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "True",
											UILayoutViewModel = 
											{
												PositionX = 1220,
												PositionY = 699,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "142",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "link_Memory4_Panel_Level_Memory_list1_Panel_root_Panel-snowMemoryContent_iceSnowDay_activity_Game",
													UUID = "1a31967b_0991_4e56_947a_1702a8ea31f5",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0.5",
													backGroundScale9Enable = "False",
													classname = "MEImage",
													dstBlendFunc = "771",
													height = "54",
													ignoreSize = "True",
													name = "link",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "1",
													texturePath = "ui/activity/2020SnowDay/memory/level/021.png",
													touchAble = "False",
													UILayoutViewModel = 
													{
														PositionX = -93,
														PositionY = -2,
													},
													width = "123",
													ZOrder = "1",
												},
											},
										},
										{
											controlID = "Memory5_Panel_Level_Memory_list1_Panel_root_Panel-snowMemoryContent_iceSnowDay_activity_Game",
											UUID = "22fdbb2a_e5b1_48c7_8574_0c6f2b6ab3ce",
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
											DiyPropertyViewModel = 
											{
												cfg_Id = "190032"
											},
											dstBlendFunc = "771",
											height = "142",
											ignoreSize = "False",
											name = "Memory5",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "True",
											UILayoutViewModel = 
											{
												PositionX = 1006,
												PositionY = 478,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "142",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "link_Memory5_Panel_Level_Memory_list1_Panel_root_Panel-snowMemoryContent_iceSnowDay_activity_Game",
													UUID = "362b951d_d9a4_4573_b1ae_238cd893d44d",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0.5",
													backGroundScale9Enable = "False",
													classname = "MEImage",
													dstBlendFunc = "771",
													height = "123",
													ignoreSize = "True",
													name = "link",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "1",
													texturePath = "ui/activity/2020SnowDay/memory/level/016.png",
													touchAble = "False",
													UILayoutViewModel = 
													{
														PositionY = 98,
													},
													width = "54",
													ZOrder = "1",
												},
											},
										},
										{
											controlID = "Memory6_Panel_Level_Memory_list1_Panel_root_Panel-snowMemoryContent_iceSnowDay_activity_Game",
											UUID = "a06fc298_1843_4416_a8b8_b48de4f97428",
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
											DiyPropertyViewModel = 
											{
												cfg_Id = "190017"
											},
											dstBlendFunc = "771",
											height = "142",
											ignoreSize = "False",
											name = "Memory6",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "True",
											UILayoutViewModel = 
											{
												PositionX = 678,
												PositionY = 815,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "142",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "link_Memory6_Panel_Level_Memory_list1_Panel_root_Panel-snowMemoryContent_iceSnowDay_activity_Game",
													UUID = "bc6e0fdc_b503_456d_acfd_fb5c39f6cb2c",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0.5",
													backGroundScale9Enable = "False",
													classname = "MEImage",
													dstBlendFunc = "771",
													height = "107",
													ignoreSize = "True",
													name = "link",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "1",
													texturePath = "ui/activity/2020SnowDay/memory/level/017.png",
													touchAble = "False",
													UILayoutViewModel = 
													{
														PositionX = 83,
														PositionY = -27,
													},
													width = "115",
													ZOrder = "1",
												},
											},
										},
										{
											controlID = "Memory7_Panel_Level_Memory_list1_Panel_root_Panel-snowMemoryContent_iceSnowDay_activity_Game",
											UUID = "b9940719_a03b_4a26_ad1f_6c40e217870d",
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
											DiyPropertyViewModel = 
											{
												cfg_Id = "190018"
											},
											dstBlendFunc = "771",
											height = "142",
											ignoreSize = "False",
											name = "Memory7",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "True",
											UILayoutViewModel = 
											{
												PositionX = 587,
												PositionY = 695,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "142",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "link_Memory7_Panel_Level_Memory_list1_Panel_root_Panel-snowMemoryContent_iceSnowDay_activity_Game",
													UUID = "ed8dd6fe_d6d9_437b_b791_3bc446c0677e",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0.5",
													backGroundScale9Enable = "False",
													classname = "MEImage",
													dstBlendFunc = "771",
													height = "102",
													ignoreSize = "True",
													name = "link",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "1",
													texturePath = "ui/activity/2020SnowDay/memory/level/020.png",
													touchAble = "False",
													UILayoutViewModel = 
													{
														PositionX = 93,
														PositionY = 24,
													},
													width = "157",
													ZOrder = "1",
												},
											},
										},
										{
											controlID = "Memory8_Panel_Level_Memory_list1_Panel_root_Panel-snowMemoryContent_iceSnowDay_activity_Game",
											UUID = "c4dc71a1_d176_4017_9c92_a9fa7c8dd248",
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
											DiyPropertyViewModel = 
											{
												cfg_Id = "190019"
											},
											dstBlendFunc = "771",
											height = "142",
											ignoreSize = "False",
											name = "Memory8",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "True",
											UILayoutViewModel = 
											{
												PositionX = 679,
												PositionY = 579,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "142",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "link_Memory8_Panel_Level_Memory_list1_Panel_root_Panel-snowMemoryContent_iceSnowDay_activity_Game",
													UUID = "3767deb8_deb2_4f37_99fd_36c27e4f97df",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0.5",
													backGroundScale9Enable = "False",
													classname = "MEImage",
													dstBlendFunc = "771",
													height = "107",
													ignoreSize = "True",
													name = "link",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "1",
													texturePath = "ui/activity/2020SnowDay/memory/level/018.png",
													touchAble = "False",
													UILayoutViewModel = 
													{
														PositionX = 84,
														PositionY = 26,
													},
													width = "115",
													ZOrder = "1",
												},
											},
										},
										{
											controlID = "Memory9_Panel_Level_Memory_list1_Panel_root_Panel-snowMemoryContent_iceSnowDay_activity_Game",
											UUID = "5ab45b04_a62f_4faf_a39e_15f7b8909041",
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
											DiyPropertyViewModel = 
											{
												cfg_Id = "190021"
											},
											dstBlendFunc = "771",
											height = "142",
											ignoreSize = "False",
											name = "Memory9",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "True",
											UILayoutViewModel = 
											{
												PositionX = 896,
												PositionY = 1027,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "142",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "link_Memory9_Panel_Level_Memory_list1_Panel_root_Panel-snowMemoryContent_iceSnowDay_activity_Game",
													UUID = "3329ee45_bd2b_435d_9ea5_93584eb3ea9a",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0.5",
													backGroundScale9Enable = "False",
													classname = "MEImage",
													dstBlendFunc = "771",
													height = "115",
													ignoreSize = "True",
													name = "link",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "1",
													texturePath = "ui/activity/2020SnowDay/memory/level/014.png",
													touchAble = "False",
													UILayoutViewModel = 
													{
														PositionX = 25,
														PositionY = -80,
													},
													width = "107",
													ZOrder = "1",
												},
											},
										},
										{
											controlID = "Memory10_Panel_Level_Memory_list1_Panel_root_Panel-snowMemoryContent_iceSnowDay_activity_Game",
											UUID = "2e41e095_d3bb_4647_9c3a_c0d60680c122",
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
											DiyPropertyViewModel = 
											{
												cfg_Id = "190022"
											},
											dstBlendFunc = "771",
											height = "142",
											ignoreSize = "False",
											name = "Memory10",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "True",
											UILayoutViewModel = 
											{
												PositionX = 1006,
												PositionY = 1120,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "142",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "link_Memory10_Panel_Level_Memory_list1_Panel_root_Panel-snowMemoryContent_iceSnowDay_activity_Game",
													UUID = "16463937_19db_4658_a131_1eec990da653",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0.5",
													backGroundScale9Enable = "False",
													classname = "MEImage",
													dstBlendFunc = "771",
													height = "146",
													ignoreSize = "True",
													name = "link",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "1",
													texturePath = "ui/activity/2020SnowDay/memory/level/013.png",
													touchAble = "False",
													UILayoutViewModel = 
													{
														PositionY = -96,
													},
													width = "54",
													ZOrder = "1",
												},
											},
										},
										{
											controlID = "Memory11_Panel_Level_Memory_list1_Panel_root_Panel-snowMemoryContent_iceSnowDay_activity_Game",
											UUID = "57c0fe13_bdca_482d_be55_da9aede6f332",
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
											DiyPropertyViewModel = 
											{
												cfg_Id = "190023"
											},
											dstBlendFunc = "771",
											height = "142",
											ignoreSize = "False",
											name = "Memory11",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "True",
											UILayoutViewModel = 
											{
												PositionX = 1118,
												PositionY = 1027,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "142",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "link_Memory11_Panel_Level_Memory_list1_Panel_root_Panel-snowMemoryContent_iceSnowDay_activity_Game",
													UUID = "000ee005_fabd_48da_9152_37e135d83fa3",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0.5",
													backGroundScale9Enable = "False",
													classname = "MEImage",
													dstBlendFunc = "771",
													height = "142",
													ignoreSize = "True",
													name = "link",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "1",
													texturePath = "ui/activity/2020SnowDay/memory/level/015.png",
													touchAble = "False",
													UILayoutViewModel = 
													{
														PositionX = -19,
														PositionY = -66,
													},
													width = "123",
													ZOrder = "1",
												},
											},
										},
										{
											controlID = "Memory12_Panel_Level_Memory_list1_Panel_root_Panel-snowMemoryContent_iceSnowDay_activity_Game",
											UUID = "09c87cc3_5c16_4391_a771_3a061d91e33a",
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
											DiyPropertyViewModel = 
											{
												cfg_Id = "190025"
											},
											dstBlendFunc = "771",
											height = "142",
											ignoreSize = "False",
											name = "Memory12",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "True",
											UILayoutViewModel = 
											{
												PositionX = 1331,
												PositionY = 815,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "142",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "link_Memory12_Panel_Level_Memory_list1_Panel_root_Panel-snowMemoryContent_iceSnowDay_activity_Game",
													UUID = "09a7ead9_5842_412d_b679_096e30ede674",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0.5",
													backGroundScale9Enable = "False",
													classname = "MEImage",
													dstBlendFunc = "771",
													height = "158",
													ignoreSize = "True",
													name = "link",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "1",
													texturePath = "ui/activity/2020SnowDay/memory/level/024.png",
													touchAble = "False",
													UILayoutViewModel = 
													{
														PositionX = -82,
														PositionY = -1,
													},
													width = "120",
													ZOrder = "1",
												},
											},
										},
										{
											controlID = "Memory13_Panel_Level_Memory_list1_Panel_root_Panel-snowMemoryContent_iceSnowDay_activity_Game",
											UUID = "dc7835af_aded_45ec_97a3_901195a8e67c",
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
											DiyPropertyViewModel = 
											{
												cfg_Id = "190026"
											},
											dstBlendFunc = "771",
											height = "142",
											ignoreSize = "False",
											name = "Memory13",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "True",
											UILayoutViewModel = 
											{
												PositionX = 1418,
												PositionY = 697,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "142",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "link_Memory13_Panel_Level_Memory_list1_Panel_root_Panel-snowMemoryContent_iceSnowDay_activity_Game",
													UUID = "09033fef_e9cf_4f4c_aaad_4916d2d30e98",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0.5",
													backGroundScale9Enable = "False",
													classname = "MEImage",
													dstBlendFunc = "771",
													height = "54",
													ignoreSize = "True",
													name = "link",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "1",
													texturePath = "ui/activity/2020SnowDay/memory/level/022.png",
													touchAble = "False",
													UILayoutViewModel = 
													{
														PositionX = -95,
													},
													width = "146",
													ZOrder = "1",
												},
											},
										},
										{
											controlID = "Memory14_Panel_Level_Memory_list1_Panel_root_Panel-snowMemoryContent_iceSnowDay_activity_Game",
											UUID = "f764d70f_f3e2_4970_bf23_4648e3050fa2",
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
											DiyPropertyViewModel = 
											{
												cfg_Id = "190027"
											},
											dstBlendFunc = "771",
											height = "142",
											ignoreSize = "False",
											name = "Memory14",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "True",
											UILayoutViewModel = 
											{
												PositionX = 1331,
												PositionY = 581,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "142",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "link_Memory14_Panel_Level_Memory_list1_Panel_root_Panel-snowMemoryContent_iceSnowDay_activity_Game",
													UUID = "f86ac5d6_1164_4da0_bf46_21ab9ff7c5a0",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0.5",
													backGroundScale9Enable = "False",
													classname = "MEImage",
													dstBlendFunc = "771",
													height = "107",
													ignoreSize = "True",
													name = "link",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "1",
													texturePath = "ui/activity/2020SnowDay/memory/level/019.png",
													touchAble = "False",
													UILayoutViewModel = 
													{
														PositionX = -81,
														PositionY = 26,
													},
													width = "115",
													ZOrder = "1",
												},
											},
										},
										{
											controlID = "Memory15_Panel_Level_Memory_list1_Panel_root_Panel-snowMemoryContent_iceSnowDay_activity_Game",
											UUID = "a64c1c19_64fd_4ec4_827d_4f70b97fef0a",
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
											DiyPropertyViewModel = 
											{
												cfg_Id = "190029"
											},
											dstBlendFunc = "771",
											height = "142",
											ignoreSize = "False",
											name = "Memory15",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "True",
											UILayoutViewModel = 
											{
												PositionX = 1125,
												PositionY = 370,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "142",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "link_Memory15_Panel_Level_Memory_list1_Panel_root_Panel-snowMemoryContent_iceSnowDay_activity_Game",
													UUID = "2b5f8a55_976c_47a1_a28a_d3819ef7d085",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0.5",
													backGroundScale9Enable = "False",
													classname = "MEImage",
													dstBlendFunc = "771",
													height = "107",
													ignoreSize = "True",
													name = "link",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "1",
													texturePath = "ui/activity/2020SnowDay/memory/level/017.png",
													touchAble = "False",
													UILayoutViewModel = 
													{
														PositionX = -29,
														PositionY = 81,
													},
													width = "115",
													ZOrder = "1",
												},
											},
										},
										{
											controlID = "Memory16_Panel_Level_Memory_list1_Panel_root_Panel-snowMemoryContent_iceSnowDay_activity_Game",
											UUID = "4d34bdf7_b960_46f1_a0cd_b9e48588ed01",
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
											DiyPropertyViewModel = 
											{
												cfg_Id = "190030"
											},
											dstBlendFunc = "771",
											height = "142",
											ignoreSize = "False",
											name = "Memory16",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "True",
											UILayoutViewModel = 
											{
												PositionX = 1006,
												PositionY = 268,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "142",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "link_Memory16_Panel_Level_Memory_list1_Panel_root_Panel-snowMemoryContent_iceSnowDay_activity_Game",
													UUID = "105d1f22_1060_489d_b106_48f0c22bd680",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0.5",
													backGroundScale9Enable = "False",
													classname = "MEImage",
													dstBlendFunc = "771",
													height = "146",
													ignoreSize = "True",
													name = "link",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "1",
													texturePath = "ui/activity/2020SnowDay/memory/level/013.png",
													touchAble = "False",
													UILayoutViewModel = 
													{
														PositionY = 99,
													},
													width = "54",
													ZOrder = "1",
												},
											},
										},
										{
											controlID = "Memory17_Panel_Level_Memory_list1_Panel_root_Panel-snowMemoryContent_iceSnowDay_activity_Game",
											UUID = "4938b36b_05e6_4060_bfc8_62f931020679",
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
											DiyPropertyViewModel = 
											{
												cfg_Id = "190031"
											},
											dstBlendFunc = "771",
											height = "142",
											ignoreSize = "False",
											name = "Memory17",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "True",
											UILayoutViewModel = 
											{
												PositionX = 893,
												PositionY = 367,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "142",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "link_Memory17_Panel_Level_Memory_list1_Panel_root_Panel-snowMemoryContent_iceSnowDay_activity_Game",
													UUID = "14772811_7093_45ea_a4a0_6e352a2950c5",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0.5",
													backGroundScale9Enable = "False",
													classname = "MEImage",
													dstBlendFunc = "771",
													height = "171",
													ignoreSize = "True",
													name = "link",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "1",
													texturePath = "ui/activity/2020SnowDay/memory/level/023.png",
													touchAble = "False",
													UILayoutViewModel = 
													{
														PositionX = 23,
														PositionY = 110,
													},
													width = "112",
													ZOrder = "1",
												},
											},
										},
										{
											controlID = "Memory18_Panel_Level_Memory_list1_Panel_root_Panel-snowMemoryContent_iceSnowDay_activity_Game",
											UUID = "3eb19230_9c5a_442a_ab2a_a715aa4a5a3c",
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
											DiyPropertyViewModel = 
											{
												cfg_Id = "190033"
											},
											dstBlendFunc = "771",
											height = "142",
											ignoreSize = "False",
											name = "Memory18",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "True",
											UILayoutViewModel = 
											{
												PositionX = 434,
												PositionY = 1371,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "142",
											ZOrder = "1",
										},
										{
											controlID = "Memory19_Panel_Level_Memory_list1_Panel_root_Panel-snowMemoryContent_iceSnowDay_activity_Game",
											UUID = "655b2630_1e6e_4a50_a59d_59f5299ad7af",
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
											DiyPropertyViewModel = 
											{
												cfg_Id = "190016"
											},
											dstBlendFunc = "771",
											height = "142",
											ignoreSize = "False",
											name = "Memory19",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "True",
											UILayoutViewModel = 
											{
												PositionX = 285,
												PositionY = 1172,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "142",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "link_Memory19_Panel_Level_Memory_list1_Panel_root_Panel-snowMemoryContent_iceSnowDay_activity_Game",
													UUID = "8ba92f0e_9985_4d5d_a09a_af57aec4fa07",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0.5",
													backGroundScale9Enable = "False",
													classname = "MEImage",
													dstBlendFunc = "771",
													height = "183",
													ignoreSize = "True",
													name = "link",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "1",
													texturePath = "ui/activity/2020SnowDay/memory/level/012.png",
													touchAble = "False",
													UILayoutViewModel = 
													{
														PositionX = 77,
														PositionY = 63,
													},
													width = "96",
													ZOrder = "1",
												},
											},
										},
										{
											controlID = "Memory20_Panel_Level_Memory_list1_Panel_root_Panel-snowMemoryContent_iceSnowDay_activity_Game",
											UUID = "4808aacb_c86c_4e3f_8206_b7a3194e14a0",
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
											DiyPropertyViewModel = 
											{
												cfg_Id = "190012"
											},
											dstBlendFunc = "771",
											height = "142",
											ignoreSize = "False",
											name = "Memory20",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "True",
											UILayoutViewModel = 
											{
												PositionX = 213,
												PositionY = 1574,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "142",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "link_Memory20_Panel_Level_Memory_list1_Panel_root_Panel-snowMemoryContent_iceSnowDay_activity_Game",
													UUID = "d6f0e627_ac57_4fba_997d_771e121e1dda",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0.5",
													backGroundScale9Enable = "False",
													classname = "MEImage",
													dstBlendFunc = "771",
													height = "190",
													ignoreSize = "True",
													name = "link",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "1",
													texturePath = "ui/activity/2020SnowDay/memory/level/005.png",
													touchAble = "False",
													UILayoutViewModel = 
													{
														PositionX = 66,
														PositionY = -134,
													},
													width = "188",
													ZOrder = "1",
												},
											},
										},
										{
											controlID = "Memory21_Panel_Level_Memory_list1_Panel_root_Panel-snowMemoryContent_iceSnowDay_activity_Game",
											UUID = "61f08e14_e7d5_4cbf_a7c6_7cb3ccf01a3a",
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
											DiyPropertyViewModel = 
											{
												cfg_Id = "190008"
											},
											dstBlendFunc = "771",
											height = "142",
											ignoreSize = "False",
											name = "Memory21",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "True",
											UILayoutViewModel = 
											{
												PositionX = 656,
												PositionY = 1572,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "142",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "link_Memory21_Panel_Level_Memory_list1_Panel_root_Panel-snowMemoryContent_iceSnowDay_activity_Game",
													UUID = "b4fa71a8_64cb_46eb_bd81_9475311dc3e1",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0.5",
													backGroundScale9Enable = "False",
													classname = "MEImage",
													dstBlendFunc = "771",
													height = "64",
													ignoreSize = "True",
													name = "link",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "1",
													touchAble = "False",
													UILayoutViewModel = 
													{
														PositionX = -69,
														PositionY = -133,
													},
													width = "64",
													ZOrder = "1",
												},
											},
										},
										{
											controlID = "Memory22_Panel_Level_Memory_list1_Panel_root_Panel-snowMemoryContent_iceSnowDay_activity_Game",
											UUID = "61c56fdd_48d3_4a28_9178_6afcd6d4ad6f",
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
											DiyPropertyViewModel = 
											{
												cfg_Id = "190004"
											},
											dstBlendFunc = "771",
											height = "142",
											ignoreSize = "False",
											name = "Memory22",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "True",
											UILayoutViewModel = 
											{
												PositionX = 584,
												PositionY = 1175,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "142",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "link_Memory22_Panel_Level_Memory_list1_Panel_root_Panel-snowMemoryContent_iceSnowDay_activity_Game",
													UUID = "8a6a55b2_fc8c_4fbe_bf14_11e80f4e964d",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0.5",
													backGroundScale9Enable = "False",
													classname = "MEImage",
													dstBlendFunc = "771",
													height = "64",
													ignoreSize = "True",
													name = "link",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "1",
													touchAble = "False",
													UILayoutViewModel = 
													{
														PositionX = -83,
														PositionY = 55,
													},
													width = "64",
													ZOrder = "1",
												},
											},
										},
										{
											controlID = "Memory23_Panel_Level_Memory_list1_Panel_root_Panel-snowMemoryContent_iceSnowDay_activity_Game",
											UUID = "24b3aece_a307_4c4b_b1c9_35d7fe60a19c",
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
											DiyPropertyViewModel = 
											{
												cfg_Id = "190015"
											},
											dstBlendFunc = "771",
											height = "142",
											ignoreSize = "False",
											name = "Memory23",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "True",
											UILayoutViewModel = 
											{
												PositionX = 146,
												PositionY = 1291,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "142",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "link_Memory23_Panel_Level_Memory_list1_Panel_root_Panel-snowMemoryContent_iceSnowDay_activity_Game",
													UUID = "fada5b33_4be2_47cf_90f4_b42b547a908b",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0.5",
													backGroundScale9Enable = "False",
													classname = "MEImage",
													dstBlendFunc = "771",
													height = "106",
													ignoreSize = "True",
													name = "link",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "1",
													texturePath = "ui/activity/2020SnowDay/memory/level/007.png",
													touchAble = "False",
													UILayoutViewModel = 
													{
														PositionX = 96,
														PositionY = -27,
													},
													width = "140",
													ZOrder = "1",
												},
											},
										},
										{
											controlID = "Memory24_Panel_Level_Memory_list1_Panel_root_Panel-snowMemoryContent_iceSnowDay_activity_Game",
											UUID = "354b9436_f948_40a9_b05c_b511e87aa42b",
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
											DiyPropertyViewModel = 
											{
												cfg_Id = "190014"
											},
											dstBlendFunc = "771",
											height = "142",
											ignoreSize = "False",
											name = "Memory24",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "True",
											UILayoutViewModel = 
											{
												PositionX = 100,
												PositionY = 1171,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "142",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "link_Memory24_Panel_Level_Memory_list1_Panel_root_Panel-snowMemoryContent_iceSnowDay_activity_Game",
													UUID = "59bfecd6_5d23_41e0_a11b_192cc454933e",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0.5",
													backGroundScale9Enable = "False",
													classname = "MEImage",
													dstBlendFunc = "771",
													height = "54",
													ignoreSize = "True",
													name = "link",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "1",
													texturePath = "ui/activity/2020SnowDay/memory/level/011.png",
													touchAble = "False",
													UILayoutViewModel = 
													{
														PositionX = 89,
													},
													width = "128",
													ZOrder = "1",
												},
											},
										},
										{
											controlID = "Memory25_Panel_Level_Memory_list1_Panel_root_Panel-snowMemoryContent_iceSnowDay_activity_Game",
											UUID = "3efdd102_a607_45b2_a974_bff3bee45342",
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
											DiyPropertyViewModel = 
											{
												cfg_Id = "190013"
											},
											dstBlendFunc = "771",
											height = "142",
											ignoreSize = "False",
											name = "Memory25",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "True",
											UILayoutViewModel = 
											{
												PositionX = 146,
												PositionY = 1053,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "142",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "link_Memory25_Panel_Level_Memory_list1_Panel_root_Panel-snowMemoryContent_iceSnowDay_activity_Game",
													UUID = "713b9cd5_0940_4c0d_90c4_fb49c08d2781",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0.5",
													backGroundScale9Enable = "False",
													classname = "MEImage",
													dstBlendFunc = "771",
													height = "106",
													ignoreSize = "True",
													name = "link",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "1",
													texturePath = "ui/activity/2020SnowDay/memory/level/009.png",
													touchAble = "False",
													UILayoutViewModel = 
													{
														PositionX = 96,
														PositionY = 26,
													},
													width = "140",
													ZOrder = "1",
												},
											},
										},
										{
											controlID = "Memory26_Panel_Level_Memory_list1_Panel_root_Panel-snowMemoryContent_iceSnowDay_activity_Game",
											UUID = "d6cb5923_1a46_4d98_a435_c1abb310d322",
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
											DiyPropertyViewModel = 
											{
												cfg_Id = "190011"
											},
											dstBlendFunc = "771",
											height = "142",
											ignoreSize = "False",
											name = "Memory26",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "True",
											UILayoutViewModel = 
											{
												PositionX = 101,
												PositionY = 1687,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "142",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "link_Memory26_Panel_Level_Memory_list1_Panel_root_Panel-snowMemoryContent_iceSnowDay_activity_Game",
													UUID = "29cd73fa_5ec8_46a7_b48f_770cc822e1f2",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0.5",
													backGroundScale9Enable = "False",
													classname = "MEImage",
													dstBlendFunc = "771",
													height = "115",
													ignoreSize = "True",
													name = "link",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "1",
													texturePath = "ui/activity/2020SnowDay/memory/level/001.png",
													touchAble = "False",
													UILayoutViewModel = 
													{
														PositionX = 26,
														PositionY = -82,
													},
													width = "107",
													ZOrder = "1",
												},
											},
										},
										{
											controlID = "Memory27_Panel_Level_Memory_list1_Panel_root_Panel-snowMemoryContent_iceSnowDay_activity_Game",
											UUID = "ab1a79ff_788b_4e0f_bb87_6fd2185516b6",
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
											DiyPropertyViewModel = 
											{
												cfg_Id = "190010"
											},
											dstBlendFunc = "771",
											height = "142",
											ignoreSize = "False",
											name = "Memory27",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "True",
											UILayoutViewModel = 
											{
												PositionX = 215,
												PositionY = 1737,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "142",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "link_Memory27_Panel_Level_Memory_list1_Panel_root_Panel-snowMemoryContent_iceSnowDay_activity_Game",
													UUID = "c9b6c798_be00_4313_a96d_928ee6279638",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0.5",
													backGroundScale9Enable = "False",
													classname = "MEImage",
													dstBlendFunc = "771",
													height = "100",
													ignoreSize = "True",
													name = "link",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "1",
													texturePath = "ui/activity/2020SnowDay/memory/level/002.png",
													touchAble = "False",
													UILayoutViewModel = 
													{
														PositionY = -75,
													},
													width = "54",
													ZOrder = "1",
												},
											},
										},
										{
											controlID = "Memory28_Panel_Level_Memory_list1_Panel_root_Panel-snowMemoryContent_iceSnowDay_activity_Game",
											UUID = "be4bbfbe_016c_41cb_aa80_1187fba94ff3",
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
											DiyPropertyViewModel = 
											{
												cfg_Id = "190009"
											},
											dstBlendFunc = "771",
											height = "142",
											ignoreSize = "False",
											name = "Memory28",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "True",
											UILayoutViewModel = 
											{
												PositionX = 325,
												PositionY = 1688,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "142",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "link_Memory28_Panel_Level_Memory_list1_Panel_root_Panel-snowMemoryContent_iceSnowDay_activity_Game",
													UUID = "5f2266b9_b90a_4436_a718_0e663f499b6c",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0.5",
													backGroundScale9Enable = "False",
													classname = "MEImage",
													dstBlendFunc = "771",
													height = "115",
													ignoreSize = "True",
													name = "link",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "1",
													texturePath = "ui/activity/2020SnowDay/memory/level/003.png",
													touchAble = "False",
													UILayoutViewModel = 
													{
														PositionX = -26,
														PositionY = -82,
													},
													width = "107",
													ZOrder = "1",
												},
											},
										},
										{
											controlID = "Memory29_Panel_Level_Memory_list1_Panel_root_Panel-snowMemoryContent_iceSnowDay_activity_Game",
											UUID = "66e44078_52c9_40bf_b41a_02f0ddfd00e2",
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
											DiyPropertyViewModel = 
											{
												cfg_Id = "190007"
											},
											dstBlendFunc = "771",
											height = "142",
											ignoreSize = "False",
											name = "Memory29",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "True",
											UILayoutViewModel = 
											{
												PositionX = 546,
												PositionY = 1683,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "142",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "link_Memory29_Panel_Level_Memory_list1_Panel_root_Panel-snowMemoryContent_iceSnowDay_activity_Game",
													UUID = "df0d374e_f23a_44b0_9f34_ec4b61bb8704",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0.5",
													backGroundScale9Enable = "False",
													classname = "MEImage",
													dstBlendFunc = "771",
													height = "115",
													ignoreSize = "True",
													name = "link",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "1",
													texturePath = "ui/activity/2020SnowDay/memory/level/001.png",
													touchAble = "False",
													UILayoutViewModel = 
													{
														PositionX = 27,
														PositionY = -81,
													},
													width = "107",
													ZOrder = "1",
												},
											},
										},
										{
											controlID = "Memory30_Panel_Level_Memory_list1_Panel_root_Panel-snowMemoryContent_iceSnowDay_activity_Game",
											UUID = "cf6e6ec9_91e4_40b1_a145_f39666a3135c",
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
											DiyPropertyViewModel = 
											{
												cfg_Id = "190006"
											},
											dstBlendFunc = "771",
											height = "142",
											ignoreSize = "False",
											name = "Memory30",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "True",
											UILayoutViewModel = 
											{
												PositionX = 656,
												PositionY = 1732,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "142",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "link_Memory30_Panel_Level_Memory_list1_Panel_root_Panel-snowMemoryContent_iceSnowDay_activity_Game",
													UUID = "3b8fb55d_77cd_45c4_bd94_355b012a13ca",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0.5",
													backGroundScale9Enable = "False",
													classname = "MEImage",
													dstBlendFunc = "771",
													height = "100",
													ignoreSize = "True",
													name = "link",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "1",
													texturePath = "ui/activity/2020SnowDay/memory/level/002.png",
													touchAble = "False",
													UILayoutViewModel = 
													{
														PositionY = -74,
													},
													width = "54",
													ZOrder = "1",
												},
											},
										},
										{
											controlID = "Memory31_Panel_Level_Memory_list1_Panel_root_Panel-snowMemoryContent_iceSnowDay_activity_Game",
											UUID = "442ed38d_160c_4f6b_bb87_60e85ecf3574",
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
											DiyPropertyViewModel = 
											{
												cfg_Id = "190005"
											},
											dstBlendFunc = "771",
											height = "142",
											ignoreSize = "False",
											name = "Memory31",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "True",
											UILayoutViewModel = 
											{
												PositionX = 767,
												PositionY = 1684,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "142",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "link_Memory31_Panel_Level_Memory_list1_Panel_root_Panel-snowMemoryContent_iceSnowDay_activity_Game",
													UUID = "68d65c12_1ef2_4de5_b12d_8fbf5b9061ef",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0.5",
													backGroundScale9Enable = "False",
													classname = "MEImage",
													dstBlendFunc = "771",
													height = "129",
													ignoreSize = "True",
													name = "link",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "1",
													texturePath = "ui/activity/2020SnowDay/memory/level/004.png",
													touchAble = "False",
													UILayoutViewModel = 
													{
														PositionX = -22,
														PositionY = -89,
													},
													width = "117",
													ZOrder = "1",
												},
											},
										},
										{
											controlID = "Memory32_Panel_Level_Memory_list1_Panel_root_Panel-snowMemoryContent_iceSnowDay_activity_Game",
											UUID = "f18d8f4e_a370_444b_9a15_4eccd702955d",
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
											DiyPropertyViewModel = 
											{
												cfg_Id = "190003"
											},
											dstBlendFunc = "771",
											height = "142",
											ignoreSize = "False",
											name = "Memory32",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "True",
											UILayoutViewModel = 
											{
												PositionX = 722,
												PositionY = 1291,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "142",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "link_Memory32_Panel_Level_Memory_list1_Panel_root_Panel-snowMemoryContent_iceSnowDay_activity_Game",
													UUID = "ea831763_b1a3_4c27_8e86_be45f7d9aa0c",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0.5",
													backGroundScale9Enable = "False",
													classname = "MEImage",
													dstBlendFunc = "771",
													height = "106",
													ignoreSize = "True",
													name = "link",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "1",
													texturePath = "ui/activity/2020SnowDay/memory/level/008.png",
													touchAble = "False",
													UILayoutViewModel = 
													{
														PositionX = -94,
														PositionY = -25,
													},
													width = "140",
													ZOrder = "1",
												},
											},
										},
										{
											controlID = "Memory33_Panel_Level_Memory_list1_Panel_root_Panel-snowMemoryContent_iceSnowDay_activity_Game",
											UUID = "f34a1200_9f7e_4613_a597_33057fbdbeec",
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
											DiyPropertyViewModel = 
											{
												cfg_Id = "190002"
											},
											dstBlendFunc = "771",
											height = "142",
											ignoreSize = "False",
											name = "Memory33",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "True",
											UILayoutViewModel = 
											{
												PositionX = 766,
												PositionY = 1174,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "142",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "link_Memory33_Panel_Level_Memory_list1_Panel_root_Panel-snowMemoryContent_iceSnowDay_activity_Game",
													UUID = "abc2f96d_be33_4f9e_8d3c_d91bfc575584",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0.5",
													backGroundScale9Enable = "False",
													classname = "MEImage",
													dstBlendFunc = "771",
													height = "54",
													ignoreSize = "True",
													name = "link",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "1",
													texturePath = "ui/activity/2020SnowDay/memory/level/011.png",
													touchAble = "False",
													UILayoutViewModel = 
													{
														PositionX = -89,
													},
													width = "128",
													ZOrder = "1",
												},
											},
										},
										{
											controlID = "Memory34_Panel_Level_Memory_list1_Panel_root_Panel-snowMemoryContent_iceSnowDay_activity_Game",
											UUID = "b13391e0_36cf_4db3_8a6d_db71445736db",
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
											DiyPropertyViewModel = 
											{
												cfg_Id = "190001"
											},
											dstBlendFunc = "771",
											height = "142",
											ignoreSize = "False",
											name = "Memory34",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "True",
											UILayoutViewModel = 
											{
												PositionX = 723,
												PositionY = 1059,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "142",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "link_Memory34_Panel_Level_Memory_list1_Panel_root_Panel-snowMemoryContent_iceSnowDay_activity_Game",
													UUID = "b2998623_d125_487a_9e76_8505b2cc1a20",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0.5",
													backGroundScale9Enable = "False",
													classname = "MEImage",
													dstBlendFunc = "771",
													height = "106",
													ignoreSize = "True",
													name = "link",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "1",
													texturePath = "ui/activity/2020SnowDay/memory/level/010.png",
													touchAble = "False",
													UILayoutViewModel = 
													{
														PositionX = -95,
														PositionY = 26,
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
						{
							controlID = "Memory_list2_Panel_root_Panel-snowMemoryContent_iceSnowDay_activity_Game",
							UUID = "05f9fc86_7341_4d20_bfb2_fe35213ec940",
							anchorPoint = "False",
							anchorPointX = "0",
							anchorPointY = "0",
							backGroundScale9Enable = "False",
							bgColorOpacity = "50",
							bIsOpenClipping = "False",
							bounceEnable = "False",
							classname = "MEScrollView",
							colorType = "0;SingleColor:#FFE6E6E6;GraduallyChangingColorStart:#FFFFFFFF;GraduallyChangingColorEnd:#FFFFFFFF;vectorX:0;vectorY:0",
							direction = "3",
							dstBlendFunc = "771",
							height = "572",
							ignoreSize = "False",
							innerHeight = "1300",
							innerWidth = "1900",
							name = "Memory_list2",
							showScrollbar = "False",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							touchAble = "True",
							UILayoutViewModel = 
							{
								PositionX = -480,
								PositionY = -252,
								BottomPosition = 68,
								relativeToName = "Panel_root",
								nType = 3,
								nGravity = 4,
								nAlign = 7
							},
							uipanelviewmodel = 
							{
								Layout="Absolute",
								nType = "0"
							},
							width = "1250",
							ZOrder = "1",
							components = 
							{
								
								{
									controlID = "Panel_Level_Memory_list2_Panel_root_Panel-snowMemoryContent_iceSnowDay_activity_Game",
									UUID = "dd083dbb_748b_44fe_a092_2e5e69ae63ec",
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
									height = "1400",
									ignoreSize = "False",
									name = "Panel_Level",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = 80,
										PositionY = -60,
									},
									uipanelviewmodel = 
									{
										Layout="Absolute",
										nType = "0"
									},
									width = "1700",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "Memory1_Panel_Level_Memory_list2_Panel_root_Panel-snowMemoryContent_iceSnowDay_activity_Game",
											UUID = "476732a1_dce8_4091_9af4_6009fc318aa4",
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
											DiyPropertyViewModel = 
											{
												cfg_Id = "190219"
											},
											dstBlendFunc = "771",
											height = "142",
											ignoreSize = "False",
											name = "Memory1",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "True",
											UILayoutViewModel = 
											{
												PositionX = 923,
												PositionY = 362,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "142",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "link_Memory1_Panel_Level_Memory_list2_Panel_root_Panel-snowMemoryContent_iceSnowDay_activity_Game",
													UUID = "95fcdf49_73fd_4cfd_89a1_3e31d32090da",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0.5",
													backGroundScale9Enable = "False",
													classname = "MEImage",
													dstBlendFunc = "771",
													height = "108",
													ignoreSize = "True",
													name = "link",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "1",
													texturePath = "ui/activity/2020SnowDay/memory/chrismasGiftBattle/010_1.png",
													touchAble = "False",
													UILayoutViewModel = 
													{
														PositionX = 108,
														PositionY = -112,
													},
													width = "269",
													ZOrder = "1",
												},
											},
										},
										{
											controlID = "Memory2_Panel_Level_Memory_list2_Panel_root_Panel-snowMemoryContent_iceSnowDay_activity_Game",
											UUID = "ccc1196f_a933_44b9_94cb_2857340ffc9a",
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
											DiyPropertyViewModel = 
											{
												cfg_Id = "190206"
											},
											dstBlendFunc = "771",
											height = "142",
											ignoreSize = "False",
											name = "Memory2",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "True",
											UILayoutViewModel = 
											{
												PositionX = 923,
												PositionY = 697,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "142",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "link_Memory2_Panel_Level_Memory_list2_Panel_root_Panel-snowMemoryContent_iceSnowDay_activity_Game",
													UUID = "70282ef7_bd9c_4d84_8aa4_23d63f126722",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0.5",
													backGroundScale9Enable = "False",
													classname = "MEImage",
													dstBlendFunc = "771",
													height = "235",
													ignoreSize = "True",
													name = "link",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "1",
													texturePath = "ui/activity/2020SnowDay/memory/chrismasGiftBattle/007_1.png",
													touchAble = "False",
													UILayoutViewModel = 
													{
														PositionX = -1,
														PositionY = -156,
													},
													width = "52",
													ZOrder = "1",
												},
											},
										},
										{
											controlID = "Memory3_Panel_Level_Memory_list2_Panel_root_Panel-snowMemoryContent_iceSnowDay_activity_Game",
											UUID = "28b39043_8c76_4b06_b430_e01a34bdd7d1",
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
											DiyPropertyViewModel = 
											{
												cfg_Id = "190212"
											},
											dstBlendFunc = "771",
											height = "142",
											ignoreSize = "False",
											name = "Memory3",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "True",
											UILayoutViewModel = 
											{
												PositionX = 610,
												PositionY = 365,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "142",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "link_Memory3_Panel_Level_Memory_list2_Panel_root_Panel-snowMemoryContent_iceSnowDay_activity_Game",
													UUID = "a971572e_debb_4aeb_bd5e_2c32735ecbf7",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0.5",
													backGroundScale9Enable = "False",
													classname = "MEImage",
													dstBlendFunc = "771",
													height = "94",
													ignoreSize = "True",
													name = "link",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "1",
													texturePath = "ui/activity/2020SnowDay/memory/chrismasGiftBattle/009_1.png",
													touchAble = "False",
													UILayoutViewModel = 
													{
														PositionX = 143,
														PositionY = 18,
													},
													width = "223",
													ZOrder = "1",
												},
											},
										},
										{
											controlID = "Memory4_Panel_Level_Memory_list2_Panel_root_Panel-snowMemoryContent_iceSnowDay_activity_Game",
											UUID = "40a9367d_ce47_4690_a293_66c99d014625",
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
											DiyPropertyViewModel = 
											{
												cfg_Id = "190218"
											},
											dstBlendFunc = "771",
											height = "142",
											ignoreSize = "False",
											name = "Memory4",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "True",
											UILayoutViewModel = 
											{
												PositionX = 1117,
												PositionY = 490,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "142",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "link_Memory4_Panel_Level_Memory_list2_Panel_root_Panel-snowMemoryContent_iceSnowDay_activity_Game",
													UUID = "21881884_00f5_4f25_9c74_3569524f917b",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0.5",
													backGroundScale9Enable = "False",
													classname = "MEImage",
													dstBlendFunc = "771",
													height = "113",
													ignoreSize = "True",
													name = "link",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "1",
													texturePath = "ui/activity/2020SnowDay/memory/chrismasGiftBattle/011_1.png",
													touchAble = "False",
													UILayoutViewModel = 
													{
														PositionX = -56,
														PositionY = -101,
													},
													width = "166",
													ZOrder = "1",
												},
											},
										},
										{
											controlID = "Memory5_Panel_Level_Memory_list2_Panel_root_Panel-snowMemoryContent_iceSnowDay_activity_Game",
											UUID = "81866ae3_3e22_4ff1_b64c_9cf17ab373e1",
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
											DiyPropertyViewModel = 
											{
												cfg_Id = "190210"
											},
											dstBlendFunc = "771",
											height = "142",
											ignoreSize = "False",
											name = "Memory5",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "True",
											UILayoutViewModel = 
											{
												PositionX = 470,
												PositionY = 631,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "142",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "link_Memory5_Panel_Level_Memory_list2_Panel_root_Panel-snowMemoryContent_iceSnowDay_activity_Game",
													UUID = "d6ddee4b_20e5_4964_9267_56c411cab4e2",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0.5",
													backGroundScale9Enable = "False",
													classname = "MEImage",
													dstBlendFunc = "771",
													height = "98",
													ignoreSize = "True",
													name = "link",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "1",
													texturePath = "ui/activity/2020SnowDay/memory/chrismasGiftBattle/006.png",
													touchAble = "False",
													UILayoutViewModel = 
													{
														PositionX = 98,
														PositionY = -23,
													},
													width = "134",
													ZOrder = "1",
												},
											},
										},
										{
											controlID = "Memory6_Panel_Level_Memory_list2_Panel_root_Panel-snowMemoryContent_iceSnowDay_activity_Game",
											UUID = "76e0c084_48e9_4b6a_81bc_c4a13722f631",
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
											DiyPropertyViewModel = 
											{
												cfg_Id = "190209"
											},
											dstBlendFunc = "771",
											height = "142",
											ignoreSize = "False",
											name = "Memory6",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "True",
											UILayoutViewModel = 
											{
												PositionX = 332,
												PositionY = 531,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "142",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "link_Memory6_Panel_Level_Memory_list2_Panel_root_Panel-snowMemoryContent_iceSnowDay_activity_Game",
													UUID = "76b351a0_8661_4d06_abb1_b8dfa975a533",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0.5",
													backGroundScale9Enable = "False",
													classname = "MEImage",
													dstBlendFunc = "771",
													height = "155",
													ignoreSize = "True",
													name = "link",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "1",
													texturePath = "ui/activity/2020SnowDay/memory/chrismasGiftBattle/012.png",
													touchAble = "False",
													UILayoutViewModel = 
													{
														PositionX = 35,
														PositionY = 102,
													},
													width = "141",
													ZOrder = "1",
												},
											},
										},
										{
											controlID = "Memory7_Panel_Level_Memory_list2_Panel_root_Panel-snowMemoryContent_iceSnowDay_activity_Game",
											UUID = "950e07ef_268e_43a4_b771_54bd78259849",
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
											DiyPropertyViewModel = 
											{
												cfg_Id = "190207"
											},
											dstBlendFunc = "771",
											height = "142",
											ignoreSize = "False",
											name = "Memory7",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "True",
											UILayoutViewModel = 
											{
												PositionX = 516,
												PositionY = 233,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "142",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "link_Memory7_Panel_Level_Memory_list2_Panel_root_Panel-snowMemoryContent_iceSnowDay_activity_Game",
													UUID = "3dfc79d0_ca05_4caf_a73a_10b3b3c1875d",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0.5",
													backGroundScale9Enable = "False",
													classname = "MEImage",
													dstBlendFunc = "771",
													height = "54",
													ignoreSize = "True",
													name = "link",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "1",
													texturePath = "ui/activity/2020SnowDay/memory/level/011_1.png",
													touchAble = "False",
													UILayoutViewModel = 
													{
														PositionX = -87,
													},
													width = "128",
													ZOrder = "1",
												},
											},
										},
										{
											controlID = "Memory9_Panel_Level_Memory_list2_Panel_root_Panel-snowMemoryContent_iceSnowDay_activity_Game",
											UUID = "59de1064_0dc0_426d_b728_47081b0d8570",
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
											DiyPropertyViewModel = 
											{
												cfg_Id = "190211"
											},
											dstBlendFunc = "771",
											height = "142",
											ignoreSize = "False",
											name = "Memory9",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "True",
											UILayoutViewModel = 
											{
												PositionX = 608,
												PositionY = 531,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "142",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "link_Memory9_Panel_Level_Memory_list2_Panel_root_Panel-snowMemoryContent_iceSnowDay_activity_Game",
													UUID = "5d307570_6100_45e9_8cea_a24d6835f29d",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0.5",
													backGroundScale9Enable = "False",
													classname = "MEImage",
													dstBlendFunc = "771",
													height = "102",
													ignoreSize = "True",
													name = "link",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "1",
													texturePath = "ui/activity/2020SnowDay/memory/chrismasGiftBattle/001_1.png",
													touchAble = "False",
													UILayoutViewModel = 
													{
														PositionY = -77,
													},
													width = "52",
													ZOrder = "1",
												},
											},
										},
										{
											controlID = "Memory10_Panel_Level_Memory_list2_Panel_root_Panel-snowMemoryContent_iceSnowDay_activity_Game",
											UUID = "5ba2d952_f57f_4eef_b35a_d97e9ae4e4f3",
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
											DiyPropertyViewModel = 
											{
												cfg_Id = "190203"
											},
											dstBlendFunc = "771",
											height = "142",
											ignoreSize = "False",
											name = "Memory10",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "True",
											UILayoutViewModel = 
											{
												PositionX = 716,
												PositionY = 1037,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "142",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "link_Memory10_Panel_Level_Memory_list2_Panel_root_Panel-snowMemoryContent_iceSnowDay_activity_Game",
													UUID = "00a2e182_c73c_45e5_813f_33506ab18578",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0.5",
													backGroundScale9Enable = "False",
													classname = "MEImage",
													dstBlendFunc = "771",
													height = "102",
													ignoreSize = "True",
													name = "link",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "1",
													texturePath = "ui/activity/2020SnowDay/memory/chrismasGiftBattle/001_1.png",
													touchAble = "False",
													UILayoutViewModel = 
													{
														PositionY = -79,
													},
													width = "52",
													ZOrder = "1",
												},
											},
										},
										{
											controlID = "Memory11_Panel_Level_Memory_list2_Panel_root_Panel-snowMemoryContent_iceSnowDay_activity_Game",
											UUID = "e787ad13_99af_41c8_bb67_79dd9b441b5c",
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
											DiyPropertyViewModel = 
											{
												cfg_Id = "190215"
											},
											dstBlendFunc = "771",
											height = "142",
											ignoreSize = "False",
											name = "Memory11",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "True",
											UILayoutViewModel = 
											{
												PositionX = 1303,
												PositionY = 770,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "142",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "link_Memory11_Panel_Level_Memory_list2_Panel_root_Panel-snowMemoryContent_iceSnowDay_activity_Game",
													UUID = "841ef769_a240_4963_aab1_d490941d1fca",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0.5",
													backGroundScale9Enable = "False",
													classname = "MEImage",
													dstBlendFunc = "771",
													height = "177",
													ignoreSize = "True",
													name = "link",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "1",
													texturePath = "ui/activity/2020SnowDay/memory/chrismasGiftBattle/003_1.png",
													touchAble = "False",
													UILayoutViewModel = 
													{
														PositionX = -120,
														PositionY = -17,
													},
													width = "188",
													ZOrder = "1",
												},
											},
										},
										{
											controlID = "Memory12_Panel_Level_Memory_list2_Panel_root_Panel-snowMemoryContent_iceSnowDay_activity_Game",
											UUID = "0dfb2c5b_8780_431e_9c83_f51a5be037e9",
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
											DiyPropertyViewModel = 
											{
												cfg_Id = "190213"
											},
											dstBlendFunc = "771",
											height = "142",
											ignoreSize = "False",
											name = "Memory12",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "True",
											UILayoutViewModel = 
											{
												PositionX = 1296,
												PositionY = 1051,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "142",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "link_Memory12_Panel_Level_Memory_list2_Panel_root_Panel-snowMemoryContent_iceSnowDay_activity_Game",
													UUID = "a947f79b_3a5d_4330_ac29_439d7d64f673",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0.5",
													backGroundScale9Enable = "False",
													classname = "MEImage",
													dstBlendFunc = "771",
													height = "177",
													ignoreSize = "True",
													name = "link",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "1",
													texturePath = "ui/activity/2020SnowDay/memory/chrismasGiftBattle/003.png",
													touchAble = "False",
													UILayoutViewModel = 
													{
														PositionX = -116,
														PositionY = -18,
													},
													width = "188",
													ZOrder = "1",
												},
											},
										},
										{
											controlID = "Memory13_Panel_Level_Memory_list2_Panel_root_Panel-snowMemoryContent_iceSnowDay_activity_Game",
											UUID = "0c4f41dd_dcf9_4ce7_bd7a_92dc4a66e891",
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
											DiyPropertyViewModel = 
											{
												cfg_Id = "190205"
											},
											dstBlendFunc = "771",
											height = "142",
											ignoreSize = "False",
											name = "Memory13",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "True",
											UILayoutViewModel = 
											{
												PositionX = 714,
												PositionY = 698,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "142",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "link_Memory13_Panel_Level_Memory_list2_Panel_root_Panel-snowMemoryContent_iceSnowDay_activity_Game",
													UUID = "229ef062_d4b9_477e_8578_334d3d2db7ed",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0.5",
													backGroundScale9Enable = "False",
													classname = "MEImage",
													dstBlendFunc = "771",
													height = "121",
													ignoreSize = "True",
													name = "link",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "1",
													texturePath = "ui/activity/2020SnowDay/memory/chrismasGiftBattle/005.png",
													touchAble = "False",
													UILayoutViewModel = 
													{
														PositionX = 101,
														PositionY = 17,
													},
													width = "150",
													ZOrder = "1",
												},
											},
										},
										{
											controlID = "Memory14_Panel_Level_Memory_list2_Panel_root_Panel-snowMemoryContent_iceSnowDay_activity_Game",
											UUID = "e97e4f9a_06a9_4233_ba0b_88b07158fb29",
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
											DiyPropertyViewModel = 
											{
												cfg_Id = "190217"
											},
											dstBlendFunc = "771",
											height = "142",
											ignoreSize = "False",
											name = "Memory14",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "True",
											UILayoutViewModel = 
											{
												PositionX = 1318,
												PositionY = 490,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "142",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "link_Memory14_Panel_Level_Memory_list2_Panel_root_Panel-snowMemoryContent_iceSnowDay_activity_Game",
													UUID = "993bdc73_b54f_4f1b_95bc_f6a58a0b5baa",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0.5",
													backGroundScale9Enable = "False",
													classname = "MEImage",
													dstBlendFunc = "771",
													height = "52",
													ignoreSize = "True",
													name = "link",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "1",
													texturePath = "ui/activity/2020SnowDay/memory/chrismasGiftBattle/008.png",
													touchAble = "False",
													UILayoutViewModel = 
													{
														PositionX = -96,
													},
													width = "139",
													ZOrder = "1",
												},
											},
										},
										{
											controlID = "Memory15_Panel_Level_Memory_list2_Panel_root_Panel-snowMemoryContent_iceSnowDay_activity_Game",
											UUID = "7e7f8a35_bb45_462d_a83b_a7c16b412987",
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
											DiyPropertyViewModel = 
											{
												cfg_Id = "190201"
											},
											dstBlendFunc = "771",
											height = "142",
											ignoreSize = "False",
											name = "Memory15",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "True",
											UILayoutViewModel = 
											{
												PositionX = 924,
												PositionY = 1198,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "142",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "link_Memory15_Panel_Level_Memory_list2_Panel_root_Panel-snowMemoryContent_iceSnowDay_activity_Game",
													UUID = "8c313341_be84_4584_8d36_3047728b2d1d",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0.5",
													backGroundScale9Enable = "False",
													classname = "MEImage",
													dstBlendFunc = "771",
													height = "102",
													ignoreSize = "True",
													name = "link",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "1",
													texturePath = "ui/activity/2020SnowDay/memory/chrismasGiftBattle/001.png",
													touchAble = "False",
													UILayoutViewModel = 
													{
														PositionY = -76,
													},
													width = "52",
													ZOrder = "1",
												},
											},
										},
										{
											controlID = "Memory16_Panel_Level_Memory_list2_Panel_root_Panel-snowMemoryContent_iceSnowDay_activity_Game",
											UUID = "39adba1d_5333_43d0_b771_58c7885ed87a",
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
											DiyPropertyViewModel = 
											{
												cfg_Id = "190220"
											},
											dstBlendFunc = "771",
											height = "142",
											ignoreSize = "False",
											name = "Memory16",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "True",
											UILayoutViewModel = 
											{
												PositionX = 1224,
												PositionY = 229,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "142",
											ZOrder = "1",
										},
										{
											controlID = "Memory17_Panel_Level_Memory_list2_Panel_root_Panel-snowMemoryContent_iceSnowDay_activity_Game",
											UUID = "45560024_a2a5_4847_aa27_6f10bd3be20f",
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
											DiyPropertyViewModel = 
											{
												cfg_Id = "190216"
											},
											dstBlendFunc = "771",
											height = "142",
											ignoreSize = "False",
											name = "Memory17",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "True",
											UILayoutViewModel = 
											{
												PositionX = 1117,
												PositionY = 623,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "142",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "link_Memory17_Panel_Level_Memory_list2_Panel_root_Panel-snowMemoryContent_iceSnowDay_activity_Game",
													UUID = "1c21b187_4c26_4ca9_9104_88813c4de28d",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0.5",
													backGroundScale9Enable = "False",
													classname = "MEImage",
													dstBlendFunc = "771",
													height = "133",
													ignoreSize = "True",
													name = "link",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "1",
													texturePath = "ui/activity/2020SnowDay/memory/chrismasGiftBattle/004.png",
													touchAble = "False",
													UILayoutViewModel = 
													{
														PositionX = 132,
														PositionY = -39,
													},
													width = "188",
													ZOrder = "1",
												},
											},
										},
										{
											controlID = "Memory18_Panel_Level_Memory_list2_Panel_root_Panel-snowMemoryContent_iceSnowDay_activity_Game",
											UUID = "c0af3870_3ba6_4fd2_9f2f_992c97437ed0",
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
											DiyPropertyViewModel = 
											{
												cfg_Id = "190214"
											},
											dstBlendFunc = "771",
											height = "142",
											ignoreSize = "False",
											name = "Memory18",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "True",
											UILayoutViewModel = 
											{
												PositionX = 1112,
												PositionY = 907,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "142",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "link_Memory18_Panel_Level_Memory_list2_Panel_root_Panel-snowMemoryContent_iceSnowDay_activity_Game",
													UUID = "c12cab28_1658_4376_9b51_15c721c19598",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0.5",
													backGroundScale9Enable = "False",
													classname = "MEImage",
													dstBlendFunc = "771",
													height = "133",
													ignoreSize = "True",
													name = "link",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "1",
													texturePath = "ui/activity/2020SnowDay/memory/chrismasGiftBattle/004.png",
													touchAble = "False",
													UILayoutViewModel = 
													{
														PositionX = 123,
														PositionY = -41,
													},
													width = "188",
													ZOrder = "1",
												},
											},
										},
										{
											controlID = "Memory19_Panel_Level_Memory_list2_Panel_root_Panel-snowMemoryContent_iceSnowDay_activity_Game",
											UUID = "4c493a28_00b2_46c5_9e9a_06581bcf78fe",
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
											DiyPropertyViewModel = 
											{
												cfg_Id = "190204"
											},
											dstBlendFunc = "771",
											height = "142",
											ignoreSize = "False",
											name = "Memory19",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "True",
											UILayoutViewModel = 
											{
												PositionX = 716,
												PositionY = 864,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "142",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "link_Memory19_Panel_Level_Memory_list2_Panel_root_Panel-snowMemoryContent_iceSnowDay_activity_Game",
													UUID = "32b48b58_adf4_40bf_bdf5_a27d3a11cee9",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0.5",
													backGroundScale9Enable = "False",
													classname = "MEImage",
													dstBlendFunc = "771",
													height = "102",
													ignoreSize = "True",
													name = "link",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "1",
													texturePath = "ui/activity/2020SnowDay/memory/chrismasGiftBattle/001.png",
													touchAble = "False",
													UILayoutViewModel = 
													{
														PositionX = -1,
														PositionY = -89,
													},
													width = "52",
													ZOrder = "1",
												},
											},
										},
										{
											controlID = "Memory20_Panel_Level_Memory_list2_Panel_root_Panel-snowMemoryContent_iceSnowDay_activity_Game",
											UUID = "380fdc03_2a13_4467_90f0_dea851b8a058",
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
											DiyPropertyViewModel = 
											{
												cfg_Id = "190202"
											},
											dstBlendFunc = "771",
											height = "142",
											ignoreSize = "False",
											name = "Memory20",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "True",
											UILayoutViewModel = 
											{
												PositionX = 924,
												PositionY = 1035,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "142",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "link_Memory20_Panel_Level_Memory_list2_Panel_root_Panel-snowMemoryContent_iceSnowDay_activity_Game",
													UUID = "967865fe_b401_4ca6_b2d9_c3f06a7ed5cb",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0.5",
													backGroundScale9Enable = "False",
													classname = "MEImage",
													dstBlendFunc = "771",
													height = "115",
													ignoreSize = "True",
													name = "link",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "1",
													texturePath = "ui/activity/2020SnowDay/memory/chrismasGiftBattle/002.png",
													touchAble = "False",
													UILayoutViewModel = 
													{
														PositionX = -105,
														PositionY = 32,
													},
													width = "149",
													ZOrder = "1",
												},
											},
										},
										{
											controlID = "Memory21_Panel_Level_Memory_list2_Panel_root_Panel-snowMemoryContent_iceSnowDay_activity_Game",
											UUID = "d42eb267_ad1d_4c69_b5ef_306e2d771226",
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
											DiyPropertyViewModel = 
											{
												cfg_Id = "190208"
											},
											dstBlendFunc = "771",
											height = "142",
											ignoreSize = "False",
											name = "Memory21",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "True",
											UILayoutViewModel = 
											{
												PositionX = 333,
												PositionY = 233,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "142",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "link_Memory21_Panel_Level_Memory_list2_Panel_root_Panel-snowMemoryContent_iceSnowDay_activity_Game",
													UUID = "5577dc11_466b_482f_98e8_f227f1646f4a",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0.5",
													backGroundScale9Enable = "False",
													classname = "MEImage",
													dstBlendFunc = "771",
													height = "235",
													ignoreSize = "True",
													name = "link",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "1",
													texturePath = "ui/activity/2020SnowDay/memory/chrismasGiftBattle/007.png",
													touchAble = "False",
													UILayoutViewModel = 
													{
														PositionY = 156,
													},
													width = "52",
													ZOrder = "1",
												},
											},
										},
									},
								},
							},
						},
						{
							controlID = "Memory_list3_Panel_root_Panel-snowMemoryContent_iceSnowDay_activity_Game",
							UUID = "fde337e1_cead_4676_ace4_5951d6fdb8e8",
							anchorPoint = "False",
							anchorPointX = "0",
							anchorPointY = "0",
							backGroundScale9Enable = "False",
							bgColorOpacity = "50",
							bIsOpenClipping = "False",
							bounceEnable = "False",
							classname = "MEScrollView",
							colorType = "0;SingleColor:#FFE6E6E6;GraduallyChangingColorStart:#FFFFFFFF;GraduallyChangingColorEnd:#FFFFFFFF;vectorX:0;vectorY:0",
							direction = "3",
							dstBlendFunc = "771",
							height = "572",
							ignoreSize = "False",
							innerHeight = "2000",
							innerWidth = "2400",
							name = "Memory_list3",
							showScrollbar = "False",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							touchAble = "True",
							UILayoutViewModel = 
							{
								PositionX = -480,
								PositionY = -317,
								BottomPosition = 3,
								relativeToName = "Panel_root",
								nType = 3,
								nGravity = 4,
								nAlign = 7
							},
							uipanelviewmodel = 
							{
								Layout="Absolute",
								nType = "0"
							},
							visible = "False",
							width = "1250",
							ZOrder = "1",
							components = 
							{
								
								{
									controlID = "Panel_Level_Memory_list3_Panel_root_Panel-snowMemoryContent_iceSnowDay_activity_Game",
									UUID = "80c8cbdb_0744_45ef_871a_ca403ceba449",
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
									height = "1800",
									ignoreSize = "False",
									name = "Panel_Level",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = -57,
										PositionY = 105,
									},
									uipanelviewmodel = 
									{
										Layout="Absolute",
										nType = "0"
									},
									width = "2300",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "Memory1_Panel_Level_Memory_list3_Panel_root_Panel-snowMemoryContent_iceSnowDay_activity_Game",
											UUID = "d384f3c3_f01c_4838_8806_6d02c347ed4c",
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
											DiyPropertyViewModel = 
											{
												cfg_Id = "190143"
											},
											dstBlendFunc = "771",
											height = "142",
											ignoreSize = "False",
											name = "Memory1",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "True",
											UILayoutViewModel = 
											{
												PositionX = 1113,
												PositionY = 869,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "142",
											ZOrder = "1",
										},
										{
											controlID = "Memory2_Panel_Level_Memory_list3_Panel_root_Panel-snowMemoryContent_iceSnowDay_activity_Game",
											UUID = "479c70fe_9d1e_4357_aefb_ce0a136d5ea0",
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
											DiyPropertyViewModel = 
											{
												cfg_Id = "190128"
											},
											dstBlendFunc = "771",
											height = "142",
											ignoreSize = "False",
											name = "Memory2",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "True",
											UILayoutViewModel = 
											{
												PositionX = 1465,
												PositionY = 871,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "142",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "link_Memory2_Panel_Level_Memory_list3_Panel_root_Panel-snowMemoryContent_iceSnowDay_activity_Game",
													UUID = "4b537306_ea5a_49b1_9226_ff33cf807506",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0.5",
													backGroundScale9Enable = "False",
													classname = "MEImage",
													dstBlendFunc = "771",
													height = "95",
													ignoreSize = "True",
													name = "link",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "1",
													texturePath = "ui/activity/2020SnowDay/memory/chrimasBattle/011_1.png",
													touchAble = "False",
													UILayoutViewModel = 
													{
														PositionX = -170,
														PositionY = -24,
													},
													width = "276",
													ZOrder = "1",
												},
											},
										},
										{
											controlID = "Memory3_Panel_Level_Memory_list3_Panel_root_Panel-snowMemoryContent_iceSnowDay_activity_Game",
											UUID = "76411209_6b28_41de_b94e_b658588bc21d",
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
											DiyPropertyViewModel = 
											{
												cfg_Id = "190127"
											},
											dstBlendFunc = "771",
											height = "142",
											ignoreSize = "False",
											name = "Memory3",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "True",
											UILayoutViewModel = 
											{
												PositionX = 1624,
												PositionY = 1048,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "142",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "link_Memory3_Panel_Level_Memory_list3_Panel_root_Panel-snowMemoryContent_iceSnowDay_activity_Game",
													UUID = "975770b1_3160_4d47_b267_9fde61969fca",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0.5",
													backGroundScale9Enable = "False",
													classname = "MEImage",
													dstBlendFunc = "771",
													height = "207",
													ignoreSize = "True",
													name = "link",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "1",
													texturePath = "ui/activity/2020SnowDay/memory/chrimasBattle/015_1.png",
													touchAble = "False",
													UILayoutViewModel = 
													{
														PositionX = -109,
														PositionY = -35,
													},
													width = "155",
													ZOrder = "1",
												},
											},
										},
										{
											controlID = "Memory4_Panel_Level_Memory_list3_Panel_root_Panel-snowMemoryContent_iceSnowDay_activity_Game",
											UUID = "68929942_e419_49eb_a56b_e2f29efb8153",
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
											DiyPropertyViewModel = 
											{
												cfg_Id = "190126"
											},
											dstBlendFunc = "771",
											height = "142",
											ignoreSize = "False",
											name = "Memory4",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "True",
											UILayoutViewModel = 
											{
												PositionX = 1800,
												PositionY = 1050,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "142",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "link_Memory4_Panel_Level_Memory_list3_Panel_root_Panel-snowMemoryContent_iceSnowDay_activity_Game",
													UUID = "b7513828_4611_4a64_a05d_0c2254f68c66",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0.5",
													backGroundScale9Enable = "False",
													classname = "MEImage",
													dstBlendFunc = "771",
													height = "54",
													ignoreSize = "True",
													name = "link",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "1",
													texturePath = "ui/activity/2020SnowDay/memory/chrimasBattle/004_1.png",
													touchAble = "False",
													UILayoutViewModel = 
													{
														PositionX = -87,
														PositionY = -2,
													},
													width = "116",
													ZOrder = "1",
												},
											},
										},
										{
											controlID = "Memory5_Panel_Level_Memory_list3_Panel_root_Panel-snowMemoryContent_iceSnowDay_activity_Game",
											UUID = "b3e61dd2_2773_481b_816b_3bddc1c55863",
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
											DiyPropertyViewModel = 
											{
												cfg_Id = "190125"
											},
											dstBlendFunc = "771",
											height = "142",
											ignoreSize = "False",
											name = "Memory5",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "True",
											UILayoutViewModel = 
											{
												PositionX = 1802,
												PositionY = 867,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "142",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "link_Memory5_Panel_Level_Memory_list3_Panel_root_Panel-snowMemoryContent_iceSnowDay_activity_Game",
													UUID = "cc6da2a9_ee5f_4f92_9316_fd013e294f02",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0.5",
													backGroundScale9Enable = "False",
													classname = "MEImage",
													dstBlendFunc = "771",
													height = "109",
													ignoreSize = "True",
													name = "link",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "1",
													texturePath = "ui/activity/2020SnowDay/memory/chrimasBattle/002_1.png",
													touchAble = "False",
													UILayoutViewModel = 
													{
														PositionX = -1,
														PositionY = 90,
													},
													width = "52",
													ZOrder = "1",
												},
											},
										},
										{
											controlID = "Memory6_Panel_Level_Memory_list3_Panel_root_Panel-snowMemoryContent_iceSnowDay_activity_Game",
											UUID = "05d36a3e_a4a0_42a8_85d2_72a5b61c4c49",
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
											DiyPropertyViewModel = 
											{
												cfg_Id = "190124"
											},
											dstBlendFunc = "771",
											height = "142",
											ignoreSize = "False",
											name = "Memory6",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "True",
											UILayoutViewModel = 
											{
												PositionX = 1616,
												PositionY = 740,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "142",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "link_Memory6_Panel_Level_Memory_list3_Panel_root_Panel-snowMemoryContent_iceSnowDay_activity_Game",
													UUID = "aad94f06_1f5b_40ab_baad_db689bc0d707",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0.5",
													backGroundScale9Enable = "False",
													classname = "MEImage",
													dstBlendFunc = "771",
													height = "158",
													ignoreSize = "True",
													name = "link",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "1",
													texturePath = "ui/activity/2020SnowDay/memory/chrimasBattle/016_1.png",
													touchAble = "False",
													UILayoutViewModel = 
													{
														PositionX = 52,
														PositionY = 118,
													},
													width = "214",
													ZOrder = "1",
												},
											},
										},
										{
											controlID = "Memory7_Panel_Level_Memory_list3_Panel_root_Panel-snowMemoryContent_iceSnowDay_activity_Game",
											UUID = "1fd90314_a5fc_4bfa_8690_9337f79770cc",
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
											DiyPropertyViewModel = 
											{
												cfg_Id = "190123"
											},
											dstBlendFunc = "771",
											height = "142",
											ignoreSize = "False",
											name = "Memory7",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "True",
											UILayoutViewModel = 
											{
												PositionX = 1800,
												PositionY = 741,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "142",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "link_Memory7_Panel_Level_Memory_list3_Panel_root_Panel-snowMemoryContent_iceSnowDay_activity_Game",
													UUID = "3f944b1c_ee53_4e29_993a_c3715d7ab357",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0.5",
													backGroundScale9Enable = "False",
													classname = "MEImage",
													dstBlendFunc = "771",
													height = "54",
													ignoreSize = "True",
													name = "link",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "1",
													texturePath = "ui/activity/2020SnowDay/memory/chrimasBattle/004_1.png",
													touchAble = "False",
													UILayoutViewModel = 
													{
														PositionX = -90,
														PositionY = -2,
													},
													width = "116",
													ZOrder = "1",
												},
											},
										},
										{
											controlID = "Memory8_Panel_Level_Memory_list3_Panel_root_Panel-snowMemoryContent_iceSnowDay_activity_Game",
											UUID = "76be4700_da44_436f_99a8_068712dac0bc",
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
											DiyPropertyViewModel = 
											{
												cfg_Id = "190122"
											},
											dstBlendFunc = "771",
											height = "142",
											ignoreSize = "False",
											name = "Memory8",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "True",
											UILayoutViewModel = 
											{
												PositionX = 1982,
												PositionY = 741,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "142",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "link_Memory8_Panel_Level_Memory_list3_Panel_root_Panel-snowMemoryContent_iceSnowDay_activity_Game",
													UUID = "51b1fc14_2217_4916_8173_a42f2287015a",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0.5",
													backGroundScale9Enable = "False",
													classname = "MEImage",
													dstBlendFunc = "771",
													height = "54",
													ignoreSize = "True",
													name = "link",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "1",
													texturePath = "ui/activity/2020SnowDay/memory/chrimasBattle/004_1.png",
													touchAble = "False",
													UILayoutViewModel = 
													{
														PositionX = -88,
													},
													width = "116",
													ZOrder = "1",
												},
											},
										},
										{
											controlID = "Memory9_Panel_Level_Memory_list3_Panel_root_Panel-snowMemoryContent_iceSnowDay_activity_Game",
											UUID = "f8cb6f53_0fa5_4f93_8eca_c800784aecd5",
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
											DiyPropertyViewModel = 
											{
												cfg_Id = "190121"
											},
											dstBlendFunc = "771",
											height = "142",
											ignoreSize = "False",
											name = "Memory9",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "True",
											UILayoutViewModel = 
											{
												PositionX = 1305,
												PositionY = 542,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "142",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "link_Memory9_Panel_Level_Memory_list3_Panel_root_Panel-snowMemoryContent_iceSnowDay_activity_Game",
													UUID = "84e10034_5f46_45e1_93b5_6492b60af8e6",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0.5",
													backGroundScale9Enable = "False",
													classname = "MEImage",
													dstBlendFunc = "771",
													height = "313",
													ignoreSize = "True",
													name = "link",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "1",
													texturePath = "ui/activity/2020SnowDay/memory/chrimasBattle/014_1.png",
													touchAble = "False",
													UILayoutViewModel = 
													{
														PositionX = -138,
														PositionY = 109,
													},
													width = "210",
													ZOrder = "1",
												},
											},
										},
										{
											controlID = "Memory10_Panel_Level_Memory_list3_Panel_root_Panel-snowMemoryContent_iceSnowDay_activity_Game",
											UUID = "bbcbc316_f83d_4240_9ce2_89f8b98a3903",
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
											DiyPropertyViewModel = 
											{
												cfg_Id = "190120"
											},
											dstBlendFunc = "771",
											height = "142",
											ignoreSize = "False",
											name = "Memory10",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "True",
											UILayoutViewModel = 
											{
												PositionX = 1557,
												PositionY = 545,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "142",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "link_Memory10_Panel_Level_Memory_list3_Panel_root_Panel-snowMemoryContent_iceSnowDay_activity_Game",
													UUID = "d36eda5f_28a6_4627_8a82_22c85a0cd576",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0.5",
													backGroundScale9Enable = "False",
													classname = "MEImage",
													dstBlendFunc = "771",
													height = "52",
													ignoreSize = "True",
													name = "link",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "1",
													texturePath = "ui/activity/2020SnowDay/memory/chrimasBattle/001_1.png",
													touchAble = "False",
													UILayoutViewModel = 
													{
														PositionX = -129,
														PositionY = -1,
													},
													width = "187",
													ZOrder = "1",
												},
											},
										},
										{
											controlID = "Memory11_Panel_Level_Memory_list3_Panel_root_Panel-snowMemoryContent_iceSnowDay_activity_Game",
											UUID = "7bb576bf_b51e_48b8_b162_988528490108",
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
											DiyPropertyViewModel = 
											{
												cfg_Id = "190119"
											},
											dstBlendFunc = "771",
											height = "142",
											ignoreSize = "False",
											name = "Memory11",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "True",
											UILayoutViewModel = 
											{
												PositionX = 1557,
												PositionY = 355,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "142",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "link_Memory11_Panel_Level_Memory_list3_Panel_root_Panel-snowMemoryContent_iceSnowDay_activity_Game",
													UUID = "2f651366_f9b9_46a4_b5d8_c48a4263d16a",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0.5",
													backGroundScale9Enable = "False",
													classname = "MEImage",
													dstBlendFunc = "771",
													height = "109",
													ignoreSize = "True",
													name = "link",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "1",
													texturePath = "ui/activity/2020SnowDay/memory/chrimasBattle/002_1.png",
													touchAble = "False",
													UILayoutViewModel = 
													{
														PositionX = 1,
														PositionY = 91,
													},
													width = "52",
													ZOrder = "1",
												},
											},
										},
										{
											controlID = "Memory12_Panel_Level_Memory_list3_Panel_root_Panel-snowMemoryContent_iceSnowDay_activity_Game",
											UUID = "dc05df0b_ea9f_4c26_9712_8c457860de82",
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
											DiyPropertyViewModel = 
											{
												cfg_Id = "190118"
											},
											dstBlendFunc = "771",
											height = "142",
											ignoreSize = "False",
											name = "Memory12",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "True",
											UILayoutViewModel = 
											{
												PositionX = 1377,
												PositionY = 353,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "142",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "link_Memory12_Panel_Level_Memory_list3_Panel_root_Panel-snowMemoryContent_iceSnowDay_activity_Game",
													UUID = "e293f8f2_bfa1_4149_8388_c8bcc172b9e8",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0.5",
													backGroundScale9Enable = "False",
													classname = "MEImage",
													dstBlendFunc = "771",
													height = "54",
													ignoreSize = "True",
													name = "link",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "1",
													texturePath = "ui/activity/2020SnowDay/memory/chrimasBattle/004_1.png",
													touchAble = "False",
													UILayoutViewModel = 
													{
														PositionX = 85,
													},
													width = "116",
													ZOrder = "1",
												},
											},
										},
										{
											controlID = "Memory13_Panel_Level_Memory_list3_Panel_root_Panel-snowMemoryContent_iceSnowDay_activity_Game",
											UUID = "00e02051_77a9_41ca_a875_70aea89388c5",
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
											DiyPropertyViewModel = 
											{
												cfg_Id = "190117"
											},
											dstBlendFunc = "771",
											height = "142",
											ignoreSize = "False",
											name = "Memory13",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "True",
											UILayoutViewModel = 
											{
												PositionX = 1194,
												PositionY = 353,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "142",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "link_Memory13_Panel_Level_Memory_list3_Panel_root_Panel-snowMemoryContent_iceSnowDay_activity_Game",
													UUID = "19568ad0_fe5a_4389_9fa1_4b32bf2f531e",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0.5",
													backGroundScale9Enable = "False",
													classname = "MEImage",
													dstBlendFunc = "771",
													height = "54",
													ignoreSize = "True",
													name = "link",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "1",
													texturePath = "ui/activity/2020SnowDay/memory/chrimasBattle/004_1.png",
													touchAble = "False",
													UILayoutViewModel = 
													{
														PositionX = 92,
													},
													width = "116",
													ZOrder = "1",
												},
											},
										},
										{
											controlID = "Memory14_Panel_Level_Memory_list3_Panel_root_Panel-snowMemoryContent_iceSnowDay_activity_Game",
											UUID = "03e54e93_3ae3_4e22_80a9_66e53e9459b1",
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
											DiyPropertyViewModel = 
											{
												cfg_Id = "190116"
											},
											dstBlendFunc = "771",
											height = "142",
											ignoreSize = "False",
											name = "Memory14",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "True",
											UILayoutViewModel = 
											{
												PositionX = 1194,
												PositionY = 160,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "142",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "link_Memory14_Panel_Level_Memory_list3_Panel_root_Panel-snowMemoryContent_iceSnowDay_activity_Game",
													UUID = "e4b9fcea_cc43_45a8_8c84_1240eec70254",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0.5",
													backGroundScale9Enable = "False",
													classname = "MEImage",
													dstBlendFunc = "771",
													height = "109",
													ignoreSize = "True",
													name = "link",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "1",
													texturePath = "ui/activity/2020SnowDay/memory/chrimasBattle/002_1.png",
													touchAble = "False",
													UILayoutViewModel = 
													{
														PositionX = -1,
														PositionY = 98,
													},
													width = "52",
													ZOrder = "1",
												},
											},
										},
										{
											controlID = "Memory15_Panel_Level_Memory_list3_Panel_root_Panel-snowMemoryContent_iceSnowDay_activity_Game",
											UUID = "859f0c1f_1fda_4cd1_871a_5a8d2ddbd151",
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
											DiyPropertyViewModel = 
											{
												cfg_Id = "190115"
											},
											dstBlendFunc = "771",
											height = "142",
											ignoreSize = "False",
											name = "Memory15",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "True",
											UILayoutViewModel = 
											{
												PositionX = 1442,
												PositionY = 161,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "142",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "link_Memory15_Panel_Level_Memory_list3_Panel_root_Panel-snowMemoryContent_iceSnowDay_activity_Game",
													UUID = "eb552cbb_c302_4e6c_988e_835bcb88581b",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0.5",
													backGroundScale9Enable = "False",
													classname = "MEImage",
													dstBlendFunc = "771",
													height = "52",
													ignoreSize = "True",
													name = "link",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "1",
													texturePath = "ui/activity/2020SnowDay/memory/chrimasBattle/001_1.png",
													touchAble = "False",
													UILayoutViewModel = 
													{
														PositionX = -119,
													},
													width = "187",
													ZOrder = "1",
												},
											},
										},
										{
											controlID = "Memory16_Panel_Level_Memory_list3_Panel_root_Panel-snowMemoryContent_iceSnowDay_activity_Game",
											UUID = "7f59eac9_3b92_4a1d_8344_5c9ca53ace41",
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
											DiyPropertyViewModel = 
											{
												cfg_Id = "190114"
											},
											dstBlendFunc = "771",
											height = "142",
											ignoreSize = "False",
											name = "Memory16",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "True",
											UILayoutViewModel = 
											{
												PositionX = 983,
												PositionY = 528,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "142",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "link_Memory16_Panel_Level_Memory_list3_Panel_root_Panel-snowMemoryContent_iceSnowDay_activity_Game",
													UUID = "04ea10dc_be16_4c78_8bc4_b74164ffc17d",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0.5",
													backGroundScale9Enable = "False",
													classname = "MEImage",
													dstBlendFunc = "771",
													height = "276",
													ignoreSize = "True",
													name = "link",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "1",
													texturePath = "ui/activity/2020SnowDay/memory/chrimasBattle/009_1.png",
													touchAble = "False",
													UILayoutViewModel = 
													{
														PositionX = 28,
														PositionY = 181,
													},
													width = "107",
													ZOrder = "1",
												},
											},
										},
										{
											controlID = "Memory17_Panel_Level_Memory_list3_Panel_root_Panel-snowMemoryContent_iceSnowDay_activity_Game",
											UUID = "7b045462_e841_4263_b65e_507f14039a94",
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
											DiyPropertyViewModel = 
											{
												cfg_Id = "190113"
											},
											dstBlendFunc = "771",
											height = "142",
											ignoreSize = "False",
											name = "Memory17",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "True",
											UILayoutViewModel = 
											{
												PositionX = 982,
												PositionY = 332,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "142",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "link_Memory17_Panel_Level_Memory_list3_Panel_root_Panel-snowMemoryContent_iceSnowDay_activity_Game",
													UUID = "3be51ae8_ffee_4226_a9d9_58aca10f5262",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0.5",
													backGroundScale9Enable = "False",
													classname = "MEImage",
													dstBlendFunc = "771",
													height = "109",
													ignoreSize = "True",
													name = "link",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "1",
													texturePath = "ui/activity/2020SnowDay/memory/chrimasBattle/002_1.png",
													touchAble = "False",
													UILayoutViewModel = 
													{
														PositionX = -1,
														PositionY = 97,
													},
													width = "52",
													ZOrder = "1",
												},
											},
										},
										{
											controlID = "Memory18_Panel_Level_Memory_list3_Panel_root_Panel-snowMemoryContent_iceSnowDay_activity_Game",
											UUID = "db961979_c496_454a_80ef_f48cd94873dd",
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
											DiyPropertyViewModel = 
											{
												cfg_Id = "190112"
											},
											dstBlendFunc = "771",
											height = "142",
											ignoreSize = "False",
											name = "Memory18",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "True",
											UILayoutViewModel = 
											{
												PositionX = 820,
												PositionY = 155,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "142",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "link_Memory18_Panel_Level_Memory_list3_Panel_root_Panel-snowMemoryContent_iceSnowDay_activity_Game",
													UUID = "727e93ee_b25a_424a_b339_a71539976412",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0.5",
													backGroundScale9Enable = "False",
													classname = "MEImage",
													dstBlendFunc = "771",
													height = "189",
													ignoreSize = "True",
													name = "link",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "1",
													texturePath = "ui/activity/2020SnowDay/memory/chrimasBattle/017_1.png",
													touchAble = "False",
													UILayoutViewModel = 
													{
														PositionX = 109,
														PositionY = 38,
													},
													width = "158",
													ZOrder = "1",
												},
											},
										},
										{
											controlID = "Memory19_Panel_Level_Memory_list3_Panel_root_Panel-snowMemoryContent_iceSnowDay_activity_Game",
											UUID = "63485fa0_b9e5_4518_ba9b_591dd26f528b",
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
											DiyPropertyViewModel = 
											{
												cfg_Id = "190111"
											},
											dstBlendFunc = "771",
											height = "142",
											ignoreSize = "False",
											name = "Memory19",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "True",
											UILayoutViewModel = 
											{
												PositionX = 817,
												PositionY = 295,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "142",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "link_Memory19_Panel_Level_Memory_list3_Panel_root_Panel-snowMemoryContent_iceSnowDay_activity_Game",
													UUID = "68611139_37f9_44f6_ac4c_d639225b5a3f",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0.5",
													backGroundScale9Enable = "False",
													classname = "MEImage",
													dstBlendFunc = "771",
													height = "73",
													ignoreSize = "True",
													name = "link",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "1",
													texturePath = "ui/activity/2020SnowDay/memory/chrimasBattle/005_1.png",
													touchAble = "False",
													UILayoutViewModel = 
													{
														PositionX = 1,
														PositionY = -70,
													},
													width = "54",
													ZOrder = "1",
												},
											},
										},
										{
											controlID = "Memory20_Panel_Level_Memory_list3_Panel_root_Panel-snowMemoryContent_iceSnowDay_activity_Game",
											UUID = "eb8ff83b_fd69_4466_a57a_d2cd47cdd0ab",
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
											DiyPropertyViewModel = 
											{
												cfg_Id = "190110"
											},
											dstBlendFunc = "771",
											height = "142",
											ignoreSize = "False",
											name = "Memory20",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "True",
											UILayoutViewModel = 
											{
												PositionX = 818,
												PositionY = 433,
												LeftPositon = 1848,
												TopPosition = 1462,
												relativeToName = "Panel_root",
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "142",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "link_Memory20_Panel_Level_Memory_list3_Panel_root_Panel-snowMemoryContent_iceSnowDay_activity_Game",
													UUID = "b2353d7c_e627_431e_91ff_562d726157f6",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0.5",
													backGroundScale9Enable = "False",
													classname = "MEImage",
													dstBlendFunc = "771",
													height = "73",
													ignoreSize = "True",
													name = "link",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "1",
													texturePath = "ui/activity/2020SnowDay/memory/chrimasBattle/005_1.png",
													touchAble = "False",
													UILayoutViewModel = 
													{
														PositionX = -1,
														PositionY = -70,
													},
													width = "54",
													ZOrder = "1",
												},
											},
										},
										{
											controlID = "Memory21_Panel_Level_Memory_list3_Panel_root_Panel-snowMemoryContent_iceSnowDay_activity_Game",
											UUID = "ee79014b_0ec3_42c1_9e64_d7d5fc1577d6",
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
											DiyPropertyViewModel = 
											{
												cfg_Id = "190109"
											},
											dstBlendFunc = "771",
											height = "142",
											ignoreSize = "False",
											name = "Memory21",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "True",
											UILayoutViewModel = 
											{
												PositionX = 634,
												PositionY = 439,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "142",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "link_Memory21_Panel_Level_Memory_list3_Panel_root_Panel-snowMemoryContent_iceSnowDay_activity_Game",
													UUID = "5ceff716_6e69_4c18_9a92_218d4b9cda92",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0.5",
													backGroundScale9Enable = "False",
													classname = "MEImage",
													dstBlendFunc = "771",
													height = "54",
													ignoreSize = "True",
													name = "link",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "1",
													texturePath = "ui/activity/2020SnowDay/memory/chrimasBattle/004_1.png",
													touchAble = "False",
													UILayoutViewModel = 
													{
														PositionX = 92,
													},
													width = "116",
													ZOrder = "1",
												},
											},
										},
										{
											controlID = "Memory22_Panel_Level_Memory_list3_Panel_root_Panel-snowMemoryContent_iceSnowDay_activity_Game",
											UUID = "8a9c2338_9322_46d8_bfe6_b0132504c809",
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
											DiyPropertyViewModel = 
											{
												cfg_Id = "190108"
											},
											dstBlendFunc = "771",
											height = "142",
											ignoreSize = "False",
											name = "Memory22",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "True",
											UILayoutViewModel = 
											{
												PositionX = 636,
												PositionY = 233,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "142",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "link_Memory22_Panel_Level_Memory_list3_Panel_root_Panel-snowMemoryContent_iceSnowDay_activity_Game",
													UUID = "85a168bf_3e9b_4820_b73a_12b43937efb9",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0.5",
													backGroundScale9Enable = "False",
													classname = "MEImage",
													dstBlendFunc = "771",
													height = "137",
													ignoreSize = "True",
													name = "link",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "1",
													texturePath = "ui/activity/2020SnowDay/memory/chrimasBattle/006_1.png",
													touchAble = "False",
													UILayoutViewModel = 
													{
														PositionX = -2,
														PositionY = 100,
													},
													width = "54",
													ZOrder = "1",
												},
											},
										},
										{
											controlID = "Memory23_Panel_Level_Memory_list3_Panel_root_Panel-snowMemoryContent_iceSnowDay_activity_Game",
											UUID = "d2ac9728_f2a7_401c_aa4e_e1b754b2d9b3",
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
											DiyPropertyViewModel = 
											{
												cfg_Id = "190107"
											},
											dstBlendFunc = "771",
											height = "142",
											ignoreSize = "False",
											name = "Memory23",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "True",
											UILayoutViewModel = 
											{
												PositionX = 761,
												PositionY = 870,
												LeftPositon = 1795,
												TopPosition = 1053,
												relativeToName = "Panel_root",
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "142",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "link_Memory23_Panel_Level_Memory_list3_Panel_root_Panel-snowMemoryContent_iceSnowDay_activity_Game",
													UUID = "015b96e2_8e5e_4c45_b309_74174fc48b58",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0.5",
													backGroundScale9Enable = "False",
													classname = "MEImage",
													dstBlendFunc = "771",
													height = "95",
													ignoreSize = "True",
													name = "link",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "1",
													texturePath = "ui/activity/2020SnowDay/memory/chrimasBattle/010_1.png",
													touchAble = "False",
													UILayoutViewModel = 
													{
														PositionX = 167,
														PositionY = 23,
													},
													width = "276",
													ZOrder = "1",
												},
											},
										},
										{
											controlID = "Memory24_Panel_Level_Memory_list3_Panel_root_Panel-snowMemoryContent_iceSnowDay_activity_Game",
											UUID = "f7bc9daf_8f8b_4752_b011_63bc0ff35c0d",
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
											DiyPropertyViewModel = 
											{
												cfg_Id = "190106"
											},
											dstBlendFunc = "771",
											height = "142",
											ignoreSize = "False",
											name = "Memory24",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "True",
											UILayoutViewModel = 
											{
												PositionX = 603,
												PositionY = 681,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "142",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "link_Memory24_Panel_Level_Memory_list3_Panel_root_Panel-snowMemoryContent_iceSnowDay_activity_Game",
													UUID = "e0b61686_dc48_43e4_b72e_76b93918ee57",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0.5",
													backGroundScale9Enable = "False",
													classname = "MEImage",
													dstBlendFunc = "771",
													height = "179",
													ignoreSize = "True",
													name = "link",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "1",
													texturePath = "ui/activity/2020SnowDay/memory/chrimasBattle/013_1.png",
													touchAble = "False",
													UILayoutViewModel = 
													{
														PositionX = 110,
														PositionY = 46,
													},
													width = "155",
													ZOrder = "1",
												},
											},
										},
										{
											controlID = "Memory25_Panel_Level_Memory_list3_Panel_root_Panel-snowMemoryContent_iceSnowDay_activity_Game",
											UUID = "b7d8bbf3_0a5d_4617_abb2_34e1bbd27b83",
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
											DiyPropertyViewModel = 
											{
												cfg_Id = "190105"
											},
											dstBlendFunc = "771",
											height = "142",
											ignoreSize = "False",
											name = "Memory25",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "True",
											UILayoutViewModel = 
											{
												PositionX = 423,
												PositionY = 680,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "142",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "link_Memory25_Panel_Level_Memory_list3_Panel_root_Panel-snowMemoryContent_iceSnowDay_activity_Game",
													UUID = "4077ff41_20c2_48f6_828d_229be48562c8",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0.5",
													backGroundScale9Enable = "False",
													classname = "MEImage",
													dstBlendFunc = "771",
													height = "54",
													ignoreSize = "True",
													name = "link",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "1",
													texturePath = "ui/activity/2020SnowDay/memory/chrimasBattle/004_1.png",
													touchAble = "False",
													UILayoutViewModel = 
													{
														PositionX = 89,
													},
													width = "116",
													ZOrder = "1",
												},
											},
										},
										{
											controlID = "Memory26_Panel_Level_Memory_list3_Panel_root_Panel-snowMemoryContent_iceSnowDay_activity_Game",
											UUID = "b7e6d68f_c400_40e9_8286_17a30457f882",
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
											DiyPropertyViewModel = 
											{
												cfg_Id = "190104"
											},
											dstBlendFunc = "771",
											height = "142",
											ignoreSize = "False",
											name = "Memory26",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "True",
											UILayoutViewModel = 
											{
												PositionX = 424,
												PositionY = 859,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "142",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "link_Memory26_Panel_Level_Memory_list3_Panel_root_Panel-snowMemoryContent_iceSnowDay_activity_Game",
													UUID = "963eb9a5_01cb_4d72_8ae0_29c561ceae67",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0.5",
													backGroundScale9Enable = "False",
													classname = "MEImage",
													dstBlendFunc = "771",
													height = "109",
													ignoreSize = "True",
													name = "link",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "1",
													texturePath = "ui/activity/2020SnowDay/memory/chrimasBattle/002_1.png",
													touchAble = "False",
													UILayoutViewModel = 
													{
														PositionX = -1,
														PositionY = -90,
													},
													width = "52",
													ZOrder = "1",
												},
											},
										},
										{
											controlID = "Memory27_Panel_Level_Memory_list3_Panel_root_Panel-snowMemoryContent_iceSnowDay_activity_Game",
											UUID = "db2aa745_5a30_47dd_8b43_58e93da35d66",
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
											DiyPropertyViewModel = 
											{
												cfg_Id = "190103"
											},
											dstBlendFunc = "771",
											height = "142",
											ignoreSize = "False",
											name = "Memory27",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "True",
											UILayoutViewModel = 
											{
												PositionX = 613,
												PositionY = 986,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "142",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "link_Memory27_Panel_Level_Memory_list3_Panel_root_Panel-snowMemoryContent_iceSnowDay_activity_Game",
													UUID = "a868ce59_83fc_4891_af31_014b275b29e5",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0.5",
													backGroundScale9Enable = "False",
													classname = "MEImage",
													dstBlendFunc = "771",
													height = "115",
													ignoreSize = "True",
													name = "link",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "1",
													texturePath = "ui/activity/2020SnowDay/memory/chrimasBattle/012_1.png",
													touchAble = "False",
													UILayoutViewModel = 
													{
														PositionX = -65,
														PositionY = -98,
													},
													width = "183",
													ZOrder = "1",
												},
											},
										},
										{
											controlID = "Memory28_Panel_Level_Memory_list3_Panel_root_Panel-snowMemoryContent_iceSnowDay_activity_Game",
											UUID = "ef15a0ba_63b5_43ba_8c69_f177c38e014e",
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
											DiyPropertyViewModel = 
											{
												cfg_Id = "190102"
											},
											dstBlendFunc = "771",
											height = "142",
											ignoreSize = "False",
											name = "Memory28",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "True",
											UILayoutViewModel = 
											{
												PositionX = 428,
												PositionY = 989,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "142",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "link_Memory28_Panel_Level_Memory_list3_Panel_root_Panel-snowMemoryContent_iceSnowDay_activity_Game",
													UUID = "87e4ec4b_8de5_4c6d_9e1b_4316c8b9a7b2",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0.5",
													backGroundScale9Enable = "False",
													classname = "MEImage",
													dstBlendFunc = "771",
													height = "54",
													ignoreSize = "True",
													name = "link",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "1",
													texturePath = "ui/activity/2020SnowDay/memory/chrimasBattle/004_1.png",
													touchAble = "False",
													UILayoutViewModel = 
													{
														PositionX = 91,
														PositionY = 2,
													},
													width = "116",
													ZOrder = "1",
												},
											},
										},
										{
											controlID = "Memory29_Panel_Level_Memory_list3_Panel_root_Panel-snowMemoryContent_iceSnowDay_activity_Game",
											UUID = "caa1eb26_b23a_4454_af31_8553abb2cf1b",
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
											DiyPropertyViewModel = 
											{
												cfg_Id = "190101"
											},
											dstBlendFunc = "771",
											height = "142",
											ignoreSize = "False",
											name = "Memory29",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "True",
											UILayoutViewModel = 
											{
												PositionX = 250,
												PositionY = 992,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "142",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "link_Memory29_Panel_Level_Memory_list3_Panel_root_Panel-snowMemoryContent_iceSnowDay_activity_Game",
													UUID = "2fe41a3e_dad4_420f_8824_7e982b8e83c7",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0.5",
													backGroundScale9Enable = "False",
													classname = "MEImage",
													dstBlendFunc = "771",
													height = "54",
													ignoreSize = "True",
													name = "link",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "1",
													texturePath = "ui/activity/2020SnowDay/memory/chrimasBattle/004_1.png",
													touchAble = "False",
													UILayoutViewModel = 
													{
														PositionX = 88,
														PositionY = -1,
													},
													width = "116",
													ZOrder = "1",
												},
											},
										},
										{
											controlID = "Memory30_Panel_Level_Memory_list3_Panel_root_Panel-snowMemoryContent_iceSnowDay_activity_Game",
											UUID = "294abbe7_25a2_4bbd_a0f0_1f5debbb1c01",
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
											DiyPropertyViewModel = 
											{
												cfg_Id = "190142"
											},
											dstBlendFunc = "771",
											height = "142",
											ignoreSize = "False",
											name = "Memory30",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "True",
											UILayoutViewModel = 
											{
												PositionX = 921,
												PositionY = 1199,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "142",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "link_Memory30_Panel_Level_Memory_list3_Panel_root_Panel-snowMemoryContent_iceSnowDay_activity_Game",
													UUID = "d5c43062_80ad_413e_86bf_6dd70564882f",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0.5",
													backGroundScale9Enable = "False",
													classname = "MEImage",
													dstBlendFunc = "771",
													height = "355",
													ignoreSize = "True",
													name = "link",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "1",
													texturePath = "ui/activity/2020SnowDay/memory/chrimasBattle/007_1.png",
													touchAble = "False",
													UILayoutViewModel = 
													{
														PositionX = 126,
														PositionY = -89,
													},
													width = "185",
													ZOrder = "1",
												},
											},
										},
										{
											controlID = "Memory31_Panel_Level_Memory_list3_Panel_root_Panel-snowMemoryContent_iceSnowDay_activity_Game",
											UUID = "529152e8_5a58_4f4c_bcde_9127fb03cffc",
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
											DiyPropertyViewModel = 
											{
												cfg_Id = "190141"
											},
											dstBlendFunc = "771",
											height = "142",
											ignoreSize = "False",
											name = "Memory31",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "True",
											UILayoutViewModel = 
											{
												PositionX = 668,
												PositionY = 1202,
												LeftPositon = 1701,
												TopPosition = 720,
												relativeToName = "Panel_root",
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "142",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "link_Memory31_Panel_Level_Memory_list3_Panel_root_Panel-snowMemoryContent_iceSnowDay_activity_Game",
													UUID = "c829c963_ac34_411c_aa8a_c52836224ac8",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0.5",
													backGroundScale9Enable = "False",
													classname = "MEImage",
													dstBlendFunc = "771",
													height = "52",
													ignoreSize = "True",
													name = "link",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "1",
													texturePath = "ui/activity/2020SnowDay/memory/chrimasBattle/001_1.png",
													touchAble = "False",
													UILayoutViewModel = 
													{
														PositionX = 126,
														PositionY = -3,
													},
													width = "187",
													ZOrder = "1",
												},
											},
										},
										{
											controlID = "Memory32_Panel_Level_Memory_list3_Panel_root_Panel-snowMemoryContent_iceSnowDay_activity_Game",
											UUID = "513b098e_e2c7_4cf0_acf4_4a1c3fcb90f1",
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
											DiyPropertyViewModel = 
											{
												cfg_Id = "190140"
											},
											dstBlendFunc = "771",
											height = "142",
											ignoreSize = "False",
											name = "Memory32",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "True",
											UILayoutViewModel = 
											{
												PositionX = 668,
												PositionY = 1390,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "142",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "link_Memory32_Panel_Level_Memory_list3_Panel_root_Panel-snowMemoryContent_iceSnowDay_activity_Game",
													UUID = "9dc28436_1ba8_49c2_a81b_0ebe78378b35",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0.5",
													backGroundScale9Enable = "False",
													classname = "MEImage",
													dstBlendFunc = "771",
													height = "109",
													ignoreSize = "True",
													name = "link",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "1",
													texturePath = "ui/activity/2020SnowDay/memory/chrimasBattle/002_1.png",
													touchAble = "False",
													UILayoutViewModel = 
													{
														PositionY = -92,
													},
													width = "52",
													ZOrder = "1",
												},
											},
										},
										{
											controlID = "Memory33_Panel_Level_Memory_list3_Panel_root_Panel-snowMemoryContent_iceSnowDay_activity_Game",
											UUID = "8d4c0ff4_9b3e_4353_aadf_67f01f84c760",
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
											DiyPropertyViewModel = 
											{
												cfg_Id = "190139"
											},
											dstBlendFunc = "771",
											height = "142",
											ignoreSize = "False",
											name = "Memory33",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "True",
											UILayoutViewModel = 
											{
												PositionX = 842,
												PositionY = 1392,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "142",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "link_Memory33_Panel_Level_Memory_list3_Panel_root_Panel-snowMemoryContent_iceSnowDay_activity_Game",
													UUID = "c105718b_02fe_4a06_858f_91a322977e40",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0.5",
													backGroundScale9Enable = "False",
													classname = "MEImage",
													dstBlendFunc = "771",
													height = "54",
													ignoreSize = "True",
													name = "link",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "1",
													texturePath = "ui/activity/2020SnowDay/memory/chrimasBattle/004_1.png",
													touchAble = "False",
													UILayoutViewModel = 
													{
														PositionX = -85,
													},
													width = "116",
													ZOrder = "1",
												},
											},
										},
										{
											controlID = "Memory34_Panel_Level_Memory_list3_Panel_root_Panel-snowMemoryContent_iceSnowDay_activity_Game",
											UUID = "119b090d_ed7d_4296_902f_58e9ddc0b386",
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
											DiyPropertyViewModel = 
											{
												cfg_Id = "190138"
											},
											dstBlendFunc = "771",
											height = "142",
											ignoreSize = "False",
											name = "Memory34",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "True",
											UILayoutViewModel = 
											{
												PositionX = 1020,
												PositionY = 1396,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "142",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "link_Memory34_Panel_Level_Memory_list3_Panel_root_Panel-snowMemoryContent_iceSnowDay_activity_Game",
													UUID = "e8b657ef_cdd1_4773_812e_51e44a9b8d40",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0.5",
													backGroundScale9Enable = "False",
													classname = "MEImage",
													dstBlendFunc = "771",
													height = "54",
													ignoreSize = "True",
													name = "link",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "1",
													texturePath = "ui/activity/2020SnowDay/memory/chrimasBattle/004_1.png",
													touchAble = "False",
													UILayoutViewModel = 
													{
														PositionX = -88,
														PositionY = -4,
													},
													width = "116",
													ZOrder = "1",
												},
											},
										},
										{
											controlID = "Memory35_Panel_Level_Memory_list3_Panel_root_Panel-snowMemoryContent_iceSnowDay_activity_Game",
											UUID = "318e1824_8886_496b_af31_ffc8d2341d8f",
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
											DiyPropertyViewModel = 
											{
												cfg_Id = "190137"
											},
											dstBlendFunc = "771",
											height = "142",
											ignoreSize = "False",
											name = "Memory35",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "True",
											UILayoutViewModel = 
											{
												PositionX = 1021,
												PositionY = 1585,
												LeftPositon = 2052,
												TopPosition = 339,
												relativeToName = "Panel_root",
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "142",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "link_Memory35_Panel_Level_Memory_list3_Panel_root_Panel-snowMemoryContent_iceSnowDay_activity_Game",
													UUID = "e9185ee2_b3a7_4f41_834d_e2113b22a451",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0.5",
													backGroundScale9Enable = "False",
													classname = "MEImage",
													dstBlendFunc = "771",
													height = "109",
													ignoreSize = "True",
													name = "link",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "1",
													texturePath = "ui/activity/2020SnowDay/memory/chrimasBattle/002_1.png",
													touchAble = "False",
													UILayoutViewModel = 
													{
														PositionX = 1,
														PositionY = -94,
													},
													width = "52",
													ZOrder = "1",
												},
											},
										},
										{
											controlID = "Memory36_Panel_Level_Memory_list3_Panel_root_Panel-snowMemoryContent_iceSnowDay_activity_Game",
											UUID = "c72ec48e_c97e_433f_a291_371ef4111d97",
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
											DiyPropertyViewModel = 
											{
												cfg_Id = "190136"
											},
											dstBlendFunc = "771",
											height = "142",
											ignoreSize = "False",
											name = "Memory36",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "True",
											UILayoutViewModel = 
											{
												PositionX = 773,
												PositionY = 1581,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "142",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "link_Memory36_Panel_Level_Memory_list3_Panel_root_Panel-snowMemoryContent_iceSnowDay_activity_Game",
													UUID = "7d15eaf9_98f2_40fd_95de_1f5bc06c5f0d",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0.5",
													backGroundScale9Enable = "False",
													classname = "MEImage",
													dstBlendFunc = "771",
													height = "52",
													ignoreSize = "True",
													name = "link",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "1",
													texturePath = "ui/activity/2020SnowDay/memory/chrimasBattle/001_1.png",
													touchAble = "False",
													UILayoutViewModel = 
													{
														PositionX = 119,
													},
													width = "187",
													ZOrder = "1",
												},
											},
										},
										{
											controlID = "Memory37_Panel_Level_Memory_list3_Panel_root_Panel-snowMemoryContent_iceSnowDay_activity_Game",
											UUID = "765a1b72_8a01_4122_89f4_a1c0a7052258",
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
											DiyPropertyViewModel = 
											{
												cfg_Id = "190135"
											},
											dstBlendFunc = "771",
											height = "142",
											ignoreSize = "False",
											name = "Memory37",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "True",
											UILayoutViewModel = 
											{
												PositionX = 1237,
												PositionY = 1207,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "142",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "link_Memory37_Panel_Level_Memory_list3_Panel_root_Panel-snowMemoryContent_iceSnowDay_activity_Game",
													UUID = "43a9bdc0_7440_48f6_ab5c_041b90e92f25",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0.5",
													backGroundScale9Enable = "False",
													classname = "MEImage",
													dstBlendFunc = "771",
													height = "276",
													ignoreSize = "True",
													name = "link",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "1",
													texturePath = "ui/activity/2020SnowDay/memory/chrimasBattle/008_1.png",
													touchAble = "False",
													UILayoutViewModel = 
													{
														PositionX = -27,
														PositionY = -177,
													},
													width = "107",
													ZOrder = "1",
												},
											},
										},
										{
											controlID = "Memory38_Panel_Level_Memory_list3_Panel_root_Panel-snowMemoryContent_iceSnowDay_activity_Game",
											UUID = "d9c7e1fa_a26b_4649_bb69_000bb2f69e92",
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
											DiyPropertyViewModel = 
											{
												cfg_Id = "190134"
											},
											dstBlendFunc = "771",
											height = "142",
											ignoreSize = "False",
											name = "Memory38",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "True",
											UILayoutViewModel = 
											{
												PositionX = 1236,
												PositionY = 1399,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "142",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "link_Memory38_Panel_Level_Memory_list3_Panel_root_Panel-snowMemoryContent_iceSnowDay_activity_Game",
													UUID = "c1041bda_312e_42e8_8173_349a1b18fbfd",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0.5",
													backGroundScale9Enable = "False",
													classname = "MEImage",
													dstBlendFunc = "771",
													height = "109",
													ignoreSize = "True",
													name = "link",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "1",
													texturePath = "ui/activity/2020SnowDay/memory/chrimasBattle/002_1.png",
													touchAble = "False",
													UILayoutViewModel = 
													{
														PositionY = -93,
													},
													width = "52",
													ZOrder = "1",
												},
											},
										},
										{
											controlID = "Memory39_Panel_Level_Memory_list3_Panel_root_Panel-snowMemoryContent_iceSnowDay_activity_Game",
											UUID = "0f98a637_b4d8_4bbf_b2db_7bfdb4479468",
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
											DiyPropertyViewModel = 
											{
												cfg_Id = "190133"
											},
											dstBlendFunc = "771",
											height = "142",
											ignoreSize = "False",
											name = "Memory39",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "True",
											UILayoutViewModel = 
											{
												PositionX = 1397,
												PositionY = 1587,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "142",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "link_Memory39_Panel_Level_Memory_list3_Panel_root_Panel-snowMemoryContent_iceSnowDay_activity_Game",
													UUID = "53deca3b_960d_41ae_b4c2_84107807ec0e",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0.5",
													backGroundScale9Enable = "False",
													classname = "MEImage",
													dstBlendFunc = "771",
													height = "207",
													ignoreSize = "True",
													name = "link",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "1",
													texturePath = "ui/activity/2020SnowDay/memory/chrimasBattle/018_1.png",
													touchAble = "False",
													UILayoutViewModel = 
													{
														PositionX = -109,
														PositionY = -37,
													},
													width = "155",
													ZOrder = "1",
												},
											},
										},
										{
											controlID = "Memory40_Panel_Level_Memory_list3_Panel_root_Panel-snowMemoryContent_iceSnowDay_activity_Game",
											UUID = "1355c674_037f_43d8_ac9d_d868bd9c9fe5",
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
											DiyPropertyViewModel = 
											{
												cfg_Id = "190132"
											},
											dstBlendFunc = "771",
											height = "142",
											ignoreSize = "False",
											name = "Memory40",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "True",
											UILayoutViewModel = 
											{
												PositionX = 1397,
												PositionY = 1449,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "142",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "link_Memory40_Panel_Level_Memory_list3_Panel_root_Panel-snowMemoryContent_iceSnowDay_activity_Game",
													UUID = "e14f9a8c_2c88_426d_b3a8_4a509caff6f1",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0.5",
													backGroundScale9Enable = "False",
													classname = "MEImage",
													dstBlendFunc = "771",
													height = "73",
													ignoreSize = "True",
													name = "link",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "1",
													texturePath = "ui/activity/2020SnowDay/memory/chrimasBattle/005_1.png",
													touchAble = "False",
													UILayoutViewModel = 
													{
														PositionX = -1,
														PositionY = 68,
													},
													width = "54",
													ZOrder = "1",
												},
											},
										},
										{
											controlID = "Memory41_Panel_Level_Memory_list3_Panel_root_Panel-snowMemoryContent_iceSnowDay_activity_Game",
											UUID = "bc674762_3b9b_4a24_ad5d_80ec2de16ce0",
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
											DiyPropertyViewModel = 
											{
												cfg_Id = "190131"
											},
											dstBlendFunc = "771",
											height = "142",
											ignoreSize = "False",
											name = "Memory41",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "True",
											UILayoutViewModel = 
											{
												PositionX = 1397,
												PositionY = 1309,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "142",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "link_Memory41_Panel_Level_Memory_list3_Panel_root_Panel-snowMemoryContent_iceSnowDay_activity_Game",
													UUID = "cdc0c0e3_73e0_4591_8754_920e2bd3f103",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0.5",
													backGroundScale9Enable = "False",
													classname = "MEImage",
													dstBlendFunc = "771",
													height = "73",
													ignoreSize = "True",
													name = "link",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "1",
													texturePath = "ui/activity/2020SnowDay/memory/chrimasBattle/005_1.png",
													touchAble = "False",
													UILayoutViewModel = 
													{
														PositionY = 69,
													},
													width = "54",
													ZOrder = "1",
												},
											},
										},
										{
											controlID = "Memory42_Panel_Level_Memory_list3_Panel_root_Panel-snowMemoryContent_iceSnowDay_activity_Game",
											UUID = "fee9b70c_88a5_4275_875f_1c0d1189ed96",
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
											DiyPropertyViewModel = 
											{
												cfg_Id = "190130"
											},
											dstBlendFunc = "771",
											height = "142",
											ignoreSize = "False",
											name = "Memory42",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "True",
											UILayoutViewModel = 
											{
												PositionX = 1577,
												PositionY = 1326,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "142",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "link_Memory42_Panel_Level_Memory_list3_Panel_root_Panel-snowMemoryContent_iceSnowDay_activity_Game",
													UUID = "6c4a1293_f861_4e0f_8ab2_1c25744d4cdc",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0.5",
													backGroundScale9Enable = "False",
													classname = "MEImage",
													dstBlendFunc = "771",
													height = "54",
													ignoreSize = "True",
													name = "link",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "1",
													texturePath = "ui/activity/2020SnowDay/memory/chrimasBattle/004_1.png",
													touchAble = "False",
													UILayoutViewModel = 
													{
														PositionX = -91,
														PositionY = -2,
													},
													width = "116",
													ZOrder = "1",
												},
											},
										},
										{
											controlID = "Memory43_Panel_Level_Memory_list3_Panel_root_Panel-snowMemoryContent_iceSnowDay_activity_Game",
											UUID = "7597864a_3cb9_49b5_9d3b_4b8ca2ca3ad7",
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
											DiyPropertyViewModel = 
											{
												cfg_Id = "190129"
											},
											dstBlendFunc = "771",
											height = "142",
											ignoreSize = "False",
											name = "Memory43",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "True",
											UILayoutViewModel = 
											{
												PositionX = 1576,
												PositionY = 1529,
											},
											uipanelviewmodel = 
											{
												Layout="Absolute",
												nType = "0"
											},
											width = "142",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "link_Memory43_Panel_Level_Memory_list3_Panel_root_Panel-snowMemoryContent_iceSnowDay_activity_Game",
													UUID = "31e9947f_091f_440f_80be_97b7598565df",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0.5",
													backGroundScale9Enable = "False",
													classname = "MEImage",
													dstBlendFunc = "771",
													height = "137",
													ignoreSize = "True",
													name = "link",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "1",
													texturePath = "ui/activity/2020SnowDay/memory/chrimasBattle/006_1.png",
													touchAble = "False",
													UILayoutViewModel = 
													{
														PositionX = 1,
														PositionY = -94,
													},
													width = "54",
													ZOrder = "1",
												},
											},
										},
									},
								},
							},
						},
						{
							controlID = "Image_snowMemoryContent_1_Panel_root_Panel-snowMemoryContent_iceSnowDay_activity_Game",
							UUID = "a780fad3_b082_4879_b729_3c8e206b35fa",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							backGroundScale9Enable = "False",
							classname = "MEImage",
							dstBlendFunc = "771",
							height = "138",
							ignoreSize = "True",
							name = "Image_snowMemoryContent_1",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							texturePath = "ui/activity/2020SnowDay/memory/bg_mask1.png",
							touchAble = "False",
							UILayoutViewModel = 
							{
								PositionX = 1,
								PositionY = 252,
								LeftPositon = -212,
								TopPosition = -1,
								relativeToName = "Panel_root",
								nType = 3,
							},
							width = "1386",
							ZOrder = "1",
						},
						{
							controlID = "Button_Collection_Panel_root_Panel-snowMemoryContent_iceSnowDay_activity_Game",
							UUID = "4c9a04c4_75b8_4197_907f_0c8799e2335a",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							backGroundScale9Enable = "False",
							classname = "MEButton",
							ClickHighLightEnabled = "True",
							dstBlendFunc = "771",
							flipX = "False",
							flipY = "False",
							height = "100",
							ignoreSize = "True",
							name = "Button_Collection",
							normal = "ui/activity/2020SnowDay/memory/003.png",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							touchAble = "True",
							UILayoutViewModel = 
							{
								PositionX = 352,
								PositionY = -260,
								RightPosition = 17,
								BottomPosition = 10,
								relativeToName = "Panel_root",
								nType = 3,
								nGravity = 3,
								nAlign = 9
							},
							UItype = "Button",
							width = "222",
							ZOrder = "1",
							components = 
							{
								
								{
									controlID = "Label_Button_Collection_Panel_root_Panel-snowMemoryContent_iceSnowDay_activity_Game",
									UUID = "ae779ab1_4290_448d_8bff_f531a0cd1b60",
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
										IsStroke = false,
										StrokeColor = "#FFE6E6E6",
										StrokeSize = 1,
									},
									height = "32",
									ignoreSize = "True",
									name = "Label",
									nTextAlign = "1",
									nTextHAlign = "1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "前往图鉴",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionY = -4,
									},
									width = "106",
									ZOrder = "1",
								},
							},
						},
						{
							controlID = "Panel_tab_Panel_root_Panel-snowMemoryContent_iceSnowDay_activity_Game",
							UUID = "8675b271_e6fa_4384_a753_7046ce099365",
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
							height = "130",
							ignoreSize = "False",
							name = "Panel_tab",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							touchAble = "False",
							UILayoutViewModel = 
							{
								PositionX = 173,
								PositionY = 114,
								RightPosition = -93,
								TopPosition = 76,
								relativeToName = "Panel_root",
								nType = 3,
								nGravity = 3,
								nAlign = 3
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
									controlID = "tab_1_Panel_tab_Panel_root_Panel-snowMemoryContent_iceSnowDay_activity_Game",
									UUID = "2edaa654_d9d6_477a_84d1_f33803b535bf",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "50",
									ignoreSize = "True",
									name = "tab_1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/activity/2020SnowDay/memory/002.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = 198,
										PositionY = 98,
									},
									width = "372",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "panel_lab_tab_1_Panel_tab_Panel_root_Panel-snowMemoryContent_iceSnowDay_activity_Game",
											UUID = "0a37f54e_d2b2_4eeb_bafb_281153816fb2",
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
											height = "10",
											ignoreSize = "False",
											name = "panel_lab",
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
											width = "10",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "Label_panel_lab_tab_1_Panel_tab_Panel_root_Panel-snowMemoryContent_iceSnowDay_activity_Game",
													UUID = "d396bbf9_9b08_49f8_9c9f_831b78ec04ed",
													anchorPoint = "False",
													anchorPointX = "0",
													anchorPointY = "0.5",
													classname = "MELabel",
													compPath = "luacomponents.common.MEIconLabel",
													dstBlendFunc = "771",
													FontColor = "#FFBBDCFD",
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
													name = "Label",
													nTextAlign = "1",
													nTextHAlign = "1",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "770",
													text = "回忆",
													touchAble = "False",
													touchScaleEnable = "False",
													UILayoutViewModel = 
													{
														PositionX = -160,
														PositionY = -5,
													},
													width = "58",
													ZOrder = "1",
												},
												{
													controlID = "Label_Right_panel_lab_tab_1_Panel_tab_Panel_root_Panel-snowMemoryContent_iceSnowDay_activity_Game",
													UUID = "d63b4142_cdad_4f9d_a6e6_47aea05860a8",
													anchorPoint = "False",
													anchorPointX = "1",
													anchorPointY = "0.5",
													classname = "MELabel",
													compPath = "luacomponents.common.MEIconLabel",
													dstBlendFunc = "771",
													FontColor = "#FFBBDCFD",
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
													name = "Label_Right",
													nTextAlign = "1",
													nTextHAlign = "1",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "770",
													text = "回忆",
													touchAble = "False",
													touchScaleEnable = "False",
													UILayoutViewModel = 
													{
														PositionX = 89,
														PositionY = -4,
													},
													width = "58",
													ZOrder = "1",
												},
											},
										},
										{
											controlID = "Image_select_tab_1_Panel_tab_Panel_root_Panel-snowMemoryContent_iceSnowDay_activity_Game",
											UUID = "4aa51084_e66e_492e_a674_83b332580694",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											classname = "MEImage",
											dstBlendFunc = "771",
											height = "62",
											ignoreSize = "True",
											name = "Image_select",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											texturePath = "ui/activity/2020SnowDay/memory/001.png",
											touchAble = "False",
											UILayoutViewModel = 
											{
												
											},
											width = "437",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "Label_Image_select_tab_1_Panel_tab_Panel_root_Panel-snowMemoryContent_iceSnowDay_activity_Game",
													UUID = "d629b31f_7775_4f06_ae6c_1ff5ba7a5a16",
													anchorPoint = "False",
													anchorPointX = "0",
													anchorPointY = "0.5",
													classname = "MELabel",
													compPath = "luacomponents.common.MEIconLabel",
													dstBlendFunc = "771",
													FontColor = "#FF3C78BF",
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
													name = "Label",
													nTextAlign = "1",
													nTextHAlign = "1",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "770",
													text = "回忆",
													touchAble = "False",
													touchScaleEnable = "False",
													UILayoutViewModel = 
													{
														PositionX = -160,
														PositionY = -5,
													},
													width = "58",
													ZOrder = "1",
												},
												{
													controlID = "Label_Right_Image_select_tab_1_Panel_tab_Panel_root_Panel-snowMemoryContent_iceSnowDay_activity_Game",
													UUID = "615ac88f_8b72_4030_9702_a856908a16b1",
													anchorPoint = "False",
													anchorPointX = "1",
													anchorPointY = "0.5",
													classname = "MELabel",
													compPath = "luacomponents.common.MEIconLabel",
													dstBlendFunc = "771",
													FontColor = "#FF3C78BF",
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
													name = "Label_Right",
													nTextAlign = "1",
													nTextHAlign = "1",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "770",
													text = "回忆",
													touchAble = "False",
													touchScaleEnable = "False",
													UILayoutViewModel = 
													{
														PositionX = 89,
														PositionY = -4,
													},
													width = "58",
													ZOrder = "1",
												},
											},
										},
									},
								},
								{
									controlID = "tab_2_Panel_tab_Panel_root_Panel-snowMemoryContent_iceSnowDay_activity_Game",
									UUID = "8bd54f95_9081_462c_bd1e_d231a6f5ed1f",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "50",
									ignoreSize = "True",
									name = "tab_2",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/activity/2020SnowDay/memory/002.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = 198,
										PositionY = 41,
									},
									width = "372",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "panel_lab_tab_2_Panel_tab_Panel_root_Panel-snowMemoryContent_iceSnowDay_activity_Game",
											UUID = "c5cdd635_293c_45c4_ba2d_bf0de982e4a7",
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
											height = "10",
											ignoreSize = "False",
											name = "panel_lab",
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
											width = "10",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "Label_panel_lab_tab_2_Panel_tab_Panel_root_Panel-snowMemoryContent_iceSnowDay_activity_Game",
													UUID = "f0cfae26_2050_474d_b383_8828cbe5cbf1",
													anchorPoint = "False",
													anchorPointX = "0",
													anchorPointY = "0.5",
													classname = "MELabel",
													compPath = "luacomponents.common.MEIconLabel",
													dstBlendFunc = "771",
													FontColor = "#FFBBDCFD",
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
													name = "Label",
													nTextAlign = "1",
													nTextHAlign = "1",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "770",
													text = "回忆",
													touchAble = "False",
													touchScaleEnable = "False",
													UILayoutViewModel = 
													{
														PositionX = -160,
														PositionY = -5,
													},
													width = "58",
													ZOrder = "1",
												},
												{
													controlID = "Label_Right_panel_lab_tab_2_Panel_tab_Panel_root_Panel-snowMemoryContent_iceSnowDay_activity_Game",
													UUID = "b41af640_8f75_467c_9543_95bfe40b8cd1",
													anchorPoint = "False",
													anchorPointX = "1",
													anchorPointY = "0.5",
													classname = "MELabel",
													compPath = "luacomponents.common.MEIconLabel",
													dstBlendFunc = "771",
													FontColor = "#FFBBDCFD",
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
													name = "Label_Right",
													nTextAlign = "1",
													nTextHAlign = "1",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "770",
													text = "回忆",
													touchAble = "False",
													touchScaleEnable = "False",
													UILayoutViewModel = 
													{
														PositionX = 89,
														PositionY = -3,
													},
													width = "58",
													ZOrder = "1",
												},
											},
										},
										{
											controlID = "Image_select_tab_2_Panel_tab_Panel_root_Panel-snowMemoryContent_iceSnowDay_activity_Game",
											UUID = "ddb56581_55a2_4f2c_a856_205e25023cd2",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											classname = "MEImage",
											dstBlendFunc = "771",
											height = "62",
											ignoreSize = "True",
											name = "Image_select",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											texturePath = "ui/activity/2020SnowDay/memory/001.png",
											touchAble = "False",
											UILayoutViewModel = 
											{
												
											},
											width = "437",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "Label_Image_select_tab_2_Panel_tab_Panel_root_Panel-snowMemoryContent_iceSnowDay_activity_Game",
													UUID = "e12cb75d_6670_4204_82aa_d975ed30d207",
													anchorPoint = "False",
													anchorPointX = "0",
													anchorPointY = "0.5",
													classname = "MELabel",
													compPath = "luacomponents.common.MEIconLabel",
													dstBlendFunc = "771",
													FontColor = "#FF3C78BF",
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
													name = "Label",
													nTextAlign = "1",
													nTextHAlign = "1",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "770",
													text = "回忆",
													touchAble = "False",
													touchScaleEnable = "False",
													UILayoutViewModel = 
													{
														PositionX = -160,
														PositionY = -5,
													},
													width = "58",
													ZOrder = "1",
												},
												{
													controlID = "Label_Right_Image_select_tab_2_Panel_tab_Panel_root_Panel-snowMemoryContent_iceSnowDay_activity_Game",
													UUID = "ba30962c_d941_4d4b_bca6_ae37ad2c9c34",
													anchorPoint = "False",
													anchorPointX = "1",
													anchorPointY = "0.5",
													classname = "MELabel",
													compPath = "luacomponents.common.MEIconLabel",
													dstBlendFunc = "771",
													FontColor = "#FF3C78BF",
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
													name = "Label_Right",
													nTextAlign = "1",
													nTextHAlign = "1",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "770",
													text = "回忆",
													touchAble = "False",
													touchScaleEnable = "False",
													UILayoutViewModel = 
													{
														PositionX = 89,
														PositionY = -3,
													},
													width = "58",
													ZOrder = "1",
												},
											},
										},
									},
								},
								{
									controlID = "tab_3_Panel_tab_Panel_root_Panel-snowMemoryContent_iceSnowDay_activity_Game",
									UUID = "6370c99e_3b74_4eec_86ed_38c48b425b10",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "50",
									ignoreSize = "True",
									name = "tab_3",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/activity/2020SnowDay/memory/002.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = 198,
										PositionY = -14,
									},
									width = "372",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "panel_lab_tab_3_Panel_tab_Panel_root_Panel-snowMemoryContent_iceSnowDay_activity_Game",
											UUID = "a8e6fc9e_35d3_48ab_bfb7_880c9a93d63b",
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
											height = "10",
											ignoreSize = "False",
											name = "panel_lab",
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
											width = "10",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "Label_panel_lab_tab_3_Panel_tab_Panel_root_Panel-snowMemoryContent_iceSnowDay_activity_Game",
													UUID = "7a492d03_8b15_4e17_87b6_02c5a8d7a769",
													anchorPoint = "False",
													anchorPointX = "0",
													anchorPointY = "0.5",
													classname = "MELabel",
													compPath = "luacomponents.common.MEIconLabel",
													dstBlendFunc = "771",
													FontColor = "#FFBBDCFD",
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
													name = "Label",
													nTextAlign = "1",
													nTextHAlign = "1",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "770",
													text = "回忆",
													touchAble = "False",
													touchScaleEnable = "False",
													UILayoutViewModel = 
													{
														PositionX = -160,
														PositionY = -5,
													},
													width = "58",
													ZOrder = "1",
												},
												{
													controlID = "Label_Right_panel_lab_tab_3_Panel_tab_Panel_root_Panel-snowMemoryContent_iceSnowDay_activity_Game",
													UUID = "08097c18_6229_4bf7_b0ef_525d0dfe7719",
													anchorPoint = "False",
													anchorPointX = "1",
													anchorPointY = "0.5",
													classname = "MELabel",
													compPath = "luacomponents.common.MEIconLabel",
													dstBlendFunc = "771",
													FontColor = "#FFBBDCFD",
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
													name = "Label_Right",
													nTextAlign = "1",
													nTextHAlign = "1",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "770",
													text = "回忆",
													touchAble = "False",
													touchScaleEnable = "False",
													UILayoutViewModel = 
													{
														PositionX = 89,
														PositionY = -1,
													},
													width = "58",
													ZOrder = "1",
												},
											},
										},
										{
											controlID = "Image_select_tab_3_Panel_tab_Panel_root_Panel-snowMemoryContent_iceSnowDay_activity_Game",
											UUID = "0299068b_e397_4026_8e16_1bce25002877",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											classname = "MEImage",
											dstBlendFunc = "771",
											height = "62",
											ignoreSize = "True",
											name = "Image_select",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											texturePath = "ui/activity/2020SnowDay/memory/001.png",
											touchAble = "False",
											UILayoutViewModel = 
											{
												
											},
											width = "437",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "Label_Image_select_tab_3_Panel_tab_Panel_root_Panel-snowMemoryContent_iceSnowDay_activity_Game",
													UUID = "9ae42d32_801f_44ff_977b_5fe496f0ef4c",
													anchorPoint = "False",
													anchorPointX = "0",
													anchorPointY = "0.5",
													classname = "MELabel",
													compPath = "luacomponents.common.MEIconLabel",
													dstBlendFunc = "771",
													FontColor = "#FF3C78BF",
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
													name = "Label",
													nTextAlign = "1",
													nTextHAlign = "1",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "770",
													text = "回忆",
													touchAble = "False",
													touchScaleEnable = "False",
													UILayoutViewModel = 
													{
														PositionX = -160,
														PositionY = -5,
													},
													width = "58",
													ZOrder = "1",
												},
												{
													controlID = "Label_Right_Image_select_tab_3_Panel_tab_Panel_root_Panel-snowMemoryContent_iceSnowDay_activity_Game",
													UUID = "7338574d_a7b7_4ee8_80a9_ac145d70dce0",
													anchorPoint = "False",
													anchorPointX = "1",
													anchorPointY = "0.5",
													classname = "MELabel",
													compPath = "luacomponents.common.MEIconLabel",
													dstBlendFunc = "771",
													FontColor = "#FF3C78BF",
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
													name = "Label_Right",
													nTextAlign = "1",
													nTextHAlign = "1",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "770",
													text = "回忆",
													touchAble = "False",
													touchScaleEnable = "False",
													UILayoutViewModel = 
													{
														PositionX = 90,
														PositionY = -2,
													},
													width = "58",
													ZOrder = "1",
												},
											},
										},
									},
								},
							},
						},
						{
							controlID = "Panel_Help_Panel_root_Panel-snowMemoryContent_iceSnowDay_activity_Game",
							UUID = "034a72a8_959a_4dbb_b7d3_a11d80abe1c4",
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
							height = "560",
							ignoreSize = "False",
							name = "Panel_Help",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							touchAble = "True",
							UILayoutViewModel = 
							{
								PositionX = -692,
								PositionY = -314,
								LeftPositon = -212,
								TopPosition = 74,
								relativeToName = "Panel_root",
								nType = 3,
							},
							uipanelviewmodel = 
							{
								Layout="Absolute",
								nType = "0"
							},
							width = "1386",
							ZOrder = "1",
							components = 
							{
								
								{
									controlID = "ImageLimit_Panel_Help_Panel_root_Panel-snowMemoryContent_iceSnowDay_activity_Game",
									UUID = "fb964b1e_c2ce_4a62_bd43_7b04b1879b37",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "50",
									ignoreSize = "True",
									name = "ImageLimit",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/activity/2020SnowDay/memory/008.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = 404,
										PositionY = 528,
										relativeToName = "Panel_root",
									},
									width = "369",
									ZOrder = "1",
								},
								{
									controlID = "Button_help_Panel_Help_Panel_root_Panel-snowMemoryContent_iceSnowDay_activity_Game",
									UUID = "bcfae97c_886b_4ddf_bfee_f9d9ab9eb212",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEButton",
									ClickHighLightEnabled = "True",
									dstBlendFunc = "771",
									flipX = "False",
									flipY = "False",
									height = "38",
									ignoreSize = "True",
									name = "Button_help",
									normal = "ui/activity/2020SnowDay/memory/004.png",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "True",
									UILayoutViewModel = 
									{
										PositionX = 498,
										PositionY = 525,
									},
									UItype = "Button",
									width = "38",
									ZOrder = "1",
								},
								{
									controlID = "Label_Name_Panel_Help_Panel_root_Panel-snowMemoryContent_iceSnowDay_activity_Game",
									UUID = "5debb367_6119_4746_ab05_1b98b1613b44",
									anchorPoint = "False",
									anchorPointX = "0",
									anchorPointY = "0.5",
									classname = "MELabel",
									compPath = "luacomponents.common.MEIconLabel",
									dstBlendFunc = "771",
									FontColor = "#FF273D77",
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
									name = "Label_Name",
									nTextAlign = "1",
									nTextHAlign = "1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "冬日回忆解锁数量上限",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionX = 226,
										PositionY = 526,
										LeftPositon = 3,
										TopPosition = 29,
										relativeToName = "Panel_root",
									},
									width = "203",
									ZOrder = "1",
								},
								{
									controlID = "tipsBg_Panel_Help_Panel_root_Panel-snowMemoryContent_iceSnowDay_activity_Game",
									UUID = "2355122d_fc33_459e_b878_9709566f58e9",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "78",
									ignoreSize = "True",
									name = "tipsBg",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/activity/2020SnowDay/memory/005.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = 745,
										PositionY = 505,
									},
									width = "435",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "content_tipsBg_Panel_Help_Panel_root_Panel-snowMemoryContent_iceSnowDay_activity_Game",
											UUID = "7b9eace8_eaed_42d8_818c_a87b81d88346",
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
											height = "60",
											ignoreSize = "False",
											name = "content",
											nTextAlign = "0",
											nTextHAlign = "0",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "770",
											text = "在冰雪手册提升冬日回忆的等级可以提升上限当前等级:",
											touchAble = "False",
											touchScaleEnable = "False",
											UILayoutViewModel = 
											{
												PositionX = -202,
												PositionY = -7,
											},
											width = "420",
											ZOrder = "1",
										},
										{
											controlID = "curBookLevel_tipsBg_Panel_Help_Panel_root_Panel-snowMemoryContent_iceSnowDay_activity_Game",
											UUID = "a2be3a79_aa84_47f6_ad6f_e05bdabde84d",
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
											name = "curBookLevel",
											nTextAlign = "1",
											nTextHAlign = "0",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "770",
											text = "当前等级:14",
											touchAble = "False",
											touchScaleEnable = "False",
											UILayoutViewModel = 
											{
												PositionX = -197,
												PositionY = -16,
											},
											visible = "False",
											width = "106",
											ZOrder = "1",
										},
									},
								},
							},
						},
						{
							controlID = "MainMemoryIconPrefab_Panel_root_Panel-snowMemoryContent_iceSnowDay_activity_Game",
							UUID = "91a46cea_9d8a_40b5_a4be_42105acaebf1",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							classname = "MEClippingNode",
							clipNodeX = "50",
							clipNodeY = "50",
							dstBlendFunc = "771",
							height = "100",
							ignoreSize = "False",
							name = "MainMemoryIconPrefab",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							stencilPath = "ui/activity/2020SnowDay/memory/mainMemoryMask.png",
							touchAble = "False",
							UILayoutViewModel = 
							{
								PositionX = -139,
								PositionY = 859,
								LeftPositon = 291,
								TopPosition = -589,
								relativeToName = "Panel_root",
								nType = 3,
							},
							width = "100",
							ZOrder = "1",
							components = 
							{
								
								{
									controlID = "HeadIcon_MainMemoryIconPrefab_Panel_root_Panel-snowMemoryContent_iceSnowDay_activity_Game",
									UUID = "1941f255_a4c3_4504_99a9_955badcfc08b",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "160",
									ignoreSize = "True",
									name = "HeadIcon",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "icon/cg/date_cg_250.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionY = -12,
									},
									width = "250",
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
			"ui/activity/2020SnowDay/memory/bg.png",
			"ui/activity/2020SnowDay/memory/bg_mask.png",
			"ui/activity/2020SnowDay/memory/level/021.png",
			"ui/activity/2020SnowDay/memory/level/016.png",
			"ui/activity/2020SnowDay/memory/level/017.png",
			"ui/activity/2020SnowDay/memory/level/020.png",
			"ui/activity/2020SnowDay/memory/level/018.png",
			"ui/activity/2020SnowDay/memory/level/014.png",
			"ui/activity/2020SnowDay/memory/level/013.png",
			"ui/activity/2020SnowDay/memory/level/015.png",
			"ui/activity/2020SnowDay/memory/level/024.png",
			"ui/activity/2020SnowDay/memory/level/022.png",
			"ui/activity/2020SnowDay/memory/level/019.png",
			"ui/activity/2020SnowDay/memory/level/023.png",
			"ui/activity/2020SnowDay/memory/level/012.png",
			"ui/activity/2020SnowDay/memory/level/005.png",
			"ui/activity/2020SnowDay/memory/level/007.png",
			"ui/activity/2020SnowDay/memory/level/011.png",
			"ui/activity/2020SnowDay/memory/level/009.png",
			"ui/activity/2020SnowDay/memory/level/001.png",
			"ui/activity/2020SnowDay/memory/level/002.png",
			"ui/activity/2020SnowDay/memory/level/003.png",
			"ui/activity/2020SnowDay/memory/level/004.png",
			"ui/activity/2020SnowDay/memory/level/008.png",
			"ui/activity/2020SnowDay/memory/level/010.png",
			"ui/activity/2020SnowDay/memory/chrismasGiftBattle/010_1.png",
			"ui/activity/2020SnowDay/memory/chrismasGiftBattle/007_1.png",
			"ui/activity/2020SnowDay/memory/chrismasGiftBattle/009_1.png",
			"ui/activity/2020SnowDay/memory/chrismasGiftBattle/011_1.png",
			"ui/activity/2020SnowDay/memory/chrismasGiftBattle/006.png",
			"ui/activity/2020SnowDay/memory/chrismasGiftBattle/012.png",
			"ui/activity/2020SnowDay/memory/level/011_1.png",
			"ui/activity/2020SnowDay/memory/chrismasGiftBattle/001_1.png",
			"ui/activity/2020SnowDay/memory/chrismasGiftBattle/003_1.png",
			"ui/activity/2020SnowDay/memory/chrismasGiftBattle/003.png",
			"ui/activity/2020SnowDay/memory/chrismasGiftBattle/005.png",
			"ui/activity/2020SnowDay/memory/chrismasGiftBattle/008.png",
			"ui/activity/2020SnowDay/memory/chrismasGiftBattle/001.png",
			"ui/activity/2020SnowDay/memory/chrismasGiftBattle/004.png",
			"ui/activity/2020SnowDay/memory/chrismasGiftBattle/002.png",
			"ui/activity/2020SnowDay/memory/chrismasGiftBattle/007.png",
			"ui/activity/2020SnowDay/memory/chrimasBattle/011_1.png",
			"ui/activity/2020SnowDay/memory/chrimasBattle/015_1.png",
			"ui/activity/2020SnowDay/memory/chrimasBattle/004_1.png",
			"ui/activity/2020SnowDay/memory/chrimasBattle/002_1.png",
			"ui/activity/2020SnowDay/memory/chrimasBattle/016_1.png",
			"ui/activity/2020SnowDay/memory/chrimasBattle/014_1.png",
			"ui/activity/2020SnowDay/memory/chrimasBattle/001_1.png",
			"ui/activity/2020SnowDay/memory/chrimasBattle/009_1.png",
			"ui/activity/2020SnowDay/memory/chrimasBattle/017_1.png",
			"ui/activity/2020SnowDay/memory/chrimasBattle/005_1.png",
			"ui/activity/2020SnowDay/memory/chrimasBattle/006_1.png",
			"ui/activity/2020SnowDay/memory/chrimasBattle/010_1.png",
			"ui/activity/2020SnowDay/memory/chrimasBattle/013_1.png",
			"ui/activity/2020SnowDay/memory/chrimasBattle/012_1.png",
			"ui/activity/2020SnowDay/memory/chrimasBattle/007_1.png",
			"ui/activity/2020SnowDay/memory/chrimasBattle/008_1.png",
			"ui/activity/2020SnowDay/memory/chrimasBattle/018_1.png",
			"ui/activity/2020SnowDay/memory/bg_mask1.png",
			"ui/activity/2020SnowDay/memory/003.png",
			"ui/activity/2020SnowDay/memory/002.png",
			"ui/activity/2020SnowDay/memory/001.png",
			"ui/activity/2020SnowDay/memory/008.png",
			"ui/activity/2020SnowDay/memory/004.png",
			"ui/activity/2020SnowDay/memory/005.png",
			"icon/cg/date_cg_250.png",
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

