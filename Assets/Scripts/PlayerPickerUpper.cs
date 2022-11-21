using System;
using TMPro;
using UnityEngine;

namespace DefaultNamespace
{
    public class PlayerPickerUpper : MonoBehaviour
    {
        public float range = 4f;
        public LayerMask lm;

        public TextMeshProUGUI tmp;

        public GameObject holdingItem;

        private void Update()
        {
            tmp.text = "";
            
            if (Physics.Raycast(transform.position, transform.forward, out var hit, range, lm))
            {
                if (hit.transform.TryGetComponent(out ItemPickup ip) && holdingItem == null)
                {
                    tmp.text = $"Press E or F to pick up item";
                    
                    if (Input.GetButtonDown("Interact"))
                    {
                        holdingItem = ip.gameObject;
                        var t = holdingItem.transform;
                        t.parent = this.transform;
                        t.localPosition = ip.positionOffset;
                        t.localEulerAngles = ip.rotOffset;
                        t.localScale = ip.scaleOffset;
                        if (t.TryGetComponent(out Rigidbody rb))
                        {
                            Destroy(rb);
                        }
                    }
                }
            }

            if (Input.GetButtonDown("Drop"))
            {
                holdingItem.transform.parent = null;
                holdingItem.AddComponent<Rigidbody>();
                holdingItem.layer = LayerMask.NameToLayer("Item");
                holdingItem.transform.localScale = holdingItem.GetComponent<ItemPickup>().originalScale;
                holdingItem = null;
            }

            if (holdingItem != null)
            {
                tmp.text = "Press Q to drop item";
            }
        }
    }
}