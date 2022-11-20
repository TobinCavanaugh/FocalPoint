using System;
using System.Collections;
using System.Collections.Generic;
using Unity.VisualScripting;
using UnityEngine;
using UnityEngine.AI;
using Random = UnityEngine.Random;

namespace DefaultNamespace
{
    public class AIController : MonoBehaviour
    {
        public NavMeshAgent agent;
        public Transform playerTransform;

        public Animator animator;

        public List<Transform> patrolPositions;

        public float viewRange = 25f;

        private Vector3 oldSeenPosition;

        public string roarAnimation;

        public Rigidbody rb;

        public float attackRange = 2f;
        
        private void Start()
        {
            oldSeenPosition = patrolPositions[Random.Range(0, patrolPositions.Count - 1)].position;
            StartCoroutine(AIUpdate());
        }

        private WaitForSeconds wfs = new WaitForSeconds(.1f);
        private static readonly int Speed = Animator.StringToHash("Speed");

        private IEnumerator AIUpdate()
        {
            Physics.Linecast(transform.position, playerTransform.position, out var hit);

            if (hit.transform.TryGetComponent(out PlayerMovement pm) && Vector3.Distance(transform.position, playerTransform.position) <= viewRange)
            {
                oldSeenPosition = playerTransform.position;
                Debug.Log("Seen player");
                
                for (int i = 0; i < 100; i++)
                {
                    Debug.Log($"thing{i}");
                    oldSeenPosition = playerTransform.position;
                    agent.SetDestination(oldSeenPosition);
                    yield return new WaitForSeconds(.2f);
                }
                goto AfterChecks;
            }

            //Checked old seen position
            if (Vector3.Distance(oldSeenPosition, transform.position) <= 2f)
            {
                // Ran into Player
                if (Vector3.Distance(transform.position, playerTransform.position) <= 2f)
                {
                    oldSeenPosition = playerTransform.position;
                    Debug.Log("Kill player");


                }
                else
                {
                    animator.Play(roarAnimation);
                    agent.isStopped = true;
                    yield return new WaitForSeconds(Random.Range(5, 7));
                    oldSeenPosition = patrolPositions[Random.Range(0, patrolPositions.Count - 1)].position;
                }
            }

            AfterChecks:
            
            agent.isStopped = false;
            agent.SetDestination(oldSeenPosition);

            animator.SetFloat(Speed, agent.velocity.magnitude);
            
            yield return wfs;
            
            StartCoroutine(AIUpdate());
        }
    }
}