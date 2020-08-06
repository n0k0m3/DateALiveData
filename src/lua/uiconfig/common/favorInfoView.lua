local t = 
{
	version = 1,
	components = 
	{
		
		{
			controlID = "Panel-favorInfoView_Layer1_common_Game",
			UUID = "7074efdc_ad77_42e8_ac34_60c2802d3d82",
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
					controlID = "Image_bottom_Panel-favorInfoView_Layer1_common_Game",
					UUID = "d5dbd4bf_938a_4ca9_b812_856ed8ba6c98",
					anchorPoint = "False",
					anchorPointX = "0.5",
					anchorPointY = "0.5",
					backGroundScale9Enable = "False",
					classname = "MEImage",
					dstBlendFunc = "771",
					height = "106",
					ignoreSize = "True",
					name = "Image_bottom",
					sizepercentx = "0",
					sizepercenty = "0",
					sizeType = "0",
					srcBlendFunc = "1",
					texturePath = "ui/kanbanniang/001.png",
					touchAble = "False",
					UILayoutViewModel = 
					{
						
					},
					width = "290",
					ZOrder = "1",
					components = 
					{
						
						{
							controlID = "Image_favorStar_Image_bottom_Panel-favorInfoView_Layer1_common_Game",
							UUID = "3e02bfe3_97e8_47b7_869c_2b8c6c900848",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							backGroundScale9Enable = "False",
							classname = "MEImage",
							dstBlendFunc = "771",
							height = "24",
							ignoreSize = "True",
							name = "Image_favorStar",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							texturePath = "ui/kanbanniang/003.png",
							touchAble = "False",
							UILayoutViewModel = 
							{
								PositionX = -110,
								PositionY = 20,
							},
							width = "26",
							ZOrder = "1",
						},
						{
							controlID = "Label_title_Image_bottom_Panel-favorInfoView_Layer1_common_Game",
							UUID = "72dd7432_abee_47a6_be67_a69f993418fb",
							anchorPoint = "False",
							anchorPointX = "0",
							anchorPointY = "0.5",
							classname = "MELabel",
							compPath = "luacomponents.common.MEIconLabel",
							dstBlendFunc = "771",
							FontColor = "#FF70718D",
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
							name = "Label_title",
							nTextAlign = "1",
							nTextHAlign = "1",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "770",
							text = "好感度等级",
							touchAble = "False",
							touchScaleEnable = "False",
							UILayoutViewModel = 
							{
								PositionX = -87,
								PositionY = 15,
							},
							width = "123",
							ZOrder = "1",
						},
						{
							controlID = "Label_favorValue_Image_bottom_Panel-favorInfoView_Layer1_common_Game",
							UUID = "ada8f2db_14ff_4af4_887f_ffb2b5260e6f",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							classname = "MELabel",
							compPath = "luacomponents.common.MEIconLabel",
							dstBlendFunc = "771",
							FontColor = "#FF70718D",
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
							name = "Label_favorValue",
							nTextAlign = "1",
							nTextHAlign = "1",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "770",
							text = "3",
							touchAble = "False",
							touchScaleEnable = "False",
							UILayoutViewModel = 
							{
								PositionX = 68,
								PositionY = 15,
							},
							width = "15",
							ZOrder = "1",
						},
						{
							controlID = "Image_favorProgress_Image_bottom_Panel-favorInfoView_Layer1_common_Game",
							UUID = "63e6ad75_e3e0_46f1_9d52_8c55b1d09fea",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							backGroundScale9Enable = "True;capInsetsX:0;capInsetsY:0;capInsetsWidth:0;capInsetsHeight:0",
							classname = "MEImage",
							dstBlendFunc = "771",
							height = "12",
							ignoreSize = "False",
							name = "Image_favorProgress",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							texturePath = "ui/kanbanniang/005.png",
							touchAble = "False",
							UILayoutViewModel = 
							{
								PositionX = -23,
								PositionY = -26,
							},
							width = "220",
							ZOrder = "1",
							components = 
							{
								
								{
									controlID = "LoadingBar_favor_Image_favorProgress_Image_bottom_Panel-favorInfoView_Layer1_common_Game",
									UUID = "d8b67912_adc8_42b7_8859_43cb25594041",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "True;capInsetsX:0;capInsetsY:0;capInsetsWidth:0;capInsetsHeight:0",
									classname = "MELoadingBar",
									direction = "0",
									dstBlendFunc = "771",
									height = "12",
									ignoreSize = "False",
									name = "LoadingBar_favor",
									percent = "100",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texture = "ui/kanbanniang/004.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										
									},
									width = "220",
									ZOrder = "1",
								},
							},
						},
						{
							controlID = "Image_enter_Image_bottom_Panel-favorInfoView_Layer1_common_Game",
							UUID = "7c60800e_038e_4c2f_94cf_db2f9aafd3f5",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							backGroundScale9Enable = "True;capInsetsX:0;capInsetsY:0;capInsetsWidth:0;capInsetsHeight:0",
							classname = "MEImage",
							dstBlendFunc = "771",
							height = "90",
							ignoreSize = "False",
							name = "Image_enter",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							texturePath = "ui/kanbanniang/002.png",
							touchAble = "False",
							UILayoutViewModel = 
							{
								PositionX = 116,
							},
							width = "40",
							ZOrder = "1",
							components = 
							{
								
								{
									controlID = "Label_enter_Image_enter_Image_bottom_Panel-favorInfoView_Layer1_common_Game",
									UUID = "a9a0fddf_dc42_4420_92a1_5b5f698dc5ff",
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
									fontSize = "30",
									fontStroke = 
									{
										IsStroke = false,
										StrokeColor = "#FFE6E6E6",
										StrokeSize = 1,
									},
									height = "90",
									ignoreSize = "False",
									name = "Label_enter",
									nTextAlign = "1",
									nTextHAlign = "1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "编辑",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										
									},
									width = "40",
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
			"ui/kanbanniang/001.png",
			"ui/kanbanniang/003.png",
			"ui/kanbanniang/005.png",
			"ui/kanbanniang/004.png",
			"ui/kanbanniang/002.png",
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

