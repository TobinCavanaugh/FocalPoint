//{"Values":["0","PPU/IndustrialCamera","_MainTex","0",""]}|{"position":{"serializedVersion":"2","x":0.0,"y":0.0,"width":212.0,"height":109.0},"name":"FloatSlider","selected":false,"Values":["Intensity","Effect intensity","0.5","0","1"],"unique":3352}|{"position":{"serializedVersion":"2","x":0.0,"y":0.0,"width":212.0,"height":109.0},"name":"FloatSlider","selected":false,"Values":["Lines","Lines visibility","0.5","0","1"],"unique":-1}|{"tempTextures":1,"passes":[{"position":{"serializedVersion":"2","x":0.0,"y":36.0,"width":212.0,"height":16.0},"Input":0,"Output":0,"Pass":0,"Iterations":1,"Variable":0}],"passOptions":["0"],"inputOptions":["Game","tempRT0"],"outputOptions":["Screen","tempRT0"],"variableOptions":["None"]}
//\	CameraOutput\	2140.675\	-12.75711\	96\	110\		False\			null\			null\		False\			null\			null\		False\			null\			null\		True\			20\			0\	CameraInput\	861.2943\	61.6001\	96\	170\		False\			null\			null\		False\			null\			null\		False\			null\			null\		False\			null\			null\		False\			null\			null\		False\			null\			null\		True\			2\			2\	StereoUV\	441.7695\	72.6713\	96\	90\		False\			null\			null\		False\			null\			null\		False\			null\			null\	Add\	1251.455\	59.6937\	96\	130\		/5\		False\			null\			null\		True\			22\			0\		True\			22\			1\		True\			22\			2\		False\			null\			null\	Div\	1403.678\	130.8049\	96\	110\		/4\		False\			null\			null\		True\			3\			0\		True\			5\			0\		False\			null\			null\	Value1\	1238.122\	233.0271\	96\	50\		/3.0\		False\			null\			null\	Mul\	1696.793\	207.7699\	96\	110\		/4\		False\			null\			null\		True\			4\			0\		True\			18\			0\		False\			null\			null\	Abs\	1313.282\	311.7578\	96\	70\		False\			null\			null\		True\			8\			0\	Sin\	1159.234\	326.7578\	96\	70\		False\			null\			null\		True\			9\			0\	Mul\	937.5671\	298.4243\	96\	110\		/4\		False\			null\			null\		True\			11\			0\		True\			10\			0\		False\			null\			null\	Value1\	740.1863\	335.3291\	96\	50\		/16.0\		False\			null\			null\	Add\	598.8771\	206.4\	96\	110\		/4\		False\			null\			null\		True\			2\			1\		True\			12\			0\		False\			null\			null\	Time\	288.9759\	259.0399\	96\	130\		False\			null\			null\		False\			null\			null\		False\			null\			null\		False\			null\			null\		False\			null\			null\	Floor\	1509.333\	332.0756\	96\	70\		False\			null\			null\		True\			14\			0\	Mul\	1366.139\	420.597\	96\	110\		/4\		False\			null\			null\		True\			7\			0\		True\			15\			0\		False\			null\			null\	Value1\	1184.69\	479.0405\	96\	50\		/3.0\		False\			null\			null\	Lerp\	1667.547\	-22.3887\	96\	110\		False\			null\			null\		True\			4\			0\		True\			6\			0\		True\			17\			0\	_FloatSlider\	1490.404\	70.46851\	96\	50\		/Lines\		/2\		/-1\		False\			null\			null\	Lerp\	1725.94\	448.6226\	96\	110\		False\			null\			null\		True\			13\			0\		True\			14\			0\		True\			19\			0\	Value1\	1523.44\	513.6226\	96\	50\		/0.5\		False\			null\			null\	Lerp\	2022.44\	198.6229\	96\	110\		False\			null\			null\		True\			1\			3\		True\			16\			0\		True\			21\			0\	_FloatSlider\	1889.44\	319.6229\	96\	50\		/Intensity\		/1\		/3352\		False\			null\			null\	Detach3\	1046\	12\	96\	110\		False\			null\			null\		False\			null\			null\		False\			null\			null\		True\			1\			3

Shader "PPU/IndustrialCamera" {

	HLSLINCLUDE

			#include "Packages/com.unity.postprocessing/PostProcessing/Shaders/StdLib.hlsl"

			TEXTURE2D_SAMPLER2D(_MainTex, sampler_MainTex);
			uniform half _Intensity;
			uniform half _Lines;

			half3 Frag0 (VaryingsDefault i) : SV_Target {
				half3 CameraOutput = 0.0;
				CameraOutput = lerp(SAMPLE_TEXTURE2D(_MainTex, sampler_MainTex, i.texcoordStereo).xyz, lerp(((SAMPLE_TEXTURE2D(_MainTex, sampler_MainTex, i.texcoordStereo).xyz.x + SAMPLE_TEXTURE2D(_MainTex, sampler_MainTex, i.texcoordStereo).xyz.y + SAMPLE_TEXTURE2D(_MainTex, sampler_MainTex, i.texcoordStereo).xyz.z) / 3.0), (((SAMPLE_TEXTURE2D(_MainTex, sampler_MainTex, i.texcoordStereo).xyz.x + SAMPLE_TEXTURE2D(_MainTex, sampler_MainTex, i.texcoordStereo).xyz.y + SAMPLE_TEXTURE2D(_MainTex, sampler_MainTex, i.texcoordStereo).xyz.z) / 3.0) * lerp(floor((abs(sin(((i.texcoordStereo.y + _Time.x) * 16.0))) * 3.0)), (abs(sin(((i.texcoordStereo.y + _Time.x) * 16.0))) * 3.0), 0.5)), _Lines), _Intensity);
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