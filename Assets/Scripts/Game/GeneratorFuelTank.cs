using DefaultNamespace;
using Player;
using UnityEngine;
using UnityEngine.Events;

namespace Game
{
    public class GeneratorFuelTank : Interactable
    {
        public string itemRequirement = "gas_can";
        public UnityEvent fullEvent;
        
        public int gasCanRequirement = 4;
        public int curGasCan = 0;

        public Animator an;

        public void DestroyThisComponent()
        {
            Destroy(this);
        }

        private void Start()
        {
            _ppu = GameObject.FindObjectOfType<PlayerPickerUpper>();
        }

        public override void Interact(PlayerPickerUpper ppu)
        {
            _ppu = ppu;
            
            //If item matches
            if (_ppu.item.id == itemRequirement)
            {
                //If pour animation is not playing, we are good to go again 
                if (!an.GetCurrentAnimatorStateInfo(0).IsName("Pour"))
                {
                    interactEvent?.Invoke();
                    Destroy(_ppu.holdingItem);
                    _ppu.item = null;
                    _ppu.holdingItem = null;
                }
            }
        }

        /// <summary>
        /// Increments the gas can amount by 1
        /// </summary>
        public void Increment()
        {
            curGasCan++;
            
            if (curGasCan >= gasCanRequirement)
            {
                fullEvent?.Invoke();
            } 
        }

        public override string GetHoverText()
        {
            if (_ppu.item == null)
            {
                return $"This isn't gas ({curGasCan}/{gasCanRequirement})";
            }
            
            if (_ppu.item.id == itemRequirement)
            {
                return $"Press {PlayerInput.instance.inputKey} to pour gas can into generator ({curGasCan}/{gasCanRequirement})";
            }
            else
            {
                return $"This generator only takes gas ({curGasCan}/{gasCanRequirement})";
            }
        }
    }
}