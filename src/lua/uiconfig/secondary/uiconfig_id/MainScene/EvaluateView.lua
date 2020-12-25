local t = 
{
	version = 1,
	components = 
	{
		
		{
			controlID = "Panel-EvaluateView_Layer1_MainScene_Game",
			UUID = "cc417e62_6ab2_4be1_b666_282d930ce17f",
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
					controlID = "Panel_base_Panel-EvaluateView_Layer1_MainScene_Game",
					UUID = "98a68f12_690c_4dd5_987b_96a3a715cd57",
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
							controlID = "Image_text_Panel_base_Panel-EvaluateView_Layer1_MainScene_Game",
							UUID = "298f434e_f04e_48f9_a271_8f127067b70e",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							backGroundScale9Enable = "False",
							classname = "MEImage",
							dstBlendFunc = "771",
							height = "269",
							ignoreSize = "True",
							name = "Image_text",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							texturePath = "ui/Evaluate/text_pl.png",
							touchAble = "False",
							UILayoutViewModel = 
							{
								PositionX = 804,
								PositionY = 340,
							},
							width = "388",
							ZOrder = "1",
							components = 
							{
								
								{
									controlID = "Button_ok_Image_text_Panel_base_Panel-EvaluateView_Layer1_MainScene_Game",
									UUID = "d314d3a9_d3be_415b_8d67_8720da970c7c",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEButton",
									ClickHighLightEnabled = "True",
									dstBlendFunc = "771",
									flipX = "False",
									flipY = "False",
									height = "72",
									ignoreSize = "True",
									name = "Button_ok",
									normal = "ui/Evaluate/btn_ok1.png",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "True",
									UILayoutViewModel = 
									{
										PositionX = 90,
										PositionY = -68,
									},
									UItype = "Button",
									width = "151",
									ZOrder = "1",
								},
								{
									controlID = "Button_cancle_Image_text_Panel_base_Panel-EvaluateView_Layer1_MainScene_Game",
									UUID = "06f67ff9_ca07_4f54_9f13_c46ba6363f85",
									anchorPoint = "False",
									anchorPointX = "0.5",
									anchorPointY = "0.5",
									backGroundScale9Enable = "False",
									classname = "MEButton",
									ClickHighLightEnabled = "True",
									dstBlendFunc = "771",
									flipX = "False",
									flipY = "False",
									height = "45",
									ignoreSize = "True",
									name = "Button_cancle",
									normal = "ui/Evaluate/btn_cancle.png",
									pressed = "ui/Evaluate/btn_cancle.png",
									sizepercentx = "0",
									sizepercenty = "0",
									sizeType = "0",
									srcBlendFunc = "1",
									touchAble = "True",
									UILayoutViewModel = 
									{
										PositionX = -71,
										PositionY = -82,
									},
									UItype = "Button",
									width = "98",
									ZOrder = "1",
								},
							},
						},
						{
							controlID = "Spine_happy_Panel_base_Panel-EvaluateView_Layer1_MainScene_Game",
							UUID = "bf9c2bd7_d470_457e_91d7_aa70e088d7d6",
							classname = "MESpine",
							dstBlendFunc = "771",
							name = "Spine_happy",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							spineModel = 
							{
								SpinePath = "effect/effects_evaluate/city_10104x",
								animationName = "happy2",
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
								PositionX = 425,
								PositionY = 90,
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
			"ui/Evaluate/text_pl.png",
			"ui/Evaluate/btn_ok1.png",
			"ui/Evaluate/btn_cancle.png",
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

