//{"Values":["0","PPU/CrossedEyes","_MainTex","0",""]}|{"position":{"serializedVersion":"2","x":0.0,"y":0.0,"width":212.0,"height":109.0},"name":"FloatSlider","selected":false,"Values":["Shift","Horizontal shift","0.5","0","1"],"unique":239}|{"tempTextures":0,"passes":[{"position":{"serializedVersion":"2","x":0.0,"y":36.0,"width":212.0,"height":16.0},"Input":0,"Output":0,"Pass":0,"Iterations":1,"Variable":0}],"passOptions":["0"],"inputOptions":["Game"],"outputOptions":["Screen"],"variableOptions":["None"]}
//\	CameraOutput\	1485.58\	80.44244\	96\	110\		False\			null\			null\		False\			null\			null\		False\			null\			null\		True\			3\			0\	CameraInput\	1024.079\	37.94244\	96\	170\		False\			null\			null\		False\			null\			null\		False\			null\			null\		False\			null\			null\		True\			10\			0\		True\			2\			1\		False\			null\			null\	StereoUV\	473.0788\	253.9426\	96\	90\		False\			null\			null\		False\			null\			null\		False\			null\			null\	Lerp\	1302.897\	181.397\	96\	110\		False\			null\			null\		True\			1\			3\		True\			6\			3\		True\			9\			0\	Add\	849.8969\	468.3972\	96\	110\		/4\		False\			null\			null\		True\			2\			0\		True\			7\			0\		False\			null\			null\	_FloatSlider\	349.3967\	504.8971\	96\	50\		/Shift\		/1\		/239\		False\			null\			null\	CameraInput\	1080.579\	293.9424\	96\	170\		False\			null\			null\		False\			null\			null\		False\			null\			null\		False\			null\			null\		True\			4\			0\		True\			2\			1\		False\			null\			null\	Div\	553.3968\	554.3978\	96\	110\		/4\		False\			null\			null\		True\			5\			0\		True\			8\			0\		False\			null\			null\	Value1\	329.8967\	675.8986\	96\	50\		/50.0\		False\			null\			null\	Value1\	1038.397\	586.1749\	96\	50\		/0.5\		False\			null\			null\	Sub\	780.8969\	301.1747\	96\	110\		/4\		False\			null\			null\		True\			2\			0\		True\			7\			0\		False\			null\			null

Shader "PPU/CrossedEyes" {

	HLSLINCLUDE

			#include "Packages/com.unity.postprocessing/PostProcessing/Shaders/StdLib.hlsl"

			TEXTURE2D_SAMPLER2D(_MainTex, sampler_MainTex);
			uniform half _Shift;

			half3 Frag0 (VaryingsDefault i) : SV_Target {
				half3 CameraOutput = 0.0;
				CameraOutput = lerp(SAMPLE_TEXTURE2D(_MainTex, sampler_MainTex, half2((i.texcoordStereo.x - (_Shift / 50.0)),i.texcoordStereo.y)).xyz, SAMPLE_TEXTURE2D(_MainTex, sampler_MainTex, half2((i.texcoordStereo.x + (_Shift / 50.0)),i.texcoordStereo.y)).xyz, 0.5);
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