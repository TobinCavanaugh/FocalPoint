//{"Values":["0","PPU/ColorCurves","_MainTex","0",""]}|{"position":{"serializedVersion":"2","x":0.0,"y":0.0,"width":212.0,"height":69.0},"name":"Spline","selected":false,"Values":["Red","Red channel curve"],"unique":-1}|{"position":{"serializedVersion":"2","x":0.0,"y":0.0,"width":212.0,"height":69.0},"name":"Spline","selected":false,"Values":["Green","Green channel curve"],"unique":3646}|{"position":{"serializedVersion":"2","x":0.0,"y":0.0,"width":212.0,"height":69.0},"name":"Spline","selected":false,"Values":["Blue","Blue channel curve"],"unique":1415}|{"position":{"serializedVersion":"2","x":0.0,"y":0.0,"width":212.0,"height":89.0},"name":"Color","selected":false,"Values":["Tint","Image filter","1","1","1","0"],"unique":214}|{"tempTextures":0,"passes":[{"position":{"serializedVersion":"2","x":0.0,"y":36.0,"width":212.0,"height":16.0},"Input":0,"Output":0,"Pass":0,"Iterations":1,"Variable":0}],"passOptions":["0"],"inputOptions":["Game"],"outputOptions":["Screen"],"variableOptions":["None"]}
//\	CameraOutput\	1584.293\	263.0878\	96\	110\		False\			null\			null\		False\			null\			null\		False\			null\			null\		True\			6\			0\	CameraInput\	588.6269\	146.0878\	96\	170\		False\			null\			null\		False\			null\			null\		False\			null\			null\		False\			null\			null\		False\			null\			null\		False\			null\			null\		True\			2\			2\	StereoUV\	304.7226\	229.3253\	96\	90\		False\			null\			null\		False\			null\			null\		False\			null\			null\	_Spline\	884.9604\	146.4211\	96\	70\		/Red\		/1\		/-1\		False\			null\			null\		True\			1\			0\	_Spline\	886.9604\	258.0876\	96\	70\		/Green\		/2\		/3646\		False\			null\			null\		True\			1\			1\	_Spline\	881.9604\	348.7543\	96\	70\		/Blue\		/3\		/1415\		False\			null\			null\		True\			1\			2\	Mul\	1385.397\	329.6586\	96\	110\		/4\		False\			null\			null\		True\			8\			0\		True\			7\			0\		False\			null\			null\	_Color\	1146.396\	472.9919\	96\	130\		/Tint\		/1\		/214\		False\			null\			null\		False\			null\			null\		False\			null\			null\		False\			null\			null\		False\			null\			null\	Append3\	1149\	206\	96\	110\		False\			null\			null\		True\			3\			0\		True\			4\			0\		True\			5\			0

Shader "PPU/ColorCurves" {

	HLSLINCLUDE

			#include "Packages/com.unity.postprocessing/PostProcessing/Shaders/StdLib.hlsl"

			TEXTURE2D_SAMPLER2D(_MainTex, sampler_MainTex);
			TEXTURE2D_SAMPLER2D(_Red, sampler_Red);
			TEXTURE2D_SAMPLER2D(_Green, sampler_Green);
			TEXTURE2D_SAMPLER2D(_Blue, sampler_Blue);
			uniform half4 _Tint;

			half3 Frag0 (VaryingsDefault i) : SV_Target {
				half3 CameraOutput = 0.0;
				CameraOutput = (half3(SAMPLE_TEXTURE2D(_Red, sampler_Red, half2(SAMPLE_TEXTURE2D(_MainTex, sampler_MainTex, i.texcoordStereo).x, 0.5)).a, SAMPLE_TEXTURE2D(_Green, sampler_Green, half2(SAMPLE_TEXTURE2D(_MainTex, sampler_MainTex, i.texcoordStereo).y, 0.5)).a, SAMPLE_TEXTURE2D(_Blue, sampler_Blue, half2(SAMPLE_TEXTURE2D(_MainTex, sampler_MainTex, i.texcoordStereo).z, 0.5)).a) * _Tint.xyz);
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