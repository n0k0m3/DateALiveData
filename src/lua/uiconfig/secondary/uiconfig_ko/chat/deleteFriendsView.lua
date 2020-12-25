local t = 
{
	version = 1,
	components = 
	{
		
		{
			controlID = "Panel-deleteFriendsView_Layer1_chat_Game",
			UUID = "9cb788dc_e219_41ca_a220_91ed0faced0c",
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
					controlID = "Image_word_Panel-deleteFriendsView_Layer1_chat_Game",
					UUID = "c9b63049_4938_4be6_90da_dd200e744422",
					anchorPoint = "False",
					anchorPointX = "0.5",
					anchorPointY = "0.5",
					backGroundScale9Enable = "True;capInsetsX:491;capInsetsY:65;capInsetsWidth:30;capInsetsHeight:30",
					classname = "MEImage",
					dstBlendFunc = "771",
					height = "300",
					ignoreSize = "False",
					name = "Image_word",
					sizepercentx = "100",
					sizepercenty = "100",
					sizeType = "0",
					srcBlendFunc = "1",
					texturePath = "ui/bag/014.png",
					touchAble = "False",
					UILayoutViewModel = 
					{
						PositionX = 480,
						PositionY = 320,
						relativeToName = "Panel_root",
						nGravity = 6,
						nAlign = 5
					},
					width = "600",
					ZOrder = "1",
					components = 
					{
						
						{
							controlID = "Label_title_Image_word_Panel-deleteFriendsView_Layer1_chat_Game",
							UUID = "aba7e6bb_db30_4591_b771_635a73612dbc",
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
							height = "34",
							ignoreSize = "True",
							name = "Label_title",
							nTextAlign = "1",
							nTextHAlign = "1",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "770",
							text = "친구 삭제",
							touchAble = "False",
							touchScaleEnable = "False",
							UILayoutViewModel = 
							{
								PositionY = 123,
							},
							width = "114",
							ZOrder = "1",
						},
						{
							controlID = "Button_close_Image_word_Panel-deleteFriendsView_Layer1_chat_Game",
							UUID = "5cbba784_c2ea_4010_9046_7ae71dd816fc",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							backGroundScale9Enable = "False",
							classname = "MEButton",
							ClickHighLightEnabled = "True",
							dstBlendFunc = "771",
							flipX = "False",
							flipY = "False",
							height = "2",
							ignoreSize = "True",
							name = "Button_close",
							normal = "ui/common/xx.png",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							touchAble = "True",
							UILayoutViewModel = 
							{
								PositionX = 269,
								PositionY = 123,
							},
							UItype = "Button",
							width = "2",
							ZOrder = "1",
						},
						{
							controlID = "Label_desc_Image_word_Panel-deleteFriendsView_Layer1_chat_Game",
							UUID = "aec3fa46_405d_4f41_b90d_7486196b44ed",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							classname = "MELabel",
							compPath = "luacomponents.common.MEIconLabel",
							dstBlendFunc = "771",
							FontColor = "#FF000000",
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
							height = "116",
							ignoreSize = "False",
							name = "Label_desc",
							nTextAlign = "1",
							nTextHAlign = "1",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "770",
							text = "친구를 삭제하시겠습니까?",
							touchAble = "False",
							touchScaleEnable = "False",
							UILayoutViewModel = 
							{
								PositionY = 11,
							},
							width = "300",
							ZOrder = "1",
						},
						{
							controlID = "Button_cancle_Image_word_Panel-deleteFriendsView_Layer1_chat_Game",
							UUID = "ccde61c5_fad2_4cca_8c8e_6c81a784d36a",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							backGroundScale9Enable = "False",
							classname = "MEButton",
							ClickHighLightEnabled = "True",
							dstBlendFunc = "771",
							flipX = "False",
							flipY = "False",
							height = "2",
							ignoreSize = "True",
							name = "Button_cancle",
							normal = "ui/common/button05.png",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							touchAble = "True",
							UILayoutViewModel = 
							{
								PositionX = -129,
								PositionY = -90,
							},
							UItype = "Button",
							width = "2",
							ZOrder = "1",
							components = 
							{
								
								{
									controlID = "Label_cancle_Button_cancle_Image_word_Panel-deleteFriendsView_Layer1_chat_Game",
									UUID = "26a94f1e_f9ab_4337_a76c_ed727a6a955a",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									classname = "MELabel",
									compPath = "luacomponents.common.MEIconLabel",
									dstBlendFunc = "771",
									FontColor = "#FF000000",
									fontName = "font/fangzheng_zhunyuan.ttf",
									fontShadow = 
									{
										IsShadow = false,
										ShadowColor = "#FFFFFFFF",
										ShadowAlpha = 255,
										OffsetX = 0,
										OffsetY = 0,
									},
									fontSize = "23",
									fontStroke = 
									{
										IsStroke = false,
										StrokeColor = "#FFE6E6E6",
										StrokeSize = 1,
									},
									height = "26",
									ignoreSize = "True",
									name = "Label_cancle",
									nTextAlign = "1",
									nTextHAlign = "1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "취소",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionY = 3,
									},
									width = "43",
									ZOrder = "1",
								},
							},
						},
						{
							controlID = "Button_ok_Image_word_Panel-deleteFriendsView_Layer1_chat_Game",
							UUID = "89fca63a_2c6b_4a1c_b2f9_2cf76088c889",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							backGroundScale9Enable = "False",
							classname = "MEButton",
							ClickHighLightEnabled = "True",
							dstBlendFunc = "771",
							flipX = "False",
							flipY = "False",
							height = "2",
							ignoreSize = "True",
							name = "Button_ok",
							normal = "ui/common/button05.png",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							touchAble = "True",
							UILayoutViewModel = 
							{
								PositionX = 132,
								PositionY = -90,
							},
							UItype = "Button",
							width = "2",
							ZOrder = "1",
							components = 
							{
								
								{
									controlID = "Label_cancle_Button_ok_Image_word_Panel-deleteFriendsView_Layer1_chat_Game",
									UUID = "e1004800_f341_4411_b53c_33875d15057a",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									classname = "MELabel",
									compPath = "luacomponents.common.MEIconLabel",
									dstBlendFunc = "771",
									FontColor = "#FF000000",
									fontName = "font/fangzheng_zhunyuan.ttf",
									fontShadow = 
									{
										IsShadow = false,
										ShadowColor = "#FFFFFFFF",
										ShadowAlpha = 255,
										OffsetX = 0,
										OffsetY = 0,
									},
									fontSize = "23",
									fontStroke = 
									{
										IsStroke = false,
										StrokeColor = "#FFE6E6E6",
										StrokeSize = 1,
									},
									height = "26",
									ignoreSize = "True",
									name = "Label_cancle",
									nTextAlign = "1",
									nTextHAlign = "1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "확인",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionY = 3,
									},
									width = "42",
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
			"ui/bag/014.png",
			"ui/common/xx.png",
			"ui/common/button05.png",
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

