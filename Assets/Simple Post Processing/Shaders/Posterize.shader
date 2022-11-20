//{"Values":["0","PPU/Posterize","_MainTex","0",""]}|{"position":{"serializedVersion":"2","x":0.0,"y":0.0,"width":212.0,"height":89.0},"name":"Int","selected":false,"Values":["Colors","Number of colors in each channel","8"],"unique":-1}|{"tempTextures":0,"passes":[{"position":{"serializedVersion":"2","x":0.0,"y":36.0,"width":212.0,"height":16.0},"Input":0,"Output":0,"Pass":0,"Iterations":1,"Variable":0}],"passOptions":["0"],"inputOptions":["Game"],"outputOptions":["Screen"],"variableOptions":["None","Colors"]}
//\	CameraOutput\	1194.715\	50.38879\	96\	110\		False\			null\			null\		False\			null\			null\		False\			null\			null\		True\			2\			0\	StereoUV\	280.4522\	164.5435\	96\	90\		False\			null\			null\		False\			null\			null\		False\			null\			null\	Div\	1092.024\	276.222\	96\	110\		/4\		False\			null\			null\		True\			4\			0\		True\			6\			0\		False\			null\			null\	Mul\	732.0234\	252.222\	96\	110\		/4\		False\			null\			null\		True\			5\			3\		True\			6\			0\		False\			null\			null\	Floor\	905.0234\	270.222\	96\	70\		False\			null\			null\		True\			3\			0\	CameraInput\	492.6904\	89.63873\	96\	170\		False\			null\			null\		False\			null\			null\		False\			null\			null\		False\			null\			null\		False\			null\			null\		False\			null\			null\		True\			1\			2\	_Int\	498.71\	363.8339\	96\	50\		/Colors\		/1\		/-1\		False\			null\			null

Shader "PPU/Posterize" {

	HLSLINCLUDE

			#include "Packages/com.unity.postprocessing/PostProcessing/Shaders/StdLib.hlsl"

			TEXTURE2D_SAMPLER2D(_MainTex, sampler_MainTex);
			uniform half _Colors;

			half3 Frag0 (VaryingsDefault i) : SV_Target {
				half3 CameraOutput = 0.0;
				CameraOutput = (floor((SAMPLE_TEXTURE2D(_MainTex, sampler_MainTex, i.texcoordStereo).xyz * _Colors)) / _Colors);
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