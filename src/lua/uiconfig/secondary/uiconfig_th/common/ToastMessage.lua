local t = 
{
	version = 1,
	components = 
	{
		
		{
			controlID = "Panel-ToastMessage_Layer1_common_Game",
			UUID = "42f3a21c_5c62_4d92_89ee_50b6a64c16cc",
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
			height = "192",
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
			width = "1136",
			ZOrder = "1",
			components = 
			{
				
				{
					controlID = "Image_ToastMessage_1_Panel-ToastMessage_Layer1_common_Game",
					UUID = "f2991517_e440_4944_ac34_68687f892a6d",
					anchorPoint = "False",
					anchorPointX = "0.5",
					anchorPointY = "0.5",
					backGroundScale9Enable = "False",
					classname = "MEImage",
					dstBlendFunc = "771",
					height = "136",
					ignoreSize = "True",
					name = "Image_ToastMessage_1",
					sizepercentx = "0",
					sizepercenty = "0",
					sizeType = "0",
					srcBlendFunc = "1",
					texturePath = "ui/common/tips_bg.png",
					touchAble = "False",
					UILayoutViewModel = 
					{
						
					},
					width = "1210",
					ZOrder = "1",
					components = 
					{
						
						{
							controlID = "Image_ToastMessage_icon_Image_ToastMessage_1_Panel-ToastMessage_Layer1_common_Game",
							UUID = "499d2c6f_95d6_491a_b3f1_32f9d0c85135",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							backGroundScale9Enable = "False",
							classname = "MEImage",
							dstBlendFunc = "771",
							height = "44",
							ignoreSize = "True",
							name = "Image_ToastMessage_icon",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							texturePath = "ui/common/tips_icon_normal.png",
							touchAble = "False",
							UILayoutViewModel = 
							{
								PositionY = 45,
							},
							width = "44",
							ZOrder = "1",
						},
						{
							controlID = "text_Image_ToastMessage_1_Panel-ToastMessage_Layer1_common_Game",
							UUID = "efa77b8a_1ff1_4747_899d_427077ff26f3",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							classname = "METextArea",
							dstBlendFunc = "771",
							fontName = "font/fangzheng_zhunyuan.ttf",
							fontShadow = 
							{
								IsShadow = false,
								ShadowColor = "#FFFFFFFF",
								ShadowAlpha = 255,
								OffsetX = 0,
								OffsetY = 0,
							},
							fontSize = "28",
							fontStroke = 
							{
								IsStroke = false,
								StrokeColor = "#FFE6E6E6",
								StrokeSize = 1,
							},
							hAlignment = "1",
							height = "0",
							ignoreSize = "False",
							name = "text",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "770",
							text = "คำเตือน!",
							touchAble = "False",
							touchScaleEnable = "False",
							UILayoutViewModel = 
							{
								PositionY = -11,
							},
							vAlignment = "1",
							width = "1000",
							ZOrder = "1",
						},
					},
				},
				{
					controlID = "Image_ToastMessage_2_Panel-ToastMessage_Layer1_common_Game",
					UUID = "ff160632_047d_453f_b384_4131b6e5ca63",
					anchorPoint = "False",
					anchorPointX = "0.5",
					anchorPointY = "0.5",
					backGroundScale9Enable = "True;capInsetsX:0;capInsetsY:0;capInsetsWidth:0;capInsetsHeight:0",
					classname = "MEImage",
					dstBlendFunc = "771",
					height = "404",
					ignoreSize = "False",
					name = "Image_ToastMessage_2",
					sizepercentx = "0",
					sizepercenty = "0",
					sizeType = "0",
					srcBlendFunc = "1",
					texturePath = "ui/common/pop_ui/pop_bg_01.png",
					touchAble = "False",
					UILayoutViewModel = 
					{
						PositionX = 1,
						PositionY = 2,
						IsPercent = true,
						PercentX = 0.08,
						PercentY = 0.97,
						nGravity = 1,
					},
					visible = "False",
					width = "686",
					ZOrder = "1",
					components = 
					{
						
						{
							controlID = "Label_Title_Image_ToastMessage_2_Panel-ToastMessage_Layer1_common_Game",
							UUID = "545dd6e4_a761_49af_b7a7_dd1c05af9990",
							anchorPoint = "False",
							anchorPointX = "0",
							anchorPointY = "0.5",
							classname = "MELabel",
							compPath = "luacomponents.common.MEIconLabel",
							dstBlendFunc = "771",
							FontColor = "#FF101117",
							fontName = "font/MFLiHei_Noncommercial.ttf",
							fontShadow = 
							{
								IsShadow = false,
								ShadowColor = "#FFFFFFFF",
								ShadowAlpha = 255,
								OffsetX = 0,
								OffsetY = 0,
							},
							fontSize = "34",
							fontStroke = 
							{
								IsStroke = false,
								StrokeColor = "#FFE6E6E6",
								StrokeSize = 1,
							},
							height = "39",
							ignoreSize = "True",
							name = "Label_Title",
							nTextAlign = "1",
							nTextHAlign = "1",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "770",
							text = "ข้อมูลประกาศ",
							touchAble = "False",
							touchScaleEnable = "False",
							UILayoutViewModel = 
							{
								PositionX = -325,
								PositionY = 171,
							},
							width = "164",
							ZOrder = "1",
						},
						{
							controlID = "Image_ToastMessage_bg_Image_ToastMessage_2_Panel-ToastMessage_Layer1_common_Game",
							UUID = "73019fb1_17f8_41f4_a1ed_588a7263ab61",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							backGroundScale9Enable = "False",
							classname = "MEImage",
							dstBlendFunc = "771",
							height = "331",
							ignoreSize = "False",
							name = "Image_ToastMessage_bg",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							texturePath = "ui/common/pop_ui/pop_bg_02.png",
							touchAble = "False",
							UILayoutViewModel = 
							{
								PositionY = -14,
							},
							width = "669",
							ZOrder = "1",
						},
						{
							controlID = "text1_Image_ToastMessage_2_Panel-ToastMessage_Layer1_common_Game",
							UUID = "d1b5b71e_60dd_4d60_99e9_620dce9322a9",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							classname = "METextArea",
							dstBlendFunc = "771",
							fontName = "font/fangzheng_zhunyuan.ttf",
							fontShadow = 
							{
								IsShadow = false,
								ShadowColor = "#FFFFFFFF",
								ShadowAlpha = 255,
								OffsetX = 0,
								OffsetY = 0,
							},
							fontSize = "26",
							fontStroke = 
							{
								IsStroke = false,
								StrokeColor = "#FFE6E6E6",
								StrokeSize = 1,
							},
							hAlignment = "1",
							height = "200",
							ignoreSize = "False",
							name = "text1",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "770",
							text = "พื้นที่ข้อความพื้นที่ข้อความพื้นที่ข้อความพื้นที่ข้อความพื้นที่ข้อความพื้นที่ข้อความพื้นที่ข้อความพื้นที่ข้อความพื้นที่ข้อความพื้นที่ข้อความพื้นที่ข้อความพื้นที่ข้อความพื้นที่ข้อความพื้นที่ข้อความพื้นที่ข้อความพื้นที่ข้อความพื้นที่ข้อความ",
							touchAble = "False",
							touchScaleEnable = "False",
							UILayoutViewModel = 
							{
								PositionX = -1,
								PositionY = -8,
								IsPercent = true,
								PercentX = -0.2,
								PercentY = -2.06,
							},
							vAlignment = "1",
							width = "500",
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
			"ui/common/tips_bg.png",
			"ui/common/tips_icon_normal.png",
			"ui/common/pop_ui/pop_bg_01.png",
			"ui/common/pop_ui/pop_bg_02.png",
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

