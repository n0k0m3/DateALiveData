local t = 
{
	version = 1,
	components = 
	{
		
		{
			controlID = "Panel-BalloonRewardView_balloon_activity_Game",
			UUID = "318c41e9_8253_4126_af61_e7b60990887c",
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
					controlID = "img_bg_Panel-BalloonRewardView_balloon_activity_Game",
					UUID = "49892967_b2d5_4579_9fc8_1c3fb2f3b231",
					anchorPoint = "False",
					anchorPointX = "0.5",
					anchorPointY = "0.5",
					backGroundScale9Enable = "False",
					classname = "MEImage",
					dstBlendFunc = "771",
					height = "454",
					ignoreSize = "True",
					name = "img_bg",
					sizepercentx = "0",
					sizepercenty = "0",
					sizeType = "0",
					srcBlendFunc = "1",
					texturePath = "ui/balloon/23.png",
					touchAble = "True",
					UILayoutViewModel = 
					{
						PositionX = 568,
						PositionY = 320,
						relativeToName = "Panel",
						nType = 3,
						nGravity = 6,
						nAlign = 5
					},
					width = "820",
					ZOrder = "1",
					components = 
					{
						
						{
							controlID = "label_title_img_bg_Panel-BalloonRewardView_balloon_activity_Game",
							UUID = "f585e625_4c34_4f69_91a8_76b3a25237d0",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							classname = "MELabel",
							compPath = "luacomponents.common.MEIconLabel",
							dstBlendFunc = "771",
							FontColor = "#FF485381",
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
							text = "奖励详情",
							touchAble = "False",
							touchScaleEnable = "False",
							UILayoutViewModel = 
							{
								PositionX = -155,
								PositionY = 167,
							},
							width = "115",
							ZOrder = "1",
							components = 
							{
								
								{
									controlID = "img_line_label_title_img_bg_Panel-BalloonRewardView_balloon_activity_Game",
									UUID = "b30cb885_6770_44f7_8a91_b91e4689dddd",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "26",
									ignoreSize = "True",
									name = "img_line",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									texturePath = "ui/balloon/28.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = 62,
										PositionY = 2,
									},
									width = "5",
									ZOrder = "1",
								},
								{
									controlID = "label_title1_label_title_img_bg_Panel-BalloonRewardView_balloon_activity_Game",
									UUID = "49c46883_c1be_4880_839a_2f9654498999",
									anchorPoint = "False",
									anchorPointX = "0",
									anchorPointY = "0.5",
									classname = "MELabel",
									compPath = "luacomponents.common.MEIconLabel",
									dstBlendFunc = "771",
									FontColor = "#FF485381",
									fontName = "font/fangzheng_zhunyuan.ttf",
									fontShadow = 
									{
										IsShadow = false,
										ShadowColor = "#FFFFFFFF",
										ShadowAlpha = 255,
										OffsetX = 0,
										OffsetY = 0,
									},
									fontSize = "16",
									fontStroke = 
									{
										IsStroke = false,
										StrokeColor = "#FFE6E6E6",
										StrokeSize = 1,
									},
									height = "18",
									ignoreSize = "True",
									name = "label_title1",
									nTextAlign = "1",
									nTextHAlign = "1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "Rewards",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionX = 67,
										PositionY = -4,
									},
									width = "61",
									ZOrder = "1",
								},
							},
						},
						{
							controlID = "btn_close_img_bg_Panel-BalloonRewardView_balloon_activity_Game",
							UUID = "6a6259c8_e96b_4ad4_a3c4_1c43cae614fb",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							backGroundScale9Enable = "False",
							classname = "MEButton",
							ClickHighLightEnabled = "True",
							dstBlendFunc = "771",
							flipX = "False",
							flipY = "False",
							height = "32",
							ignoreSize = "True",
							name = "btn_close",
							normal = "ui/balloon/close_btn.png",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							touchAble = "True",
							UILayoutViewModel = 
							{
								PositionX = 338,
								PositionY = 170,
							},
							UItype = "Button",
							width = "35",
							ZOrder = "1",
						},
						{
							controlID = "img_di_img_bg_Panel-BalloonRewardView_balloon_activity_Game",
							UUID = "c7602089_873e_4136_b85e_e03eeb158ddb",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							backGroundScale9Enable = "False",
							classname = "MEImage",
							dstBlendFunc = "771",
							height = "293",
							ignoreSize = "True",
							name = "img_di",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							texturePath = "ui/balloon/24.png",
							touchAble = "False",
							UILayoutViewModel = 
							{
								PositionX = 6,
								PositionY = -1,
							},
							width = "719",
						},
						{
							controlID = "scroll_list_img_bg_Panel-BalloonRewardView_balloon_activity_Game",
							UUID = "bb374029_500d_42cd_baab_cb515f3352e6",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							backGroundScale9Enable = "False",
							bgColorOpacity = "50",
							bIsOpenClipping = "True",
							bounceEnable = "False",
							classname = "MEScrollView",
							colorType = "0;SingleColor:#FFE6E6E6;GraduallyChangingColorStart:#FFFFFFFF;GraduallyChangingColorEnd:#FFFFFFFF;vectorX:0;vectorY:0",
							direction = "1",
							dstBlendFunc = "771",
							height = "286",
							ignoreSize = "False",
							innerHeight = "286",
							innerWidth = "710",
							name = "scroll_list",
							showScrollbar = "False",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							touchAble = "True",
							UILayoutViewModel = 
							{
								PositionX = 6,
								PositionY = -2,
							},
							uipanelviewmodel = 
							{
								Layout="Absolute",
								nType = "0"
							},
							width = "710",
							ZOrder = "1",
						},
					},
				},
				{
					controlID = "reward_item_Panel-BalloonRewardView_balloon_activity_Game",
					UUID = "0595a4e4_b857_4bc7_be20_8f19a033da64",
					anchorPoint = "False",
					anchorPointX = "0.5",
					anchorPointY = "0.5",
					backGroundScale9Enable = "True;capInsetsX:0;capInsetsY:0;capInsetsWidth:0;capInsetsHeight:0",
					classname = "MEImage",
					dstBlendFunc = "771",
					height = "80",
					ignoreSize = "False",
					name = "reward_item",
					sizepercentx = "0",
					sizepercenty = "0",
					sizeType = "0",
					srcBlendFunc = "1",
					texturePath = "ui/balloon/27.png",
					touchAble = "False",
					UILayoutViewModel = 
					{
						PositionX = 578,
						PositionY = -66,
						LeftPositon = 223,
						TopPosition = 666,
						relativeToName = "Panel",
						nType = 3,
					},
					width = "710",
					ZOrder = "1",
					components = 
					{
						
						{
							controlID = "label_desc_reward_item_Panel-BalloonRewardView_balloon_activity_Game",
							UUID = "7955e5e0_77cc_4362_b2b6_59798b6cf256",
							anchorPoint = "False",
							anchorPointX = "0",
							anchorPointY = "0.5",
							classname = "MELabel",
							compPath = "luacomponents.common.MEIconLabel",
							dstBlendFunc = "771",
							FontColor = "#FF485381",
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
							name = "label_desc",
							nTextAlign = "1",
							nTextHAlign = "1",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "770",
							text = "上交1种气球",
							touchAble = "False",
							touchScaleEnable = "False",
							UILayoutViewModel = 
							{
								PositionX = -336,
								PositionY = -1,
							},
							width = "131",
							ZOrder = "1",
						},
						{
							controlID = "label_get_reward_item_Panel-BalloonRewardView_balloon_activity_Game",
							UUID = "7668a946_1db6_4fa2_b332_16e2509564bc",
							anchorPoint = "False",
							anchorPointX = "1",
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
							name = "label_get",
							nTextAlign = "1",
							nTextHAlign = "1",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "770",
							text = "Bisa dapat",
							touchAble = "False",
							touchScaleEnable = "False",
							UILayoutViewModel = 
							{
								PositionX = 53,
								PositionY = -1,
							},
							width = "75",
							ZOrder = "1",
						},
						{
							controlID = "img_line_reward_item_Panel-BalloonRewardView_balloon_activity_Game",
							UUID = "86fd6fb9_eb6c_42c1_ab1f_919ba5ffd457",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							backGroundScale9Enable = "False",
							classname = "MEImage",
							dstBlendFunc = "771",
							height = "64",
							ignoreSize = "True",
							name = "img_line",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							texturePath = "ui/balloon/06.png",
							touchAble = "False",
							UILayoutViewModel = 
							{
								PositionX = 68,
							},
							width = "2",
							ZOrder = "1",
						},
						{
							controlID = "rewards_reward_item_Panel-BalloonRewardView_balloon_activity_Game",
							UUID = "94f36402_5d90_409e_b8b8_4e01d8489310",
							anchorPoint = "False",
							anchorPointX = "0",
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
							height = "70",
							ignoreSize = "False",
							name = "rewards",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							touchAble = "False",
							UILayoutViewModel = 
							{
								PositionX = 76,
							},
							uipanelviewmodel = 
							{
								Layout="Absolute",
								nType = "0"
							},
							width = "270",
							ZOrder = "1",
							components = 
							{
								
								{
									controlID = "pos1_rewards_reward_item_Panel-BalloonRewardView_balloon_activity_Game",
									UUID = "7055cbe1_852d_4341_9ac3_b80e6fdec6a9",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									bgColorOpacity = "50",
									bIsOpenClipping = "False",
									classname = "MEPanel",
									colorType = "0;SingleColor:#00FFFFFF;GraduallyChangingColorStart:#FFFFFFFF;GraduallyChangingColorEnd:#FFFFFFFF;vectorX:0;vectorY:0",
									DesignHeight = "640",
									DesignType = "0",
									DesignWidth = "960",
									dstBlendFunc = "771",
									height = "50",
									ignoreSize = "False",
									name = "pos1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = 36,
									},
									uipanelviewmodel = 
									{
										Layout="Absolute",
										nType = "0"
									},
									width = "50",
									ZOrder = "1",
								},
								{
									controlID = "pos2_rewards_reward_item_Panel-BalloonRewardView_balloon_activity_Game",
									UUID = "77416e1f_8059_4692_bc3e_af1056bf2260",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									bgColorOpacity = "50",
									bIsOpenClipping = "False",
									classname = "MEPanel",
									colorType = "0;SingleColor:#00FFFFFF;GraduallyChangingColorStart:#FFFFFFFF;GraduallyChangingColorEnd:#FFFFFFFF;vectorX:0;vectorY:0",
									DesignHeight = "640",
									DesignType = "0",
									DesignWidth = "960",
									dstBlendFunc = "771",
									height = "50",
									ignoreSize = "False",
									name = "pos2",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = 106,
									},
									uipanelviewmodel = 
									{
										Layout="Absolute",
										nType = "0"
									},
									width = "50",
									ZOrder = "1",
								},
								{
									controlID = "pos3_rewards_reward_item_Panel-BalloonRewardView_balloon_activity_Game",
									UUID = "e816cd37_978e_4e4d_962d_5215c8490965",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									bgColorOpacity = "50",
									bIsOpenClipping = "False",
									classname = "MEPanel",
									colorType = "0;SingleColor:#00FFFFFF;GraduallyChangingColorStart:#FFFFFFFF;GraduallyChangingColorEnd:#FFFFFFFF;vectorX:0;vectorY:0",
									DesignHeight = "640",
									DesignType = "0",
									DesignWidth = "960",
									dstBlendFunc = "771",
									height = "50",
									ignoreSize = "False",
									name = "pos3",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = 176,
									},
									uipanelviewmodel = 
									{
										Layout="Absolute",
										nType = "0"
									},
									width = "50",
									ZOrder = "1",
								},
								{
									controlID = "pos4_rewards_reward_item_Panel-BalloonRewardView_balloon_activity_Game",
									UUID = "717c7f8e_909f_456b_8383_dc0158bd6be6",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									bgColorOpacity = "50",
									bIsOpenClipping = "False",
									classname = "MEPanel",
									colorType = "0;SingleColor:#00FFFFFF;GraduallyChangingColorStart:#FFFFFFFF;GraduallyChangingColorEnd:#FFFFFFFF;vectorX:0;vectorY:0",
									DesignHeight = "640",
									DesignType = "0",
									DesignWidth = "960",
									dstBlendFunc = "771",
									height = "50",
									ignoreSize = "False",
									name = "pos4",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = 246,
									},
									uipanelviewmodel = 
									{
										Layout="Absolute",
										nType = "0"
									},
									width = "50",
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
			"ui/balloon/23.png",
			"ui/balloon/28.png",
			"ui/balloon/close_btn.png",
			"ui/balloon/24.png",
			"ui/balloon/27.png",
			"ui/balloon/06.png",
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

