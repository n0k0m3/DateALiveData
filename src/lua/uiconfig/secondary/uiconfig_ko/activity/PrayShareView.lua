local t = 
{
	version = 1,
	components = 
	{
		
		{
			controlID = "Panel-PrayShareView_pray_activity_Game",
			UUID = "3186fd26_ff3d_432d_a01b_eb3d9eaf2b1a",
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
					controlID = "panel_root_Panel-PrayShareView_pray_activity_Game",
					UUID = "a943f03a_8128_4e2b_904e_9fe1b218dd5b",
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
						Layout="Relative",
						nType = "3"
					},
					width = "1136",
					ZOrder = "1",
					components = 
					{
						
						{
							controlID = "img_bg_panel_root_Panel-PrayShareView_pray_activity_Game",
							UUID = "351766d6_0d28_4b37_b4a7_a8e35331cf69",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							backGroundScale9Enable = "False",
							classname = "MEImage",
							dstBlendFunc = "771",
							height = "625",
							ignoreSize = "True",
							name = "img_bg",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							texturePath = "ui/activity/pray/img_share.png",
							touchAble = "False",
							UILayoutViewModel = 
							{
								relativeToName = "panel_root",
								nType = 3,
								nGravity = 6,
								nAlign = 5
							},
							width = "1055",
							ZOrder = "1",
						},
						{
							controlID = "btn_close_panel_root_Panel-PrayShareView_pray_activity_Game",
							UUID = "f10d0804_8d40_40c4_b37f_da6a7ec33369",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							backGroundScale9Enable = "False",
							classname = "MEButton",
							ClickHighLightEnabled = "True",
							dstBlendFunc = "771",
							flipX = "False",
							flipY = "False",
							height = "52",
							ignoreSize = "True",
							name = "btn_close",
							normal = "ui/common/btn_back.png",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							touchAble = "True",
							UILayoutViewModel = 
							{
								PositionX = -517,
								PositionY = 274,
								LeftPositon = 20,
								TopPosition = 20,
								relativeToName = "panel_root",
								nType = 3,
							},
							UItype = "Button",
							width = "62",
							ZOrder = "10",
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
			"ui/activity/pray/img_share.png",
			"ui/common/btn_back.png",
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

