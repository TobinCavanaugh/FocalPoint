using System;
using UnityEngine;

namespace DefaultNamespace
{
    public class ItemPickup : Interactable
    {
        public Vector3 rotOffset;
        public Vector3 positionOffset;
        public Vector3 scaleOffset = Vector3.one;
        public string id;

        [HideInInspector]
        public Vector3 originalScale;

        private void Start()
        {
            originalScale = transform.localScale;
        }

        public override void Interact(PlayerPickerUpper ppu)
        {
            ppu.holdingItem = gameObject;
            var t = ppu.holdingItem.transform;
            t.parent = ppu.transform;
            t.localPosition = positionOffset;
            t.localEulerAngles = rotOffset;
            t.localScale = scaleOffset;
            ppu.item = this;
            
            if (t.TryGetComponent(out Rigidbody rb))
            {
                Destroy(rb);
            }
        }
    }
}