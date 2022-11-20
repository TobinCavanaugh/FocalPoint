//{"Values":["0","PPU/Noise","_MainTex","0",""]}|{"position":{"serializedVersion":"2","x":0.0,"y":0.0,"width":212.0,"height":109.0},"name":"FloatSlider","selected":false,"Values":["Intensity","Effect intenisty","0.5","0","1"],"unique":-1}|{"position":{"serializedVersion":"2","x":0.0,"y":0.0,"width":212.0,"height":109.0},"name":"FloatSlider","selected":false,"Values":["Saturation","Noise saturation","0.5","0","1"],"unique":3552}|{"tempTextures":1,"passes":[{"position":{"serializedVersion":"2","x":0.0,"y":36.0,"width":212.0,"height":16.0},"Input":0,"Output":0,"Pass":0,"Iterations":1,"Variable":0}],"passOptions":["0"],"inputOptions":["Game","tempRT0"],"outputOptions":["Screen","tempRT0"],"variableOptions":["None"]}
//\	CameraOutput\	2376.351\	-9.789597\	96\	110\		False\			null\			null\		False\			null\			null\		False\			null\			null\		True\			19\			0\	CameraInput\	1604.933\	-25.0276\	96\	170\		False\			null\			null\		False\			null\			null\		False\			null\			null\		False\			null\			null\		False\			null\			null\		False\			null\			null\		True\			2\			2\	StereoUV\	563.8608\	80.8652\	96\	90\		False\			null\			null\		False\			null\			null\		False\			null\			null\	Mul\	2040.329\	124.0197\	96\	110\		/4\		False\			null\			null\		True\			1\			3\		True\			24\			0\		False\			null\			null\	Sin\	1680.171\	216.242\	96\	70\		False\			null\			null\		True\			5\			0\	Mul\	1499.854\	175.9244\	96\	150\		/6\		False\			null\			null\		True\			10\			0\		True\			9\			0\		True\			6\			0\		True\			11\			0\		False\			null\			null\	Add\	1269.913\	215.2893\	96\	150\		/6\		False\			null\			null\		True\			7\			0\		True\			8\			0\		True\			12\			0\		True\			12\			1\		False\			null\			null\	Sin\	1048.384\	184.0618\	96\	70\		False\			null\			null\		True\			2\			0\	Sin\	1044.635\	282.8117\	96\	70\		False\			null\			null\		True\			13\			0\	Sub\	1253.009\	365.2307\	96\	150\		/6\		False\			null\			null\		True\			7\			0\		True\			8\			0\		True\			12\			0\		True\			12\			1\		False\			null\			null\	Value1\	1271.878\	141.1833\	96\	50\		/512.0\		False\			null\			null\	Div\	1487.533\	457.4936\	96\	130\		/5\		False\			null\			null\		True\			7\			0\		True\			8\			0\		True\			12\			0\		False\			null\			null\	Screen\	926.1036\	367.1357\	96\	130\		False\			null\			null\		False\			null\			null\		False\			null\			null\		False\			null\			null\		False\			null\			null\	Mul\	773.388\	217.1714\	96\	130\		/5\		False\			null\			null\		True\			2\			1\		True\			14\			0\		True\			17\			0\		False\			null\			null\	Value1\	541.9598\	240.0285\	96\	50\		/4096.0\		False\			null\			null\	Abs\	513.3878\	407.1716\	96\	70\		False\			null\			null\		True\			16\			3\	SinTime\	334.8168\	305.7428\	96\	130\		False\			null\			null\		False\			null\			null\		False\			null\			null\		False\			null\			null\		False\			null\			null\	Add\	701.9599\	384.3142\	96\	110\		/4\		False\			null\			null\		True\			15\			0\		True\			18\			0\		False\			null\			null\	Value1\	506.2452\	315.7428\	96\	50\		/1.0\		False\			null\			null\	Lerp\	2226.181\	15.6039\	96\	110\		False\			null\			null\		True\			1\			3\		True\			3\			0\		True\			20\			0\	_FloatSlider\	2176.046\	261.0793\	96\	50\		/Intensity\		/1\		/-1\		False\			null\			null\	_FloatSlider\	1586.191\	368.7064\	96\	50\		/Saturation\		/2\		/3552\		False\			null\			null\	Mul\	1727.798\	438.7066\	96\	110\		/4\		False\			null\			null\		True\			21\			0\		True\			25\			0\		False\			null\			null\	Add\	1819.704\	308.2304\	96\	110\		/4\		False\			null\			null\		True\			4\			0\		True\			22\			0\		False\			null\			null\	Saturate\	2016.941\	383.2779\	96\	70\		False\			null\			null\		True\			23\			0\	Append3\	1416.667\	607.6666\	96\	110\		False\			null\			null\		True\			12\			3\		True\			8\			0\		True\			6\			0

Shader "PPU/Noise" {

	HLSLINCLUDE

			#include "Packages/com.unity.postprocessing/PostProcessing/Shaders/StdLib.hlsl"

			TEXTURE2D_SAMPLER2D(_MainTex, sampler_MainTex);
			uniform half _Intensity;
			uniform half _Saturation;

			half3 Frag0 (VaryingsDefault i) : SV_Target {
				half3 CameraOutput = 0.0;
				CameraOutput = lerp(SAMPLE_TEXTURE2D(_MainTex, sampler_MainTex, i.texcoordStereo).xyz, (SAMPLE_TEXTURE2D(_MainTex, sampler_MainTex, i.texcoordStereo).xyz * saturate((sin((512.0 * (sin(i.texcoordStereo.x) - sin((i.texcoordStereo.y * 4096.0 * (abs(_SinTime.w) + 1.0))) - _ScreenParams.x - _ScreenParams.y) * (sin(i.texcoordStereo.x) + sin((i.texcoordStereo.y * 4096.0 * (abs(_SinTime.w) + 1.0))) + _ScreenParams.x + _ScreenParams.y) * (sin(i.texcoordStereo.x) / sin((i.texcoordStereo.y * 4096.0 * (abs(_SinTime.w) + 1.0))) / _ScreenParams.x))) + (_Saturation * half3(_ScreenParams.w, sin((i.texcoordStereo.y * 4096.0 * (abs(_SinTime.w) + 1.0))), (sin(i.texcoordStereo.x) + sin((i.texcoordStereo.y * 4096.0 * (abs(_SinTime.w) + 1.0))) + _ScreenParams.x + _ScreenParams.y)))))), _Intensity);
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