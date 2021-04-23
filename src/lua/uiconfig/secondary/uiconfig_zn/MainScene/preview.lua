local t = 
{
	version = 1,
	components = 
	{
		
		{
			controlID = "Panel-preview_Layer1_MainScene_Game",
			UUID = "ccb9d455_c070_414a_9d8b_b0fe63af35d9",
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
			width = "1386",
			ZOrder = "1",
			components = 
			{
				
				{
					controlID = "Panel_base_Panel-preview_Layer1_MainScene_Game",
					UUID = "d082f0e9_faaf_430e_904c_91e6138e0c20",
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
							controlID = "Image_WxChatView_1_Panel_base_Panel-preview_Layer1_MainScene_Game",
							UUID = "c89e59df_54db_4991_98b5_104f909580e4",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							backGroundScale9Enable = "False",
							classname = "MEImage",
							dstBlendFunc = "771",
							height = "623",
							ignoreSize = "True",
							name = "Image_WxChatView_1",
							scaleX = "0.85",
							scaleY = "0.85",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							texturePath = "ui/preview/bg.png",
							touchAble = "False",
							UILayoutViewModel = 
							{
								PositionX = 568,
								PositionY = 327,
							},
							width = "1000",
							ZOrder = "1",
						},
						{
							controlID = "Button_close_Panel_base_Panel-preview_Layer1_MainScene_Game",
							UUID = "103b7ad5_a879_4945_bb6a_042356577df9",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							backGroundScale9Enable = "False",
							classname = "MEButton",
							ClickHighLightEnabled = "True",
							dstBlendFunc = "771",
							flipX = "False",
							flipY = "False",
							height = "30",
							ignoreSize = "True",
							name = "Button_close",
							normal = "ui/preview/close.png",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							touchAble = "True",
							UILayoutViewModel = 
							{
								PositionX = 1011,
								PositionY = 571,
							},
							UItype = "Button",
							width = "31",
							ZOrder = "1",
						},
						{
							controlID = "Spine_preview_1_Panel_base_Panel-preview_Layer1_MainScene_Game",
							UUID = "58ddeadd_1a24_4c85_9832_90b523473b96",
							classname = "MESpine",
							dstBlendFunc = "771",
							name = "Spine_preview_1",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							spineModel = 
							{
								SpinePath = "effect/effect_fanzhuanzhezi/effect_fanzhuanzhezi",
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
								PositionX = 583,
								PositionY = 303,
								relativeToName = "Panel",
							},
							visible = "False",
							ZOrder = "1",
						},
						{
							controlID = "Button_preview_Panel_base_Panel-preview_Layer1_MainScene_Game",
							UUID = "1cb7479c_bd0f_4bdb_940e_c21ae5904937",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							backGroundScale9Enable = "False",
							classname = "MEButton",
							ClickHighLightEnabled = "True",
							dstBlendFunc = "771",
							flipX = "False",
							flipY = "False",
							height = "136",
							ignoreSize = "True",
							name = "Button_preview",
							normal = "ui/preview/btn.png",
							scaleX = "0.8",
							scaleY = "0.8",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							touchAble = "True",
							UILayoutViewModel = 
							{
								PositionX = 575,
								PositionY = 159,
							},
							UItype = "Button",
							width = "282",
							ZOrder = "2",
						},
						{
							controlID = "Biaoti_Panel_base_Panel-preview_Layer1_MainScene_Game",
							UUID = "3a80fa34_183f_483f_839b_7ff74f54d737",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							backGroundScale9Enable = "False",
							classname = "MEButton",
							ClickHighLightEnabled = "True",
							dstBlendFunc = "771",
							flipX = "False",
							flipY = "False",
							height = "25",
							ignoreSize = "True",
							name = "Biaoti",
							normal = "ui/preview/biaoti.png",
							scaleX = "0.7",
							scaleY = "0.7",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							touchAble = "True",
							UILayoutViewModel = 
							{
								PositionX = 510,
								PositionY = 361,
							},
							UItype = "Button",
							visible = "False",
							width = "60",
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
			"ui/preview/bg.png",
			"ui/preview/close.png",
			"ui/preview/btn.png",
			"ui/preview/biaoti.png",
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

