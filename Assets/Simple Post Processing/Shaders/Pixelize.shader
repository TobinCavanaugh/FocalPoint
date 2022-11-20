//{"Values":["0","PPU/Pixelize","_MainTex","0",""]}|{"position":{"serializedVersion":"2","x":0.0,"y":0.0,"width":212.0,"height":89.0},"name":"Int","selected":false,"Values":["Horizontal","Horizontal resolution","16"],"unique":-1}|{"position":{"serializedVersion":"2","x":0.0,"y":0.0,"width":212.0,"height":89.0},"name":"Int","selected":false,"Values":["Vertical","Vertical resolution","16"],"unique":3622}|{"tempTextures":0,"passes":[{"position":{"serializedVersion":"2","x":0.0,"y":36.0,"width":212.0,"height":16.0},"Input":0,"Output":0,"Pass":0,"Iterations":1,"Variable":0}],"passOptions":["0"],"inputOptions":["Game"],"outputOptions":["Screen"],"variableOptions":["None","Horizontal","Vertical"]}
//\	CameraOutput\	1586.388\	107.5078\	96\	110\		False\			null\			null\		False\			null\			null\		False\			null\			null\		True\			12\			0\	CameraInput\	1156.198\	321.091\	96\	170\		False\			null\			null\		False\			null\			null\		False\			null\			null\		False\			null\			null\		True\			3\			0\		True\			9\			0\		False\			null\			null\	StereoUV\	404.6267\	190.4125\	96\	90\		False\			null\			null\		False\			null\			null\		False\			null\			null\	Div\	946.1981\	360.841\	96\	110\		/4\		False\			null\			null\		True\			5\			0\		True\			7\			0\		False\			null\			null\	Mul\	586.1978\	336.841\	96\	110\		/4\		False\			null\			null\		True\			2\			0\		True\			7\			0\		False\			null\			null\	Floor\	759.1976\	354.841\	96\	70\		False\			null\			null\		True\			4\			0\	CameraInput\	1016.865\	108.0077\	96\	170\		False\			null\			null\		False\			null\			null\		False\			null\			null\		False\			null\			null\		False\			null\			null\		False\			null\			null\		True\			2\			2\	_Int\	365.3845\	414.7029\	96\	50\		/Horizontal\		/1\		/-1\		False\			null\			null\	_Int\	335.3844\	550.7234\	96\	50\		/Vertical\		/2\		/3622\		False\			null\			null\	Div\	946.1981\	601.6749\	96\	110\		/4\		False\			null\			null\		True\			11\			0\		True\			8\			0\		False\			null\			null\	Mul\	586.1978\	577.6738\	96\	110\		/4\		False\			null\			null\		True\			2\			1\		True\			8\			0\		False\			null\			null\	Floor\	759.1976\	595.6749\	96\	70\		False\			null\			null\		True\			10\			0\	If\	1477.031\	349.2069\	96\	110\		False\			null\			null\		True\			13\			0\		True\			1\			3\		True\			6\			3\	And\	1310.127\	515.8739\	96\	90\		False\			null\			null\		True\			7\			0\		True\			8\			0

Shader "PPU/Pixelize" {

	HLSLINCLUDE

			#include "Packages/com.unity.postprocessing/PostProcessing/Shaders/StdLib.hlsl"

			TEXTURE2D_SAMPLER2D(_MainTex, sampler_MainTex);
			uniform half _Horizontal;
			uniform half _Vertical;

			half3 Frag0 (VaryingsDefault i) : SV_Target {
				half3 CameraOutput = 0.0;
				CameraOutput = ((_Horizontal && _Vertical) ? SAMPLE_TEXTURE2D(_MainTex, sampler_MainTex, half2((floor((i.texcoordStereo.x * _Horizontal)) / _Horizontal),(floor((i.texcoordStereo.y * _Vertical)) / _Vertical))).xyz : SAMPLE_TEXTURE2D(_MainTex, sampler_MainTex, i.texcoordStereo).xyz);
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