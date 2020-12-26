local t = 
{
	version = 1,
	components = 
	{
		
		{
			controlID = "Panel-duanwuPop1_duanwu_activity_activity_Game",
			UUID = "30fb3b68_0c13_4b06_b919_994a44d7de33",
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
					controlID = "Panel_base_Panel-duanwuPop1_duanwu_activity_activity_Game",
					UUID = "222804d3_6f7c_4216_af1a_afd4631beef1",
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
							controlID = "Image_bg_Panel_base_Panel-duanwuPop1_duanwu_activity_activity_Game",
							UUID = "15f8c116_b3d7_41ca_a09e_796968ceb51f",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							backGroundScale9Enable = "False",
							classname = "MEImage",
							dstBlendFunc = "771",
							height = "321",
							ignoreSize = "True",
							name = "Image_bg",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							texturePath = "ui/activity/duanwu_mfdzz/pop/bg.png",
							touchAble = "True",
							UILayoutViewModel = 
							{
								PositionX = 578,
								PositionY = 321,
							},
							width = "537",
							ZOrder = "1",
						},
						{
							controlID = "Label_title_Panel_base_Panel-duanwuPop1_duanwu_activity_activity_Game",
							UUID = "02a51fed_722c_472d_9436_7d37f287b9cd",
							anchorPoint = "False",
							anchorPointX = "0",
							anchorPointY = "0.5",
							classname = "MELabel",
							compPath = "luacomponents.common.MEIconLabel",
							dstBlendFunc = "771",
							FontColor = "#FF912325",
							fontName = "font/MFLiHei_Noncommercial.ttf",
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
							height = "37",
							ignoreSize = "True",
							name = "Label_title",
							nTextAlign = "1",
							nTextHAlign = "1",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "770",
							text = "Recordatorio",
							touchAble = "False",
							touchScaleEnable = "False",
							UILayoutViewModel = 
							{
								PositionX = 322,
								PositionY = 449,
							},
							width = "62",
							ZOrder = "1",
						},
						{
							controlID = "Button_close_Panel_base_Panel-duanwuPop1_duanwu_activity_activity_Game",
							UUID = "ff4e7d3c_332a_47e3_9620_732506f1c077",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							backGroundScale9Enable = "False",
							classname = "MEButton",
							ClickHighLightEnabled = "True",
							dstBlendFunc = "771",
							flipX = "False",
							flipY = "False",
							height = "28",
							ignoreSize = "True",
							name = "Button_close",
							normal = "ui/activity/duanwu_mfdzz/fortReady/close.png",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							touchAble = "True",
							UILayoutViewModel = 
							{
								PositionX = 816,
								PositionY = 453,
							},
							UItype = "Button",
							width = "28",
							ZOrder = "1",
						},
						{
							controlID = "Label_1_Panel_base_Panel-duanwuPop1_duanwu_activity_activity_Game",
							UUID = "8e285b61_61dd_495a_b8f0_f7935639e99a",
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
							fontSize = "22",
							fontStroke = 
							{
								IsStroke = false,
								StrokeColor = "#FFE6E6E6",
								StrokeSize = 1,
							},
							height = "25",
							ignoreSize = "True",
							name = "Label_1",
							nTextAlign = "1",
							nTextHAlign = "1",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "770",
							text = "是否更换支援角色？",
							touchAble = "False",
							touchScaleEnable = "False",
							UILayoutViewModel = 
							{
								PositionX = 571,
								PositionY = 406,
							},
							width = "190",
							ZOrder = "1",
						},
						{
							controlID = "Label_2_Panel_base_Panel-duanwuPop1_duanwu_activity_activity_Game",
							UUID = "2bb640fc_70e4_41a6_89a8_cd28b376d2ca",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							classname = "MELabel",
							compPath = "luacomponents.common.MEIconLabel",
							dstBlendFunc = "771",
							FontColor = "#FFE79B17",
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
							name = "Label_2",
							nTextAlign = "1",
							nTextHAlign = "1",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "770",
							text = "可获得支援时长奖励：",
							touchAble = "False",
							touchScaleEnable = "False",
							UILayoutViewModel = 
							{
								PositionX = 492,
								PositionY = 249,
							},
							width = "209",
							ZOrder = "1",
						},
						{
							controlID = "Image_1_Panel_base_Panel-duanwuPop1_duanwu_activity_activity_Game",
							UUID = "73ac6e13_042d_453f_8a04_4d7d19c4e00e",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							backGroundScale9Enable = "False",
							classname = "MEImage",
							dstBlendFunc = "771",
							height = "58",
							ignoreSize = "True",
							name = "Image_1",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							texturePath = "ui/activity/duanwu_mfdzz/pop/001.png",
							touchAble = "False",
							UILayoutViewModel = 
							{
								PositionX = 566,
								PositionY = 332,
							},
							width = "96",
							ZOrder = "1",
						},
						{
							controlID = "Image_icon_Panel_base_Panel-duanwuPop1_duanwu_activity_activity_Game",
							UUID = "37575524_7686_42a2_8c3d_bd2407c18485",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							backGroundScale9Enable = "False",
							classname = "MEImage",
							dstBlendFunc = "771",
							height = "100",
							ignoreSize = "True",
							name = "Image_icon",
							scaleX = "0.35",
							scaleY = "0.35",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							texturePath = "icon/item/goods/510201.png",
							touchAble = "False",
							UILayoutViewModel = 
							{
								PositionX = 616,
								PositionY = 249,
							},
							width = "100",
							ZOrder = "1",
						},
						{
							controlID = "Label_number_Panel_base_Panel-duanwuPop1_duanwu_activity_activity_Game",
							UUID = "1b574fdb_9c0c_48a7_a200_33f98fd1c934",
							anchorPoint = "False",
							anchorPointX = "0",
							anchorPointY = "0.5",
							classname = "MELabel",
							compPath = "luacomponents.common.MEIconLabel",
							dstBlendFunc = "771",
							FontColor = "#FFE79B17",
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
							name = "Label_number",
							nTextAlign = "1",
							nTextHAlign = "1",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "770",
							text = "88888",
							touchAble = "False",
							touchScaleEnable = "False",
							UILayoutViewModel = 
							{
								PositionX = 629,
								PositionY = 248,
							},
							width = "62",
							ZOrder = "1",
						},
						{
							controlID = "Button_cancel_Panel_base_Panel-duanwuPop1_duanwu_activity_activity_Game",
							UUID = "b2a15406_24d0_4ea3_bab2_f1f6e1124adf",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							backGroundScale9Enable = "False",
							classname = "MEButton",
							ClickHighLightEnabled = "True",
							dstBlendFunc = "771",
							flipX = "False",
							flipY = "False",
							height = "63",
							ignoreSize = "True",
							name = "Button_cancel",
							normal = "ui/activity/duanwu_mfdzz/fortReady/button.png",
							scaleX = "0.8",
							scaleY = "0.8",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							touchAble = "True",
							UILayoutViewModel = 
							{
								PositionX = 389,
								PositionY = 198,
							},
							UItype = "Button",
							width = "139",
							ZOrder = "1",
							components = 
							{
								
								{
									controlID = "Label_btn_Button_cancel_Panel_base_Panel-duanwuPop1_duanwu_activity_activity_Game",
									UUID = "98076481_630a_4404_85ee_856f4b5f9c6d",
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
									text = "Cancelar",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										
									},
									width = "50",
									ZOrder = "1",
								},
							},
						},
						{
							controlID = "Button_sure_Panel_base_Panel-duanwuPop1_duanwu_activity_activity_Game",
							UUID = "4e5f2549_3f85_4a95_8b88_8046ef06a3eb",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							backGroundScale9Enable = "False",
							classname = "MEButton",
							ClickHighLightEnabled = "True",
							dstBlendFunc = "771",
							flipX = "False",
							flipY = "False",
							height = "63",
							ignoreSize = "True",
							name = "Button_sure",
							normal = "ui/activity/duanwu_mfdzz/fortReady/button.png",
							scaleX = "0.8",
							scaleY = "0.8",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							touchAble = "True",
							UILayoutViewModel = 
							{
								PositionX = 770,
								PositionY = 198,
							},
							UItype = "Button",
							width = "139",
							ZOrder = "1",
							components = 
							{
								
								{
									controlID = "Label_btn_Button_sure_Panel_base_Panel-duanwuPop1_duanwu_activity_activity_Game",
									UUID = "af7393eb_71db_4c17_8276_6779f67bec1a",
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
									text = "Confirmar",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										
									},
									width = "51",
									ZOrder = "1",
								},
							},
						},
						{
							controlID = "Panel_role_Panel_base_Panel-duanwuPop1_duanwu_activity_activity_Game",
							UUID = "076f9dee_f915_424b_b856_dd6418ac229a",
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
							height = "89",
							ignoreSize = "False",
							name = "Panel_role",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							touchAble = "False",
							UILayoutViewModel = 
							{
								PositionX = 423,
								PositionY = 284,
							},
							uipanelviewmodel = 
							{
								Layout="Absolute",
								nType = "0"
							},
							width = "89",
							ZOrder = "1",
							components = 
							{
								
								{
									controlID = "Image_headBg_Panel_role_Panel_base_Panel-duanwuPop1_duanwu_activity_activity_Game",
									UUID = "4548fd13_8f4a_4dc8_9f79_d398701734d0",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "110",
									ignoreSize = "True",
									name = "Image_headBg",
									scaleX = "0.8",
									scaleY = "0.8",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/common/frame_normal.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = 45,
										PositionY = 44,
									},
									width = "110",
									ZOrder = "1",
								},
								{
									controlID = "ClippingNode_head_Panel_role_Panel_base_Panel-duanwuPop1_duanwu_activity_activity_Game",
									UUID = "30bdf3d0_eb69_4758_a7a2_30e53e729e76",
									anchorPoint = "False",
									anchorPointX = "0",
									anchorPointY = "0",
									classname = "MEClippingNode",
									clipNodeX = "0",
									clipNodeY = "0",
									dstBlendFunc = "771",
									height = "100",
									ignoreSize = "False",
									name = "ClippingNode_head",
									scaleX = "0.9",
									scaleY = "0.9",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									stencilPath = "icon/hero/mask/01.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = 45,
										PositionY = 44,
										relativeToName = "Panel",
									},
									width = "100",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "Image_icon_ClippingNode_head_Panel_role_Panel_base_Panel-duanwuPop1_duanwu_activity_activity_Game",
											UUID = "33090783_2240_4106_b30c_e5346591b749",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											classname = "MEImage",
											dstBlendFunc = "771",
											height = "92",
											ignoreSize = "True",
											name = "Image_icon",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											texturePath = "icon/hero/face/1104011.png",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = -32,
											},
											width = "156",
											ZOrder = "1",
										},
									},
								},
							},
						},
						{
							controlID = "Panel_role1_Panel_base_Panel-duanwuPop1_duanwu_activity_activity_Game",
							UUID = "a8c9c53f_47ee_40e1_abf3_46c2d7b1d913",
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
							height = "89",
							ignoreSize = "False",
							name = "Panel_role1",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							touchAble = "False",
							UILayoutViewModel = 
							{
								PositionX = 625,
								PositionY = 284,
							},
							uipanelviewmodel = 
							{
								Layout="Absolute",
								nType = "0"
							},
							width = "89",
							ZOrder = "1",
							components = 
							{
								
								{
									controlID = "Image_headBg_Panel_role1_Panel_base_Panel-duanwuPop1_duanwu_activity_activity_Game",
									UUID = "f3b88141_9bc3_4dde_93e7_34add06e7b92",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "110",
									ignoreSize = "True",
									name = "Image_headBg",
									scaleX = "0.8",
									scaleY = "0.8",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/common/frame_normal.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = 45,
										PositionY = 44,
									},
									width = "110",
									ZOrder = "1",
								},
								{
									controlID = "ClippingNode_head_Panel_role1_Panel_base_Panel-duanwuPop1_duanwu_activity_activity_Game",
									UUID = "52132712_6305_433f_907b_3dbee852ad51",
									anchorPoint = "False",
									anchorPointX = "0",
									anchorPointY = "0",
									classname = "MEClippingNode",
									clipNodeX = "0",
									clipNodeY = "0",
									dstBlendFunc = "771",
									height = "100",
									ignoreSize = "False",
									name = "ClippingNode_head",
									scaleX = "0.9",
									scaleY = "0.9",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									stencilPath = "icon/hero/mask/01.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = 45,
										PositionY = 44,
										relativeToName = "Panel",
									},
									width = "100",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "Image_icon_ClippingNode_head_Panel_role1_Panel_base_Panel-duanwuPop1_duanwu_activity_activity_Game",
											UUID = "2765e5ea_7616_4ca6_be27_a2a5a5163fe2",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											classname = "MEImage",
											dstBlendFunc = "771",
											height = "92",
											ignoreSize = "True",
											name = "Image_icon",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											texturePath = "icon/hero/face/1104011.png",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = -32,
											},
											width = "156",
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
			"ui/activity/duanwu_mfdzz/pop/bg.png",
			"ui/activity/duanwu_mfdzz/fortReady/close.png",
			"ui/activity/duanwu_mfdzz/pop/001.png",
			"icon/item/goods/510201.png",
			"ui/activity/duanwu_mfdzz/fortReady/button.png",
			"ui/common/frame_normal.png",
			"icon/hero/face/1104011.png",
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

