local t = 
{
	version = 1,
	components = 
	{
		
		{
			controlID = "Panel-serverListView_Layer1_test_Game",
			UUID = "7c43a18e_b917_4f00_890b_a58c67ecb82b",
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
					controlID = "Panel_root_Panel-serverListView_Layer1_test_Game",
					UUID = "44facfe2_78a6_4984_99b3_0f8a7aace681",
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
					sizepercentx = "100",
					sizepercenty = "100",
					sizeType = "0",
					srcBlendFunc = "1",
					touchAble = "True",
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
							controlID = "Image_serverListView_bg_Panel_root_Panel-serverListView_Layer1_test_Game",
							UUID = "8780669c_145b_4d68_904e_6fd074be4663",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							backGroundScale9Enable = "True;capInsetsX:0;capInsetsY:0;capInsetsWidth:0;capInsetsHeight:0",
							classname = "MEImage",
							dstBlendFunc = "771",
							height = "270",
							ignoreSize = "False",
							name = "Image_serverListView_bg",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							texturePath = "ui/login/88.png",
							touchAble = "False",
							UILayoutViewModel = 
							{
								PositionX = 140,
								PositionY = 134,
								LeftPositon = 5,
								TopPosition = 430,
								relativeToName = "Panel",
							},
							width = "258",
							ZOrder = "1",
							components = 
							{
								
								{
									controlID = "ScrollView_groupList_Image_serverListView_bg_Panel_root_Panel-serverListView_Layer1_test_Game",
									UUID = "73a46855_e76b_46c0_8180_ae9196698b43",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									bgColorOpacity = "50",
									bIsOpenClipping = "True",
									bounceEnable = "True",
									classname = "MEScrollView",
									colorType = "0;SingleColor:#FFFF0000;GraduallyChangingColorStart:#FFFFFFFF;GraduallyChangingColorEnd:#FFFFFFFF;vectorX:0;vectorY:0",
									direction = "1",
									dstBlendFunc = "771",
									height = "205",
									ignoreSize = "False",
									innerHeight = "205",
									innerWidth = "258",
									name = "ScrollView_groupList",
									showScrollbar = "False",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "True",
									UILayoutViewModel = 
									{
										PositionY = 30,
										LeftPositon = 21,
										BottomPosition = 60,
										relativeToName = "Panel_root",
										nGravity = 4,
										nAlign = 7
									},
									uipanelviewmodel = 
									{
										Layout="Absolute",
										nType = "0"
									},
									width = "258",
									ZOrder = "1",
								},
								{
									controlID = "ScrollView_serverList_Image_serverListView_bg_Panel_root_Panel-serverListView_Layer1_test_Game",
									UUID = "933c0066_ba7d_47a1_b60c_6cc1df20e9c0",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									bgColorOpacity = "50",
									bIsOpenClipping = "True",
									bounceEnable = "True",
									classname = "MEScrollView",
									colorType = "0;SingleColor:#FFE6E6E6;GraduallyChangingColorStart:#FFFFFFFF;GraduallyChangingColorEnd:#FFFFFFFF;vectorX:0;vectorY:0",
									direction = "1",
									dstBlendFunc = "771",
									height = "205",
									ignoreSize = "False",
									innerHeight = "205",
									innerWidth = "258",
									name = "ScrollView_serverList",
									showScrollbar = "False",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "True",
									UILayoutViewModel = 
									{
										PositionX = 261,
										PositionY = 30,
										LeftPositon = 21,
										BottomPosition = 60,
										relativeToName = "Panel_root",
										nGravity = 4,
										nAlign = 7
									},
									uipanelviewmodel = 
									{
										Layout="Absolute",
										nType = "0"
									},
									width = "258",
									ZOrder = "1",
								},
							},
						},
						{
							controlID = "Panel_serverList_Panel_root_Panel-serverListView_Layer1_test_Game",
							UUID = "d9c6f92a_f8c9_467e_bede_37e3eff60148",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							backGroundScale9Enable = "False",
							bgColorOpacity = "50",
							bIsOpenClipping = "False",
							classname = "MEPanel",
							colorType = "0;SingleColor:#FFFF6347;GraduallyChangingColorStart:#FFFFFFFF;GraduallyChangingColorEnd:#FFFFFFFF;vectorX:0;vectorY:0",
							DesignHeight = "640",
							DesignType = "0",
							DesignWidth = "960",
							dstBlendFunc = "771",
							height = "60",
							ignoreSize = "False",
							name = "Panel_serverList",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							touchAble = "True",
							UILayoutViewModel = 
							{
								PositionX = 140,
								PositionY = 30,
							},
							uipanelviewmodel = 
							{
								Layout="Absolute",
								nType = "0"
							},
							visible = "False",
							width = "258",
							ZOrder = "1",
							components = 
							{
								
								{
									controlID = "Image_severlistbg_Panel_serverList_Panel_root_Panel-serverListView_Layer1_test_Game",
									UUID = "35591893_1577_42f9_8d12_d4933622b14e",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "True;capInsetsX:0;capInsetsY:0;capInsetsWidth:0;capInsetsHeight:0",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "60",
									ignoreSize = "False",
									name = "Image_severlistbg",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/login/7.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										
									},
									visible = "False",
									width = "258",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "Label_serverName_Image_severlistbg_Panel_serverList_Panel_root_Panel-serverListView_Layer1_test_Game",
											UUID = "f38093e9_3dea_44ec_995c_b029aed91a6e",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											classname = "MELabel",
											compPath = "luacomponents.common.MEIconLabel",
											dstBlendFunc = "771",
											FontColor = "#FF3F4352",
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
											height = "34",
											ignoreSize = "True",
											name = "Label_serverName",
											nTextAlign = "1",
											nTextHAlign = "1",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "770",
											text = "Lista de servidores iOS",
											touchAble = "False",
											touchScaleEnable = "False",
											UILayoutViewModel = 
											{
												
											},
											width = "279",
											ZOrder = "1",
										},
									},
								},
							},
						},
					},
				},
				{
					controlID = "Panel_prefab_Panel-serverListView_Layer1_test_Game",
					UUID = "ea68485d_4144_4789_b4e0_e15e115f09ea",
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
					name = "Panel_prefab",
					sizepercentx = "100",
					sizepercenty = "100",
					sizeType = "1",
					srcBlendFunc = "1",
					touchAble = "False",
					UILayoutViewModel = 
					{
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
							controlID = "Button_serverListItem_Panel_prefab_Panel-serverListView_Layer1_test_Game",
							UUID = "ba075598_7a64_4f00_bc8c_7200d3a84595",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							backGroundScale9Enable = "True;capInsetsX:0;capInsetsY:0;capInsetsWidth:0;capInsetsHeight:0",
							classname = "MEButton",
							ClickHighLightEnabled = "True",
							dstBlendFunc = "771",
							flipX = "False",
							flipY = "False",
							height = "60",
							ignoreSize = "False",
							name = "Button_serverListItem",
							normal = "ui/login/7.png",
							pressed = "ui/login/7.png",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							touchAble = "True",
							UILayoutViewModel = 
							{
								PositionX = 528,
								PositionY = 131,
							},
							UItype = "Button",
							width = "258",
							ZOrder = "1",
							components = 
							{
								
								{
									controlID = "Label_name_Button_serverListItem_Panel_prefab_Panel-serverListView_Layer1_test_Game",
									UUID = "83cea11f_dfb4_432b_9aa5_70b947bdc789",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									classname = "MELabel",
									compPath = "luacomponents.common.MEIconLabel",
									dstBlendFunc = "771",
									FontColor = "#FFFEC8FD",
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
									height = "28",
									ignoreSize = "True",
									name = "Label_name",
									nTextAlign = "1",
									nTextHAlign = "1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "Desarrollar",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										IsPercent = true,
									},
									width = "145",
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
			"ui/login/88.png",
			"ui/login/7.png",
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

