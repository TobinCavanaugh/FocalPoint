using System.Collections;
using System.Collections.Generic;
using Sirenix.OdinInspector;
using UnityEngine;
using UnityEngine.AI;

namespace Game
{
    public class AIController : MonoBehaviour
    {
        #region Navigation

        private const string NAVIGATION = "Navigation";
        
        [FoldoutGroup(NAVIGATION)]
        public NavMeshAgent agent;
        
        [FoldoutGroup(NAVIGATION)]
        public Transform playerTransform;
        
        [SerializeField,FoldoutGroup(NAVIGATION)]
        private float maxChaseTime = 5f;
        
        [FoldoutGroup(NAVIGATION)]
        public List<Transform> patrolPositions;

        [FoldoutGroup(NAVIGATION), SerializeField] 
        private Transform elevatorRoom;

        #endregion

        #region Animation

        private const string ANIMATION = "Animation";
        
        [FoldoutGroup(ANIMATION)]
        public Animator animator;
        
        [FoldoutGroup(ANIMATION)]
        public string roarAnimation;

        #endregion
        
        #region Speed

        private const string SPEEDS = "Speeds";
        
        [FoldoutGroup(SPEEDS)]
        public float defaultSpeed = 3.5f;
        
        [FoldoutGroup(SPEEDS)]
        public float chaseSpeed = 5f;
        
        [SerializeField, ReadOnly, FoldoutGroup(SPEEDS)]
        public float velocity;
        
        #endregion

        public AudioSource playerHeartbeat;

        private bool _chasing = false;
        private Vector3 _previousPos;

        
        private void Start()
        {
            StartCoroutine(AIUpdate());
        }

        private void FixedUpdate()
        {
            velocity = Mathf.Lerp(velocity, Vector3.Distance(transform.position, _previousPos) * 33f, Time.fixedDeltaTime);
            _previousPos = transform.position;
            animator.SetFloat(SpeedProperty, velocity);
        }

        private const float UPDATE_TIME = .1f;
        private WaitForSeconds wfs = new (UPDATE_TIME);
        private static readonly int SpeedProperty = Animator.StringToHash("Speed");

        [SerializeField, ReadOnly]
        private float chaseTime = 0;

        [HideInInspector]
        public bool hasSightOnPlayer;
        
        private IEnumerator AIUpdate()
        {
            hasSightOnPlayer = SightLineOnPlayer();

            if (_chasing)
            {
                playerHeartbeat.volume = Mathf.Lerp(playerHeartbeat.volume, 1, Time.deltaTime);
                
                agent.speed = chaseSpeed;
                agent.SetDestination(playerTransform.position);
                chaseTime += UPDATE_TIME;

                //Reset chase if we see player gain
                if (hasSightOnPlayer)
                {
                    chaseTime = 0;
                }

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
                playerHeartbeat.volume = Mathf.Lerp(playerHeartbeat.volume, 0, Time.deltaTime);

                agent.speed = defaultSpeed;
                
                //Initiate chase if we have sight
                if (hasSightOnPlayer)
                {
                    InitiateChase();   
                }
                //Otherwise do patrol stuff
                else
                {
                    //If near to the destination
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

        /// <summary>
        /// Returns a random patrol point from the list
        /// </summary>
        /// <returns></returns>
        private Vector3 GetRandomPatrolPoint()
        {
            return patrolPositions[Random.Range(0, patrolPositions.Count)].position;
        }

        /// <summary>
        /// Can the AI see the player?
        /// </summary>
        /// <returns></returns>
        private bool SightLineOnPlayer()
        {
            Physics.Linecast(transform.position, playerTransform.position, out var hit);
            if(hit.transform.TryGetComponent(out PlayerMovement pm))
            {
                return true;
            }

            return false;
        }


        /// <summary>
        /// Starts the chase
        /// </summary>
        private void InitiateChase()
        {
            _chasing = true;
            ExternalSetDestination(playerTransform.position);
        }
        
        /// <summary>
        /// Ends the chase
        /// </summary>
        private void EndChase()
        {
            _chasing = false;
        }

        /// <summary>
        /// Set the destination, includes a scream to alert the player
        /// </summary>
        /// <param name="pos"></param>
        public void ExternalSetDestination(Vector3 pos)
        {
            Scream();
            agent.SetDestination(pos);
        }

        public void SetDestinationToElevatorRoom()
        {
            ExternalSetDestination(elevatorRoom.position);
        }
        
        /// <summary>
        ///Plays the scream animation and stops the AI
        /// </summary>
        private void Scream()
        {
            agent.isStopped = true;
            animator.CrossFade(roarAnimation, .2f);
            Invoke(nameof(ResetFromScream), 5.2f);
        }

        /// <summary>
        /// Resumes the AI from being stopped
        /// </summary>
        private void ResetFromScream()
        {
            agent.isStopped = false;
        }
    }
}