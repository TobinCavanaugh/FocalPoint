using DefaultNamespace;
using Player;
using Sirenix.OdinInspector;
using UnityEngine;
using UnityEngine.Events;

namespace Game
{
    public class Interactable : MonoBehaviour
    {
        private const string INTERACTION_TEXT = "Interaction Text";

        #region Interaction Text

        [SerializeField, FoldoutGroup(INTERACTION_TEXT), HideIf(nameof(overrideText))] 
        private string verb;
        [SerializeField, FoldoutGroup(INTERACTION_TEXT)] 
        private string noun;
        [SerializeField, FoldoutGroup(INTERACTION_TEXT)] 
        private bool overrideText = false; 
        
        #endregion

        [SerializeField]
        internal UnityEvent interactEvent;

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
    }
}