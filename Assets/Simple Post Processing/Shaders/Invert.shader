//{"Values":["0","PPU/Invert","_MainTex","0",""]}|{"position":{"serializedVersion":"2","x":0.0,"y":0.0,"width":212.0,"height":109.0},"name":"FloatSlider","selected":false,"Values":["Intensity","Effect intensity","1","0","1"],"unique":-1}|{"tempTextures":0,"passes":[{"position":{"serializedVersion":"2","x":0.0,"y":36.0,"width":212.0,"height":16.0},"Input":0,"Output":0,"Pass":0,"Iterations":1,"Variable":0}],"passOptions":["0"],"inputOptions":["Game"],"outputOptions":["Screen"],"variableOptions":["None"]}
//\	CameraOutput\	1179.19\	49.57339\	96\	110\		False\			null\			null\		False\			null\			null\		False\			null\			null\		True\			4\			0\	CameraInput\	492.1907\	38.07339\	96\	170\		False\			null\			null\		False\			null\			null\		False\			null\			null\		False\			null\			null\		False\			null\			null\		False\			null\			null\		True\			2\			2\	StereoUV\	278.1906\	242.0734\	96\	90\		False\			null\			null\		False\			null\			null\		False\			null\			null\	Custom\	730.1907\	57.46227\	96\	270\		/Assets/Post Processing Ultimate/Functions/Invert.hlsl\		/Invert\		/3\		/4\		/Value\		False\			null\			null\		False\			null\			null\		False\			null\			null\		False\			null\			null\		False\			null\			null\		False\			null\			null\		False\			null\			null\		False\			null\			null\		False\			null\			null\		True\			1\			3\	Lerp\	981.5239\	187.9068\	96\	110\		False\			null\			null\		True\			1\			3\		True\			3\			4\		True\			5\			0\	_FloatSlider\	558.6907\	484.4069\	96\	50\		/Intensity\		/1\		/-1\		False\			null\			null

Shader "PPU/Invert" {

	HLSLINCLUDE

			#include "Packages/com.unity.postprocessing/PostProcessing/Shaders/StdLib.hlsl"
			#include "Assets/Simple Post Processing/Functions/Invert.hlsl"

			TEXTURE2D_SAMPLER2D(_MainTex, sampler_MainTex);
			uniform half _Intensity;

			half3 Frag0 (VaryingsDefault i) : SV_Target {
				half3 CameraOutput = 0.0;
				CameraOutput = lerp(SAMPLE_TEXTURE2D(_MainTex, sampler_MainTex, i.texcoordStereo).xyz, Invert(half4(SAMPLE_TEXTURE2D(_MainTex, sampler_MainTex, i.texcoordStereo).xyz, 0.0)).xyz, _Intensity);
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