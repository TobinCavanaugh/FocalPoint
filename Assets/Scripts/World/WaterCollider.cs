using System;
using Game;
using UnityEngine;

public class WaterCollider : MonoBehaviour
{
    public AudioSource audioSource;
    
    private AIController _aiController;
    private PlayerMovement _movement;

    private void Start()
    {
        _aiController = FindObjectOfType<AIController>();
        _movement = FindObjectOfType<PlayerMovement>();
    }

    private void OnTriggerEnter(Collider other)
    {
        audioSource.Play();

        if (other.CompareTag("Player"))
        {
            if (!_aiController.hasSightOnPlayer)
            {
                _aiController.ExternalSetDestination(_movement.transform.position);
            }
        }
    }
}
