using System;
using UnityEngine;
using UnityEngine.Rendering.PostProcessing;

namespace DawidMoza.PostProcessingUltimate {
	[Serializable]
	[PostProcess(typeof(SepiaRenderer), PostProcessEvent.AfterStack, "PPU/Sepia")]
	public sealed class Sepia : PostProcessEffectSettings {
		[Tooltip("Sepia color")]
		public ColorParameter Color = new ColorParameter {value = new Color(0.6745098f, 0.4784314f, 0.2f, 0f)};
	}

	public sealed class SepiaRenderer : PostProcessEffectRenderer<Sepia> {
		public override void Render(PostProcessRenderContext context) {
			var sheet = context.propertySheets.Get(Shader.Find("PPU/Sepia"));
			sheet.properties.SetColor("_Color", settings.Color);
			context.command.BlitFullscreenTriangle(context.source, context.destination, sheet, 0);
		}
	}
}