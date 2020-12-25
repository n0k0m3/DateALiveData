local t = 
{
	version = 1,
	components = 
	{
		
		{
			controlID = "Panel-summonContractMainView_Layer1_summon_Game",
			UUID = "2938a765_46f6_4ae5_bea9_e7902b6e5f8a",
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
					controlID = "Panel_root_Panel-summonContractMainView_Layer1_summon_Game",
					UUID = "a33cce9d_a54b_4ad9_a04a_0bf9cd8313f3",
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
							controlID = "Image_bg_Panel_root_Panel-summonContractMainView_Layer1_summon_Game",
							UUID = "3367754a_718b_4d7c_9ca1_d608b323fd47",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							backGroundScale9Enable = "False",
							classname = "MEImage",
							dstBlendFunc = "771",
							height = "640",
							ignoreSize = "True",
							name = "Image_bg",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							texturePath = "ui/summon/elf_contract/new_1/bg.png",
							touchAble = "False",
							UILayoutViewModel = 
							{
								
							},
							width = "1386",
							ZOrder = "1",
						},
						{
							controlID = "Image_title_tip_Panel_root_Panel-summonContractMainView_Layer1_summon_Game",
							UUID = "13101788_6310_42b6_9bdd_22ee9609617b",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							backGroundScale9Enable = "False",
							classname = "MEImage",
							dstBlendFunc = "771",
							height = "127",
							ignoreSize = "True",
							name = "Image_title_tip",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							texturePath = "ui/summon/elf_contract/title_tip.png",
							touchAble = "False",
							UILayoutViewModel = 
							{
								PositionX = -210,
								PositionY = -150,
							},
							visible = "False",
							width = "364",
							ZOrder = "1",
						},
						{
							controlID = "Button_details_Panel_root_Panel-summonContractMainView_Layer1_summon_Game",
							UUID = "a905ddac_3b9e_480a_867c_1d7bd81d5619",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							backGroundScale9Enable = "False",
							classname = "MEButton",
							ClickHighLightEnabled = "True",
							dstBlendFunc = "771",
							flipX = "False",
							flipY = "False",
							height = "84",
							ignoreSize = "True",
							name = "Button_details",
							normal = "ui/summon/elf_contract/new_1/004.png",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							touchAble = "True",
							UILayoutViewModel = 
							{
								PositionX = -285,
								PositionY = -273,
							},
							UItype = "Button",
							width = "296",
							ZOrder = "1",
						},
						{
							controlID = "Image_task_Panel_root_Panel-summonContractMainView_Layer1_summon_Game",
							UUID = "47b9c066_a531_4bdd_9ec2_99fd0d9ebcb4",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							backGroundScale9Enable = "False",
							classname = "MEImage",
							dstBlendFunc = "771",
							height = "64",
							ignoreSize = "True",
							name = "Image_task",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							touchAble = "False",
							UILayoutViewModel = 
							{
								PositionX = 403,
								PositionY = 12,
							},
							width = "64",
							ZOrder = "1",
							components = 
							{
								
								{
									controlID = "ScrollView_task_Image_task_Panel_root_Panel-summonContractMainView_Layer1_summon_Game",
									UUID = "e23a4432_c1e3_4229_a018_037d2feec4b1",
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
									height = "330",
									ignoreSize = "False",
									innerHeight = "330",
									innerWidth = "380",
									name = "ScrollView_task",
									showScrollbar = "False",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "True",
									UILayoutViewModel = 
									{
										PositionX = -30,
										PositionY = -70,
									},
									uipanelviewmodel = 
									{
										Layout="Absolute",
										nType = "0"
									},
									width = "380",
									ZOrder = "1",
								},
								{
									controlID = "Image_summonContractMainView_1_Image_task_Panel_root_Panel-summonContractMainView_Layer1_summon_Game",
									UUID = "b3fa40ce_64f7_497a_b451_f4bb0d3b2262",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "640",
									ignoreSize = "True",
									name = "Image_summonContractMainView_1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/summon/elf_contract/new_1/bg2_1.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = 24,
										PositionY = -9,
									},
									width = "524",
									ZOrder = "1",
								},
								{
									controlID = "Image_scrollBar_Image_task_Panel_root_Panel-summonContractMainView_Layer1_summon_Game",
									UUID = "3c8cf309_a804_468d_89dd_16fb92460ebd",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "True;capInsetsX:0;capInsetsY:0;capInsetsWidth:0;capInsetsHeight:0",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "330",
									ignoreSize = "False",
									name = "Image_scrollBar",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/common/scroll_bar_01.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = 154,
										PositionY = -70,
									},
									width = "6",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "Image_scrollBarInner_Image_scrollBar_Image_task_Panel_root_Panel-summonContractMainView_Layer1_summon_Game",
											UUID = "72f91dbe_74b1_4ffb_93fb_78f17dedf066",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "True;capInsetsX:0;capInsetsY:0;capInsetsWidth:0;capInsetsHeight:0",
											classname = "MEImage",
											dstBlendFunc = "771",
											height = "330",
											ignoreSize = "False",
											name = "Image_scrollBarInner",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											texturePath = "ui/common/scroll_bar_02.png",
											touchAble = "False",
											UILayoutViewModel = 
											{
												
											},
											width = "6",
											ZOrder = "1",
										},
									},
								},
							},
						},
						{
							controlID = "Image_contract_Panel_root_Panel-summonContractMainView_Layer1_summon_Game",
							UUID = "1f9153b3_a999_41c0_9c8c_15b1a1f055b0",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							backGroundScale9Enable = "False",
							classname = "MEImage",
							dstBlendFunc = "771",
							height = "128",
							ignoreSize = "True",
							name = "Image_contract",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							texturePath = "ui/summon/elf_contract/new_1/006.png",
							touchAble = "False",
							UILayoutViewModel = 
							{
								PositionX = 341,
								PositionY = 171,
							},
							width = "424",
							ZOrder = "1",
							components = 
							{
								
								{
									controlID = "Label_contract_Image_contract_Panel_root_Panel-summonContractMainView_Layer1_summon_Game",
									UUID = "06973f22_b58d_4619_9112_49535aa4d6b5",
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
									name = "Label_contract",
									nTextAlign = "1",
									nTextHAlign = "1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "Termina invocación de espíritus",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionX = -93,
										PositionY = 12,
									},
									visible = "False",
									width = "251",
									ZOrder = "1",
								},
								{
									controlID = "Label_timing_Image_contract_Panel_root_Panel-summonContractMainView_Layer1_summon_Game",
									UUID = "0916f666_8046_41dc_b481_dcb8b6a6ae3c",
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
									name = "Label_timing",
									nTextAlign = "1",
									nTextHAlign = "1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "99:99:99",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionX = 84,
										PositionY = -13,
									},
									visible = "False",
									width = "72",
									ZOrder = "1",
								},
								{
									controlID = "lab_tip_Image_contract_Panel_root_Panel-summonContractMainView_Layer1_summon_Game",
									UUID = "7546c300_b47b_4b5e_9fe0_59269a994951",
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
									fontSize = "20",
									fontStroke = 
									{
										IsStroke = false,
										StrokeColor = "#FFE6E6E6",
										StrokeSize = 1,
									},
									height = "0",
									ignoreSize = "False",
									name = "lab_tip",
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
										PositionX = 32,
									},
									width = "241",
									ZOrder = "1",
								},
								{
									controlID = "Label_cond_Image_contract_Panel_root_Panel-summonContractMainView_Layer1_summon_Game",
									UUID = "8e0edca4_eea7_45ed_945e_38c6e0f2a81b",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									classname = "MELabel",
									compPath = "luacomponents.common.MEIconLabel",
									dstBlendFunc = "771",
									FontColor = "#FFABCFF2",
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
									name = "Label_cond",
									nTextAlign = "1",
									nTextHAlign = "1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "(Puedes comprar y activar nuevamente después del nivel 60)",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionX = 40,
										PositionY = -16,
									},
									visible = "False",
									width = "468",
									ZOrder = "1",
								},
								{
									controlID = "Label_cur_level_Image_contract_Panel_root_Panel-summonContractMainView_Layer1_summon_Game",
									UUID = "78e12e6f_2663_439a_9a40_b5e315027a5a",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									classname = "MELabel",
									compPath = "luacomponents.common.MEIconLabel",
									dstBlendFunc = "771",
									FontColor = "#FFFEE968",
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
										IsStroke = true,
										StrokeColor = "#FF425478",
										StrokeSize = 1,
									},
									height = "25",
									ignoreSize = "True",
									name = "Label_cur_level",
									nTextAlign = "1",
									nTextHAlign = "1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "Nv",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionX = -164,
										PositionY = 21,
									},
									width = "26",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "Label_level_Label_cur_level_Image_contract_Panel_root_Panel-summonContractMainView_Layer1_summon_Game",
											UUID = "c8bf4dd1_0ee7_498f_a625_952a3b7a2371",
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
											fontSize = "38",
											fontStroke = 
											{
												IsStroke = false,
												StrokeColor = "#FFE6E6E6",
												StrokeSize = 1,
											},
											height = "44",
											ignoreSize = "True",
											name = "Label_level",
											nTextAlign = "1",
											nTextHAlign = "1",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "770",
											text = "34",
											touchAble = "False",
											touchScaleEnable = "False",
											UILayoutViewModel = 
											{
												PositionX = 8,
												PositionY = -36,
											},
											width = "43",
											ZOrder = "1",
										},
									},
								},
								{
									controlID = "lvBar_Image_contract_Panel_root_Panel-summonContractMainView_Layer1_summon_Game",
									UUID = "70d0d23c_978f_4e9e_bc0f_a0ecbb980c87",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MELoadingBar",
									direction = "5",
									dstBlendFunc = "771",
									height = "112",
									ignoreSize = "True",
									name = "lvBar",
									percent = "60",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texture = "ui/summon/elf_contract/new_1/005.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = -154,
									},
									width = "96",
									ZOrder = "1",
								},
								{
									controlID = "Label_summonContractMainView_1_Image_contract_Panel_root_Panel-summonContractMainView_Layer1_summon_Game",
									UUID = "7f5332d4_19a4_4099_89d6_79e84279ca26",
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
										IsStroke = false,
										StrokeColor = "#FFE6E6E6",
										StrokeSize = 1,
									},
									height = "25",
									ignoreSize = "True",
									name = "Label_summonContractMainView_1",
									nTextAlign = "1",
									nTextHAlign = "1",
									rotation = "32",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "Actual",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionX = -120,
										PositionY = 57,
									},
									width = "69",
									ZOrder = "1",
								},
							},
						},
						{
							controlID = "Image_cost_Panel_root_Panel-summonContractMainView_Layer1_summon_Game",
							UUID = "6dee40a7_c8ac_43e5_8908_34e4ff1225f2",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							backGroundScale9Enable = "False",
							classname = "MEImage",
							dstBlendFunc = "771",
							height = "52",
							ignoreSize = "True",
							name = "Image_cost",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							texturePath = "ui/summon/elf_contract/003.png",
							touchAble = "False",
							UILayoutViewModel = 
							{
								PositionX = 464,
								PositionY = -233,
							},
							visible = "False",
							width = "182",
							ZOrder = "1",
							components = 
							{
								
								{
									controlID = "Image_raw_costIcon_Image_cost_Panel_root_Panel-summonContractMainView_Layer1_summon_Game",
									UUID = "5db6baee_a3b5_461b_b8e7_618b4d24f660",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "100",
									ignoreSize = "True",
									name = "Image_raw_costIcon",
									scaleX = "0.25",
									scaleY = "0.25",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "icon/system/005.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = -72,
										PositionY = 3,
									},
									visible = "False",
									width = "100",
									ZOrder = "1",
								},
								{
									controlID = "Label_price_Image_cost_Panel_root_Panel-summonContractMainView_Layer1_summon_Game",
									UUID = "4f2aeefc_4f73_47cd_92cd_816dbc17a806",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									classname = "MELabel",
									compPath = "luacomponents.common.MEIconLabel",
									dstBlendFunc = "771",
									FontColor = "#FF38436A",
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
										IsStroke = false,
										StrokeColor = "#FFE6E6E6",
										StrokeSize = 1,
									},
									height = "23",
									ignoreSize = "True",
									name = "Label_price",
									nTextAlign = "1",
									nTextHAlign = "1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "$",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionX = -68,
									},
									width = "14",
									ZOrder = "1",
								},
								{
									controlID = "Label_raw_costNum_Image_cost_Panel_root_Panel-summonContractMainView_Layer1_summon_Game",
									UUID = "1abcc345_f437_4cd1_beaf_d5c3735817cd",
									anchorPoint = "False",
									anchorPointX = "0",
									anchorPointY = "0.5",
									classname = "MELabel",
									compPath = "luacomponents.common.MEIconLabel",
									dstBlendFunc = "771",
									FontColor = "#FF38436A",
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
									height = "23",
									ignoreSize = "True",
									name = "Label_raw_costNum",
									nTextAlign = "1",
									nTextHAlign = "1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "29999",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionX = -56,
										PositionY = 3,
									},
									width = "57",
									ZOrder = "1",
								},
								{
									controlID = "Image_summonContractMainView_1_Image_cost_Panel_root_Panel-summonContractMainView_Layer1_summon_Game",
									UUID = "5c04898f_7dcd_415a_b2fe_1b3c76a297f1",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "20",
									ignoreSize = "True",
									name = "Image_summonContractMainView_1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "ui/summon/elf_contract/004.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = -44,
										PositionY = 4,
									},
									width = "88",
									ZOrder = "1",
								},
								{
									controlID = "Image_costIcon_Image_cost_Panel_root_Panel-summonContractMainView_Layer1_summon_Game",
									UUID = "15af0e24_48f0_4132_8fcd_93fca35b7367",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "100",
									ignoreSize = "True",
									name = "Image_costIcon",
									scaleX = "0.25",
									scaleY = "0.25",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "icon/system/005.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = 26,
										PositionY = 3,
									},
									visible = "False",
									width = "100",
									ZOrder = "1",
								},
								{
									controlID = "Label_price1_Image_cost_Panel_root_Panel-summonContractMainView_Layer1_summon_Game",
									UUID = "e4bdc7ab_3e9f_479f_8f16_41e5e86cef95",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									classname = "MELabel",
									compPath = "luacomponents.common.MEIconLabel",
									dstBlendFunc = "771",
									FontColor = "#FF38436A",
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
										IsStroke = false,
										StrokeColor = "#FFE6E6E6",
										StrokeSize = 1,
									},
									height = "23",
									ignoreSize = "True",
									name = "Label_price1",
									nTextAlign = "1",
									nTextHAlign = "1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "$",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionX = 22,
									},
									width = "14",
									ZOrder = "1",
								},
								{
									controlID = "Label_costNum_Image_cost_Panel_root_Panel-summonContractMainView_Layer1_summon_Game",
									UUID = "8168213d_2110_4a0f_aad1_52c72c154df2",
									anchorPoint = "False",
									anchorPointX = "0",
									anchorPointY = "0.5",
									classname = "MELabel",
									compPath = "luacomponents.common.MEIconLabel",
									dstBlendFunc = "771",
									FontColor = "#FF38436A",
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
									name = "Label_costNum",
									nTextAlign = "1",
									nTextHAlign = "1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "999",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionX = 35,
										PositionY = 3,
									},
									width = "41",
									ZOrder = "1",
								},
							},
						},
						{
							controlID = "Button_summon_Panel_root_Panel-summonContractMainView_Layer1_summon_Game",
							UUID = "75b4cc50_9ddd_4f7e_adda_ada5becdd928",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							backGroundScale9Enable = "False",
							classname = "MEButton",
							ClickHighLightEnabled = "True",
							dstBlendFunc = "771",
							flipX = "False",
							flipY = "False",
							height = "58",
							ignoreSize = "True",
							name = "Button_summon",
							normal = "ui/summon/elf_contract/new_1/003.png",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							touchAble = "True",
							UILayoutViewModel = 
							{
								PositionX = 237,
								PositionY = -280,
							},
							UItype = "Button",
							width = "134",
							ZOrder = "1",
							components = 
							{
								
								{
									controlID = "Label_summon_Button_summon_Panel_root_Panel-summonContractMainView_Layer1_summon_Game",
									UUID = "aa99ae50_3b97_425e_a6ae_8c15b4e51a2f",
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
									name = "Label_summon",
									nTextAlign = "1",
									nTextHAlign = "1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "Ir a invocar",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										
									},
									width = "114",
									ZOrder = "1",
								},
							},
						},
						{
							controlID = "Button_build_Panel_root_Panel-summonContractMainView_Layer1_summon_Game",
							UUID = "39ab6efa_dedb_48d0_a61a_edc32bb0dc0a",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							backGroundScale9Enable = "True;capInsetsX:0;capInsetsY:0;capInsetsWidth:0;capInsetsHeight:0",
							classname = "MEButton",
							ClickHighLightEnabled = "True",
							dstBlendFunc = "771",
							flipX = "False",
							flipY = "False",
							height = "58",
							ignoreSize = "False",
							name = "Button_build",
							normal = "ui/summon/elf_contract/new_1/002.png",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							touchAble = "True",
							UILayoutViewModel = 
							{
								PositionX = 416,
								PositionY = -280,
							},
							UItype = "Button",
							width = "214",
							ZOrder = "1",
							components = 
							{
								
								{
									controlID = "Label_build_Button_build_Panel_root_Panel-summonContractMainView_Layer1_summon_Game",
									UUID = "be3284e3_93c6_4405_b2c7_8209d12f9cb2",
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
									name = "Label_build",
									nTextAlign = "1",
									nTextHAlign = "1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "Establecer covenant",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionY = -2,
									},
									width = "203",
									ZOrder = "1",
								},
								{
									controlID = "Image_icon_Button_build_Panel_root_Panel-summonContractMainView_Layer1_summon_Game",
									UUID = "8368b50a_8b3e_47ea_b542_7642ed399937",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "64",
									ignoreSize = "True",
									name = "Image_icon",
									scaleX = "0.6",
									scaleY = "0.6",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = -56,
									},
									width = "64",
									ZOrder = "1",
								},
								{
									controlID = "spine_effect_Button_build_Panel_root_Panel-summonContractMainView_Layer1_summon_Game",
									UUID = "762808ef_3c7e_45e9_bd42_2483ed86d64c",
									classname = "MESpine",
									dstBlendFunc = "771",
									name = "spine_effect",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									spineModel = 
									{
										SpinePath = "effect/jinglingqiyue_all/jinglingqiyue_all",
										animationName = "animation3",
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
										PositionX = -5,
										PositionY = 7,
									},
									ZOrder = "-14",
								},
							},
						},
						{
							controlID = "Image_flag_Panel_root_Panel-summonContractMainView_Layer1_summon_Game",
							UUID = "bba08411_0d81_4f83_9b4d_d415992fe2c4",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							backGroundScale9Enable = "False",
							classname = "MEImage",
							dstBlendFunc = "771",
							height = "88",
							ignoreSize = "False",
							name = "Image_flag",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							texturePath = "ui/summon/elf_contract/036.png",
							touchAble = "False",
							UILayoutViewModel = 
							{
								PositionX = 420,
								PositionY = -236,
							},
							width = "273",
							ZOrder = "1",
							components = 
							{
								
								{
									controlID = "Label_num_Image_flag_Panel_root_Panel-summonContractMainView_Layer1_summon_Game",
									UUID = "db79f689_db04_4da7_86c1_af3a69c8f74f",
									anchorPoint = "False",
									anchorPointX = "1",
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
										IsStroke = true,
										StrokeColor = "#FF8A511E",
										StrokeSize = 2,
									},
									height = "32",
									ignoreSize = "True",
									name = "Label_num",
									nTextAlign = "1",
									nTextHAlign = "1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "4倍",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionX = 125,
										PositionY = 1,
									},
									width = "41",
									ZOrder = "1",
								},
								{
									controlID = "Label_tip_Image_flag_Panel_root_Panel-summonContractMainView_Layer1_summon_Game",
									UUID = "6cbe5992_f63d_4e8c_aa36_e96e608964b5",
									anchorPoint = "False",
									anchorPointX = "1",
									anchorPointY = "0.5",
									classname = "MELabel",
									compPath = "luacomponents.common.MEIconLabel",
									dstBlendFunc = "771",
									FontColor = "#FF8A511E",
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
										IsStroke = false,
										StrokeColor = "#FFE6E6E6",
										StrokeSize = 1,
									},
									height = "23",
									ignoreSize = "True",
									name = "Label_tip",
									nTextAlign = "1",
									nTextHAlign = "1",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "770",
									text = "Compensación",
									touchAble = "False",
									touchScaleEnable = "False",
									UILayoutViewModel = 
									{
										PositionX = 127,
										PositionY = 27,
									},
									width = "142",
									ZOrder = "1",
								},
							},
						},
						{
							controlID = "particle_effect_Panel_root_Panel-summonContractMainView_Layer1_summon_Game",
							UUID = "d46166d5_d4be_4a5b_9f13_37386bc11931",
							classname = "MEParticle",
							dstBlendFunc = "1",
							name = "particle_effect",
							particleViewModel = 
							{
								szParticlePath = "particles/particle_fenhong.plist",
								texturePath = "particles/particle_fenhong.png",
								bIsPlaying = true,
								Duration = -1,
								Life = 0.39,
								LifeVar = 0.4,
								Angle = 154,
								AngleVar = 50,
								StartSize = 32,
								StartSizeVar = 10,
								EndSize = 42,
								EndSizeVar = 0,
								TotalParticles = 102,
								StartSpin = 354,
								StartSpinVar = 0,
								EndSpin = 0,
								EndSpinVar = 0,
								StartColor = 
								{
									a = 63,
									 r = 255,
									 g = 102,
									 b = 153
								},
								StartColorVar = 
								{
									a = 25,
									 r = 0,
									 g = 0,
									 b = 38
								},
								EndColor = 
								{
									a = 255,
									 r = 0,
									 g = 0,
									 b = 0
								},
								EndColorVar = 
								{
									a = 0,
									 r = 0,
									 g = 0,
									 b = 0
								},
								EmitterMode = 0,
								TangentialAccel = 0,
								TangentialAccelVar = 0,
								Speed = 64,
								SpeedVar = 5,
								Gravity = 
								{
									 x = -60,
									 y = 0
								},
								SourcePosition = 
								{
									 x = 0,
									 y = 0
								},
								PosVar = 
								{
									 x = 20,
									 y = 15
								},
								RadialAccel = 0,
								RadialAccelVar = 0,
								StartRadius = 0,
								StartRadiusVar = 0,
								EndRadius = 0,
								EndRadiusVar = 0,
								RotatePerSecond = 0,
								RotatePerSecondVar = 0,
							},
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "770",
							touchAble = "False",
							UILayoutViewModel = 
							{
								PositionX = -62,
								PositionY = 14,
							},
							ZOrder = "1",
						},
					},
				},
				{
					controlID = "Panel_prefab_Panel-summonContractMainView_Layer1_summon_Game",
					UUID = "04e7284a_08c5_4872_b83d_40a9d34025b5",
					anchorPoint = "False",
					anchorPointX = "0.5",
					anchorPointY = "0.5",
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
					sizepercentx = "0",
					sizepercenty = "0",
					sizeType = "0",
					srcBlendFunc = "1",
					touchAble = "False",
					UILayoutViewModel = 
					{
						PositionX = -551,
						PositionY = -1161,
						LeftPositon = -551,
						TopPosition = 1161,
						relativeToName = "Panel",
						nType = 3,
						nGravity = 1,
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
							controlID = "Panel_taskItem_Panel_prefab_Panel-summonContractMainView_Layer1_summon_Game",
							UUID = "6cc56a28_096c_4b85_b813_2ff598be5901",
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
							height = "86",
							ignoreSize = "False",
							name = "Panel_taskItem",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							touchAble = "False",
							UILayoutViewModel = 
							{
								PositionX = -174,
								PositionY = 88,
							},
							uipanelviewmodel = 
							{
								Layout="Absolute",
								nType = "0"
							},
							width = "380",
							ZOrder = "1",
							components = 
							{
								
								{
									controlID = "Button_task_Panel_taskItem_Panel_prefab_Panel-summonContractMainView_Layer1_summon_Game",
									UUID = "51284b0c_1bfe_4e79_8b48_ee13237f8157",
									anchorPoint = "False",
									anchorPointX = "0",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEButton",
									ClickHighLightEnabled = "True",
									dstBlendFunc = "771",
									flipX = "False",
									flipY = "False",
									height = "94",
									ignoreSize = "True",
									name = "Button_task",
									normal = "ui/summon/elf_contract/new_1/007.png",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "True",
									UILayoutViewModel = 
									{
										PositionX = -170,
									},
									UItype = "Button",
									width = "330",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "Label_desc_Button_task_Panel_taskItem_Panel_prefab_Panel-summonContractMainView_Layer1_summon_Game",
											UUID = "9f5b7f25_5312_49b0_9b3a_43c922113ceb",
											anchorPoint = "False",
											anchorPointX = "0",
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
												IsStroke = false,
												StrokeColor = "#FFE6E6E6",
												StrokeSize = 1,
											},
											height = "25",
											ignoreSize = "True",
											name = "Label_desc",
											nTextAlign = "1",
											nTextHAlign = "1",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "770",
											text = "Alcanzar nivel 100",
											touchAble = "False",
											touchScaleEnable = "False",
											UILayoutViewModel = 
											{
												PositionX = 93,
												PositionY = -2,
											},
											width = "190",
											ZOrder = "1",
										},
										{
											controlID = "Image_icon_Button_task_Panel_taskItem_Panel_prefab_Panel-summonContractMainView_Layer1_summon_Game",
											UUID = "1bc317d4_501f_4a1e_8805_858d82faf9e2",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											classname = "MEImage",
											dstBlendFunc = "771",
											height = "100",
											ignoreSize = "True",
											name = "Image_icon",
											scaleX = "0.65",
											scaleY = "0.65",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											texturePath = "icon/system/005.png",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 44,
											},
											width = "100",
											ZOrder = "1",
										},
										{
											controlID = "img_getted_Button_task_Panel_taskItem_Panel_prefab_Panel-summonContractMainView_Layer1_summon_Game",
											UUID = "28f0fda2_0678_4bdd_8f83_a30a21bd885c",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											classname = "MEImage",
											dstBlendFunc = "771",
											height = "50",
											ignoreSize = "True",
											name = "img_getted",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											texturePath = "ui/role/newRoleShow/c5.png",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionX = 45,
											},
											width = "50",
											ZOrder = "1",
										},
										{
											controlID = "Label_name_Button_task_Panel_taskItem_Panel_prefab_Panel-summonContractMainView_Layer1_summon_Game",
											UUID = "227d4336_e3c7_4079_b35c_1cd0e49c2c4e",
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
											fontSize = "20",
											fontStroke = 
											{
												IsStroke = true,
												StrokeColor = "#FF515DA0",
												StrokeSize = 2,
											},
											height = "27",
											ignoreSize = "True",
											name = "Label_name",
											nTextAlign = "1",
											nTextHAlign = "1",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "770",
											text = "x454",
											touchAble = "False",
											touchScaleEnable = "False",
											UILayoutViewModel = 
											{
												PositionX = 45,
												PositionY = -19,
											},
											width = "47",
											ZOrder = "1",
										},
										{
											controlID = "spine_canGet_Button_task_Panel_taskItem_Panel_prefab_Panel-summonContractMainView_Layer1_summon_Game",
											UUID = "73abb9cd_fcd4_4b67_bf7e_9a09e24a7408",
											classname = "MESpine",
											dstBlendFunc = "771",
											name = "spine_canGet",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											spineModel = 
											{
												SpinePath = "effect/jinglingqy_lingqutishi/jinglingqy_lingqutishi",
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
												PositionX = 45,
											},
											ZOrder = "1",
										},
									},
								},
								{
									controlID = "panel_root_Panel_taskItem_Panel_prefab_Panel-summonContractMainView_Layer1_summon_Game",
									UUID = "56d176cf_2d4f_43b1_b503_4dcb214401b6",
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
									name = "panel_root",
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
									visible = "False",
									width = "400",
									ZOrder = "1",
									components = 
									{
										
										{
											controlID = "Image_geted_panel_root_Panel_taskItem_Panel_prefab_Panel-summonContractMainView_Layer1_summon_Game",
											UUID = "9756a497_503c_447c_be59_a2fa76b3f1b0",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											classname = "MEImage",
											dstBlendFunc = "771",
											height = "164",
											ignoreSize = "True",
											name = "Image_geted",
											opacity = "204",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											texturePath = "ui/summon/elf_contract/008.png",
											touchAble = "False",
											UILayoutViewModel = 
											{
												
											},
											width = "132",
											ZOrder = "1",
										},
										{
											controlID = "Image_gou_panel_root_Panel_taskItem_Panel_prefab_Panel-summonContractMainView_Layer1_summon_Game",
											UUID = "8ad20b1d_9a22_4606_987b_7b45b43b3103",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											classname = "MEImage",
											dstBlendFunc = "771",
											height = "80",
											ignoreSize = "True",
											name = "Image_gou",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											texturePath = "ui/summon/elf_contract/035.png",
											touchAble = "False",
											UILayoutViewModel = 
											{
												PositionY = 3,
											},
											width = "80",
											ZOrder = "1",
											components = 
											{
												
												{
													controlID = "Label_geted_Image_gou_panel_root_Panel_taskItem_Panel_prefab_Panel-summonContractMainView_Layer1_summon_Game",
													UUID = "7d9ae492_459c_45b6_8d0f_a955dc8ec590",
													anchorPoint = "False",
													anchorPointX = "0.5",
													anchorPointY = "0.5",
													classname = "MELabel",
													compPath = "luacomponents.common.MEIconLabel",
													dstBlendFunc = "771",
													FontColor = "#FFE1E1F7",
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
														StrokeColor = "#FF293B51",
														StrokeSize = 1,
													},
													height = "27",
													ignoreSize = "True",
													name = "Label_geted",
													nTextAlign = "1",
													nTextHAlign = "1",
													sizepercentx = "0",
													sizepercenty = "0",
													sizeType = "0",
													srcBlendFunc = "770",
													text = "Adquirido",
													touchAble = "False",
													touchScaleEnable = "False",
													UILayoutViewModel = 
													{
														PositionY = -39,
													},
													width = "106",
													ZOrder = "1",
												},
											},
										},
										{
											controlID = "Image_notGet_panel_root_Panel_taskItem_Panel_prefab_Panel-summonContractMainView_Layer1_summon_Game",
											UUID = "ae6bd534_1099_4c58_b722_e581df18d098",
											anchorPoint = "False",
											anchorPointX = "0.5",
											anchorPointY = "0.5",
											backGroundScale9Enable = "False",
											classname = "MEImage",
											dstBlendFunc = "771",
											height = "164",
											ignoreSize = "True",
											name = "Image_notGet",
											opacity = "108",
											sizepercentx = "0",
											sizepercenty = "0",
											sizeType = "0",
											srcBlendFunc = "1",
											texturePath = "ui/summon/elf_contract/008.png",
											touchAble = "False",
											UILayoutViewModel = 
											{
												
											},
											visible = "False",
											width = "132",
											ZOrder = "1",
										},
									},
								},
								{
									controlID = "spine_effect_Panel_taskItem_Panel_prefab_Panel-summonContractMainView_Layer1_summon_Game",
									UUID = "70fcc2a7_b36c_4e26_a9cf_dd365bb11076",
									classname = "MESpine",
									dstBlendFunc = "771",
									name = "spine_effect",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									spineModel = 
									{
										SpinePath = "effect/jinglingqiyue_all/jinglingqiyue_all",
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
										
									},
									visible = "False",
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
		particle_ani = 
		{
			name = "particle_ani",
			FPS = 40,
			duration = 0.62,
			looptimes = 1,
			autoplay = false,
			{
				id = "particle_effect_Panel_root_Panel-summonContractMainView_Layer1_summon_Game",
				name = "Panel.Panel_root.particle_effect",
				frames = 
				{
					
					{
						alpha = 255,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 1,
						frame = 0,
						particleData = 
						{
							texturePath = "particles/particle_fenhong.png",
							bIsPlaying = true,
							Duration = -1,
							Life = 0.39,
							LifeVar = 0.4,
							Angle = 154,
							AngleVar = 50,
							StartSize = 32,
							StartSizeVar = 10,
							EndSize = 42,
							EndSizeVar = 0,
							TotalParticles = 102,
							StartSpin = 354,
							StartSpinVar = 0,
							EndSpin = 0,
							EndSpinVar = 0,
							StartColor = 
							{
								a = 63,
								 r = 255,
								 g = 102,
								 b = 153
							},
							StartColorVar = 
							{
								a = 25,
								 r = 0,
								 g = 0,
								 b = 38
							},
							EndColor = 
							{
								a = 255,
								 r = 0,
								 g = 0,
								 b = 0
							},
							EndColorVar = 
							{
								a = 0,
								 r = 0,
								 g = 0,
								 b = 0
							},
							EmitterMode = 0,
							TangentialAccel = 0,
							TangentialAccelVar = 0,
							Speed = 64,
							SpeedVar = 5,
							Gravity = 
							{
								 x = -60,
								 y = 0
							},
							SourcePosition = 
							{
								 x = 0,
								 y = 0
							},
							PosVar = 
							{
								 x = 20,
								 y = 15
							},
							RadialAccel = 0,
							RadialAccelVar = 0,
							StartRadius = 0,
							StartRadiusVar = 0,
							EndRadius = 0,
							EndRadiusVar = 0,
							RotatePerSecond = 0,
							RotatePerSecondVar = 0,
						},
						percentenable = false,
						perposition = 
						{
							x=0,
							y=0,
						},
						position = 
						{
							x=0,
							y=0,
						},
						rotate = 0,
						scale = 
						{
							x=1,
							y=1,
						},
						srcBlendFunc = 770,
						tweenToNext = true,
						visible = true,
					},
					{
						alpha = 255,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 1,
						frame = 7,
						particleData = 
						{
							texturePath = "particles/particle_fenhong.png",
							bIsPlaying = true,
							Duration = -1,
							Life = 0.39,
							LifeVar = 0.4,
							Angle = 154,
							AngleVar = 50,
							StartSize = 32,
							StartSizeVar = 10,
							EndSize = 42,
							EndSizeVar = 0,
							TotalParticles = 102,
							StartSpin = 354,
							StartSpinVar = 0,
							EndSpin = 0,
							EndSpinVar = 0,
							StartColor = 
							{
								a = 63,
								 r = 255,
								 g = 102,
								 b = 153
							},
							StartColorVar = 
							{
								a = 25,
								 r = 0,
								 g = 0,
								 b = 38
							},
							EndColor = 
							{
								a = 255,
								 r = 0,
								 g = 0,
								 b = 0
							},
							EndColorVar = 
							{
								a = 1,
								 r = 0,
								 g = 0,
								 b = 0
							},
							EmitterMode = 0,
							TangentialAccel = 0,
							TangentialAccelVar = 0,
							Speed = 64,
							SpeedVar = 5,
							Gravity = 
							{
								 x = -60,
								 y = 0
							},
							SourcePosition = 
							{
								 x = 0,
								 y = 0
							},
							PosVar = 
							{
								 x = 20,
								 y = 15
							},
							RadialAccel = 0,
							RadialAccelVar = 0,
							StartRadius = 0,
							StartRadiusVar = 0,
							EndRadius = 0,
							EndRadiusVar = 0,
							RotatePerSecond = 0,
							RotatePerSecondVar = 0,
						},
						percentenable = false,
						perposition = 
						{
							x=13.29,
							y=-4.85,
						},
						position = 
						{
							x=151,
							y=-31,
						},
						rotate = 0,
						scale = 
						{
							x=1,
							y=1,
						},
						srcBlendFunc = 770,
						tweenToNext = true,
						visible = true,
					},
					{
						alpha = 255,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 1,
						frame = 16,
						particleData = 
						{
							texturePath = "particles/particle_fenhong.png",
							bIsPlaying = true,
							Duration = -1,
							Life = 0.39,
							LifeVar = 0.4,
							Angle = 154,
							AngleVar = 50,
							StartSize = 32,
							StartSizeVar = 10,
							EndSize = 42,
							EndSizeVar = 0,
							TotalParticles = 102,
							StartSpin = 354,
							StartSpinVar = 0,
							EndSpin = 0,
							EndSpinVar = 0,
							StartColor = 
							{
								a = 63,
								 r = 255,
								 g = 102,
								 b = 153
							},
							StartColorVar = 
							{
								a = 25,
								 r = 0,
								 g = 0,
								 b = 38
							},
							EndColor = 
							{
								a = 255,
								 r = 0,
								 g = 0,
								 b = 0
							},
							EndColorVar = 
							{
								a = 1,
								 r = 0,
								 g = 0,
								 b = 0
							},
							EmitterMode = 0,
							TangentialAccel = 0,
							TangentialAccelVar = 0,
							Speed = 64,
							SpeedVar = 5,
							Gravity = 
							{
								 x = -60,
								 y = 0
							},
							SourcePosition = 
							{
								 x = 0,
								 y = 0
							},
							PosVar = 
							{
								 x = 20,
								 y = 15
							},
							RadialAccel = 0,
							RadialAccelVar = 0,
							StartRadius = 0,
							StartRadiusVar = 0,
							EndRadius = 0,
							EndRadiusVar = 0,
							RotatePerSecond = 0,
							RotatePerSecondVar = 0,
						},
						percentenable = false,
						perposition = 
						{
							x=28.87,
							y=-16.88,
						},
						position = 
						{
							x=327,
							y=-108,
						},
						rotate = 0,
						scale = 
						{
							x=1,
							y=1,
						},
						srcBlendFunc = 770,
						tweenToNext = true,
						visible = true,
					},
					{
						alpha = 255,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 1,
						frame = 25,
						particleData = 
						{
							texturePath = "particles/particle_fenhong.png",
							bIsPlaying = true,
							Duration = -1,
							Life = 0.39,
							LifeVar = 0.4,
							Angle = 154,
							AngleVar = 50,
							StartSize = 32,
							StartSizeVar = 10,
							EndSize = 42,
							EndSizeVar = 0,
							TotalParticles = 102,
							StartSpin = 354,
							StartSpinVar = 0,
							EndSpin = 0,
							EndSpinVar = 0,
							StartColor = 
							{
								a = 63,
								 r = 255,
								 g = 102,
								 b = 153
							},
							StartColorVar = 
							{
								a = 25,
								 r = 0,
								 g = 0,
								 b = 38
							},
							EndColor = 
							{
								a = 255,
								 r = 0,
								 g = 0,
								 b = 0
							},
							EndColorVar = 
							{
								a = 0,
								 r = 0,
								 g = 0,
								 b = 0
							},
							EmitterMode = 0,
							TangentialAccel = 0,
							TangentialAccelVar = 0,
							Speed = 64,
							SpeedVar = 5,
							Gravity = 
							{
								 x = -60,
								 y = 0
							},
							SourcePosition = 
							{
								 x = 0,
								 y = 0
							},
							PosVar = 
							{
								 x = 20,
								 y = 15
							},
							RadialAccel = 0,
							RadialAccelVar = 0,
							StartRadius = 0,
							StartRadiusVar = 0,
							EndRadius = 0,
							EndRadiusVar = 0,
							RotatePerSecond = 0,
							RotatePerSecondVar = 0,
						},
						percentenable = false,
						perposition = 
						{
							x=41.56,
							y=-43.13,
						},
						position = 
						{
							x=472,
							y=-276,
						},
						rotate = 0,
						scale = 
						{
							x=1,
							y=1,
						},
						srcBlendFunc = 770,
						tweenToNext = true,
						visible = true,
					},
				},
			},
		},
	},
	respaths = 
	{
		textures = 
		{
			"ui/summon/elf_contract/new_1/bg.png",
			"ui/summon/elf_contract/title_tip.png",
			"ui/summon/elf_contract/new_1/004.png",
			"ui/summon/elf_contract/new_1/bg2_1.png",
			"ui/common/scroll_bar_01.png",
			"ui/common/scroll_bar_02.png",
			"ui/summon/elf_contract/new_1/006.png",
			"ui/summon/elf_contract/new_1/005.png",
			"ui/summon/elf_contract/003.png",
			"icon/system/005.png",
			"ui/summon/elf_contract/004.png",
			"ui/summon/elf_contract/new_1/003.png",
			"ui/summon/elf_contract/new_1/002.png",
			"ui/summon/elf_contract/036.png",
			"ui/summon/elf_contract/new_1/007.png",
			"ui/role/newRoleShow/c5.png",
			"ui/summon/elf_contract/008.png",
			"ui/summon/elf_contract/035.png",
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

