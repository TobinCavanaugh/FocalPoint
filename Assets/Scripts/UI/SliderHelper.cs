using System;
using TMPro;
using UnityEngine;

namespace UI
{
    public class SliderHelper : MonoBehaviour
    {
        public string beforeFloat;
        public string afterFloat;
        public TextMeshProUGUI tmp;
        public void SetText(float value)
        {
            value = (float) Math.Round(value, 1);
            tmp.text = beforeFloat + value + afterFloat;
        }
    }
}