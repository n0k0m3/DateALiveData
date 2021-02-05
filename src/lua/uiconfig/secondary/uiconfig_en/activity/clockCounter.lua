local t = 
{
	version = 1,
	components = 
	{
		
		{
			controlID = "Panel-clockCounter_springFestival_activity_Game",
			UUID = "e826e32c_32fe_40df_a83d_46d9531f86b9",
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
			width = "960",
			ZOrder = "1",
			components = 
			{
				
				{
					controlID = "bg_Panel-clockCounter_springFestival_activity_Game",
					UUID = "3aa8bfc5_8323_4540_bfdc_1a190b3322cc",
					anchorPoint = "False",
					anchorPointX = "0.5",
					anchorPointY = "0.5",
					backGroundScale9Enable = "False",
					classname = "MEImage",
					dstBlendFunc = "771",
					height = "44",
					ignoreSize = "True",
					name = "bg",
					sizepercentx = "0",
					sizepercenty = "0",
					sizeType = "0",
					srcBlendFunc = "1",
					texturePath = "ui/newyear/fishGame/3.png",
					touchAble = "False",
					UILayoutViewModel = 
					{
						
					},
					width = "125",
					ZOrder = "1",
					components = 
					{
						
						{
							controlID = "clockIcon_bg_Panel-clockCounter_springFestival_activity_Game",
							UUID = "ead8a05c_af84_44ac_8337_4a0f39ed2b6f",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							backGroundScale9Enable = "False",
							classname = "MEImage",
							dstBlendFunc = "771",
							height = "30",
							ignoreSize = "True",
							name = "clockIcon",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							texturePath = "ui/newyear/fishGame/2.png",
							touchAble = "False",
							UILayoutViewModel = 
							{
								PositionX = -42,
							},
							width = "30",
							ZOrder = "1",
						},
						{
							controlID = "time_bg_Panel-clockCounter_springFestival_activity_Game",
							UUID = "284bca56_dc68_46cf_8695_da0cb54ee799",
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
							fontSize = "20",
							fontStroke = 
							{
								IsStroke = false,
								StrokeColor = "#FFE6E6E6",
								StrokeSize = 1,
							},
							height = "23",
							ignoreSize = "True",
							name = "time",
							nTextAlign = "1",
							nTextHAlign = "1",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "770",
							text = "00:00:09",
							touchAble = "False",
							touchScaleEnable = "False",
							UILayoutViewModel = 
							{
								PositionX = 13,
								PositionY = -1,
							},
							width = "76",
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
			"ui/newyear/fishGame/3.png",
			"ui/newyear/fishGame/2.png",
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

