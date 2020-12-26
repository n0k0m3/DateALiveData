local t = 
{
	version = 1,
	components = 
	{
		
		{
			controlID = "Panel-duanwuPopProgressView_duanwu_activity_activity_Game",
			UUID = "2f891ffc_bcd4_4711_887c_e1e171cce9b7",
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
					controlID = "Panel_base_Panel-duanwuPopProgressView_duanwu_activity_activity_Game",
					UUID = "1f636cd7_9f23_4e57_8ca9_c688099d8494",
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
							controlID = "Image_bg_Panel_base_Panel-duanwuPopProgressView_duanwu_activity_activity_Game",
							UUID = "7f1fe17a_9504_4feb_9173_b1fbc26eabfa",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							backGroundScale9Enable = "False",
							classname = "MEImage",
							dstBlendFunc = "771",
							height = "524",
							HitType = 
							{
								nHitType = 1,
								nXpos = -148,
								nYpos = -210,
								nHitWidth = 296,
								nHitHeight = 420
							},
							ignoreSize = "True",
							name = "Image_bg",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							texturePath = "ui/activity/duanwu_mfdzz/pop/002.png",
							touchAble = "True",
							UILayoutViewModel = 
							{
								PositionX = 578,
								PositionY = 321,
							},
							width = "401",
							ZOrder = "1",
						},
						{
							controlID = "LoadingBar_progress_Panel_base_Panel-duanwuPopProgressView_duanwu_activity_activity_Game",
							UUID = "e9821f65_c722_49d3_9559_e80d5b6c26e0",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							backGroundScale9Enable = "False",
							classname = "MELoadingBar",
							direction = "4",
							dstBlendFunc = "771",
							height = "118",
							ignoreSize = "True",
							name = "LoadingBar_progress",
							percent = "43",
							sizepercentx = "51",
							sizepercenty = "3",
							sizeType = "0",
							srcBlendFunc = "1",
							texture = "ui/activity/duanwu_mfdzz/pop/progress.png",
							touchAble = "False",
							UILayoutViewModel = 
							{
								PositionX = 578,
								PositionY = 397,
							},
							width = "137",
							ZOrder = "1",
						},
						{
							controlID = "lab_name_Panel_base_Panel-duanwuPopProgressView_duanwu_activity_activity_Game",
							UUID = "931ffb99_30ac_4711_863c_9b79a109b168",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							classname = "MELabel",
							compPath = "luacomponents.common.MEIconLabel",
							dstBlendFunc = "771",
							FontColor = "#FFF5E2D2",
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
							name = "lab_name",
							nTextAlign = "1",
							nTextHAlign = "1",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "770",
							text = "名称5个字",
							touchAble = "False",
							touchScaleEnable = "False",
							UILayoutViewModel = 
							{
								PositionX = 583,
								PositionY = 491,
							},
							width = "118",
							ZOrder = "1",
						},
						{
							controlID = "lab_progress_Panel_base_Panel-duanwuPopProgressView_duanwu_activity_activity_Game",
							UUID = "5a3508ee_1598_455e_970e_3cc2ce6781d5",
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
							fontSize = "24",
							fontStroke = 
							{
								IsStroke = false,
								StrokeColor = "#FFE6E6E6",
								StrokeSize = 1,
							},
							height = "27",
							ignoreSize = "True",
							name = "lab_progress",
							nTextAlign = "1",
							nTextHAlign = "1",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "770",
							text = "70%",
							touchAble = "False",
							touchScaleEnable = "False",
							UILayoutViewModel = 
							{
								PositionX = 597,
								PositionY = 304,
							},
							width = "45",
							ZOrder = "1",
							components = 
							{
								
								{
									controlID = "lab_progress__lab_progress_Panel_base_Panel-duanwuPopProgressView_duanwu_activity_activity_Game",
									UUID = "2557a45f_f1d8_4a87_883e_fd344c5803b5",
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
									fontSize = "24",
									fontStroke = 
									{
										IsStroke = false,
										StrokeColor = "#FFE6E6E6",
										StrokeSize = 1,
									},
									height = "27",
									ignoreSize = "True",
									name = "lab_progress_",
									nTextAlign = "1",
									nTextHAlign = "1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "完成度：",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionX = -48,
									},
									width = "83",
									ZOrder = "1",
								},
							},
						},
						{
							controlID = "Label_duanwuPopProgressView_1_Panel_base_Panel-duanwuPopProgressView_duanwu_activity_activity_Game",
							UUID = "4985e5e2_3f5d_4677_bcea_89dc3342997d",
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
							name = "Label_duanwuPopProgressView_1",
							nTextAlign = "1",
							nTextHAlign = "1",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "770",
							text = "获得道具",
							touchAble = "False",
							touchScaleEnable = "False",
							UILayoutViewModel = 
							{
								PositionX = 577,
								PositionY = 247,
							},
							width = "99",
							ZOrder = "1",
						},
						{
							controlID = "panel_goodsPos_Panel_base_Panel-duanwuPopProgressView_duanwu_activity_activity_Game",
							UUID = "59c4cbdd_bb86_4d6b_a529_13dc731f530f",
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
							height = "50",
							ignoreSize = "False",
							name = "panel_goodsPos",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							touchAble = "False",
							UILayoutViewModel = 
							{
								PositionX = 578,
								PositionY = 183,
							},
							uipanelviewmodel = 
							{
								Layout="Absolute",
								nType = "0"
							},
							width = "50",
							ZOrder = "1",
						},
						{
							controlID = "Image_icon_Panel_base_Panel-duanwuPopProgressView_duanwu_activity_activity_Game",
							UUID = "c831df98_4089_4bda_aac8_d7366a9380a6",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							backGroundScale9Enable = "False",
							classname = "MEImage",
							dstBlendFunc = "771",
							height = "57",
							ignoreSize = "True",
							name = "Image_icon",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							texturePath = "ui/activity/duanwu_mfdzz/main/field.png",
							touchAble = "False",
							UILayoutViewModel = 
							{
								PositionX = 577,
								PositionY = 397,
							},
							width = "57",
							ZOrder = "1",
						},
					},
				},
				{
					controlID = "Panel_touched_Panel-duanwuPopProgressView_duanwu_activity_activity_Game",
					UUID = "c3fd118d_fbe6_4bc4_a322_6e634d240384",
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
					name = "Panel_touched",
					PanelRelativeSizeModel = 
					{
						PanelRelativeEnable = true,
					},
					sizepercentx = "0",
					sizepercenty = "0",
					sizeType = "0",
					srcBlendFunc = "1",
					touchAble = "True",
					UILayoutViewModel = 
					{
						PositionY = -69,
						relativeToName = "Panel",
						nType = 3,
					},
					uipanelviewmodel = 
					{
						Layout="Absolute",
						nType = "0"
					},
					width = "1020",
					ZOrder = "1",
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
			"ui/activity/duanwu_mfdzz/pop/002.png",
			"ui/activity/duanwu_mfdzz/pop/progress.png",
			"ui/activity/duanwu_mfdzz/main/field.png",
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

