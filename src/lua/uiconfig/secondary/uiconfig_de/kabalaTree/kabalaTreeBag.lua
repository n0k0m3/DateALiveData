local t = 
{
	version = 1,
	components = 
	{
		
		{
			controlID = "Panel-kabalaTreeBag_Layer1_kabalaTree_Game",
			UUID = "170e4457_d22b_461c_a152_6902be4ee448",
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
					controlID = "Panel_root_Panel-kabalaTreeBag_Layer1_kabalaTree_Game",
					UUID = "ea96d174_047a_45b6_b65c_a59697647a29",
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
							controlID = "Image_bg_Panel_root_Panel-kabalaTreeBag_Layer1_kabalaTree_Game",
							UUID = "57d264d6_1e68_4b63_bfe0_53ed46e28ecf",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							backGroundScale9Enable = "True;capInsetsX:0;capInsetsY:0;capInsetsWidth:0;capInsetsHeight:0",
							classname = "MEImage",
							dstBlendFunc = "771",
							height = "412",
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
							width = "730",
							ZOrder = "1",
							components = 
							{
								
								{
									controlID = "Image_innerbg_Image_bg_Panel_root_Panel-kabalaTreeBag_Layer1_kabalaTree_Game",
									UUID = "8b3f3156_7adf_420a_bfdb_9baa7b3bc46f",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "340",
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
										PositionY = -17,
									},
									width = "712",
									ZOrder = "1",
								},
								{
									controlID = "Button_close_Image_bg_Panel_root_Panel-kabalaTreeBag_Layer1_kabalaTree_Game",
									UUID = "9106f75c_675d_4554_9b1e_5fb501ba5161",
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
										PositionX = 337,
										PositionY = 178,
									},
									UItype = "Button",
									width = "60",
									ZOrder = "1",
								},
								{
									controlID = "Label_title_Image_bg_Panel_root_Panel-kabalaTreeBag_Layer1_kabalaTree_Game",
									UUID = "f93b5b41_a442_4655_a35e_85ab1e300653",
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
									text = "Tasche",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionX = -352,
										PositionY = 172,
									},
									width = "58",
									ZOrder = "1",
								},
								{
									controlID = "ScrollView_bag_Image_bg_Panel_root_Panel-kabalaTreeBag_Layer1_kabalaTree_Game",
									UUID = "eac84fa7_dbf2_445d_9d7e_42cc7f1683ea",
									anchorPoint = "False",
									anchorPointX = "0",
									anchorPointY = "0",
									backGroundScale9Enable = "False",
									bgColorOpacity = "50",
									bIsOpenClipping = "True",
									bounceEnable = "False",
									classname = "MEScrollView",
									colorType = "0;SingleColor:#FFFF0000;GraduallyChangingColorStart:#FFFFFFFF;GraduallyChangingColorEnd:#FFFFFFFF;vectorX:0;vectorY:0",
									direction = "1",
									dstBlendFunc = "771",
									height = "328",
									ignoreSize = "False",
									innerHeight = "330",
									innerWidth = "712",
									name = "ScrollView_bag",
									showScrollbar = "False",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "True",
									UILayoutViewModel = 
									{
										PositionX = -357,
										PositionY = -182,
									},
									uipanelviewmodel = 
									{
										Layout="Absolute",
										nType = "0"
									},
									width = "712",
									ZOrder = "1",
								},
								{
									controlID = "Image_kabalaTreeMapInfo_2_Image_bg_Panel_root_Panel-kabalaTreeBag_Layer1_kabalaTree_Game",
									UUID = "d36d319b_ca93_4b67_8a48_b6a9cf0f8775",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "27",
									ignoreSize = "True",
									name = "Image_kabalaTreeMapInfo_2",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/common/image_title.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = -228,
										PositionY = 173,
									},
									width = "121",
									ZOrder = "1",
								},
							},
						},
					},
				},
				{
					controlID = "Panel_prefab_Panel-kabalaTreeBag_Layer1_kabalaTree_Game",
					UUID = "7630b9c7_e91e_4897_b5b1_56f69796a85d",
					anchorPoint = "False",
					anchorPointX = "0",
					anchorPointY = "0",
					backGroundScale9Enable = "False",
					bgColorOpacity = "50",
					bIsOpenClipping = "False",
					classname = "MEPanel",
					colorType = "1;SingleColor:#FFE6E6E6;GraduallyChangingColorStart:#FFFFFFFF;GraduallyChangingColorEnd:#FFFFFFFF;vectorX:0;vectorY:0",
					DesignHeight = "640",
					DesignType = "0",
					DesignWidth = "960",
					dstBlendFunc = "771",
					height = "640",
					ignoreSize = "False",
					name = "Panel_prefab",
					sizepercentx = "100",
					sizepercenty = "100",
					sizeType = "1",
					srcBlendFunc = "1",
					touchAble = "False",
					UILayoutViewModel = 
					{
						PositionX = 6,
						PositionY = -795,
						LeftPositon = 6,
						TopPosition = 795,
						relativeToName = "Panel",
						nType = 3,
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
							controlID = "Panel_bagItem_Panel_prefab_Panel-kabalaTreeBag_Layer1_kabalaTree_Game",
							UUID = "83681e1e_7646_42f1_86ce_b1f3ae5755fc",
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
							height = "108",
							ignoreSize = "False",
							name = "Panel_bagItem",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							touchAble = "False",
							UILayoutViewModel = 
							{
								PositionX = 541,
								PositionY = 433,
							},
							uipanelviewmodel = 
							{
								Layout="Absolute",
								nType = "0"
							},
							width = "700",
							ZOrder = "1",
							components = 
							{
								
								{
									controlID = "Image_choosebg_Panel_bagItem_Panel_prefab_Panel-kabalaTreeBag_Layer1_kabalaTree_Game",
									UUID = "d52e7b82_1ce3_4072_a271_a1f33bceea49",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "108",
									ignoreSize = "False",
									name = "Image_choosebg",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/kabalatree/cell_bg2.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										
									},
									width = "700",
									ZOrder = "1",
								},
								{
									controlID = "Label_itemName_Panel_bagItem_Panel_prefab_Panel-kabalaTreeBag_Layer1_kabalaTree_Game",
									UUID = "7395de2c_672f_45e7_a01b_f10d33848264",
									anchorPoint = "False",
									anchorPointX = "0",
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
									fontSize = "22",
									fontStroke = 
									{
										IsStroke = false,
										StrokeColor = "#FFE6E6E6",
										StrokeSize = 1,
									},
									height = "25",
									ignoreSize = "True",
									name = "Label_itemName",
									nTextAlign = "1",
									nTextHAlign = "1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "Erhalte Truhe",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionX = -244,
										PositionY = 32,
									},
									width = "91",
									ZOrder = "1",
								},
								{
									controlID = "Image_kabalaTreeBag_2_Panel_bagItem_Panel_prefab_Panel-kabalaTreeBag_Layer1_kabalaTree_Game",
									UUID = "cdb7817a_aebe_4d10_9a8c_5eda24e91ecb",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "58",
									ignoreSize = "True",
									name = "Image_kabalaTreeBag_2",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/kabalatree/title_bg1.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = -93,
										PositionY = -15,
									},
									width = "320",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "Label_itemDesc_Image_kabalaTreeBag_2_Panel_bagItem_Panel_prefab_Panel-kabalaTreeBag_Layer1_kabalaTree_Game",
											UUID = "f4867dfc_6e21_403d_bd7d_780f3f417cab",
											anchorPoint = "False",
											anchorPointX = "0",
											anchorPointY = "0.5",
											classname = "MELabel",
											compPath = "luacomponents.common.MEIconLabel",
											dstBlendFunc = "771",
											FontColor = "#FFA2A4C8",
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
											height = "45",
											ignoreSize = "False",
											name = "Label_itemDesc",
											nTextAlign = "0",
											nTextHAlign = "0",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "770",
											text = "Beschreibung",
											touchAble = "False",
											touchScaleEnable = "False",
											UILayoutViewModel = 
											{
												PositionX = -151,
												PositionY = 2,
											},
											width = "300",
											ZOrder = "1",
										},
									},
								},
								{
									controlID = "Label_haveCnt_Panel_bagItem_Panel_prefab_Panel-kabalaTreeBag_Layer1_kabalaTree_Game",
									UUID = "f9a479e2_5fc6_4267_b23a_876f6cb9fae7",
									anchorPoint = "False",
									anchorPointX = "0",
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
									fontSize = "18",
									fontStroke = 
									{
										IsStroke = false,
										StrokeColor = "#FFE6E6E6",
										StrokeSize = 1,
									},
									height = "21",
									ignoreSize = "True",
									name = "Label_haveCnt",
									nTextAlign = "1",
									nTextHAlign = "1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "Verbleibend",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionX = 117,
										PositionY = -27,
									},
									width = "66",
									ZOrder = "1",
								},
								{
									controlID = "Image_kabalaTreeBag_1_Panel_bagItem_Panel_prefab_Panel-kabalaTreeBag_Layer1_kabalaTree_Game",
									UUID = "574549e2_1bbe_4f2c_b104_a0cc710bea4a",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "26",
									ignoreSize = "True",
									name = "Image_kabalaTreeBag_1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/kabalatree/title_1.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = -249,
										PositionY = 32,
									},
									width = "4",
									ZOrder = "1",
								},
								{
									controlID = "Button_use_Panel_bagItem_Panel_prefab_Panel-kabalaTreeBag_Layer1_kabalaTree_Game",
									UUID = "b6c77880_f2ff_42fa_b151_c5dd65836cb8",
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
									name = "Button_use",
									normal = "ui/kabalatree/btn_3.png",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "True",
									UILayoutViewModel = 
									{
										PositionX = 276,
										PositionY = -15,
									},
									UItype = "Button",
									width = "114",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "Label_btn_Button_use_Panel_bagItem_Panel_prefab_Panel-kabalaTreeBag_Layer1_kabalaTree_Game",
											UUID = "023f1d2c_0427_44c6_95ff_1d2440eb5416",
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
											height = "27",
											ignoreSize = "True",
											name = "Label_btn",
											nTextAlign = "1",
											nTextHAlign = "1",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "770",
											text = "Benutzen",
											touchAble = "False",
											touchScaleEnable = "False",
											UILayoutViewModel = 
											{
												
											},
											width = "55",
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
			"ui/common/image_title.png",
			"ui/kabalatree/cell_bg2.png",
			"ui/kabalatree/title_bg1.png",
			"ui/kabalatree/title_1.png",
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

