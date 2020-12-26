local t = 
{
	version = 1,
	components = 
	{
		
		{
			controlID = "Panel-huiyiTip_duanwu_activity_activity_Game",
			UUID = "e4255028_5a64_4fbb_8d3d_0265f4f23a53",
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
					controlID = "Panel_base_Panel-huiyiTip_duanwu_activity_activity_Game",
					UUID = "8a71e9ca_cf39_4480_9049_ff02a5ffa966",
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
							controlID = "Image_bg_Panel_base_Panel-huiyiTip_duanwu_activity_activity_Game",
							UUID = "f8490a50_40c6_4353_b816_31ce37a6b402",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							backGroundScale9Enable = "False",
							classname = "MEImage",
							dstBlendFunc = "771",
							height = "428",
							ignoreSize = "True",
							name = "Image_bg",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							texturePath = "ui/activity/duanwu_mfdzz/spriteInfo/bg.png",
							touchAble = "True",
							UILayoutViewModel = 
							{
								PositionX = 569,
								PositionY = 318,
							},
							width = "738",
							ZOrder = "1",
						},
						{
							controlID = "Label_title_Panel_base_Panel-huiyiTip_duanwu_activity_activity_Game",
							UUID = "104594bc_00fd_4575_9b98_af9e432107ae",
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
							text = "回忆笔记",
							touchAble = "False",
							touchScaleEnable = "False",
							UILayoutViewModel = 
							{
								PositionX = 216,
								PositionY = 498,
							},
							width = "124",
							ZOrder = "1",
						},
						{
							controlID = "Button_close_Panel_base_Panel-huiyiTip_duanwu_activity_activity_Game",
							UUID = "8f0fc81c_0bfc_4ff3_bec8_f3ab526fc8ea",
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
								PositionX = 903,
								PositionY = 503,
							},
							UItype = "Button",
							width = "28",
							ZOrder = "1",
						},
						{
							controlID = "ScrollView_list_Panel_base_Panel-huiyiTip_duanwu_activity_activity_Game",
							UUID = "50186fbe_fca7_4608_9b6a_a2bedd641575",
							anchorPoint = "False",
							anchorPointX = "0",
							anchorPointY = "0",
							backGroundScale9Enable = "False",
							bgColorOpacity = "50",
							bIsOpenClipping = "True",
							bounceEnable = "False",
							classname = "MEScrollView",
							colorType = "0;SingleColor:#FFE6E6E6;GraduallyChangingColorStart:#FFFFFFFF;GraduallyChangingColorEnd:#FFFFFFFF;vectorX:0;vectorY:0",
							direction = "1",
							dstBlendFunc = "771",
							height = "355",
							ignoreSize = "False",
							innerHeight = "355",
							innerWidth = "700",
							name = "ScrollView_list",
							showScrollbar = "False",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							touchAble = "True",
							UILayoutViewModel = 
							{
								PositionX = 219,
								PositionY = 121,
							},
							uipanelviewmodel = 
							{
								Layout="Absolute",
								nType = "0"
							},
							width = "700",
							ZOrder = "1",
						},
						{
							controlID = "Image_scrollBarModel_Panel_base_Panel-huiyiTip_duanwu_activity_activity_Game",
							UUID = "2c3095b1_76d8_49f0_89d0_ca3503806791",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0",
							backGroundScale9Enable = "True;capInsetsX:0;capInsetsY:0;capInsetsWidth:0;capInsetsHeight:0",
							classname = "MEImage",
							dstBlendFunc = "771",
							height = "358",
							ignoreSize = "False",
							name = "Image_scrollBarModel",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							texturePath = "ui/common/scroll_bar_01.png",
							touchAble = "False",
							UILayoutViewModel = 
							{
								PositionX = 927,
								PositionY = 120,
							},
							width = "8",
							ZOrder = "1",
							components = 
							{
								
								{
									controlID = "Image_scrollBarInner_Image_scrollBarModel_Panel_base_Panel-huiyiTip_duanwu_activity_activity_Game",
									UUID = "9477a220_7be6_4756_8500_517ac1ed67e0",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "210",
									ignoreSize = "False",
									name = "Image_scrollBarInner",
									sizepercentx = "100",
									sizepercenty = "100",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/common/scroll_bar_02.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										
									},
									width = "5",
									ZOrder = "1",
								},
							},
						},
					},
				},
				{
					controlID = "Panel_prefab_Panel-huiyiTip_duanwu_activity_activity_Game",
					UUID = "1695fdd5_9d6c_441b_8dd3_c35f72a137fa",
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
					height = "400",
					ignoreSize = "False",
					name = "Panel_prefab",
					sizepercentx = "0",
					sizepercenty = "0",
					sizeType = "0",
					srcBlendFunc = "1",
					touchAble = "False",
					UILayoutViewModel = 
					{
						PositionY = -640,
						BottomPosition = -640,
						relativeToName = "Panel",
						nType = 3,
						nGravity = 4,
						nAlign = 7
					},
					uipanelviewmodel = 
					{
						Layout="Absolute",
						nType = "0"
					},
					width = "400",
					ZOrder = "1",
					components = 
					{
						
						{
							controlID = "Panel_item_Panel_prefab_Panel-huiyiTip_duanwu_activity_activity_Game",
							UUID = "4f32b09b_b85a_4d60_a119_9d6cb9a9ad28",
							anchorPoint = "False",
							anchorPointX = "0.5",
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
							height = "166",
							ignoreSize = "False",
							name = "Panel_item",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							touchAble = "False",
							UILayoutViewModel = 
							{
								PositionX = 110,
								PositionY = 177,
							},
							uipanelviewmodel = 
							{
								Layout="Absolute",
								nType = "0"
							},
							width = "162",
							ZOrder = "1",
							components = 
							{
								
								{
									controlID = "Image_bg_Panel_item_Panel_prefab_Panel-huiyiTip_duanwu_activity_activity_Game",
									UUID = "e402a5b7_5c99_4fbd_8872_6364d53083e5",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "166",
									ignoreSize = "True",
									name = "Image_bg",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/activity/duanwu_mfdzz/huiyi/002.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionY = 83,
									},
									width = "162",
									ZOrder = "1",
								},
								{
									controlID = "Image_icon_Panel_item_Panel_prefab_Panel-huiyiTip_duanwu_activity_activity_Game",
									UUID = "47b8ddae_a994_4fde_acfa_6916d7c737ee",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "118",
									ignoreSize = "True",
									name = "Image_icon",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/activity/duanwu_mfdzz/huiyi/003.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionY = 101,
									},
									width = "113",
									ZOrder = "1",
								},
								{
									controlID = "Image_lock_Panel_item_Panel_prefab_Panel-huiyiTip_duanwu_activity_activity_Game",
									UUID = "cbc95497_a27d_46a1_8046_24fa4fc1fab7",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "118",
									ignoreSize = "True",
									name = "Image_lock",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/activity/duanwu_mfdzz/huiyi/001.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionY = 101,
									},
									width = "113",
									ZOrder = "1",
								},
								{
									controlID = "Label_name_Panel_item_Panel_prefab_Panel-huiyiTip_duanwu_activity_activity_Game",
									UUID = "5e8d4260_bdd0_4dab_996e_dae9c05efca6",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									classname = "MELabel",
									compPath = "luacomponents.common.MEIconLabel",
									dstBlendFunc = "771",
									FontColor = "#FFEBC29B",
									fontName = "phanta.ttf",
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
									height = "23",
									ignoreSize = "True",
									name = "Label_name",
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
										PositionY = 25,
									},
									width = "80",
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
			"ui/activity/duanwu_mfdzz/spriteInfo/bg.png",
			"ui/activity/duanwu_mfdzz/fortReady/close.png",
			"ui/common/scroll_bar_01.png",
			"ui/common/scroll_bar_02.png",
			"ui/activity/duanwu_mfdzz/huiyi/002.png",
			"ui/activity/duanwu_mfdzz/huiyi/003.png",
			"ui/activity/duanwu_mfdzz/huiyi/001.png",
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

