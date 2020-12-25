local t = 
{
	version = 1,
	components = 
	{
		
		{
			controlID = "Panel-itemCoolDownTips_Layer1_common_Game",
			UUID = "b255162b_b3ec_45b0_88dc_15a8ab6fa59f",
			anchorPoint = "False",
			anchorPointX = "0.5",
			anchorPointY = "0.5",
			backGroundScale9Enable = "False",
			bgColorOpacity = "255",
			bIsOpenClipping = "False",
			classname = "MEPanel",
			colorType = "0;SingleColor:#FFE6E6E6;GraduallyChangingColorStart:#FFFFFFFF;GraduallyChangingColorEnd:#FFFFFFFF;vectorX:0;vectorY:0",
			DesignHeight = "640",
			DesignType = "0",
			DesignWidth = "501",
			dstBlendFunc = "771",
			height = "76",
			ignoreSize = "False",
			name = "Panel",
			sizepercentx = "44",
			sizepercenty = "30",
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
			width = "175",
			ZOrder = "1",
			components = 
			{
				
				{
					controlID = "Image_tips_bg_Panel-itemCoolDownTips_Layer1_common_Game",
					UUID = "c35ae202_cbc1_4317_bea0_5ebb25e7275d",
					anchorPoint = "False",
					anchorPointX = "0.5",
					anchorPointY = "0.5",
					backGroundScale9Enable = "False",
					classname = "MEImage",
					dstBlendFunc = "771",
					height = "76",
					ignoreSize = "True",
					name = "Image_tips_bg",
					sizepercentx = "0",
					sizepercenty = "0",
					sizeType = "0",
					srcBlendFunc = "1",
					texturePath = "ui/common/cool_down_tips_bg.png",
					touchAble = "False",
					UILayoutViewModel = 
					{
						
					},
					width = "175",
					ZOrder = "1",
					components = 
					{
						
						{
							controlID = "Label_tips_single_Image_tips_bg_Panel-itemCoolDownTips_Layer1_common_Game",
							UUID = "5c054326_8a69_4fad_916d_3a88a8a85ca4",
							anchorPoint = "False",
							anchorPointX = "0",
							anchorPointY = "0.5",
							classname = "MELabel",
							compPath = "luacomponents.common.MEIconLabel",
							dstBlendFunc = "771",
							FontColor = "#FF30354A",
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
							height = "0",
							ignoreSize = "False",
							name = "Label_tips_single",
							nTextAlign = "1",
							nTextHAlign = "0",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "770",
							text = "Wiederhergestellt um 1 in 00:00",
							touchAble = "False",
							touchScaleEnable = "False",
							UILayoutViewModel = 
							{
								PositionX = -72,
							},
							width = "150",
							ZOrder = "1",
						},
						{
							controlID = "Label_tips_total_Image_tips_bg_Panel-itemCoolDownTips_Layer1_common_Game",
							UUID = "83e3d357_9904_4ad8_8e34_e03251c485bd",
							anchorPoint = "False",
							anchorPointX = "0",
							anchorPointY = "0.5",
							classname = "MELabel",
							compPath = "luacomponents.common.MEIconLabel",
							dstBlendFunc = "771",
							FontColor = "#FF30354A",
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
							height = "0",
							ignoreSize = "False",
							name = "Label_tips_total",
							nTextAlign = "0",
							nTextHAlign = "0",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "770",
							text = "Vollständig wiederhergestellt in 00:00:00",
							touchAble = "False",
							touchScaleEnable = "False",
							UILayoutViewModel = 
							{
								PositionX = -74,
								PositionY = -2,
							},
							width = "150",
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
			"ui/common/cool_down_tips_bg.png",
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

