using System;
using Game;
using Player;
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

        /// <summary>
        /// Call this to pick up item
        /// </summary>
        /// <param name="ppu"></param>
        public override void Interact(PlayerPickerUpper ppu)
        {
            //Assign pickup stuff
            ppu.holdingItem = gameObject;
            ppu.item = this;

            //Cache transform to t
            var t = transform;
            t.parent = ppu.transform;
            t.localPosition = positionOffset;
            t.localEulerAngles = rotOffset;
            t.localScale = scaleOffset;
            
            if (t.TryGetComponent(out Rigidbody rb))
            {
                Destroy(rb);
            }
        }
    }
}