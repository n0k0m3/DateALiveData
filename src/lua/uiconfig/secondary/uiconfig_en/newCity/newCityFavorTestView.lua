local t = 
{
	version = 1,
	components = 
	{
		
		{
			controlID = "Panel-newCityFavorTestView_Layer1_newCity_Game",
			UUID = "7bc4bf92_0f36_4f47_9623_46dcd6056ea4",
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
					controlID = "Panel_base_Panel-newCityFavorTestView_Layer1_newCity_Game",
					UUID = "dab22898_3dcb_447f_b97b_204257ba80bb",
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
							controlID = "TextField_input_Panel_base_Panel-newCityFavorTestView_Layer1_newCity_Game",
							UUID = "42774b25_558d_41a7_bead_816756af6744",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							classname = "METextField",
							CursorEnabled = "True",
							dstBlendFunc = "771",
							fontName = "font/fangzheng_zhunyuan.ttf",
							fontSize = "32",
							hAlignment = "0",
							height = "36",
							ignoreSize = "False",
							KeyBoradType = "1",
							maxLengthEnable = "False",
							name = "TextField_input",
							outlineColor = "#FF000000",
							outlineSize = "1",
							passwordEnable = "False",
							placeHolder = "Main ID",
							shadowColor = "#FF000000",
							shadowHeight = "0",
							shadowWidth = "0",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "770",
							touchAble = "True",
							UILayoutViewModel = 
							{
								PositionX = 124,
								PositionY = 111,
								LeftPositon = 18,
								TopPosition = 22,
								relativeToName = "Panel_base",
							},
							useOutline = "False",
							useShadow = "False",
							vAlignment = "0",
							width = "200",
							ZOrder = "1",
						},
						{
							controlID = "Button_send_Panel_base_Panel-newCityFavorTestView_Layer1_newCity_Game",
							UUID = "8a5eb316_f735_44ef_acb7_53d3f870f816",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							backGroundScale9Enable = "False",
							classname = "MEButton",
							ClickHighLightEnabled = "True",
							dstBlendFunc = "771",
							flipX = "False",
							flipY = "False",
							height = "45",
							ignoreSize = "True",
							name = "Button_send",
							normal = "ui/common/button02.png",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							touchAble = "True",
							UILayoutViewModel = 
							{
								PositionX = 179,
								PositionY = 228,
							},
							UItype = "Button",
							width = "124",
							ZOrder = "1",
						},
						{
							controlID = "ScrollView_data_Panel_base_Panel-newCityFavorTestView_Layer1_newCity_Game",
							UUID = "02cd9400_16a3_4c6e_b4d2_6a724ec30e81",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							backGroundScale9Enable = "False",
							bgColorOpacity = "20",
							bIsOpenClipping = "True",
							bounceEnable = "True",
							classname = "MEScrollView",
							colorType = "1;SingleColor:#FFFFFF00;GraduallyChangingColorStart:#FFFFFFFF;GraduallyChangingColorEnd:#FFFFFFFF;vectorX:0;vectorY:0",
							direction = "1",
							dstBlendFunc = "771",
							height = "500",
							ignoreSize = "False",
							innerHeight = "500",
							innerWidth = "600",
							name = "ScrollView_data",
							showScrollbar = "False",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							touchAble = "True",
							UILayoutViewModel = 
							{
								PositionX = 568,
								PositionY = 288,
								IsPercent = true,
								PercentX = 50,
								PercentY = 45,
							},
							uipanelviewmodel = 
							{
								Layout="Absolute",
								nType = "0"
							},
							width = "600",
							ZOrder = "1",
						},
						{
							controlID = "Label_data_Panel_base_Panel-newCityFavorTestView_Layer1_newCity_Game",
							UUID = "7632a356_99c0_4e6f_aa88_eb2b7f150f06",
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
							height = "30",
							ignoreSize = "True",
							name = "Label_data",
							nTextAlign = "1",
							nTextHAlign = "1",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "770",
							text = "TextLable",
							touchAble = "False",
							touchScaleEnable = "False",
							UILayoutViewModel = 
							{
								PositionX = 193,
								PositionY = 554,
							},
							visible = "False",
							width = "104",
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
			"ui/common/button02.png",
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

