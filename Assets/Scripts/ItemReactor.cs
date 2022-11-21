using System;
using UnityEngine;
using UnityEngine.Events;

namespace DefaultNamespace
{
    public class ItemReactor : MonoBehaviour
    {
        public string failString = "You need a gas can";
        
        public string verb = "pour gas";
        public string itemRequirement = "gas_can";

        public UnityEvent interactEvent;

        public UnityEvent fullEvent;

        public PlayerPickerUpper pi;

        public int gasCanRequirement = 4;
        public int curGasCan = 0;
        
        public void Interact()
        {
            if (pi.item.id == itemRequirement)
            {
                interactEvent?.Invoke();
                Destroy(pi.holdingItem);
                pi.item = null;
                pi.holdingItem = null;
            }
        }

        public void Increment()
        {
            curGasCan++;
            
            if (curGasCan >= gasCanRequirement)
            {
                fullEvent?.Invoke();
            } 
        }

        public string GetText()
        {
            try
            {
                if (pi.item.id == itemRequirement)
                {
                    return $"Press E to {verb}";
                }
            }
            catch (Exception e)
            {
                return $"You need a gas can ({curGasCan}/{gasCanRequirement})";
            }
            
            return $"You need a gas can ({curGasCan}/{gasCanRequirement})";
        }
    }
}