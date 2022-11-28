using DefaultNamespace;
using Game;
using TMPro;
using UnityEngine;

namespace Player
{
    /// <summary>
    /// Handles picking up, holding, and dropping items
    /// </summary>
    public class PlayerPickerUpper : MonoBehaviour
    {
        public float pickupRange = 2f;

        /// <summary>
        /// The layermask that the raycast will go on (Include walls and the item itself)
        /// </summary>
        public LayerMask lm;

        //The text where interaction messages should be displayed
        public TextMeshProUGUI tmp;

        public GameObject holdingItem;
        public ItemPickup item;

        private void Update()
        {
            var itext = "";

            //Dropping item here
            if (Input.GetKey(PlayerInput.instance.dropKey))
            {
                holdingItem.transform.parent = null;
                holdingItem.AddComponent<Rigidbody>();
                holdingItem.layer = LayerMask.NameToLayer("Item");
                holdingItem.transform.localScale = holdingItem.GetComponent<ItemPickup>().originalScale;
                holdingItem = null;
                item = null;
            }

            //If not holding item, show the drop message
            if (holdingItem != null)
            {
                itext = "Press Q to drop item";
            }

            //Do a raycast
            if (Physics.Raycast(transform.position, transform.forward, out var hit, pickupRange, lm))
            {
                //If its an interactable
                if (hit.transform.TryGetComponent(out Interactable inter))
                {
                    //Set the text to the hover text
                    itext = inter.GetHoverText();

                    //If input is pressed, interact
                    if (Input.GetKeyDown(PlayerInput.instance.inputKey))
                    {
                        inter.Interact(this);
                    }
                }
            }

            tmp.text = itext;
        }
    }
}