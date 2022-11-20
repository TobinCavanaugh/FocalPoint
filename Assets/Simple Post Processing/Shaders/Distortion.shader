//{"Values":["0","PPU/Distortion","_MainTex","0",""]}|{"position":{"serializedVersion":"2","x":0.0,"y":0.0,"width":212.0,"height":109.0},"name":"FloatSlider","selected":false,"Values":["Intensity","Effect intensity","0.5","0","1"],"unique":3095}|{"position":{"serializedVersion":"2","x":0.0,"y":0.0,"width":212.0,"height":69.0},"name":"Texture2D","selected":false,"Values":["Coords","New coords"],"unique":-1}|{"tempTextures":0,"passes":[{"position":{"serializedVersion":"2","x":0.0,"y":36.0,"width":212.0,"height":16.0},"Input":0,"Output":0,"Pass":0,"Iterations":1,"Variable":0}],"passOptions":["0"],"inputOptions":["Game"],"outputOptions":["Screen"],"variableOptions":["None"]}
//\	CameraOutput\	1488.735\	232.2954\	96\	110\		False\			null\			null\		False\			null\			null\		False\			null\			null\		True\			1\			3\	CameraInput\	1283.402\	212.9622\	96\	170\		False\			null\			null\		False\			null\			null\		False\			null\			null\		False\			null\			null\		False\			null\			null\		False\			null\			null\		True\			4\			0\	StereoUV\	316.9015\	144.6287\	96\	90\		False\			null\			null\		False\			null\			null\		False\			null\			null\	_Texture2D\	504.687\	388.4144\	96\	190\		/Coords\		/1\		/-1\		False\			null\			null\		False\			null\			null\		False\			null\			null\		False\			null\			null\		False\			null\			null\		False\			null\			null\		False\			null\			null\		True\			2\			2\	Add\	1079.457\	268.0731\	96\	110\		/4\		False\			null\			null\		True\			2\			2\		True\			7\			0\		False\			null\			null\	Sub\	863.8459\	653.7394\	96\	110\		/4\		False\			null\			null\		True\			6\			2\		True\			2\			2\		False\			null\			null\	Value2\	703.7268\	258.5016\	96\	90\		/0.5\		/0.5\		False\			null\			null\		False\			null\			null\		False\			null\			null\	Mul\	1203.013\	561.2399\	96\	130\		/5\		False\			null\			null\		True\			9\			0\		True\			5\			0\		True\			8\			0\		False\			null\			null\	_FloatSlider\	1015.68\	832.7394\	96\	50\		/Intensity\		/1\		/3095\		False\			null\			null\	Append2\	715.1666\	430.5859\	96\	90\		False\			null\			null\		True\			3\			2\		True\			3\			1

Shader "PPU/Distortion" {

	HLSLINCLUDE

			#include "Packages/com.unity.postprocessing/PostProcessing/Shaders/StdLib.hlsl"

			TEXTURE2D_SAMPLER2D(_MainTex, sampler_MainTex);
			uniform half _Intensity;
			TEXTURE2D_SAMPLER2D(_Coords, sampler_Coords);

			half3 Frag0 (VaryingsDefault i) : SV_Target {
				half3 CameraOutput = 0.0;
				CameraOutput = SAMPLE_TEXTURE2D(_MainTex, sampler_MainTex, (i.texcoordStereo + (half2(SAMPLE_TEXTURE2D(_Coords, sampler_Coords, i.texcoordStereo).y, SAMPLE_TEXTURE2D(_Coords, sampler_Coords, i.texcoordStereo).x) * (half2(0.5, 0.5) - i.texcoordStereo) * _Intensity))).xyz;
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