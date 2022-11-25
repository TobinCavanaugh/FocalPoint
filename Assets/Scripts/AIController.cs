using System;
using System.Collections;
using System.Collections.Generic;
using Sirenix.OdinInspector;
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

        private Vector3 previousPos;

        public float defaultSpeed = 3.5f;
        public float chaseSpeed = 5f;
        
        [ReadOnly]
        public float velocity;

        private bool chasing = false;


        public float maxChaseTime = 12f;
        private void Start()
        {
            oldSeenPosition = patrolPositions[Random.Range(0, patrolPositions.Count - 1)].position;
            StartCoroutine(AIUpdate());
        }

        private void FixedUpdate()
        {
            velocity = Mathf.Lerp(velocity, Vector3.Distance(transform.position, previousPos) * 33f, Time.fixedDeltaTime);
            previousPos = transform.position;
            animator.SetFloat(Speed, velocity);
        }

        private const float UPDATE_TIME = .1f;
        private WaitForSeconds wfs = new WaitForSeconds(UPDATE_TIME);
        private static readonly int Speed = Animator.StringToHash("Speed");

        [SerializeField, ReadOnly]
        private float chaseTime = 0;

        private IEnumerator AIUpdate()
        {
            bool hasSightOnPlayer = SightlineOnPlayer();

            if (chasing)
            {
                agent.speed = chaseSpeed;
                agent.SetDestination(playerTransform.position);
                chaseTime += UPDATE_TIME;
                
                //If max chase time has been exceeded
                if (chaseTime >= maxChaseTime)
                {
                    //If we lost sight of player, the chase is done
                    if(!hasSightOnPlayer)
                    {
                        EndChase();
                    }

                    //Reset value either way
                    chaseTime = 0;
                }
            }
            else
            {
                agent.speed = defaultSpeed;
                //Initiate chase if we have sight
                if (hasSightOnPlayer)
                {
                    InitiateChase();   
                }
                //Otherwise do patrol stuff
                else
                {
                    if (Vector3.Distance(transform.position, agent.destination) <= 2f)
                    {
                        Scream();
                        agent.SetDestination(GetRandomPatrolPoint());
                    }
                }
            }

            yield return wfs;
            
            StartCoroutine(AIUpdate());
        }

        private Vector3 GetRandomPatrolPoint()
        {
            return patrolPositions[Random.Range(0, patrolPositions.Count)].position;
        }

        private bool SightlineOnPlayer()
        {
            Physics.Linecast(transform.position, playerTransform.position, out var hit);
            if(hit.transform.TryGetComponent(out PlayerMovement pm))
            {
                return true;
            }

            return false;
        }

        private void EndChase()
        {
            chasing = false;
        }

        private void InitiateChase()
        {
            chasing = true;
            SetDestination(playerTransform.position);
        }

        public void SetDestination(Vector3 pos)
        {
            Scream();
            agent.SetDestination(pos);
        }

        private void Scream()
        {
            agent.isStopped = true;
            animator.Play(roarAnimation);
            Invoke(nameof(ResetFromScream), 5.2f);
            
        }

        private void ResetFromScream()
        {
            agent.isStopped = false;
        }
    }
}