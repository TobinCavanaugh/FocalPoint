//{"Values":["0","PPU/ChromaticAberration","_MainTex","0",""]}|{"position":{"serializedVersion":"2","x":0.0,"y":0.0,"width":212.0,"height":109.0},"name":"IntSlider","selected":false,"Values":["Iterations","Effect iterations","1","1","32"],"unique":2581}|{"position":{"serializedVersion":"2","x":0.0,"y":0.0,"width":212.0,"height":109.0},"name":"FloatSlider","selected":false,"Values":["Offset","Channels offset","0.5","0","1"],"unique":-1}|{"tempTextures":0,"passes":[{"position":{"serializedVersion":"2","x":0.0,"y":36.0,"width":212.0,"height":16.0},"Input":0,"Output":0,"Pass":0,"Iterations":1,"Variable":1}],"passOptions":["0"],"inputOptions":["Game"],"outputOptions":["Screen"],"variableOptions":["None","Iterations"]}
//\	CameraOutput\	1547.025\	349.6427\	96\	110\		True\			1\			0\		True\			3\			1\		True\			4\			2\		False\			null\			null\	CameraInput\	1229.692\	112.476\	96\	170\		False\			null\			null\		False\			null\			null\		False\			null\			null\		False\			null\			null\		True\			7\			0\		True\			2\			1\		False\			null\			null\	StereoUV\	403.8584\	166.6427\	96\	90\		False\			null\			null\		False\			null\			null\		False\			null\			null\	CameraInput\	1199.692\	324.7427\	96\	170\		False\			null\			null\		False\			null\			null\		False\			null\			null\		False\			null\			null\		False\			null\			null\		False\			null\			null\		True\			2\			2\	CameraInput\	1213.025\	578.6759\	96\	170\		False\			null\			null\		False\			null\			null\		False\			null\			null\		False\			null\			null\		True\			6\			0\		True\			2\			1\		False\			null\			null\	_FloatSlider\	445.717\	353.8585\	96\	50\		/Offset\		/1\		/-1\		False\			null\			null\	Add\	867.6215\	512.1899\	96\	110\		/4\		False\			null\			null\		True\			2\			0\		True\			8\			0\		False\			null\			null\	Sub\	894.4547\	312.69\	96\	110\		/4\		False\			null\			null\		True\			2\			0\		True\			8\			0\		False\			null\			null\	Div\	675.9406\	573.1509\	96\	110\		/4\		False\			null\			null\		True\			5\			0\		True\			9\			0\		False\			null\			null\	Value1\	450.6069\	661.4841\	96\	50\		/30.0\		False\			null\			null

Shader "PPU/Brightness" {

	HLSLINCLUDE

			#include "Packages/com.unity.postprocessing/PostProcessing/Shaders/StdLib.hlsl"

			TEXTURE2D_SAMPLER2D(_MainTex, sampler_MainTex);

			half _Brightness;
	
			half3 Frag0 (VaryingsDefault i) : SV_Target {
				half3 CameraOutput = SAMPLE_TEXTURE2D(_MainTex, sampler_MainTex, i.texcoordStereo);
				CameraOutput *= _Brightness;			
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