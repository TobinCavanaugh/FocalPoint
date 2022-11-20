//{"Values":["0","PPU/Fog","_MainTex","0",""]}|{"position":{"serializedVersion":"2","x":0.0,"y":0.0,"width":212.0,"height":89.0},"name":"Color","selected":false,"Values":["Color","Fog color","0.7843137","0.7843137","0.7843137","0.7843137"],"unique":3124}|{"position":{"serializedVersion":"2","x":0.0,"y":0.0,"width":212.0,"height":109.0},"name":"FloatSlider","selected":false,"Values":["Intensity","Fog visibility","0.5","0","1"],"unique":2153}|{"position":{"serializedVersion":"2","x":0.0,"y":0.0,"width":212.0,"height":109.0},"name":"FloatSlider","selected":false,"Values":["Distance","Distance at which fog should appear","1","0","1"],"unique":-1}|{"position":{"serializedVersion":"2","x":0.0,"y":0.0,"width":212.0,"height":89.0},"name":"Float","selected":false,"Values":["Height","Fog height","3"],"unique":147}|{"tempTextures":0,"passes":[{"position":{"serializedVersion":"2","x":0.0,"y":36.0,"width":212.0,"height":16.0},"Input":0,"Output":0,"Pass":0,"Iterations":1,"Variable":0}],"passOptions":["0"],"inputOptions":["Game"],"outputOptions":["Screen"],"variableOptions":["None"]}
//\	CameraOutput\	2251.018\	-22.50993\	96\	110\		False\			null\			null\		False\			null\			null\		False\			null\			null\		True\			10\			0\	StereoUV\	320.9807\	97.3942\	96\	90\		False\			null\			null\		False\			null\			null\		False\			null\			null\	CameraDepth\	614.8951\	213.2414\	96\	110\		False\			null\			null\		False\			null\			null\		False\			null\			null\		True\			1\			2\	CameraInput\	871.2642\	84.70621\	96\	170\		False\			null\			null\		False\			null\			null\		False\			null\			null\		False\			null\			null\		False\			null\			null\		False\			null\			null\		True\			1\			2\	Mul\	1900.245\	403.8011\	96\	130\		/5\		False\			null\			null\		True\			7\			0\		True\			5\			0\		True\			21\			0\		False\			null\			null\	_FloatSlider\	1829.534\	842.5653\	96\	50\		/Intensity\		/1\		/2153\		False\			null\			null\	_FloatSlider\	770.8392\	594.4131\	96\	50\		/Distance\		/2\		/-1\		False\			null\			null\	Mul\	1705.745\	382.0938\	96\	110\		/4\		False\			null\			null\		True\			22\			0\		True\			18\			0\		False\			null\			null\	Saturate\	1932.954\	246.3141\	96\	70\		False\			null\			null\		True\			4\			0\	Saturate\	1493.409\	123.8573\	96\	70\		False\			null\			null\		True\			3\			3\	Lerp\	2025.683\	-50.73289\	96\	110\		False\			null\			null\		True\			9\			0\		True\			23\			0\		True\			24\			0\	WorldPosition\	740.1425\	695.454\	96\	110\		False\			null\			null\		False\			null\			null\		False\			null\			null\		False\			null\			null\	_Float\	982.6985\	1031.62\	96\	50\		/Height\		/1\		/147\		False\			null\			null\	Linear01Depth\	854.8641\	312.0133\	96\	70\		False\			null\			null\		True\			2\			0\	Sub\	1139.602\	335.0281\	96\	110\		/4\		False\			null\			null\		True\			13\			0\		True\			15\			0\		False\			null\			null\	Sub\	1044.047\	486.3611\	96\	110\		/4\		False\			null\			null\		True\			16\			0\		True\			6\			0\		False\			null\			null\	Value1\	503.8253\	434.1392\	96\	50\		/1.0\		False\			null\			null\	Sub\	1442.936\	866.5826\	96\	110\		/4\		False\			null\			null\		True\			16\			0\		True\			12\			0\		False\			null\			null\	Sub\	1527.381\	545.4723\	96\	110\		/4\		False\			null\			null\		True\			19\			0\		True\			17\			0\		False\			null\			null\	Mul\	1312.936\	666.5808\	96\	110\		/4\		False\			null\			null\		True\			11\			1\		True\			20\			0\		False\			null\			null\	Value1\	974.0469\	878.8036\	96\	50\		/-1.0\		False\			null\			null\	Value1\	1684.048\	748.8063\	96\	50\		/2.0\		False\			null\			null\	Saturate\	1417.381\	391.0289\	96\	70\		False\			null\			null\		True\			14\			0\	_Color\	1515.667\	218.6391\	96\	130\		/Color\		/1\		/3124\		False\			null\			null\		False\			null\			null\		False\			null\			null\		False\			null\			null\		False\			null\			null\	Mul\	2176.778\	260.8612\	96\	110\		/4\		False\			null\			null\		True\			8\			0\		True\			23\			4\		False\			null\			null

Shader "PPU/Fog" {

	HLSLINCLUDE

			#include "Packages/com.unity.postprocessing/PostProcessing/Shaders/StdLib.hlsl"
			uniform float4x4 _ProjMat;
			
			struct VaryingsExtended {
				float4 vertex : SV_POSITION;
				float2 texcoord : TEXCOORD0;
				float2 texcoordStereo : TEXCOORD1;
				float3 worldDirection : TEXCOORD2;
			};
			
			VaryingsExtended VertExtended(AttributesDefault v) {
				VaryingsExtended o;
				o.vertex = float4(v.vertex.xy, 0.0, 1.0);
				o.texcoord = TransformTriangleVertexToUV(v.vertex.xy);
				#if UNITY_UV_STARTS_AT_TOP
					o.texcoord = o.texcoord * float2(1.0, -1.0) + float2(0.0, 1.0);
				#endif
				o.texcoordStereo = TransformStereoScreenSpaceTex(o.texcoord, 1.0);
				float4 clip = float4(o.texcoord.xy * 2 - 1, 0.0, 1.0);
				o.worldDirection = mul(_ProjMat, clip) - _WorldSpaceCameraPos;
				return o;
			}

			TEXTURE2D_SAMPLER2D(_MainTex, sampler_MainTex);
			TEXTURE2D_SAMPLER2D(_CameraDepthTexture, sampler_CameraDepthTexture);
			uniform half4 _Color;
			uniform half _Intensity;
			uniform half _Distance;
			uniform half _Height;

			half3 Frag0 (VaryingsExtended i) : SV_Target {
				half3 CameraOutput = 0.0;
				CameraOutput = lerp(saturate(SAMPLE_TEXTURE2D(_MainTex, sampler_MainTex, i.texcoordStereo).xyz), _Color.xyz, (saturate(((saturate((Linear01Depth(SAMPLE_TEXTURE2D(_CameraDepthTexture, sampler_CameraDepthTexture, i.texcoordStereo).x) - (1.0 - _Distance))) * (((i.worldDirection * LinearEyeDepth(SAMPLE_DEPTH_TEXTURE(_CameraDepthTexture, sampler_CameraDepthTexture, i.texcoordStereo)) + _WorldSpaceCameraPos).y * -1.0) - (1.0 - _Height))) * _Intensity * 2.0)) * _Color.w));
				return CameraOutput;
			}

	ENDHLSL

	SubShader {

		Cull Off ZWrite Off ZTest Always

		Pass {

			HLSLPROGRAM

				#pragma vertex VertExtended
				#pragma fragment Frag0

			ENDHLSL
		}
	}
}