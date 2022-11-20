//{"Values":["0","PPU/Drunk","_MainTex","0",""]}|{"position":{"serializedVersion":"2","x":0.0,"y":0.0,"width":212.0,"height":89.0},"name":"Float","selected":false,"Values":["Horizontal","Horizontal wobble","1"],"unique":-1}|{"position":{"serializedVersion":"2","x":0.0,"y":0.0,"width":212.0,"height":89.0},"name":"Float","selected":false,"Values":["Vertical","Vertical wobble","1"],"unique":843}|{"position":{"serializedVersion":"2","x":0.0,"y":0.0,"width":212.0,"height":89.0},"name":"Float","selected":false,"Values":["Speed","Animation speed","1"],"unique":1106}|{"tempTextures":0,"passes":[{"position":{"serializedVersion":"2","x":0.0,"y":36.0,"width":212.0,"height":16.0},"Input":0,"Output":0,"Pass":0,"Iterations":1,"Variable":0}],"passOptions":["0"],"inputOptions":["Game"],"outputOptions":["Screen"],"variableOptions":["None"]}
//\	CameraOutput\	3546.025\	75.63317\	96\	110\		False\			null\			null\		False\			null\			null\		False\			null\			null\		True\			1\			3\	CameraInput\	3213.52\	-22.36698\	96\	170\		False\			null\			null\		False\			null\			null\		False\			null\			null\		False\			null\			null\		True\			5\			0\		True\			6\			0\		False\			null\			null\	StereoUV\	999.384\	105.0376\	96\	90\		False\			null\			null\		False\			null\			null\		False\			null\			null\	Sin\	2274.976\	130.9424\	96\	70\		False\			null\			null\		True\			13\			0\	Sin\	2367.527\	463.8717\	96\	70\		False\			null\			null\		True\			15\			0\	Add\	2661.676\	-11.90678\	96\	110\		/4\		False\			null\			null\		True\			2\			0\		True\			8\			0\		False\			null\			null\	Add\	2889.176\	165.5939\	96\	110\		/4\		False\			null\			null\		True\			2\			1\		True\			7\			0\		False\			null\			null\	Mul\	2834.934\	383.3337\	96\	110\		/4\		False\			null\			null\		True\			4\			0\		True\			16\			0\		False\			null\			null\	Mul\	2424.26\	234.2437\	96\	110\		/4\		False\			null\			null\		True\			3\			0\		True\			16\			0\		False\			null\			null\	Mul\	1100.596\	378.044\	96\	110\		/4\		False\			null\			null\		True\			20\			0\		True\			17\			0\		False\			null\			null\	_Float\	346.5529\	346.3912\	96\	50\		/Speed\		/3\		/1106\		False\			null\			null\	_Float\	2177.741\	296.0332\	96\	50\		/Horizontal\		/1\		/-1\		False\			null\			null\	_Float\	1429.526\	492.8193\	96\	50\		/Vertical\		/2\		/843\		False\			null\			null\	Mul\	1904.447\	136.8663\	96\	130\		/5\		False\			null\			null\		True\			21\			0\		True\			14\			0\		True\			12\			0\		False\			null\			null\	Value1\	1528.632\	293.8902\	96\	50\		/10.0\		False\			null\			null\	Mul\	2051.726\	437.4542\	96\	130\		/5\		False\			null\			null\		True\			22\			0\		True\			14\			0\		True\			11\			0\		False\			null\			null\	Value1\	2143.137\	616.629\	96\	50\		/0.01\		False\			null\			null\	Value1\	718.1392\	454.13\	96\	50\		/0.1\		False\			null\			null\	Time\	338.8703\	48.29855\	96\	130\		False\			null\			null\		False\			null\			null\		False\			null\			null\		False\			null\			null\		False\			null\			null\	Mul\	566.4092\	123.219\	96\	110\		/4\		False\			null\			null\		True\			18\			1\		True\			10\			0\		False\			null\			null\	Add\	855.0592\	291.7511\	96\	90\		/3\		False\			null\			null\		True\			19\			0\		False\			null\			null\	Add\	1408.076\	127.1468\	96\	110\		/4\		False\			null\			null\		True\			2\			1\		True\			9\			0\		False\			null\			null\	Add\	1225.933\	248.5755\	96\	110\		/4\		False\			null\			null\		True\			2\			0\		True\			9\			0\		False\			null\			null

Shader "PPU/Drunk" {

	HLSLINCLUDE

			#include "Packages/com.unity.postprocessing/PostProcessing/Shaders/StdLib.hlsl"

			TEXTURE2D_SAMPLER2D(_MainTex, sampler_MainTex);
			uniform half _Horizontal;
			uniform half _Vertical;
			uniform half _Speed;

			half3 Frag0 (VaryingsDefault i) : SV_Target {
				half3 CameraOutput = 0.0;
				CameraOutput = SAMPLE_TEXTURE2D(_MainTex, sampler_MainTex, half2((i.texcoordStereo.x + (sin(((i.texcoordStereo.y + ((_Time.y * _Speed) * 0.1)) * 10.0 * _Vertical)) * 0.01)),(i.texcoordStereo.y + (sin(((i.texcoordStereo.x + ((_Time.y * _Speed) * 0.1)) * 10.0 * _Horizontal)) * 0.01)))).xyz;
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