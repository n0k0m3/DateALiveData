local t = 
{
	version = 1,
	components = 
	{
		
		{
			controlID = "Panel-bingoResultView_Layer1_bingo_Game",
			UUID = "0a6ba755_a1b7_44e1_be92_2a733916f8c3",
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
					controlID = "Panel_root_Panel-bingoResultView_Layer1_bingo_Game",
					UUID = "aa76e348_bd60_458b_8712_06bf22e32330",
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
							controlID = "Panel_touch_Panel_root_Panel-bingoResultView_Layer1_bingo_Game",
							UUID = "fd016fb5_e928_46e7_9a90_c38ea67c4287",
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
							height = "400",
							ignoreSize = "False",
							name = "Panel_touch",
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
							width = "400",
							ZOrder = "1",
						},
						{
							controlID = "Panel_player_mask_Panel_root_Panel-bingoResultView_Layer1_bingo_Game",
							UUID = "b12b5262_d001_4d65_ae6f_e65778186347",
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
							height = "400",
							ignoreSize = "False",
							name = "Panel_player_mask",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							touchAble = "False",
							UILayoutViewModel = 
							{
								PositionY = 63,
							},
							uipanelviewmodel = 
							{
								Layout="Absolute",
								nType = "0"
							},
							width = "400",
							ZOrder = "1",
						},
						{
							controlID = "Spine_down_Panel_root_Panel-bingoResultView_Layer1_bingo_Game",
							UUID = "265c53a6_450c_46f9_9855_6db52609cc7e",
							classname = "MESpine",
							dstBlendFunc = "771",
							name = "Spine_down",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							spineModel = 
							{
								SpinePath = "effect/evt_effect_victory/evt_effect_victory",
								animationName = "evt_effect_victory_down",
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
								PositionY = 54,
								LeftPositon = 850,
								TopPosition = 379,
								relativeToName = "Panel",
							},
							ZOrder = "1",
						},
						{
							controlID = "Spine_up_Panel_root_Panel-bingoResultView_Layer1_bingo_Game",
							UUID = "f8ceeba4_e590_4fb5_901c_687019feff10",
							classname = "MESpine",
							dstBlendFunc = "771",
							name = "Spine_up",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							spineModel = 
							{
								SpinePath = "effect/evt_effect_victory/evt_effect_victory",
								animationName = "evt_effect_victory_up",
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
								PositionY = 54,
								LeftPositon = 850,
								TopPosition = 379,
								relativeToName = "Panel",
							},
							ZOrder = "1",
						},
						{
							controlID = "Image_bingoResultView_1_Panel_root_Panel-bingoResultView_Layer1_bingo_Game",
							UUID = "368bfeb2_dfa5_4e49_8778_a1f13aac6629",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							backGroundScale9Enable = "False",
							classname = "MEImage",
							dstBlendFunc = "771",
							height = "444",
							ignoreSize = "True",
							name = "Image_bingoResultView_1",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							texturePath = "ui/activity/bingoGame/result/001.png",
							touchAble = "False",
							UILayoutViewModel = 
							{
								PositionX = -59,
								PositionY = -559,
							},
							width = "984",
							ZOrder = "1",
						},
						{
							controlID = "ClippingNode_Panel_root_Panel-bingoResultView_Layer1_bingo_Game",
							UUID = "64e325f6_cd5f_4bac_92da_e9e4770c334f",
							alphaThreshold = "0.5",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							classname = "MEClippingNode",
							clipNodeX = "0",
							clipNodeY = "0",
							dstBlendFunc = "771",
							height = "100",
							ignoreSize = "True",
							name = "ClippingNode",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							stencilPath = "ui/activity/bingoGame/result/001.png",
							touchAble = "False",
							UILayoutViewModel = 
							{
								PositionX = -136,
								PositionY = 180,
							},
							width = "100",
							ZOrder = "1",
							components = 
							{
								
								{
									controlID = "Image_head_ClippingNode_Panel_root_Panel-bingoResultView_Layer1_bingo_Game",
									UUID = "0068f004_81b9_417f_a78d_058e2ec23830",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "92",
									ignoreSize = "True",
									name = "Image_head",
									scaleX = "0.93",
									scaleY = "0.93",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									texturePath = "icon/hero/face/1101011.png",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = 385,
										PositionY = 147,
									},
									width = "156",
									ZOrder = "1",
								},
								{
									controlID = "Image_player_ClippingNode_Panel_root_Panel-bingoResultView_Layer1_bingo_Game",
									UUID = "63a02476_01ce_4bb9_9df0_792610e5c45e",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEImage",
									dstBlendFunc = "771",
									height = "64",
									ignoreSize = "True",
									name = "Image_player",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "False",
									UILayoutViewModel = 
									{
										PositionX = -189,
										PositionY = -441,
									},
									width = "64",
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
			"ui/activity/bingoGame/result/001.png",
			"icon/hero/face/1101011.png",
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

