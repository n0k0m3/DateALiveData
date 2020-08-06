local t = 
{
	version = 1,
	components = 
	{
		
		{
			controlID = "Panel-summonGetEquipmentView_Layer1_summon_Game",
			UUID = "161b0758_2c23_4397_854f_b94af3320169",
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
					controlID = "Panel_root_Panel-summonGetEquipmentView_Layer1_summon_Game",
					UUID = "bc604bbf_265f_4b29_ae11_1a567174d9df",
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
							controlID = "Spine_down_Panel_root_Panel-summonGetEquipmentView_Layer1_summon_Game",
							UUID = "53e8cfa7_bb4e_4876_8694_6bc1271e7594",
							classname = "MESpine",
							dstBlendFunc = "771",
							name = "Spine_down",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							spineModel = 
							{
								SpinePath = "effect/zhidian/zhidian_h",
								animationName = "xunhuan",
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
								PositionX = 568,
								PositionY = 320,
								relativeToName = "Panel",
							},
							ZOrder = "1",
						},
						{
							controlID = "Image_equipmentModel_shadow_Panel_root_Panel-summonGetEquipmentView_Layer1_summon_Game",
							UUID = "f36d1935_eb0c_43d6_8e9d_c15829ab0b7a",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							backGroundScale9Enable = "False",
							classname = "MEImage",
							dstBlendFunc = "771",
							height = "1366",
							ignoreSize = "True",
							name = "Image_equipmentModel_shadow",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							texturePath = "icon/equipment/paint/paint_wangguan_2.png",
							touchAble = "False",
							UILayoutViewModel = 
							{
								PositionX = 220,
								PositionY = 255,
							},
							width = "1362",
							ZOrder = "1",
						},
						{
							controlID = "Image_equipmentModel_Panel_root_Panel-summonGetEquipmentView_Layer1_summon_Game",
							UUID = "39d9d38c_c04f_4e4f_9655_43dc3bc84d0e",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							backGroundScale9Enable = "False",
							classname = "MEImage",
							dstBlendFunc = "771",
							height = "1366",
							ignoreSize = "True",
							name = "Image_equipmentModel",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							texturePath = "icon/equipment/paint/paint_wangguan_2.png",
							touchAble = "False",
							UILayoutViewModel = 
							{
								PositionX = 220,
								PositionY = 255,
							},
							width = "1362",
							ZOrder = "1",
						},
						{
							controlID = "Spine_up_Panel_root_Panel-summonGetEquipmentView_Layer1_summon_Game",
							UUID = "1d03d5e6_c820_45a6_9b73_53e4c7583bf3",
							classname = "MESpine",
							dstBlendFunc = "771",
							name = "Spine_up",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							spineModel = 
							{
								SpinePath = "effect/zhidian/zhidian_q",
								animationName = "xunhuan",
								IsLoop = false,
								IsPlay = false,
								IsUseQueue = false,
								AnimationQueue = 
								{
									
								},
							},
							srcBlendFunc = "1",
							touchAble = "False",
							UILayoutViewModel = 
							{
								PositionX = 568,
								PositionY = 320,
								relativeToName = "Panel",
							},
							ZOrder = "1",
						},
						{
							controlID = "Image_name_Panel_root_Panel-summonGetEquipmentView_Layer1_summon_Game",
							UUID = "6baed2f2_e051_45e4_987d_1e923603f874",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							backGroundScale9Enable = "False",
							classname = "MEImage",
							dstBlendFunc = "771",
							height = "293",
							ignoreSize = "True",
							name = "Image_name",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							texturePath = "icon/equipment/name/Christina.png",
							touchAble = "False",
							UILayoutViewModel = 
							{
								PositionX = 829,
								PositionY = 180,
							},
							width = "372",
							ZOrder = "1",
						},
						{
							controlID = "Spine_ziti_Panel_root_Panel-summonGetEquipmentView_Layer1_summon_Game",
							UUID = "28a9b85f_bb70_4d46_b2ba_24baa77b0d49",
							classname = "MESpine",
							dstBlendFunc = "771",
							name = "Spine_ziti",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							spineModel = 
							{
								SpinePath = "effect/zhidian/zhidian_h",
								animationName = "ziti",
								IsLoop = false,
								IsPlay = false,
								IsUseQueue = false,
								AnimationQueue = 
								{
									
								},
							},
							srcBlendFunc = "1",
							touchAble = "False",
							UILayoutViewModel = 
							{
								PositionX = 568,
								PositionY = 320,
								relativeToName = "Panel",
							},
							ZOrder = "1",
						},
					},
				},
				{
					controlID = "Panel_touch_Panel-summonGetEquipmentView_Layer1_summon_Game",
					UUID = "74c1c161_3748_41c1_8042_fc021e96237f",
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
					name = "Panel_touch",
					sizepercentx = "100",
					sizepercenty = "100",
					sizeType = "1",
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
				},
				{
					controlID = "Panel_prefab_Panel-summonGetEquipmentView_Layer1_summon_Game",
					UUID = "0e133101_6d7a_47df_9503_8cea66641bf3",
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
						PositionX = 99,
						PositionY = -951,
						LeftPositon = 99,
						TopPosition = 951,
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
			"icon/equipment/paint/paint_wangguan_2.png",
			"icon/equipment/name/Christina.png",
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

