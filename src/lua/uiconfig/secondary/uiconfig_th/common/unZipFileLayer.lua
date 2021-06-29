local t = 
{
	version = 1,
	components = 
	{
		
		{
			controlID = "Panel-unZipFileLayer_Layer1_common_Game",
			UUID = "0f9af9b0_5029_400f_a373_ba2ecd6fe76f",
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
					controlID = "panel_root_Panel-unZipFileLayer_Layer1_common_Game",
					UUID = "0a7c5703_b456_46e2_94da_8d7420d04801",
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
					name = "panel_root",
					sizepercentx = "0",
					sizepercenty = "0",
					sizeType = "0",
					srcBlendFunc = "1",
					touchAble = "True",
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
					width = "1386",
					ZOrder = "1",
					components = 
					{
						
						{
							controlID = "img_bg_panel_root_Panel-unZipFileLayer_Layer1_common_Game",
							UUID = "f3fc20d5_67ac_41a1_ac97_496d1a8c1938",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							backGroundScale9Enable = "False",
							classname = "MEImage",
							dstBlendFunc = "771",
							height = "640",
							ignoreSize = "True",
							name = "img_bg",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "770",
							texturePath = "ui/update/s1.png",
							touchAble = "False",
							UILayoutViewModel = 
							{
								
							},
							width = "1386",
							ZOrder = "1",
						},
						{
							controlID = "img_extAssetsDownloadView_1_panel_root_Panel-unZipFileLayer_Layer1_common_Game",
							UUID = "6aadd6d6_23b4_49be_b9f2_13ccaeaf84c1",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							backGroundScale9Enable = "False",
							classname = "MEImage",
							dstBlendFunc = "771",
							height = "80",
							ignoreSize = "False",
							name = "img_extAssetsDownloadView_1",
							scaleY = "0.6",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							texturePath = "ui/update/1763.png",
							touchAble = "False",
							UILayoutViewModel = 
							{
								PositionY = -298,
							},
							width = "1386",
							ZOrder = "1",
						},
						{
							controlID = "label_title_panel_root_Panel-unZipFileLayer_Layer1_common_Game",
							UUID = "d894c4fe_f669_4ceb_8d4b_9deb01f52af2",
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
							name = "label_title",
							nTextAlign = "1",
							nTextHAlign = "1",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "770",
							text = "正在检测补充资源",
							touchAble = "False",
							touchScaleEnable = "False",
							UILayoutViewModel = 
							{
								PositionX = -566,
								PositionY = -295,
							},
							width = "147",
							ZOrder = "1",
						},
						{
							controlID = "img_loadingbg_panel_root_Panel-unZipFileLayer_Layer1_common_Game",
							UUID = "a9244d10_a287_4d33_940f_4ba68376cb81",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							backGroundScale9Enable = "False",
							classname = "MEImage",
							dstBlendFunc = "771",
							height = "12",
							ignoreSize = "False",
							name = "img_loadingbg",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							texturePath = "ui/load_bg.png",
							touchAble = "False",
							UILayoutViewModel = 
							{
								PositionY = -313,
							},
							width = "1386",
							ZOrder = "1",
						},
						{
							controlID = "loadingBar_process_panel_root_Panel-unZipFileLayer_Layer1_common_Game",
							UUID = "17b5499f_9659_4f25_a39f_4626a005a68a",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							backGroundScale9Enable = "False",
							classname = "MELoadingBar",
							direction = "0",
							dstBlendFunc = "771",
							height = "12",
							ignoreSize = "False",
							name = "loadingBar_process",
							percent = "100",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							texture = "ui/load.png",
							touchAble = "False",
							UILayoutViewModel = 
							{
								PositionY = -313,
								relativeToName = "Panel",
							},
							width = "1136",
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
			"ui/update/s1.png",
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

