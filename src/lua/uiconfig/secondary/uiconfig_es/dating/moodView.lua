local t = 
{
	version = 1,
	components = 
	{
		
		{
			controlID = "Panel-moodView_Layer1_dating_Game",
			UUID = "92b114ee_e3f4_474c_815c_1c792915254d",
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
			width = "1386",
			ZOrder = "1",
			components = 
			{
				
				{
					controlID = "Image_mood_Panel-moodView_Layer1_dating_Game",
					UUID = "1a13ede8_6cba_4696_8c7d_8e1c928d4bb4",
					anchorPoint = "False",
					anchorPointX = "0.5",
					anchorPointY = "0.5",
					backGroundScale9Enable = "False",
					classname = "MEImage",
					dstBlendFunc = "771",
					height = "148",
					ignoreSize = "True",
					name = "Image_mood",
					sizepercentx = "0",
					sizepercenty = "0",
					sizeType = "0",
					srcBlendFunc = "1",
					texturePath = "ui/dating/elvesInformation/mood/1.png",
					touchAble = "False",
					UILayoutViewModel = 
					{
						LeftPositon = 456,
						TopPosition = 1,
						relativeToName = "Panel",
					},
					width = "148",
					ZOrder = "1",
					components = 
					{
						
						{
							controlID = "Image_moodLast_Image_mood_Panel-moodView_Layer1_dating_Game",
							UUID = "f8298b75_60cf_4a01_89f5_a05b9af11782",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							backGroundScale9Enable = "False",
							classname = "MEImage",
							dstBlendFunc = "771",
							height = "148",
							ignoreSize = "True",
							name = "Image_moodLast",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							texturePath = "ui/dating/elvesInformation/mood/1.png",
							touchAble = "False",
							UILayoutViewModel = 
							{
								LeftPositon = 456,
								TopPosition = 1,
								relativeToName = "Panel",
							},
							width = "148",
							ZOrder = "1",
						},
						{
							controlID = "Image_moodUp_Image_mood_Panel-moodView_Layer1_dating_Game",
							UUID = "136a8fd4_59a0_4908_abee_a5de9c39437d",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							backGroundScale9Enable = "False",
							classname = "MEImage",
							dstBlendFunc = "771",
							height = "56",
							ignoreSize = "True",
							name = "Image_moodUp",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							texturePath = "ui/226.png",
							touchAble = "False",
							UILayoutViewModel = 
							{
								PositionX = 68,
								PositionY = 14,
							},
							width = "42",
							ZOrder = "1",
						},
						{
							controlID = "Label_addMoodValues_Image_mood_Panel-moodView_Layer1_dating_Game",
							UUID = "38381c16_e45d_4955_9a41_2f701c4f5b37",
							anchorPoint = "False",
							anchorPointX = "0.5",
							anchorPointY = "0.5",
							classname = "MELabelBMFont",
							dstBlendFunc = "771",
							fileNameData = "font/tisheng.fnt",
							height = "37",
							ignoreSize = "True",
							name = "Label_addMoodValues",
							sizepercentx = "0",
							sizepercenty = "0",
							sizeType = "0",
							srcBlendFunc = "1",
							text = "+10",
							touchAble = "False",
							UILayoutViewModel = 
							{
								PositionX = 64,
								PositionY = -25,
							},
							width = "81",
							ZOrder = "1",
						},
					},
				},
			},
		},
	},
	actions = 
	{
		Action0 = 
		{
			name = "Action0",
			FPS = 60,
			duration = 0.5,
			looptimes = 1,
			autoplay = false,
			{
				id = "Image_moodUp_Image_mood_Panel-moodView_Layer1_dating_Game",
				name = "Panel.Image_mood.Image_moodUp",
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
						dstBlendFunc = 771,
						frame = 0,
						percentenable = false,
						perposition = 
						{
							x=0,
							y=0,
						},
						position = 
						{
							x=68,
							y=14,
						},
						rotate = 0,
						scale = 
						{
							x=1,
							y=1,
						},
						srcBlendFunc = 1,
						tweenToNext = true,
						visible = true,
					},
					{
						alpha = 0,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 30,
						percentenable = false,
						perposition = 
						{
							x=0,
							y=0,
						},
						position = 
						{
							x=68,
							y=64,
						},
						rotate = 0,
						scale = 
						{
							x=1,
							y=1,
						},
						srcBlendFunc = 1,
						tweenToNext = true,
						visible = true,
					},
				},
			},
			{
				id = "Label_addMoodValues_Image_mood_Panel-moodView_Layer1_dating_Game",
				name = "Panel.Image_mood.Label_addMoodValues",
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
						dstBlendFunc = 771,
						frame = 0,
						percentenable = false,
						perposition = 
						{
							x=43.24,
							y=-16.89,
						},
						position = 
						{
							x=64,
							y=-25,
						},
						rotate = 0,
						scale = 
						{
							x=1,
							y=1,
						},
						srcBlendFunc = 1,
						tweenToNext = true,
						visible = true,
					},
					{
						alpha = 0,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 30,
						percentenable = false,
						perposition = 
						{
							x=43.24,
							y=-16.89,
						},
						position = 
						{
							x=64,
							y=25,
						},
						rotate = 0,
						scale = 
						{
							x=1,
							y=1,
						},
						srcBlendFunc = 1,
						tweenToNext = true,
						visible = true,
					},
				},
			},
		},
		Action1 = 
		{
			name = "Action1",
			FPS = 60,
			duration = 0.5,
			looptimes = 1,
			autoplay = false,
			{
				id = "Image_moodLast_Image_mood_Panel-moodView_Layer1_dating_Game",
				name = "Panel.Image_mood.Image_moodLast",
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
						dstBlendFunc = 771,
						frame = 0,
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
						srcBlendFunc = 1,
						tweenToNext = true,
						visible = true,
					},
					{
						alpha = 0,
						color = 
						{
							r=255,
							g=255,
							b=255,
							 a=255,
						},
						dstBlendFunc = 771,
						frame = 30,
						percentenable = false,
						perposition = 
						{
							x=0,
							y=0,
						},
						position = 
						{
							x=0,
							y=50,
						},
						rotate = 0,
						scale = 
						{
							x=1,
							y=1,
						},
						srcBlendFunc = 1,
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
			"ui/dating/elvesInformation/mood/1.png",
			"ui/226.png",
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

