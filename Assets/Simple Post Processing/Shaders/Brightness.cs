using System;
using UnityEngine;
using UnityEngine.Rendering.PostProcessing;

[Serializable]
[PostProcess(typeof(BrightnessRenderer), PostProcessEvent.AfterStack, "PPU/Brightness")]

public class Brightness : PostProcessEffectSettings
{
    public FloatParameter _Brightness = new FloatParameter();
}

public sealed class BrightnessRenderer : PostProcessEffectRenderer<Brightness>
{
    public override void Render(PostProcessRenderContext context) {
        var sheet = context.propertySheets.Get(Shader.Find("PPU/Brightness"));
        sheet.properties.SetFloat("_Brightness", settings._Brightness);
        context.command.BlitFullscreenTriangle(context.source, context.destination, sheet, 0);
    }
}

