using System;
using TMPro;
using Unity.VisualScripting;
using UnityEngine;
using UnityEngine.UI;

namespace UI
{
    public class SliderHelper : MonoBehaviour
    {
        public string beforeFloat;
        public string afterFloat;
        public TextMeshProUGUI tmp;
        public Slider slider;

        private void Start()
        {
            slider = GetComponent<Slider>();
            slider.onValueChanged.AddListener(x => SetText(x));
        }

        public void SetText(float value)
        {
            value = (float) Math.Round(value, 1);
            tmp.text = beforeFloat + value + afterFloat;
        }
    }
}