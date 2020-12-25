local t = 
{
	version = 1,
	components = 
	{
		
		{
			controlID = "Panel-Prefabe_group_osd_Game",
			UUID = "7d768387_f65a_4aca_b39d_685ee7ad5695",
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
					controlID = "Image_player_Panel-Prefabe_group_osd_Game",
					UUID = "6fc87dba_68ae_4c50_a0ce_8d5d437c87be",
					anchorPoint = "False",
					anchorPointX = "0.5",
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
					height = "40",
					ignoreSize = "False",
					name = "Image_player",
					sizepercentx = "0",
					sizepercenty = "0",
					sizeType = "0",
					srcBlendFunc = "1",
					touchAble = "False",
					UILayoutViewModel = 
					{
						PositionY = 4,
					},
					uipanelviewmodel = 
					{
						Layout="Absolute",
						nType = "0"
					},
					width = "124",
					ZOrder = "1",
					components = 
					{
						
						{
							controlID = "Label_gonghui_Image_player_Panel-Prefabe_group_osd_Game",
							UUID = "98acc2d9_5709_471f_896f_db34c593a821",
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
							fontSize = "18",
							fontStroke = 
							{
								IsStroke = true,
								StrokeColor = "#FF49557F",
								StrokeSize = 1,
							},
							height = "23",
							ignoreSize = "True",
							name = "Label_gonghui",
							nTextAlign = "1",
							nTextHAlign = "1",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "770",
							text = "Tampilan Gelar",
							touchAble = "False",
							touchScaleEnable = "False",
							UILayoutViewModel = 
							{
								PositionY = 38,
							},
							width = "76",
							ZOrder = "1",
						},
						{
							controlID = "Label_name_Image_player_Panel-Prefabe_group_osd_Game",
							UUID = "b40c1506_192b_48b9_a7d8_2b74cdfd6c9a",
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
								StrokeColor = "#FF49557F",
								StrokeSize = 2,
							},
							height = "26",
							ignoreSize = "True",
							name = "Label_name",
							nTextAlign = "1",
							nTextHAlign = "1",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "770",
							text = "Nama pemain",
							touchAble = "False",
							touchScaleEnable = "False",
							UILayoutViewModel = 
							{
								PositionY = 14,
							},
							width = "77",
							ZOrder = "1",
						},
						{
							controlID = "Image_bubble_Image_player_Panel-Prefabe_group_osd_Game",
							UUID = "8987b64e_bb87_41f0_b1a2_654b516f0569",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0",
							backGroundScale9Enable = "False",
							classname = "MEImage",
							dstBlendFunc = "771",
							height = "98",
							ignoreSize = "True",
							name = "Image_bubble",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							texturePath = "ui/osd/main/003.png",
							touchAble = "False",
							UILayoutViewModel = 
							{
								PositionY = 23,
							},
							visible = "False",
							width = "98",
							ZOrder = "1",
							components = 
							{
								
								{
									controlID = "Label_bubble_Image_bubble_Image_player_Panel-Prefabe_group_osd_Game",
									UUID = "4c202b4e_80bd_4bad_82a4_d6f315b031b3",
									anchorPoint = "False",
									anchorPointX = "0",
									anchorPointY = "1",
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
									fontSize = "16",
									fontStroke = 
									{
										IsStroke = false,
										StrokeColor = "#FFE6E6E6",
										StrokeSize = 1,
									},
									height = "65",
									ignoreSize = "False",
									name = "Label_bubble",
									nTextAlign = "0",
									nTextHAlign = "0",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "Nama pemain",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionX = -45,
										PositionY = 89,
									},
									width = "89",
									ZOrder = "1",
								},
							},
						},
						{
							controlID = "Label_selfname_Image_player_Panel-Prefabe_group_osd_Game",
							UUID = "bf794fb7_d3bc_40f3_bac9_a36f78c7f425",
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
								StrokeColor = "#FFFD3870",
								StrokeSize = 2,
							},
							height = "26",
							ignoreSize = "True",
							name = "Label_selfname",
							nTextAlign = "1",
							nTextHAlign = "1",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "770",
							text = "Nama pemain",
							touchAble = "False",
							touchScaleEnable = "False",
							UILayoutViewModel = 
							{
								PositionY = 14,
							},
							width = "77",
							ZOrder = "1",
						},
						{
							controlID = "panel_title_Image_player_Panel-Prefabe_group_osd_Game",
							UUID = "9856d6d4_26ab_47ee_8800_0b1d605f4876",
							anchorPoint = "False",
							anchorPointX = "0.5",
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
							name = "panel_title",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							touchAble = "False",
							UILayoutViewModel = 
							{
								PositionY = 60,
							},
							uipanelviewmodel = 
							{
								Layout="Absolute",
								nType = "0"
							},
							width = "0",
							ZOrder = "1",
						},
					},
				},
				{
					controlID = "Image_npc_Panel-Prefabe_group_osd_Game",
					UUID = "712b9a5e_52ac_4631_a37c_5e30497c216e",
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
					height = "40",
					ignoreSize = "False",
					name = "Image_npc",
					sizepercentx = "0",
					sizepercenty = "0",
					sizeType = "0",
					srcBlendFunc = "1",
					touchAble = "False",
					UILayoutViewModel = 
					{
						PositionX = 392,
						PositionY = 183,
					},
					uipanelviewmodel = 
					{
						Layout="Absolute",
						nType = "0"
					},
					width = "122",
					ZOrder = "1",
					components = 
					{
						
						{
							controlID = "npc_type_Image_npc_Panel-Prefabe_group_osd_Game",
							UUID = "fb1acf98_fad4_413a_a49d_d45fb69023e5",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							backGroundScale9Enable = "False",
							classname = "MEImage",
							dstBlendFunc = "771",
							height = "68",
							ignoreSize = "True",
							name = "npc_type",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							texturePath = "icon/hero/npc/001.png",
							touchAble = "False",
							UILayoutViewModel = 
							{
								PositionY = 69,
							},
							width = "68",
							ZOrder = "1",
						},
						{
							controlID = "Label_name_Image_npc_Panel-Prefabe_group_osd_Game",
							UUID = "b209f17d_5ae8_43f4_b85e_62b0ac89c260",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							classname = "MELabel",
							compPath = "luacomponents.common.MEIconLabel",
							dstBlendFunc = "771",
							FontColor = "#FF339195",
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
								StrokeColor = "#FFFFFFFF",
								StrokeSize = 2,
							},
							height = "29",
							ignoreSize = "True",
							name = "Label_name",
							nTextAlign = "1",
							nTextHAlign = "1",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "770",
							text = "NPC",
							touchAble = "False",
							touchScaleEnable = "False",
							UILayoutViewModel = 
							{
								PositionX = -1,
								PositionY = 13,
							},
							width = "59",
							ZOrder = "1",
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
			"ui/osd/main/003.png",
			"icon/hero/npc/001.png",
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

