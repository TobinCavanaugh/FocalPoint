//{"Values":["0","PPU/Splatter","_MainTex","0",""]}|{"position":{"serializedVersion":"2","x":0.0,"y":0.0,"width":212.0,"height":109.0},"name":"FloatSlider","selected":false,"Values":["Intensity","Effect intensity","0","0","1"],"unique":2082}|{"position":{"serializedVersion":"2","x":0.0,"y":0.0,"width":212.0,"height":69.0},"name":"Texture2D","selected":false,"Values":["Image","Situation texture"],"unique":-1}|{"tempTextures":0,"passes":[{"position":{"serializedVersion":"2","x":0.0,"y":36.0,"width":212.0,"height":16.0},"Input":0,"Output":0,"Pass":0,"Iterations":1,"Variable":0}],"passOptions":["0"],"inputOptions":["Game"],"outputOptions":["Screen"],"variableOptions":["None"]}
//\	CameraOutput\	1139.005\	14.02718\	96\	110\		False\			null\			null\		False\			null\			null\		False\			null\			null\		True\			4\			0\	CameraInput\	750.0056\	23.02711\	96\	170\		False\			null\			null\		False\			null\			null\		False\			null\			null\		False\			null\			null\		False\			null\			null\		False\			null\			null\		True\			2\			2\	StereoUV\	538.0056\	87.02721\	96\	90\		False\			null\			null\		False\			null\			null\		False\			null\			null\	_Texture2D\	716.0057\	230.0272\	96\	190\		/Image\		/1\		/-1\		False\			null\			null\		False\			null\			null\		False\			null\			null\		False\			null\			null\		False\			null\			null\		False\			null\			null\		False\			null\			null\		True\			2\			2\	Lerp\	1061.756\	172.0272\	96\	110\		False\			null\			null\		True\			1\			3\		True\			3\			0\		True\			12\			0\	Mul\	1043.951\	316.8604\	96\	110\		/4\		False\			null\			null\		True\			3\			4\		True\			10\			0\		False\			null\			null\	_FloatSlider\	332.7\	379.3604\	96\	50\		/Intensity\		/1\		/2082\		False\			null\			null\	Value2\	254.7555\	681.8594\	96\	90\		/0.5\		/0.5\		False\			null\			null\		False\			null\			null\		False\			null\			null\	Sub\	482.2556\	740.3319\	96\	110\		/4\		False\			null\			null\		True\			2\			2\		True\			7\			2\		False\			null\			null\	Abs\	634.8946\	828.9424\	96\	70\		False\			null\			null\		True\			8\			0\	Add\	1611.321\	398.5864\	96\	110\		/4\		False\			null\			null\		True\			11\			0\		True\			19\			0\		False\			null\			null\	Custom\	789.0616\	442.2766\	96\	270\		/Assets/Post Processing Ultimate/Functions/Invert.hlsl\		/Invert\		/3\		/4\		/Value\		False\			null\			null\		False\			null\			null\		False\			null\			null\		False\			null\			null\		False\			null\			null\		True\			18\			0\		False\			null\			null\		False\			null\			null\		False\			null\			null\		False\			null\			null\	Saturate\	1313.644\	337.694\	96\	70\		False\			null\			null\		True\			5\			0\	Add\	1377.126\	730.4989\	96\	110\		/4\		False\			null\			null\		True\			14\			0\		True\			15\			0\		False\			null\			null\	Pow\	1215.991\	625.5143\	96\	90\		False\			null\			null\		True\			20\			0\		True\			16\			0\	Pow\	1182.241\	818.0143\	96\	90\		False\			null\			null\		True\			20\			1\		True\			16\			0\	Value2\	1003.491\	910.5145\	96\	90\		/2.0\		/1.0\		False\			null\			null\		False\			null\			null\		False\			null\			null\	Pow\	1556.686\	630.6533\	96\	90\		False\			null\			null\		True\			13\			0\		True\			16\			1\	Mul\	577.4474\	533.1772\	96\	110\		/4\		False\			null\			null\		True\			6\			0\		True\			16\			0\		False\			null\			null\	Mul\	1416.186\	498.0355\	96\	110\		/4\		False\			null\			null\		True\			17\			0\		True\			16\			0\		False\			null\			null\	Detach2\	823.7776\	831.7777\	96\	90\		False\			null\			null\		False\			null\			null\		True\			9\			0

Shader "PPU/Splatter" {

	HLSLINCLUDE

			#include "Packages/com.unity.postprocessing/PostProcessing/Shaders/StdLib.hlsl"
			#include "../../Post Processing Ultimate/Functions/Invert.hlsl"

			TEXTURE2D_SAMPLER2D(_MainTex, sampler_MainTex);
			uniform half _Intensity;
			TEXTURE2D_SAMPLER2D(_Image, sampler_Image);

			half3 Frag0 (VaryingsDefault i) : SV_Target {
				half3 CameraOutput = 0.0;
				CameraOutput = lerp(SAMPLE_TEXTURE2D(_MainTex, sampler_MainTex, i.texcoordStereo).xyz, SAMPLE_TEXTURE2D(_Image, sampler_Image, i.texcoordStereo).xyz, saturate((SAMPLE_TEXTURE2D(_Image, sampler_Image, i.texcoordStereo).w * (Invert(half4((_Intensity * 2.0), 0.0, 0.0, 0.0)).x + (pow((pow(abs((i.texcoordStereo - half2(0.5, 0.5))).x, 2.0) + pow(abs((i.texcoordStereo - half2(0.5, 0.5))).y, 2.0)), 1.0) * 2.0)))));
				return CameraOutput;
			}

	ENDHLSL

	SubShader {

		Cull Off ZWrite Off ZTest Always

		Pass {

			HLSLPROGRAM

				#pragma vertex VertDefault
				#pragma fragment Frag0

			ENDHLSL
		}
	}
}