local t = 
{
	version = 1,
	components = 
	{
		
		{
			controlID = "Panel-kabalaTreeStrongPoint_Layer1_kabalaTree_Game",
			UUID = "201c8a49_cea4_4d4a_a248_5be440ce56d5",
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
					controlID = "Panel_root_Panel-kabalaTreeStrongPoint_Layer1_kabalaTree_Game",
					UUID = "24d06d55_378b_4d4a_924f_3e9e882adcbb",
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
							controlID = "Image_bg_Panel_root_Panel-kabalaTreeStrongPoint_Layer1_kabalaTree_Game",
							UUID = "5324b90b_fac8_42f4_9880_e67fe75e88f5",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							backGroundScale9Enable = "True;capInsetsX:0;capInsetsY:0;capInsetsWidth:0;capInsetsHeight:0",
							classname = "MEImage",
							dstBlendFunc = "771",
							height = "502",
							ignoreSize = "False",
							name = "Image_bg",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							texturePath = "ui/common/pop_ui/pop_bg_01.png",
							touchAble = "False",
							UILayoutViewModel = 
							{
								PositionX = 568,
								PositionY = 320,
								IsPercent = true,
								PercentX = 50,
								PercentY = 50,
							},
							width = "382",
							ZOrder = "1",
							components = 
							{
								
								{
									controlID = "Image_innerbg_Image_bg_Panel_root_Panel-kabalaTreeStrongPoint_Layer1_kabalaTree_Game",
									UUID = "7a043fb3_59b3_45a8_a09e_647cc11209f7",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "200",
									ignoreSize = "False",
									name = "Image_innerbg",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/common/pop_ui/pop_bg_02.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionY = 101,
									},
									width = "356",
									ZOrder = "1",
								},
								{
									controlID = "Button_close_Image_bg_Panel_root_Panel-kabalaTreeStrongPoint_Layer1_kabalaTree_Game",
									UUID = "04374953_c67b_4d40_acd5_75c425e4d6be",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEButton",
									ClickHighLightEnabled = "True",
									dstBlendFunc = "771",
									flipX = "False",
									flipY = "False",
									height = "30",
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
										PositionX = 163,
										PositionY = 221,
									},
									UItype = "Button",
									width = "30",
									ZOrder = "1",
								},
								{
									controlID = "Label_title_Image_bg_Panel_root_Panel-kabalaTreeStrongPoint_Layer1_kabalaTree_Game",
									UUID = "448a5686_2bca_4229_83be_833edbfee2d3",
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
									text = "ข้อมูลฐานที่มั่น",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionX = -177,
										PositionY = 218,
									},
									width = "115",
									ZOrder = "1",
								},
								{
									controlID = "Image_portIcon_Image_bg_Panel_root_Panel-kabalaTreeStrongPoint_Layer1_kabalaTree_Game",
									UUID = "bb0e290f_7302_4295_b815_0d597d0ead8b",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "110",
									ignoreSize = "True",
									name = "Image_portIcon",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/kabalatree/event/floor_question.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionY = 108,
									},
									width = "82",
									ZOrder = "1",
								},
								{
									controlID = "Label_portDesc_Image_bg_Panel_root_Panel-kabalaTreeStrongPoint_Layer1_kabalaTree_Game",
									UUID = "c5a7796f_5a23_4645_88b5_3dca72de46bd",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									classname = "MELabel",
									compPath = "luacomponents.common.MEIconLabel",
									dstBlendFunc = "771",
									FontColor = "#FF101117",
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
									height = "100",
									ignoreSize = "False",
									name = "Label_portDesc",
									nTextAlign = "0",
									nTextHAlign = "0",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "รายละเอียดข้อมูล รายละเอียดข้อมูล รายละเอียดข้อมูล รายละเอียดข้อมูล",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionX = 2,
										PositionY = -60,
									},
									width = "330",
									ZOrder = "1",
								},
								{
									controlID = "Button_ok_Image_bg_Panel_root_Panel-kabalaTreeStrongPoint_Layer1_kabalaTree_Game",
									UUID = "c59fd7b2_528c_4edf_87c0_169ac493607e",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEButton",
									ClickHighLightEnabled = "True",
									dstBlendFunc = "771",
									flipX = "False",
									flipY = "False",
									height = "54",
									ignoreSize = "True",
									name = "Button_ok",
									normal = "ui/kabalatree/btn_3.png",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "True",
									UILayoutViewModel = 
									{
										PositionX = -124,
										PositionY = -213,
									},
									UItype = "Button",
									width = "114",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "Label_btn_Button_ok_Image_bg_Panel_root_Panel-kabalaTreeStrongPoint_Layer1_kabalaTree_Game",
											UUID = "0e7bcf1f_ce0d_47a9_929c_e1d8c7f9d164",
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
											fontSize = "26",
											fontStroke = 
											{
												IsStroke = true,
												StrokeColor = "#1BB2475D",
												StrokeSize = 0.3,
											},
											height = "30",
											ignoreSize = "True",
											name = "Label_btn",
											nTextAlign = "1",
											nTextHAlign = "1",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "770",
											text = "เทเลพอร์ต",
											touchAble = "False",
											touchScaleEnable = "False",
											UILayoutViewModel = 
											{
												
											},
											width = "69",
											ZOrder = "1",
										},
									},
								},
								{
									controlID = "Button_cancle_Image_bg_Panel_root_Panel-kabalaTreeStrongPoint_Layer1_kabalaTree_Game",
									UUID = "0ca4865f_7fb8_4c1d_a5b1_d7e508972cc0",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEButton",
									ClickHighLightEnabled = "True",
									dstBlendFunc = "771",
									flipX = "False",
									flipY = "False",
									height = "54",
									ignoreSize = "True",
									name = "Button_cancle",
									normal = "ui/kabalatree/btn_3.png",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "True",
									UILayoutViewModel = 
									{
										PositionX = 124,
										PositionY = -212,
									},
									UItype = "Button",
									width = "114",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "Label_btn_Button_cancle_Image_bg_Panel_root_Panel-kabalaTreeStrongPoint_Layer1_kabalaTree_Game",
											UUID = "cdc291f5_27aa_4e04_bac8_ad1155a58cf9",
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
											fontSize = "26",
											fontStroke = 
											{
												IsStroke = true,
												StrokeColor = "#FFB2475D",
												StrokeSize = 0.3,
											},
											height = "30",
											ignoreSize = "True",
											name = "Label_btn",
											nTextAlign = "1",
											nTextHAlign = "1",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "770",
											text = "เทเลพอร์ต",
											touchAble = "False",
											touchScaleEnable = "False",
											UILayoutViewModel = 
											{
												
											},
											width = "69",
											ZOrder = "1",
										},
									},
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
			"ui/common/pop_ui/pop_bg_01.png",
			"ui/common/pop_ui/pop_bg_02.png",
			"ui/common/pop_ui/pop_btn_02.png",
			"ui/kabalatree/event/floor_question.png",
			"ui/kabalatree/btn_3.png",
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

