local t = 
{
	version = 1,
	components = 
	{
		
		{
			controlID = "Panel-extAssetsDownloadView_Layer1_common_Game",
			UUID = "9eb9e07d_08fd_491c_b650_349eeea90539",
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
					controlID = "Panel_root_Panel-extAssetsDownloadView_Layer1_common_Game",
					UUID = "de48eb1f_6798_4a1e_b57d_626d5c63b2ae",
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
					touchAble = "True",
					UILayoutViewModel = 
					{
						PositionX = -125,
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
					width = "1386",
					ZOrder = "1",
					components = 
					{
						
						{
							controlID = "Image_bg_Panel_root_Panel-extAssetsDownloadView_Layer1_common_Game",
							UUID = "240e13fb_273c_4aa4_b8b6_7bdc2213a062",
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
							texturePath = "scene/bg/bg_new.png",
							touchAble = "False",
							UILayoutViewModel = 
							{
								PositionX = 693,
								PositionY = 320,
							},
							width = "1386",
							ZOrder = "1",
						},
						{
							controlID = "Image_extAssetsDownloadView_1_Panel_root_Panel-extAssetsDownloadView_Layer1_common_Game",
							UUID = "484e5bec_17d8_402f_9afa_d9b757f5bd8d",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							backGroundScale9Enable = "False",
							classname = "MEImage",
							dstBlendFunc = "771",
							height = "80",
							ignoreSize = "False",
							name = "Image_extAssetsDownloadView_1",
							scaleY = "0.6",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							texturePath = "ui/update/1763.png",
							touchAble = "False",
							UILayoutViewModel = 
							{
								PositionX = 693,
								PositionY = 22,
							},
							width = "1386",
							ZOrder = "1",
						},
						{
							controlID = "Image_loadingbg_Panel_root_Panel-extAssetsDownloadView_Layer1_common_Game",
							UUID = "623dd92f_f195_4a2f_9c75_b191c436e914",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							backGroundScale9Enable = "False",
							classname = "MEImage",
							dstBlendFunc = "771",
							height = "12",
							ignoreSize = "False",
							name = "Image_loadingbg",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							texturePath = "ui/load_bg.png",
							touchAble = "False",
							UILayoutViewModel = 
							{
								PositionX = 691,
								PositionY = 6,
							},
							width = "1386",
							ZOrder = "1",
						},
						{
							controlID = "LoadingBar_process_Panel_root_Panel-extAssetsDownloadView_Layer1_common_Game",
							UUID = "24e87506_dd42_45e8_a946_720acffcd72b",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							backGroundScale9Enable = "False",
							classname = "MELoadingBar",
							direction = "0",
							dstBlendFunc = "771",
							height = "12",
							ignoreSize = "False",
							name = "LoadingBar_process",
							percent = "100",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							texture = "ui/load.png",
							touchAble = "False",
							UILayoutViewModel = 
							{
								PositionX = 693,
								PositionY = 8,
								relativeToName = "Panel",
							},
							width = "1136",
							ZOrder = "1",
							components = 
							{
								
								{
									controlID = "Label_speed_LoadingBar_process_Panel_root_Panel-extAssetsDownloadView_Layer1_common_Game",
									UUID = "a4eab8b1_79a9_46cf_a8a0_e30c1f69e694",
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
										IsStroke = false,
										StrokeColor = "#FFE6E6E6",
										StrokeSize = 1,
									},
									height = "21",
									ignoreSize = "True",
									name = "Label_speed",
									nTextAlign = "1",
									nTextHAlign = "1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "12Mps",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionY = 20,
									},
									width = "52",
									ZOrder = "1",
								},
								{
									controlID = "Label_filesize_LoadingBar_process_Panel_root_Panel-extAssetsDownloadView_Layer1_common_Game",
									UUID = "b7c8a2a5_f797_4d4a_b2b6_2b42c6b6572f",
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
									fontSize = "18",
									fontStroke = 
									{
										IsStroke = false,
										StrokeColor = "#FFE6E6E6",
										StrokeSize = 1,
									},
									height = "21",
									ignoreSize = "True",
									name = "Label_filesize",
									nTextAlign = "1",
									nTextHAlign = "1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "18MB",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionX = -388,
										PositionY = 19,
									},
									width = "44",
									ZOrder = "1",
								},
							},
						},
						{
							controlID = "Label_title_Panel_root_Panel-extAssetsDownloadView_Layer1_common_Game",
							UUID = "2ec53aa9_1512_4eaf_a624_89211d5620db",
							anchorPoint = "False",
							anchorPointX = "0",
							anchorPointY = "0.5",
							classname = "MELabel",
							compPath = "luacomponents.common.MEIconLabel",
							dstBlendFunc = "771",
							FontColor = "#FFF5F5F5",
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
								IsStroke = false,
								StrokeColor = "#FFE6E6E6",
								StrokeSize = 1,
							},
							height = "21",
							ignoreSize = "True",
							name = "Label_title",
							nTextAlign = "1",
							nTextHAlign = "1",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "770",
							text = "Zusätzliche Ressourcen werden heruntergeladen",
							touchAble = "False",
							touchScaleEnable = "False",
							UILayoutViewModel = 
							{
								PositionX = 127,
								PositionY = 29,
							},
							width = "147",
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
			"scene/bg/bg_new.png",
			"ui/update/1763.png",
			"ui/load_bg.png",
			"ui/load.png",
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

