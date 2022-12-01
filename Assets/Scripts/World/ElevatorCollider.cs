using Game;
using UnityEngine;
using UnityEngine.Events;

public class ElevatorCollider : MonoBehaviour
{
    public PlayerMovement pm;
    public AIController aic;
    public Transform wendigoViewPos;

    public UnityEvent enterEvent;

    public bool active = false;

    public void Activate()
    {
        active = true;
    }

    private void OnTriggerEnter(Collider other)
    {
        if (!active)
        {
            return;
        }

        if (other.gameObject.CompareTag("Player"))
        {
            enterEvent?.Invoke();
            pm.canMove = false;
            aic.ExternalSetDestination(wendigoViewPos.position);
        }
    }
}