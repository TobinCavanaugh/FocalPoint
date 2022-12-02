using UnityEngine;
using UnityEngine.Events;

namespace Game
{
    public class EndgameCollider : MonoBehaviour
    {
        public UnityEvent enterTrigger;
        private void OnTriggerEnter(Collider other)
        {
            if (other.CompareTag("Player"))
            {
                enterTrigger?.Invoke();
            }
        }
    }
}