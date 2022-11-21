using System;
using UnityEngine;

namespace DefaultNamespace
{
    public class ItemPickup : MonoBehaviour
    {
        public Vector3 rotOffset;
        public Vector3 positionOffset;
        public Vector3 scaleOffset = Vector3.one;

        [HideInInspector]
        public Vector3 originalScale;

        private void Start()
        {
            originalScale = transform.localScale;
        }
    }
}