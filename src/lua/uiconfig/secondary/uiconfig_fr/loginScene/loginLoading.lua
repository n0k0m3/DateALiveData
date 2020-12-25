local t = 
{
	version = 1,
	components = 
	{
		
		{
			controlID = "Panel-loginLoading_Layer1_loginScene_Game",
			UUID = "111675a8_afb2_42fb_b079_ff43192dbe6d",
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
			height = "0",
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
			width = "0",
			ZOrder = "1",
			components = 
			{
				
				{
					controlID = "Panel_base_Panel-loginLoading_Layer1_loginScene_Game",
					UUID = "783d041e_f743_47bc_8bfb_b93512ad7668",
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
							controlID = "Image_bg_Panel_base_Panel-loginLoading_Layer1_loginScene_Game",
							UUID = "3a7e15d1_f700_4621_ac44_79f1117501e4",
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
							texturePath = "login/back.png",
							touchAble = "False",
							UILayoutViewModel = 
							{
								PositionX = 568,
								PositionY = 320,
								IsPercent = true,
								PercentX = 50,
								PercentY = 50,
								LeftPositon = -32,
								TopPosition = 608,
								relativeToName = "Panel",
							},
							width = "1386",
							ZOrder = "1",
						},
						{
							controlID = "logo2_Panel_base_Panel-loginLoading_Layer1_loginScene_Game",
							UUID = "91e67924_7018_465b_b1c4_3aa57412582c",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							backGroundScale9Enable = "False",
							classname = "MEImage",
							dstBlendFunc = "771",
							height = "83",
							ignoreSize = "True",
							name = "logo2",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							texturePath = "login/logo.png",
							touchAble = "False",
							UILayoutViewModel = 
							{
								PositionX = 569,
								PositionY = 130,
								IsPercent = true,
								PercentX = 50.11,
								PercentY = 20.35,
							},
							width = "344",
							ZOrder = "1",
						},
						{
							controlID = "loading_title_Panel_base_Panel-loginLoading_Layer1_loginScene_Game",
							UUID = "57891108_978a_48d9_adb6_f74bdfd77ced",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							backGroundScale9Enable = "False",
							classname = "MEImage",
							dstBlendFunc = "771",
							height = "29",
							ignoreSize = "True",
							name = "loading_title",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							texturePath = "login/loading.png",
							touchAble = "False",
							UILayoutViewModel = 
							{
								PositionX = 574,
								PositionY = 71,
							},
							width = "109",
							ZOrder = "1",
						},
						{
							controlID = "loading_bg_Panel_base_Panel-loginLoading_Layer1_loginScene_Game",
							UUID = "ab6404ed_07e6_4b0e_845e_9eccb01cb5bb",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							backGroundScale9Enable = "False",
							classname = "MEImage",
							dstBlendFunc = "771",
							height = "10",
							ignoreSize = "True",
							name = "loading_bg",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							texturePath = "login/loading01.png",
							touchAble = "False",
							UILayoutViewModel = 
							{
								PositionX = 568,
								PositionY = 54,
								IsPercent = true,
								PercentX = 50,
								PercentY = 8.5,
							},
							width = "727",
							ZOrder = "1",
						},
						{
							controlID = "LoadingBar_Panel_base_Panel-loginLoading_Layer1_loginScene_Game",
							UUID = "4cfedec0_41f2_4043_8a77_b344971ba42a",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							backGroundScale9Enable = "False",
							classname = "MELoadingBar",
							direction = "0",
							dstBlendFunc = "771",
							height = "6",
							ignoreSize = "True",
							name = "LoadingBar",
							percent = "100",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							texture = "login/loading02.png",
							touchAble = "False",
							UILayoutViewModel = 
							{
								PositionX = 568,
								PositionY = 54,
								IsPercent = true,
								PercentX = 50,
								PercentY = 8.5,
							},
							width = "723",
							ZOrder = "1",
						},
						{
							controlID = "Label_updateLayer_1_Panel_base_Panel-loginLoading_Layer1_loginScene_Game",
							UUID = "a01f88e8_4c4d_4b03_b219_85104dba53cc",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							classname = "MELabel",
							compPath = "luacomponents.common.MEIconLabel",
							dstBlendFunc = "771",
							FontColor = "#FF000000",
							fontName = "simhei",
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
							height = "29",
							ignoreSize = "True",
							name = "Label_updateLayer_1",
							nTextAlign = "1",
							nTextHAlign = "1",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "770",
							text = "Chargement...",
							touchAble = "False",
							touchScaleEnable = "False",
							UILayoutViewModel = 
							{
								PositionX = 568,
								PositionY = 26,
								IsPercent = true,
								PercentX = 50,
								PercentY = 4.06,
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
			"login/back.png",
			"login/logo.png",
			"login/loading.png",
			"login/loading01.png",
			"login/loading02.png",
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

