using Sirenix.OdinInspector;
using UnityEngine;
using UnityEngine.Events;

namespace DefaultNamespace
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
        private UnityEvent interactEvent;

        internal PlayerPickerUpper _ppu;

        public virtual void Interact(PlayerPickerUpper ppu)
        {
            _ppu = ppu;
            interactEvent?.Invoke();
        }
        
        public virtual string GetHoverText()
        {
            if (overrideText)
            {
                return noun;
            }
            else
            {
                return $"Press {PlayerInput.instance.inputKey.ToString()} to {verb}";
            }
        }
    }
}