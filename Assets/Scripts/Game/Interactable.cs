using DefaultNamespace;
using Player;
using Sirenix.OdinInspector;
using UnityEngine;
using UnityEngine.Events;

namespace Game
{
    public class Interactable : MonoBehaviour
    {
        private const string INTERACTION = "Interaction Base";

        #region Interaction Text

        [SerializeField, FoldoutGroup(INTERACTION), HideIf(nameof(overrideText))] 
        internal string verb;
        [SerializeField, FoldoutGroup(INTERACTION)] 
        internal string noun;
        [SerializeField, FoldoutGroup(INTERACTION)] 
        internal bool overrideText = false;
        [SerializeField, FoldoutGroup(INTERACTION)]
        internal UnityEvent interactEvent;

        #endregion


        internal PlayerPickerUpper _ppu;

        /// <summary>
        /// Call to interact with the object
        /// </summary>
        /// <param name="ppu">Reference to the player picker upper</param>
        public virtual void Interact(PlayerPickerUpper ppu)
        {
            _ppu = ppu;
            interactEvent?.Invoke();
        }
        
        /// <summary>
        /// Get the text that should be displayed when looking at an interactable
        /// </summary>
        /// <returns>String in the form of Press {InputKey} to {Do Thing}</returns>
        public virtual string GetHoverText()
        {
            if (overrideText)
            {
                return noun;
            }
            else
            {
                return $"Press {PlayerInput.instance.inputKey.ToString()} to {verb} {noun}";
            }
        }

        public virtual void SetOverrideText(string dat)
        {
            overrideText = true;
            noun = dat;
        }
    }
}