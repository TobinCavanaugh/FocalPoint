﻿using System.Collections.Generic;
using System.IO;
using System.Linq;
using UnityEditor;
using UnityEngine;
using UnityEngine.Rendering.PostProcessing;

namespace DawidMoza.PostProcessingUltimate {
    public class LutBlender : EditorWindow {

        internal List<string> camNames = new List<string>();
        internal int selection = 0;
        internal int tempSelection = 0;
        internal Vector2 scrollPos;
        internal static LutBlender window;
        internal float width;
        internal float height;
        internal float lerp = 0.5f;
        internal float lerp1 = 0.5f;
        internal Texture2D[] tex = new Texture2D[2];
        internal Texture2D[] tex1 = new Texture2D[2];
        internal Camera cam;
        internal Texture2D tex2D;
        internal Texture2D ldr;
        internal Texture2D current;
        internal string path;
        internal bool stopped;
        internal ColorGrading colorGrading;

        [MenuItem("Window/" + MiscUtils.name + "/LUT Blender")]
        private static void Init() {
            window = (LutBlender) GetWindow(typeof(LutBlender));
            window.minSize = new Vector2(450, 347);
            window.titleContent = new GUIContent("LUT Blender");
            window.position = MiscUtils.CenteredSize(window.minSize);
            window.Show();
        }

        internal void Awake() {
            stopped = false;
            List<Camera> cameras = MiscUtils.CamerasThatContainsEffect("ColorGrading");
            camNames = cameras.Select(c => c.name).ToList();
            if (cameras.Count > 0) {
                cam = cameras[selection];
            } else {
                return;
            }
            colorGrading = (ColorGrading) StackEffect.GetEffect(cam, "ColorGrading");
            if (colorGrading.ldrLut.value != null) {
                ldr = (Texture2D) colorGrading.ldrLut.value;
            }
            colorGrading.ldrLut.value = null;
            tex2D = MiscUtils.CurrentScreen(cam);
            colorGrading.ldrLut.value = ldr;
            tex[0] = Resources.Load("NeutralLdrLut") as Texture2D;
            tex[1] = tex[0];
            tex1[0] = tex[0];
            tex1[1] = tex[0];
            Clear();
        }

        internal void Blend() {
            current = new Texture2D(1024, 32, TextureFormat.RGBAFloat, true);
            for (int y = 0; y < current.height; ++y) {
                for (int x = 0; x < current.width; ++x) {
                    try {
                        Color color = Color.Lerp(tex[0].GetPixel(x, y), tex[1].GetPixel(x, y), lerp);
                        current.SetPixel(x, y, color);
                    } catch {
                        Debug.Log("Wrong textures");
                    }
                }
            }
            current.Apply();
        }

        internal void Clear() {
            EditorUtility.UnloadUnusedAssetsImmediate(true);
            Resources.UnloadUnusedAssets();
            System.GC.Collect();
        }

        internal void OnDestroy() {
            Clear();
        }

        internal void OnGUI() {
            width = position.width - 22;
            height = 0.5625f * width;
            if (!Application.isPlaying && cam != null && cam.enabled && !stopped) {
                scrollPos = EditorGUILayout.BeginScrollView(scrollPos);
                selection = EditorGUILayout.Popup("Camera:", selection, camNames.ToArray());
                if (selection != tempSelection) {
                    tempSelection = selection;
                    Awake();
                }
                GUILayout.Box(tex2D, GUILayout.Width(width), GUILayout.Height(Mathf.Min(height, tex2D.height)));
                tex[0] = (Texture2D) EditorGUILayout.ObjectField(tex[0], typeof(Texture2D), false);
                tex[1] = (Texture2D) EditorGUILayout.ObjectField(tex[1], typeof(Texture2D), false);
                lerp = EditorGUILayout.Slider(lerp, 0f, 1f);
                if (GUILayout.Button("Save")) {
                    path = EditorUtility.SaveFilePanel("Save LUT Texture", $"Assets/{MiscUtils.name}/Resources/PPU_LUTs", "MyLUT", "png");
                    Blend();
                    if (path != null && path != "") {
                        File.WriteAllBytes(path, current.EncodeToPNG());
                        Debug.Log("Success");
                    }
                }
                if (lerp1 != lerp || tex1[0] != tex[0] || tex1[1] != tex[1]) {
                    lerp1 = lerp;
                    tex1[0] = tex[0];
                    tex1[1] = tex[1];
                    Blend();
                    colorGrading.ldrLut.value = current;
                    tex2D = MiscUtils.CurrentScreen(cam);
                    colorGrading.ldrLut.value = null;
                }
                EditorGUILayout.EndScrollView();
            } else {
                stopped = true;
                if (GUILayout.Button(Application.isPlaying ? "Click me when Application is not playing." : "Click me when Color Grading is attached to an active camera.", GUILayout.Width(position.width - 4), GUILayout.Height(position.height - 4))) {
                    Awake();
                }
            }
        }
    }
}