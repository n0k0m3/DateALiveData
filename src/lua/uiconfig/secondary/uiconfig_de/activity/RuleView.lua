local t = 
{
	version = 1,
	components = 
	{
		
		{
			controlID = "Panel-RuleView_groupPurchase_activity_Game",
			UUID = "5abbdff3_0c11_453d_ba94_ce0b2f3d14b3",
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
			width = "960",
			ZOrder = "1",
			components = 
			{
				
				{
					controlID = "Panel_root_Panel-RuleView_groupPurchase_activity_Game",
					UUID = "bcf410aa_df76_426f_8a09_2541c4feff90",
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
						
					},
					uipanelviewmodel = 
					{
						Layout="Absolute",
						nType = "0"
					},
					width = "960",
					ZOrder = "1",
					components = 
					{
						
						{
							controlID = "bg_Panel_root_Panel-RuleView_groupPurchase_activity_Game",
							UUID = "ba2d3409_4109_4f61_9db1_5727481dc0d5",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							backGroundScale9Enable = "False",
							classname = "MEImage",
							dstBlendFunc = "771",
							height = "410",
							ignoreSize = "True",
							name = "bg",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							texturePath = "ui/activity/groupPurchase/rule_bg.png",
							touchAble = "False",
							UILayoutViewModel = 
							{
								PositionX = 480,
								PositionY = 320,
							},
							width = "721",
							ZOrder = "1",
						},
						{
							controlID = "explain_Panel_root_Panel-RuleView_groupPurchase_activity_Game",
							UUID = "1c023dec_2426_4454_8be8_390c27a7ee77",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							backGroundScale9Enable = "False",
							classname = "MEImage",
							dstBlendFunc = "771",
							height = "52",
							ignoreSize = "True",
							name = "explain",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							texturePath = "ui/activity/groupPurchase/rule_explain.png",
							touchAble = "False",
							UILayoutViewModel = 
							{
								PositionX = 657,
								PositionY = 487,
							},
							width = "331",
							ZOrder = "1",
						},
						{
							controlID = "Button_Start_Panel_root_Panel-RuleView_groupPurchase_activity_Game",
							UUID = "77a79d85_6bc8_4979_9e90_98fec31e4a82",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							backGroundScale9Enable = "False",
							classname = "MEButton",
							ClickHighLightEnabled = "True",
							dstBlendFunc = "771",
							flipX = "False",
							flipY = "False",
							height = "59",
							ignoreSize = "True",
							name = "Button_Start",
							normal = "ui/activity/groupPurchase/rule_btn.png",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							touchAble = "True",
							UILayoutViewModel = 
							{
								PositionX = 699,
								PositionY = 157,
							},
							UItype = "Button",
							width = "282",
							ZOrder = "1",
							components = 
							{
								
								{
									controlID = "btn_label_Button_Start_Panel_root_Panel-RuleView_groupPurchase_activity_Game",
									UUID = "3641a627_4d2b_4fa9_a556_6e8af126de2d",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									classname = "MELabel",
									compPath = "luacomponents.common.MEIconLabel",
									dstBlendFunc = "771",
									FontColor = "#FFFFFFFF",
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
									name = "btn_label",
									nTextAlign = "1",
									nTextHAlign = "1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "500个礼包币发起",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionX = 7,
										PositionY = -2,
									},
									width = "211",
									ZOrder = "1",
								},
							},
						},
						{
							controlID = "des_Panel_root_Panel-RuleView_groupPurchase_activity_Game",
							UUID = "b1a4c0d1_e8b2_4517_89dd_fcca3f1f1698",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							classname = "MELabel",
							compPath = "luacomponents.common.MEIconLabel",
							dstBlendFunc = "771",
							FontColor = "#FF2F386F",
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
							height = "200",
							ignoreSize = "False",
							name = "des",
							nTextAlign = "0",
							nTextHAlign = "0",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "770",
							text = "张张张张张张张张张张张张张张张张张张张张张张张张张张张张张张张张张张张张张张张张张张张张张张张张张张张张张张张张张张张张张张张张张张张张张张张张张张张张张张张张张张张张张张张张张张张张张张张张张张张张张张张张张张张张张张张张张张张张张张张张张张张张张张张张张张张张张张张张张张张张张张张张张张张张张张张张",
							touchAble = "False",
							touchScaleEnable = "False",
							UILayoutViewModel = 
							{
								PositionX = 594,
								PositionY = 314,
							},
							width = "490",
							ZOrder = "1",
						},
						{
							controlID = "careful_Panel_root_Panel-RuleView_groupPurchase_activity_Game",
							UUID = "0e858d79_ae05_48e0_8468_d896fdc43526",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							classname = "MELabel",
							compPath = "luacomponents.common.MEIconLabel",
							dstBlendFunc = "771",
							FontColor = "#FFFFFFFF",
							fontName = "font/MFLiHei_Noncommercial.ttf",
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
								IsStroke = true,
								StrokeColor = "#FF546188",
								StrokeSize = 1,
							},
							height = "27",
							ignoreSize = "True",
							name = "careful",
							nTextAlign = "1",
							nTextHAlign = "1",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "770",
							text = "请仔细阅读",
							touchAble = "False",
							touchScaleEnable = "False",
							UILayoutViewModel = 
							{
								PositionX = 756,
								PositionY = 434,
							},
							width = "108",
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
			"ui/activity/groupPurchase/rule_bg.png",
			"ui/activity/groupPurchase/rule_explain.png",
			"ui/activity/groupPurchase/rule_btn.png",
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

