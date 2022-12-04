using Game;
using Player;
using UnityEngine;

namespace World
{
    public class WaterCollider : MonoBehaviour
    {
        public AudioSource audioSource;

        private AIController _aiController;
        private PlayerMovement _movement;

        private void Start()
        {

            _movement = FindObjectOfType<PlayerMovement>();
        }

        private void OnTriggerEnter(Collider other)
        {
            audioSource.Play();

            if (other.CompareTag("Player"))
            {
                if (_aiController is null)
                {
                    _aiController = FindObjectOfType<AIController>();

                    // Couldnt find AI
                    if (_aiController is null)
                    {
                        return;
                    }
                }

                if (!_aiController.hasSightOnPlayer)
                {
                    _aiController.ExternalSetDestination(_movement.transform.position);
                }
            }
        }
    }
}