//{"Values":["0","PPU/Sepia","_MainTex","0",""]}|{"position":{"serializedVersion":"2","x":0.0,"y":0.0,"width":212.0,"height":89.0},"name":"Color","selected":false,"Values":["Color","Sepia color","0.6745098","0.4784314","0.2","0"],"unique":-1}|{"tempTextures":0,"passes":[{"position":{"serializedVersion":"2","x":0.0,"y":36.0,"width":212.0,"height":16.0},"Input":0,"Output":0,"Pass":0,"Iterations":1,"Variable":0}],"passOptions":["0"],"inputOptions":["Game"],"outputOptions":["Screen"],"variableOptions":["None"]}
//\	CameraOutput\	1027.89\	83.11113\	96\	110\		False\			null\			null\		False\			null\			null\		False\			null\			null\		True\			4\			0\	CameraInput\	460.8889\	62.11113\	96\	170\		False\			null\			null\		False\			null\			null\		False\			null\			null\		False\			null\			null\		False\			null\			null\		False\			null\			null\		True\			2\			2\	StereoUV\	260.8889\	62.11113\	96\	90\		False\			null\			null\		False\			null\			null\		False\			null\			null\	Av\	699.8895\	186.1111\	96\	130\		/5\		False\			null\			null\		True\			1\			0\		True\			1\			1\		True\			1\			2\		False\			null\			null\	Mul\	873.8895\	278.1111\	96\	110\		/4\		False\			null\			null\		True\			3\			0\		True\			5\			0\		False\			null\			null\	_Color\	554.2225\	364\	96\	130\		/Color\		/1\		/-1\		False\			null\			null\		False\			null\			null\		False\			null\			null\		False\			null\			null\		False\			null\			null

Shader "PPU/Sepia" {

	HLSLINCLUDE

			#include "Packages/com.unity.postprocessing/PostProcessing/Shaders/StdLib.hlsl"

			TEXTURE2D_SAMPLER2D(_MainTex, sampler_MainTex);
			uniform half4 _Color;

			half3 Frag0 (VaryingsDefault i) : SV_Target {
				half3 CameraOutput = 0.0;
				CameraOutput = (((SAMPLE_TEXTURE2D(_MainTex, sampler_MainTex, i.texcoordStereo).x + SAMPLE_TEXTURE2D(_MainTex, sampler_MainTex, i.texcoordStereo).y + SAMPLE_TEXTURE2D(_MainTex, sampler_MainTex, i.texcoordStereo).z) / 3.0) * _Color.xyz);
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