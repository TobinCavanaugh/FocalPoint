using System;
using UnityEngine;

namespace Assets.Scripts.UI
{
    public class CustomCanvasScaler : MonoBehaviour
    {
        public float sizeMult;
        public Vector3 startingScale;
        public RectTransform rectTransform;
        private void FixedUpdate()
        {
            Debug.Log($"{Screen.width} / {Screen.height}") ;
            rectTransform.localScale = startingScale * sizeMult * (Screen.width / Screen.height);
        }
    }
}