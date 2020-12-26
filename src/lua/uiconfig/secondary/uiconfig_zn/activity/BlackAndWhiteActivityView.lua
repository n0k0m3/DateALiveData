local t = 
{
	version = 1,
	components = 
	{
		
		{
			controlID = "Panel-BlackAndWhiteActivityView_Layer1_activity_Game",
			UUID = "cc4e62c0_359b_49b5_b4cc_a32f217b7ff5",
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
			height = "536",
			ignoreSize = "False",
			name = "Panel",
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
			width = "926",
			ZOrder = "1",
			components = 
			{
				
				{
					controlID = "Panel_root_Panel-BlackAndWhiteActivityView_Layer1_activity_Game",
					UUID = "1c457632_3f38_4a1e_846d_6bcf403a8940",
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
					height = "548",
					ignoreSize = "False",
					name = "Panel_root",
					sizepercentx = "100",
					sizepercenty = "100",
					sizeType = "1",
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
					width = "888",
					ZOrder = "1",
					components = 
					{
						
						{
							controlID = "Image_BlackAndWhiteActivityView_1_Panel_root_Panel-BlackAndWhiteActivityView_Layer1_activity_Game",
							UUID = "6ef10b0b_01c9_49ec_8892_f35daa5de38b",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							backGroundScale9Enable = "False",
							classname = "MEImage",
							dstBlendFunc = "771",
							height = "536",
							ignoreSize = "True",
							name = "Image_BlackAndWhiteActivityView_1",
							sizepercentx = "100",
							sizepercenty = "100",
							sizeType = "0",
							srcBlendFunc = "1",
							texturePath = "ui/activity/BlackAndWhite/enter/004.png",
							touchAble = "False",
							UILayoutViewModel = 
							{
								
							},
							width = "926",
							ZOrder = "1",
						},
						{
							controlID = "Image_rank_Panel_root_Panel-BlackAndWhiteActivityView_Layer1_activity_Game",
							UUID = "d207b781_37db_42f1_adbf_12420c418c94",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							backGroundScale9Enable = "False",
							classname = "MEButton",
							ClickHighLightEnabled = "True",
							dstBlendFunc = "771",
							flipX = "False",
							flipY = "False",
							height = "142",
							ignoreSize = "True",
							name = "Image_rank",
							normal = "ui/activity/BlackAndWhite/enter/002.png",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							touchAble = "True",
							UILayoutViewModel = 
							{
								PositionX = 394,
								PositionY = -58,
							},
							UItype = "Button",
							width = "92",
							ZOrder = "1",
							components = 
							{
								
								{
									controlID = "Label_BlackAndWhiteActivityView_1_Image_rank_Panel_root_Panel-BlackAndWhiteActivityView_Layer1_activity_Game",
									UUID = "bde1fdaa_72b7_4c90_a141_85173e397b82",
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
									fontSize = "22",
									fontStroke = 
									{
										IsStroke = true,
										StrokeColor = "#FFF588A7",
										StrokeSize = 1,
									},
									height = "29",
									ignoreSize = "True",
									name = "Label_BlackAndWhiteActivityView_1",
									nTextAlign = "1",
									nTextHAlign = "1",
									rotation = "-32",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "排行",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionX = 12,
										PositionY = -42,
									},
									width = "48",
									ZOrder = "1",
								},
							},
						},
						{
							controlID = "Image_main_Panel_root_Panel-BlackAndWhiteActivityView_Layer1_activity_Game",
							UUID = "578f1604_7616_40b6_8472_651811678f98",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							backGroundScale9Enable = "False",
							classname = "MEButton",
							ClickHighLightEnabled = "True",
							dstBlendFunc = "771",
							flipX = "False",
							flipY = "False",
							height = "142",
							ignoreSize = "True",
							name = "Image_main",
							normal = "ui/activity/BlackAndWhite/enter/003.png",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							touchAble = "True",
							UILayoutViewModel = 
							{
								PositionX = 341,
								PositionY = -170,
							},
							UItype = "Button",
							width = "92",
							ZOrder = "1",
							components = 
							{
								
								{
									controlID = "Image_item_Image_main_Panel_root_Panel-BlackAndWhiteActivityView_Layer1_activity_Game",
									UUID = "ea555a4c_b4bb_4c98_86c3_1d68e09b3a20",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "64",
									ignoreSize = "True",
									name = "Image_item",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = 79,
										PositionY = -53,
									},
									visible = "False",
									width = "64",
									ZOrder = "1",
								},
								{
									controlID = "Label_itemcost_Image_main_Panel_root_Panel-BlackAndWhiteActivityView_Layer1_activity_Game",
									UUID = "9cde1c88_f8aa_49c0_a54c_a9d2541baadf",
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
									fontSize = "18",
									fontStroke = 
									{
										IsStroke = false,
										StrokeColor = "#FFE6E6E6",
										StrokeSize = 1,
									},
									height = "21",
									ignoreSize = "True",
									name = "Label_itemcost",
									nTextAlign = "1",
									nTextHAlign = "1",
									rotation = "-32",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "TextLable",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionX = 82,
										PositionY = -61,
									},
									visible = "False",
									width = "73",
									ZOrder = "1",
								},
								{
									controlID = "Label_BlackAndWhiteActivityView_1_Image_main_Panel_root_Panel-BlackAndWhiteActivityView_Layer1_activity_Game",
									UUID = "6f00b85a_3809_4f7e_a53c_7c74fb207eba",
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
									fontSize = "22",
									fontStroke = 
									{
										IsStroke = true,
										StrokeColor = "#FFF588A7",
										StrokeSize = 1,
									},
									height = "29",
									ignoreSize = "True",
									name = "Label_BlackAndWhiteActivityView_1",
									nTextAlign = "1",
									nTextHAlign = "1",
									rotation = "-32",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "进入",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionX = 12,
										PositionY = -41,
									},
									width = "48",
									ZOrder = "1",
								},
							},
						},
						{
							controlID = "Image_BlackAndWhiteActivityView_2_Panel_root_Panel-BlackAndWhiteActivityView_Layer1_activity_Game",
							UUID = "45e5b86e_ca83_442a_b466_dc8de9f58c14",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							backGroundScale9Enable = "False",
							classname = "MEImage",
							dstBlendFunc = "771",
							height = "82",
							ignoreSize = "True",
							name = "Image_BlackAndWhiteActivityView_2",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							texturePath = "ui/activity/BlackAndWhite/enter/001.png",
							touchAble = "False",
							UILayoutViewModel = 
							{
								PositionX = -345,
								PositionY = -152,
							},
							width = "156",
							ZOrder = "1",
						},
						{
							controlID = "Image_BlackAndWhiteActivityView_3_Panel_root_Panel-BlackAndWhiteActivityView_Layer1_activity_Game",
							UUID = "68953d70_095e_4042_9416_ec970874d22f",
							anchorPoint = "False",
							anchorPointX = "0",
							anchorPointY = "0",
							backGroundScale9Enable = "False",
							classname = "MEImage",
							dstBlendFunc = "771",
							height = "88",
							ignoreSize = "True",
							name = "Image_BlackAndWhiteActivityView_3",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							texturePath = "ui/activity/oneYear/corner.png",
							touchAble = "False",
							UILayoutViewModel = 
							{
								PositionX = -463,
								PositionY = 180,
							},
							width = "150",
							ZOrder = "1",
						},
						{
							controlID = "label_time_Panel_root_Panel-BlackAndWhiteActivityView_Layer1_activity_Game",
							UUID = "bbf113ce_0bdb_471b_a321_fc2bc41b50ff",
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
							fontSize = "18",
							fontStroke = 
							{
								IsStroke = true,
								StrokeColor = "#FF216298",
								StrokeSize = 1,
							},
							height = "24",
							ignoreSize = "True",
							name = "label_time",
							nTextAlign = "1",
							nTextHAlign = "1",
							rotation = "330",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "770",
							text = "TextLable",
							touchAble = "False",
							touchScaleEnable = "False",
							UILayoutViewModel = 
							{
								PositionX = -384,
								PositionY = 210,
							},
							width = "119",
							ZOrder = "1",
						},
						{
							controlID = "Spine_BlackAndWhiteActivityView_1_Panel_root_Panel-BlackAndWhiteActivityView_Layer1_activity_Game",
							UUID = "13c87345_1726_4577_beb1_b0d60fec87dc",
							classname = "MESpine",
							dstBlendFunc = "771",
							name = "Spine_BlackAndWhiteActivityView_1",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							spineModel = 
							{
								SpinePath = "effect/title/effect_title_black_01/effect_title_black_01",
								animationName = "animation",
								IsLoop = true,
								IsPlay = true,
								IsUseQueue = false,
								AnimationQueue = 
								{
									
								},
							},
							srcBlendFunc = "1",
							touchAble = "False",
							UILayoutViewModel = 
							{
								PositionX = -344,
								PositionY = -163,
								TopPosition = 536,
								relativeToName = "Panel",
							},
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
			"ui/activity/BlackAndWhite/enter/004.png",
			"ui/activity/BlackAndWhite/enter/002.png",
			"ui/activity/BlackAndWhite/enter/003.png",
			"ui/activity/BlackAndWhite/enter/001.png",
			"ui/activity/oneYear/corner.png",
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

