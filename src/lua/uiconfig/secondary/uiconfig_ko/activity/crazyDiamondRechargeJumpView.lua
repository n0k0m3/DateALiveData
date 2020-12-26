local t = 
{
	version = 1,
	components = 
	{
		
		{
			controlID = "Panel-crazyDiamondRechargeJumpView_activityEn_activity_Game",
			UUID = "67f588c0_4879_44b7_9c80_f376473911c2",
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
					controlID = "panel_root_Panel-crazyDiamondRechargeJumpView_activityEn_activity_Game",
					UUID = "edd90070_9a26_416f_a66a_b98d569a1009",
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
					height = "640",
					ignoreSize = "False",
					name = "panel_root",
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
							controlID = "img_content_panel_root_Panel-crazyDiamondRechargeJumpView_activityEn_activity_Game",
							UUID = "1c9e1fb6_9860_40fc_8f0c_b2f1959e08bd",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							backGroundScale9Enable = "False",
							classname = "MEImage",
							dstBlendFunc = "771",
							height = "324",
							ignoreSize = "True",
							name = "img_content",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							texturePath = "ui/common/mini_pop/9.png",
							touchAble = "True",
							UILayoutViewModel = 
							{
								
							},
							width = "540",
							ZOrder = "1",
							components = 
							{
								
								{
									controlID = "img_bg_img_content_panel_root_Panel-crazyDiamondRechargeJumpView_activityEn_activity_Game",
									UUID = "44f54fc2_7865_4f50_819b_ed6894d8b9b1",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "True;capInsetsX:0;capInsetsY:0;capInsetsWidth:0;capInsetsHeight:0",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "204",
									ignoreSize = "False",
									name = "img_bg",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/common/mini_pop/7.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionY = 8,
									},
									width = "523",
									ZOrder = "1",
								},
								{
									controlID = "label_title_img_content_panel_root_Panel-crazyDiamondRechargeJumpView_activityEn_activity_Game",
									UUID = "412677f8_18d3_4afd_9606_429cdb1b2126",
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
									name = "label_title",
									nTextAlign = "1",
									nTextHAlign = "1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "횟수 부족",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionX = -254,
										PositionY = 131,
									},
									width = "115",
									ZOrder = "1",
								},
								{
									controlID = "btn_recharge_img_content_panel_root_Panel-crazyDiamondRechargeJumpView_activityEn_activity_Game",
									UUID = "e9211043_9342_49d5_92fb_203610aa106e",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEButton",
									ClickHighLightEnabled = "True",
									dstBlendFunc = "771",
									flipX = "False",
									flipY = "False",
									height = "50",
									ignoreSize = "False",
									name = "btn_recharge",
									normal = "ui/common/button_middle_n.png",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "True",
									UILayoutViewModel = 
									{
										PositionY = -123,
									},
									UItype = "Button",
									width = "110",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "label_recharge_btn_recharge_img_content_panel_root_Panel-crazyDiamondRechargeJumpView_activityEn_activity_Game",
											UUID = "1f11d6d8_074f_4f28_8470_48a7b402958e",
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
												IsStroke = false,
												StrokeColor = "#FFE6E6E6",
												StrokeSize = 1,
											},
											height = "30",
											ignoreSize = "True",
											name = "label_recharge",
											nTextAlign = "1",
											nTextHAlign = "1",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "770",
											text = "충전",
											touchAble = "False",
											touchScaleEnable = "False",
											UILayoutViewModel = 
											{
												PositionY = -1,
											},
											width = "55",
											ZOrder = "1",
										},
									},
								},
								{
									controlID = "label_tips_img_content_panel_root_Panel-crazyDiamondRechargeJumpView_activityEn_activity_Game",
									UUID = "73a0588f_3df7_498c_a76b_2d43a0001b91",
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
									height = "0",
									ignoreSize = "False",
									name = "label_tips",
									nTextAlign = "0",
									nTextHAlign = "0",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "횟수 부족합니다. 어서 충전하세요.",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionY = -22,
									},
									width = "400",
									ZOrder = "1",
								},
								{
									controlID = "img_tip_img_content_panel_root_Panel-crazyDiamondRechargeJumpView_activityEn_activity_Game",
									UUID = "aaddfac3_d43c_4f48_80bc_80a2952f1d0c",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "51",
									ignoreSize = "True",
									name = "img_tip",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/common/pop_ui/pop_ui_11.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionY = 31,
									},
									width = "61",
									ZOrder = "1",
								},
								{
									controlID = "btn_close_img_content_panel_root_Panel-crazyDiamondRechargeJumpView_activityEn_activity_Game",
									UUID = "c597e7dc_079d_402a_a459_28c482dc0112",
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
									name = "btn_close",
									normal = "ui/common/pop_ui/pop_btn_02.png",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "True",
									UILayoutViewModel = 
									{
										PositionX = 234,
										PositionY = 130,
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
			"ui/common/button_middle_n.png",
			"ui/common/pop_ui/pop_ui_11.png",
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

