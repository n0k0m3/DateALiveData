local t = 
{
	version = 1,
	components = 
	{
		
		{
			controlID = "Panel-skillPreview_angelInfo_angelNew_Game",
			UUID = "8dda071f_42cc_4496_bbdb_3933f53b29af",
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
			height = "710",
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
			width = "1020",
			ZOrder = "1",
			components = 
			{
				
				{
					controlID = "Panel_root_Panel-skillPreview_angelInfo_angelNew_Game",
					UUID = "a4c467ae_9691_4fc5_9c46_c3d6c6369a76",
					anchorPoint = "False",
					anchorPointX = "0.5",
					anchorPointY = "0.5",
					backGroundScale9Enable = "False",
					bgColorOpacity = "98",
					bIsOpenClipping = "False",
					classname = "MEPanel",
					colorType = "1;SingleColor:#FF000000;GraduallyChangingColorStart:#FFFFFFFF;GraduallyChangingColorEnd:#FFFFFFFF;vectorX:0;vectorY:0",
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
							controlID = "Image_bg_Panel_root_Panel-skillPreview_angelInfo_angelNew_Game",
							UUID = "15de9add_2cb0_4521_90ff_7dbff66cf4e3",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							backGroundScale9Enable = "True;capInsetsX:0;capInsetsY:0;capInsetsWidth:0;capInsetsHeight:0",
							classname = "MEImage",
							dstBlendFunc = "771",
							height = "360",
							ignoreSize = "False",
							name = "Image_bg",
							sizepercentx = "100",
							sizepercenty = "100",
							sizeType = "0",
							srcBlendFunc = "1",
							texturePath = "ui/common/pop_ui/pop_bg_01.png",
							touchAble = "False",
							UILayoutViewModel = 
							{
								PositionX = 1,
								relativeToName = "Panel_root",
								nGravity = 6,
								nAlign = 5
							},
							width = "680",
							ZOrder = "1",
							components = 
							{
								
								{
									controlID = "Image_itemInfoView_2_Image_bg_Panel_root_Panel-skillPreview_angelInfo_angelNew_Game",
									UUID = "3c6e2e4c_c8c1_470f_8ef7_8160c57619e2",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "255",
									ignoreSize = "False",
									name = "Image_itemInfoView_2",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/common/pop_ui/pop_bg_02.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										
									},
									width = "662",
									ZOrder = "1",
								},
								{
									controlID = "Button_close_Image_bg_Panel_root_Panel-skillPreview_angelInfo_angelNew_Game",
									UUID = "f6f5ab6f_0a46_4051_8859_de8d4128891a",
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
									pressed = "ui/common/pop_ui/pop_btn_02.png",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "True",
									UILayoutViewModel = 
									{
										PositionX = 308,
										PositionY = 150,
									},
									UItype = "Button",
									width = "30",
									ZOrder = "1",
								},
								{
									controlID = "Label_title_Image_bg_Panel_root_Panel-skillPreview_angelInfo_angelNew_Game",
									UUID = "7015a3f0_bd4d_4fab_b776_443095d07dda",
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
									text = "技能预览",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionX = -320,
										PositionY = 148,
									},
									width = "115",
									ZOrder = "1",
								},
								{
									controlID = "Image_skillPreview_1_Image_bg_Panel_root_Panel-skillPreview_angelInfo_angelNew_Game",
									UUID = "910ab86a_5334_491e_8fa0_d45bdd4ef709",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "27",
									ignoreSize = "True",
									name = "Image_skillPreview_1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/fairy_angle/2.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = -142,
										PositionY = 150,
									},
									width = "121",
									ZOrder = "1",
								},
								{
									controlID = "Image_skillPreview_2(2)_Image_bg_Panel_root_Panel-skillPreview_angelInfo_angelNew_Game",
									UUID = "7c7651c4_e1c4_450b_91c6_52171218b124",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "42",
									ignoreSize = "True",
									name = "Image_skillPreview_2(2)",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/fairy_angle/3.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = 8,
										PositionY = 84,
									},
									width = "206",
									ZOrder = "1",
								},
								{
									controlID = "Button_skillPreview_1_Image_bg_Panel_root_Panel-skillPreview_angelInfo_angelNew_Game",
									UUID = "530bde49_97fc_4a76_a584_78271a4a6e4c",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEButton",
									ClickHighLightEnabled = "True",
									dstBlendFunc = "771",
									flipX = "False",
									flipY = "False",
									height = "137",
									ignoreSize = "True",
									name = "Button_skillPreview_1",
									normal = "ui/fairy_angle/1.png",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "True",
									UILayoutViewModel = 
									{
										PositionY = -19,
									},
									UItype = "Button",
									width = "136",
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
			"ui/common/pop_ui/pop_bg_01.png",
			"ui/common/pop_ui/pop_bg_02.png",
			"ui/common/pop_ui/pop_btn_02.png",
			"ui/fairy_angle/2.png",
			"ui/fairy_angle/3.png",
			"ui/fairy_angle/1.png",
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

