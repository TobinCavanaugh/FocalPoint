using System;
using UnityEngine;
using UnityEngine.Rendering.PostProcessing;

namespace DawidMoza.PostProcessingUltimate {
	[Serializable]
	[PostProcess(typeof(InfraredRenderer), PostProcessEvent.AfterStack, "PPU/Infrared")]
	public sealed class Infrared : PostProcessEffectSettings {
		//[Range(0f, 1f), Tooltip("Effect intensity")]
		public FloatParameter Intensity = new FloatParameter {value = 0.3f};
		public ColorParameter _Color = new ColorParameter();
		public FloatParameter _Brightness = new FloatParameter();
	}
	

	public sealed class InfraredRenderer : PostProcessEffectRenderer<Infrared> {
		public override void Render(PostProcessRenderContext context) {
			var sheet = context.propertySheets.Get(Shader.Find("PPU/Infrared"));
			sheet.properties.SetFloat("_Intensity", settings.Intensity);
			sheet.properties.SetColor("_Color", settings._Color);
			sheet.properties.SetFloat("_brightness", settings._Brightness);
			context.command.BlitFullscreenTriangle(context.source, context.destination, sheet, 0);
		}
	}
}