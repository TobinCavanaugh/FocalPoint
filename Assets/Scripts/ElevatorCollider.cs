using System;
using System.Collections;
using System.Collections.Generic;
using DefaultNamespace;
using UnityEngine;

public class ElevatorCollider : MonoBehaviour
{
    public Animator animator;
    public string elevatorMove;
    public PlayerMovement pm;
    public AIController aic;
    public Transform wendigoViewPos;
    public GameObject wendigoJumpcareCollider;

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
            pm.canMove = false;
            aic.SetDestination(wendigoViewPos.position);
            wendigoJumpcareCollider.SetActive(false);
            animator.Play(elevatorMove);
        }
    }
}
