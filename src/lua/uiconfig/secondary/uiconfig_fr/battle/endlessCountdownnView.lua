local t = 
{
	version = 1,
	components = 
	{
		
		{
			controlID = "Panel-endlessCountdownnView_ui_battle_Game",
			UUID = "57f717f2_8d94_4fc0_a569_ad8f4a6976d4",
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
					controlID = "Panel_root_Panel-endlessCountdownnView_ui_battle_Game",
					UUID = "0e54968e_b624_4419_b8cc_a3bc196455f3",
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
							controlID = "Image_content_Panel_root_Panel-endlessCountdownnView_ui_battle_Game",
							UUID = "f3f12e06_8753_4e4a_b4b2_8475e5215a48",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							backGroundScale9Enable = "False",
							classname = "MEImage",
							dstBlendFunc = "771",
							height = "78",
							ignoreSize = "True",
							name = "Image_content",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							texturePath = "ui/battle/result/endless_007.png",
							touchAble = "False",
							UILayoutViewModel = 
							{
								PositionX = -7,
								PositionY = -168,
								LeftPositon = 3,
								TopPosition = 591,
								relativeToName = "Panel_root",
							},
							width = "422",
							ZOrder = "1",
							components = 
							{
								
								{
									controlID = "Label_goto_Image_content_Panel_root_Panel-endlessCountdownnView_ui_battle_Game",
									UUID = "a687d5a6_347a_4b68_bf52_a96fff737040",
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
									fontSize = "15",
									fontStroke = 
									{
										IsStroke = false,
										StrokeColor = "#FFE6E6E6",
										StrokeSize = 1,
									},
									height = "0",
									ignoreSize = "False",
									name = "Label_goto",
									nTextAlign = "1",
									nTextHAlign = "1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "Arrivée prochaine",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionY = 23,
									},
									width = "206",
									ZOrder = "1",
								},
								{
									controlID = "Image_progress_Image_content_Panel_root_Panel-endlessCountdownnView_ui_battle_Game",
									UUID = "98576ee4_111d_4134_ada4_3020eb7a5c49",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "12",
									ignoreSize = "True",
									name = "Image_progress",
									scaleX = "0.235",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/battle/result/endless_006.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = 1,
										PositionY = -15,
										LeftPositon = -1,
										relativeToName = "Panel_root",
										nGravity = 4,
										nAlign = 7
									},
									width = "1138",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "LoadingBar_time_Image_progress_Image_content_Panel_root_Panel-endlessCountdownnView_ui_battle_Game",
											UUID = "dac83ff5_36d0_4c2f_9334_f5b1eefc5280",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											classname = "MELoadingBar",
											direction = "0",
											dstBlendFunc = "771",
											height = "12",
											ignoreSize = "True",
											name = "LoadingBar_time",
											percent = "62",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											texture = "ui/battle/result/endless_008.png",
											touchAble = "False",
											UILayoutViewModel = 
											{
												
											},
											width = "1136",
											ZOrder = "1",
										},
									},
								},
								{
									controlID = "Label_countDown_Image_content_Panel_root_Panel-endlessCountdownnView_ui_battle_Game",
									UUID = "2b8419c0_37c1_4f19_a5d2_761a905a0f21",
									anchorPoint = "False",
									anchorPointX = "0",
									anchorPointY = "0.5",
									classname = "MELabel",
									compPath = "luacomponents.common.MEIconLabel",
									dstBlendFunc = "771",
									FontColor = "#FFFFE460",
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
										StrokeColor = "#FF2B2955",
										StrokeSize = 2,
									},
									height = "25",
									ignoreSize = "True",
									name = "Label_countDown",
									nTextAlign = "1",
									nTextHAlign = "1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "4-5s",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionX = 79,
										PositionY = -13,
									},
									width = "44",
									ZOrder = "1",
								},
								{
									controlID = "Button_continue_Image_content_Panel_root_Panel-endlessCountdownnView_ui_battle_Game",
									UUID = "5d7266a2_a8b8_4990_b358_8d9622049a7d",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEButton",
									ClickHighLightEnabled = "True",
									dstBlendFunc = "771",
									flipX = "False",
									flipY = "False",
									height = "50",
									ignoreSize = "True",
									name = "Button_continue",
									normal = "ui/battle/n211.png",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "True",
									UILayoutViewModel = 
									{
										PositionX = 172,
										PositionY = -4,
									},
									UItype = "Button",
									width = "58",
									ZOrder = "1",
								},
								{
									controlID = "Button_exit_Image_content_Panel_root_Panel-endlessCountdownnView_ui_battle_Game",
									UUID = "405817fd_0ead_4879_88bc_8f9963b0a70b",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEButton",
									ClickHighLightEnabled = "True",
									dstBlendFunc = "771",
									flipX = "False",
									flipY = "False",
									height = "50",
									ignoreSize = "True",
									name = "Button_exit",
									normal = "ui/battle/n212.png",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "True",
									UILayoutViewModel = 
									{
										PositionX = -174,
										PositionY = -4,
									},
									UItype = "Button",
									width = "58",
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
			"ui/battle/result/endless_007.png",
			"ui/battle/result/endless_006.png",
			"ui/battle/result/endless_008.png",
			"ui/battle/n211.png",
			"ui/battle/n212.png",
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

