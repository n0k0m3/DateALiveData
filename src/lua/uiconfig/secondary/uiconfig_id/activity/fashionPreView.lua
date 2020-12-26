local t = 
{
	version = 1,
	components = 
	{
		
		{
			controlID = "Panel-fashionPreView_Layer1_activity_Game",
			UUID = "3ec5e9e1_c176_4da3_bed3_a3eb0c9b29f1",
			anchorPoint = "False",
			anchorPointX = "0",
			anchorPointY = "0",
			backGroundScale9Enable = "False",
			bgColorOpacity = "0",
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
			sizepercentx = "100",
			sizepercenty = "100",
			sizeType = "1",
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
					controlID = "Panel_root_Panel-fashionPreView_Layer1_activity_Game",
					UUID = "2c90a3d6_505e_4a58_b1c8_1d9bfba15848",
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
					DesignWidth = "960",
					dstBlendFunc = "771",
					height = "640",
					ignoreSize = "False",
					name = "Panel_root",
					sizepercentx = "0",
					sizepercenty = "0",
					sizeType = "0",
					srcBlendFunc = "1",
					touchAble = "False",
					UILayoutViewModel = 
					{
						PositionX = 568,
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
					width = "1136",
					ZOrder = "1",
					components = 
					{
						
						{
							controlID = "Image_content_Panel_root_Panel-fashionPreView_Layer1_activity_Game",
							UUID = "4c8aa8a9_c777_4ea8_a3db_bdabded9a02c",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							backGroundScale9Enable = "True;capInsetsX:80;capInsetsY:80;capInsetsWidth:10;capInsetsHeight:10",
							classname = "MEImage",
							dstBlendFunc = "771",
							height = "500",
							ignoreSize = "False",
							name = "Image_content",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							texturePath = "ui/common/mini_pop/9.png",
							touchAble = "True",
							UILayoutViewModel = 
							{
								
							},
							width = "400",
							ZOrder = "1",
							components = 
							{
								
								{
									controlID = "Image_fashionPreView_2_Image_content_Panel_root_Panel-fashionPreView_Layer1_activity_Game",
									UUID = "b2ce6833_2725_4050_a6a8_06603d958dee",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "True;capInsetsX:0;capInsetsY:0;capInsetsWidth:0;capInsetsHeight:0",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "450",
									ignoreSize = "False",
									name = "Image_fashionPreView_2",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/common/mini_pop/7.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = -3,
										PositionY = -26,
									},
									width = "392",
									ZOrder = "1",
								},
								{
									controlID = "Label_title_Image_content_Panel_root_Panel-fashionPreView_Layer1_activity_Game",
									UUID = "94b12205_bc8d_4ca4_ab5b_90cc5f4fc904",
									anchorPoint = "False",
									anchorPointX = "0",
									anchorPointY = "0.5",
									classname = "MELabel",
									compPath = "luacomponents.common.MEIconLabel",
									dstBlendFunc = "771",
									FontColor = "#FF30354A",
									fontName = "font/MFLiHei_Noncommercial.ttf",
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
									height = "35",
									ignoreSize = "True",
									name = "Label_title",
									nTextAlign = "1",
									nTextHAlign = "1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "灵装预览",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionX = -248,
										PositionY = 218,
									},
									visible = "False",
									width = "115",
									ZOrder = "1",
								},
								{
									controlID = "Image_fashionPreView_1_Image_content_Panel_root_Panel-fashionPreView_Layer1_activity_Game",
									UUID = "79642844_52c4_47f3_be71_accbaaf97c3f",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "26",
									ignoreSize = "True",
									name = "Image_fashionPreView_1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/common/pop_ui/pop_ui_02.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = -128,
										PositionY = 219,
									},
									visible = "False",
									width = "2",
									ZOrder = "1",
								},
								{
									controlID = "Label_title_en_Image_content_Panel_root_Panel-fashionPreView_Layer1_activity_Game",
									UUID = "7da3bc79_125c_40a9_b5be_7623fcea3df9",
									anchorPoint = "False",
									anchorPointX = "0",
									anchorPointY = "0.5",
									classname = "MELabel",
									compPath = "luacomponents.common.MEIconLabel",
									dstBlendFunc = "771",
									FontColor = "#FF30354A",
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
									name = "Label_title_en",
									nTextAlign = "1",
									nTextHAlign = "1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "Infomation PreView",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionX = -195,
										PositionY = 218,
									},
									width = "308",
									ZOrder = "1",
								},
								{
									controlID = "Panel_clip_Image_content_Panel_root_Panel-fashionPreView_Layer1_activity_Game",
									UUID = "2dff8085_b38b_43c4_8095_c016c05e3da3",
									anchorPoint = "False",
									anchorPointX = "0",
									anchorPointY = "0",
									backGroundScale9Enable = "False",
									bgColorOpacity = "50",
									bIsOpenClipping = "True",
									classname = "MEPanel",
									colorType = "0;SingleColor:#FFE6E6E6;GraduallyChangingColorStart:#FFFFFFFF;GraduallyChangingColorEnd:#FFFFFFFF;vectorX:0;vectorY:0",
									DesignHeight = "640",
									DesignType = "0",
									DesignWidth = "960",
									dstBlendFunc = "771",
									height = "445",
									ignoreSize = "False",
									name = "Panel_clip",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = -198,
										PositionY = -247,
									},
									uipanelviewmodel = 
									{
										Layout="Absolute",
										nType = "0"
									},
									width = "392",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "Image_fashion_Panel_clip_Image_content_Panel_root_Panel-fashionPreView_Layer1_activity_Game",
											UUID = "c3a3849d_2390_4675_b439_d674b2e46020",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											classname = "MEImage",
											dstBlendFunc = "771",
											height = "64",
											ignoreSize = "True",
											name = "Image_fashion",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 134,
												PositionY = 281,
											},
											width = "64",
											ZOrder = "1",
										},
									},
								},
								{
									controlID = "Button_close_Image_content_Panel_root_Panel-fashionPreView_Layer1_activity_Game",
									UUID = "bc8ec068_3711_4f41_966e_4f8714f9e8dd",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEButton",
									ClickHighLightEnabled = "True",
									dstBlendFunc = "771",
									flipX = "False",
									flipY = "False",
									height = "60",
									ignoreSize = "True",
									name = "Button_close",
									normal = "ui/common/pop_ui/pop_btn_02.png",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "True",
									UILayoutViewModel = 
									{
										PositionX = 172,
										PositionY = 220,
									},
									UItype = "Button",
									width = "60",
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
			"ui/common/mini_pop/9.png",
			"ui/common/mini_pop/7.png",
			"ui/common/pop_ui/pop_ui_02.png",
			"ui/common/pop_ui/pop_btn_02.png",
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

