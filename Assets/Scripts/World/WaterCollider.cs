using UnityEngine;

public class WaterCollider : MonoBehaviour
{
    public AudioSource audioSource; 
    private void OnTriggerEnter(Collider other)
    {
        audioSource.Play();
    }
}
