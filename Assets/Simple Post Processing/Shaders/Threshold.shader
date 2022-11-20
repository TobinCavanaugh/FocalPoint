//{"Values":["0","PPU/Threshold","_MainTex","0",""]}|{"position":{"serializedVersion":"2","x":0.0,"y":0.0,"width":212.0,"height":109.0},"name":"FloatSlider","selected":false,"Values":["Intensity","Effect visibility","0.5","0","1"],"unique":-1}|{"position":{"serializedVersion":"2","x":0.0,"y":0.0,"width":212.0,"height":109.0},"name":"FloatSlider","selected":false,"Values":["Level","Threshold level","0.5","0","1"],"unique":1179}|{"tempTextures":0,"passes":[{"position":{"serializedVersion":"2","x":0.0,"y":36.0,"width":212.0,"height":16.0},"Input":0,"Output":0,"Pass":0,"Iterations":1,"Variable":0}],"passOptions":["0"],"inputOptions":["Game"],"outputOptions":["Screen"],"variableOptions":["None"]}
//\	CameraOutput\	1660.892\	11.0555\	96\	110\		False\			null\			null\		False\			null\			null\		False\			null\			null\		True\			3\			0\	CameraInput\	469.5435\	143.5157\	96\	170\		False\			null\			null\		False\			null\			null\		False\			null\			null\		False\			null\			null\		False\			null\			null\		False\			null\			null\		True\			2\			2\	StereoUV\	269.5435\	143.5157\	96\	90\		False\			null\			null\		False\			null\			null\		False\			null\			null\	Lerp\	1295.989\	114.9599\	96\	110\		False\			null\			null\		True\			1\			3\		True\			8\			1\		True\			4\			0\	_FloatSlider\	987.813\	254.3574\	96\	50\		/Intensity\		/1\		/-1\		False\			null\			null\	Add\	669.5275\	406.9287\	96\	130\		/5\		False\			null\			null\		True\			1\			0\		True\			1\			1\		True\			1\			2\		False\			null\			null\	Div\	922.385\	389.786\	96\	110\		/4\		False\			null\			null\		True\			5\			0\		True\			7\			0\		False\			null\			null\	Value1\	702.3845\	586.9285\	96\	50\		/3.0\		False\			null\			null\	Compare\	1226.195\	355.4999\	96\	230\		False\			null\			null\		False\			null\			null\		False\			null\			null\		False\			null\			null\		False\			null\			null\		False\			null\			null\		True\			6\			0\		True\			9\			0\		True\			10\			0\		False\			null\			null\	_FloatSlider\	1014.112\	564.6665\	96\	50\		/Level\		/2\		/1179\		False\			null\			null\	Value1\	1029.984\	496.9675\	96\	50\		/1.0\		False\			null\			null

Shader "PPU/Threshold" {

	HLSLINCLUDE

			#include "Packages/com.unity.postprocessing/PostProcessing/Shaders/StdLib.hlsl"

			TEXTURE2D_SAMPLER2D(_MainTex, sampler_MainTex);
			uniform half _Intensity;
			uniform half _Level;

			half3 Frag0 (VaryingsDefault i) : SV_Target {
				half3 CameraOutput = 0.0;
				CameraOutput = lerp(SAMPLE_TEXTURE2D(_MainTex, sampler_MainTex, i.texcoordStereo).xyz, (((SAMPLE_TEXTURE2D(_MainTex, sampler_MainTex, i.texcoordStereo).x + SAMPLE_TEXTURE2D(_MainTex, sampler_MainTex, i.texcoordStereo).y + SAMPLE_TEXTURE2D(_MainTex, sampler_MainTex, i.texcoordStereo).z) / 3.0) >= _Level ? 1.0 : 0.0), _Intensity);
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